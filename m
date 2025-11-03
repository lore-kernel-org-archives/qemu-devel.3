Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB9CCCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 20:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1E7-0008K9-AD; Mon, 03 Nov 2025 15:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vG1Dz-00080W-EZ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:32:23 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vG1Dt-00008O-79
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:32:23 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3KJimK023330;
 Mon, 3 Nov 2025 20:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Tj7KpDpb1W+/7To5FKwJ3eGo18duFYWSDO7b7vwvYtY=; b=
 gFoAoR/IGb4BTF6dfCLbVBIf4/O/MVlPnEDlLM3+OsLk9GJhumv26hY9ePfzoFCs
 yffoewrJAkNh/Oic61JKR2/9Xgz2295PXQaz/enQwuV8cvHC/6fSGyDqxBJkIZkM
 hKgvdBdD4MNIXVbdYQoS5d3uFD4ComLaTxa5tB3scPclFu1/INcbpi7bxKQXIcU9
 D8W7ZqPqyyIFs32feCGxSoIgI/Rgt76+5q9V+PGioWqNZBvceJhExyYDfbSZQyCa
 11XiLKxK0zDVGUsd7YmiEOtAJQLsf6diNCKa0HHoaGYLjsx4oBmC39Fcy92+xVza
 S00PBb4JH7cmHH/sw2wIuw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a73ay011p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 20:32:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5A3IROvL009620; Mon, 3 Nov 2025 20:32:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4a58nc6eag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 20:32:10 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A3KSvS1040083;
 Mon, 3 Nov 2025 20:32:09 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4a58nc6e9h-2; Mon, 03 Nov 2025 20:32:09 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, qemu-devel@nongnu.org, sarunkod@amd.com
Cc: alejandro.j.jimenez@oracle.com
Subject: [PATCH 1/3] MAINTAINERS: Update entry for AMD-Vi Emulation
Date: Mon,  3 Nov 2025 20:32:07 +0000
Message-ID: <20251103203209.645434-2-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251103203209.645434-1-alejandro.j.jimenez@oracle.com>
References: <20251103203209.645434-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030183
X-Authority-Analysis: v=2.4 cv=D5xK6/Rj c=1 sm=1 tr=0 ts=6909114a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8 a=69wJf7TsAAAA:8
 a=FCmSo5QTj4tFlZMtZ9wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13657
X-Proofpoint-GUID: -Hd-SlGqu4ZSwU-RYI3u7k-GECcm06QJ
X-Proofpoint-ORIG-GUID: -Hd-SlGqu4ZSwU-RYI3u7k-GECcm06QJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE4MiBTYWx0ZWRfXzG1JBgnyOZoo
 y9lO7331dPNhFG51uA7e9vKThE2tOgVy+hstiU895I96FVbWXPY1ufAuBf8K/lAH3ai/uzRE6j5
 smHERMyFJbXUT+a7HEpEcPGWwlRXjtEznp8U6L5g4nr1gFhD+4KIF5fjOroP6yWoJ9Dxd1ouHJS
 Ti+MCJ/IrcRm+i+o8d5ZziEZlTJcetvl6fIksYeYpi+GSZ1FPoRSUoYQaiK+1HzUMG4KK7nGViw
 qgQcWfERZ+fvRasAcu/Mnwlo9MipyjwMptJtuMP9LeG6Si+B4TnnYXMb8XAQavNOwR9+P0toa3H
 ZK6dfzAIlAhlWllhMzA/342yvfAJqSPVfPMTH4XdrrkrVkAXjcIelFAjz7bClwoxsJfP6GuptbT
 OpjFkoyHGN0Gl5BWsDcd8cWxOhpCpBAFwpNaMw9T6xZMWZiVWGM=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add myself as maintainer and Sairaj Kodilkar as reviewer.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee058e2fef..3974c1e2ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3932,8 +3932,10 @@ F: tests/functional/x86_64/test_intel_iommu.py
 F: tests/qtest/intel-iommu-test.c
 
 AMD-Vi Emulation
-S: Orphan
-F: hw/i386/amd_iommu.?
+M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
+R: Sairaj Kodilkar <sarunkod@amd.com>
+S: Supported
+F: hw/i386/amd_iommu*
 
 OpenSBI Firmware
 L: qemu-riscv@nongnu.org
-- 
2.43.5


