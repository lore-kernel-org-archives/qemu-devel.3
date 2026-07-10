Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB86C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qm-00029s-O2; Thu, 09 Jul 2026 22:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qg-0001tp-9D
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:31 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qe-00007C-57
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:29 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c9d1fc053e0so433919a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652246; x=1784257046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q0q6cG7Yzjl2GPwUteIZiV0o0F/pUXyv/mqLmsuEf8U=;
 b=XV10ZutUQWtr8lcAAP+CThcEk0GRepHlFpGdsD0ecH4/bRNuq4MTE0IzwnhBoQDfot
 uf0VKuj6/Cwro+XYH59SUQLGR1e86LPfV4yPvmLu3lV5/UdAfgpQXL2V5q6ERaKLoRsl
 QKXaNC5zRzlPKdc48EIIxPxAstin3VNjiWzFcoDQjtmXebywhpWWB9C4YS1ks/BWC20K
 Jw8pzpJh3VMzm1bgzYBJY30EOzoBqB5XJoRUYPRHhNj7JGoNSRpfALTSLWueZR1D4fYA
 by94CpZP0vRST54T4Nwx9fPrufdGmcqV//D3ft66FcUQ3yKQ8bGvdtjxp1oMX7mr7K7d
 Dfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652246; x=1784257046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q0q6cG7Yzjl2GPwUteIZiV0o0F/pUXyv/mqLmsuEf8U=;
 b=Rp0XN2Nl1J0/d2BMiU6k/hYLu/MlYnjt2SCpZIfXjRX1Y2VYXcf43l+ht2S6hbH+vQ
 taV72Uo4DP04xL1fHx1zgJGipGrUvIBmirVK6tCYqM+SOkFhBbpOpUNXRdS676B+M8r3
 KeievMoOKCTRd9Zh9p4hxaHe+TtzLH4L1ObTReWDIX46scqe7wo+qCsKVuuc/IOEUIJl
 lsZ84YUXZx4DyXc8PPxpb4ZzHzS8XD5WK5JXZo4jEUHv7f2DgzY4bH5/acf7XxIcoTz4
 ev6C8nSUcDmcyc+ENLoDx45am9SHnOqH1xIqD7oJD1Jv2kUdROayuFgeAtAPuH83V5Po
 fg5w==
X-Gm-Message-State: AOJu0YxCL7kB0SyKmgiwOV9jU9V1piDmS6yLcymCSBmaaelbpn2mCNJe
 mUfzjChkKxr4UuVvcUPMi+N+f4oR60j/tyNZkBonVTeuguXPJJWbepy0vRcvzw==
X-Gm-Gg: AfdE7cnwpIkLOInccE2MAv05KShCCYGNh7pbQTizCwaFG1MMYtm/j14wQ+HYfWSTa9Z
 +Pt9I2+cWGZXgWTujmYHR+prV12iPUuozSozgvYKsZlAF6nJ3Zq638CEL9ioC5ajReY4zZqtGwm
 vAdLkW8D3f4q3wHNEIsJHbwO+F2YrZECnbcmihZeDHH2FkuGPMpbVSO/RdxY1HJY9vvrRx79OnW
 ELSFZNU8GCVu42jImsY2IGNpU1c7OBFe7EacZYSgUyJQdAZfGjgQBhfimzGcgfLBrr6Sn8OMmo4
 xOMY35UgeSncNYg9EUMUFuOgaMYvXts4FN0hO9/H9JCzbsJYlCge2aBMoH2tL5Ojt6Z+G0uYGyq
 673rO4kY79s+lpK7Xvmmklid+78wxcDIkaE0yHLisktqXw2BhrjJTuewNPF7kRoR0vTHoRH+BUr
 +kXeHh34HPC7HbA3UJgga37I+3iBbyAVc=
X-Received: by 2002:a05:6a21:6e43:b0:3bf:6c08:2847 with SMTP id
 adf61e73a8af0-3c0bd274a73mr11839943637.54.1783652246419; 
 Thu, 09 Jul 2026 19:57:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/40] hw/riscv/riscv-iommu.c: set ftype and iova in
 riscv_iommu_ctx()
