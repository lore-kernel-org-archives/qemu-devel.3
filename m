Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E001C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 01:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weMz4-0007Vf-OZ; Mon, 29 Jun 2026 21:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weMz3-0007Uu-0O
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 21:09:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weMz1-0002Ki-8T
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 21:09:52 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TKfL2Y4042754
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 01:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=rRbDSRBdO4dHXyxvi03GdoEAf0VRXCOtTMP
 12G4xOLM=; b=gmajT45NaK0ZHAs0cDhcclQlIH3Kc+NKycXqaZqZu8aNmq7+CRu
 9VUNsOFhdAf5ps/Wcwcrmy1Q3ADBsFpwLfBkBQsP/rftD2EItWZU64kDGex/DWJ2
 V+iZ4Hq7vkwOLCNhrK48tCEHZ2rdB81d4uuK50lDQ/EoW4RwyKt4YcYHZkQRpquU
 DaIIS4SpsUlxmiorWzE0cpkuvyX8hecyWwWyCF8hjoRgjFunJ4s76uW1xTcoGSQk
 1eJmSr0YQnHNf7iLzAlPorG9JiNanW4HNcRdUrlRfRVj7rlbN9R2KlaIhiAb9t9B
 x10rmVJQz/yEgX0ue5GBTYIMvwo2eqf7HrQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s3vqn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 01:09:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f08f19552aso16113186d6.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 18:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782781786; x=1783386586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rRbDSRBdO4dHXyxvi03GdoEAf0VRXCOtTMP12G4xOLM=;
 b=TG82NbZxz5VRKMkC44+xQVsJVSwIY2HKlbzbC+xnrTT1iovbXJEfzKUGgRfMTo5Uyf
 LzvJC42jNxSPFL24zXlS4F1HPiTB65aYwSozLU96ZlkcVKEjMcx/Jvt+aj4/bA89zv2A
 QnFdKR8+fUNUp9fVsTlmm/TH/2R+U3XtrBZ4ulKc9oZpc0UrphP5wtLfzP1JypY7nZaI
 UzHIVjVY8zKAq35ROFiRLkvmjzo5/Iv7u4QTdGmcsCJQRAs7x1W/lvqCUGXIxMWhbcTr
 416nKathQRYsqMwPWJ/TdxOQQ++Y61SKB8NwjyEmYhikSTHbFObSP9G3XtQGKh990eXJ
 +ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782781786; x=1783386586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRbDSRBdO4dHXyxvi03GdoEAf0VRXCOtTMP12G4xOLM=;
 b=MU1MZT8x4mLq1fvLcxzM3mAhcYUymv7Rcnp2mNR+yIdnvxFUuRg+Zb4Qe9lW1TK/Um
 vthtWSKc6AJ1zZsQPP+VdkGjGVBIJvnyZJ8o4f3tOZR8oQyWKj0mnoCEkyxXTGQplWjw
 VACAyUTXgZuPoidHmOjue9UDeFZ/UN9hjxBw60HcnStUU5tf/Vv71EbqsWzQSw0aPW/e
 DMoKxWHe/3+qZDEiXIIeFe2BWWUzP4KBg/4ctpesiYxMNrn++xqEBU7+JFYIRKlH/ySh
 JYTaxD2FBOsBeOiC9kitPbrEHi0564VWOyOx4AFupXOjMHAGD2v1hIELVmiCwx1cC4nu
 OSYg==
X-Gm-Message-State: AOJu0YxryBzbEfE82ATuAX6MqQJPYqOvJ/0Mpp+uK5CC2t9RKsrFlbE/
 18owV4S8RrRZ4SXlxwr9bCtRXT5r3qh7RlDRlus2lVUGf83vBFz5Fm9+voGRYaVCUf4dPJFUAOB
 yXvPbWiPlD+qFg59JTtfF//aDWxd7MJmCRNxlshiIY7z80GOoJwXc0qhx5MiG8zx1qA==
X-Gm-Gg: AfdE7cldl6TZ0MUXWbFFmiklmzvKlOEP2DsEy2yeZCYR4oIXwjzEV+oSDvhOVF0omcg
 f+6xt1wWU5KZFHhQBPk0rJZAdzsxp+YiLZS2whrJGuaVl3WKtHP+xr1oNBcyy1mWMpLfnQAstqX
 rrBlyrl/3Y/f2QdtcNoXpNAYBvqca2MYmbOWyrhnnUIWvEgIvdVOASMfw4Q464OWEPrUWAOEeg9
 rnWZFplVdPWyXxXuusJEK/kHcWa7tNIQiOWjT3EYQD1jIIEbwn5NioJPCV7Qt5Sc3+KY505cJd7
 bjaUCKQGt7Esu/IJpefIUHi7k0ZudYAacsTNynISXg6ie8mtXcGRKLz5sAN+pc4LYA2XQH1LK0w
 fzTBT4RhI6UajIaWbC5M4gGm2bKL2S0gg4VnOLVTQmeoKkQ==
X-Received: by 2002:a05:6214:248a:b0:8e6:23ab:a055 with SMTP id
 6a1803df08f44-8f1bd21e19bmr29000626d6.33.1782781786097; 
 Mon, 29 Jun 2026 18:09:46 -0700 (PDT)
