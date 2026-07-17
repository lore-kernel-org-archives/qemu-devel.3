Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01116C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkgfX-0005ex-55; Fri, 17 Jul 2026 07:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wkgfU-0005dz-PS
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:23:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wkgfS-0008Jk-S9
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:23:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HATONo1388536
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=czT540BGHprotdvyBya4XBVf8GAhAsGl4mo
 u0i7NKxs=; b=JMu2hivdWtZ2MkpgGots7lmuWSZPKmf0eptjpSJFS27ShNZYO/5
 pINV9bDEZwN63QXVDjDt9u+YkLJW6dqfolK1hRgYNGL5UYg3cEsr673NYzTGO2HZ
 Oy6k8+O+vS3zUu3gZAeKBaQHE9CY4mhlWxF8uftwR+f0UO5F1XgxAhMcEJT9YaUg
 EgrnbN9j/99hgMWL9fUgaaajX2D8M7ROS+AEh+PooCPazhLnnlfdFd1vo6hZiWIE
 6fF2dxGekTtmuUEP4zZxR7fhx6kmiUi4SMawMzO1MRm78lTi5k8WfRJju1fdBZrk
 J7nj/U241Pv7KUEXnsEH8Vpn7uoYhUUvJMQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9p91x7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:23:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8fdace20927so54307686d6.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784287423; x=1784892223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=czT540BGHprotdvyBya4XBVf8GAhAsGl4mou0i7NKxs=;
 b=KuNbhJrluNlrO1mesJ/Yr62ZgihRYfqm4xYRZL0Eap0o4nfrUeS1fgT2QAsz6j7qTg
 XW8JZJYrBoGlX/No2YOS0YDq/rICJTmfIAFS0sm55QnZhvfrt2FSymxKeBvxWfVVdmEi
 dj6t3UojuB3XdLIk/fUguUb8fhIdPptgBMQhtS3PqDmbHZalmLaedgu3hGU50tVwhx2H
 tNUPfArWEyO4999gVLXqfksUgETqrLIhHpPt88JksnE3vFFXOJ+JlQvFB6/ZG303tXfU
 tpuZJK8kKAY3bpCafTqi88674TI/ULLwGJzyBfxfRqOgk4CCiWKNffsnugvdDiiidRh6
 iZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784287423; x=1784892223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=czT540BGHprotdvyBya4XBVf8GAhAsGl4mou0i7NKxs=;
 b=fyhuXP7n+TZHXUUJebBX0BHxyMdJHntBLPuB0P7FHGSF/fjOB1B9n6GVxJ6cKgd9bd
 ePwqfqwkwp4Tg+66c9cZmq805UwzcOVXqZFU5mkwfOWRe+7prG4pM975kzz30zAyLybM
 /HcMFibXrgC2o/i5Fo3zCVpjT/fyA30YVf+mFKNhsvVxXv+94xhdTfdClFJ12TbOOsXx
 /Mpo876u1zzsPF0UrwVyOGcycyHgqzSmwjxlvRbojG8LkX4sPo1fctBSk5OEjuXYGIk/
 mxhUyEbjzDzb2wc67g5VivF8sNJvUmwN/fkpPZ09iWhvCwza6fhSNF/rUWMDFpVWysLx
 RzmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTm4PR/84Lu+d4mxaT49o8zy2suvi6ubp9Hf5jrJlt07iC2ToaRqjfCBGdb9nyIjogxxfqo4baWab5@nongnu.org
X-Gm-Message-State: AOJu0Yxd+8Qn3OkE7c2Q0JXhasilRJQzQS/he1TnCK/hOwEUnTZzcU6Q
 BBUsHQv9qQGTGO62bM8RzJSb/CpyVAyeh4J5RQsUPVIDQllZeezP7CDLDeOv+tHaoAZ2UWE7BZ8
 kG553HC08/FgaNrrfqZrQpQQJPUNVnF6dMlTqOkot1SX8wytORl1wNB5uCw==
X-Gm-Gg: AfdE7cmwJ2gc8f6Q+762FCwSVAvQX4djgLBE5drtP3atsuD8snIPvkNcHu+j90jhpDt
 Lkh0tu81ANXJ5//tSXQzn3ij/Vqy3mJ+OzN97G2dIQujzvILP7LpCx07ZMHs3LY0kBbn2lbY948
 YJbiowmAjrg3h2j1moyPDKO6gLLyfeTGSq3DPkkavH2k/G3VQqE+QL1h0WVjUqxFwAsEvqmeAMK
 5wyp5iXpw2NE37mOzu1ey+9K1zdTuvu8CVJJGQqn9cqltVin33NxAKzdqEHdDYMlrxftnDX5a2+
 qexwKCAApWSrBFu009yZP8LLmLxBQEA5aupX+EQulgBv78jzIXRKQPQE2Tl+ZBDiNcePcwa6YjY
 8Gs1L+UziANL3PNcMJzeBxUulHQwybIC9o25f87XJ
