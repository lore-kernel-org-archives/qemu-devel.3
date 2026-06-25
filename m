Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB533CDE012
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrJZ-0001Ou-2u; Thu, 25 Jun 2026 17:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcrJW-0001Nv-RV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:08:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcrJU-0000XK-Jm
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:08:46 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFe6Hw2192044
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 21:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gDUPDK423dk
 7DGFaCufXXLoQFk+vlVA5ode5RrhMdqs=; b=R2vpomdlgP6gM64Zb7BFfUYhsnG
 iFklg6y6zPlBraT+N9V1ygdUYaoO73FT3y/rChkNtzUS0UMoJw+G0WmeMjGPkDXa
 4hHqBAoa8anAdKLeUZLQOHyKkRyVJ3etGCBi9nVmKNYR1v3VUBoPoMEmlRKYMdXb
 5Po+honLsQmZKIC2LY+TsAMqa+PvN+Ddkx5VJqLfY369Q58UgTk33MjUkHBJ4nna
 haR6LJkHo656XiqSSZKz2+1sv+Em4Cn/w2n2514w/oucy2mOuPKtRFSK8B1p3zor
 R3spaDu1GopzjcppR31QHTz4eboddB6/JsaJhPgTlfbeY5N0GKQ/uYXuhjg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uudm7de-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 21:08:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915c364ae3bso52217985a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782421722; x=1783026522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDUPDK423dk7DGFaCufXXLoQFk+vlVA5ode5RrhMdqs=;
 b=JO89XvP66n0SmC7pI8Ursjw1bdidhYdr2s3TwpkoAmngZ88N1w2zefshlc5twEu4ow
 K/Da2RAV3/yoVx/Y2w90bbiHP1+SF6G2y91tXAXsP/Y422tQkXrF8RRrys3OyBpmgD8x
 InSNsOUBNtJujyhcGAjpUP+brEOi/UABqRuIlK85FPBJE6DRL3ahi64s3p9DjgMtWvs3
 q8Ra6ilSW06BV+vyW/15PeGZ+CzY9hLJ9qSMI0XoWXPBhRCiPnsKl0ljt8vrMV8onLzW
 ZMnzpkr1Igxyn7IEdoOILq4NyhDhL1bYvh2WDo8ofZW+0GpvinkqCLkJYRlqJcT6JEUP
 AQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782421722; x=1783026522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gDUPDK423dk7DGFaCufXXLoQFk+vlVA5ode5RrhMdqs=;
 b=m/KiMpnzAWRUdsSAUwJSGs9DU/T935ijV922dDKOGu7T2or99mbSe9eoOUls9IiiNU
 bKgRQBXBlj5Ln99GvJ8zrBUooWOqY1FWD/fybX0JGYiPEYgItdGE1ccAwCGKD2FBq0V2
 DPkbGWr1n3TzBPHhG12bKt53kiIsBeQmdaGYh8t+IHmMO3qDMlS3c0+j/AodvcrR5zJi
 ThiSXOeohPH1Yi4INDLZeEwF59qijDnXxuTEMZAlzEoyx5KHx6xFPfiPtXpJawi2I975
 ABOY6Ytzzh3Jw1TxKuA9I5kmlg3N74X+v1Wx7Em9pKyeP0cKMW/d0KZtyGbUlx5ykgCs
 aMqA==
X-Gm-Message-State: AOJu0YxA2yeJ8MzWyyo+yD3il2Tqa+XZOwVfP3l2liwfNC5z43UZqmBb
 twXc++kbVVmZgKEt21404hYmKdXxJQ0miGyK9YCEbCW39tDookd85e5Qg9hX/WFX1/BDH8CfNRB
 dxw9dLsths7rx5SInvs//zH38C5PwHjpd+w/CV+5PtnrTuyGVgvMzDadvqYz4Ii0x2g==
X-Gm-Gg: AfdE7clx4Z5pwvkPRkysFAfJFkoyJkvA6TulQQxv01qh2KnASxs4Co1/rPr9n+Z/NRM
 iGb77G46RJuUzDADtPWfQVX2OCv/XjylkW0kl44GiaKLPt4Bn5UQREnEYtWYhPQz3GduysF1Qqx
 hc1b4Tuj5ATzx4aO9yDfYUOye3wSy19SDc/3wuP/8upR8zgixtiJJ5fxIfDV+A/xmYC1GnwR1JV
 lQpR2yZoih9jyhQ/uUZ1Ub/TeQpF0rD1HfT078MwCyMSYVGDNSfkzCdiUTV/hZpMDr9gBmnF9As
 vZ40xUxcCdOXyGkJ9Y44kTvx1iGfrioHySgbCa9zuX0CcAHsoh/MkzG7wTOVZiXWMKSiD39V6dq
 sUlo5WG5MRnkChdZMR06/H0TBEcmn/3NvOtIZZSBvmDLeRg==
