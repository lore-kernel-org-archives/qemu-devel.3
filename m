Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46426C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYAS-0008VV-AV; Fri, 08 Mar 2024 06:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAQ-0008L0-MU
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:34 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAO-0001jO-UY
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:34 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dd01ea35b5so11612095ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896411; x=1710501211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VusZNRxPzcdQ84f6CizRKShOJCxSLEZq7yv4bYvmfdM=;
 b=an+u5VV/yRMF+Jox631mXmXqfrSjVa07WKBDBaAfgWGtZrr/mSLrzOCwTa37UnEFeD
 gjxqoFupDom3/yJCgoc8wc3LCU8rHVqZ03iBltMzwlVfmBtijQvL9U6ptLrUA4sXhsfZ
 ji33VuzFRRQnNOf9eC6HGerHR6SW/WhoR/HUDeZpzt9qZCl63HJlFOtsh8Le/WUCvn/L
 oNn8uNnoinBQzbxAPSiJkWOTi6IEoknJjl9b6mtIMxgFbrrqCoWURnuw3dmrbLzjBTdG
 dBE4MtAeC2c2hSZcU6S1StiONFPm6e0x6vCYpnFZrc3XeKWCFbfOSsTuj7kwjoy5h/to
 EUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896411; x=1710501211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VusZNRxPzcdQ84f6CizRKShOJCxSLEZq7yv4bYvmfdM=;
 b=IjEL06+L10INfYN4VXENENDML48fM+F20ig8sDNsC/ECaUsDaZGdwZvJM/lmXcIdqR
 whCjMSjkiwcpzTu2mzLKh/3bSfekkZPJou7jatE8IzikQMsn0GfsFoX4djMhQtl9vv7j
 BjKDNzGY0QTl1CoGcNfxwIZDYyk5rjz8/AvSf/QMbSFLv0ZiVcK0RciZkI74TPvZZQ7G
 iXlHLyiiAT6NNSJflzMTTaukS4ZFfZEk15/3L2ihfls7/0KXvxx/OkfwuNSpdzF1894A
 22PHttfoMEkTGDskYMaYoKhL57h3MfnRU2lTheVSNlSnLIQCvHo8/tqM7gFNbteaNZSI
 2ezg==
X-Gm-Message-State: AOJu0YxftqE5NafQYrnL4qm89a3NF4oIKeqHydhQvcT+I3nRIlxmoRF4
 g71We5s4ENh7ZAoSksbMJn+zvrxrjmziZoOpX0EYEuSRkU1NDls59UEzXxX+zaQMZQ==
X-Google-Smtp-Source: AGHT+IGmkMEqQBwd0ChujjBasCfzNz9BLDW3acw14agHX1XDLZ3AXV85ujHOE2s5vv1fNUX3Tdconw==
X-Received: by 2002:a17:902:e5c8:b0:1dc:b01e:9ae0 with SMTP id
 u8-20020a170902e5c800b001dcb01e9ae0mr13087806plf.14.1709896411156; 
 Fri, 08 Mar 2024 03:13:31 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:30 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Vadim Shakirov <vadim.shakirov@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 27/34] target/riscv: mcountinhibit, mcounteren, scounteren,
 hcounteren is 32-bit
Date: Fri,  8 Mar 2024 21:11:45 +1000
Message-ID: <20240308111152.2856137-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Vadim Shakirov <vadim.shakirov@syntacore.com>

mcountinhibit, mcounteren, scounteren and hcounteren must always be 32-bit
by privileged spec

Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20240202113919.18236-1-vadim.shakirov@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     |  8 ++++----
 target/riscv/machine.c | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5d291a7092..3b1a02b944 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -271,7 +271,7 @@ struct CPUArchState {
     target_ulong hstatus;
     target_ulong hedeleg;
     uint64_t hideleg;
-    target_ulong hcounteren;
+    uint32_t hcounteren;
     target_ulong htval;
     target_ulong htinst;
     target_ulong hgatp;
@@ -334,10 +334,10 @@ struct CPUArchState {
      */
     bool two_stage_indirect_lookup;
 
-    target_ulong scounteren;
-    target_ulong mcounteren;
+    uint32_t scounteren;
+    uint32_t mcounteren;
 
-    target_ulong mcountinhibit;
+    uint32_t mcountinhibit;
 
     /* PMU counter state */
     PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 81cf22894e..76f2150f78 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -79,14 +79,14 @@ static bool hyper_needed(void *opaque)
 
 static const VMStateDescription vmstate_hyper = {
     .name = "cpu/hyper",
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .needed = hyper_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.hstatus, RISCVCPU),
         VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
         VMSTATE_UINT64(env.hideleg, RISCVCPU),
-        VMSTATE_UINTTL(env.hcounteren, RISCVCPU),
+        VMSTATE_UINT32(env.hcounteren, RISCVCPU),
         VMSTATE_UINTTL(env.htval, RISCVCPU),
         VMSTATE_UINTTL(env.htinst, RISCVCPU),
         VMSTATE_UINTTL(env.hgatp, RISCVCPU),
@@ -353,8 +353,8 @@ static const VMStateDescription vmstate_jvt = {
 
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
-    .version_id = 9,
-    .minimum_version_id = 9,
+    .version_id = 10,
+    .minimum_version_id = 10,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
@@ -397,9 +397,9 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.mtval, RISCVCPU),
         VMSTATE_UINTTL(env.miselect, RISCVCPU),
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
-        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
-        VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
-        VMSTATE_UINTTL(env.mcountinhibit, RISCVCPU),
+        VMSTATE_UINT32(env.scounteren, RISCVCPU),
+        VMSTATE_UINT32(env.mcounteren, RISCVCPU),
+        VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
         VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
                              vmstate_pmu_ctr_state, PMUCTRState),
         VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
-- 
2.44.0


