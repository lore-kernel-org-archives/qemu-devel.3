Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A92CCF9F3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnbM-0006Gw-8w; Tue, 28 Oct 2025 13:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbI-0006Ei-P6
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbE-0004fh-Eg
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJJwl93Eh9oixq1cw/+plHG+ew8tbgNiOl2RmOmLQvg=;
 b=PSUWs0mkBIH+E9Ybe3HYftDW0NpzMOGaett4Y/Qp2EQ31FuWmcwoisYU86UlN0UZMDQmkE
 sOe6gFituD0srnpXDe27YAbqeTQMGNRMNrRfxuGakU7eaCIhIktDEaeUU0JUfpuqOSwNZd
 Yot/lEVxvZLaHGTPEDFlxPIZ69fAEeI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-c_x6qspiPuWlaxwXr1cDbQ-1; Tue, 28 Oct 2025 13:35:09 -0400
X-MC-Unique: c_x6qspiPuWlaxwXr1cDbQ-1
X-Mimecast-MFC-AGG-ID: c_x6qspiPuWlaxwXr1cDbQ_1761672908
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4770e0910a1so15819895e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672908; x=1762277708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJJwl93Eh9oixq1cw/+plHG+ew8tbgNiOl2RmOmLQvg=;
 b=SsTC/SSAQJGR+ME/H0VLhYu0sU0Gq55fxKfx/oPWVnev5J9uJjBtsksZ0oEiLkM1I1
 xk/x1WM4YNHWE5gMXEvkoiN2d56lmRd0w9PjVM0huOYviQ4f9D57yZNXzxYw4pYA8l7H
 rIEzXgFXFdQ6HofhpDqQKorDrQuwf0Ah57FClZs7lTA/YmAqAYQS2+viAKPkUkB4ATUD
 YbkqotEwMknQW2QwnCSkH2/Bx0TiF4ak9ab1OWOco3gYB5FKzP2I+bzXX1VuuFqzNFvh
 RoyHFZgFOrApXG84x51pWboTGUOkhrUdmwVJCVatyVFVLO5N98CtOLwfQICktwMlHw2M
 UyGg==
X-Gm-Message-State: AOJu0YyJfrAJFTAHnjn9CS/cr2Wzy9Q7WtpW02vMFLcyM3a28eAtMvUF
 eyCQFPzeYc/OYZ0prXzkqlDSHItGMyKK/fweFAB0+1JFl3sRdGyR1GE9Oij17iMI0JDhrRTnpjo
 RBCAFXVa24XJfuxWsuCIsEcK+2DhCOL3uzfIf6DDbfsh5qdVzF0zV75GYrcTR+uSrMVkiDfsPyU
 L4P31YIxc42PyMBivMcZMurbA+LY1VhXiPUfuTc1yC
X-Gm-Gg: ASbGncuEQGCmIdem2Qz4YOq+1p6h3m7W9BgjdqIJ8ZZqrhrO1rQ7G9biUgmhI9uEQpz
 fRfv3UwAxfsho1DZOffb6iMeUQGdpjCFKAfOfzKIDLTY/yapqAtfswH5zC0BckgWi7+mD3xrS+M
 +v1gt76vWfavgv/HM8Yti/JxUzzmIpyjY0gO89u+oYJ5KBOZIbGfZH9AALxRA1pMjV2m2+KncKe
 oyZxcXhPuUBwqeMzU3hOx6mjCos9s3y0IwHuDIrGrfN8ALqR3bQJQ0IeIhL/PyIi0KqBfSMlZrD
 vvUEsyo338hSJMpVF1fBNJWPY73SMaerEhbpPGZDP2q3FBWJEjWN0hNYWrtT1U08dd5xlYvB19v
 PcBAlNz8yHpGAKQUG59Awvch9qCNtQ0Vg/H1eo557TztIdUGgRL+gPC9FVkCx15zCvTpDmViePs
 zDpmI=
X-Received: by 2002:a05:600c:5197:b0:46e:2e93:589f with SMTP id
 5b1f17b1804b1-4771e17ef8cmr2420455e9.14.1761672907614; 
 Tue, 28 Oct 2025 10:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPkUU+dAv10MxRkRHfnhA0BtnY/MDOcbEVTYwfqdlHI4fPQinVEwWKurG9s7KIAA3VpwNZFQ==
X-Received: by 2002:a05:600c:5197:b0:46e:2e93:589f with SMTP id
 5b1f17b1804b1-4771e17ef8cmr2420215e9.14.1761672907106; 
 Tue, 28 Oct 2025 10:35:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47718493c61sm25002885e9.4.2025.10.28.10.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:35:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 12/18] rust/qemu-macros: Convert bit value to u8 within
 #[property]