X-Received: by 2002:a05:620a:2613:b0:921:a4ed:2d06 with SMTP id
 af79cd13be357-9293a6b126amr749670285a.4.1782421721802; 
 Thu, 25 Jun 2026 14:08:41 -0700 (PDT)
X-Received: by 2002:a05:620a:2613:b0:921:a4ed:2d06 with SMTP id
 af79cd13be357-9293a6b126amr749660485a.4.1782421721248; 
 Thu, 25 Jun 2026 14:08:41 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ac1acsm920733485a.32.2026.06.25.14.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 14:08:40 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 1/2] hw/riscv/riscv-iommu: rename regs_rw to regs
Date: Thu, 25 Jun 2026 18:08:32 -0300
Message-ID: <20260625210833.3294437-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625210833.3294437-1-daniel.barboza@oss.qualcomm.com>
References: <20260625210833.3294437-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE4MyBTYWx0ZWRfX6LmzRmFSn7qV
 Kiga/H5mI1ULjNnQH6Rv8KUIUg7rx6Qk8JJRArTE08Mjac30p81GAcuT0RHj/lgCuxm7tSkhg/G
 DxOLBfjyCQtmao6rW1s3uETVBYuyKqI=
X-Proofpoint-ORIG-GUID: DVWG4Piwy_xt8a8Fy6kAMujjkKtgCZAp
X-Proofpoint-GUID: DVWG4Piwy_xt8a8Fy6kAMujjkKtgCZAp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE4MyBTYWx0ZWRfX1M8j6niIpMBd
 GntZDi4PCr1KjZxGGSTcL99htOQBW9DWWIrrzXJLum7p5zmc9DSnewIOg3769oH5yI7ZgrRTSDV
 KTxAJMV3DFoRlzbS4Hxg/uo0t7RKVambpTp2ukOsR4K8dVSzQddX7ZcNaFHAbcIbDR7N/QyjPHN
 ZT1ejHhazdtPBxECMeDenSchpIY7QQ/dBQ4AVU1F57NvuWr8tJV+nJT8kSwFcFjmkuX1QVp2e0u
 oGspW4HKrO4l1RtstYNdmzrbwr5TwYYUjM7z3VznPkFhINEtxzk3Ib1SpubbpEycSp6tXVtHiMa
 WtdMKkOISMtlYjs0PM4NH0sibUaon9c/DDOT/bo/xZSjbVl79H/qkOvK/+6WicW2Z6DNUjevWUc
 b6Y2Y6F3DzQ5aXmUtmvYXQLzPD9qIjRNF1B27GjNX827QSPlj/wu64vKwGIum59sLVmGAxTza3P
 6LwUK05bxuyj4/vZORw==
X-Authority-Analysis: v=2.4 cv=HdckiCE8 c=1 sm=1 tr=0 ts=6a3d98db cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=DEm_bw29_yUsxB17_HcA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250183
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The existing nomenclature can be misleading: regs_rw can cosplay as
'read and write' mask, in particular because we have regs_ro which is a
read only mask.

regs_rw is the current reg value, and all bits that aren't on the
regs_ro mask is considered r/w bits.

Rename regs_rw to 'regs' to be on par with the nomenclature other
devices uses (e.g. cadence_gem).

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu-hpm.c |  4 ++--
 hw/riscv/riscv-iommu.c     | 36 ++++++++++++++++++------------------
 hw/riscv/riscv-iommu.h     | 26 +++++++++++++++-----------
 3 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index 5bf80a8db9..9bfef6db45 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -60,8 +60,8 @@ static void hpm_incr_ctr(RISCVIOMMUState *s, uint32_t ctr_idx)
     const uint32_t off = ctr_idx << 3;
     uint64_t cntr_val;
 
-    cntr_val = ldq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + off]);
-    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + off], cntr_val + 1);
+    cntr_val = ldq_le_p(&s->regs[RISCV_IOMMU_REG_IOHPMCTR_BASE + off]);
+    stq_le_p(&s->regs[RISCV_IOMMU_REG_IOHPMCTR_BASE + off], cntr_val + 1);
 
     trace_riscv_iommu_hpm_incr_ctr(cntr_val);
 
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index a500cb8440..30f16b999c 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2034,8 +2034,8 @@ static void riscv_iommu_process_cq_control(RISCVIOMMUState *s)
         s->cq_mask = (2ULL << get_field(base, RISCV_IOMMU_CQB_LOG2SZ)) - 1;
         s->cq_addr = PPN_PHYS(get_field(base, RISCV_IOMMU_CQB_PPN));
         stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~s->cq_mask);
