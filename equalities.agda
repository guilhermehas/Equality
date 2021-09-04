{-# OPTIONS --cubical --type-in-type #-}

module equalities where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Isomorphism
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Univalence
open import Agda.Primitive
open import Cubical.Data.Equality

module _ {a ℓ} {A : Set a} where
  ≣-Type = A → A → Set ℓ

  record IsEquality (≣ : ≣-Type) : Set (ℓ-suc (a ⊔ ℓ)) where
    constructor eq
    field
      ≣-≡-≡ : let ≣' : A → A → Set (a ⊔ ℓ)
                  ≣' = ≣
               in ≣' ≡ _≡_


  record Equality : Set (ℓ-suc (a ⊔ ℓ)) where
    field
      _≣_ : ≣-Type
      isEquality : IsEquality _≣_

module _ {a} {A : Set a} where
  instance
    ≡-IsEquality : IsEquality {A = A} _≡_
    ≡-IsEquality = eq refl

  instance
    ≡p-IsEquality : IsEquality {A = A} _≡p_
    ≡p-IsEquality = eq (sym λ i x y → p-c {_} {_} {x} {y} i)

module _ {ℓ} where
  instance
    ≃-IsEquality : IsEquality {A = Type ℓ} (λ A B → Lift (A ≃ B))
    ≃-IsEquality = eq (sym α)
      where
      α : _≡c_ ≡c (λ A B → Lift (A ≃ B))
      α i A B = univalencePath {ℓ} {A} {B} i
