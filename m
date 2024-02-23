Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A29C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXuS-0004oW-OD; Fri, 23 Feb 2024 10:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXk9-0006uJ-Lx; Fri, 23 Feb 2024 10:45:45 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXk7-0006gU-G3; Fri, 23 Feb 2024 10:45:45 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc1e7c0e29so2609445ad.1; 
 Fri, 23 Feb 2024 07:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703142; x=1709307942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnb2MkOZFPUeH1yh62P5aTEWIUtL79vmsTCtISegskM=;
 b=JP27ocIIitW01EgQRp6ktM9F0RIwdb1ZxMrCqXWAQWz/MisCYHrDYQNKr3Tz+4ClsI
 Xkh20bzw2VjBCiubco16NV0tkwdAWBepI4/QQchV3cCbs1LV3V2j+h3EVYQOT/yfnghj
 w3Pv5lZVMnJaG3XCSj13Iynw0x9MEH4YEAzvEetqBrAK+0trCewzIGZl9V8k1EKcbyC9
 V1nj6w/M/2geXuJNhSjvx0fSDiSXf+khH2n9GPkB+IF9qgvKnKa6P2jgtLCtrNKWVAYY
 6ex50hAuytDQwpzSCSBv6ZTXud9rIeT+xWFMh0Te4w+0ESxBfvKDYC54H7MHNQ0iXUSK
 xu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703142; x=1709307942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qnb2MkOZFPUeH1yh62P5aTEWIUtL79vmsTCtISegskM=;
 b=xCIlQpBmmLqHs+vtxN72Sn/KeLExXfBzyIdFOlVhwQaLAiTawTKtZe2d2GfSG8dLQs
 WVRZnYmLCofysqUC9Pq/puDMhedTIyR3VAZXBqVS0hZ0sZ6yGW/pHEfy+2bDwlXgU9TZ
 MQHrya/QhV+aLPuxvtT4BtxY+ggU2LTAKaY5th3C9QMGBd/Apw7tFKeRiElCZOz1pbRw
 xUmgOHxaTQAvY/zHeImJAmly6X2OLssw3f4sBYyr6cojn1lXQmvnNGiE4qzK0+ELmcM6
 rKSxHwzw25vEvpB/nMFmezzxDFQ5evRhgzwQF59oPT9SDs7G20TENdHUQERvclhiXs9v
 MwLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe2ZyEHugP2cY+rKXLijMFUQhrRkPoYcv9bPhTqUvj16LVWT07+zS4stFGy4cynywlKLlpJczxfu9EE5iFavAD08V4
X-Gm-Message-State: AOJu0YxhAIyxN4XwNfCkM8EsCoSWMq7zyicA/+PwX+41eHQsp6RDBYm/
 yIkvyEWRNMGmxm+x5X+xkHX7GBtzykARaH6fAvGlJ+/hNu2qxB51GLS7El59
X-Google-Smtp-Source: AGHT+IHX54K2jDWQnCIJOddSBY3zOC3F+4UlCKJgDHqY+e0g8tfpIjhJ73q9g9FCVWcrvtkL8ViJjA==
X-Received: by 2002:a17:903:1206:b0:1db:68d5:6281 with SMTP id
 l6-20020a170903120600b001db68d56281mr221061plh.35.1708703141631; 
 Fri, 23 Feb 2024 07:45:41 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:45:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 39/47] ppc/pnv: Implement the ChipTOD to Core transfer
Date: Sat, 24 Feb 2024 01:41:58 +1000
Message-ID: <20240223154211.1001692-40-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

One of the functions of the ChipTOD is to transfer TOD to the Core
(aka PC - Pervasive Core) timebase facility.

The ChipTOD can be programmed with a target address to send the TOD
value to. The hardware implementation seems to perform this by
sending the TOD value to a SCOM address.

This implementation grabs the core directly and manipulates the
timebase facility state in the core. This is a hack, but it works
enough for now. A better implementation would implement the transfer
to the PnvCore xscom register and drive the timebase state machine
from there.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c                 |  15 ++++
 hw/ppc/pnv_chiptod.c         | 132 +++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv.h         |   2 +
 include/hw/ppc/pnv_chiptod.h |   4 ++
 target/ppc/cpu.h             |  13 ++++
 5 files changed, 166 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8beddb1313..0b47b92baa 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2121,6 +2121,21 @@ static void pnv_chip_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip";
 }
 
