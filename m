Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910E2C27C7B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 14:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHPBX-0008Dp-Ap; Wed, 12 Jun 2024 10:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHPBV-00088I-6O
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:42:45 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHPBQ-0002mW-JO
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:42:44 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-421cd1e5f93so17310645e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718203359; x=1718808159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IJQzGtOTNGRDOa/cPH2bXSMiZyr4bNAcRThTDQ+LV3Q=;
 b=R6b2MS0+dh9m4tdfM1E+1fgIQxBaqFx5w+YJik1hAEH+WimmlQcW276t2PsQiJySsW
 2/SiS9kNU0acsWVrY8Kbi3CMB1c95zllZH/3ByQy1oxmOKzX40RCkMiAtstxzLyhOnJx
 lapVUnqmfiMCrNdDOQVWEbSpkW6yv7vuVebnelJcOFjkgIZQxgEj+RrRQ2FqHFf1bDFw
 +PoOkrup5S4N8OLeDggNMpNSaYYyQeodtlFubIQ4npKv+8LKbbIrUtS72YC13JTgAPQr
 Oi7r6Lup1ULB1z98jaHpm/VhA1s3K6v4t1EtEQwI4h5eaxHf+9ZrncK181KBMge0IRh+
 vCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718203359; x=1718808159;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IJQzGtOTNGRDOa/cPH2bXSMiZyr4bNAcRThTDQ+LV3Q=;
 b=ZnwTqxuC9rpSQ4qScsYtRVnSV+R3oBO+ttRnBrBk43h4lIK+L92ToAQ426zL7jIzlP
 ax9alAUkJNX6Jznd1lZHGgraCe0/BQKaMwvCRrEitsM7xV9W06tIcVwt9NLErIx7xnLg
 1sJddqloPuMmVngaXBTyWCF1daJn7U3H5iqcx8+PlRBix5LYnsurHDs5dLBuOWGTxgR8
 l7t/QTTRlpicthCE/hZsxZmAiSioAQHC8SlxdsXq78b9IX5pb36yULy4+U1VM7pu1mh8
 qDITwoDxkoKpVy9IKJ5eJ83hnRbMnKRr113pavlKM8pbTe4oWHZeiNqGEOp8ftAILiXV
 4KrQ==
X-Gm-Message-State: AOJu0YyKjElqv4RLKd6gIwY6NBTg5dNX46ENqO5S9F4tHZB+bRyDHX6/
 ElBp9jOUMaiUq8GpgTfTfjeyvNgPHLACcpueQYHc8jPD7/G1Ye8Xe7qZ3z6g/do=
X-Google-Smtp-Source: AGHT+IHdQmAR0MXedkxeaXitG9pojWJ5jaToLVqkTanv9+IXHaVgy1Bb9i5NVSobH2i4T9IvOn+LDA==
X-Received: by 2002:a5d:64cf:0:b0:35e:60f8:7ed8 with SMTP id
 ffacd0b85a97d-35fdf770cc1mr1820498f8f.11.1718203358794; 
 Wed, 12 Jun 2024 07:42:38 -0700 (PDT)
