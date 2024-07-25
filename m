Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819B2C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Kh-0000ke-7b; Thu, 25 Jul 2024 19:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Kb-0000Uf-W3; Thu, 25 Jul 2024 19:57:10 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ka-0001JK-5H; Thu, 25 Jul 2024 19:57:09 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2cb5243766dso320194a91.0; 
 Thu, 25 Jul 2024 16:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951826; x=1722556626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPCxFjqA845bFfBDX6QcwlN1hvHVfAlMa5QHleMSePg=;
 b=DexiS+Rzkh5FpSN9qZRzdrL9glN+vzJ9lqaYZNylp1YdCr1uJh9zM2HkZOIsKig2k5
 nXGV7q5LdGml5A+eAIznBTWxWAoyWq1/ATynkiJJQ5UfM/5YMq/q2uxQZFnb9dgQ0w9T
 gv0Pwe3Q6A1Kemk3heNWOXXswQaXhjeG11uvKXGSDOL7g07DF9gZ5iacGFg9BfS1AKI3
 o0RINsPgtWxO1ULMidB0BwiB0ZFNroUHDYLv540Wm3aENLBVbNyz/gMikT4/o+LoLZ5T
 D5jA8hNOKixdE+gZnQFr8XEt/nTk34mJqCoTinpG8X/ERPETZmOz1DBz3uGf8GMaQDvL
 Yq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951826; x=1722556626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPCxFjqA845bFfBDX6QcwlN1hvHVfAlMa5QHleMSePg=;
 b=RVi/cSKWztNEQIQAXYWKT4GZd8iQvSgU4eK9loHiWdLdopKAkUxa1ZNKewsW3sWKlF
 QU7lGUhxH8xBB7lV6zRrWQRB7+VCPTh4hgxA3Axpj/MbwvCYqXcdr2NpuYm3uvJEMT28
 XEkSQKJx5q04GHFTUGamynnvgPnIl3TCbGAua4jd18LqyR8alHIwPIuYsrVMxIcN021s
 H3qb/lYbtlvydPy8gd3wPFbW0zEfJmuwWjQz3OgEWDTeG3006nALK0JpIX0JhXigqzeo
 B21ndOHxy/3VhJLCtigXzLGaZz6QaonWg8ayR7Trzy+d+IZM27ifL7NKJE8GafROyVxX
 W/oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUubK3jMt2A+OY6GNdFz042JR6oDjp9p5oIYS84je3jenXbPpkmBywx+gT8/BBT9aHfGvCGgnJmfoD0ARdpYdMyXjKq
X-Gm-Message-State: AOJu0YwMB0/PUmQRv/ms5uIgnyHxaCefOIBqp4x1VBN2QE2UkeSvm/Tc
 Um+1an8k0qL/s4zrNJ6WV3rCv/EumpNXEyp+npdADYSBawjHz88uL01HwQ==
X-Google-Smtp-Source: AGHT+IG5b1pk6J8kn8+iRDOnxeIypGK/xnkGiXhBew6UUMMgkp+VfUbQxBSIcPi7SxlyzZAYkEZIvg==
X-Received: by 2002:a17:90a:ab0d:b0:2c8:84b:580e with SMTP id
 98e67ed59e1d1-2cf23e25a25mr4848404a91.41.1721951825997; 
 Thu, 25 Jul 2024 16:57:05 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 45/96] pnv/xive2: Add NVG and NVC to cache watch facility
Date: Fri, 26 Jul 2024 09:53:18 +1000
Message-ID: <20240725235410.451624-46-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

The cache watch facility uses the same register interface to handle
entries in the NVP, NVG and NVC tables. A bit-field in the 'watchX
specification' register tells the table type. So far, that bit-field
was not read and the code assumed a read/write to the NVP table.

This patch allows to read/write entries in the NVG and NVC table as
well.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive2.c | 49 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 3dbbfddacb..561e61682e 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -465,10 +465,30 @@ static int pnv_xive2_write_nvp(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
                               word_number);
 }
 
