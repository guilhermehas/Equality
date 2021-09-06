{-# OPTIONS --cubical --cumulativity #-}

module equalities where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Isomorphism
open import Cubical.Foundations.Equiv
open import Cubical.Foundations.Univalence
open import Agda.Primitive
open import Cubical.Data.Equality

module _ {a ℓ} {A : Set a} where
  ≣-Type = A → A → Set ℓ

  record IsEquality (_≣_ : ≣-Type) : Set (ℓ-suc (a ⊔ ℓ)) where
    constructor eq
    field
      ≣-≡-≡ : ∀ {x y} → let
        ℓ₁ = a ⊔ ℓ

        x≡y : Type ℓ₁
        x≡y = x ≡ y

        x≣y : Type ℓ₁
        x≣y = x ≣ y

        in _≡_ {ℓ-suc ℓ₁} x≣y x≡y

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
    ≡p-IsEquality = eq (λ {x y} → sym λ i → p-c {x = x} {y = y} i)


module _ {ℓ} where
  univalencePath' : {A B : Type ℓ} → (A ≡ B) ≡ (A ≃ B)
  univalencePath' {A} {B} =
    ua {ℓ-suc ℓ} {A ≡ B} {A ≃ B} (compEquiv (univalence {ℓ} {A} {B})
    (isoToEquiv (iso {ℓ} {ℓ-suc ℓ} (λ x → x) (λ x → x) (λ b i → b) λ a i → a)))

  instance
    ≃-IsEquality : IsEquality {A = Type ℓ} (λ A B → (A ≃ B))
    ≃-IsEquality = eq λ {A B} → sym λ i → let w = univalencePath' {A = A} {B = B} i in w
