Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2432EC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHN79-00047l-P8; Wed, 12 Jun 2024 08:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHN77-00047X-S2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHN75-00024I-UF
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718195402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AtAzsA8QZUV7/KlaD4WPdzb5edEBk3GLwFtGsb6iIb0=;
 b=D8QbEuvvgqIyZ6mjdySuTiTl09Wc9ixUPapUZZYHbn8V5ykIHtyDEiCZfHq2ItJjb8HDAb
 7TEqyVoCoYw+fKEZq4WepoNzQP7/rkgc6TXaee6Y+GN73VIgUEUKdhtuqK3MvU2dZ+CoD4
 GQjzEOMmSLqXOuZtUe4eOogOqyKw2Ho=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-98-yuRIkML6jxv-uU9Ky5A-1; Wed, 12 Jun 2024 08:29:59 -0400
X-MC-Unique: 98-yuRIkML6jxv-uU9Ky5A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-421e17ae038so23663565e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 05:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718195398; x=1718800198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AtAzsA8QZUV7/KlaD4WPdzb5edEBk3GLwFtGsb6iIb0=;
 b=GLpx/0b/RadTapnGKtrOZ8mVI8T2mZNtRTAhSMzVOxrAMo/LLfVzuRM49+HQT+gLrB
 zaXwQvnvfh+jF15aCvRS6wFyzzsbASTn2G4mA8L6Az+w4ObnQ2tJJX12lWB21BwVb5jQ
 MRuv53cFPfNgAcxDwK66Pejy3P2rpi3UdEDVt6SGF1zHraKEWGlzm/OQyOoT+Ke27CY8
 oQJ9mxLg/G1d2kkiFHY0calLLsvjAMGIxyemZpHmZkSgBx82jHeAKJrNZbaCOUc7oXWl
 zZXdKa71uMgGAND8A7BmMAdAlS6P/i2GceFBqo/n8bpY0C5KcPG8W5WLrbb4XtDwl2xf
 D/tQ==
X-Gm-Message-State: AOJu0YzBGZhGVwgX00T3eTw/VpVwxzvFpYfRZx1+7+1pUZ3ZFOg8FneH
 LOtSpUVLzq51m0nfH42dAq4SZBZ9koPcD5JpeDPpuRu3+3kLb8cWAcRdrr7QrLV/4GfkNZUsZIu
 uK2G7Ify2o9m+AzW3phDKIL9cUdA4OiFnmxg+QN7rE5F9xxI6eynh26mwumldcBfKGKPTWEBVFT
 omxMOs3HK9bit8yyq4RplRjW6XXfs=
X-Received: by 2002:a05:600c:3ba4:b0:422:5953:343b with SMTP id
 5b1f17b1804b1-422866bf7acmr12422545e9.34.1718195398010; 
 Wed, 12 Jun 2024 05:29:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGINd+6BS488jJJd+2tnTAeS15ZxdKgoq7bmp+3EMsQJULV521LTJB7mc5d1Ofo7Q8sHUmFNoOiWA49az3ACkI=
X-Received: by 2002:a05:600c:3ba4:b0:422:5953:343b with SMTP id
 5b1f17b1804b1-422866bf7acmr12422445e9.34.1718195397680; Wed, 12 Jun 2024
 05:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jun 2024 14:29:45 +0200
Message-ID: <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I think this is extremely useful to show where we could go in the task
of creating more idiomatic bindings.

