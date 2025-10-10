Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DE1CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 12:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7C3V-0000kp-QG; Fri, 10 Oct 2025 08:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v7C3S-0000jW-9M
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:17:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v7C3L-0005Fg-CE
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:17:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A8tM1h003680;
 Fri, 10 Oct 2025 12:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=iDzhWHqJ
 +KIDITg8y7iLfTA4e121WBjnQvtG1VK/WN8=; b=CKYI+aA4zlm3/vy1KCCxMOlx
 sZHnV15Q2eHHrS0UX9TuXnn/sJdG/fijncKcGtCYSZfdzVW/h3FcWdWKxCslvHB8
 4bPdSPBXx8UGRW4BDNThjTb/IiSW7cP14cBC8HqDYZbBQjCM5171OuT2nfNJSxpt
 XIjDrl5+C7u4NTj8AP6WpKGe/VvHo1pPlCOEBLYF1nlKmZGJvUCO265ukY/FBB3G
 Lxtz2FRJ681ztKdoHdGjwfhBZL8BikakWBlazY0oNc881ItwMwQPJVlZ5pc4/S5e
 xSGte8TIuPs7lKvOC61bAD2XXsPaRNCs+THqWZhOU+sJE8FDJT90sLT/ucn49g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6duhmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Oct 2025 12:16:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 59ABYGYq022916; Fri, 10 Oct 2025 12:16:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49nv63wgd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Oct 2025 12:16:42 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59ACGgHr001220;
 Fri, 10 Oct 2025 12:16:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 49nv63wgcq-1; Fri, 10 Oct 2025 12:16:42 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] MAINTAINERS: update cpr reviewers
Date: Fri, 10 Oct 2025 05:16:40 -0700
Message-Id: <1760098600-399192-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510100070
X-Proofpoint-ORIG-GUID: pkxjUWAh2wmFARQ1NUjJtXVK8ClgkKov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX46dm9pHACUB9
 avtmBaKsAkUHLjKfD/ZhTtsu+eAAwCU6Z8QcKNkOQYclNZ/GbVxbPB3V6+nFEU0ee/jIrN2LunR
 3XYEv5eRHEiY1rsC4NDVpnVFgrHQalaYzf2Qlo1RTnWulYGnioTRvJ6g6OtON7VoBImE+7pIq3A
 rBSrK12RCxMu85zjHXUHxY1xsHhp662YsoaQUiDwieXtHHUcTMWS5s+HR4q6GHPzvs08bCQgwJi
 s8XUwfYU5RH1KfNxesQ2xgPqqGRSFQVJec1/VuGxm5M4hSGtXJRrAnywdrmR0O95KuH79q4ABzm
 yAreZD0WO8vj/xGHp5RoOjrfm6uJZMGTxj65YCuGagpHrvtkxiFjcMiwZcI01a6Qvh/xwHmmp0F
 NlbFDLFH8FhwSfE0QaeTtphE+de/tiChw0uyEJPrmc/rGzX1iAM=
X-Authority-Analysis: v=2.4 cv=etHSD4pX c=1 sm=1 tr=0 ts=68e8f92b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=x6icFKpwvdMA:10 a=p0WdMEafAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=n0Zxfx1fad7VIAJ_cMQA:9 cc=ntf awl=host:12091
X-Proofpoint-GUID: pkxjUWAh2wmFARQ1NUjJtXVK8ClgkKov
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Update cpr reviewers.  Some of these files overlap with migration
files, but some do not.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 84cfd85..9a10bda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3107,7 +3107,8 @@ T: git https://gitlab.com/jsnow/qemu.git jobs
 T: git https://gitlab.com/vsementsov/qemu.git block
 
 CheckPoint and Restart (CPR)
-R: Steve Sistare <steven.sistare@oracle.com>
+R: Peter Xu <peterx@redhat.com>
+R: Fabiano Rosas <farosas@suse.de>
 S: Supported
 F: hw/vfio/cpr*
 F: include/hw/vfio/vfio-cpr.h
-- 
1.8.3.1


