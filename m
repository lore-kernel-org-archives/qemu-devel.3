Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86853CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXrx-0003yj-3z; Tue, 16 Jun 2026 13:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wZXrt-0003tO-Q4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:46:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wZXrq-0000Hl-QK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:46:33 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GFnjK9079531; Tue, 16 Jun 2026 17:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=tVH58gVewWF5ve01BG0806XnPSMiW
 AcFKNGMph/FtOU=; b=sfjau4lBSeSvos69uf5KgQ0AwmIWibkjSFJr/opp7UEmW
 2Mkjdt778f5/UL9YqjcZEDVCSUkUNvjfJdNSQL5uLHuoJv1kVrI3P7Qf2hvU9SHj
 GpUN1Z9YC7RGh1BYsrTSuoE97q8CDvcnV09ZKadFQLCJlpxL2Q0TNcXKNgUWmdWA
 yrkWYs7m61T5OQ+9Zc3Zc3LH5V0BZrs7TueDNmu4IF52YJ1hluZKEyECeBfWaVG9
 y15hJdz90Kdgm40eV+dEcwF84hAleTbk79Jl6fToAeJYK7E8v098Zcgknw6pH46o
 BUDOqdHKp/DiQ+xYvUxGf60SvgC8zKK5IXd6HsM8Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4es182d1pu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2026 17:46:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65GHcA4v038240; Tue, 16 Jun 2026 17:46:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4erwnd0jac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2026 17:46:22 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65GHkLGp025920;
 Tue, 16 Jun 2026 17:46:21 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4erwnd0j9m-1; Tue, 16 Jun 2026 17:46:21 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: qemu@demindiro.com, imammedo@redhat.com, sarunkod@amd.com, mst@redhat.com, 
 pbonzini@redhat.com, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2] amd_iommu: Fix opcode reported in invalid command handling
Date: Tue, 16 Jun 2026 17:46:20 +0000
Message-ID: <20260616174620.438468-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606040000 definitions=main-2606160181
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE4MiBTYWx0ZWRfX5kFrVpylfODM
 iUQsLV6mJ4qbhmpHHQJ9BcgWzNKnNbiT4leglKP95CaCcGThYjLuNM9LZxDfCLS+i+6XtHMSvRy
 nqmcOa3mUwXgKt/dHy+c06ljHePHRUiHELLWpWZGufoHgX7ofidE
X-Proofpoint-GUID: Au7pspUzWAqGpUrUWjIvhNvR93QZsTe5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE4MiBTYWx0ZWRfX5tzMNRmpFkRg
 hDJjOpPpvjEYiqBxbgj3kAAVaMVPeBvImHE0QkXnuwd5jByTpXc1uU0OF8I2IrP0ZAvEA890QFA
 ngN+Sa6iMThLVpWl6dQS6/pjGIS/FhZR1XUtU/tqe97bp9Q1TfGJ1B46vdOErsU+hUCsPmqsugT
 9yAZMe0QCZd1ucTi8h5N4SlFjelYQ/U+E0X+MAdnAUikiUZm54fKdaKsjCRVyuQCLxvYaJV+4z8
 s1nMGTtGcCvuZCYwEiHpx2IzUPCyqp3fay7YewB2uZ3LA4wMw5dCJfKHZICrFTHmCcuMiFIVEgk
 hg5fK4Ng+dLjlWWtVDbeZTQxcUN8IUTPm6TNuha5SggXsTihKnP1wbOSD561PUOUI5sd7+EI/0N
 cYmt2uB7D96SVzdlop3YADAbFnaiiSqmULcUTCpRZHBMstGojVyhZEV4GXmQeFVbdnZGpPZaohq
 ZXtWFIJURUjJtAEXJiA==
X-Proofpoint-ORIG-GUID: Au7pspUzWAqGpUrUWjIvhNvR93QZsTe5
X-Authority-Analysis: v=2.4 cv=Rr/16imK c=1 sm=1 tr=0 ts=6a318bef b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=RWxpEp7VAAAA:8 a=zd2uoN0lAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=GzNvJYq7lnVrn9pzyLoA:9 a=O8hF6Hzn-FEA:10
 a=3unh6Pbajv6CBnL1DxgC:22
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

From: David Hoppenbrouwers <qemu@demindiro.com>

According to the AMD I/O Virtualization Technology (IOMMU) Specification
(Rev 3.10), Section 2.4 Commands, the Generic Command Buffer Entry Format
encodes the opcode in bits [63:60] of the command buffer.

When handling illegal opcodes, the traces for unhandled commands and event
log info extract the opcode from an incorrect offset in the command buffer.
Fix this issue to avoid potential confusion with mismatched opcodes in
traces and unlikely errors in guest event processing.

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: David Hoppenbrouwers <qemu@demindiro.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
Sending v2 to the list for visibility before inclusion in 11.1.
v2 changes:
- Edit title and commit message with IOMMU spec reference.
- Add Reviewed-by and Acked-by from v1.

 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 79216fb305..05b7c638f4 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1509,9 +1509,9 @@ static void amdvi_cmdbuf_exec(AMDVIState *s)
         amdvi_inval_all(s, cmd);
         break;
     default:
-        trace_amdvi_unhandled_command(extract64(cmd[1], 60, 4));
+        trace_amdvi_unhandled_command(extract64(cmd[0], 60, 4));
         /* log illegal command */
-        amdvi_log_illegalcom_error(s, extract64(cmd[1], 60, 4),
+        amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
 }

base-commit: 608ad9307d5b4797d2254ee3a4bad2bc8c8bcbae
-- 
2.47.3


