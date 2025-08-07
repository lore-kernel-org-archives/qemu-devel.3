Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77A0C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzzv-0005i6-5i; Thu, 07 Aug 2025 08:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujzzr-0005gE-Hj
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 08:45:27 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujzzp-0003aN-JJ
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 08:45:27 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-af94e75445dso179319366b.0
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 05:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754570724; x=1755175524; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4mxnmdWURKrspkJkgabtVF7shbXvkNrjRY+cj6lEhk=;
 b=BuFRz10OQprOAbFbMuNLuXo/HyIslIPUTU/A4yDlVdoa0moCiSGDySdQD6zXBod+jJ
 5rWNrj+LAJvToyH4LawQ9rjxOElhRk8EaGWS7SuDMYS2UoqGcbWoU0D/YyMHksZqFdob
 Mp88+DIT4wzv0bKITXsovcZnM5R315TTzT5tJo22kLLcA0A4R9MzPVX027KQ6QTCy/1M
 f9J/BYaAgZYq9PlCANGfL4khGyWsSjn8QvMqjkGw5Go+zy89fB9jL+U+vWsVdpi5z/2L
 A8RKL1WbG33SYJn9RpW/Lf9VgullNXuQ3Zx+9xECJFuPWLnVl+pr4Te3GTWx3F3PsfGI
 mhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754570724; x=1755175524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4mxnmdWURKrspkJkgabtVF7shbXvkNrjRY+cj6lEhk=;
 b=PXmeNiv+EEnarnrzoJGRqXC/smv052Yr84nRAKfCaaoxp4ayVF4io2nHOfbvUpTdyA
 AKY2Pnf56V/5hvCn5tqPlvfIYm79r7w1qWDxd1OP/yY4cFRq8xouJbNIY8gW+/iEl88C
 sLHBM7IFEx5ZhQpM5zJ3wKCQtNVLaaJHnCCVVz564+kyZDn7sa/kddfejXiAZE58NR//
 SVmSCbvu2cRYTQ7lFQcgMK3dGhQthcG7QGteGG2iUxR5lLOHZWcS9mg6xVhlzEQLgEgJ
 zwoKZ0F12dL4idZMrBuG4YW5gnP+Jn89wTdXcM95mfnwCsFvvIAE4TPVMxSvWFmWZqna
 Q/Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZuKHBlJ1QDdXNpIhOWc5Iex4IuKNbcsl4jGfxgWqT3Kzx8DokSpZcc+kmJ5FcjZSEisQ37FJWrHbd@nongnu.org
X-Gm-Message-State: AOJu0YxmaFcDL5wIgDIWJhAqRyWEfTmhp8oq5FVvLxTMt7M7Ub7pBWwb
 LFN6km4JQ7H1U5+Eph7y5T7Uxq12z90rDKzEI3Wude+v0Ny3WGLGdJZXmkAdTa2AEG3mKb5Ncan
 JDVlR5hmdTOt55xniR7QbToL0ZmjxqmXGrBvdBWz+9w==
X-Gm-Gg: ASbGncuWcW53F2Vu5bBuQZWEdO/boRfyi48Sc/olgyFZq1239cBJjG5Lv17Ki7SBlcu
 aBQw4wcwxrc9RDwtMyOfMsk8bQrT7w0iaunpIpy/MXD4g6h5WInJWofAbvzu41kNsBV3z/Clp1W
 uxiqzlwV3t77kC+BaCs0tOTdmWjpr88LswJ3ScMq6kTFcicWE0c4VdMWpZhHeG4R1+yPiZ3J5kR
 nqQGjtd
X-Google-Smtp-Source: AGHT+IHRq/HhoBkia7VvEENszVQ+ymQvQSWJdZDLzKe2FOBBDEwXybC8DQDXCiIGAI9cwJmHl8R9bmbnP6ib/m5Ebm0=
X-Received: by 2002:a17:906:c10b:b0:af9:3116:e0f6 with SMTP id
 a640c23a62f3a-af9904baf22mr672198666b.53.1754570723408; Thu, 07 Aug 2025
 05:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-26-zhao1.liu@intel.com>
In-Reply-To: <20250807123027.2910950-26-zhao1.liu@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 7 Aug 2025 15:44:57 +0300
X-Gm-Features: Ac12FXxMhbtJ6yZr4cYSYbkHseHf6_3gREmBqkNcXXr1xmu1weK83lwusimXAnY
Message-ID: <CAAjaMXa3SK2Zh06jiMsONh73zpKLCGTaG7oK=4uoqHYkja=X7g@mail.gmail.com>
Subject: Re: [RFC 25/26] rust/memory: Add binding to check target endian
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel@nongnu.org, 
 qemu-rust@nongnu.org, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 7, 2025 at 3:10=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrote=
