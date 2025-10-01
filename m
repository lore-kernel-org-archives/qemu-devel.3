Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C4BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rdq-0006bl-2j; Wed, 01 Oct 2025 03:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdm-0006af-Ck
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdb-00037C-BC
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4rzyy18VHCroAiugvOh6Z84T0tr26zY/aqtmKDiKlo=;
 b=THoDpBlPjRfRjbaFgLR+KcaNB79+iNz0YFC/y0ejkvW7D1gox4s4cyduux7vYOwuCH2qne
 pl5I/Da0llvafYcTDyPxvqHXDk40EUmlVt4eERJQFKiYWU7021Zq4k+ceDRSzhIuTK90mO
 GyR2E4usFp0asgEImVpoefmRLXC0mRQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-9LqYuJDSOEGJ4OW_m2sYBQ-1; Wed, 01 Oct 2025 03:52:25 -0400
X-MC-Unique: 9LqYuJDSOEGJ4OW_m2sYBQ-1
X-Mimecast-MFC-AGG-ID: 9LqYuJDSOEGJ4OW_m2sYBQ_1759305144
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3afaf5defdso519805466b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305143; x=1759909943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4rzyy18VHCroAiugvOh6Z84T0tr26zY/aqtmKDiKlo=;
 b=O9fbxFjgXgC7b02q4Y5o7M9PdYu/pqzCaMHtrfyhuRTWRqY3OpCq/SHdAFf3J+bPvh
 q3iZtVAOGL66pozvdV1CHXEtThKuNVBk061cQoVyiVEjPns9OL/E9uEfrRB/4Dkse+F2
 Ps5GlXR6V53O8MY11u7W+bA29V49yh3dnUL/8s+9UEz3X6oVAfvwBeWT6J6IQbHhrMMV
 9yx7tv40YnFGx40TqdGsQRArjCqPIgnxUCEPwZXtTYQ+ZN5Wfr7PXlGkU8ck4Tq4rqQA
 DpP5Ig3mLJohI/XMFX2MYrqTiHihB47tzb9lBWoFitlccuOyk4JEeGO/Ywk1mtkdg6tl
 pZFA==
X-Gm-Message-State: AOJu0YxHBVUaljJuk+IhH1Mb62rkUZnbHjG5A8LvabXgYwIaG577oGaX
 HaZog6qWmw4oNvDacVO4q9C76QP7rVB28QbxBniOH7iRl5bZb6WTYMZiqPjuH96x3QELqokGsjM
 o8JkGFt2BkTvhX+Blx/oqUNCPHpIPsh7faCIfqG47C/IifX4IRciCd1tJpeDCxOpukmPefE7170
 Tozbq7Rvza0dJa0xZ5Vc/z1v00AIaqaywpRUIRUZqc
X-Gm-Gg: ASbGnct0Qnb3HJx5pi9VUjfiToYeudP2MrY2FFfR1S52MkUI5rwscKD7efx/rMkyMLG
 hGfmrs/EzcCdg+L0t85WyBfGdu8P3AbmQYPnxFUoa2LzvjfsTWbAr5/oQW7KLV3qyyOQlcq8xUn
 z4vw9A+HYREraqYHg+jpbRpqL15waRhzXAIJggAio7Vl9Z5lJTejcI97sRtLFNMsWCBv0wQUf8T
 KUp/T2ss6wNIMXevmdv2GRmsoOyS4QJK5quMCCneDGUxwM/Yp9H02R9M90ArF6avs74lJt2jPWV
 8fXaXjQ9T7QV/AIeqibvlY/I0S7BEmvGjEE1TlnApygWG/daOgJnsqRgcLUPH8blrSZoLK/5rKQ
 eLujZhMgVtWX/+r7uW3WxSm9dbagORbNyIlIcagt8aVkRrJ9hfZ8=
X-Received: by 2002:a17:907:3d42:b0:b3e:6091:2c65 with SMTP id
 a640c23a62f3a-b46e985e14fmr268585666b.56.1759305143489; 
 Wed, 01 Oct 2025 00:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHymp+6WpTG2+RiYNFl0x5QoJMeZpU8gXIKoVmVWLD63yv1NnU0AMT+b93OHX1Z9EJRVvReog==
X-Received: by 2002:a17:907:3d42:b0:b3e:6091:2c65 with SMTP id
 a640c23a62f3a-b46e985e14fmr268581866b.56.1759305143017; 
 Wed, 01 Oct 2025 00:52:23 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3f575aa299sm557064466b.50.2025.10.01.00.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:52:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/11] rust: migration: extract vmstate_fields_ref
Date: Wed,  1 Oct 2025 09:52:04 +0200
Message-ID: <20251001075210.1042479-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The separate macros are needed because you cannot just do

                 .fields(vmstate_fields_ref! {
                      vmstate_of!(PL011State, clock),
                 })

The value returned by vmstate_fields_ref! is not promoted to static, which is
unfortunate but intentional (https://github.com/rust-lang/rust/issues/60502):

error[E0716]: temporary value dropped while borrowed
   --> rust/hw/char/pl011/libpl011.rlib.p/structured/device.rs:743:17
    |
738 | /      VMStateDescriptionBuilder::<PL011State>::new()
739 | |          .name(c"pl011/clock")
740 | |          .version_id(1)
741 | |          .minimum_version_id(1)
742 | |          .needed(&PL011State::clock_needed)
743 | |          .fields(vmstate_fields_ref! {
    | | _________________^
744 | ||              vmstate_of!(PL011State, clock),
745 | ||         })
    | ||_________^- argument requires that borrow lasts for `'static`
    |  |_________|
    |            creates a temporary value which is freed while still in use
746 |            .build();
    |                   - temporary value is freed at the end of this statement

Thus it is necessary to use the "static", whether explicitly or hidden by
vmstate_fields.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 22799dffdc7..2900ef1127a 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -411,19 +411,30 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
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
         _FIELDS
     }}
 }
-- 
2.51.0


