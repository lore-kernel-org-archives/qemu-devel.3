Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3DBC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIO-0002gI-0q; Fri, 06 Jun 2025 08:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIM-0002fm-5m
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIJ-0005uG-Mz
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GD5j4iIBSM/wWOplLwp2FFPFSX88IRGEIBS2r4z9frY=;
 b=KcZHqcc2fOCPi3s3KrsP+HlOuuy79wBnUSj7l9TDPODl4q+ZhR/4Jtxy367CXX2jHepulE
 7swmDjciUBVM1mNvs1kkuQUj997x7g4QE3SUxEr6QPJSVbM+pe/24KhFVaa3XpXQEaOb2M
 MpP4P6vzOlCx0785uPCD/j+YBurcd2g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-nJfguWtEP92j_gpLoA7Qgg-1; Fri, 06 Jun 2025 08:35:32 -0400
X-MC-Unique: nJfguWtEP92j_gpLoA7Qgg-1
X-Mimecast-MFC-AGG-ID: nJfguWtEP92j_gpLoA7Qgg_1749213330
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4eb9c80deso988743f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213330; x=1749818130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GD5j4iIBSM/wWOplLwp2FFPFSX88IRGEIBS2r4z9frY=;
 b=PPK2HH9YIaFNMtVPj6wspGdjkL/vx/6VX+8Rq4nYmi5gFRvdEGy8PNmTp9hH3S5JZ3
 +DeyPQAYRRI/iD9yJaD8t5JAgUWWS3mwS4SzoIQZd1MA6WvDTg8J/tYkHP/DVZkZ+bp6
 xbFiA5Hwn7BxsBFv30MVeP5kMM1tcJnlE6E478vf4VyoBi3J3Di4A925WaEy3SwnI5Ka
 ZcfKY3lPTb5y5G/0OJ4SkID10Z2qN5Jd5Yr9JTK+efJ1bUlASVpXsOOCEjt/yde5CFXK
 nVfdVDPORFzgD2ORvyDhNGT/bWRdS4QP0VaYSk49IfFhyETvqzFfzOw81Ueyvh/IAhiz
 otXQ==
X-Gm-Message-State: AOJu0Yz03u/EjsXFejDSTQ+ko7b1BoTIA5FzzWpAsNrRRt6xed/9vbtb
 A1rifZdD8AzWO1d2qEufNgD4vjkJflXOB774lV1HlBOetlV/sIwQHG7ZUT0TUuAzxMyCe69wTn6
 0OTz5o48Q9w7F6wy02hD8ofpLsQxgUmF8wCecWv2BeZBwTigO01OuhrCBPpdcAfWRx7dJ50xg3u
 727wH0CkY1JAYh3siZM6uQIZmWR9RY11Gs63+0RcfG
X-Gm-Gg: ASbGncu2Z/9gkhNZQdCRbMSToQZlCVQewYtyVeR+7ybbg/ZPMUVuNBDs+ko6dIrFBEG
 uW/uD9JdFytHfwMQ193BKpJREu9pUs5Zq4n29zU5usPa4cyXkgyG2hRCmfXOSZC3NvKZcn/hHdF
 X9VqGJyTyZO8BWndE+IjxzGgikFN26ZPAATJZP3F1L7O6d9gcrv2V3onc3ax1qUY/L2JBFmEPdw
 Ou8KUwPwXhsP9R6kXU9X7YyBf9JCBHTNgxF0Zt//Cd8JsvZ2FOFwI8O4Ufx6/ZzXgViLbcHeeGV
 KQ67JYc9V8/uJg==
X-Received: by 2002:a05:6000:1a88:b0:3a5:2f23:3780 with SMTP id
 ffacd0b85a97d-3a531caa458mr2755848f8f.18.1749213329596; 
 Fri, 06 Jun 2025 05:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8obiB+K6zbjNoVhf6oxiXuoc8LmtlcwiOxBTWLPZFiXB8L0wrKFOVX6MNSQVnSoY/T1HmqQ==
X-Received: by 2002:a05:6000:1a88:b0:3a5:2f23:3780 with SMTP id
 ffacd0b85a97d-3a531caa458mr2755819f8f.18.1749213329154; 
 Fri, 06 Jun 2025 05:35:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244ee34sm1786042f8f.72.2025.06.06.05.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 12/31] rust/hpet: return errors from realize if properties are
 incorrect
Date: Fri,  6 Jun 2025 14:34:26 +0200
Message-ID: <20250606123447.538131-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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


