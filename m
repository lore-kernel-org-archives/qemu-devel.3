Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98CCCCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 07:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBsn-0003zA-N0; Fri, 24 Oct 2025 03:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vCBsl-0003yl-Pm
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:06:39 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vCBsi-0007oB-JK
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:06:39 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-63bf76fc9faso3186715a12.2
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 00:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761289594; x=1761894394; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JUJEaRPsh6/qimqJR3dkhAKVZxll1SWc/WpT3QfbVlk=;
 b=ZXBkuvRt+EHQMEEN+IRVuv+Tpk5eltqBKBP++dcG7jBteLN+8t0MF1kTho08FVrRB5
 5T38JrZxSv4p6I0UsmBW3cjorQR9df0y/uuh01xB2nOsXf7qeraxiW8x1J7MpdI7DRDC
 BNMej/viLFdKCdjJY+kJXz1VMUKl6rKa/7OwOT/6Yi1lIt3PMmrP128dMHRAZYIuxOb6
 plG+BBXuU8LNOFlya9P1XDFR02ukT4S7vjiCVoW8cYDhomPy32sHto9qSCFcnPg/I3g7
 QICBIcalAab9WMSlKfdxolybhFwGlp/ZWNWWxLap0AKPPowa2ENF/jzyYGX/0WBCs+cF
 TI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761289594; x=1761894394;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUJEaRPsh6/qimqJR3dkhAKVZxll1SWc/WpT3QfbVlk=;
 b=w7sp0gpwZ34CLRO6vbMxj9+/3PDCw/7urVQRCqH6RLe+mABROhAFVR157TVrny71Hv
 zoh6MCjdZf1qF50VJlOj8CXIk3W76gfW3OuacblWWGFHQ30sQz3kwmtFnkZfkUgzkbUl
 Cn0Mfpye5q/kSYMSrDVDZMUqOHsqPvCi+l4Iy1j7crnxkOhOdVjC3d4CP0SiMUjcklKF
 dHhw9Zd786QWFiz+VkmnT1KKTtWblWDHg5v6jFYwj0z0GTZu4qEZJseuyir2tB8RKcuK
 Y+exYpKlYo3ybMA2vQhEveXcfhsvELU+XwGrkLdrJx9c2d+/X4d54PJIaJS1pR2TtBCl
 flAQ==
X-Gm-Message-State: AOJu0Yyh4xt2KJMVPt2nL2hGn/yCLrp8r8bfNf/sjD5Lut7+VezUcgaZ
 SdwYNs28eJjQAVNg2Vyh0m68zUFZ4kpZ2kFd+Y1BnmEWji2G3rIcveJAYnZqppEHA08=
X-Gm-Gg: ASbGncs8w/IIMpNnN6gj2GuGQkpC8mOVRDGhb8wDP7bHEMT55Y0vLw+7byLSUXcKGY8
 nlrjnzWQix0OOiwFkCJiw/ScSI7CWvxw9lxhlZJ2RQ5uGaNOLCiZE1BCu76/QEUQMJPkvkyRITU
 6mJjzZWJalbJolJRtaR3iO9RAdssNagyydAPm4Rs1THRT7uFK8JgqoATcJhbOJpFLPvMgm4cLsd
 MEhZQTJId6vVSTBuPrQXeFEDeewdAl7iVgkAsrbrKg9RZZBHsim5bxafYwb1AiIqhyOCXzX2gdF
 YkqX+cvfIVk08bQMCqhnB6liI2hac1ulILlYExJELXwpHa5cHKrhm3tHgJZnFbUKR9JtQGCIySN
 iHh5bK8/cBLmfv+b2s2BgPSYm9KVe3wYyRlSdr+mHl3ZzXGF/FCTm3L9O+GlULwO7KAUnhg4wS1
 UwwXs82TBiLrm3PkcUV3FVe8w6ez3e5gbJv3IY0csZeiujp0H3wS4h64IOVkqQ
X-Google-Smtp-Source: AGHT+IExyXPOMj6BIgZSb8wr9qFGU6WhtqmFly/uHleC8TxgrdaTVTTVNs+8QD1wKZHAkpkjkUfd5w==
X-Received: by 2002:a05:6402:5189:b0:63c:3efe:d970 with SMTP id
 4fb4d7f45d1cf-63c3efeee6emr22089507a12.31.1761289594164; 
 Fri, 24 Oct 2025 00:06:34 -0700 (PDT)
Received: from meli-email.org (athedsl-4440453.home.otenet.gr.
 [79.129.177.117]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e3ebb328esm3446636a12.5.2025.10.24.00.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 00:06:33 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:59:37 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2] rust/qemu-macros: Convert bit value to u8 within
 #[property]
User-Agent: meli/0.8.12
References: <20251024041344.1389488-1-zhao1.liu@intel.com>
In-Reply-To: <20251024041344.1389488-1-zhao1.liu@intel.com>
Message-ID: <t4mjqw.dx8x6zfu0m3i@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 24 Oct 2025 07:13, Zhao Liu <zhao1.liu@intel.com> wrote:
>For bit property, make the type conversion within the #[property] macro
>so that users do not need to handle the conversion.
>
>Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>---
>Changes Since v2:
> - Check #field_ty::BITS instead of u8::MAX.
> - Update test cases.
>---