X-Received: by 2002:a05:622a:3ce:b0:51b:fdd4:a1d6 with SMTP id
 d75a77b69052e-5213cbd581bmr17073551cf.31.1784287423513; 
 Fri, 17 Jul 2026 04:23:43 -0700 (PDT)
X-Received: by 2002:a05:622a:3ce:b0:51b:fdd4:a1d6 with SMTP id
 d75a77b69052e-5213cbd581bmr17073271cf.31.1784287423058; 
 Fri, 17 Jul 2026 04:23:43 -0700 (PDT)
Received: from localhost (85-207-54-79.static.bluetone.cz. [85.207.54.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69e6fee330fsm530949a12.3.2026.07.17.04.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 04:23:42 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com
Subject: [PATCH] hw/riscv/riscv-iommu: fix U-bit check to apply only to leaf
 S/VS-stage PTEs
Date: Fri, 17 Jul 2026 13:23:40 +0200
Message-ID: <20260717112340.1071148-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: G1vZr2SmoD29MtS2IQsP5HjfUyM5xAON
X-Proofpoint-ORIG-GUID: G1vZr2SmoD29MtS2IQsP5HjfUyM5xAON
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExNSBTYWx0ZWRfXx3ecIJw+aSiJ
 PiZldvIhff+QK01kHrRXzoCDbzsiedHWrK3FoEvPv5oDHmydcN2fXdEjsEfOt3kp0Rh0VFO9/MO
 nE+EtdZri1tb5xTxnQqF+e8GWrdBD8/a3FuQr0BgsOK0mT1g9P8J7E9iyX9HkmnTKUNUzD8yFYd
 bjtQxl2FqL5+SY4k508/YRUmwaxS/LexTBCrxHLF5777Bp3uUlmRWjVEDY1iC+XtcKSlxHC4fb5
 BUT1hRME2a3V0Ckhx6pcC9yXisGCslEyvSs9+E8ecAKnTj1qDAQCCLp/L/QhXwUYjuOYY1lTTun
 HGxlwLrLbVee54NNb8u+whse7TBaxOr4XoRPcNMrggguXlOBC9IfuxA9FBZT/eg6Uidw6bfncAJ
 KET9OzZd1SiA2aZTftp1Fevk6dkkgCqk02wD0/U4gwINKbrL4DZZhfsAi+Mq6enUsemPuv7ObD2
 vjwecCaLM7T+YiD540A==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a5a10c0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=sMQditckXvAul1hrnTxjdA==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=67zmbIgRDZDG84ANJA8A:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExNSBTYWx0ZWRfX25ciRQPYHyKZ
 bxY03fNAxUH33U2JCqMDjvqRs0mz6rhznqxiORTlU95UiySry73WL4yKXmBwSiiWFp+WOvsXrD/
 97yVujB57L70oZm8MJ/AeZq0soLkuos=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170115
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Commit b795ea0ba471 ("hw/riscv/riscv-iommu.c: fault when !PTE_U and
no priv access") placed its check ahead of the leaf-vs-non-leaf
branch in riscv_iommu_spa_fetch(), so it fires on every PTE walked,
including non-leaf/table entries. Per the RISC-V privileged spec's
address translation algorithm (Sv39/Sv48/etc., the "leaf PTE has
been reached" step, followed separately by the U-bit permission
check), the U bit is only defined and checked for the leaf PTE
reached at the end of the walk -- non-leaf PTEs don't carry a
meaningful U bit at all.

Move the check after the leaf/non-leaf branch, alongside the other
leaf-only checks, mirroring how the G_STAGE U-bit check (added in
9158c900ab30) is already correctly placed.

Fixes: b795ea0ba471 ("hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access")
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index f6865d1e164e..ed9fb09f8bc7 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -476,13 +476,6 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Invalid PTE */
         } else if (pte & PTE_RESERVED(false)) {
             break;                /* Reserved PTE bits set */
-        } else if (!(pte & PTE_U) && !pv) {
-            /*
-             * All accesses are assumed to be User mode unless
-             * process_id is valid (pv).  In case we have a
-             * non-user mode PTE and !pv we need to fault.
-             */
-            break;
         } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
             base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
         } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
@@ -491,6 +484,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Reserved leaf PTE flags: PTE_W + PTE_X */
         } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
             break;                /* Misaligned PPN */
+        } else if (!(pte & PTE_U) && !pv) {
+            /*
+             * All accesses are assumed to be User mode unless
+             * process_id is valid (pv).  In case we have a
+             * non-user mode leaf PTE and !pv we need to fault.
+             */
+            break;
         } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
             break;                /* Read access check failed */
         } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
-- 
2.43.0


