Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE751CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKsur-0007IC-WF; Thu, 07 May 2026 03:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wKsup-0007Gs-Oy
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:12:59 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wKsun-0001dV-GL
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:12:59 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so388139f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 00:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778137976; cv=none;
 d=google.com; s=arc-20240605;
 b=ZRqNwdJb/7kdEX99z0pcrVH0rl0E3h/TPoTEl3+VCKvu76PuRrL7qyoSNcFOsi9a/E
 l5JUKCpUxeLNX6ioM5150gE3jp+9j91uoj1ObeJoEj1l22N00t4IaByVgMslPiojjdrc
 WkO2bLNy22dJzWpZ1/22KZU+YIRorL35RRQb+Gespj9JmnOomvM8QlVYmBZBNOCztAPG
 Ed/Q3rT8DSZiIoVgdLhzEfpbnBl6vpfSkbT/XRnMMOuW25UcQbD54njDbrEBztO3i6rA
 p+ZQTc4DMlkkV58mfOYPdaF2K5TzX0uQnW0FlOlH+3CkRICuVyHj1n32bt/9MZH8NmYn
 yeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jlQXBkufNCNcZlou47vR9Rc0Rbfyjwxb/Z/znMGd+pE=;
 fh=HdjMIMmzyss7cK7kg9FOKJv5Tx2R5fhs9Ucbm+bWmOc=;
 b=jBN6Q2HBlnZsuAK1kNimF5WZKUrgLMGWdl7XUqW+OhAZdMxs+8hY70rZ664pZMGaW1
 UnsWZ/Yc2Gyzs+CVHeKa9dCBKHSKEi/B1XIhGtEYybTr7Hnl26B8hrPKcZPV7VKdzJUK
 yNahfRwxJwWE+kNCDesEdhxjbKSv3Gpm7EKpxuNekGqujI3rUFnuvZCKkaEMJ7/+O7qE
 JUh7DPDGWU+mZQjeJVBG2GvxeZAdXSwQ47cowZNxGwQRMGLjozj+s7GrlXBQ+CjmG3Qm
 2bEiSPAaVgceJZOaGizYrJoE743/7VkkcEv0jtaAG5C30ublsO5pTI/U+lp/MYRJOWYt
 f9vA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778137976; x=1778742776; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlQXBkufNCNcZlou47vR9Rc0Rbfyjwxb/Z/znMGd+pE=;
 b=sKkFAbhb+2RTObbavXd1a7t03OSDji5UDLsh9QeZ5ZPf/+E3mVg6lXtJWZ54lveIUI
 Yz/sYAYVrMwOvDRo7Uu0aCz3LKh1LHIiyp/qO7rdMjV5o+RWlocAzhgGcQ8IfNOEjHhn
 leQ7HwbdkCR7lbFBHOPsJHhT4rKYhU7nasMknhb0jDQQlsVgWCw+3VSzh2dGsZDXfEum
 2p8awS2A1BKM0uGjyY9aLsRhdvP4XXXBMTlTMBBgyKoEHDei8rV78xW2N3f6ZO5XMTrD
 yM2aqW3HBIRNbrhg7z1xTqbudPMKPIRztYlrk2XAzyNSvoIo3ZxY18h0/rfHwIN5QxV6
 Ra+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778137976; x=1778742776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jlQXBkufNCNcZlou47vR9Rc0Rbfyjwxb/Z/znMGd+pE=;
 b=e6AkOvP8Dv/orw+7oQ5CjmG6ji/vwHtGrpT+OOFVQ7xutJSKYgXsGA1pGW+9vkI3ZS
 oW1rXqLds0kPOYHSCknrElXsv/1o/gTgDQPo0mGcmnAt2prC91oFykS0n/J9T5rkGIMa
 CSTue5DVsCJsW5sOSbzrJtZC42HFd7bc9ViDcWchVZ/JP9As/J7wmXmLPS1PV2SpXvuz
 TbR586QrtYWSeyaxSvdOtVRQy29w80Ge1uXbVuAKNfxcxilOvvtNg49YrE/B6kulWg/C
 AnvK0gcu/fwEkNEUTaplzFRlpl1oBbE7bD3shej75CS2vN4C0K/4xnaUqa7J35IfZJof
 GMsw==