LGTM, some questions...

> rust/hw/timer/hpet/src/device.rs |  2 +-
> rust/qemu-macros/src/lib.rs      | 23 ++++++++++++++++++-----
> rust/qemu-macros/src/tests.rs    | 15 ++++++++++++---
> 3 files changed, 31 insertions(+), 9 deletions(-)
>
>diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
>index 86638c076666..23f2eefd1cd9 100644
>--- a/rust/hw/timer/hpet/src/device.rs
>+++ b/rust/hw/timer/hpet/src/device.rs
>@@ -539,7 +539,7 @@ pub struct HPETState {
>     // Internal state
>     /// Capabilities that QEMU HPET supports.
>     /// bit 0: MSI (or FSB) support.
>-    #[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8, default = false)]
>+    #[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT, default = false)]
>     flags: u32,
> 
>     /// Offset of main counter relative to qemu clock.
>diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
>index 50239f228be2..ee417bb4b4ef 100644
>--- a/rust/qemu-macros/src/lib.rs
>+++ b/rust/qemu-macros/src/lib.rs
>@@ -262,12 +262,25 @@ macro_rules! str_to_c_str {
>             },
>         )?;
>         let field_ty = field.ty.clone();
>-        let qdev_prop = if bitnr.is_none() {
>-            quote! { <#field_ty as ::hwcore::QDevProp>::BASE_INFO }
>+        let (qdev_prop, bitval) = if let Some(bitval) = bitnr {
>+            (
>+                quote! { <#field_ty as ::hwcore::QDevProp>::BIT_INFO },
>+                quote! {
>+                    {
>+                        const {
>+                            assert!(#bitval >= 0 && #bitval < #field_ty::BITS as _,
>+                                    "bit number exceeds type bits 
>range");

Const panic messages cannot use formatting parameters yet, but.
Can we interpolate the type (e.g u32) in the compile-time panic message? 
Not important but would make the error message friendlier.


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>+                        }
>+                        #bitval as u8
>+                    }
>+                },
>+            )
>         } else {
>-            quote! { <#field_ty as ::hwcore::QDevProp>::BIT_INFO }
>+            (
>+                quote! { <#field_ty as ::hwcore::QDevProp>::BASE_INFO },
>+                quote! { 0 },
>+            )
>         };
>-        let bitnr = bitnr.unwrap_or(syn::Expr::Verbatim(quote! { 0 }));
>         let set_default = defval.is_some();
>         let defval = defval.unwrap_or(syn::Expr::Verbatim(quote! { 0 }));
>         properties_expanded.push(quote! {
>@@ -275,7 +288,7 @@ macro_rules! str_to_c_str {
>                 name: ::std::ffi::CStr::as_ptr(#prop_name),
>                 info: #qdev_prop,
>                 offset: ::core::mem::offset_of!(#name, #field_name) as isize,
>-                bitnr: #bitnr,
>+                bitnr: #bitval,
>                 set_default: #set_default,
>                 defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: #defval as u64 },
>                 ..::common::Zeroable::ZERO
>diff --git a/rust/qemu-macros/src/tests.rs b/rust/qemu-macros/src/tests.rs
>index 65691412ff57..b65cf656fa36 100644
>--- a/rust/qemu-macros/src/tests.rs
>+++ b/rust/qemu-macros/src/tests.rs
>@@ -179,7 +179,10 @@ unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
>                         name: ::std::ffi::CStr::as_ptr(c"flags"),
>                         info: <u32 as ::hwcore::QDevProp>::BIT_INFO,
>                         offset: ::core::mem::offset_of!(DummyState, flags) as isize,
>-                        bitnr: 3,
>+                        bitnr : {
>+                            const { assert!(3 >= 0 && 3 < u32::BITS as _ , "bit number exceeds type bits range"); }
>+                            3 as u8
>+                        },
>                         set_default: false,
>                         defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: 0 as u64 },
>                         ..::common::Zeroable::ZERO
>@@ -207,7 +210,10 @@ unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
>                         name: ::std::ffi::CStr::as_ptr(c"flags"),
>                         info: <u32 as ::hwcore::QDevProp>::BIT_INFO,
>                         offset: ::core::mem::offset_of!(DummyState, flags) as isize,
>-                        bitnr: 3,
>+                        bitnr : {
>+                            const { assert!(3 >= 0 && 3 < u32::BITS as _ , "bit number exceeds type bits range"); }
>+                            3 as u8
>+                        },
>                         set_default: true,
>                         defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: true as u64 },
>                         ..::common::Zeroable::ZERO
>@@ -235,7 +241,10 @@ unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
>                         name: ::std::ffi::CStr::as_ptr(c"msi"),
>                         info: <u64 as ::hwcore::QDevProp>::BIT_INFO,
>                         offset: ::core::mem::offset_of!(DummyState, flags) as isize,
>-                        bitnr: 3,
>+                        bitnr : {
>+                            const { assert!(3 >= 0 && 3 < u64::BITS as _ , "bit number exceeds type bits range"); }
>+                            3 as u8
>+                        },
>                         set_default: true,
>                         defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: false as u64 },
>                         ..::common::Zeroable::ZERO
>-- 
>2.34.1
>