On Tue, Jun 11, 2024 at 12:34=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> +fn main() {
> +    println!("cargo::rerun-if-env-changed=3DMESON_BUILD_DIR");
> +    println!("cargo::rerun-if-env-changed=3DMESON_BUILD_ROOT");
> +    println!("cargo::rerun-if-changed=3Dsrc/generated.rs.inc");

Why do you need this rerun-if-changed?

> +pub const PL011_ARM_INFO: TypeInfo =3D TypeInfo {
> +    name: TYPE_PL011.as_ptr(),
> +    parent: TYPE_SYS_BUS_DEVICE.as_ptr(),
> +    instance_size: core::mem::size_of::<PL011State>(),
> +    instance_align: core::mem::align_of::<PL011State>(),
> +    instance_init: Some(pl011_init),
> +    instance_post_init: None,
> +    instance_finalize: None,
> +    abstract_: false,
> +    class_size: 0,
> +    class_init: Some(pl011_class_init),
> +    class_base_init: None,
> +    class_data: core::ptr::null_mut(),
> +    interfaces: core::ptr::null_mut(),
> +};

QOM is certainly a major part of what we need to do for idiomatic
bindings. This series includes both using QOM objects (chardev) and
defining them.

For using QOM objects, there is only one strategy that we need to
implement for both Chardev and DeviceState/SysBusDevice which is nice.
We can probably take inspiration from glib-rs, see for example
- https://docs.rs/glib/latest/glib/object/trait.Cast.html
- https://docs.rs/glib/latest/glib/object/trait.ObjectType.html
- https://docs.rs/glib/latest/glib/object/struct.ObjectRef.html

For definining new classes I think it's okay if Rust does not support
writing superclasses yet, only leaves.

I would make a QOM class written in Rust a struct that only contains
the new fields. The struct must implement Default and possibly Drop
(for finalize).

  struct PL011_Inner {
    iomem: MemoryRegion,
    readbuff: u32.
    ...
  }

and then a macro defines a wrapper struct that includes just two
fields, one for the superclass and one for the Rust struct.
instance_init can initialize the latter with Default::default().

  struct PL011 {
    parent_obj: qemu::bindings::SysBusDevice,
    private: PL011_Inner,
  }

"private" probably should be RefCell<PL011_Inner>, avoiding the unsafe

    state.as_mut().read(addr, size)

There should also be macros to define the wrappers for MMIO MemoryRegions.

> +    pub fn realize(&mut self) {
> +        unsafe {
> +            qemu_chr_fe_set_handlers(
> +                addr_of_mut!(self.char_backend),
> +                Some(pl011_can_receive),
> +                Some(pl011_receive),
> +                Some(pl011_event),
> +                None,
> +                addr_of_mut!(*self).cast::<c_void>(),
> +                core::ptr::null_mut(),
> +                true,
> +            );
> +        }

Probably each set of callbacks (MemoryRegion, Chardev) needs to be a
struct that implements a trait.

> +#[macro_export]
> +macro_rules! define_property {
> +    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default=
 =3D $defval:expr) =3D> {
> +        $crate::generated::Property {
> +            name: $name,
> +            info: $prop,
> +            offset: ::core::mem::offset_of!($state, $field) as _,
> +            bitnr: 0,
> +            bitmask: 0,
> +            set_default: true,
> +            defval: $crate::generated::Property__bindgen_ty_1 { u: $defv=
al.into() },
> +            arrayoffset: 0,
> +            arrayinfo: ::core::ptr::null(),
> +            arrayfieldsize: 0,
> +            link_type: ::core::ptr::null(),
> +        }
> +    };

Perhaps we can define macros similar to the C DEFINE_PROP_*, and const
functions can be used to enforce some kind of type safety.

pub const fn check_type<T>(_x: &T, y: T) -> T { y }

static VAR: i16 =3D 42i16;
static TEST: i8 =3D check_type(&VAR, 43i8);

pub fn main() { println!("{}", TEST); }

error[E0308]: mismatched types
 --> ff.rs:4:30
  |
4 | static TEST: i8 =3D check_type(&VAR, 43i8);
  |                   ---------- ^^^^ expected `&i8`, found `&i16`
  |                   |
  |                   arguments to this function are incorrect
  |
  =3D note: expected reference `&i8`
             found reference `&i16`

Anyhow I think this is already very useful, because as the
abstractions are developed, it is possible to see how the device code
evolves.

Paolo


