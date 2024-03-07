Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A04C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGE5-0005SI-6o; Thu, 07 Mar 2024 11:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGE3-0005RX-JN
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:04:07 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGE1-0006Lv-I3
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:04:07 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dd59b95677so5116695ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 08:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709827444; x=1710432244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXvSa8C+BXkOe83nsw1vLVz6jeTfH0D/qmyUUWWTv1c=;
 b=D7EdNnENEEAxIrheGKowQzMhNPPamX/sZfqr2WEjjz+8AgbccukcicUmekTQihyou/
 NKDcgIXCEtYmtKuMBy/rs4rG/Iye8lBhKQd/RlZwlT5ubQTOr6ofMsxgvV6b86G34oKw
 PaJ3uo1UgvrPWnEDGuYrtuvY1ECuMRY/iRXSgoOhPTRLkQlqDhGV24Kvk4QYcO/2IGx+
 g0hGjqPuxyVg1+gFJ2hUnos6MG7qEZ97I7Lrn8jp4uBdasXmLRsnw8FAUJW/vrzZmddP
 J4SZrQPtyVpXnZssv4RKvozPZ3xzm1FYaa4j4Ut/SBcsgJ34nAxrDPjkvEiHHpAS2xLi
 /rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709827444; x=1710432244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DXvSa8C+BXkOe83nsw1vLVz6jeTfH0D/qmyUUWWTv1c=;
 b=pTS7ueoInnElGqi+xKN/uo8vobGXHXFJxvuvJ32vyRiY4sZXZNs1TdGdVf404cDACM
 M3WvVnKGMZJvm0uM6bnWrFO+rki00AZKUmeT0OWh8tNEJp14UUXS7h8W9Zs62YM/RJI1
 ZFXG05+LcuBQvnlWqxVWeG5GVoFvwWDT78Y6/qSi6Qby77mPriNxRwZsxnGQmRQkGuyH
 +udV5An/TYzjNorzy40h8FRDQ+NNUOuXYw2+supRVTt/EDPiNbH2L6iP6ZefUOzLrcyM
 fwCDOE9d3bBne3i0KC+rVp4p+eaAfb/SHCf6qKWr/0cD7VdQ49zkCrWGGFMb2CrpLasC
 iIzA==
X-Gm-Message-State: AOJu0YySYXC1Rq2X3+7CVpYpwAgGs7TihNDyYl2p2mqX303yFsxLT8Te
 1AZKtjbQk0THPzbUDgeoNeRL0kFX7tTwrWOQcFOqqnNnI0LkGETJWBXoZhHs1XimYtyXHn1CkoU
 z
X-Google-Smtp-Source: AGHT+IHjLSJ5UIjmzOqGS92eCFc9Zt2TmEfuG/xfViUzeywujktTaN6ss0MUHOvvaKo/8o1T7l5GUg==
X-Received: by 2002:a17:903:2349:b0:1d7:4353:aba5 with SMTP id
 c9-20020a170903234900b001d74353aba5mr8300970plh.58.1709827443664; 
 Thu, 07 Mar 2024 08:04:03 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170903124b00b001db2b8b2da7sm14663136plh.122.2024.03.07.08.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 08:04:03 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 10/15] hw/riscv/riscv-iommu: add ATS support
Date: Thu,  7 Mar 2024 13:03:13 -0300
Message-ID: <20240307160319.675044-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307160319.675044-1-dbarboza@ventanamicro.com>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Add PCIe Address Translation Services (ATS) capabilities to the IOMMU.
This will add support for ATS translation requests in Fault/Event
queues, Page-request queue and IOATC invalidations.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv-iommu-bits.h |  43 ++++++++++++++-
 hw/riscv/riscv-iommu.c      | 107 +++++++++++++++++++++++++++++++++---
 hw/riscv/riscv-iommu.h      |   1 +
 hw/riscv/trace-events       |   3 +
 4 files changed, 145 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 9d645d69ea..0994f5ce48 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -81,6 +81,7 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
 #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
 #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
+#define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
 #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
 #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
 #define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