Date: Tue, 28 Oct 2025 18:34:24 +0100
Message-ID: <20251028173430.2180057-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

For bit property, make the type conversion within the #[property] macro
so that users do not need to handle the conversion.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251024041344.1389488-1-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs |  2 +-
 rust/qemu-macros/src/lib.rs      | 23 ++++++++++++++++++-----
 rust/qemu-macros/src/tests.rs    | 15 ++++++++++++---
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 86638c07666..23f2eefd1cd 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -539,7 +539,7 @@ pub struct HPETState {
     // Internal state
     /// Capabilities that QEMU HPET supports.
     /// bit 0: MSI (or FSB) support.
-    #[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8, default = false)]
+    #[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT, default = false)]
     flags: u32,
 
     /// Offset of main counter relative to qemu clock.
diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index 50239f228be..ee417bb4b4e 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -262,12 +262,25 @@ macro_rules! str_to_c_str {
             },
         )?;
         let field_ty = field.ty.clone();
-        let qdev_prop = if bitnr.is_none() {
-            quote! { <#field_ty as ::hwcore::QDevProp>::BASE_INFO }
+        let (qdev_prop, bitval) = if let Some(bitval) = bitnr {
+            (
+                quote! { <#field_ty as ::hwcore::QDevProp>::BIT_INFO },
+                quote! {
+                    {
+                        const {
+                            assert!(#bitval >= 0 && #bitval < #field_ty::BITS as _,
+                                    "bit number exceeds type bits range");
+                        }
+                        #bitval as u8
+                    }
+                },
+            )
         } else {
-            quote! { <#field_ty as ::hwcore::QDevProp>::BIT_INFO }
+            (
+                quote! { <#field_ty as ::hwcore::QDevProp>::BASE_INFO },
+                quote! { 0 },
+            )
         };
-        let bitnr = bitnr.unwrap_or(syn::Expr::Verbatim(quote! { 0 }));
         let set_default = defval.is_some();
         let defval = defval.unwrap_or(syn::Expr::Verbatim(quote! { 0 }));
         properties_expanded.push(quote! {
@@ -275,7 +288,7 @@ macro_rules! str_to_c_str {
                 name: ::std::ffi::CStr::as_ptr(#prop_name),
                 info: #qdev_prop,
                 offset: ::core::mem::offset_of!(#name, #field_name) as isize,
-                bitnr: #bitnr,
+                bitnr: #bitval,
                 set_default: #set_default,
                 defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: #defval as u64 },
                 ..::common::Zeroable::ZERO
diff --git a/rust/qemu-macros/src/tests.rs b/rust/qemu-macros/src/tests.rs
index 65691412ff5..b65cf656fa3 100644
--- a/rust/qemu-macros/src/tests.rs
+++ b/rust/qemu-macros/src/tests.rs
@@ -179,7 +179,10 @@ unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
                         name: ::std::ffi::CStr::as_ptr(c"flags"),
                         info: <u32 as ::hwcore::QDevProp>::BIT_INFO,
                         offset: ::core::mem::offset_of!(DummyState, flags) as isize,
-                        bitnr: 3,
+                        bitnr : {
+                            const { assert!(3 >= 0 && 3 < u32::BITS as _ , "bit number exceeds type bits range"); }
+                            3 as u8
+                        },
                         set_default: false,
                         defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: 0 as u64 },
                         ..::common::Zeroable::ZERO
@@ -207,7 +210,10 @@ unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
                         name: ::std::ffi::CStr::as_ptr(c"flags"),
                         info: <u32 as ::hwcore::QDevProp>::BIT_INFO,
                         offset: ::core::mem::offset_of!(DummyState, flags) as isize,
-                        bitnr: 3,
+                        bitnr : {
+                            const { assert!(3 >= 0 && 3 < u32::BITS as _ , "bit number exceeds type bits range"); }
+                            3 as u8
+                        },
                         set_default: true,
                         defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: true as u64 },
                         ..::common::Zeroable::ZERO
@@ -235,7 +241,10 @@ unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
                         name: ::std::ffi::CStr::as_ptr(c"msi"),
                         info: <u64 as ::hwcore::QDevProp>::BIT_INFO,
                         offset: ::core::mem::offset_of!(DummyState, flags) as isize,
-                        bitnr: 3,
+                        bitnr : {
+                            const { assert!(3 >= 0 && 3 < u64::BITS as _ , "bit number exceeds type bits range"); }
+                            3 as u8
+                        },
                         set_default: true,
                         defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: false as u64 },
                         ..::common::Zeroable::ZERO
-- 
2.51.1


