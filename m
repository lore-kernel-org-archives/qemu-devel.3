Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A10606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ATW1ZGe0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLagi-0002cd-GE; Tue, 27 Oct 2026 02:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagT-0002EZ-82
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:21 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagQ-0008CP-EX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:20 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ad2b3b1c02so1868627a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082557; x=1793687357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sct4Ak5S29Iw3Slp/2/ovzK3S0lNLUnL6YBZFCGCQ9A=;
 b=ATW1ZGe0LeFqPsNS//BvIacMxte9m/UcIS/PK9PVTOIJy+QAHH7n9LPo6bQ2mHmy0X
 FMROsaAdzdTgGeUdqLLeP3IDsodVpR8mSRZJh31IgIqcFAP+9I8tLv1gxMw41ZWlE8c/
 PraUWF+RPDO7I0iE5LBTv79TzZKVYLrkxCXJFluRGeNBdwQDCW/0YxENJTBdhAR+pce5
 2vBfG0EdGvqojp5PDHHIWBGa8oJhZMw+3gRdFVId8z4s0VGT7dpgDpw991aicKbmFIT9
 Pa7QV+a7Tr36iKeaQWFeUsnOcqPjvgkPH1MFMZvMApAOYfE41hjx24yklREdE42AF+N9
 qRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082557; x=1793687357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sct4Ak5S29Iw3Slp/2/ovzK3S0lNLUnL6YBZFCGCQ9A=;
 b=K/RFV0Maj+v+NmVa+4Wvy5fUz9Tc2TKB3fXu18mB9KGH2a5A2OYGvY6GO/HRbWtaRM
 4OIoawg9kTO6ZGlcqhfhq7a0ufvfnPKv2m7KodrEz+tos4ybgnHfhGrDbopJ+epaH4qR
 yeHXlNF0OV1ZXs7b95S8bTMYpmwaUoJXtM7VqhNjwZz4bbtmoVWrs3JXcrmfw8QgVZEW
 JEK1GFI5IA9H8scvEgVN8DWdMS+nQGHJSW4ST3xe/wXHnPpPYU1IFVLbQ4n59dSaV3Bn
 vxpjnrcZ3zbyAE0/b5W0FhTRjY/PBv3UfnoDUqB8QFPGgFiC9WEymp0NP2OKwjrQQN0n
 m4Jw==
X-Gm-Message-State: AFq9FYIiCsjWjCH7lXqi1kBVpQ6krYsS+TL1YVlvg8pbjNfsS8jZXPpL
 VGS9Ypzab1euktA+MlRQlbh5Edf92O+VBUGNyru4kh39CMi6pXlGmb0vPGnybQ==
X-Gm-Gg: AYBFou15u5Ezam90x5qnLjP+kwKSuJ5uuHh/FVljt38Cggfm/JmmL7P1N7NIW8ZZedK
 iJ22dBsVfYUVLoOazWXyq6iCvqr57HXpLHEiR8X3x/EaQ27MXOxdPSAw+MBoYSMM9uNRDFgl9fg
 V9mHj40x7UlQ2P8GQSj5iT+AbBKJbxfy8XrjT8GDkf0yi5OggYW4cSr81Iu/o6IMoTnhmYoRUoB
 9U5XJMYg4i6x92Vdtue+k3nMeQ8gOOvqHm/35sIinoSmMNdPJzQdvQT5SC9ZgsbUs5hU2vKF/to
 8JY0O6HiLMEVmURtbXycEm0/FQtLDhe7NmsO7krAUYnahqurx2xVs20JbCqR8CjGF1QInVbV4Nq
 /xzwUs+zcSF1GZAPNG8KaCvkK0H9HLVAca2n27EeL7aLpyEV1H1KHfi33H7AwhZa2lw9ciL5/mv
 PqhNqMAHgfXAMBlnd5KrrY1Z7VygizKOCkBjcyx7/cGLgeWM0Uob38Yk0Q/ruWclCUj1nT4H9wx
 u47OmRyYtFxNI842XdWaR5ReAv9P4HOek+ENmiwfbMqXmvtAgXO8jOgJH98vwjrNko6RSZSjw==
X-Received: by 2002:a17:90b:2745:b0:3ac:9e5e:d195 with SMTP id
 98e67ed59e1d1-3adeaf9a767mr6851508a91.61.1793082556906; 
 Mon, 26 Oct 2026 23:29:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tan Chi <tanchi25@mails.ucas.ac.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/29] hw/riscv/riscv-iommu: reclaim invalidated IOATC entries
Date: Tue, 27 Oct 2026 16:27:55 +1000
Message-ID: <20261027062808.1995205-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tan Chi <tanchi25@mails.ucas.ac.cn>

