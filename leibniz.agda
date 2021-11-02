{-# OPTIONS --cubical #-}
module leibniz where

open import Cubical.Data.Equality
open import Cubical.Foundations.Function using (_∘_)

module Martin-Löf {ℓ} {A : Set ℓ} where

  reflexive≡ : {a : A} → a ≡p a
  reflexive≡ = reflp

  symmetric≡ : {a b : A} → a ≡p b → b ≡p a
  symmetric≡ reflp = reflp

  transitive≡ : {a b c : A} → a ≡p b → b ≡p c → a ≡p c
  transitive≡ reflp reflp = reflp

open Martin-Löf public

ext : ∀ {ℓ ℓ′} {A : Set ℓ} {B : A → Set ℓ′} {f g : (a : A) → B a} →
            (∀ (a : A) → f a ≡p g a) → f ≡p g
ext p = ctop (funExt (ptoc ∘ p))

module Leibniz {A : Set} where

  _≐_ : (a b : A) → Set₁
  a ≐ b = (P : A → Set) → P a → P b

  reflexive≐ : {a : A} → a ≐ a
  reflexive≐ P Pa = Pa

  transitive≐ : {a b c : A} → a ≐ b → b ≐ c → a ≐ c
  transitive≐ a≐b b≐c P Pa = b≐c P (a≐b P Pa)

  symmetric≐ : {a b : A} → a ≐ b → b ≐ a
  symmetric≐ {a} {b} a≐b P = Qb
    where
      Q : A → Set
      Q c = P c → P a
      Qa : Q a
      Qa = reflexive≐ P
      Qb : Q b
      Qb = a≐b Q Qa

open Leibniz

T : Set → Set₁
T A = ∀ (X : Set) → (A → X) → X



module WarmUp (A : Set) where

  postulate
    paramT : (t : T A) → (X X′ : Set) (R : X → X′ → Set) →
             (k : A → X) (k′ : A → X′) (kR : (a : A) → R (k a) (k′ a)) →
             R (t X k) (t X′ k′)

  i : A → T A
  i a X k = k a

  id : A → A
  id a = a

  j : T A → A
  j t = t A id

  ji : (a : A) → (j (i a) ≡p a)
  ji a = reflp

  ijₑₓₜ : (t : T A) (X : Set) (k : A → X) → (i (j t) X k ≡p t X k)
  ijₑₓₜ t X k = paramT t A X R id k (λ a → reflp)
    where
      R : A → X → Set
      R a x = k a ≡p x

  ij : (t : T A) → (i (j t) ≡p t)
  ij t = ext (λ X → ext (λ k → ijₑₓₜ t X k))



module MainResult (A : Set) where

  postulate
    param≐ : {a b : A} (a≐b : a ≐ b) →
             (P P′ : A → Set) → (R : (c : A) → P c → P′ c → Set) →
                (Pa : P a) (P′a : P′ a) → R a Pa P′a →
                    R b (a≐b P Pa) (a≐b P′ P′a)

  i : {a b : A} (a≡b : a ≡p b) → a ≐ b
  i reflp P Pa = Pa

  j : {a b : A} → a ≐ b → a ≡p b
  j {a} {b} a≐b = Qb
    where
      Q : A → Set
      Q c = a ≡p c
      Qa : Q a
      Qa = reflexive≡
      Qb : Q b
      Qb = a≐b Q Qa

  ji : {a b : A} (a≡b : a ≡p b) → j (i a≡b) ≡p a≡b
  ji reflp = reflp

  ijₑₓₜ : {a b : A} (a≐b : a ≐ b) →
    (P : A → Set) (Pa : P a) → i (j a≐b) P Pa ≡p a≐b P Pa
  ijₑₓₜ {a} a≐b P Pa = param≐ a≐b Q P R reflp Pa reflp
    where
      Q : A → Set
      Q c = a ≡p c
      R : (c : A) (Qc : Q c) (Pc : P c) → Set
      R c Qc Pc = i Qc P Pa ≡p Pc
  ij : {a b : A} (a≐b : a ≐ b) → i (j a≐b) ≡p a≐b
  ij a≐b = ext (λ P → ext (ijₑₓₜ a≐b P))
