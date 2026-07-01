Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5EFC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weuFD-0005QB-D0; Wed, 01 Jul 2026 08:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weuFB-0005PO-Am
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:40:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weuF8-0004LE-DF
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:40:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A915k722279
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 12:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=xmSzVdEa1UXvtLbIOTxa13z7dKjtsC/eWWx
 TMv2p4tg=; b=D4JD3km6Dvt/hiVd1DZnBHFD3YI8Yeg7OToYSL3oyYjoYxdedSp
 s/xQ+20nRBV63uMAU/dl98mfrNZFJLZoXvouuCyIlaooyHoypqxOcc9z0HbZE43S
 SDG2qXuJ2EAnIgXPHAbAdMHcR3br75uYVeT7VznerUO88K5ZImvqZWmGyG4WoInj
 sazEb4EMsdKPcHqtH8Dr4Bw42nN2LDZCnQu0x+xsOFFieMin9Fb3DDPkUiA8hOvS
 7NrFhr6uGIeDlaVd2zbwXy60pbHX72xGTA1De/vjjAVwNvHCaKKSeHSY/3EhbYn3
 7QWBAcMuisz0N0H/AnCp5aJEui0HE/+Vh6Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvwc2ts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 12:40:40 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f0ed4fe79aso15384306d6.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 05:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782909640; x=1783514440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xmSzVdEa1UXvtLbIOTxa13z7dKjtsC/eWWxTMv2p4tg=;
 b=FkEuF2RWJD2HooyPzKnpcSZrbDYkrdwekkmpUaWGA3OYXSWSjr8iHqurfSIe2/6Am/
 sjEJCRjqR82pIDU1P+pR8Z788t0RfGxL5Xb0FDopHegy7fZUQO0zaZsC9tfh0qApl/Nl
 2ffMx2LvF8lLy8pU8/k6u3xFnWDbhjaTzN5bLSwV5qStQ0oOItD8mMfgUv6Q5U5ZGydl
 8D0Zh2y0VkSQJ/8D/H6ZSdjP0baLVsO2J01YJ5jeCOkfq2v+WGhfInhUby3N1gJ+htb0
 BiGHte1jFwdrGM7J5nle7mngHhStAHVVHwP3Sgk8SSrLPwT112RqSRayk/GeDpVSuK5k
 /eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782909640; x=1783514440;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmSzVdEa1UXvtLbIOTxa13z7dKjtsC/eWWxTMv2p4tg=;
 b=Xx46UULgKVQq9cU4qCduISgau4OeS3ipMxD5AxN473Nj63bUjvuQ596i2eHIpfQGzY
 ZtWdMUxW7wihsUbbDt5rJUvk2JShpDs1RJeiM3mzEb/SWyRKdnpMLv+dJ5w6p/rnc5s5
 DOGM+tp10q7OtbStpqVYgl3UncFeQG4tpiwOOeD90C8pb7VuMH6dMQgAuHbdwe0SmEtE
 Bz/BunHAFZ2sezSI/lW2Kq9Hd6WyvnNR8j+alBtPSAIXzkOHa0Q+CdJ3YfuhcMTgR/hz
 F0ai4DGDUi64BuB+Glu80jiAlXl7Yn4R8q6qh5Pu/1EzOJP8faGphLMILRYtuqDR1kO1
 D5jg==
X-Gm-Message-State: AOJu0YxVtotqA8695kWgfJjPq8KiVxCAE5EL6EpuDPEY12DF4zIvztbi
 dvPsuR31KXQKxvxsGn6I2hZIi4T0Yj/75O+8p7wC4h3J+oXPUWNSwa5SYMGEMkS8Wg+QhPW5slC
 kaOfSnqK7kbnez8BvlZ4dW51oM8ul0mmVHSYhaxLv64xzPSOssZVgGeHZDSU7MKuQBg==
