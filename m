Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E22AC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7eZ-0000JD-6l; Thu, 05 Jun 2025 06:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7e2-0007U4-FZ
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7e0-0001MC-UA
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GD5j4iIBSM/wWOplLwp2FFPFSX88IRGEIBS2r4z9frY=;
 b=Nv4K359weTv8JxE99S6sq31nXPXVPp3+9f5THGi6clraXcHaZRaad2JFajp4LGu9ST4pGm
 wu6Z6fb5pvn/7G4/aSekxst51LjooBES4NpkxOV2avVa0t0BV5yv1tDh8w3hV3RYrf1IYo
 V4c9PvqQKmiigCHPU7hsw949EMxBU8g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-cbAeAOXxO-yQfkFK3c_Oyw-1; Thu, 05 Jun 2025 06:16:18 -0400
X-MC-Unique: cbAeAOXxO-yQfkFK3c_Oyw-1
X-Mimecast-MFC-AGG-ID: cbAeAOXxO-yQfkFK3c_Oyw_1749118578
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442f90418b0so3746385e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118577; x=1749723377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GD5j4iIBSM/wWOplLwp2FFPFSX88IRGEIBS2r4z9frY=;
 b=v3CZSqgFzBEjeRGjLEMEP+NBb8FR8x7BSq+vb6N3HK3VLxtDkjfp6wUc226sOwm8i3
 +vzddqzQ+VPhGQaVncD/RVRoIJgYu3fh8mfeZdokHm2HGJxZ9v9glpnIbuGsZJuFkPOn
 MJKUovmQDDCp8GP050qsuBfq0iv4N+g/+CF80LuAV6g44RGKdEigb60uqxqh6FcRfjsk
 nZilqeevhu0SBbEPL3fkzfgR1EcVUhlE3StZ/OFUUMhVMhUpVwjE8am9WHkOOcNPPe/l
 UFJl1Q3ShuiBdOc3iCWRdgfuSarhsMZdB1NmWPQzKU18VN0WzVb+22R56owJyXtDU4iP
 B8ow==
X-Gm-Message-State: AOJu0Ywy/Uhplr8IXJsfp05/VpLnqHIvUVzz3qHhE1Ao8qMVBoRfJ6DS
 603cZOB5XdXqiWFd5hrZKsCuykAJ/KP2lmfsxH+pOzxSOe5KTyr6AUmpcM9NZEGU0DZONw4L99K
 DFflOdiAOBWjMPaqvR+GeYMueTE367doC65AMIe4bdQr0AyT8RZwG5V0iZbnIXpJPGt3gek+zpf
 7soHQHpxR52cH5M7i1GSYiH9qvlkdmZYdZCNSFoLpV
X-Gm-Gg: ASbGncveMOMUY/9Qf/XC8ZfoF6x9qHOPuS3x92KwlOUE0P3FFf3gnqj5lZSzpAovAQk
 rxmaANe+7TRhBkiC3UO0jlXCErUlReGz9dr0+qENQbME53YfwSkyRwP4PJRrB9BUDqZspWEK85+
 NTFOUvNW0FxuF+0uRyD4zmP17bHuKedB21uoAgd/vwFvONwzqazpeBAMwo9oSoyTmvEkD3kNofv
 F8UgKKuR2U6E2bgIIv6Z5E7NmAyZ4PRoveWNngr+v4XP0xccYxAwEam87veA6Hr2AU4fpiMW1fl
 3U6DX3pod8gDQg==
X-Received: by 2002:a05:600c:8b6d:b0:450:cf46:5510 with SMTP id
 5b1f17b1804b1-451f0b22e23mr56626895e9.29.1749118576854; 
 Thu, 05 Jun 2025 03:16:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM0OyOQR1+NRguq1XOtcjnPQIF9Gr40UgvMJqdEGVs+VneypJ8IWVhahKwCGWB3BdJbkU2fA==
X-Received: by 2002:a05:600c:8b6d:b0:450:cf46:5510 with SMTP id
 5b1f17b1804b1-451f0b22e23mr56626545e9.29.1749118576346; 
 Thu, 05 Jun 2025 03:16:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00972c1sm24452174f8f.68.2025.06.05.03.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:16:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 12/14] rust/hpet: return errors from realize if properties are
 incorrect
Date: Thu,  5 Jun 2025 12:15:41 +0200
Message-ID: <20250605101544.368953-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101544.368953-1-pbonzini@redhat.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

Match the code in hpet.c; this also allows removing the
BqlCell from the num_timers field.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 16 +++++++---------
 rust/hw/timer/hpet/src/fw_cfg.rs |  7 +++----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index a957de1e767..cd439f90b7e 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
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
diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index 6c10316104c..619d662ee1e 100644
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
-- 
2.49.0