:
>
> Add a binding (target_is_big_endian()) to check whether target is big
> endian or not. This could help user to adjust endian before calling

s/adjust endian/adjust endianness/

> AddresssSpace::store() or after calling AddressSpace::load().

No strong preference, but maybe we can keep the same name as C,
target_big_endian()? Just for consistency.

Either way:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>
> Add the example in the documentation of AddresssSpace::store() to help
> explain how to use it.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  rust/qemu-api/src/memory.rs | 28 +++++++++++++++++++++++++---
>  rust/qemu-api/wrapper.h     |  1 +
>  2 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
> index 42bba23cf3f8..a8eb83c95ead 100644
> --- a/rust/qemu-api/src/memory.rs
> +++ b/rust/qemu-api/src/memory.rs
> @@ -31,7 +31,7 @@
>          memory_region_init_io, section_access_allowed, section_covers_re=
gion_addr,
>          section_fuzz_dma_read, section_get_host_addr, section_rust_load,
>          section_rust_read_continue_step, section_rust_store, section_rus=
t_write_continue_step,
> -        MEMTX_OK,
> +        target_big_endian, MEMTX_OK,
>      },
>      callbacks::FnCall,
>      cell::Opaque,
> @@ -1107,9 +1107,25 @@ pub fn read(&self, buf: &mut [u8], addr: GuestAddr=
ess) -> Result<usize> {
>      /// This function is similar to `address_space_st{size}` in C side.
>      ///
>      /// But it only assumes @val follows target-endian by default. So en=
sure
> -    /// the endian of `val` aligned with target, before using this metho=
d.
> +    /// the endian of `val` aligned with target, before using this metho=
d.  The
> +    /// taget-endian can be checked with [`target_is_big_endian`].
>      ///
>      /// And it assumes the memory attributes is MEMTXATTRS_UNSPECIFIED.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use qemu_api::memory::{ADDRESS_SPACE_MEMORY, target_is_big_endia=
n};
> +    ///
> +    /// let addr =3D GuestAddress(0x123438000);
> +    /// let val: u32 =3D 5;
> +    /// let val_end =3D if target_is_big_endian() {
> +    ///     val.to_be()
> +    /// } else {
> +    ///     val.to_le()
> +    /// }
> +    ///
> +    /// assert!(ADDRESS_SPACE_MEMORY.store(addr, val_end).is_ok());
>      pub fn store<T: AtomicAccess>(&self, addr: GuestAddress, val: T) -> =
Result<()> {
>          rcu_read_lock();
>          let r =3D self.memory().deref().store(val, addr, Ordering::Relax=
ed);
> @@ -1122,7 +1138,8 @@ pub fn store<T: AtomicAccess>(&self, addr: GuestAdd=
ress, val: T) -> Result<()> {
>      /// This function is similar to `address_space_ld{size}` in C side.
>      ///
>      /// But it only support target-endian by default.  The returned valu=
e is
> -    /// with target-endian.
> +    /// with target-endian.  The taget-endian can be checked with
> +    /// [`target_is_big_endian`].
>      ///
>      /// And it assumes the memory attributes is MEMTXATTRS_UNSPECIFIED.
>      pub fn load<T: AtomicAccess>(&self, addr: GuestAddress) -> Result<T>=
 {
> @@ -1147,3 +1164,8 @@ pub fn load<T: AtomicAccess>(&self, addr: GuestAddr=
ess) -> Result<T> {
>      // the whole QEMU life.
>      &*wrapper_ptr
>  };
> +
> +pub fn target_is_big_endian() -> bool {
> +    // SAFETY: the return value is boolean, so it is always valid.
> +    unsafe { target_big_endian() }
> +}
> diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
> index ce0ac8d3f550..c466b93054aa 100644
> --- a/rust/qemu-api/wrapper.h
> +++ b/rust/qemu-api/wrapper.h
> @@ -70,3 +70,4 @@ typedef enum memory_order {
>  #include "system/address-spaces.h"
>  #include "hw/char/pl011.h"
>  #include "qemu/rcu.h"
> +#include "qemu/target-info.h"
> --
> 2.34.1
>