Received: from meli-email.org (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3606f9dee76sm1115442f8f.31.2024.06.12.07.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 07:42:38 -0700 (PDT)
Date: Wed, 12 Jun 2024 17:14:56 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
In-Reply-To: <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
Message-ID: <ez270.x96k6aeu0rpw@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 12 Jun 2024 15:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
>I think this is extremely useful to show where we could go in the task
>of creating more idiomatic bindings.
>
>On Tue, Jun 11, 2024 at 12:34 PM Manos Pitsidianakis
><manos.pitsidianakis@linaro.org> wrote:
>> +fn main() {
>> +    println!("cargo::rerun-if-env-changed=MESON_BUILD_DIR");
>> +    println!("cargo::rerun-if-env-changed=MESON_BUILD_ROOT");
>> +    println!("cargo::rerun-if-changed=src/generated.rs.inc");
>
>Why do you need this rerun-if-changed?

To show an error from build.rs in case the file is deleted and the build 
is not via meson

>
>> +pub const PL011_ARM_INFO: TypeInfo = TypeInfo {
>> +    name: TYPE_PL011.as_ptr(),
>> +    parent: TYPE_SYS_BUS_DEVICE.as_ptr(),
>> +    instance_size: core::mem::size_of::<PL011State>(),
>> +    instance_align: core::mem::align_of::<PL011State>(),
>> +    instance_init: Some(pl011_init),
>> +    instance_post_init: None,
>> +    instance_finalize: None,
>> +    abstract_: false,
>> +    class_size: 0,
>> +    class_init: Some(pl011_class_init),
>> +    class_base_init: None,
>> +    class_data: core::ptr::null_mut(),
>> +    interfaces: core::ptr::null_mut(),
>> +};
>
>QOM is certainly a major part of what we need to do for idiomatic
>bindings. This series includes both using QOM objects (chardev) and
>defining them.
>
>For using QOM objects, there is only one strategy that we need to
>implement for both Chardev and DeviceState/SysBusDevice which is nice.
>We can probably take inspiration from glib-rs, see for example
>- https://docs.rs/glib/latest/glib/object/trait.Cast.html
>- https://docs.rs/glib/latest/glib/object/trait.ObjectType.html
>- https://docs.rs/glib/latest/glib/object/struct.ObjectRef.html


There was consensus in the community call that we won't be writing Rust 
APIs for internal C QEMU interfaces; or at least, that's not the goal

It's not necessary to make bindings to write idiomatic Rust. If you 
notice, most callbacks QEMU calls cast the pointer into the Rust struct 
which then calls its idiomatic type methods. I like abstraction a lot, 
but it has diminishing returns. We'll see how future Rust devices look 
like and we can then decide if extra code for abstractions is a good 
trade-off.

>
>For definining new classes I think it's okay if Rust does not support
>writing superclasses yet, only leaves.
>
>I would make a QOM class written in Rust a struct that only contains
>the new fields. The struct must implement Default and possibly Drop
>(for finalize).

The object is allocated and freed from C, hence it is not Dropped. We're 
only ever accessing it from a reference retrieved from a QEMU provided 
raw pointer. If the struct gains heap object fields like Box or Vec or 
String, they'd have to be dropped manually on _unrealize.


>
>  struct PL011_Inner {
>    iomem: MemoryRegion,
>    readbuff: u32.
>    ...
>  }
>
>and then a macro defines a wrapper struct that includes just two
>fields, one for the superclass and one for the Rust struct.
>instance_init can initialize the latter with Default::default().
>
>  struct PL011 {
>    parent_obj: qemu::bindings::SysBusDevice,
>    private: PL011_Inner,
>  }

a nested struct is not necessary for using the Default trait. Consider a 
Default impl that sets parent_obj as a field memset to zero; on instance 
initialization we can do

  *self = Self {
    parent_obj: self.parent_obj,
    ..Self::default(),
  };

>"private" probably should be RefCell<PL011_Inner>, avoiding the unsafe
>
>    state.as_mut().read(addr, size)


RefCell etc are not FFI safe. Also, nested fields must be visible so 
that the offset_of! macro works, for QOM properties. Finally, 

     state.as_mut().read(addr, size)

Is safe since we receive a valid pointer from QEMU. This fact cannot be 
derived by the compiler, which is why it has an `unsafe` keyword. That 
does not mean that the use here is unsafe.

>
>There should also be macros to define the wrappers for MMIO MemoryRegions.


Do you mean the MemoryRegionOps?


>
>> +    pub fn realize(&mut self) {
>> +        unsafe {
>> +            qemu_chr_fe_set_handlers(
>> +                addr_of_mut!(self.char_backend),
>> +                Some(pl011_can_receive),
>> +                Some(pl011_receive),
>> +                Some(pl011_event),
>> +                None,
>> +                addr_of_mut!(*self).cast::<c_void>(),
>> +                core::ptr::null_mut(),
>> +                true,
>> +            );
>> +        }
>
>Probably each set of callbacks (MemoryRegion, Chardev) needs to be a
>struct that implements a trait.
>
>> +#[macro_export]
>> +macro_rules! define_property {
>> +    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr) => {
>> +        $crate::generated::Property {
>> +            name: $name,
>> +            info: $prop,
>> +            offset: ::core::mem::offset_of!($state, $field) as _,
>> +            bitnr: 0,
>> +            bitmask: 0,
>> +            set_default: true,
>> +            defval: $crate::generated::Property__bindgen_ty_1 { u: $defval.into() },
>> +            arrayoffset: 0,
>> +            arrayinfo: ::core::ptr::null(),
>> +            arrayfieldsize: 0,
>> +            link_type: ::core::ptr::null(),
>> +        }
>> +    };
>
>Perhaps we can define macros similar to the C DEFINE_PROP_*,

Hopefully if I end up doing something like this, it'd be in a standalone 
crate for other devices to use

>
>and const
>functions can be used to enforce some kind of type safety.
>
>pub const fn check_type<T>(_x: &T, y: T) -> T { y }
>
>static VAR: i16 = 42i16;
>static TEST: i8 = check_type(&VAR, 43i8);
>
>pub fn main() { println!("{}", TEST); }
>
>error[E0308]: mismatched types
> --> ff.rs:4:30
>  |
>4 | static TEST: i8 = check_type(&VAR, 43i8);
>  |                   ---------- ^^^^ expected `&i8`, found `&i16`
>  |                   |
>  |                   arguments to this function are incorrect
>  |
>  = note: expected reference `&i8`
>             found reference `&i16`


Yes this kind of type safety trick is easy to do (already done for a 
register macro in src/lib.rs).

I wanted to focus on the build system integration for the first RFC 
which is why there are some macros but not in every place it makes 
sense.

Thanks Paolo,
Manos

