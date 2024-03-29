{-# OPTIONS --cubical --cumulativity #-}

module leibniz-equality where

open import Cubical.Foundations.Isomorphism
open import Cubical.Foundations.Function
open import Cubical.Data.Equality

open import equalities
open import leibniz
open Leibniz

liftIso : ∀ {a b} {A : Type a} {B : Type b} → Iso {a} {b} A B → Iso {ℓ-max a b} {ℓ-max a b} A B
liftIso {a} f = iso fun inv (λ x i → rightInv x i) (λ x i → leftInv x i)
  where open Iso f

module FinalEquality {A : Set} where
  open MainResult A

  ≐≅≡ : ∀ {a b} → Iso (a ≐ b) (a ≡p b)
  ≐≅≡ = iso j i (ptoc ∘ ji) (ptoc ∘ ij)

  ≐≡≡' : ∀ {a b} → (a ≐ b) ≡c (a ≡p b)
  ≐≡≡' = let lifted = liftIso ≐≅≡  in isoToPath lifted

  ≐≡≡ : _≐_ {A} ≡c _≡p_
  ≐≡≡ i x y = ≐≡≡' {x} {y} i

  open IsEquality
  open equalities

  instance
    ≐-IsEquality : IsEquality {A = A} _≐_
    ≐-IsEquality = eq λ {x} {y} → ≐≡≡' ∙ λ i → ≡p-IsEquality {ℓ-zero} .≣-≡-≡ {x} {y} i
