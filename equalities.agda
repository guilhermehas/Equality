{-# OPTIONS --cubical #-}

module equalities where

open import Cubical.Data.Equality

module _ {ℓ ℓ₁} {A : Set ℓ} where

  ≡-Type = ∀ (x y : A) → Set ℓ₁

  removeVars≡ : {_≡₁_ : ≡-Type} {_≡₂_ : ≡-Type}
    → (≡≡≡ : ∀ {x y : A} → (x ≡₁ y) ≡c (x ≡₂ y))
    → _≡₁_ ≡c _≡₂_
  removeVars≡ ≡≡≡ i a b = ≡≡≡ {a} {b} i