+PnvCore *pnv_chip_find_core(PnvChip *chip, uint32_t core_id)
+{
+    int i;
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pc = chip->cores[i];
+        CPUCore *cc = CPU_CORE(pc);
+
+        if (cc->core_id == core_id) {
+            return pc;
+        }
+    }
+    return NULL;
+}
+
 PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir)
 {
     int i, j;
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index 6ac3eac9d0..3831a72101 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -210,6 +210,79 @@ static void chiptod_power10_broadcast_ttype(PnvChipTOD *sender,
     }
 }
 
+static PnvCore *pnv_chip_get_core_by_xscom_base(PnvChip *chip,
+                                                uint32_t xscom_base)
+{
+    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+    int i;
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pc = chip->cores[i];
+        CPUCore *cc = CPU_CORE(pc);
+        int core_hwid = cc->core_id;
+
+        if (pcc->xscom_core_base(chip, core_hwid) == xscom_base) {
+            return pc;
+        }
+    }
+    return NULL;
+}
+
+static PnvCore *chiptod_power9_tx_ttype_target(PnvChipTOD *chiptod,
+                                               uint64_t val)
+{
+    /*
+     * skiboot uses Core ID for P9, though SCOM should work too.
+     */
+    if (val & PPC_BIT(35)) { /* SCOM addressing */
+        uint32_t addr = val >> 32;
+        uint32_t reg = addr & 0xfff;
+
+        if (reg != PC_TOD) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: SCOM addressing: "
+                          "unimplemented slave register 0x%" PRIx32 "\n", reg);
+            return NULL;
+        }
+
+        return pnv_chip_get_core_by_xscom_base(chiptod->chip, addr & ~0xfff);
+
+    } else { /* Core ID addressing */
+        uint32_t core_id = GETFIELD(TOD_TX_TTYPE_PIB_SLAVE_ADDR, val) & 0x1f;
+        return pnv_chip_find_core(chiptod->chip, core_id);
+    }
+}
+
+static PnvCore *chiptod_power10_tx_ttype_target(PnvChipTOD *chiptod,
+                                               uint64_t val)
+{
+    /*
+     * skiboot uses SCOM for P10 because Core ID was unable to be made to
+     * work correctly. For this reason only SCOM addressing is implemented.
+     */
+    if (val & PPC_BIT(35)) { /* SCOM addressing */
+        uint32_t addr = val >> 32;
+        uint32_t reg = addr & 0xfff;
+
+        if (reg != PC_TOD) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: SCOM addressing: "
+                          "unimplemented slave register 0x%" PRIx32 "\n", reg);
+            return NULL;
+        }
+
+        /*
+         * This may not deal with P10 big-core addressing at the moment.
+         * The big-core code in skiboot syncs small cores, but it targets
+         * the even PIR (first small-core) when syncing second small-core.
+         */
+        return pnv_chip_get_core_by_xscom_base(chiptod->chip, addr & ~0xfff);
+
+    } else { /* Core ID addressing */
+        qemu_log_mask(LOG_UNIMP, "pnv_chiptod: TX TTYPE Core ID "
+                      "addressing is not implemented for POWER10\n");
+        return NULL;
+    }
+}
+
 static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
                                     uint64_t val, unsigned size)
 {
@@ -231,6 +304,22 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
         chiptod->pss_mss_ctrl_reg = val & PPC_BITMASK(0, 31);
         break;
 
+    case TOD_TX_TTYPE_CTRL_REG:
+        /*
+         * This register sets the target of the TOD value transfer initiated
+         * by TOD_MOVE_TOD_TO_TB. The TOD is able to send the address to
+         * any target register, though in practice only the PC TOD register
+         * should be used. ChipTOD has a "SCOM addressing" mode which fully
+         * specifies the SCOM address, and a core-ID mode which uses the
+         * core ID to target the PC TOD for a given core.
+         */
+        chiptod->slave_pc_target = pctc->tx_ttype_target(chiptod, val);
+        if (!chiptod->slave_pc_target) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                          " TOD_TX_TTYPE_CTRL_REG val 0x%" PRIx64
+                          " invalid slave address\n", val);
+        }
+        break;
     case TOD_ERROR_REG:
         chiptod->tod_error &= ~val;
         break;
@@ -256,6 +345,47 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
             }
         }
         break;
