Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9D2CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbpT6-000733-Hr; Mon, 22 Jun 2026 20:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wbpT4-00072m-RL
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 20:58:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wbpT2-0000Fv-Vr
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 20:58:22 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MNcMBR2914087; Tue, 23 Jun 2026 00:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=ecBaR
 Olmlbeci3rICs6iQcT5eWieO19NCqj+PXf6JM0=; b=TWZg5RfHiZOZZuhWhJf53
 yZiMVJBTClYXhEIHtQUcZHd6QQ8gqADBztvquGDrEMwa0FS3tRCf5pdrNlOVN9Fj
 8FEN/edsacLic2nMKKql1USVDFU1EsPHb1cMvACrVZ9gyNFb9Dsvos4wMD2zNDq4
 MyJYLP4NdBaiZ1z4KWx2wnFsu1pae6SIIVeimZZ0RNAYcdsAStuK62YE2+dgwy3I
 1VYu19LjSSEdLvci9uTdvtspQipA3o7E+8M1nKknFW3hNtdGbP1NXNn7DBSQFdY3
 suaNYM0nVMoPf+Qbda/h4OrzSXVViRVLEFrcPECgwrYBV/szEZ7XQK+Ioc4v+X1Y
 Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjwcaux6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:58:17 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65N0w8Th019650; Tue, 23 Jun 2026 00:58:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhabf3tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:58:15 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65N0wE2f020136;
 Tue, 23 Jun 2026 00:58:15 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4ewhabf3sw-2; Tue, 23 Jun 2026 00:58:15 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mst@redhat.com, sarunkod@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 1/2] amd_iommu: Return int from page walk status helpers
Date: Tue, 23 Jun 2026 00:58:12 +0000
Message-ID: <20260623005813.984238-2-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623005813.984238-1-alejandro.j.jimenez@oracle.com>
References: <20260623005813.984238-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606230005
X-Authority-Analysis: v=2.4 cv=eJAjSnp1 c=1 sm=1 tr=0 ts=6a39da29 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8
 a=CPMDAz_8QbydQVlharwA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ZbjR4IphGysyOE-i6nxsWlxQQbiemu7D
X-Proofpoint-GUID: ZbjR4IphGysyOE-i6nxsWlxQQbiemu7D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwNSBTYWx0ZWRfX45DtrS7ZJsnn
 ckck9KugenhRlLBs8hjGn6HwUOalsbmvm9hM4WaUzP253OyLemAQaTMbX0ZWH9U8+Q64NyqOiPw
 5IijVFcCnKkkwfwTJMBavu33v4E+vDUKdBRA2Esk11n1UZbemWiN1gDDc1+IINIHdf0QXAxBFpA
 Xw8//s1HgIz+7OFlPXGeOF50fPjkVf7oEM3ccEJR4jMGj9zg9PaoezPiVyQHVT6dcTjS+/e6sR6
 ayfuINpPuShTIlat3lnyLQ8QShFSxTOecP9zJ7SW4IoGjxV91aApaJAjADie0ENqCYx2jCp7wKt
 wpQIF1m+51rGfa7Wck0auU+EByUrC1/vLGdHADUD++sMPhp+r+CEKuGnFEKZwzAZrf6kcBExu6p
 6kkOneZ9YuU/NBvGIePHRckvtGxWHOz5x0mi9qjzegG09NrqJBd9g0k6H+pG6AfHzkVdXXCwOd2
 FN0hMzqZPzNbD9C+J5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwNSBTYWx0ZWRfXx9NefimD1llM
 7VVpYgE/196RyhYkKff+OTxtkMOduFaJjH/TzGDemBWR8rrMqvBrWJTQ+xNOp0UprrqXKbeBLui
 8LbW+Id+DjadCu0d8TmdA+k+5LLVMmLw3DYvcKkDiQcHKKowXBym
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

fetch_pte() returns a status code 0 on success, and (small) negative values
on failure. The PTE value itself is returned via an output parameter.
amdvi_get_top_pt_level_and_perms() follows the same return convention.

Both functions currently return uint64_t, which means any negative error
values are returned as unsigned and then converted back to int by the
callers. This does not cause any issues in the current implementation, but
Coverity flags the type mismatch and potential overflow.

Make both helpers return int, so the type matches what the return variable
is (0 on success, small negative value on failure), and also the type used
by all callers to store their return values.

No functional changes are intended.

Fixes: a1c97c395729 ("amd_iommu: Sync shadow page tables on page invalidation")
Fixes: 786550e2d38a ("amd_iommu: Follow root pointer before page walk and use 1-based levels")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 79216fb305..0d273fd33d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -659,7 +659,7 @@ static uint64_t large_pte_page_size(uint64_t pte)
  *   - IOVA exceeds the address width supported by DTE[Mode]
  * In all such cases a page walk must be aborted.
  */
-static uint64_t amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
+static int amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
                                                  uint8_t *top_level,
                                                  IOMMUAccessFlags *dte_perms)
 {
@@ -702,7 +702,7 @@ static uint64_t amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
  *      page table walk. This means that the DTE has valid data, but one of the
  *      lower level entries in the Page Table could not be read.
  */
-static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
+static int fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
                           uint64_t *pte, hwaddr *page_size)
 {
     uint64_t pte_addr;
-- 
2.47.3


