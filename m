Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5D3CAC5B5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Loy-0005G0-5V; Wed, 24 Sep 2025 05:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lov-0005EH-07
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Loq-0004pJ-8r
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HXmvPGZW6Xy2j6d5SQMF9drQH62wek/K3jL06MV925U=;
 b=MysXxtF5Y0+cGfPUIIjrt9yPAsP792F1KwMqWp0WZnKBSKPZJPkesIUZR431JArcuO/uEd
 dmnuZsNK2ryPjS4B87X9U6c3idYTRsJW1Rm0BqpKYcsF9aUPZVu66m4EIg0E6topBdlfM5
 C83mSdU9k2GV17IzpmJhWI7c8/M6Xgc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-0kUguhR8MUiV5kId6M3o6w-1; Wed, 24 Sep 2025 05:29:41 -0400
X-MC-Unique: 0kUguhR8MUiV5kId6M3o6w-1
X-Mimecast-MFC-AGG-ID: 0kUguhR8MUiV5kId6M3o6w_1758706180
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b2e6b2bb443so264352166b.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706180; x=1759310980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXmvPGZW6Xy2j6d5SQMF9drQH62wek/K3jL06MV925U=;
 b=Ca9jqOA/LOXr7CK9XP9lo/HBe9KjcjuC+s5tKefO6SZaGMX+Z6wzRtCbxtLEQQCx7j
 jv1fBx71hLjtwXXs8gjKDqxoN23x8slcdRhUEMGd/K8RisuQ0Ci5xb4opj3yLNpQXICL
 Erf8WHdZpzfCc4geLx6iD78xswYGVAdpX/Y63so4aalTcKzdPwRJDCEhfOH+eM9BUtYc
 C9IeDb0Wa1az/nC9UhrmXs6ChagugSZyWC/nEZfgKIP3/lNCm7t+vJZaYYtcDPhXrIYN
 B6zG2iFJ3nwMPnq2GMNi6c7m4RkYwfnYpNkd64WkqIN8ymFZeAPDirqMKX3KY9VVvBVZ
 eMzA==
X-Gm-Message-State: AOJu0Yy8hCa6kmoYxo9VA1OgKdEstSyKJAUOy5SSWHsuGvF5zxlKqoSi
 4ZUcaqfzR0u+7j+wfmfjozqXmfGoMLeT3z5z6N2bkLsty2dI1jFdR1UEbMuzujj1NzpfLg7RM6K
 8M92ioNH7o1jkeG1q+oEngoRJcSmKd6MRCAGQMkfdMCm4bXJVJIyNxB2jRSNCispaL+LtEkPB2W
 N294UH9LE2Lahn42vOa46Ll2IOtDzne7CcZz4IDQ2a
X-Gm-Gg: ASbGncs33obArk0fkcdtmRjj6ZJzBa1rrlIS6Jg7bmHNWOHiPrxwW0X2zKRD7vuqfxW
 kMZheYmEiUOenVKWbRyei6GCRnScJYuNJFU3N462IYW2XGnueo8b7qNDC68hXULB/2NCMSuEEpV
 Z6CoJIIp5Wm+e7mTo0W++B6n2Y2O6djSoZKmh6jMAXKhn9gUWO3bd4Huxaz2SFQtva+aCjViZvm
 YSz20wTEQamXdWJC4DOJopgOsEx7wvagUJsDDPtu/CBRxA3ZXowj97urr2Nysie06BP8D5hTxEW
 mPza2HM4dA8t71fp59LZuF+XU6o3dDKebhtjC0ObfgI9noQsJy5e2EnjofzKXaHEKI9I67fcfdJ
 kMJrY3YeoUqn1wHffntl64NMkcMZKHo/teVGCcbiDUTj04A==
X-Received: by 2002:a17:906:4fca:b0:ae3:b2b7:7f2f with SMTP id
 a640c23a62f3a-b302a36d276mr638233866b.40.1758706179755; 
 Wed, 24 Sep 2025 02:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcVaNEYDYvuMwc5KljUL2ILfOCZq9WbaTbv8PpkQPjvlWw7PbjtCqBlFk/hyGs+i+Cp1gw3A==
X-Received: by 2002:a17:906:4fca:b0:ae3:b2b7:7f2f with SMTP id
 a640c23a62f3a-b302a36d276mr638230866b.40.1758706179290; 
 Wed, 24 Sep 2025 02:29:39 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62fa5f27640sm12429827a12.39.2025.09.24.02.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 15/29] rust/qdev: Test bit property for #property