+
+    case TOD_MOVE_TOD_TO_TB_REG:
+        /*
+         * XXX: it should be a cleaner model to have this drive a SCOM
+         * transaction to the target address, and implement the state machine
+         * in the PnvCore. For now, this hack makes things work.
+         */
+        if (chiptod->tod_state != tod_running) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                          " TOD_MOVE_TOD_TO_TB_REG in bad state %d\n",
+                          chiptod->tod_state);
+        } else if (!(val & PPC_BIT(0))) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                          " TOD_MOVE_TOD_TO_TB_REG with bad val 0x%" PRIx64"\n",
+                          val);
+        } else if (chiptod->slave_pc_target == NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                          " TOD_MOVE_TOD_TO_TB_REG with no slave target\n");
+        } else {
+            PowerPCCPU *cpu = chiptod->slave_pc_target->threads[0];
+            CPUPPCState *env = &cpu->env;
+
+            /*
+             * Moving TOD to TB will set the TB of all threads in a
+             * core, so skiboot only does this once per thread0, so
+             * that is where we keep the timebase state machine.
+             *
+             * It is likely possible for TBST to be driven from other
+             * threads in the core, but for now we only implement it for
+             * thread 0.
+             */
+
+            if (env->pnv_tod_tbst.tb_ready_for_tod) {
+                env->pnv_tod_tbst.tod_sent_to_tb = 1;
+            } else {
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                              " TOD_MOVE_TOD_TO_TB_REG with TB not ready to"
+                              " receive TOD\n");
+            }
+        }
+        break;
     case TOD_START_TOD_REG:
         if (chiptod->tod_state != tod_stopped) {
             qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: LOAD_TOG_REG in "
@@ -340,6 +470,7 @@ static void pnv_chiptod_power9_class_init(ObjectClass *klass, void *data)
     xdc->dt_xscom = pnv_chiptod_power9_dt_xscom;
 
     pctc->broadcast_ttype = chiptod_power9_broadcast_ttype;
+    pctc->tx_ttype_target = chiptod_power9_tx_ttype_target;
 
     pctc->xscom_size = PNV_XSCOM_CHIPTOD_SIZE;
 }
@@ -375,6 +506,7 @@ static void pnv_chiptod_power10_class_init(ObjectClass *klass, void *data)
     xdc->dt_xscom = pnv_chiptod_power10_dt_xscom;
 
     pctc->broadcast_ttype = chiptod_power10_broadcast_ttype;
+    pctc->tx_ttype_target = chiptod_power10_tx_ttype_target;
 
     pctc->xscom_size = PNV_XSCOM_CHIPTOD_SIZE;
 }
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 110ac9aace..476b136146 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -28,6 +28,7 @@
 
 #define TYPE_PNV_CHIP "pnv-chip"
 
+typedef struct PnvCore PnvCore;
 typedef struct PnvChip PnvChip;
 typedef struct Pnv8Chip Pnv8Chip;
 typedef struct Pnv9Chip Pnv9Chip;
@@ -56,6 +57,7 @@ DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER9,
 DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER10,
                          TYPE_PNV_CHIP_POWER10)
 
+PnvCore *pnv_chip_find_core(PnvChip *chip, uint32_t core_id);
 PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir);
 
 typedef struct PnvPHB PnvPHB;
diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
index ca770525d9..fde569bcbf 100644
--- a/include/hw/ppc/pnv_chiptod.h
+++ b/include/hw/ppc/pnv_chiptod.h
@@ -25,6 +25,8 @@ enum tod_state {
     tod_stopped = 1,
 };
 
+typedef struct PnvCore PnvCore;
+
 struct PnvChipTOD {
     DeviceState xd;
 
@@ -36,12 +38,14 @@ struct PnvChipTOD {
     enum tod_state tod_state;
     uint64_t tod_error;
     uint64_t pss_mss_ctrl_reg;
+    PnvCore *slave_pc_target;
 };
 
 struct PnvChipTODClass {
     DeviceClass parent_class;
 
     void (*broadcast_ttype)(PnvChipTOD *sender, uint32_t trigger);
+    PnvCore *(*tx_ttype_target)(PnvChipTOD *chiptod, uint64_t val);
 
     int xscom_size;
 };
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 16baea609c..0e932838aa 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1183,6 +1183,13 @@ DEXCR_ASPECT(SRAPD, 4)
 DEXCR_ASPECT(NPHIE, 5)
 DEXCR_ASPECT(PHIE, 6)
 
+/*****************************************************************************/
+/* PowerNV ChipTOD and TimeBase State Machine */
+struct pnv_tod_tbst {
+    int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
+    int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
+};
+
 /*****************************************************************************/
 /* The whole PowerPC CPU context */
 
@@ -1258,6 +1265,12 @@ struct CPUArchState {
     uint32_t tlb_need_flush; /* Delayed flush needed */
 #define TLB_NEED_LOCAL_FLUSH   0x1
 #define TLB_NEED_GLOBAL_FLUSH  0x2
+
+#if defined(TARGET_PPC64)
+    /* PowerNV chiptod / timebase facility state. */
+    /* Would be nice to put these into PnvCore */
+    struct pnv_tod_tbst pnv_tod_tbst;
+#endif
 #endif
 
     /* Other registers */
-- 
2.42.0


