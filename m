Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086B8C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkjor-0006Xo-HS; Fri, 17 Jul 2026 10:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wkjok-0006X3-Hs
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:45:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wkjoi-0001e3-A9
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:45:34 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HE7qDa1875183
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 14:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=BvRoZwGnPxP1MvFPCRipUS24Heo1YSkKkPw
 HV9QMs2Q=; b=am35V1kYuwzZShP8s9cCdBxN0ebaJ2PlrE8DCthPLCEYHuv5PX/
 sklY/ZMfgQ1BQvxgGd2vu5snAGZTu7kPbpvnmzeUfny5buFJ/7lex6DMV6FTmXjh
 04PbIolGCOJhNxPgtwBUwpZ3kHuz1Nn+SSygdElU2OMW47a2cYEa8gG4QEBq5A+g
 0Snr6GylgqmOHQnpbd5P7JuHaImvLm0SEd0b/IdzrTiFZRD+BtSEcaU/k+QrxSOK
 ZWS1H605QvB18aVT/b4caWw1u67QMpY+l+2jkwRLSvNfEdtNDqyn4FSuZlnqjXPW
 gHocvT1J0NnZqU97yO+VsOV8R+4OqgU0I3A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9p9twk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 14:45:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso72398371cf.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784299530; x=1784904330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BvRoZwGnPxP1MvFPCRipUS24Heo1YSkKkPwHV9QMs2Q=;
 b=OewlvtH08Pz0Nca6yyDujyrPLoyLycNzJxuWqZpQ6e1n2+9w0mteo7MMmkSK2jkOWU
 LD5IasZyPHqexsY5AIyMCFdooAs9/nfQZE1mrNSU1sCb4keBGEBxIqqeeRwiSothep+i
 BluRzRQORC7ABjxw03MJuG8TjdIWv/bOASCOr5pOdHlwsgbHs3f3OumaVJquY5tCrc7T
 vztanrBR+XESA3rPgXFTtpetvHp79JwfIu3qT3LeY7cJU+lsf6SbsEqI81J3+sAMNpy/
 95/IwR1DRl8rfrRuJrPjDqfKalH/2VZslAi4RiGkgus3CypqrX2EXPMjfchXU73jl4WP
 9Kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784299530; x=1784904330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BvRoZwGnPxP1MvFPCRipUS24Heo1YSkKkPwHV9QMs2Q=;
 b=QlJT9IACIM902geAm8JW/rljb2vo7gOeKay9+xcyEzZTxR0MTyeuRcns3PIXX87Vyj
 cqWk3+uXzj5NOnH6HHj7jbnv98jAZkUz4bT1F1gSEG15QeTcs0wuEZDFZn2u2YlMnvU2
 13fZlIne3ssZTQnXKF+lHT1Q6jViwfl4gZ1d1QlOu1HP697wdVXu4SZaTFORZ2oCauHW
 xjU8mg13wi4F2oSFj8LWlJwmdU+LGdIy51g6xyWiqTWf78kXwu0enl7rNFOyYw84BnF6
 6jg1OrT4ThyfWYg6arYREDXbKoV6vFA1DOWKJvmB7bVUb55KjWoVfThCoha9gr/fT9k6
 1L8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoohX79eH4wp/vchui+lQiQDIQ7lBciUhJ2WG6IoeNTl1xpfs79DQgU/cYpNdAdwjAsBA4AAGduvnQK@nongnu.org
X-Gm-Message-State: AOJu0YyIvEiatuWLxAdfqOhINS3CxfUN7lpN988oDqbyJ/RVvgWTh1q6
 HKsXyn7FFaWwkrr8+F83U59ql7rodtnBwTEsYHMFY7zwvMxYGcAH293Pdpb1McUpaBzFxv26B/6
 pkDU1uAZr4rh2cg6jNbFnWSlW0B5z33uNc6wGVvcBhwDCPbzTldjkMQt/7g==
