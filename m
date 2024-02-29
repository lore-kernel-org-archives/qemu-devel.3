Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B843AC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhC1-00074u-2q; Thu, 29 Feb 2024 09:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfhBz-00072C-9e
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:15:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfhBw-0002PY-PE
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:15:23 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41T9M5Yt017371; Thu, 29 Feb 2024 14:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=+KZ7ZPG8/4OyXOAYJR5ka81bx5WihxqCFCBiApDNcTg=;
 b=fC3b1ot1eiqzSjHJ+yHcg6y1kShHWzpR8IShjkCqXRfDc49IRvYI7NcfEsSqS5OVMVH4
 Dh1Br12VS+3d16TmlOp5Dr+lISuqtNe3R3tPqEFRxx5KRznmKoKxuFmS3JBfcuTNLt59
 /C6rPalFgRoWo1XsFNNdT/PEARdNB+AlOu6giyeHfvGwdhotEfNZOgm2phAkXkoHQJOU
 55GfD/cm+Uxs9jYm4WPMXsZP9UUy9mqc5sSNhHmQrLfJtgxG6JTte3BCScG7Oc6ovqAy
 gFNsvLW9gzF9IctIz+5p9Rqx1afyd9U664PZVB+Fz+wNhHdATRCjyKk288/Uk6TwNcLs 6Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccnque-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 14:15:17 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41TDJcIT009801; Thu, 29 Feb 2024 14:15:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6wahe04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 14:15:16 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41TEFGKV002988;
 Thu, 29 Feb 2024 14:15:16 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3wf6wahdyu-1; Thu, 29 Feb 2024 14:15:16 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] migration: re-format cpr-reboot documentation
Date: Thu, 29 Feb 2024 06:15:15 -0800
Message-Id: <1709216115-3093-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290110
X-Proofpoint-ORIG-GUID: sZOy32VXsTr-UbcKuo9ZeSrgf6pplFGe
X-Proofpoint-GUID: sZOy32VXsTr-UbcKuo9ZeSrgf6pplFGe
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Re-wrap the cpr-reboot documentation to 70 columns, use '@' for
cpr-reboot references, and capitalize COLO.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 qapi/migration.json | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index c6bfe2e..b69f62a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -636,28 +636,30 @@
 #
 # @normal: the original form of migration. (since 8.2)
 #
-# @cpr-reboot: The migrate command stops the VM and saves state to the URI.
-#     After quitting qemu, the user resumes by running qemu -incoming.
+# @cpr-reboot: The migrate command stops the VM and saves state to
+#     the URI.  After quitting qemu, the user resumes by running
+#     qemu -incoming.
 #
-#     This mode allows the user to quit qemu, and restart an updated version
-#     of qemu.  The user may even update and reboot the OS before restarting,
-#     as long as the URI persists across a reboot.
+#     This mode allows the user to quit qemu and restart an updated
+#     version of qemu.  The user may even update and reboot the OS
+#     before restarting, as long as the URI persists across a reboot.
 #
-#     Unlike normal mode, the use of certain local storage options does not
-#     block the migration, but the user must not modify guest block devices
-#     between the quit and restart.
+#     Unlike normal mode, the use of certain local storage options
+#     does not block the migration, but the user must not modify guest
+#     block devices between the quit and restart.
 #
-#     This mode supports vfio devices provided the user first puts the guest
-#     in the suspended runstate, such as by issuing guest-suspend-ram to the
-#     qemu guest agent.
+#     This mode supports vfio devices provided the user first puts
+#     the guest in the suspended runstate, such as by issuing
+#     guest-suspend-ram to the qemu guest agent.
 #
-#     Best performance is achieved when the memory backend is shared and the
-#     @x-ignore-shared migration capability is set, but this is not required.
-#     Further, if the user reboots before restarting such a configuration, the
-#     shared backend must be be non-volatile across reboot, such as by backing
-#     it with a dax device.
+#     Best performance is achieved when the memory backend is shared
+#     and the @x-ignore-shared migration capability is set, but this
+#     is not required.  Further, if the user reboots before restarting
+#     such a configuration, the shared backend must be be non-volatile
+#     across reboot, such as by backing it with a dax device.
 #
-#     cpr-reboot may not be used with postcopy, colo, or background-snapshot.
+#     @cpr-reboot may not be used with postcopy, background-snapshot,
+#     or COLO.
 #
 #     (since 8.2)
 ##
-- 
1.8.3.1


