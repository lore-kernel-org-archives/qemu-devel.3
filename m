Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF6BC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 06:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siTJG-0000Km-7r; Mon, 26 Aug 2024 02:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siTJE-0000K6-Fo
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:34:36 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siTJA-0007sz-9q
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:34:36 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a86acbaddb4so264477866b.1
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 23:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724654071; x=1725258871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yD4Wvg142Xg4rfjsCCSpI82hmcRXozOMye58z1giECY=;
 b=AaW+hMS43kkx03Y3rxeC06Xk7dvDIYvXiONwCiOSd0JPKyUsVcybwNQBrrMNO18pWU
 7drwQx3htcIo9Kn8HwC4DMIlOPG9MtohQ+xguWvu0abB70PoswU7o//Xv266usLkIig+
 S/0207XDTDVt7Q6xdybZrM99U0d9UwKp/+CThZTT2T9JjQMXj96AokgWEhZLxuQfy6vQ
 0qmomtUQaj9C5TUaGsLDdemDi4UDnkT5cmuIrNaMC0CZWjaBkdIeldzJ9gsB3MFWgvFL
 h70zftIn1quCdDTyjX1dqZKYw7rUkPb9xilZqvUFQb4o7E3QghFh8sKbsx2v1y3/4Jyo
 QGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724654071; x=1725258871;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yD4Wvg142Xg4rfjsCCSpI82hmcRXozOMye58z1giECY=;
 b=ni9JEIShkZ+V7TBDlME0MW89VW2Gj/laAJUG4/5ivcebREONPZkzOH7JLn1+O85ZFz
 8qtRVByJwrq47WSkZw5M/iAEQagKG2GikQVaxZu6wn+6AQUaTCxn8mptLH81cJY4gtaH
 rst5+93RfCfxx5OA4+6u0OOW0dQYI/FWfPIb6Y25xuUWfdqi6UYbBKa+q2BS6y//avDN
 mUNvQAUX11GVUb8R/5f6ecuc72NzKwIYD5mrjszPDncc3AgzD2yxX/ESRisfdXtRFlU6
 T6LPNtiloEyJOs0MH5xp5IS/WXvV+dhpb3Z4KOOFoPabVgDkMtnPIxYatJTk/N479Swb
 D4Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7xdCERuPjBcNs7WWrPpFud60O/gpsfSlg8ybcXkQSjz/0o/5gVqyGdDsMAKwWMKGMdo+CgQNvdpS0@nongnu.org
X-Gm-Message-State: AOJu0YzQGWEsTaxHn/CblvcZ4TldmiE4rzLpq1uH41KjrTYoqwweyi0r
 h8MdkES1V5Pz9PhIBGiI1bzwPdeZaxm0hI2dR0EwXS6srz0/pKovN7AKZTQ8CxY=
X-Google-Smtp-Source: AGHT+IFRBddJwrAZlcJTcaS9z3pWuQsc2LRvuNpDKzd525QuDzXKp4HMLlwmy/BFRExFk3qFR8yfWw==
X-Received: by 2002:a17:906:6a17:b0:a86:4649:28e6 with SMTP id
 a640c23a62f3a-a86a54bf4d6mr591933866b.57.1724654070091; 
 Sun, 25 Aug 2024 23:34:30 -0700 (PDT)
Received: from meli-email.org (adsl-98.109.242.227.tellas.gr. [109.242.227.98])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f2a5321sm623380466b.73.2024.08.25.23.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2024 23:34:29 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:12:28 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Junjie Mao <junjie.mao@intel.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v8 6/8] rust: add crate to expose bindings and interfaces
User-Agent: meli 0.8.7
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
 <20240823-rust-pl011-v8-6-b9f5746bdaf3@linaro.org>
 <8570704d-7cc8-460f-940e-4bf626972465@intel.com>
In-Reply-To: <8570704d-7cc8-460f-940e-4bf626972465@intel.com>
Message-ID: <itblf.by425lac4ow@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