X-Gm-Gg: AfdE7cnXLG1BRdKYDTFHkMcu8hQSrXPquhCnLguYOGLwBsGdwE5nnVmtUpyvEcnVDQO
 TK1+aPnGjDKr8z8AY6bXMhLeq7aC5zDBOjbdvJKDIDYB17OxeT8kaRTOUZ2l+BguATpeJBsdi+D
 ohy8YesB0aayd2aM56zoFyziXf8RVQowjZZUBRdfe4aqvaF/MYGqBB8mi9NiDyMKNdkwASUuert
 PJIOOCJ3HIz11j1PNLImmyATIEaOqoj9WbE2TFmOKq5j8BXU/LAAOpFut5xpGxY7jvrC+P/M+0j
 ZG2F7d4uqveIkJblh4sjrCrEd51LuC8GUxw8Ezku0qp1Emw7bf32m/J28eOID2RHe024Gz5R+ly
 XUmhV8/z/+8ds9cWP/cjkbMXYBIZIBIim5J5KmCI/
X-Received: by 2002:a05:622a:4012:b0:51c:c29:d4c7 with SMTP id
 d75a77b69052e-5213fc54d38mr27413041cf.62.1784299530230; 
 Fri, 17 Jul 2026 07:45:30 -0700 (PDT)
X-Received: by 2002:a05:622a:4012:b0:51c:c29:d4c7 with SMTP id
 d75a77b69052e-5213fc54d38mr27411291cf.62.1784299528677; 
 Fri, 17 Jul 2026 07:45:28 -0700 (PDT)
Received: from localhost (85-207-54-79.static.bluetone.cz. [85.207.54.79])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b291e0ea1dsm374475e87.43.2026.07.17.07.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 07:45:27 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com
Subject: [PATCH] hw/riscv/riscv-iommu: preserve requested perm in spa_fetch()
Date: Fri, 17 Jul 2026 16:45:25 +0200
Message-ID: <20260717144525.1154204-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bmNDeUoHD7KQSsL3a0y3HvIDwIcV9Bt0
X-Proofpoint-ORIG-GUID: bmNDeUoHD7KQSsL3a0y3HvIDwIcV9Bt0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfXxeYNngJ9eqIx
 B5hq4xnelSjYril38QgaO3A6eQr95jyJNVk8SUlo9YdBU04ixmHAE+Bk+8xVX2LBuGSwualFOfP
 FZOhPD+kXU9l16ds/BUQBL33nUFGnwkzG65Pg+2KoqqDUeny/H18d7zgtXbZEOJfvzryjzfgD5q
 5OQrKRgKMbh5LHaOeE6L9xdMcwnNxpzLVq+ZHLMT0S6LZNSohIVH+7+FuTvswz6uPhQ51duqMoz
 uk5YydLqTdyD3U2vLcoEDWxk9e00wAarCuuEKMp72EDiFZfHYSRzuqnioLH01r1R8Hp9kcykaya
 5RmWc/9QRBwBVCkoZ1EmAr6OfD+gAnA5Ku/6Hw31kMW+zkcAJX0cbQcn7qnwjNnCV9C3Wz2izk+
 UmJNpfPAkyg98WxPOH4+n1/yuVttfVszAUCifMw6H2ma1/tti2zvJcup/TK2vY6Gf72JVe4Eym4
 f8mBjZothoYv/ehZ5jg==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a5a400b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=sMQditckXvAul1hrnTxjdA==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=fpZ6B_ekHF_c09mJ6V8A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX02acaoAgol1u
 fCF++WV395ebT2L/5WgmS5E3KGWqURTwDpLdvPSwi4rKeeS0y5M6Ex3Q8QuyzKWDNBFg8vUW2CQ
 M+5GwpbhUh8SvnQsp8/X//tG3DnJDQc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170150
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

b18e3f0e2d0f fixed spa_fetch() faults whose TTYP used the leaf PTE
permission instead of the original request permission.  However, it kept
that request-narrowed value in iotlb->perm after a successful walk, and
riscv_iommu_translate() caches iotlb->perm for later accesses to the same
IOVA.

That means a write to an RW mapping can cache the entry as write-only.
A later read then hits the cache and faults even though the mapping allows
it, which showed up in NVMe testing as bogus completions and controller
timeouts.

Keep the requested permission in a separate req_perm and use it for all
permission checks and fault-type decisions.  Accumulate the leaf
permissions separately and copy them to iotlb->perm only after the full
walk succeeds, so cached entries describe the mapping rather than the
current request.  Since faults leave iotlb->perm as the original request,
the S-stage and G-stage TTYP fixes remain intact.

