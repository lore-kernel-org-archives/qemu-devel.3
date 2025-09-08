Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9B2CAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSd-0006AM-SA; Mon, 08 Sep 2025 06:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSb-00068G-Dl
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSQ-00062p-V7
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8ur6sR5CqLxSkx3WZYXiIVlabjiKb3u0UAioy1JxsI=;
 b=dU62vOaiFKhbXGdcaNCbHq8U9O54cOlYIjZGqtcgcc+CdpHe6XGwmmGHrEB4aLsJ4JdYgg
 FaDAwrmnllIaR/ds23Nlge5KG60vhKPDZVBQ7lZYkm8oinEgTplmNy0nLwDLgbRBWsn0e6
 RuND+fGTYwgdXP0SsYLgE4kN9UpPuIA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-i-XV9Mz7MoGyMstvoyyB6w-1; Mon, 08 Sep 2025 06:50:40 -0400
X-MC-Unique: i-XV9Mz7MoGyMstvoyyB6w-1
X-Mimecast-MFC-AGG-ID: i-XV9Mz7MoGyMstvoyyB6w_1757328639
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45a15f10f31so29698435e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328638; x=1757933438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8ur6sR5CqLxSkx3WZYXiIVlabjiKb3u0UAioy1JxsI=;
 b=TNuc4vji55DBcFUacJdWn4J0c+UAa3JUZIMTxJ0IzLYPA7cYhp1WtVWQRtcu1y2FG3
 GygK15aKiNr4Y9wsQV6yBCJ+KVfUNDhMbNuPH8ftfOxCvi5zE8l7T22rdlS8WniogY+d
 dCYaTK2NA5Xf+uhT9MIsEF+icF459Br8/zjSi/GBNBl9g7POfTmnd2ZdyyiH1vnlT7EA
 MD5uxuJf956F2wGJoB31a08wZzJECwtzZEIDNhQ5hbOedtuS2h4XiUhf6P8zgEqUsdQ+
 nRgO6c6sVmqJSWzkCH3dTqkKXm0Cq9C6jo7dQWBRs/k7wqUCERQitM1YXTKcX2zTiV04
 fKPQ==
X-Gm-Message-State: AOJu0YxbTR7s29ICopZp4sLDKbyIlht/GbIIliihO1MX0t9HYwoA+SeM
 4zF3tj7gzwM5Mk4HZImXHTOhS3lx94c1qCH9mkLEdJIPQ61NanTEY+k1FYm7o/Yau7n7wVPjqOk
 Rtnaf89URu74wvefHYh3kiaIqVFI0GH7Af89QdiogMehnS5pir4GAb21pcD5mWNj5dgrtCczBaQ
 hFQ7IognbRkGDsZ40HSwt7jDWUEH6yWwmoXeDOgR9m
X-Gm-Gg: ASbGncv/rget6bfLchF3PIXWzb/p4rAz0LuJ8bO/cmatl1YEN+W/aWpVnn+7jHPP0hA
 ePMRj0B09M61M/vpJr72nIU6913O+kUX2541xgFylbmSgqv1vPW1NN+NjDOTPLSurvhIDWcIoBt
 bD0XgmPXKcnCSi0kD2HUDU0P60e4/+px702AfIInlcKQxzdjNlIo4JmTTNMZ5h0rsXtGYlLFq9u
 tAVzPlX8EJ0Leeojw/wTkrXlLpwRIGLqJKGPpAvJak2EoEyQvaz/EEwSzduq3bc1m7kmNTjM9cp
 zkCXlwKK4gynFQvqo4FIGK8kTwQdJkWJ/l1LeaTYvWBulNvpLogNviSKo7D41lHIswghcPtLLIq
 G/K8206W2HAlW66Gte5YLXT6uPLViZ5K9NWcsZ2763r4=
X-Received: by 2002:a05:600c:1390:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-45dde1b3265mr63196385e9.8.1757328638529; 
 Mon, 08 Sep 2025 03:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIBBX/NfVSlA80CtYjAn/Nt0R7nJM2/SoETTZceBM/mNE6HHENpB3e8sg9KTAl4DoESrqjcQ==
X-Received: by 2002:a05:600c:1390:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-45dde1b3265mr63196055e9.8.1757328638059; 
 Mon, 08 Sep 2025 03:50:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e12444de96sm16317745f8f.19.2025.09.08.03.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 13/33] rust: move vmstate_clock!() to qdev module
Date: Mon,  8 Sep 2025 12:49:45 +0200
Message-ID: <20250908105005.2119297-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This will allow to split vmstate to a standalone crate next.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-8-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qdev.rs    |  3 +++
 rust/qemu-api/src/vmstate.rs | 14 ++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 436142d8aef..e2b4121cac5 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -17,6 +17,7 @@
     cell::{bql_locked, Opaque},
     chardev::Chardev,
     error::{Error, Result},
+    impl_vmstate_c_struct,
     irq::InterruptSource,
     prelude::*,
     qom::{ObjectClass, ObjectImpl, Owned, ParentInit},
@@ -455,3 +456,5 @@ unsafe impl ObjectType for Clock {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_CLOCK) };
 }
 qom_isa!(Clock: Object);
+
+impl_vmstate_c_struct!(Clock, bindings::vmstate_clock);
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index b5c6b764fbb..59c7950a5aa 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -41,7 +41,6 @@
     callbacks::FnCall,
     errno::{into_neg_errno, Errno},
     prelude::*,
-    qdev,
     qom::Owned,
     zeroable::Zeroable,
 };
@@ -318,21 +317,20 @@ unsafe impl VMState for $type {
 impl_vmstate_scalar!(vmstate_info_uint64, u64);
 impl_vmstate_scalar!(vmstate_info_timer, crate::timer::Timer);
 
+#[macro_export]
 macro_rules! impl_vmstate_c_struct {
     ($type:ty, $vmsd:expr) => {
         unsafe impl VMState for $type {
-            const BASE: VMStateField = $crate::bindings::VMStateField {
-                vmsd: addr_of!($vmsd),
-                size: mem::size_of::<$type>(),
-                flags: VMStateFlags::VMS_STRUCT,
-                ..Zeroable::ZERO
+            const BASE: $crate::bindings::VMStateField = $crate::bindings::VMStateField {
+                vmsd: ::std::ptr::addr_of!($vmsd),
+                size: ::std::mem::size_of::<$type>(),
+                flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
+                ..$crate::zeroable::Zeroable::ZERO
             };
         }
     };
 }
 
-impl_vmstate_c_struct!(qdev::Clock, bindings::vmstate_clock);
-
 // Pointer types using the underlying type's VMState plus VMS_POINTER
 // Note that references are not supported, though references to cells
 // could be allowed.
-- 
2.51.0


