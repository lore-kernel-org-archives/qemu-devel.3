Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F42C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRl-0007Wa-5X; Fri, 21 Feb 2025 12:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRi-0007H0-7G
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRg-0001TU-20
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptln7kC4VQ55Kh7p6OYpuJx9dpz1kCK9KqyudGJngSI=;
 b=LEIdMg34iOcZ7RGUDOwuVdUI+6guYG8Gt4MtjfGJ/Q3yNo6NcV3TD8NoKGit+LKJuyAyiL
 J1khO2HzPDZAYNqiyh7iRsBjbXK6R6fOiKK76+wnEvFQ5varO34LK35oJG5kssGgRENmPQ
 eenOsR7aT3gY0ctJ1/rBq2Aw0qKIc4A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-9XF-9xH5MmK7xmNNdEl6BA-1; Fri, 21 Feb 2025 12:04:09 -0500
X-MC-Unique: 9XF-9xH5MmK7xmNNdEl6BA-1
X-Mimecast-MFC-AGG-ID: 9XF-9xH5MmK7xmNNdEl6BA_1740157448
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43942e82719so15904815e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157447; x=1740762247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptln7kC4VQ55Kh7p6OYpuJx9dpz1kCK9KqyudGJngSI=;
 b=tCyBFzzdzz7lxpscndfjbTr/TxHqRTytR+VQJcTkRRESeA6uGwy9IMy2F5g1xl/R5o
 OIp0vrE5rRovZzPPCJrCLJSP05tNQxhU8aAmiYQgnMhJI3Wv9ntHmRI7yxtTaOH6Okia
 PTqFxBjxq4+3/FuAWzU8no2eMy5xg3Nm7tzYLtVRBGcF/EWOf8ArhU4W/b6o4XrV57qZ
 dfyAYgdDo8HCvDHU3e5gYGF3jgWnDdxGUXI8J1pn9feUZEK3OYMOl6IUOUbJasCc8mT1
 3zRGH8dyd+KvvU3GD9hVTP5urIa7xFjK90lQitoWQ41C0YpIXwncGxvvEc4aEYlmGBDH
 YJ4g==
X-Gm-Message-State: AOJu0YwiH8ZHB7aQQLn3o8tnFjAvODDZeAFpsf0UIiVsiNuNA7otpTns
 zM4t7DHYWLCJ732/xKcqEugQpFOTfKTOuEiGlk8v2CZcnhcL4NJlgj1g3HYtsxb1u073xJvlNFg
 jEaRVOTESFo3t4/ygu49yWiOmnfl56kdbGp5AxPSHN0We2gBmRgcRarIssxBrmu9W48mDLFsLAP
 zRRdl/3P8tHK3OQJEHTgXIM/Xx3eRs4TGonO4Q2a8=
X-Gm-Gg: ASbGncuv1vfKkyrhocRmNq5FAiaefExgIeQnIHQgc6JJsJqAfthPCrGhFZkaPXFlruJ
 79Qs8NfjTigwl5aEcPpp/YhyQzrXBugoXvk8oyyf4n5GH0kWPJJQ0J1k10bL5MdILwPNzZwsIRL
 ywoFdRpC8enSeiLfUy8XKE0+VmgF4UsdUnQhUJNqwQysCxP41DuSpwoMyjjnijFfPLHwZG1qrtV
 OaaapK+2SyZRYmZqxb3MzpwYk64Jt0EwgyR9RPqFHTxbVD7XcxBL6rwR5fgxETE5+u/iGg+ctbs
 IkeubuSURQZrhHHq34s=
X-Received: by 2002:a05:600c:1c9d:b0:439:88bb:d02f with SMTP id
 5b1f17b1804b1-439b1b7fdfamr27090305e9.5.1740157446934; 
 Fri, 21 Feb 2025 09:04:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5lQklDkjGCKQ5dzNMU7dIqrOWUiGmo7zLHwx/J7q+hv1FUD3/VB0Q4LzK4MqDgH6vbWTClQ==
X-Received: by 2002:a05:600c:1c9d:b0:439:88bb:d02f with SMTP id
 5b1f17b1804b1-439b1b7fdfamr27089635e9.5.1740157446414; 
 Fri, 21 Feb 2025 09:04:06 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b44b2sm23583763f8f.20.2025.02.21.09.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:04:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 09/15] rust: irq: wrap IRQState with Opaque<>
Date: Fri, 21 Feb 2025 18:03:36 +0100
Message-ID: <20250221170342.63591-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170342.63591-1-pbonzini@redhat.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/irq.rs    | 15 ++++++++++-----
 rust/qemu-api/src/sysbus.rs |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index d1c9dc96eff..aec2825b2f9 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -9,10 +9,16 @@
 
 use crate::{
     bindings::{self, qemu_set_irq},
+    cell::Opaque,
     prelude::*,
     qom::ObjectClass,
 };
 
+/// An opaque wrapper around [`bindings::IRQState`].
+#[repr(transparent)]
+#[derive(Debug, qemu_api_macros::Wrapper)]
+pub struct IRQState(Opaque<bindings::IRQState>);
+
 /// Interrupt sources are used by devices to pass changes to a value (typically
 /// a boolean).  The interrupt sink is usually an interrupt controller or
 /// GPIO controller.
@@ -22,8 +28,7 @@
 /// method sends a `true` value to the sink.  If the guest has to see a
 /// different polarity, that change is performed by the board between the
 /// device and the interrupt controller.
-pub type IRQState = bindings::IRQState;
-
+///
 /// Interrupts are implemented as a pointer to the interrupt "sink", which has
 /// type [`IRQState`].  A device exposes its source as a QOM link property using
 /// a function such as [`SysBusDeviceMethods::init_irq`], and
@@ -41,7 +46,7 @@ pub struct InterruptSource<T = bool>
 where
     c_int: From<T>,
 {
-    cell: BqlCell<*mut IRQState>,
+    cell: BqlCell<*mut bindings::IRQState>,
     _marker: PhantomData<T>,
 }
 
@@ -80,11 +85,11 @@ pub fn set(&self, level: T) {
         }
     }
 
-    pub(crate) const fn as_ptr(&self) -> *mut *mut IRQState {
+    pub(crate) const fn as_ptr(&self) -> *mut *mut bindings::IRQState {
         self.cell.as_ptr()
     }
 
-    pub(crate) const fn slice_as_ptr(slice: &[Self]) -> *mut *mut IRQState {
+    pub(crate) const fn slice_as_ptr(slice: &[Self]) -> *mut *mut bindings::IRQState {
         assert!(!slice.is_empty());
         slice[0].as_ptr()
     }
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 04821a2b9b3..48803a655f9 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -79,6 +79,7 @@ fn mmio_map(&self, id: u32, addr: u64) {
     fn connect_irq(&self, id: u32, irq: &Owned<IRQState>) {
         assert!(bql_locked());
         let id: i32 = id.try_into().unwrap();
+        let irq: &IRQState = irq;
         unsafe {
             bindings::sysbus_connect_irq(self.as_mut_ptr(), id, irq.as_mut_ptr());
         }
-- 
2.48.1