On Mon, 26 Aug 2024 08:03, Junjie Mao <junjie.mao@intel.com> wrote:
>Hi Manos,
>
>On 8/23/2024 4:11 PM, Manos Pitsidianakis wrote:
>> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
>> provides some declaration macros for symbols visible to the rest of
>> QEMU.
>> 
>> Co-authored-by: Junjie Mao <junjie.mao@intel.com>
>> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Junjie Mao <junjie.mao@intel.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>   MAINTAINERS                       |   6 ++
>>   rust/meson.build                  |   1 +
>>   rust/qemu-api/.gitignore          |   2 +
>>   rust/qemu-api/Cargo.lock          |   7 +++
>>   rust/qemu-api/Cargo.toml          |  26 ++++++++
>>   rust/qemu-api/README.md           |  17 +++++
>>   rust/qemu-api/build.rs            |  14 +++++
>>   rust/qemu-api/meson.build         |  20 ++++++
>>   rust/qemu-api/rustfmt.toml        |   1 +
>>   rust/qemu-api/src/definitions.rs  | 109 ++++++++++++++++++++++++++++++++
>>   rust/qemu-api/src/device_class.rs | 128 ++++++++++++++++++++++++++++++++++++++
>>   rust/qemu-api/src/lib.rs          | 102 ++++++++++++++++++++++++++++++
>>   rust/qemu-api/src/tests.rs        |  49 +++++++++++++++
>>   rust/rustfmt.toml                 |   7 +++
>>   14 files changed, 489 insertions(+)
>> 
>[snip]
>> diff --git a/rust/qemu-api/README.md b/rust/qemu-api/README.md
>> new file mode 100644
>> index 0000000000..7588fa29ef
>> --- /dev/null
>> +++ b/rust/qemu-api/README.md
>> @@ -0,0 +1,17 @@
>> +# QEMU bindings and API wrappers
>> +
>> +This library exports helper Rust types, Rust macros and C FFI bindings for internal QEMU APIs.
>> +
>> +The C bindings can be generated with `bindgen`, using this build target:
>> +
>> +```console
>> +$ ninja bindings.rs
>> +```
>> +
>
>I suggest mentioning here that cargo test requires --no-default-features.


Right. I will make #[global_allocator] depend on both the `allocator` 
feature being on, and `test` off.

>
>> +## Generate Rust documentation
>> +
>> +To generate docs for this crate, including private items:
>> +
>> +```sh
>> +cargo doc --no-deps --document-private-items
>> +```
>[snip]
>> diff --git a/rust/qemu-api/rustfmt.toml b/rust/qemu-api/rustfmt.toml
>> new file mode 120000
>> index 0000000000..39f97b043b
>> --- /dev/null
>> +++ b/rust/qemu-api/rustfmt.toml
>> @@ -0,0 +1 @@
>> +../rustfmt.toml
>> \ No newline at end of file
>
>This symbolic link is unnecessary. rustfmt will recursively search the parent 
>directories for rustfmt.toml [1].
>
>[1] https://github.com/rust-lang/rustfmt?tab=readme-ov-file#configuring-rustfmt

Good to know, will remove it.

>> diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
>> new file mode 100644
>> index 0000000000..4abd0253bd
>> --- /dev/null
>> +++ b/rust/qemu-api/src/definitions.rs
>> @@ -0,0 +1,109 @@
>> +// Copyright 2024, Linaro Limited
>> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +//! Definitions required by QEMU when registering a device.
>> +
>> +/// Trait a type must implement to be registered with QEMU.
>> +pub trait ObjectImpl {
>> +    type Class;
>> +    const TYPE_INFO: crate::bindings::TypeInfo;
>> +    const TYPE_NAME: &'static ::core::ffi::CStr;
>> +    const PARENT_TYPE_NAME: Option<&'static ::core::ffi::CStr>;
>> +    const INSTANCE_INIT: ::core::option::Option<
>> +        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
>> +    >;
>> +    const INSTANCE_POST_INIT: ::core::option::Option<
>> +        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
>> +    >;
>> +    const INSTANCE_FINALIZE: ::core::option::Option<
>> +        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
>> +    >;
>> +    const ABSTRACT: bool;
>> +}
>> +
>> +pub trait Class {
>> +    const CLASS_INIT: ::core::option::Option<
>> +        unsafe extern "C" fn(
>> +            klass: *mut crate::bindings::ObjectClass,
>> +            data: *mut core::ffi::c_void,
>> +        ),
>> +    >;
>> +    const CLASS_BASE_INIT: ::core::option::Option<
>> +        unsafe extern "C" fn(
>> +            klass: *mut crate::bindings::ObjectClass,
>> +            data: *mut core::ffi::c_void,
>> +        ),
>> +    >;
>> +}
>> +
>> +#[macro_export]
>> +macro_rules! module_init {
>> +    ($func:expr, $type:expr) => {
>> +        #[used]
>> +        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
>> +        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
>> +        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
>> +        pub static LOAD_MODULE: extern "C" fn() = {
>> +            assert!($type < $crate::bindings::module_init_type_MODULE_INIT_MAX);
>> +
>> +            extern "C" fn __load() {
>> +                unsafe {
>> +                    $crate::bindings::register_module_init(Some($func), $type);
>> +                }
>> +            }
>> +
>> +            __load
>> +        };
>> +    };
>> +    (qom: $func:ident => $body:block) => {
>
>This arm looks duplicating what #[derive(Object)] is for, while both have their 
>strengths and limitations: module_init!() provides more flexibility on the 
>registration function body, and #[derive(Object)] is much more convenient to use.
>
>Complex registration functions are not rare, and thus the Rust APIs should 
>ideally have both strengths: clean type declaration in most cases, and full 
>flexibility when needed. In the current codebase, we have ~1080 uses of 
>type_init(), with 750 of them having a registration function as simple as a 
>single call to type_register_static() (disclaimer: those numbers are collected 
>via brute-force searches and may not be accurate). More complex cases include:
>
>1. Registering multiple types (e.g., multiple models of same device) that share 
>the same data structure, e.g., hw/misc/aspeed_xdma.c and hw/xtensa/xtfpga.c. 
>There are ~200 uses of this kind in the codebase.
>
>2. Use domain-specific registration function, e.g., ui/egl-headless.c, 
>audio/ossaudio.c and hw/virtio/virtio-net-pci.c.
>
>3. Other device-specific operations, e.g., hw/net/spapr_llan.c.
>

This is why I left the decl macro, I was prototyping this series with a 
second Rust device (that is not included in the patches) and I needed 
more logic in the module init.

>My rough idea is to define a proc macro around an impl block to collect 
>constants (type names, parent names, etc.) as tokens and callbacks (class init, 
>instance init, etc.) as functions, from which we generate TypeInfo and 
>(optionally) type registration code. As an example:

Do you think we should not use a trait to define type info at all by the 
way?

>
>   pub struct PL011State {
>     ...
>   }
>
>   #[qemu_type(name = "pl011", parent = TYPE_SYS_BUS_DEVICE, (abstract)*)]
>   impl PL011State {
>     #[class_init]
>     pub fn class_init(klass: *mut ObjectClass, data: *mut core::ffi::c_void) {
>       ...
>     }
>
>     #[instance_init]
>     pub fn init(obj: *mut Object) { ... }
>
>     ...
>   }
>
>The proc macro then generates a TypeInfo instance named TYPE_INFO_pl011, with 
>optional callbacks being None when not given. A registration function will also 
>be generated unless qemu_type! has a no_register token.

Maybe this too can be a trait method people can override with a blank 
implementation to avoid registration...

>Devices can still use module_init! to define their own registration 
>function.
>
>The class_init callback is specified together with instance_init because it is 
>common for multi-model devices to provide a different class_init even they share 
>the same class structure. Refer to hw/misc/aspeed_xdma.c for an example.

Thanks I will take a look. QEMU Classes are a bit complex indeed.

>
>What do you think? It is still preliminary and the example can have grammatical 
>issues, but I can try drafting if you think that is a good direction.

In my plan I wanted to eventually have all these callbacks available to 
Rust code via trait methods which only take rust references instead of 
pointers. Then the proc macros would generate extern "C" wrappers for 
each of them, make a typeinfo declaration, set everything up. I like 
your approach too. Should we wait until we have an actual device that 
requires redesigning this? We're free to change things anyway.

>
>---
>Best Regards
>Junjie Mao
>
>> +        // NOTE: To have custom identifiers for the ctor func we need to either supply
>> +        // them directly as a macro argument or create them with a proc macro.
>> +        #[used]
>> +        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
>> +        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
>> +        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
>> +        pub static LOAD_MODULE: extern "C" fn() = {
>> +            extern "C" fn __load() {
>> +                #[no_mangle]
>> +                unsafe extern "C" fn $func() {
>> +                    $body
>> +                }
>> +
>> +                unsafe {
>> +                    $crate::bindings::register_module_init(
>> +                        Some($func),
>> +                        $crate::bindings::module_init_type_MODULE_INIT_QOM,
>> +                    );
>> +                }
>> +            }
>> +
>> +            __load
>> +        };
>> +    };
>> +}
>> +
>> +#[macro_export]
>> +macro_rules! type_info {
>> +    ($t:ty) => {
>> +        $crate::bindings::TypeInfo {
>> +            name: <$t as $crate::definitions::ObjectImpl>::TYPE_NAME.as_ptr(),
>> +            parent: if let Some(pname) = <$t as $crate::definitions::ObjectImpl>::PARENT_TYPE_NAME {
>> +                pname.as_ptr()
>> +            } else {
>> +                ::core::ptr::null_mut()
>> +            },
>> +            instance_size: ::core::mem::size_of::<$t>(),
>> +            instance_align: ::core::mem::align_of::<$t>(),
>> +            instance_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_INIT,
>> +            instance_post_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_POST_INIT,
>> +            instance_finalize: <$t as $crate::definitions::ObjectImpl>::INSTANCE_FINALIZE,
>> +            abstract_: <$t as $crate::definitions::ObjectImpl>::ABSTRACT,
>> +            class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>(),
>> +            class_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_INIT,
>> +            class_base_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_BASE_INIT,
>> +            class_data: ::core::ptr::null_mut(),
>> +            interfaces: ::core::ptr::null_mut(),
>> +        };
>> +    }
>> +}