@@ -201,6 +202,7 @@ struct riscv_iommu_dc {
 
 /* Translation control fields */
 #define RISCV_IOMMU_DC_TC_V             BIT_ULL(0)
+#define RISCV_IOMMU_DC_TC_EN_ATS        BIT_ULL(1)
 #define RISCV_IOMMU_DC_TC_DTF           BIT_ULL(4)
 #define RISCV_IOMMU_DC_TC_PDTV          BIT_ULL(5)
 #define RISCV_IOMMU_DC_TC_PRPR          BIT_ULL(6)
@@ -259,6 +261,20 @@ struct riscv_iommu_command {
 #define RISCV_IOMMU_CMD_IODIR_DV        BIT_ULL(33)
 #define RISCV_IOMMU_CMD_IODIR_DID       GENMASK_ULL(63, 40)
 
+/* 3.1.4 I/O MMU PCIe ATS */
+#define RISCV_IOMMU_CMD_ATS_OPCODE              4
+#define RISCV_IOMMU_CMD_ATS_FUNC_INVAL          0
+#define RISCV_IOMMU_CMD_ATS_FUNC_PRGR           1
+#define RISCV_IOMMU_CMD_ATS_PID         GENMASK_ULL(31, 12)
+#define RISCV_IOMMU_CMD_ATS_PV          BIT_ULL(32)
+#define RISCV_IOMMU_CMD_ATS_DSV         BIT_ULL(33)
+#define RISCV_IOMMU_CMD_ATS_RID         GENMASK_ULL(55, 40)
+#define RISCV_IOMMU_CMD_ATS_DSEG        GENMASK_ULL(63, 56)
+/* dword1 is the ATS payload, two different payload types for INVAL and PRGR */
+
+/* ATS.PRGR payload */
+#define RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE      GENMASK_ULL(47, 44)
+
 enum riscv_iommu_dc_fsc_atp_modes {
     RISCV_IOMMU_DC_FSC_MODE_BARE = 0,
     RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 = 8,
@@ -322,7 +338,32 @@ enum riscv_iommu_fq_ttypes {
     RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH = 5,
     RISCV_IOMMU_FQ_TTYPE_TADDR_RD = 6,
     RISCV_IOMMU_FQ_TTYPE_TADDR_WR = 7,
-    RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 8,
+    RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ = 8,
+    RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 9,
+};
+
+/* Header fields */
+#define RISCV_IOMMU_PREQ_HDR_PID        GENMASK_ULL(31, 12)
+#define RISCV_IOMMU_PREQ_HDR_PV         BIT_ULL(32)
+#define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
+#define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
+#define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
+
+/* Payload fields */
+#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
+#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
+#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
+#define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
+#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
+#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
+
+
+/*
+ * struct riscv_iommu_msi_pte - MSI Page Table Entry
+ */
+struct riscv_iommu_msi_pte {
+      uint64_t pte;
+      uint64_t mrif_info;
 };
 
 /* Fields on pte */
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 03a610fa75..7af5929b10 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -576,7 +576,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
             RISCV_IOMMU_DC_IOHGATP_MODE_BARE);
         ctx->satp = set_field(0, RISCV_IOMMU_ATP_MODE_FIELD,
             RISCV_IOMMU_DC_FSC_MODE_BARE);
-        ctx->tc = RISCV_IOMMU_DC_TC_V;
+        ctx->tc = RISCV_IOMMU_DC_TC_EN_ATS | RISCV_IOMMU_DC_TC_V;
         ctx->ta = 0;
         ctx->msiptp = 0;
         return 0;
@@ -1021,6 +1021,18 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
     enable_pasid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
 
+    /* Check for ATS request. */
+    if (iotlb->perm == IOMMU_NONE) {
+        /* Check if ATS is disabled. */
+        if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS)) {
+            enable_pri = false;
+            fault = RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
+            goto done;
+        }
+        trace_riscv_iommu_ats(s->parent_obj.id, PCI_BUS_NUM(ctx->devid),
+                PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devid), iotlb->iova);
+    }
+
     iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
     perm = iot ? iot->perm : IOMMU_NONE;
     if (perm != IOMMU_NONE) {
@@ -1067,13 +1079,10 @@ done:
 
     if (enable_faults && fault) {
         struct riscv_iommu_fq_record ev;
-        unsigned ttype;
-
-        if (iotlb->perm & IOMMU_RW) {
-            ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
-        } else {
-            ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
-        }
+        const unsigned ttype =
+            (iotlb->perm & IOMMU_RW) ? RISCV_IOMMU_FQ_TTYPE_UADDR_WR :
+            ((iotlb->perm & IOMMU_RO) ? RISCV_IOMMU_FQ_TTYPE_UADDR_RD :
+            RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ);
         ev.hdr = set_field(0, RISCV_IOMMU_FQ_HDR_CAUSE, fault);
         ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE, ttype);
         ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, enable_pasid);
@@ -1105,6 +1114,73 @@ static MemTxResult riscv_iommu_iofence(RISCVIOMMUState *s, bool notify,
         MEMTXATTRS_UNSPECIFIED);
 }
 