X-Received: by 2002:a05:6214:248a:b0:8e6:23ab:a055 with SMTP id
 6a1803df08f44-8f1bd21e19bmr29000256d6.33.1782781785414; 
 Mon, 29 Jun 2026 18:09:45 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f1a27e79f5sm10984056d6.1.2026.06.29.18.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:09:44 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] hw/riscv/riscv-iommu.c: fix read fault being recorded as write
Date: Mon, 29 Jun 2026 22:09:38 -0300
Message-ID: <20260630010938.1331641-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAwNyBTYWx0ZWRfX3aGGh2nlHQ9q
 ziT7sBrGZfTEvov4kRXmtt8zCOr92POV3B8KEV+nuhLkqDEXL907oGU84iEfhj9zu6ayBv7L8XD
 sUzuUs9yRml3TygFL5EcERDl5SLFP3A=
X-Proofpoint-ORIG-GUID: WnjCVsSMUFAfm31wcLBkKLWcRgHPdEXu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAwNyBTYWx0ZWRfX/ZafW0KX6Awb
 sOX8FALVCC/ofXDiAtlQ+BXoV6nxnbyAzcgnUoMBExYCpqr1L5jyjdYEXRfjjWJ7g/8lZ0stduB
 GcqvTw7obrShjipVpVBZsyiY4iNRT8VDv19gh9tTlVzxIKiKRXSDkmkSxg6zQf+DsjVzrIfdzZ3
 eP3+F6WLVBsrl2mJud68m0YcUKJSxQdVYempLVs0BPqDfKhq3Cs0QOzBPb2mUxqppfJP8AFKQdq
 oYVcGR+vdd8oMwba/3TpyiinZTbpqPE8KqiFLebDQ96GO5yastoxDJKm9NOd+Oi8YjvTU0Y10t4
 +LJNUozfRA0eKqeTTr1H8ch/ml0uQZuvKGphp3yGRy08uvQ+xOGh+wyuoJ9dUtBLYdhF+xuLQzg
 fBmR23E5pGjJn9bIRfEYmGseT9MGZuATyms7dsDeFqg9CMxFSVRS2wYcX9FhKukeN8HiF3bg4Uf
 YgpQk4mev5fF24H3OEQ==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a43175b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=2kUl_4CQJ_2POlUL4sAA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: WnjCVsSMUFAfm31wcLBkKLWcRgHPdEXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Under certain circunstances, like the one described in [1], a read
operation that faults will be logged as a write fault instead if it
happens after the translation phase in riscv_iommu_spa_fetch().

The first problem is that we're overwriting iotlb->perm with PTE flags,
so an IOMMU_RO access flag can be overwritten by whatever flags
the PTE has.  This will cause the wrong fault type to be thrown at
the end of the function in case a fault happens.

To solve the iotlb->perm overwrite we'll bit_and the original
iotlb->perm access flags with the PTE access flags, preserving the
original access type.  So a IOMMU_RO access in a R+W PTE will result in
a IOMMU_RO perm.

Second, the resulting fault is received by riscv_iommu_translate(), which
will then report the fault.  To do that we require a transaction type
(ttype).  We're prioritizing checking "perm & IOMMU_RW" to set a
UADDR_WR ttype, and then checking "perm & IOMMU_RO" to set UADDR_RD
ttype.  The issue with that is IOMMU_RO=1 and IOMMU_RW=3, thus checking
"perm & IOMMU_RW" for a write then "perm & IOMMU_RO" for a read will
cause the read fault to always be diagnosed as write.

Make the iotlb->perm matches more strict: "perm & IOMMU_RW" must be
exactly IOMMU_RW, ensuring that 'perm' has both flags.  Then we can
check perm & IOMMU_WO and perm & IOMMU_RO without worrying about
overlapping with the RW flag.

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3577

Fixes: 69a9ae4836 ("hw/riscv/riscv-iommu: add ATS support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3577
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c9687e01a8..e1ff5eb864 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -282,6 +282,7 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
 static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     IOMMUTLBEntry *iotlb)
 {
+    IOMMUAccessFlags pte_perm;
     dma_addr_t addr, base;
     uint64_t satp, gatp, pte;
     bool en_s, en_g;
@@ -509,8 +510,16 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             }
             /* Translation phase completed (GPA or SPA) */
             iotlb->translated_addr = base;
-            iotlb->perm = (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO)
-                                                         : IOMMU_RO;
+
+            /*
+             * Do a bit_and between the PTE bits and the original
+             * request flags to determine the exact permission we
+             * need, i.e. if the original request is RO and the
+             * PTE has RW flags the actual perm is RO.
+             */
+            pte_perm = (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO)
+                                     : IOMMU_RO;
+            iotlb->perm &= pte_perm;
 
             /* Check MSI GPA address match */
             if (pass == S_STAGE && (iotlb->perm & IOMMU_WO) &&
@@ -1704,7 +1713,8 @@ done:
     if (fault) {
         unsigned ttype = RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ;
 
-        if (iotlb->perm & IOMMU_RW) {
+        if ((iotlb->perm & IOMMU_RW) == IOMMU_RW
+            || iotlb->perm & IOMMU_WO) {
             ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
         } else if (iotlb->perm & IOMMU_RO) {
             ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
-- 
2.43.0


