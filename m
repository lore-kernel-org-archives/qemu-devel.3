Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF22C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibey-0000ys-T1; Thu, 13 Feb 2025 11:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibei-0000sb-Fc
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibee-0005W1-1m
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjaNShE0GYpF6KF1Wxl7XEXpF6pZfvD+oUSQf7rKQdY=;
 b=VFuMITx5N6RXVxdudLuL6NQb5P0dvPAi+zr8YkkQUw2gUeid9KvIBkPrBN38j84SkNpQJ6
 M70xhH70ap/D5yiBjkjfnBFHepa1e5OjWhFJ04mejgnMMt9tXWLkdv5PwPAywRrVNvoxI8
 PIMTpRODTdGAqHH51+QMOfOL7CaF4DA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-EExo55gHMhGJdRKV9yLThQ-1; Thu, 13 Feb 2025 11:01:28 -0500
X-MC-Unique: EExo55gHMhGJdRKV9yLThQ-1
X-Mimecast-MFC-AGG-ID: EExo55gHMhGJdRKV9yLThQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4394b2c19ccso8359735e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462486; x=1740067286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjaNShE0GYpF6KF1Wxl7XEXpF6pZfvD+oUSQf7rKQdY=;
 b=RCC2dM3BwDbMERS7bCFYAgZ55a7MqoyxWqVPBynAyfmR29CJ0ggowGxrSm2Q0j5Y9g
 ovXdQ/ujxwnFu2+XEJoo7ebaUU9ziwwh8MriFFgzYaPuK2F6+Rn5O9A555oAi0IOo0rf
 VqXZDSUcVCyQm4TQHZGGKxKvv9UkgYVjdhhNggS63lDm2sTQMxrNZ4DxiMBeaNQjJ3sl
 RFFIQ5RsfwELGdmOFRj16grJ0+hEkCz5/shKRr8IPrC9ynyG15JUUBZLlFNTCEQGMSxE
 mvVivRYELBoRXJtwnFpNpT7PhH2uq7Ti7wG23lspRsmclgCAdeOkP2mYC0W899Mm/DSY
 amsw==
X-Gm-Message-State: AOJu0YyW66m5G+60ls+MHLnMRWZjnmFn8pxrzoIOUZST3RXyUM/bdHVd
 OX0edMriHLz4OstDK3QiXrN0KyjD4HGDqu+7K1W1jORJPiCwWEriSKzHf5GnxR9pqj06YbJkqWM
 ZkQFeoG/cAwsJUVfCLtnSWxKMlMnRyTU1rlu1AH9lN9CIbMGjuJUWOTHUjAHFZ4+hFRpa0u5sMD
 0O+5OXdzvXP49ttN6MF2snJpjdTK6Q09ZFbdXABgE=
X-Gm-Gg: ASbGnct/Kebr06yzTO+8YRcUf1XblGaKwi53lya5M92m+mwa7skkjKuz01FLL/gSrIl
 xRYuXTLAgPdb2zyS9GSBZfrQBmrbV/jnmX46mYUhbwG41xo7V0Kagy2Pw4TM5G4CysdRoAaxsIY
 U7Rxv+hGpF+tpZNy1YbLJtWbjM+GDIp7wtfrIcKzTGicYR+dmjakp6ex7SpsH9YzMWjpGDjykzQ
 85sCLlzJJc28fCK0yfaE88ev2fD1fbnHrDHFgmRJRXSrlbd0OnXS9p4iqR0GhLnEErlqhmcm+0R
 MP3y7uFVqZ0VjAlxODuNDXpDAAt4YdUum45RaqZMI8tUeg==
X-Received: by 2002:a05:600c:6986:b0:439:4700:9eba with SMTP id
 5b1f17b1804b1-43960185ed6mr51795515e9.2.1739462484175; 
 Thu, 13 Feb 2025 08:01:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm8uVhA9hdM53H9GG/NzdknnS4BRr+dYopbimP7mYSDM/NQiZVZ5Z+N6J0R2xcVa0IJfR/yA==
X-Received: by 2002:a05:600c:6986:b0:439:4700:9eba with SMTP id
 5b1f17b1804b1-43960185ed6mr51793375e9.2.1739462481813; 
 Thu, 13 Feb 2025 08:01:21 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43961e07252sm20137425e9.14.2025.02.13.08.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 09/27] rust: bindings: add Send and Sync markers for types that
 have bindings
Date: Thu, 13 Feb 2025 17:00:36 +0100
Message-ID: <20250213160054.3937012-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is needed for the MemoryRegionOps<T> to be declared as static;
Rust requires static elements to be Sync.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs | 46 +++++++++++++++++++++++++++++++++++
 rust/qemu-api/src/irq.rs      |  3 +++
 2 files changed, 49 insertions(+)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 8a9b821bb91..b71220113ef 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -21,9 +21,55 @@
 #[cfg(not(MESON))]
 include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
 
+// SAFETY: these are implemented in C; the bindings need to assert that the
+// BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
+unsafe impl Send for BusState {}
+unsafe impl Sync for BusState {}
+
+unsafe impl Send for CharBackend {}
+unsafe impl Sync for CharBackend {}
+
+unsafe impl Send for Chardev {}
+unsafe impl Sync for Chardev {}
+
+unsafe impl Send for Clock {}
+unsafe impl Sync for Clock {}
+
+unsafe impl Send for DeviceState {}
+unsafe impl Sync for DeviceState {}
+
+unsafe impl Send for MemoryRegion {}
+unsafe impl Sync for MemoryRegion {}
+
+unsafe impl Send for ObjectClass {}
+unsafe impl Sync for ObjectClass {}
+
+unsafe impl Send for Object {}
+unsafe impl Sync for Object {}
+
+unsafe impl Send for SysBusDevice {}
+unsafe impl Sync for SysBusDevice {}
+
+// SAFETY: this is a pure data struct
+unsafe impl Send for CoalescedMemoryRange {}
+unsafe impl Sync for CoalescedMemoryRange {}
+
+// SAFETY: these are constants and vtables; the Send and Sync requirements
+// are deferred to the unsafe callbacks that they contain
+unsafe impl Send for MemoryRegionOps {}
+unsafe impl Sync for MemoryRegionOps {}
+
 unsafe impl Send for Property {}
 unsafe impl Sync for Property {}
+
+unsafe impl Send for TypeInfo {}
 unsafe impl Sync for TypeInfo {}
+
+unsafe impl Send for VMStateDescription {}
 unsafe impl Sync for VMStateDescription {}
+
+unsafe impl Send for VMStateField {}
 unsafe impl Sync for VMStateField {}
+
+unsafe impl Send for VMStateInfo {}
 unsafe impl Sync for VMStateInfo {}
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 378e5202951..638545c3a64 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -43,6 +43,9 @@ pub struct InterruptSource<T = bool>
     _marker: PhantomData<T>,
 }
 
+// SAFETY: the implementation asserts via `BqlCell` that the BQL is taken
+unsafe impl<T> Sync for InterruptSource<T> where c_int: From<T> {}
+
 impl InterruptSource<bool> {
     /// Send a low (`false`) value to the interrupt sink.
     pub fn lower(&self) {
-- 
2.48.1