X-Gm-Message-State: AOJu0YxBZuI628WSaqVrUF3YI8av1sL9LXfrB8qpbrIfBMR1cI5GkDsI
 2SDWu8reslKOJhBkILbS0v8OlYxfX4wD8rTxVeu3qTEWz3RieM/X8fU2ukJP32MC/u+XrXMtMbF
 rDowJJ5623OIW3u6rglVYct6KjzJBrLWI7+qke1nKmQ==
X-Gm-Gg: AeBDietTnu1DiheBnbDQ69CaH8Zc6v65L114IeigxllnoS7PcoFDqlNUnDbNy7unsB/
 HgW95DFbefvw53qwacsCKR8jN7k1V0IrSCfrvWJGs9ESGX7pwBtHoU2OXsQ1AJOJz1BDUFbVBls
 OVVRCC0qjX86QqEvQTVyGtrrd7yjyJmq9hyD7qwGMXCkf1kj3P8x5JZVIWHo1BbiRuoZ4zRyIPS
 IvgvuwN+j2bLGh+VgEs0EdBZ5lF8UvZXZAXxH36N5eaRSpnFi+MtLuZ0RhrFOev4w7/dJvgtBUF
 ZhMUyqiLGkbgAFEy+zIVQKIFg48hDjvm8AuePe9+Lv/Nn8xIzPreHaZinuLT
X-Received: by 2002:a5d:5d08:0:b0:44e:1984:5f3e with SMTP id
 ffacd0b85a97d-4515d3dc343mr10306596f8f.31.1778137975102; Thu, 07 May 2026
 00:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260507070228.48877-1-philmd@linaro.org>