Fixes: b18e3f0e2d0f ("hw/riscv/riscv-iommu.c: fix fault type for spa_fetch() faults")
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 50 ++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index ed9fb09f8bc7..323a041b4a55 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -281,7 +281,7 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
 static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     IOMMUTLBEntry *iotlb)
 {
-    IOMMUAccessFlags pte_perm;
+    IOMMUAccessFlags trans_perm = IOMMU_NONE;
     dma_addr_t addr, base;
     uint64_t satp, gatp, pte;
     bool en_s, en_g;
@@ -298,6 +298,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     } pass;
     MemTxResult ret;
     bool pv = !!ctx->process_id;
+    /*
+     * Keep the request permission separate from iotlb->perm.  G-stage
+     * walks translate S-stage PTE addresses before the real leaf is
+     * reached, but permission checks and fault types must still use the
+     * original request.  A successful walk leaves iotlb->perm with the
+     * effective leaf permission for the translation cache.
+     */
+    const IOMMUAccessFlags req_perm = iotlb->perm;
 
     satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
     gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
@@ -316,7 +324,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
      * means we can't do an early MSI check unless we have
      * strictly !en_s.
      */
-    if (!en_s && (iotlb->perm & IOMMU_WO) &&
+    if (!en_s && (req_perm & IOMMU_WO) &&
         riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
         iotlb->target_as = &s->trap_as;
         iotlb->translated_addr = iotlb->iova;
@@ -434,13 +442,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                 masked_msbs = (addr >> (va_len - 1)) & mask;
 
                 if (masked_msbs != 0 && masked_msbs != mask) {
-                    return (iotlb->perm & IOMMU_WO) ?
+                    return (req_perm & IOMMU_WO) ?
                                 RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S :
                                 RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S;
                 }
             } else {
                 if ((addr & va_mask) != addr) {
-                    return (iotlb->perm & IOMMU_WO) ?
+                    return (req_perm & IOMMU_WO) ?
                                 RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
                                 RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS;
                 }
@@ -465,8 +473,8 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                              MEMTXATTRS_UNSPECIFIED);
         }
         if (ret != MEMTX_OK) {
-            return (iotlb->perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT
-                                            : RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
+            return (req_perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT
+                                         : RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
         }
 
         sc[pass].step++;
@@ -491,13 +499,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
              * non-user mode leaf PTE and !pv we need to fault.
              */
             break;
-        } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
+        } else if ((req_perm & IOMMU_RO) && !(pte & PTE_R)) {
             break;                /* Read access check failed */
-        } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
+        } else if ((req_perm & IOMMU_WO) && !(pte & PTE_W)) {
             break;                /* Write access check failed */
         } else if (!ade && !(pte & PTE_A)) {
             break;                /* Access bit not set */
-        } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
+        } else if ((req_perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
             break;                /* Dirty bit not set */
         } else if (pass == G_STAGE && !(pte & PTE_U)) {
             /*
@@ -532,21 +540,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                 addr = iotlb->iova;
                 continue;
             }
+
+            /* Cache the effective permission, not this request's subset. */
+            IOMMUAccessFlags leaf_perm = (pte & PTE_W) ?
+                                         ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO) :
+                                         IOMMU_RO;
+
+            trans_perm = trans_perm == IOMMU_NONE ?
+                         leaf_perm : trans_perm & leaf_perm;
+
             /* Translation phase completed (GPA or SPA) */
             iotlb->translated_addr = base;
 
-            /*
-             * Do a bit_and between the PTE bits and the original
-             * request flags to determine the exact permission we
-             * need, i.e. if the original request is RO and the
-             * PTE has RW flags the actual perm is RO.
-             */
-            pte_perm = (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO)
-                                     : IOMMU_RO;
-            iotlb->perm &= pte_perm;
-
             /* Check MSI GPA address match */
-            if (pass == S_STAGE && (iotlb->perm & IOMMU_WO) &&
+            if (pass == S_STAGE && (req_perm & IOMMU_WO) &&
                 riscv_iommu_msi_check(s, ctx, base)) {
                 /* Trap MSI writes and return GPA address. */
                 iotlb->target_as = &s->trap_as;
@@ -563,6 +570,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                 continue;
             }
 
+            iotlb->perm = trans_perm;
             return 0;
         }
 
@@ -587,7 +595,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
      */
     iotlb->translated_addr = addr;
 
-    return (iotlb->perm & IOMMU_WO) ?
+    return (req_perm & IOMMU_WO) ?
                 (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
                         RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
                 (pass ? RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS :
-- 
2.43.0