Date: Wed, 24 Sep 2025 11:28:35 +0200
Message-ID: <20250924092850.42047-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There's a diference between Rust and C:

Though C macro (e.g., DEFINE_PROP_BIT or DEFINE_PROP_BIT64) always
requires default value, Rust side allows to omit this "default" field
in #property, and provides a default value ("0" - false) for this
field.

This minor difference does not break user habits and should be
acceptable. Therefore, the test cases also cover this scenario.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20250920160520.3699591-10-zhao1.liu@intel.com
---
 rust/qemu-macros/src/tests.rs | 99 +++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/rust/qemu-macros/src/tests.rs b/rust/qemu-macros/src/tests.rs
index ec137132ae7..ac998d20e30 100644
--- a/rust/qemu-macros/src/tests.rs
+++ b/rust/qemu-macros/src/tests.rs
@@ -89,6 +89,19 @@ struct DummyState {
         "Duplicate argument",
         "Already used here",
     );
+    derive_compile_fail!(
+        derive_device_or_error,
+        quote! {
+            #[repr(C)]
+            #[derive(Device)]
+            struct DummyState {
+                #[property(bit = 0, bit = 1)]
+                flags: u32,
+            }
+        },
+        "Duplicate argument",
+        "Already used here",
+    );
     // Check that the field name is preserved when `rename` isn't used:
     derive_compile!(
         derive_device_or_error,
@@ -145,6 +158,92 @@ unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
             }
         }
     );
+    // Check that `bit` value is used for the bit property without default
+    // value (note: though C macro (e.g., DEFINE_PROP_BIT) always requires
+    // default value, Rust side allows to default this field to "0"):
+    derive_compile!(
+        derive_device_or_error,
+        quote! {
+            #[repr(C)]
+            #[derive(Device)]
+            pub struct DummyState {
+                parent: ParentField<DeviceState>,
+                #[property(bit = 3)]
+                flags: u32,
+            }
+        },
+        quote! {
+            unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
+                const PROPERTIES: &'static [::hwcore::bindings::Property] = &[
+                    ::hwcore::bindings::Property {
+                        name: ::std::ffi::CStr::as_ptr(c"flags"),
+                        info: <u32 as ::hwcore::QDevProp>::BIT_INFO,
+                        offset: ::core::mem::offset_of!(DummyState, flags) as isize,
+                        bitnr: 3,
+                        set_default: false,
+                        defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: 0 as u64 },
+                        ..::common::Zeroable::ZERO
+                    }
+                ];
+            }
+        }
+    );
+    // Check that `bit` value is used for the bit property when used:
+    derive_compile!(
+        derive_device_or_error,
+        quote! {
+            #[repr(C)]
+            #[derive(Device)]
+            pub struct DummyState {
+                parent: ParentField<DeviceState>,
+                #[property(bit = 3, default = true)]
+                flags: u32,
+            }
+        },
+        quote! {
+            unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
+                const PROPERTIES: &'static [::hwcore::bindings::Property] = &[
+                    ::hwcore::bindings::Property {
+                        name: ::std::ffi::CStr::as_ptr(c"flags"),
+                        info: <u32 as ::hwcore::QDevProp>::BIT_INFO,
+                        offset: ::core::mem::offset_of!(DummyState, flags) as isize,
+                        bitnr: 3,
+                        set_default: true,
+                        defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: true as u64 },
+                        ..::common::Zeroable::ZERO
+                    }
+                ];
+            }
+        }
+    );
+    // Check that `bit` value is used for the bit property with rename when used:
+    derive_compile!(
+        derive_device_or_error,
+        quote! {
+            #[repr(C)]
+            #[derive(Device)]
+            pub struct DummyState {
+                parent: ParentField<DeviceState>,
+                #[property(rename = "msi", bit = 3, default = false)]
+                flags: u64,
+            }
+        },
+        quote! {
+            unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
+                const PROPERTIES: &'static [::hwcore::bindings::Property] = &[
+                    ::hwcore::bindings::Property {
+                        name: ::std::ffi::CStr::as_ptr(c"msi"),
+                        info: <u64 as ::hwcore::QDevProp>::BIT_INFO,
+                        offset: ::core::mem::offset_of!(DummyState, flags) as isize,
+                        bitnr: 3,
+                        set_default: true,
+                        defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: false as u64 },
+                        ..::common::Zeroable::ZERO
+                    }
+                ];
+            }
+        }
+    );
 }
 
 #[test]
-- 
2.51.0


