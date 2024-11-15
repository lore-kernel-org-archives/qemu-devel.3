Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9E6D68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzNt-0006eu-OJ; Fri, 15 Nov 2024 11:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNZ-0006No-Sz
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:41:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNY-0002MG-CK
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731688863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSsBp8Ew5NQp7MzYfq8I541wWmJ8ybUUCSw8jpZVemg=;
 b=Ay+aAyPhaZrwmGz6fwSRFhUWeO1BJZbax7oW6EHDVPyuPEwW0wsJY2ziAZrRLMsXoJYZkl
 bBsgZpW6FU1e18hva0d7ktuVTXIOwwRBGN+Ge4Cv9JxbSMowGrKyGuhga2DJG0sXMgh/Zm
 jDCoehebBMp8NI7FBMDwwQsTYaKbEAc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-TXtdRpJWOm6cFwpLzoKBaA-1; Fri, 15 Nov 2024 11:41:02 -0500
X-MC-Unique: TXtdRpJWOm6cFwpLzoKBaA-1
X-Mimecast-MFC-AGG-ID: TXtdRpJWOm6cFwpLzoKBaA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d4a211177so1055205f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731688860; x=1732293660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WSsBp8Ew5NQp7MzYfq8I541wWmJ8ybUUCSw8jpZVemg=;
 b=q/wApzbOApqaWvJ8TPkW7BQ83gOlPyw5/szrks8dCKltZvWbB3VTsdVAo2mR1M0LOb
 tW8zy7I7b6/16tOZAbjFaA8n1kp4quOu18zu0lxQygxhyHulQ9Cz+AC3mDNphhrZ07Eq
 p9DnjdnoRQluJjcXz2vCV4VOessTt4jzEk2p5k5u0CvmZ3QM1wxRueUkJmLuq6ZK7iHo
 4gczIml7+Ff0o6NLNSxfeaYZKu7FcwEV6ol8kv1U2RxYIHkx2+arDef2V3aVYOBiHyiN
 6T1jcKC7Wv4uBjXGCZBoKpPrE/NeNMsHTsE+DInFqyA6fIK3MVr/4pQVbbkFCRrnlOAh
 1oJQ==
X-Gm-Message-State: AOJu0YwkwZpyhdtaPTRRqSsLc/X2s4Y7MCcBKYIwlJd380pTzleqblhh
 WZ0ZDo9XCuM3Jx7voVy7roBQVcdtByyK2G53ywARS4qngy7CoTDn63nqujsY4jc5Yb0+c8QE256
 knnQVXk9frqw3xPC+qDxkF+kn6ZRJKD/rt4wd8jAmia3cbXV04gNZ/RofftBjpDJmLlZNJ8vpZG
 FM8G9Jjj09u1EM1tgiTREdJE2JeZ3MFEJPsdEvqd0=
X-Received: by 2002:a05:6000:491d:b0:371:8319:4dbd with SMTP id
 ffacd0b85a97d-382259063b5mr2481232f8f.17.1731688859831; 
 Fri, 15 Nov 2024 08:40:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9ya/7jEKZ7UNJ/r7lIVCPBSxiM5E7y0IXZZfBCxd2cWZmn85OA/9rCUoRJ7zHpXqAREZEcw==
X-Received: by 2002:a05:6000:491d:b0:371:8319:4dbd with SMTP id
 ffacd0b85a97d-382259063b5mr2481214f8f.17.1731688859379; 
 Fri, 15 Nov 2024 08:40:59 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adbbd82sm4777246f8f.52.2024.11.15.08.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:40:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, berrange@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org, kwolf@redhat.com
Subject: [PATCH 08/12] rust: fix a couple style issues from clippy
Date: Fri, 15 Nov 2024 17:40:21 +0100
Message-ID: <20241115164025.1917618-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115163944.1917393-1-pbonzini@redhat.com>
References: <20241115163944.1917393-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

These are reported as clippy::semicolon_inside_block and clippy::as_ptr_cast_mut.

clippy::semicolon_inside_block can be configured not to lint single-line
blocks; just go with the default.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs     | 8 +++++---
 rust/hw/char/pl011/src/memory_ops.rs | 4 +++-
 rust/qemu-api/tests/tests.rs         | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 6556865fc22..e582a31e4d3 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,7 +2,7 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::ptr::{addr_of, addr_of_mut, NonNull};
+use core::ptr::{addr_of_mut, NonNull};
 use std::{
     ffi::CStr,
     os::raw::{c_int, c_uchar, c_uint, c_void},
@@ -499,7 +499,9 @@ pub fn update(&self) {
         let flags = self.int_level & self.int_enabled;
         for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
             // SAFETY: self.interrupts have been initialized in init().
-            unsafe { qemu_set_irq(*irq, i32::from(flags & i != 0)) };
+            unsafe {
+                qemu_set_irq(*irq, i32::from(flags & i != 0));
+            }
         }
     }
 
@@ -601,7 +603,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
         let sysbus: *mut SysBusDevice = dev.cast::<SysBusDevice>();
 
         qdev_prop_set_chr(dev, c_str!("chardev").as_ptr(), chr);
-        sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *mut Error);
+        sysbus_realize_and_unref(sysbus, addr_of_mut!(error_fatal));
         sysbus_mmio_map(sysbus, 0, addr);
         sysbus_connect_irq(sysbus, 0, irq);
         dev
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
index 169d485a4d2..c4e8599ba43 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -33,7 +33,9 @@
             // SAFETY: self.char_backend is a valid CharBackend instance after it's been
             // initialized in realize().
             let cb_ptr = unsafe { core::ptr::addr_of_mut!(state.as_mut().char_backend) };
-            unsafe { qemu_chr_fe_accept_input(cb_ptr) };
+            unsafe {
+                qemu_chr_fe_accept_input(cb_ptr);
+            }
 
             val
         }
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 43a4827de12..925f5a3c77b 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -74,6 +74,6 @@ impl Class for DummyClass {
 
     unsafe {
         module_call_init(module_init_type::MODULE_INIT_QOM);
-        object_unref(object_new(DummyState::TYPE_NAME.as_ptr()) as *mut _);
+        object_unref(object_new(DummyState::TYPE_NAME.as_ptr()).cast());
     }
 }
-- 
2.47.0


