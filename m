Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF54C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiE2-0001ry-69; Fri, 17 Jan 2025 04:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiDz-0001rC-TP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:01:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiDx-00083l-63
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737104464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CL3TI60x6PujqVqUZyFN6Jp1dFCTcnvDg29W8z5vXdA=;
 b=f/wJfXgSfENkhkwtJ880fLgO40CBo3ZRuZNPd0aMGvEFuM9wJmwhPgdBqLPYZC/ObTHLi0
 MN4yq3tdlAnxgcX8sUGwaBMCq0xdkFIo2yq6RFN3jKQXJ1ctuN7+aX+5mcXSG86hetf0Ty
 fKI3r+Q8nxi4RCYJK5EtSBE7rr7GSXM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-_4aKho1oOtSQhpRQ3F7z8w-1; Fri, 17 Jan 2025 04:01:02 -0500
X-MC-Unique: _4aKho1oOtSQhpRQ3F7z8w-1
X-Mimecast-MFC-AGG-ID: _4aKho1oOtSQhpRQ3F7z8w
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab2b300e5daso238025366b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737104461; x=1737709261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CL3TI60x6PujqVqUZyFN6Jp1dFCTcnvDg29W8z5vXdA=;
 b=Z5qLBcB1LgaMsodN8Xb6RSGYOTsNdq8UnrlH1z8QedYEzksKT4nhjJ7aFDSJKpj9qx
 /FaNOKU5F0FwAE8+kXostOKx3a+EfbhJrmiCLh6ZSPKeGQkyKJlQPToF+oTn8JBopcsV
 OO5B4trTTlc3ZG1U+y41nk+rxyVyDGYtR3q04bGEllXeU5OYZ9Hvh3Q+ofEcLyFH0+/J
 +ZgGUI+F/DlDLXv2RqJVLzgj6e1fQkDPlyyQiVD37KVTlatQVa3EVFflfc0MoCWvi2L1
 GyHtMpdjjtkio8DKBkG5JtfKOqJDncVhXtBAJCEbSiYVQZr7/kmS2NBs3vkVqfJMHTu+
 Bfiw==
X-Gm-Message-State: AOJu0Ywsv2pqb1oQN9OjnBKM9y6TM+KJLIoP2MQM0A3tuI7UcaGJtItP
 K/dUk2+4dLWA7ObMbytBdG4yMh+WMP2avtcH2HD2TbKApLgBKYjgEE67TtIG9X8v43tEoUchUhD
 FKMoMXoI1GPrBNWhQUWOXaWk9vBmJhoRimyekCR5PDeKCpDg20phDJqfrgtoePmTpWkyJSK8/W2
 PKRTJ/b/WAosT48D9jLvsAUPkK3PhJ8BjtO2xnWbk=
X-Gm-Gg: ASbGncuHR3lDc4p4eEVFBCFChUYtRpZ5UQR49Kvcv3ASABzQWG3o1mMxCu9fz88yTxj
 4zQo5O7XTLcCxEwxRkZlKas8mYIP4c9iI1N9TY9EUNIBojSPpqryV2LicZjHe4isrtHt9JWetP7
 d7k5sHdEQGuNixoHRY4lDMQS2qE0UnFatM6u6cyKU4pFm9x4PBsqjQTEdUD78qKBN8b+/xPdEzH
 zFY+ByB0oKBldvxjdM20bfMu2F3XQAjMz8kVEYvWZdpivCFZtc00v68fctZ
X-Received: by 2002:a17:907:d1b:b0:aab:cd45:5d3c with SMTP id
 a640c23a62f3a-ab38b3c7729mr176996166b.50.1737104460532; 
 Fri, 17 Jan 2025 01:01:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2xtuKFEQyhaT4qfnZUOyLzwjzCVzPWwIpe1FuAD/FuO/UZ04ZG/uqpK/6mcmqh86Kf+OsDA==
X-Received: by 2002:a17:907:d1b:b0:aab:cd45:5d3c with SMTP id
 a640c23a62f3a-ab38b3c7729mr176992666b.50.1737104460026; 
 Fri, 17 Jan 2025 01:01:00 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce208fsm137249466b.65.2025.01.17.01.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:00:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 04/10] rust: vmstate: implement Zeroable for VMStateField
Date: Fri, 17 Jan 2025 10:00:40 +0100
Message-ID: <20250117090046.1045010-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117090046.1045010-1-pbonzini@redhat.com>
References: <20250117090046.1045010-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This shortens a bit the constants.  Do not bother using it
in the vmstate macros since most of them will go away soon.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs  | 18 +++---------------
 rust/qemu-api/src/zeroable.rs | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 3c3ed8510ab..22a5ed50d4a 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -21,8 +21,8 @@
 
 use core::{marker::PhantomData, mem, ptr::NonNull};
 
-use crate::bindings::VMStateFlags;
 pub use crate::bindings::{VMStateDescription, VMStateField};
+use crate::bindings::VMStateFlags;
 
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
@@ -503,20 +503,8 @@ macro_rules! vmstate_fields {
         static _FIELDS: &[$crate::bindings::VMStateField] = &[
             $($field),*,
             $crate::bindings::VMStateField {
-                name: ::core::ptr::null(),
-                err_hint: ::core::ptr::null(),
-                offset: 0,
-                size: 0,
-                start: 0,
-                num: 0,
-                num_offset: 0,
-                size_offset: 0,
-                info: ::core::ptr::null(),
-                flags: VMStateFlags::VMS_END,
-                vmsd: ::core::ptr::null(),
-                version_id: 0,
-                struct_version_id: 0,
-                field_exists: None,
+                flags: $crate::bindings::VMStateFlags::VMS_END,
+                ..$crate::zeroable::Zeroable::ZERO
             }
         ];
         _FIELDS.as_ptr()
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 6125aeed8b4..57cac96de06 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -49,6 +49,37 @@ unsafe impl Zeroable for crate::bindings::Property {
     };
 }
 
+// bindgen does not derive Default here
+#[allow(clippy::derivable_impls)]
+impl Default for crate::bindings::VMStateFlags {
+    fn default() -> Self {
+        Self(0)
+    }
+}
+
+unsafe impl Zeroable for crate::bindings::VMStateFlags {
+    const ZERO: Self = Self(0);
+}
+
+unsafe impl Zeroable for crate::bindings::VMStateField {
+    const ZERO: Self = Self {
+        name: ptr::null(),
+        err_hint: ptr::null(),
+        offset: 0,
+        size: 0,
+        start: 0,
+        num: 0,
+        num_offset: 0,
+        size_offset: 0,
+        info: ptr::null(),
+        flags: Zeroable::ZERO,
+        vmsd: ptr::null(),
+        version_id: 0,
+        struct_version_id: 0,
+        field_exists: None,
+    };
+}
+
 unsafe impl Zeroable for crate::bindings::VMStateDescription {
     const ZERO: Self = Self {
         name: ptr::null(),
-- 
2.47.1