+static void riscv_iommu_ats(RISCVIOMMUState *s,
+    struct riscv_iommu_command *cmd, IOMMUNotifierFlag flag,
+    IOMMUAccessFlags perm,
+    void (*trace_fn)(const char *id))
+{
+    RISCVIOMMUSpace *as = NULL;
+    IOMMUNotifier *n;
+    IOMMUTLBEvent event;
+    uint32_t pasid;
+    uint32_t devid;
+    const bool pv = cmd->dword0 & RISCV_IOMMU_CMD_ATS_PV;
+
+    if (cmd->dword0 & RISCV_IOMMU_CMD_ATS_DSV) {
+        /* Use device segment and requester id */
+        devid = get_field(cmd->dword0,
+            RISCV_IOMMU_CMD_ATS_DSEG | RISCV_IOMMU_CMD_ATS_RID);
+    } else {
+        devid = get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_RID);
+    }
+
+    pasid = get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_PID);
+
+    qemu_mutex_lock(&s->core_lock);
+    QLIST_FOREACH(as, &s->spaces, list) {
+        if (as->devid == devid) {
+            break;
+        }
+    }
+    qemu_mutex_unlock(&s->core_lock);
+
+    if (!as || !as->notifier) {
+        return;
+    }
+
+    event.type = flag;
+    event.entry.perm = perm;
+    event.entry.target_as = s->target_as;
+
+    IOMMU_NOTIFIER_FOREACH(n, &as->iova_mr) {
+        if (!pv || n->iommu_idx == pasid) {
+            event.entry.iova = n->start;
+            event.entry.addr_mask = n->end - n->start;
+            trace_fn(as->iova_mr.parent_obj.name);
+            memory_region_notify_iommu_one(n, &event);
+        }
+    }
+}
+
+static void riscv_iommu_ats_inval(RISCVIOMMUState *s,
+    struct riscv_iommu_command *cmd)
+{
+    return riscv_iommu_ats(s, cmd, IOMMU_NOTIFIER_DEVIOTLB_UNMAP, IOMMU_NONE,
+                           trace_riscv_iommu_ats_inval);
+}
+
+static void riscv_iommu_ats_prgr(RISCVIOMMUState *s,
+    struct riscv_iommu_command *cmd)
+{
+    unsigned resp_code = get_field(cmd->dword1,
+                                   RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE);
+
+    /* Using the access flag to carry response code information */
+    IOMMUAccessFlags perm = resp_code ? IOMMU_NONE : IOMMU_RW;
+    return riscv_iommu_ats(s, cmd, IOMMU_NOTIFIER_MAP, perm,
+                           trace_riscv_iommu_ats_prgr);
+}
+
 static void riscv_iommu_process_ddtp(RISCVIOMMUState *s)
 {
     uint64_t old_ddtp = s->ddtp;
@@ -1260,6 +1336,17 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
                 get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_PID));
             break;
 
+        /* ATS commands */
+        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_ATS_FUNC_INVAL,
+                             RISCV_IOMMU_CMD_ATS_OPCODE):
+            riscv_iommu_ats_inval(s, &cmd);
+            break;
+
+        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_ATS_FUNC_PRGR,
+                             RISCV_IOMMU_CMD_ATS_OPCODE):
+            riscv_iommu_ats_prgr(s, &cmd);
+            break;
+
         default:
         cmd_ill:
             /* Invalid instruction, do not advance instruction index. */
@@ -1648,6 +1735,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     if (s->enable_msi) {
         s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
     }
+    if (s->enable_ats) {
+        s->cap |= RISCV_IOMMU_CAP_ATS;
+    }
     if (s->enable_s_stage) {
         s->cap |= RISCV_IOMMU_CAP_SV32 | RISCV_IOMMU_CAP_SV39 |
                   RISCV_IOMMU_CAP_SV48 | RISCV_IOMMU_CAP_SV57;
@@ -1765,6 +1855,7 @@ static Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
         LIMIT_CACHE_IOT),
     DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
+    DEFINE_PROP_BOOL("ats", RISCVIOMMUState, enable_ats, TRUE),
     DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
     DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
     DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 9b33fb97ef..47f3fdad58 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -38,6 +38,7 @@ struct RISCVIOMMUState {
 
     bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
     bool enable_msi;      /* Enable MSI remapping */
+    bool enable_ats;      /* Enable ATS support */
     bool enable_s_stage;  /* Enable S/VS-Stage translation */
     bool enable_g_stage;  /* Enable G-Stage translation */
 
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 42a97caffa..4b486b6420 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -9,3 +9,6 @@ riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iov
 riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%"PRIx64" 0x%"PRIx64
 riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
 riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed"
+riscv_iommu_ats(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: translate request %04x:%02x.%u iova: 0x%"PRIx64
+riscv_iommu_ats_inval(const char *id) "%s: dev-iotlb invalidate"
+riscv_iommu_ats_prgr(const char *id) "%s: dev-iotlb page request group response"
-- 
2.43.2


