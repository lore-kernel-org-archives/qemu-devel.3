Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109BBC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDwo-000859-5w; Sun, 09 Mar 2025 06:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwm-00084Y-2X
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwk-00042I-It
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8+l2RbHUK94td6RHPrgOYB0tXiyNEPAhvV3YsF6B9k=;
 b=evo3a0egDcrh3kaxrGybjQ+03YrcuZVshIaRnDc4t1fjcOISdNsI4loihiV6sMtUKF6v2f
 wcuiQPzHbuaJNsvj8alrGldjuQS9Fgi8H1LzxBQoT2xID8kCuxMLKAh2iMlRK2+4lEskUx
 sYzH6j5x4tWg2bMSl4hSabSIwu44xWo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-2nFxXlSvOdWG2td_cu31Ow-1; Sun, 09 Mar 2025 06:31:48 -0400
X-MC-Unique: 2nFxXlSvOdWG2td_cu31Ow-1
X-Mimecast-MFC-AGG-ID: 2nFxXlSvOdWG2td_cu31Ow_1741516307
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43bdfb04bffso21110315e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516307; x=1742121107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8+l2RbHUK94td6RHPrgOYB0tXiyNEPAhvV3YsF6B9k=;
 b=d6ju6POHZAmYeFzJ67tGcdYZiLJVG2vj/tLVcy7GAbvm62x46Axc3IadlMl7L1O5C8
 HQ70EOfSxt1/p1VfYmUkyhb+wIOrISHSqkRPv6K37vdVlZJUR2UZx8KM5aSKS0GU2RZf
 +hm6ypgSZtpjJnpoqvwdyfY5W0G3dEbQDU37FEEgscR8IdRq5eOLg1gA0oXTurcszGge
 tkj6DUZzCRadj/+vsR13esBzQWifcjgDJb6b8fauT5CTH3/dzidGXygD63TvsR86/oD/
 W4LV3xKJ25SO0bNSe1GaT7t+/RErFJJXQy1BimHhHt9h/LCcRZYRf34TqUzpXezgP9gj
 ehkQ==
X-Gm-Message-State: AOJu0Yyp4Y6b36JtSIUlshzlQvhEU1NvQJtGBIBFtDrf+qX0GvM0hVLi
 BoMUuPRvUSggCrWl47ELnxwRD+e+b3hxymUUqCFC05imAydI2V+dCoRzzmyVtWoYNV19Wey0i3G
 TgSCNt1EuYZMnaSe2uk6P3dIEWhSWYBgzdzfrs+J6/Gz9z+6i0ygktU5nERy0fJKd9KaZNIdHkU
 ci1Ffqnx4gYO/j2A/MZndx5RM0ULtYVCIG8Vl4km8=
X-Gm-Gg: ASbGnctLV3rDLxmKxiphT9utcS+F6PVO2olA79K1I83/5xNKnJJf2qxNleQNIZnTUyr
 RLj+TJq1DlHB+NEmvCIYd8346V2+xgmESHpsfWqmO3zKy4RpHI1lMKx+E7uIapEwBMtPu9JeXSX
 Q2x7xeiLoeLLrxCwlF4zSiKvVOiGZNNUdlMEdpoQAPQzgrXh7d8fWQ5Oksi3oKuoM4IlOapN2Dj
 z85LRC4yvwMfR/tEFqVIkwAyB+B8rNp2mp7aDWNtxOKTFKKfTssrM1DtU1keBwW658i0cUy5jQK
 M/BLAnMJ9dR6XgLOz0hKmw==
X-Received: by 2002:a05:600c:5248:b0:43c:ed61:2c26 with SMTP id
 5b1f17b1804b1-43ced612d1amr20028105e9.17.1741516306978; 
 Sun, 09 Mar 2025 03:31:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7BWf9FyNUaUa6iRAVsu4zXYUv94wDhXA1+QLL7hhF2WS5VaOVEAHMbz+4rD+we00QuJsTqQ==
X-Received: by 2002:a05:600c:5248:b0:43c:ed61:2c26 with SMTP id
 5b1f17b1804b1-43ced612d1amr20027905e9.17.1741516306509; 
 Sun, 09 Mar 2025 03:31:46 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e1d67sm11506919f8f.74.2025.03.09.03.31.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/25] rust: hpet: do not access fields of SysBusDevice
Date: Sun,  9 Mar 2025 11:31:05 +0100
Message-ID: <20250309103120.1116448-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Fields of SysBusDevice must only be accessed with the BQL taken.  Add
a wrapper that verifies that.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/hpet.rs |  4 +---
 rust/qemu-api/src/sysbus.rs    | 12 ++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 3d3d6ef8eec..d989360ede8 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -730,8 +730,6 @@ fn realize(&self) {
     }
 
     fn reset_hold(&self, _type: ResetType) {
-        let sbd = self.upcast::<SysBusDevice>();
-
         for timer in self.timers.iter().take(self.num_timers.get()) {
             timer.borrow_mut().reset();
         }
@@ -744,7 +742,7 @@ fn reset_hold(&self, _type: ResetType) {
         HPETFwConfig::update_hpet_cfg(
             self.hpet_id.get(),
             self.capability.get() as u32,
-            sbd.mmio[0].addr,
+            self.mmio_addr(0).unwrap(),
         );
 
         // to document that the RTC lowers its output on reset as well
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 48803a655f9..0790576d446 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -64,6 +64,18 @@ fn init_irq(&self, irq: &InterruptSource) {
         }
     }
 
+    // TODO: do we want a type like GuestAddress here?
+    fn mmio_addr(&self, id: u32) -> Option<u64> {
+        assert!(bql_locked());
+        let sbd = self.upcast();
+        let id: usize = id.try_into().unwrap();
+        if sbd.mmio[id].memory.is_null() {
+            None
+        } else {
+            Some(sbd.mmio[id].addr)
+        }
+    }
+
     // TODO: do we want a type like GuestAddress here?
     fn mmio_map(&self, id: u32, addr: u64) {
         assert!(bql_locked());
-- 
2.48.1