Date: Fri, 10 Jul 2026 12:55:19 +1000
Message-ID: <20260710025525.1704417-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We're hardcoding faulting type as READ, where it could very well be a
write access, and we're not recording the faulting addr/iova.

A note was added in the fault_type logic because I wasn't able to
trivially handle a probable code repeitition it in this same patch.
Something to do in a later date.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3564
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260701092241.307801-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 877d24bc47..f6865d1e16 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1430,6 +1430,7 @@ static void riscv_iommu_ctx_inval(RISCVIOMMUState *s, GHFunc func,
 /* Find or allocate translation context for a given {device_id, process_id} */
 static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
                                           unsigned devid, unsigned process_id,
+                                          IOMMUAccessFlags perm, uint64_t iova,
                                           void **ref)
 {
     GHashTable *ctx_cache;
@@ -1439,6 +1440,7 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
         .process_id = process_id,
     };
     unsigned mode = get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
+    uint32_t fault_type;
 
     ctx_cache = g_hash_table_ref(s->ctx_cache);
 
@@ -1481,8 +1483,21 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
     g_hash_table_unref(ctx_cache);
     *ref = NULL;
 
-    riscv_iommu_report_fault(s, ctx, RISCV_IOMMU_FQ_TTYPE_UADDR_RD,
-                             fault, !!process_id, 0, 0);
+    /*
+     * TODO: (1) do we need to distinguish other fault types
+     * for ctx fetching and (2) evaluate putting the 'fault_type'
+     * logic inside riscv_iommu_report_fault() - there's at
+     * least one other place (end of riscv_iommu_translate())
+     * that does something similar.
+     */
+    if (perm & IOMMU_RO) {
+        fault_type = RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
+    } else {
+        fault_type = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
+    }
+
+    riscv_iommu_report_fault(s, ctx, fault_type, fault,
+                             !!process_id, iova, 0);
 
     g_free(ctx);
     return NULL;
@@ -2233,6 +2248,8 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
     uint64_t ctrl = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_TR_REQ_CTL);
     unsigned devid = get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_DID);
     unsigned pid = get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_PID);
+    IOMMUAccessFlags perm = ctrl & RISCV_IOMMU_TR_REQ_CTL_NW
+                            ? IOMMU_RO : IOMMU_RW;
     RISCVIOMMUContext *ctx;
     void *ref;
 
@@ -2240,7 +2257,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
         return;
     }
 
-    ctx = riscv_iommu_ctx(s, devid, pid, &ref);
+    ctx = riscv_iommu_ctx(s, devid, pid, perm, iova, &ref);
     if (ctx == NULL) {
         riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE,
                                  RISCV_IOMMU_TR_RESPONSE_FAULT |
@@ -2248,7 +2265,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
     } else {
         IOMMUTLBEntry iotlb = {
             .iova = iova,
-            .perm = ctrl & RISCV_IOMMU_TR_REQ_CTL_NW ? IOMMU_RO : IOMMU_RW,
+            .perm = perm,
             .addr_mask = ~0,
             .target_as = NULL,
         };
@@ -2587,7 +2604,7 @@ static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
     /* FIXME: PCIe bus remapping for attached endpoints. */
     devid |= s->bus << 8;
 
-    ctx = riscv_iommu_ctx(s, devid, 0, &ref);
+    ctx = riscv_iommu_ctx(s, devid, 0, IOMMU_RW, addr, &ref);
     if (ctx == NULL) {
         res = MEMTX_ACCESS_ERROR;
     } else {
@@ -2889,7 +2906,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
     };
     uint32_t devid = riscv_iommu_space_devid(as);
 
-    ctx = riscv_iommu_ctx(as->iommu, devid, iommu_idx, &ref);
+    ctx = riscv_iommu_ctx(as->iommu, devid, iommu_idx, flag, addr, &ref);
     if (ctx == NULL) {
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
-- 
2.54.0