-        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQH], 0);
-        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQT], 0);
+        stl_le_p(&s->regs[RISCV_IOMMU_REG_CQH], 0);
+        stl_le_p(&s->regs[RISCV_IOMMU_REG_CQT], 0);
         ctrl_set = RISCV_IOMMU_CQCSR_CQON;
         ctrl_clr = RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQMF |
                    RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CMD_TO |
@@ -2075,8 +2075,8 @@ static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)
         s->fq_mask = (2ULL << get_field(base, RISCV_IOMMU_FQB_LOG2SZ)) - 1;
         s->fq_addr = PPN_PHYS(get_field(base, RISCV_IOMMU_FQB_PPN));
         stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQH], ~s->fq_mask);
-        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQH], 0);
-        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQT], 0);
+        stl_le_p(&s->regs[RISCV_IOMMU_REG_FQH], 0);
+        stl_le_p(&s->regs[RISCV_IOMMU_REG_FQT], 0);
         ctrl_set = RISCV_IOMMU_FQCSR_FQON;
         ctrl_clr = RISCV_IOMMU_FQCSR_BUSY | RISCV_IOMMU_FQCSR_FQMF |
             RISCV_IOMMU_FQCSR_FQOF;
@@ -2105,8 +2105,8 @@ static void riscv_iommu_process_pq_control(RISCVIOMMUState *s)
         s->pq_mask = (2ULL << get_field(base, RISCV_IOMMU_PQB_LOG2SZ)) - 1;
         s->pq_addr = PPN_PHYS(get_field(base, RISCV_IOMMU_PQB_PPN));
         stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQH], ~s->pq_mask);
-        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQH], 0);
-        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQT], 0);
+        stl_le_p(&s->regs[RISCV_IOMMU_REG_PQH], 0);
+        stl_le_p(&s->regs[RISCV_IOMMU_REG_PQT], 0);
         ctrl_set = RISCV_IOMMU_PQCSR_PQON;
         ctrl_clr = RISCV_IOMMU_PQCSR_BUSY | RISCV_IOMMU_PQCSR_PQMF |
             RISCV_IOMMU_PQCSR_PQOF;
@@ -2276,9 +2276,9 @@ static void riscv_iommu_write_reg_val(RISCVIOMMUState *s,
 {
     uint64_t ro = ldn_le_p(&s->regs_ro[reg_addr], size);
     uint64_t wc = ldn_le_p(&s->regs_wc[reg_addr], size);
-    uint64_t rw = ldn_le_p(&s->regs_rw[reg_addr], size);
+    uint64_t curr_val = ldn_le_p(&s->regs[reg_addr], size);
 
-    stn_le_p(dest, size, ((rw & ro) | (data & ~ro)) & ~(data & wc));
+    stn_le_p(dest, size, ((curr_val & ro) | (data & ~ro)) & ~(data & wc));
 }
 
 static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
@@ -2378,12 +2378,12 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
      * is set IOMMU behavior of additional writes to the register
      * is UNSPECIFIED.
      */
-    riscv_iommu_write_reg_val(s, &s->regs_rw[addr], addr, size, data);
+    riscv_iommu_write_reg_val(s, &s->regs[addr], addr, size, data);
 
     /* Busy flag update, MSB 4-byte register. */
     if (busy) {
-        uint32_t rw = ldl_le_p(&s->regs_rw[regb]);
-        stl_le_p(&s->regs_rw[regb], rw | busy);
+        uint32_t rw = ldl_le_p(&s->regs[regb]);
+        stl_le_p(&s->regs[regb], rw | busy);
     }
 
     /* Process HPM writes and update any internal state if needed. */
@@ -2428,13 +2428,13 @@ static MemTxResult riscv_iommu_mmio_read(void *opaque, hwaddr addr,
          * it's not dependent over the timer callback and is computed
          * from cycle overflow.
          */
-        val = ldq_le_p(&s->regs_rw[addr]);
+        val = ldq_le_p(&s->regs[addr]);
         val |= (riscv_iommu_hpmcycle_read(s) & RISCV_IOMMU_IOHPMCYCLES_OVF)
                    ? RISCV_IOMMU_IOCOUNTOVF_CY
                    : 0;
         ptr = (uint8_t *)&val + (addr & 3);
     } else {
-        ptr = &s->regs_rw[addr];
+        ptr = &s->regs[addr];
     }
 
     val = ldn_le_p(ptr, size);
@@ -2529,7 +2529,7 @@ static void riscv_iommu_instance_init(Object *obj)
     s->cap |= RISCV_IOMMU_CAP_PD8;
 
     /* register storage */
-    s->regs_rw = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
+    s->regs = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
     s->regs_ro = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
     s->regs_wc = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
 
@@ -2554,7 +2554,7 @@ static void riscv_iommu_instance_finalize(Object *obj)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(obj);
 
-    g_free(s->regs_rw);
+    g_free(s->regs);
     g_free(s->regs_ro);
     g_free(s->regs_wc);
 
@@ -2608,8 +2608,8 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
         "riscv-iommu-regs", RISCV_IOMMU_REG_SIZE);
 
     /* Set power-on register state */