IOTINVAL currently walks the IOATC hash table and invalidates matching
entries by setting iot->perm to IOMMU_NONE. The invalidated entries remain
in the hash table afterwards.

Under workloads with frequent DMA map/unmap activity, invalid entries can
accumulate while only a smaller number of entries remain valid. Subsequent
IOTINVAL operations continue to scan these entries. They are also included
in g_hash_table_size(), causing the IOATC to reach iot_limit earlier and
the entire cache to be flushed more frequently.

Remove matching entries during invalidation instead of leaving them in the
hash table with IOMMU_NONE.

The measurements use a Linux 7.3-rc5 guest based on linux-iommu/next
commit cec2dc7663e7 with v6 of the "iommu/riscv: Enable MSI remapping,
IOMMU_DMA and VFIO" series applied. The QEMU behavior is not specific to
this guest kernel; this configuration makes it easier to exercise through
normal DMA map/unmap activity.

In a high-churn NVMe workload with frequent DMA map/unmap activity, runtime
drops from 168 seconds to 35 seconds, a 4.8x speedup.

A short fio workload with a small working set remains within measurement
noise. Across three runs for each version of a 300-second fio workload with
a 4 GiB working set, median throughput improves from 68.6 MiB/s to
75.0 MiB/s, an increase of 9.3%.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20261017144533.15610-2-tanchi25@mails.ucas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 122 +++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 66 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 2ac479ee5038..77b93fab5fb8 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1582,104 +1582,93 @@ static guint riscv_iommu_iot_hash(gconstpointer v)
 /* GV: 0 AV: 0 PSCV: 0 GVMA: 0 */
 /* GV: 0 AV: 0 GVMA: 1 */
 static
-void riscv_iommu_iot_inval_all(gpointer key, gpointer value, gpointer data)
+gboolean riscv_iommu_iot_inval_all(gpointer key, gpointer value, gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag;
 }
 
 /* GV: 0 AV: 0 PSCV: 1 GVMA: 0 */
 static
-void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value, gpointer data)
+gboolean riscv_iommu_iot_inval_pscid(gpointer key, gpointer value,
+                                     gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->pscid == arg->pscid) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->pscid == arg->pscid;
 }
 
 /* GV: 0 AV: 1 PSCV: 0 GVMA: 0 */
 static
-void riscv_iommu_iot_inval_iova(gpointer key, gpointer value, gpointer data)
+gboolean riscv_iommu_iot_inval_iova(gpointer key, gpointer value, gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->iova == arg->iova) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->iova == arg->iova;
 }
 
 /* GV: 0 AV: 1 PSCV: 1 GVMA: 0 */
-static void riscv_iommu_iot_inval_pscid_iova(gpointer key, gpointer value,
-                                             gpointer data)
+static gboolean riscv_iommu_iot_inval_pscid_iova(gpointer key,
+                                                 gpointer value,
+                                                 gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->pscid == arg->pscid &&
-        iot->iova == arg->iova) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->pscid == arg->pscid &&
+           iot->iova == arg->iova;
 }
 
 /* GV: 1 AV: 0 PSCV: 0 GVMA: 0 */
 /* GV: 1 AV: 0 GVMA: 1 */
-static
-void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value, gpointer data)
+static gboolean riscv_iommu_iot_inval_gscid(gpointer key, gpointer value,
+                                            gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->gscid == arg->gscid) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->gscid == arg->gscid;
 }
 
 /* GV: 1 AV: 0 PSCV: 1 GVMA: 0 */
-static void riscv_iommu_iot_inval_gscid_pscid(gpointer key, gpointer value,
-                                              gpointer data)
+static gboolean riscv_iommu_iot_inval_gscid_pscid(gpointer key,
+                                                  gpointer value,
+                                                  gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->gscid == arg->gscid &&
-        iot->pscid == arg->pscid) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->gscid == arg->gscid &&
+           iot->pscid == arg->pscid;
 }
 
 /* GV: 1 AV: 1 PSCV: 0 GVMA: 0 */
 /* GV: 1 AV: 1 GVMA: 1 */
-static void riscv_iommu_iot_inval_gscid_iova(gpointer key, gpointer value,
-                                             gpointer data)
+static gboolean riscv_iommu_iot_inval_gscid_iova(gpointer key,
+                                                 gpointer value,
+                                                 gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->gscid == arg->gscid &&
-        iot->iova == arg->iova) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->gscid == arg->gscid &&
+           iot->iova == arg->iova;
 }
 
 /* GV: 1 AV: 1 PSCV: 1 GVMA: 0 */
