{-# OPTIONS --cubical --type-in-type #-}

module equalities where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Isomorphism
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Univalence
open import Agda.Primitive
open import Cubical.Data.Equality

module _ {ℓ} {A : Set ℓ} where
  ≣-Type = A → A → Set ℓ

  record IsEquality (≣ : ≣-Type) : Set (ℓ-suc ℓ)  where
    constructor eq
    field
      ≣-≡-≡ : ≣ ≡ _≡_

  record Equality : Set (ℓ-suc ℓ) where
    field
      _≣_ : ≣-Type
      isEquality : IsEquality _≡_

  instance
    ≡-IsEquality : IsEquality _≡_
    ≡-IsEquality = eq refl

  instance
    ≡p-IsEquality : IsEquality _≡p_
    ≡p-IsEquality = eq (sym λ i x y → p-c {_} {_} {x} {y} i)

module _ {ℓ} where
  instance
    ≃-IsEquality : IsEquality {ℓ} (λ A B → Lift (A ≃ B))
    ≃-IsEquality = eq (sym λ i A B → univalencePath {ℓ} {A} {B} i)
