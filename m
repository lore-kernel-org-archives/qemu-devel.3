Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565E6C5B552
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKuia-0002gu-CR; Fri, 30 May 2025 04:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiR-0002aC-Mw
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiO-0004ej-D3
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GD5j4iIBSM/wWOplLwp2FFPFSX88IRGEIBS2r4z9frY=;
 b=NsOqHWCplngkJ4aTDgWrwmjO4/cgdRDcOUuKTzol++q5/nFtMIpGnRIU8o0dMz/h7TrGtb
 ZmKEzA9OlWRX/nXr6Ig5VwJrUWSn3Leulbh9uUTSyt8kjCV0jVO8hgydEi8Om6bYvY8ad1
 PfF0OmRPZgV2wQcOfHs3ppcWSrouvXw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-p6px664lMw-0cGrtP4xzbw-1; Fri, 30 May 2025 04:03:42 -0400
X-MC-Unique: p6px664lMw-0cGrtP4xzbw-1
X-Mimecast-MFC-AGG-ID: p6px664lMw-0cGrtP4xzbw_1748592221
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-604c41e0c10so1553515a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592220; x=1749197020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GD5j4iIBSM/wWOplLwp2FFPFSX88IRGEIBS2r4z9frY=;
 b=CwFCyhZo/Q4feBREgFW+C1y6xySfefLt/zKVwDau8lU38aB2GeCjFGeFEDGH4sSNHy
 4JJuBy37UgL2OmTPRc1VLLjs+ZeR3CMc/Km0mNnbdqCDaVtoona9JCyKSr6oDqW35TQ0
 nWEz9+XmWbsf7MxTdFWjF2p0CkAr8dmxjnGvr1l9GDt/5s4nKKl4eTXxUnocmQtFv1DF
 7MgRbTBgxTV5EerpqYhAIGeI3apnYX2upd7S775X3tn+BpISCc3AMup3VTUlN8Xky3Ew
 fM9DNaVUgXfw4n0L7uDCuval+7xAUN4l2fbQdJZ59a/gZt1ynM+X/g5civlrTc4J+HmZ
 uHPA==
X-Gm-Message-State: AOJu0YzSrR0Of1n02oUMpbC1uvR1/FABcOFhO2/UiJfPEQ6U7XY5ebEf
 yj0DeA21VHLrP2X3TM5lv9lCpLzb861ZVpV3yNLDqe3ODnle/95fTFZtBSnxXvxvG7b3BAhRgrL
 QWEBRYqwbzL4tWi2Gt7vuTZnIjKE3eSI/t9G+KBnRhU/WCrYIIlRxOAyR+dW4mf0aktB0MN4z++
 nmDouZ/fwaJfOUqEh5QWMXnJIwnWHCreQyD7ZG9Bu5
X-Gm-Gg: ASbGncupCaZThOHZ+FhzMTYmTJIBeCarV/djVkSE07Sjw2SWKX+5eYeZGwK/3+JMrU+
 YK2WnTP7sGSe3Qn5MagkOuhMHGlWG5DUzsWci9wJCjAhDm6aTxmV8IO5b+DTb3NCtJwYjoCtKYw
 6TaSkxyBtJQU2/mQKibLz6aFjRlaBZ1ctEs/YhG72ViQj6+wHYU9fKxvFQ3C2wfw8cm6dx7wdxg
 wIOhTdonVTvIop9Muz7siSlqoXFZTWQbMIKkB5KfePE5GboxYGZgMUyTlwfbC4IJKNyT30E0iqa
 hH1XsRB2/+RLUQ==
X-Received: by 2002:a05:6402:278c:b0:5f8:e6e5:54ac with SMTP id
 4fb4d7f45d1cf-6057c1c36bfmr1160766a12.14.1748592220213; 
 Fri, 30 May 2025 01:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNCdp6lDkMlujaocP8dWaACw5BnDqPn3Yld2gp69Q6EA29uYQsVMCayMPNnhnXpAWYk8OwEw==
X-Received: by 2002:a05:6402:278c:b0:5f8:e6e5:54ac with SMTP id
 4fb4d7f45d1cf-6057c1c36bfmr1160724a12.14.1748592219683; 
 Fri, 30 May 2025 01:03:39 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c2a757sm1247003a12.11.2025.05.30.01.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 12/14] rust/hpet: return errors from realize if properties are
 incorrect
Date: Fri, 30 May 2025 10:03:04 +0200
Message-ID: <20250530080307.2055502-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