-    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_CAP], s->cap);
-    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_FCTL], 0);
+    stq_le_p(&s->regs[RISCV_IOMMU_REG_CAP], s->cap);
+    stq_le_p(&s->regs[RISCV_IOMMU_REG_FCTL], 0);
     stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FCTL],
              ~(RISCV_IOMMU_FCTL_BE | RISCV_IOMMU_FCTL_WSI));
     stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_DDTP],
@@ -2634,7 +2634,7 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
         RISCV_IOMMU_PQCSR_BUSY);
     stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
     stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_ICVEC], 0);
-    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_DDTP], s->ddtp);
+    stq_le_p(&s->regs[RISCV_IOMMU_REG_DDTP], s->ddtp);
     /* If debug registers enabled. */
     if (s->cap & RISCV_IOMMU_CAP_DBG) {
         stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_TR_REQ_IOVA], 0);
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 2a9f6fccd5..a778e86fb7 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -76,9 +76,13 @@ struct RISCVIOMMUState {
 
     /* MMIO Hardware Interface */
     MemoryRegion regs_mr;
-    uint8_t *regs_rw;  /* register state (user write) */
+    uint8_t *regs;  /* current register state */
     uint8_t *regs_wc;  /* write-1-to-clear mask */
-    uint8_t *regs_ro;  /* read-only mask */
+    /*
+     * read-only mask. NOTE: bits not present in this RO
+     * mask are assumed to be read and write.
+     */
+    uint8_t *regs_ro;
 
     QLIST_ENTRY(RISCVIOMMUState) iommus;
     QLIST_HEAD(, RISCVIOMMUSpace) spaces;
@@ -120,39 +124,39 @@ struct RISCVIOMMUContext {
 static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
     unsigned idx, uint32_t set, uint32_t clr)
 {
-    uint32_t val = ldl_le_p(s->regs_rw + idx);
-    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
+    uint32_t val = ldl_le_p(s->regs + idx);
+    stl_le_p(s->regs + idx, (val & ~clr) | set);
     return val;
 }
 
 static inline void riscv_iommu_reg_set32(RISCVIOMMUState *s, unsigned idx,
                                          uint32_t set)
 {
-    stl_le_p(s->regs_rw + idx, set);
+    stl_le_p(s->regs + idx, set);
 }
 
 static inline uint32_t riscv_iommu_reg_get32(RISCVIOMMUState *s, unsigned idx)
 {
-    return ldl_le_p(s->regs_rw + idx);
+    return ldl_le_p(s->regs + idx);
 }
 
 static inline uint64_t riscv_iommu_reg_mod64(RISCVIOMMUState *s, unsigned idx,
                                              uint64_t set, uint64_t clr)
 {
-    uint64_t val = ldq_le_p(s->regs_rw + idx);
-    stq_le_p(s->regs_rw + idx, (val & ~clr) | set);
+    uint64_t val = ldq_le_p(s->regs + idx);
+    stq_le_p(s->regs + idx, (val & ~clr) | set);
     return val;
 }
 
 static inline void riscv_iommu_reg_set64(RISCVIOMMUState *s, unsigned idx,
                                          uint64_t set)
 {
-    stq_le_p(s->regs_rw + idx, set);
+    stq_le_p(s->regs + idx, set);
 }
 
 static inline uint64_t riscv_iommu_reg_get64(RISCVIOMMUState *s,
-    unsigned idx)
+                                             unsigned idx)
 {
-    return ldq_le_p(s->regs_rw + idx);
+    return ldq_le_p(s->regs + idx);
 }
 #endif
-- 
2.43.0


