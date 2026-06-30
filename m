Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FE9C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegdU-0007Nj-59; Tue, 30 Jun 2026 18:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wegcr-000771-SF
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:08:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wegcp-0005tH-Pa
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:08:17 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UKtqxw1029962; Tue, 30 Jun 2026 22:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=bxQacfJOzFJzNHYY
 mS3sMwSkA9R6H6+Wg3Y1aWNzpiI=; b=HA1LtdCVO8FPHMirn4Baviam/xXK8l6k
 fGYkVmmA5FybTTjagO6+0AQ2zo1tQjyCBrvEhTz0dJJeK8IlLsv39OK+LFM1w3Q5
 jlDBsrHrE2T1ZHJwkor9vVOpzjTO7KADpZbAgwZ0SNQoI/Qw90YnR28eDDXVY412
 PvSIqSZCnmRtrY69/XPuvN+gx3kHaqGDA1T0x3cffF/4TzgNq5S0kdf+IkV+iqeg
 LnRJu/TlegCIfpzxfC/okY67m2Da9LhFRw/T5UWz+oRxnf9UTxo76sUSqWybjI9S
 hEXsks+q/yOR6sq2JnsNFO/0Tqz5dp+9gRa/9lg9s4f5BEjp4QlKjg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26n154bg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 22:08:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65UM3XrT034400; Tue, 30 Jun 2026 22:08:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4f3u1w75vv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 22:08:07 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65UM87gD008507;
 Tue, 30 Jun 2026 22:08:07 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4f3u1w75vm-1; Tue, 30 Jun 2026 22:08:07 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: sarunkod@amd.com, qemu@demindiro.com, imammedo@redhat.com,
 peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 0/5] amd_iommu fixes staged for 11.1
Date: Tue, 30 Jun 2026 22:08:01 +0000
Message-ID: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=922 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606300215
X-Proofpoint-GUID: MyivBTlXfAOJ8gIfYz7hkA98KyUqoQ4T
X-Authority-Analysis: v=2.4 cv=FvI1OWrq c=1 sm=1 tr=0 ts=6a443e48 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=iQI0comr82-aZKQ-86cA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-Proofpoint-ORIG-GUID: MyivBTlXfAOJ8gIfYz7hkA98KyUqoQ4T
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfXxLQbA0UT7gCf
 5x32zbFIMEImZw7bgwvcnXAta8PXB3Ic5hi00vlM6I0NNU6GsyEUpKGDfj/cFxFhSHby3GGS/jP
 w8v1U4SOcd6Q8wWF1De/GGZM2VpGTGw8rYv3GlwjZQwUrDtXydfp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX17DsmF8oMuIt
 +omVurSoFVMw+Zcvq/QaOL1BCvubqUI9a1KvUYZ2y734F/syrH+L+1l30+UVAMpLhsxqJXON4d/
 QVC24XKAC6zMh3gkm/wm9baYkcNyeMQpSHCU/7X9Buf7S40ujc0jWqGVo509kURbkPs/zwAQ0Y0
 39kRv6Qdioyo0fiLglbIlQiApq3Uf3yYAFPxMegyPxrprwSPIgICXlTfdBJmdaviqTloOTrsxAZ
 TzFf+zM8+agoKWeD1Hk9Eze7Amp3+Shj3iGqYsiZ1ip5BTfglxDDacGUW1gHIDDXTDllSM2YLvG
 ii06HXPoDHepfuB56qTYSZCRndGFr+phN0N6rROMYEsHdAtoWRNUQhTPP1RcK3uRD1FmCmjae2J
 KKPfkTcFYm4EeNxXyReE8+8i8aX99i2UnY0iGRuBhSsiUWfsYvtoUB3+WEYKQvF8JrgVrlcGHyD
 GXSP5D6NJVY7ehSi6gOO7+xvDorsuY9SgBbk3kW8=
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

Hi Michael,

I have staged these recently reviewed AMD vIOMMU fixes for 11.1:

https://github.com/aljimenezb/qemu/commits/amdvi-next

Base: 30e8a06b64aa ("Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging")
Tip:  018c1dfb3e8c ("amd_iommu: Fix endianness handling for command buffer entries")

Patch 1 is an independent fix previously posted at:
https://lore.kernel.org/qemu-devel/20260616174620.438468-1-alejandro.j.jimenez@oracle.com/

Patches 2-5 address a Coverity finding and big-endian portability
issues. They were reviewed in:
https://lore.kernel.org/qemu-devel/20260624195925.1254462-1-alejandro.j.jimenez@oracle.com/

I did basic smoke testing on an AMD Zen4 host using the AMD vIOMMU device.
Completed several guest boot and reboot cycles with xtsup both enabled and
disabled. No regressions were observed in guest startup or reboot behavior.

There are two other outstanding series pending review, but I am unlikely to
complete review/testing by myself for those before the upcoming soft-freeze
deadline.

Thank you,
Alejandro

Alejandro Jimenez (4):
  amd_iommu: Return int from page walk status helpers
  amd_iommu: Decode XT interrupt control register without bitfields
  amd_iommu: Decode IRTEs without bitfields
  amd_iommu: Fix endianness handling for command buffer entries

David Hoppenbrouwers (1):
  amd_iommu: Fix opcode reported in invalid command handling

 hw/i386/amd_iommu.c | 168 +++++++++++++++++++++++++++++++-------------
 hw/i386/amd_iommu.h |  63 -----------------
 2 files changed, 120 insertions(+), 111 deletions(-)


base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
-- 
2.47.3


