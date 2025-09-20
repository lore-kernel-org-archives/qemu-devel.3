Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5247CCAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzybQ-0007Hs-UU; Sat, 20 Sep 2025 10:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybO-0007Gw-97
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybM-0005S6-Dj
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758378611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0J9X0otTLwkzasLt1UDH9KlN9sxJ9cBWuhH6pKrvTE=;
 b=NLlOFUX9QTS0pxVGp4oNTu8sOuVwOz+nNs+n8ZPr9aWj7Bl6HCAvFPC1Cf2BY4GReCrRWl
 W9UWpGS24dbPXFeQx6SNFwJaVLQ2lD+G47J9SwoVyulFMegwyqo+npmSCN+fNyLj6mftcz
 +A943hhvisxykBhdjXRVJ4ugB0n7sVA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-kmII5KM-NnOINQYjoSfDMg-1; Sat, 20 Sep 2025 10:30:10 -0400
X-MC-Unique: kmII5KM-NnOINQYjoSfDMg-1
X-Mimecast-MFC-AGG-ID: kmII5KM-NnOINQYjoSfDMg_1758378609
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45f2b9b99f0so932725e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 07:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758378608; x=1758983408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y0J9X0otTLwkzasLt1UDH9KlN9sxJ9cBWuhH6pKrvTE=;
 b=RD4KyRk6YEpf0NwxML9rjmuDuoPN65PdYIkUVLAdK7cxnnnF9KK1DexhMqprS3mURd
 3H3B1PLm7WvJHnlLmeXC/uJ7WDKWnK9azdWjRHgakbD7srljUwonNPW6BlVZaBxUp5zn
 nepO+rqhavvxVghjAwNG8SzNAl52nXDdSuQeE6GqK8t1Z28T6dOc9Yw0BCEr2iHOidC8
 fj+4BbytbalxkJtRd5reV8EsTnG4VohpV61N6JU7SQPVTKh1yDi5nqNdm2Kzm5KidZ39
 5zMO3li0gbe+EWBIPbtTuXhRBLvCUr7oD6hhgYgOfeGvFZnLBuI5Cr05x1bFaTQxXjT8
 1AVg==
X-Gm-Message-State: AOJu0YyEJPO5KKNfGn4GB8Ufh9PLhsnVbfAArVjthvdyNgttaWB9ZD2M
 WA/3yuK3qH9l48oqGD8n2Qa6opCtDkXstWp07TKQNBfql9writPyPoLaY6YQ6AuobAlyBuzViQy
 /uY359CeUurlSh2/XL5mi+Xa/RXow2b8Q/IdXXI0Fk2vPkMD0eBXQuKyuQucOLOOs8oMgq7Hhx+
 s3RmriaEMq1rOLq6LvxzW35r+7mVrCAJCVJgmHiBbB
X-Gm-Gg: ASbGncuEvHXSnBCJgvneNiyRD08sAPKlabSI+azHOAbXOeWuRNpCyn9pplHuy7PBwPL
 L7TU/h05adCspWjll1YNGJVwG1Q+ip5YEdB5UhFrjlcbvt6LGPLo3GWcStT94LpLIG1sv1WDEcG
 R90m7tERYLmQhO4hguRTtX5+e/dJpuSnF3eum9Ugpv2tF1D1i8RbaPe2CflF/tmfgKiMqhOZWJ1
 fcIaNpMvocMjJKrUvr8SL4la9aiLnV8jl+wS7dAoIncOzz5f4DUrAJr7iZYcFTs6vslu1rxERq9
 Qtg/qGdcmvLdiwnF8c3XhbFJFajhW/4ZadTa6v1SIvP12uF0rk7sNe1jv9GcqGIOxpHU3NqNQYf
 beaW3rmeIoeLhXks7ytXJ+sm0jvHNSoEE0KVfF5U+KjI=
X-Received: by 2002:a05:600c:34c8:b0:45b:8b95:7119 with SMTP id
 5b1f17b1804b1-464f81642e8mr114252285e9.8.1758378608032; 
 Sat, 20 Sep 2025 07:30:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfhatReDU9ArBw+DDqbbFgu0vDxDVZRAp48hqeXuZBgwvm6fdJ6o4wpAJAY0O0Bz46Q6z3mQ==
X-Received: by 2002:a05:600c:34c8:b0:45b:8b95:7119 with SMTP id
 5b1f17b1804b1-464f81642e8mr114252005e9.8.1758378607504; 
 Sat, 20 Sep 2025 07:30:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613e09f879sm166476175e9.19.2025.09.20.07.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:30:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, zhao1.liu@intel.com, manos.pitsidianakis@linaro.org
Subject: [PATCH 3/7] rust: migration: extract vmstate_fields_ref
Date: Sat, 20 Sep 2025 16:29:54 +0200
Message-ID: <20250920142958.181910-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920142958.181910-1-pbonzini@redhat.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is useful when building a VMState for generic structs, because you have
to avoid nested statics.  Using vmstate_fields! will fail in the likely case
where the _FIELDS static uses Self from an outer item, because that is
forbidden.

I also looked into returning a &'static [VMStateField] from vmstate_fields!,
but that also fails; the fields are not promoted to static, which is
unfortunate but intentional (https://github.com/rust-lang/rust/issues/60502):

error[E0716]: temporary value dropped while borrowed
   --> rust/hw/char/pl011/libpl011.rlib.p/structured/device.rs:743:17
    |
738 | /      VMStateDescriptionBuilder::<PL011State>::new()
739 | |          .name(c"pl011/clock")
740 | |          .version_id(1)
741 | |          .minimum_version_id(1)
742 | |          .needed(&PL011State::clock_needed)
743 | |          .fields(vmstate_fields! {
    | | _________________^
744 | ||              vmstate_of!(PL011State, clock),
745 | ||         })
    | ||_________^- argument requires that borrow lasts for `'static`
    |  |_________|
    |            creates a temporary value which is freed while still in use
746 |            .build();
    |                   - temporary value is freed at the end of this statement

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 05a833a8b7d..421a236194d 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -413,19 +413,30 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
     }};
 }
 
+/// Add a terminator to the fields in the arguments, and return
+/// a reference to the resulting array of values.
+#[macro_export]
+macro_rules! vmstate_fields_ref {
+    ($($field:expr),*$(,)*) => {
+        &[
+            $($field),*,
+            $crate::bindings::VMStateField {
+                flags: $crate::bindings::VMStateFlags::VMS_END,
+                ..::common::zeroable::Zeroable::ZERO
+            }
+        ]
+    }
+}
+
 /// Helper macro to declare a list of
 /// ([`VMStateField`](`crate::bindings::VMStateField`)) into a static and return
 /// a pointer to the array of values it created.
 #[macro_export]
 macro_rules! vmstate_fields {
     ($($field:expr),*$(,)*) => {{
-        static _FIELDS: &[$crate::bindings::VMStateField] = &[
+        static _FIELDS: &[$crate::bindings::VMStateField] = $crate::vmstate_fields_ref!(
             $($field),*,
-            $crate::bindings::VMStateField {
-                flags: $crate::bindings::VMStateFlags::VMS_END,
-                ..::common::zeroable::Zeroable::ZERO
-            }
-        ];
+        );
         _FIELDS.as_ptr()
     }}
 }
-- 
2.51.0