-static void riscv_iommu_iot_inval_gscid_pscid_iova(gpointer key, gpointer value,
-                                                   gpointer data)
+static gboolean riscv_iommu_iot_inval_gscid_pscid_iova(gpointer key,
+                                                       gpointer value,
+                                                       gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->gscid == arg->gscid &&
-        iot->pscid == arg->pscid &&
-        iot->iova == arg->iova) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->gscid == arg->gscid &&
+           iot->pscid == arg->pscid &&
+           iot->iova == arg->iova;
 }
 
 /* caller must hold iot_lock */
@@ -1712,7 +1701,7 @@ static void riscv_iommu_iot_update(RISCVIOMMUState *s, RISCVIOMMUEntry *iot)
     g_hash_table_add(s->iot_cache, iot);
 }
 
-static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
+static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHRFunc func,
     uint32_t gscid, uint32_t pscid, hwaddr iova, RISCVIOMMUTransTag transtag)
 {
     RISCVIOMMUEntry key = {
@@ -1723,7 +1712,7 @@ static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
     };
 
     qemu_mutex_lock(&s->iot_lock);
-    g_hash_table_foreach(s->iot_cache, func, &key);
+    g_hash_table_foreach_remove(s->iot_cache, func, &key);
     qemu_mutex_unlock(&s->iot_lock);
 }
 
@@ -1972,7 +1961,8 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
     dma_addr_t addr;
     uint32_t tail, head, ctrl;
     uint64_t cmd_opcode;
-    GHFunc func;
+    GHRFunc iot_func;
+    GHFunc ctx_func;
 
     ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
     tail = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQT) & s->cq_mask;
@@ -2035,18 +2025,18 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
                 goto cmd_ill;
             }
 
-            func = riscv_iommu_iot_inval_all;
+            iot_func = riscv_iommu_iot_inval_all;
 
             if (gv) {
-                func = (av) ? riscv_iommu_iot_inval_gscid_iova :
+                iot_func = (av) ? riscv_iommu_iot_inval_gscid_iova :
                               riscv_iommu_iot_inval_gscid;
             }
 
             riscv_iommu_iot_inval(
-                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VG);
+                s, iot_func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VG);
 
             riscv_iommu_iot_inval(
-                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VN);
+                s, iot_func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VN);
             break;
         }
 
@@ -2066,24 +2056,24 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
             if (gv) {
                 transtag = RISCV_IOMMU_TRANS_TAG_VN;
                 if (pscv) {
-                    func = (av) ? riscv_iommu_iot_inval_gscid_pscid_iova :
+                    iot_func = (av) ? riscv_iommu_iot_inval_gscid_pscid_iova :
                                   riscv_iommu_iot_inval_gscid_pscid;
                 } else {
-                    func = (av) ? riscv_iommu_iot_inval_gscid_iova :
+                    iot_func = (av) ? riscv_iommu_iot_inval_gscid_iova :
                                   riscv_iommu_iot_inval_gscid;
                 }
             } else {
                 transtag = RISCV_IOMMU_TRANS_TAG_SS;
                 if (pscv) {
-                    func = (av) ? riscv_iommu_iot_inval_pscid_iova :
+                    iot_func = (av) ? riscv_iommu_iot_inval_pscid_iova :
                                   riscv_iommu_iot_inval_pscid;
                 } else {
-                    func = (av) ? riscv_iommu_iot_inval_iova :
+                    iot_func = (av) ? riscv_iommu_iot_inval_iova :
                                   riscv_iommu_iot_inval_all;
                 }
             }
 
-            riscv_iommu_iot_inval(s, func, gscid, pscid, iova, transtag);
+            riscv_iommu_iot_inval(s, iot_func, gscid, pscid, iova, transtag);
             break;
         }
 
@@ -2091,12 +2081,12 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
                              RISCV_IOMMU_CMD_IODIR_OPCODE):
             if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
                 /* invalidate all device context cache mappings */
-                func = riscv_iommu_ctx_inval_all;
+                ctx_func = riscv_iommu_ctx_inval_all;
             } else {
                 /* invalidate all device context matching DID */
-                func = riscv_iommu_ctx_inval_devid;
+                ctx_func = riscv_iommu_ctx_inval_devid;
             }
-            riscv_iommu_ctx_inval(s, func,
+            riscv_iommu_ctx_inval(s, ctx_func,
                 get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID), 0);
             break;
 
@@ -2106,9 +2096,9 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
                 /* illegal command arguments IODIR_PDT & DV == 0 */
                 goto cmd_ill;
             } else {
-                func = riscv_iommu_ctx_inval_devid_procid;
+                ctx_func = riscv_iommu_ctx_inval_devid_procid;
             }
-            riscv_iommu_ctx_inval(s, func,
+            riscv_iommu_ctx_inval(s, ctx_func,
                 get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID),
                 get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_PID));
             break;
-- 
2.55.0