In-Reply-To: <20260507070228.48877-1-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 7 May 2026 10:12:28 +0300
X-Gm-Features: AVHnY4K5eZwztxAtNrkwNPRb7kYoRAEYnHYWFrxFvhvucdBeCe8_4KLjCgmWTOE
Message-ID: <CAAjaMXY579MY9P9805x8THF2UiDTben_ZHbFOFLz6JkjJ_OyuA@mail.gmail.com>
Subject: Re: [PATCH] migration: Remove VMS_MULTIPLY_ELEMENTS and
 VMSTATE_VARRAY_MULTIPLY()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 qemu-rust@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 7, 2026 at 10:02=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Commit c1eb3ac3468 ("target/sparc: Replace
> VMSTATE_VARRAY_MULTIPLY -> VMSTATE_UINTTL_ARRAY") removed the
> last use of the VMSTATE_VARRAY_MULTIPLY() macro. We can now
> remove it as unnecessary, along with the VMS_MULTIPLY_ELEMENTS
> flag and the associated tests.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/migration/vmstate.h        | 22 ++----------
>  migration/vmstate.c                |  4 ---
>  rust/bindings/migration-sys/lib.rs |  8 -----
>  rust/migration/src/vmstate.rs      |  3 +-
>  rust/tests/tests/vmstate_tests.rs  | 55 ------------------------------
>  5 files changed, 4 insertions(+), 88 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 28e3640e60c..0a8a2e85a63 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -105,7 +105,7 @@ enum VMStateFlags {
>      VMS_ARRAY_OF_POINTER =3D 0x040,
>
>      /* The field is an array of variable size. The uint16_t at opaque
> -     * + VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
> +     * + VMStateField.num_offset
>       * contains the number of entries in the array. See the VMS_ARRAY
>       * description regarding array handling in general. May not be
>       * combined with VMS_ARRAY or any other VMS_VARRAY*. */
> @@ -126,14 +126,14 @@ enum VMStateFlags {
>      VMS_MULTIPLY         =3D 0x200,
>
>      /* The field is an array of variable size. The uint8_t at opaque +
> -     * VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
> +     * VMStateField.num_offset
>       * contains the number of entries in the array. See the VMS_ARRAY
>       * description regarding array handling in general. May not be
>       * combined with VMS_ARRAY or any other VMS_VARRAY*. */
>      VMS_VARRAY_UINT8     =3D 0x400,
>
>      /* The field is an array of variable size. The uint32_t at opaque
> -     * + VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
> +     * + VMStateField.num_offset
>       * contains the number of entries in the array. See the VMS_ARRAY
>       * description regarding array handling in general. May not be
>       * combined with VMS_ARRAY or any other VMS_VARRAY*. */
> @@ -150,12 +150,6 @@ enum VMStateFlags {
>       * cause the individual entries to be allocated. */
>      VMS_ALLOC            =3D 0x2000,
>
> -    /* Multiply the number of entries given by the integer at opaque +
> -     * VMStateField.num_offset (see VMS_VARRAY*) with VMStateField.num
> -     * to determine the number of entries in the array. Only valid in
> -     * combination with one of VMS_VARRAY*. */
> -    VMS_MULTIPLY_ELEMENTS =3D 0x4000,
> -
>      /* A structure field that is like VMS_STRUCT, but uses
>       * VMStateField.struct_version_id to tell which version of the
>       * structure we are referencing to use. */
> @@ -446,16 +440,6 @@ extern const VMStateInfo vmstate_info_qlist;
>      .offset     =3D vmstate_offset_2darray(_state, _field, _type, _n1, _=
n2),  \
>  }
>
> -#define VMSTATE_VARRAY_MULTIPLY(_field, _state, _field_num, _multiply, _=
info, _type) { \
> -    .name       =3D (stringify(_field)),                               \
> -    .num_offset =3D vmstate_offset_value(_state, _field_num, uint32_t),\
> -    .num        =3D (_multiply),                                       \
> -    .info       =3D &(_info),                                          \
> -    .size       =3D sizeof(_type),                                     \
> -    .flags      =3D VMS_VARRAY_UINT32|VMS_MULTIPLY_ELEMENTS,           \
> -    .offset     =3D vmstate_offset_varray(_state, _field, _type),      \
> -}
> -
>  #define VMSTATE_SUB_ARRAY(_field, _state, _start, _num, _version, _info,=
 _type) { \
>      .name       =3D (stringify(_field)),                               \
>      .version_id =3D (_version),                                        \
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 2f13b48a37f..6fa7523f04d 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -100,10 +100,6 @@ static int vmstate_n_elems(void *opaque, const VMSta=
teField *field)
>          n_elems =3D *(uint8_t *)(opaque + field->num_offset);
>      }
>
> -    if (field->flags & VMS_MULTIPLY_ELEMENTS) {
> -        n_elems *=3D field->num;
> -    }
> -
>      trace_vmstate_n_elems(field->name, n_elems);
>      return n_elems;
>  }
> diff --git a/rust/bindings/migration-sys/lib.rs b/rust/bindings/migration=
-sys/lib.rs
> index 7ee30a3f7d5..9581481e421 100644
> --- a/rust/bindings/migration-sys/lib.rs
> +++ b/rust/bindings/migration-sys/lib.rs
> @@ -114,12 +114,4 @@ pub const fn with_varray_flag(mut self, flag: VMStat=
eFlags) -> Self {
>          assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) !=3D 0);
>          self.with_varray_flag_unchecked(flag)
>      }
> -
> -    #[must_use]
> -    pub const fn with_varray_multiply(mut self, num: u32) -> Self {
> -        assert!(num <=3D 0x7FFF_FFFFu32);
> -        self.flags =3D VMStateFlags(self.flags.0 | VMStateFlags::VMS_MUL=
TIPLY_ELEMENTS.0);
> -        self.num =3D num as i32;
> -        self
> -    }
>  }
> diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.r=
s
> index f34a36f6809..63d78b4f275 100644
> --- a/rust/migration/src/vmstate.rs
> +++ b/rust/migration/src/vmstate.rs
> @@ -159,8 +159,7 @@ macro_rules! vmstate_of {
>              )$(.with_varray_flag($crate::call_func_with_field!(
>                      $crate::vmstate::vmstate_varray_flag,
>                      $struct_name,
> -                    $($num).+))
> -               $(.with_varray_multiply($factor))?)?
> +                    $($num).+)))?
>          }
>      };
>  }
> diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate=
_tests.rs
> index 87176a80990..c2c12cfab52 100644
> --- a/rust/tests/tests/vmstate_tests.rs
> +++ b/rust/tests/tests/vmstate_tests.rs
> @@ -118,34 +118,6 @@ fn test_vmstate_varray_uint16_unsafe() {
>      assert!(foo_fields[2].field_exists.is_none());
>  }
>
> -#[test]
> -fn test_vmstate_varray_multiply() {
> -    let foo_fields: &[VMStateField] =3D
> -        unsafe { slice::from_raw_parts(VMSTATE_FOOA.as_ref().fields, 5) =
};
> -
> -    // 4th VMStateField ("arr_mul") in VMSTATE_FOOA (corresponding to
> -    // VMSTATE_VARRAY_MULTIPLY)
> -    assert_eq!(
> -        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(=
),
> -        b"arr_mul\0"
> -    );
> -    assert_eq!(foo_fields[3].offset, 6);
> -    assert_eq!(foo_fields[3].num_offset, 12);
> -    assert_eq!(foo_fields[3].info, unsafe { &vmstate_info_int8 });
> -    assert_eq!(foo_fields[3].version_id, 0);
> -    assert_eq!(foo_fields[3].size, 1);
> -    assert_eq!(foo_fields[3].num, 16);
> -    assert_eq!(
> -        foo_fields[3].flags.0,
> -        VMStateFlags::VMS_VARRAY_UINT32.0 | VMStateFlags::VMS_MULTIPLY_E=
LEMENTS.0
> -    );
> -    assert!(foo_fields[3].vmsd.is_null());
> -    assert!(foo_fields[3].field_exists.is_none());
> -
> -    // The last VMStateField in VMSTATE_FOOA.
> -    assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
> -}
> -
>  // =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D Test VMSTATE_FOOB =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  // Test the use cases of the vmstate macro, corresponding to the followi=
ng C
>  // macro variants:
> @@ -256,33 +228,6 @@ fn test_vmstate_struct_varray_uint8() {
>      assert!(foo_fields[2].field_exists.is_none());
>  }
>
> -#[test]
> -fn test_vmstate_struct_varray_uint32_multiply() {
> -    let foo_fields: &[VMStateField] =3D
> -        unsafe { slice::from_raw_parts(VMSTATE_FOOB.as_ref().fields, 7) =
};
> -
> -    // 4th VMStateField ("arr_a_mul") in VMSTATE_FOOB (corresponding to
> -    // (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32)
> -    assert_eq!(
> -        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(=
),
> -        b"arr_a_mul\0"
> -    );
> -    assert_eq!(foo_fields[3].offset, 64);
> -    assert_eq!(foo_fields[3].num_offset, 124);
> -    assert!(foo_fields[3].info.is_null()); // VMSTATE_STRUCT_VARRAY_UINT=
8 doesn't set info field.
> -    assert_eq!(foo_fields[3].version_id, 2);
> -    assert_eq!(foo_fields[3].size, 20);
> -    assert_eq!(foo_fields[3].num, 32);
> -    assert_eq!(
> -        foo_fields[3].flags.0,
> -        VMStateFlags::VMS_STRUCT.0
> -            | VMStateFlags::VMS_VARRAY_UINT32.0
> -            | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0
> -    );
> -    assert_eq!(foo_fields[3].vmsd, VMSTATE_FOOA.as_ref());
> -    assert!(foo_fields[3].field_exists.is_none());
> -}
> -
>  #[test]
>  fn test_vmstate_macro_array() {
>      let foo_fields: &[VMStateField] =3D
> --
> 2.53.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Acked-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

