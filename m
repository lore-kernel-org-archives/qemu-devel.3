Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB3FC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYly-0003Nk-5m; Mon, 26 May 2025 10:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlg-00032F-Sm
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYld-0007sr-7g
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748269526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pxg/98qXOCGxIS0+0C2ldwJ8rlIMJBaj9BLbfUFLby0=;
 b=S6AliX4ccYfLyGdFeO/m+LurwBNdGCx0dkPeHjrDyqUDDeB+JyGiD9ayrmZfmjaEo4Abut
 fbjQWOvPGRzQO4pU2PS20Huk4jAO45hb2U3H6j+jN8jHp+nPTKyNpwaq1pWICG+kS/ov6+
 aiwlcXbqLqShp1+32RMLhbrR6MoVj1s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-Go63gHU8MWevR3JQbeKaaA-1; Mon, 26 May 2025 10:25:24 -0400
X-MC-Unique: Go63gHU8MWevR3JQbeKaaA-1
X-Mimecast-MFC-AGG-ID: Go63gHU8MWevR3JQbeKaaA_1748269523
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so18158175e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269522; x=1748874322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pxg/98qXOCGxIS0+0C2ldwJ8rlIMJBaj9BLbfUFLby0=;
 b=tsnpK2dpuUygzW16njekbhcjCYxY0ve24ps8jsYeCEIUdMtLWL0temvQ/TL71dM4+l
 zUysYKnuo/MdzPzPnL3s5Xa77vnHiEuI3vFlM1oORWc+bmbcY9P7tzfqJD1phVLbgLhj
 SgW+W/ZlQ/ck4+EF1WYA3iLarzA3wySKppK7mpe2PaIBXHZRutantOoh909upbvYwgdp
 WzxDYMJgSw7qT5RQ/AZDYd/FHtLpmslTvJRjoRaBgTgFEjnjcq6AQJWVF03dxzXoTl2x
 8NqaNcVwIe7br2dsmTWSjs9QrMZV2gdIiwnkIRRa91q+uEA4jFw7pDNvvRu0zFgKDihd
 32CQ==
X-Gm-Message-State: AOJu0Yx2HxFVHNpv0e6+y8ltH23kAFGS8KXWFvjiLAsm9a7e8L9EiqTW
 8SNJH8z9RIVOIRYdNSN1NVbi2MwBWOCj8qy08+WNA7JnkIth0SUaoIJ9XucCT87fGANfgbAhd/p
 sTo8YuMPWVC9ZDbhzr0ZvZqnlNEk/CDQ55I7vOdDgYCJJP7g9bCkvtTtlMEH6tPb+s4joAh/tBM
 xKdDeccUuwP1R/buzqOo5CLXXClVKTAj00kTscL/BX
X-Gm-Gg: ASbGnctv2xMc0WW2EqB5kmMaSQqYmCZEs7d62u0p2fulXWaHiIN1CrVhQeVm9BMg3+t
 YmbB5lJ2MyScWJAnhFS/MWMPwWlRhAdtmCwnv1B2IOrlhG14HizXoWrt/59j9dB7sEwYaBoQJtJ
 Dx6s7TTjMCu0+jh7N1IY8LBWxEV3hyrp/SsPxsYRuZv+LV+b+SCg2rzpKOOuWgjxEH0dGpE0Sus
 aGhDmsajGcDvQPiE0nvcH3Q8r74VFQYBT3qjZmG11H8uAErj/DRJbnNUM4tEYoO5b6bg5geyY6G
 toBdQsN0rMMnQA==
X-Received: by 2002:a05:600c:1d96:b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-44c916071a2mr91336805e9.4.1748269522513; 
 Mon, 26 May 2025 07:25:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvUK5+9C/DNRU1XFsc4kPWYhQfHijzyszKQNaKq7ieOf3QPlYdJXcmWbEEwWdBGsy8k7wHqA==
X-Received: by 2002:a05:600c:1d96:b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-44c916071a2mr91336465e9.4.1748269522016; 
 Mon, 26 May 2025 07:25:22 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23c07bfsm240131505e9.23.2025.05.26.07.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:25:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 11/12] rust/hpet: return errors from realize if properties are
 incorrect
Date: Mon, 26 May 2025 16:24:54 +0200
Message-ID: <20250526142455.1061519-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526142254.1061009-1-pbonzini@redhat.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Match the code in hpet.c; this also allows removing the
BqlCell from the num_timers field.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/fw_cfg.rs |  7 +++----
 rust/hw/timer/hpet/src/hpet.rs   | 16 +++++++---------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index aa08d283519..140692062cd 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -36,7 +36,7 @@ unsafe impl Zeroable for HPETFwConfig {}
 };
 
 impl HPETFwConfig {
-    pub(crate) fn assign_hpet_id() -> usize {
+    pub(crate) fn assign_hpet_id() -> Result<usize, &'static str> {
         assert!(bql_locked());
         // SAFETY: all accesses go through these methods, which guarantee
         // that the accesses are protected by the BQL.
@@ -48,13 +48,12 @@ pub(crate) fn assign_hpet_id() -> usize {
         }
 
         if fw_cfg.count == 8 {
-            // TODO: Add error binding: error_setg()
-            panic!("Only 8 instances of HPET is allowed");
+            Err("Only 8 instances of HPET are allowed")?;
         }
 
         let id: usize = fw_cfg.count.into();
         fw_cfg.count += 1;
-        id
+        Ok(id)
     }
 
     pub(crate) fn update_hpet_cfg(hpet_id: usize, timer_block_id: u32, address: u64) {
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index b2922e6a843..b298938e4d5 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -725,18 +725,16 @@ fn post_init(&self) {
     }
 
     fn realize(&self) -> qemu_api::Result<()> {
+        if self.num_timers.get() < HPET_MIN_TIMERS || self.num_timers.get() > HPET_MAX_TIMERS {
+            Err(format!(
+                "hpet.num_timers must be between {HPET_MIN_TIMERS} and {HPET_MAX_TIMERS}"
+            ))?;
+        }
         if self.int_route_cap == 0 {
-            // TODO: Add error binding: warn_report()
-            println!("Hpet's hpet-intcap property not initialized");
+            Err("hpet.hpet-intcap property not initialized")?;
         }
 
-        self.hpet_id.set(HPETFwConfig::assign_hpet_id());
-
-        if self.num_timers.get() < HPET_MIN_TIMERS {
-            self.num_timers.set(HPET_MIN_TIMERS);
-        } else if self.num_timers.get() > HPET_MAX_TIMERS {
-            self.num_timers.set(HPET_MAX_TIMERS);
-        }
+        self.hpet_id.set(HPETFwConfig::assign_hpet_id()?);
 
         self.init_timer();
         // 64-bit General Capabilities and ID Register; LegacyReplacementRoute.
-- 
2.49.0


