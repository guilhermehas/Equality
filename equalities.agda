{-# OPTIONS --cubical #-}

module equalities where

open import Cubical.Foundations.Prelude
open import Agda.Primitive
open import Cubical.Data.Equality

≣-Type = λ {ℓ} → {A : Set ℓ} → A → A → Set ℓ

module _ {ℓ} where
  record IsEquality (≣ : ≣-Type {ℓ}) : Set (ℓ-suc ℓ)  where
    constructor eq
    field
      ≣-≡-≡ : {A : Set ℓ} → (≣ {A}) ≡ _≡_

  record Equality : Set (ℓ-suc ℓ) where
    field
      _≣_ : ≣-Type {ℓ}
      isEquality : IsEquality _≡_

  instance
    ≡-IsEquality : IsEquality _≡_
    ≡-IsEquality = eq refl

  instance
    ≡p-IsEquality : IsEquality _≡p_
    ≡p-IsEquality = eq (sym λ i x y → p-c {_} {_} {x} {y} i)