X-Gm-Gg: AfdE7cmSGRAWLCK965oZFN9DayNWr2hC1w2PEjM37gCCrhpXkw9c8urrbXIOWmw0tgN
 /NoyiVrpWe+OlNowiotqoBo0Z8Vx+WA7A6Xyyc73ujuLhBZcOFDf/4XvQMEUplJqOnz/Ood0DOU
 Zzb7rnt+AjhTrFRrYvBXxBTMok3QlH60h25zWQOeV+22Y6DxQf6rewQEETk5yGQzg1TMNuukcx7
 k2MQ159c8WT/PaIrSaLzdbMlLRK1NToCcQEIYmNF/+W3PjlhLh1OHBmD9H3lUP+V5X66WRjwjd4
 kGyeLzmDxPfE+6VDisDb0UDgQhc0Y7C+/jlULKIpfhAQw7hoJo2TUH/s0YOV/rrCp6LG3/YR4AU
 RwCa7GFjNskA+7aC4rowO32idGwFdilTk3HTx9N0jbOLDeg==
X-Received: by 2002:ad4:559d:0:b0:8ef:5c5c:dbfc with SMTP id
 6a1803df08f44-8f3c8a20ca9mr12833876d6.43.1782909640325; 
 Wed, 01 Jul 2026 05:40:40 -0700 (PDT)
X-Received: by 2002:ad4:559d:0:b0:8ef:5c5c:dbfc with SMTP id
 6a1803df08f44-8f3c8a20ca9mr12833546d6.43.1782909639666; 
 Wed, 01 Jul 2026 05:40:39 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f35e790097sm21406636d6.5.2026.07.01.05.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:40:39 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] hw/riscv/riscv-iommu.c: fix fault type for spa_fetch() faults
Date: Wed,  1 Jul 2026 09:40:34 -0300
Message-ID: <20260701124034.552271-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UdqincZkBQF-rmTC32bqT4EkoYg7a3gu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEzNCBTYWx0ZWRfXx+6gChzPPAWP
 GMhicX4MS6Fw6HNK5yRxWOvJGX8pMt1P4/Xq2VyA9gTQil/0K/ORCovxdQIQf5dP+96LIycW9Ld
 XleuNX5VCUPwrTQd+wPy7y3hYTalmL8=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a450ac9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=LJELx49qBhIdHvJ-UO8A:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: UdqincZkBQF-rmTC32bqT4EkoYg7a3gu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEzNCBTYWx0ZWRfX1EgZWZFB3Qhn
 A807WUTd4VxOy68FMFLs9VEIvKLx2hC0i+NDQxeIIEsW18rU+Q2ZWVlEbO08H3Xp5G/WibzM/t/
 abDBeYKZs0wYeUlGcW11yDhsHXL+FysE+UwGpgrrkv3ZQKlggdk5Xy7A+2Kh2XrcdIAjFp0HNEb
 6kpPt3j+Yrts3cbU5TL/roavViVSHS2EWmMrFif1P/K9m1Aq6rY/QJVFHB0lgBiz9znKk2NLkoU
 967E4K/HSQN960PBMkVaIV0ku44o0GanvoTXO7x4Nms+pf7yULrdFRh4B9E2iWiAFDG6qrnC8r4
 CY5QT44SL/pnyyT2wdlh/y+H6HDzQ3cR0KlrUtguUDCCg7QLfpN/MZVSafaLH7cR2FVHcZ1qSxq
 GW3Rh+I3uB31ZcbeiXgpzQPQVDfvZYIqtenO3nJIqBFRMDQUgnENbiQsXD9w6TDgxWTA6uB41Uz
 DqWdK+MCwk+E/p7/47w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Under certain circunstances, like the one described in [1] and [2],
a read operation that faults will be logged as a write fault instead,
and vice-versa, if they happen after the translation phase in
riscv_iommu_spa_fetch().

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

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3557
[2] https://gitlab.com/qemu-project/qemu/-/work_items/3577

Fixes: 69a9ae4836 ("hw/riscv/riscv-iommu: add ATS support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3557
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3577
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 974042d017..7f94ce152e 100644
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
@@ -1727,7 +1736,8 @@ done:
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