-static int pnv_xive2_nvp_update(PnvXive2 *xive, uint8_t watch_engine)
+static int pnv_xive2_nxc_to_table_type(uint8_t nxc_type, uint32_t *table_type)
 {
-    uint8_t  blk;
-    uint32_t idx;
+    switch (nxc_type) {
+    case PC_NXC_WATCH_NXC_NVP:
+        *table_type = VST_NVP;
+        break;
+    case PC_NXC_WATCH_NXC_NVG:
+        *table_type = VST_NVG;
+        break;
+    case PC_NXC_WATCH_NXC_NVC:
+        *table_type = VST_NVC;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "XIVE: invalid table type for nxc operation\n");
+        return -1;
+    }
+    return 0;
+}
+
+static int pnv_xive2_nxc_update(PnvXive2 *xive, uint8_t watch_engine)
+{
+    uint8_t  blk, nxc_type;
+    uint32_t idx, table_type = -1;
     int i, spec_reg, data_reg;
     uint64_t nxc_watch[4];
 
@@ -476,21 +496,24 @@ static int pnv_xive2_nvp_update(PnvXive2 *xive, uint8_t watch_engine)
 
     spec_reg = (PC_NXC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
     data_reg = (PC_NXC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
+    nxc_type = GETFIELD(PC_NXC_WATCH_NXC_TYPE, xive->pc_regs[spec_reg]);
     blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID, xive->pc_regs[spec_reg]);
     idx = GETFIELD(PC_NXC_WATCH_INDEX, xive->pc_regs[spec_reg]);
 
+    assert(!pnv_xive2_nxc_to_table_type(nxc_type, &table_type));
+
     for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
         nxc_watch[i] = cpu_to_be64(xive->pc_regs[data_reg + i]);
     }
 
-    return pnv_xive2_vst_write(xive, VST_NVP, blk, idx, nxc_watch,
+    return pnv_xive2_vst_write(xive, table_type, blk, idx, nxc_watch,
                               XIVE_VST_WORD_ALL);
 }
 
-static void pnv_xive2_nvp_cache_load(PnvXive2 *xive, uint8_t watch_engine)
+static void pnv_xive2_nxc_cache_load(PnvXive2 *xive, uint8_t watch_engine)
 {
-    uint8_t  blk;
-    uint32_t idx;
+    uint8_t  blk, nxc_type;
+    uint32_t idx, table_type = -1;
     uint64_t nxc_watch[4] = { 0 };
     int i, spec_reg, data_reg;
 
@@ -498,11 +521,15 @@ static void pnv_xive2_nvp_cache_load(PnvXive2 *xive, uint8_t watch_engine)
 
     spec_reg = (PC_NXC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
     data_reg = (PC_NXC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
+    nxc_type = GETFIELD(PC_NXC_WATCH_NXC_TYPE, xive->pc_regs[spec_reg]);
     blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID, xive->pc_regs[spec_reg]);
     idx = GETFIELD(PC_NXC_WATCH_INDEX, xive->pc_regs[spec_reg]);
 
-    if (pnv_xive2_vst_read(xive, VST_NVP, blk, idx, nxc_watch)) {
-        xive2_error(xive, "VST: no NVP entry %x/%x !?", blk, idx);
+    assert(!pnv_xive2_nxc_to_table_type(nxc_type, &table_type));
+
+    if (pnv_xive2_vst_read(xive, table_type, blk, idx, nxc_watch)) {
+        xive2_error(xive, "VST: no NXC entry %x/%x in %s table!?",
+                    blk, idx, vst_infos[table_type].name);
     }
 
     for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
@@ -1432,7 +1459,7 @@ static uint64_t pnv_xive2_ic_pc_read(void *opaque, hwaddr offset,
         * SPEC register
         */
         watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
-        pnv_xive2_nvp_cache_load(xive, watch_engine);
+        pnv_xive2_nxc_cache_load(xive, watch_engine);
         val = xive->pc_regs[reg];
         break;
 
@@ -1506,7 +1533,7 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
         /* writing to DATA0 triggers the cache write */
         watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
         xive->pc_regs[reg] = val;
-        pnv_xive2_nvp_update(xive, watch_engine);
+        pnv_xive2_nxc_update(xive, watch_engine);
         break;
 
    /* case PC_NXC_FLUSH_CTRL: */
-- 
2.45.2


