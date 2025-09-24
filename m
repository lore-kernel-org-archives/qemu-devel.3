Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1130CAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lop-00055z-HJ; Wed, 24 Sep 2025 05:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Loh-0004tG-QM
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lof-0004oE-4e
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrETRcAm62saupPnRfR+kklTa3hHwGRAVoeNUg91XF8=;
 b=CRbP3ZJvshzuNt+lIn4OLrX5mYCwzjwPILh94ZwWWu5QXTw87JIQjFqPitlYLYlzKkAMJM
 go1A98hhZXv6XL1MRupvgC0iEN8awHomjdjbpzIw2dKeFm501VgMne+aYPL55coV+BSEAd
 54kE1EzP1deILedINXPF+WPTYHNUF68=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-J1SAo9IJOay2hwtMGmL7fg-1; Wed, 24 Sep 2025 05:29:32 -0400
X-MC-Unique: J1SAo9IJOay2hwtMGmL7fg-1
X-Mimecast-MFC-AGG-ID: J1SAo9IJOay2hwtMGmL7fg_1758706172
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b07c2924d53so317594866b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706171; x=1759310971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rrETRcAm62saupPnRfR+kklTa3hHwGRAVoeNUg91XF8=;
 b=Ll0nBNw/6ob788WPmwYUyKhm9K9AeI5zlLBcEpWw+QWD+Z+5Gpm4X/fTqt5QrxiIQL
 1+SOC5DoXnci0XrnIl0U0KFWOquQDGvmz1Yffl/xWv3ShmJieHxPUQ0TjE0neIXH6M+R
 EKAWUY2sIOTC9roS0KqQZYTwwQ6JHCR/0bwlpOuM45ZRXHvPaFekDm/Xm0bAOioVvGbU
 2zrweOVU8ST3luJxzfE9epA9H9prK3qDz0qcJkvNIs7orMq78qKCV8EBvXsbXem89p5z
 J0xQnkSXdE/Ogq59nEOpfnvKiORRiYzUVZU91a4hsWAZumYF1uJtIBQkrGJg0rvhyQ9n
 ApVA==
X-Gm-Message-State: AOJu0YzEoaGT5/LpaVKRE39FB3xJ5+CNR9mt0Pub1zaiVEAiUbeCnggO
 cWprm82ybUkw1vd1tX3YkqjSCWNIIuKvU/TO90mCYL0u8lbGqCK71X1wKTG0oNMBKVlCR09LB7L
 bwrb8w2CvVMTXWFcJUGw/hSpUc40yhpHb0HC1KWL/8iXYU0xUAJIRM/dlGA5VseBuLkEU089cIC
 EXOXt0fDkhsnk6kByML9i9Iqe4A1y1ohuXTcZ/rFOH
X-Gm-Gg: ASbGncu4+75+2IBlcPAsM+Hdlgt/LwGzBZSA239YwzBSE70T044NA0VR+o66S4X4Zfz
 Jv3sYZcF8Z3j9Mk3aVz4FxVhmV71pZoqWMmO7cv/Bcy/z2ybAkl4E/Gd3TIgcdtlzf3A3/uQD0R
 oX4E+E1dBZGKOX68sPTQYF26mHi8OZoUxR6yiuH1SzbKnnAZxWxrc/BhQGSAzDNnvLFRHnfgdzj
 MgKKUoenTKJxWU0iba2qPMpHImmqE/rqMLpLKUx0Z3gMythECcyilkTXOT6nZKx+Msrs6r5lUlX
 PfaMTxrFOU/XlFznFiBo2AYDFVgCdmhPxWUVid5RREegQkfiGSjQpW+VmhBuYnp7Ks5DKJhIfP/
 x8TN1RKX5AMCdvax3PaQyOoegGaM1xuC/20LuoHzKlJbjFg==
X-Received: by 2002:a17:907:9486:b0:b0c:5929:4cff with SMTP id
 a640c23a62f3a-b3027d3e801mr547639666b.26.1758706170804; 
 Wed, 24 Sep 2025 02:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXN3snPdzdMyH+o0Lti3iJvD4aab2yra2EmLI78qCqzCalagpUQF33ZLYoBqQdXYVll6dePg==
X-Received: by 2002:a17:907:9486:b0:b0c:5929:4cff with SMTP id
 a640c23a62f3a-b3027d3e801mr547637066b.26.1758706170371; 
 Wed, 24 Sep 2025 02:29:30 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62fa5d4189bsm12451913a12.19.2025.09.24.02.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 13/29] rust/qdev: Support property info for more common types
Date: Wed, 24 Sep 2025 11:28:33 +0200
Message-ID: <20250924092850.42047-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a helper macro to implement QDevProp trait for u8/u16/u32/usize/i32
/i64.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20250920160520.3699591-8-zhao1.liu@intel.com
---
 rust/hw/core/src/qdev.rs | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 2735e2b2c10..85422e0379e 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -134,20 +134,24 @@ pub unsafe trait QDevProp {
     const VALUE: *const bindings::PropertyInfo;
 }
 
-/// Use [`bindings::qdev_prop_bool`] for `bool`.
-unsafe impl QDevProp for bool {
-    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_bool);
+macro_rules! impl_qdev_prop {
+    ($type:ty,$info:ident) => {
+        unsafe impl $crate::qdev::QDevProp for $type {
+            const VALUE: *const $crate::bindings::PropertyInfo =
+                addr_of!($crate::bindings::$info);
+        }
+    };
 }
 
-/// Use [`bindings::qdev_prop_uint64`] for `u64`.
-unsafe impl QDevProp for u64 {
-    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_uint64);
-}
-
-/// Use [`bindings::qdev_prop_chr`] for [`chardev::CharBackend`].
-unsafe impl QDevProp for chardev::CharBackend {
-    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_chr);
-}
+impl_qdev_prop!(bool, qdev_prop_bool);
+impl_qdev_prop!(u8, qdev_prop_uint8);
+impl_qdev_prop!(u16, qdev_prop_uint16);
+impl_qdev_prop!(u32, qdev_prop_uint32);
+impl_qdev_prop!(u64, qdev_prop_uint64);
+impl_qdev_prop!(usize, qdev_prop_usize);
+impl_qdev_prop!(i32, qdev_prop_int32);
+impl_qdev_prop!(i64, qdev_prop_int64);
+impl_qdev_prop!(chardev::CharBackend, qdev_prop_chr);
 
 /// Trait to define device properties.
 ///
-- 
2.51.0


