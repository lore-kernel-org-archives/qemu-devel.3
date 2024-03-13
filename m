Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16231C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 13:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkP5I-000273-47; Wed, 13 Mar 2024 09:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rkP4x-0001sN-Dn
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 09:55:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rkP4t-00036I-KN
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 09:55:34 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42D8i7aG031167; Wed, 13 Mar 2024 13:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=yNPYq5MseoAKYH52wi9OHIv1lZYux99SDhvTlFCw9mI=;
 b=WgH/ewbvF3XVIbnJ8ib4kG7+U3Bwpmwr9dFLUQkTbg2dDxy9VoSRZAcJZx8GojsAAwhY
 AU0F2zvnaNnc8N9m8CBqVPkFqUXuA1bl8KmaT0IzJHOGSs9HAkMLIirgEe11CP4qgJaM
 nZi9TUGIkAEY4UuZAxjQH7ZDtKex3eEfcOaaV+9hYgMGCr17cWQD80h1jBK8y9D308WT
 rzLWQnJ6ASDI6sibRzHMhNZrXcJebNBu3ZgcGzBMBkGeKUaN/rBQRiQIOx7rqofouQtv
 9CsYxkz2PyBBnqNq0fSgv555egPVj3yX2yQsJFTWJ+5NWa14wD69whl26eG6t2xi6yGs gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepd0w9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 13:55:23 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42DDQW0k037319; Wed, 13 Mar 2024 13:55:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre78u5cm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 13:55:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42DDtL0p037833;
 Wed, 13 Mar 2024 13:55:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wre78u5c0-1; Wed, 13 Mar 2024 13:55:21 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] migration: cpr-reboot documentation
Date: Wed, 13 Mar 2024 06:55:19 -0700
Message-Id: <1710338119-330923-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130104
X-Proofpoint-ORIG-GUID: 09XHw80M-DWKnT04CEvXhSpKZdxtk0Ic
X-Proofpoint-GUID: 09XHw80M-DWKnT04CEvXhSpKZdxtk0Ic
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

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 docs/devel/migration/CPR.rst      | 147 ++++++++++++++++++++++++++++++++++++++
 docs/devel/migration/features.rst |   1 +
 2 files changed, 148 insertions(+)
 create mode 100644 docs/devel/migration/CPR.rst

diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
new file mode 100644
index 0000000..63c3647
--- /dev/null
+++ b/docs/devel/migration/CPR.rst
@@ -0,0 +1,147 @@
+CheckPoint and Restart (CPR)
+============================
+
+CPR is the umbrella name for a set of migration modes in which the
+VM is migrated to a new QEMU instance on the same host.  It is
+intended for use when the goal is to update host software components
+that run the VM, such as QEMU or even the host kernel.  At this time,
+cpr-reboot is the only available mode.
+
+Because QEMU is restarted on the same host, with access to the same
+local devices, CPR is allowed in certain cases where normal migration
+would be blocked.  However, the user must not modify the contents of
+guest block devices between quitting old QEMU and starting new QEMU.
+
+CPR unconditionally stops VM execution before memory is saved, and
+thus does not depend on any form of dirty page tracking.
+
+cpr-reboot mode
+---------------
+
+In this mode, QEMU stops the VM, and writes VM state to the migration
+URI, which will typically be a file.  After quitting QEMU, the user
+resumes by running QEMU with the ``-incoming`` option.  Because the
+old and new QEMU instances are not active concurrently, the URI cannot
+be a type that streams data from one instance to the other.
+
+Guest RAM can be saved in place if backed by shared memory, or can be
+copied to a file.  The former is more efficient and is therefore
+preferred.
+
+After state and memory are saved, the user may update userland host
+software before restarting QEMU and resuming the VM.  Further, if
+the RAM is backed by persistent shared memory, such as a DAX device,
+then the user may reboot to a new host kernel before restarting QEMU.
+
+This mode supports VFIO devices provided the user first puts the
+guest in the suspended runstate, such as by issuing the
+``guest-suspend-ram`` command to the QEMU guest agent.  The agent
+must be pre-installed in the guest, and the guest must support
+suspend to RAM.  Beware that suspension can take a few seconds, so
+the user should poll to see the suspended state before proceeding
+with the CPR operation.
+
+Usage
+^^^^^
+
+It is recommended that guest RAM be backed with some type of shared
+memory, such as ``memory-backend-file,share=on``, and that the
+``x-ignore-shared`` capability be set.  This combination allows memory
+to be saved in place.  Otherwise, after QEMU stops the VM, all guest
+RAM is copied to the migration URI.
+
+Outgoing:
+  * Set the migration mode parameter to ``cpr-reboot``.
+  * Set the ``x-ignore-shared`` capability if desired.
+  * Issue the ``migrate`` command.  It is recommended the the URI be a
+    ``file`` type, but one can use other types such as ``exec``,
+    provided the command captures all the data from the outgoing side,
+    and provides all the data to the incoming side.
+  * Quit when QEMU reaches the postmigrate state.
+
+Incoming:
+  * Start QEMU with the ``-incoming defer`` option.
+  * Set the migration mode parameter to ``cpr-reboot``.
+  * Set the ``x-ignore-shared`` capability if desired.
+  * Issue the ``migrate-incoming`` command.
+  * If the VM was running when the outgoing ``migrate`` command was
+    issued, then QEMU automatically resumes VM execution.
+
+Example 1
+^^^^^^^^^
+::
+
+  # qemu-kvm -monitor stdio
+  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/dax0.0,align=2M,share=on -m 4G
+  ...
+
+  (qemu) info status
+  VM status: running
+  (qemu) migrate_set_parameter mode cpr-reboot
+  (qemu) migrate_set_capability x-ignore-shared on
+  (qemu) migrate -d file:vm.state
+  (qemu) info status
+  VM status: paused (postmigrate)
+  (qemu) quit
+
+  ### optionally update kernel and reboot
+  # systemctl kexec
+  kexec_core: Starting new kernel
+  ...
+
+  # qemu-kvm ... -incoming defer
+  (qemu) info status
+  VM status: paused (inmigrate)
+  (qemu) migrate_set_parameter mode cpr-reboot
+  (qemu) migrate_set_capability x-ignore-shared on
+  (qemu) migrate_incoming file:vm.state
+  (qemu) info status
+  VM status: running
+
+Example 2: VFIO
+^^^^^^^^^^^^^^^
+::
+
+  # qemu-kvm -monitor stdio
+  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/dax0.0,align=2M,share=on -m 4G
+  -device vfio-pci, ...
+  -chardev socket,id=qga0,path=qga.sock,server=on,wait=off
+  -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0
+  ...
+
+  (qemu) info status
+  VM status: running
+
+  # echo '{"execute":"guest-suspend-ram"}' | ncat --send-only -U qga.sock
+
+  (qemu) info status
+  VM status: paused (suspended)
+  (qemu) migrate_set_parameter mode cpr-reboot
+  (qemu) migrate_set_capability x-ignore-shared on
+  (qemu) migrate -d file:vm.state
+  (qemu) info status
+  VM status: paused (postmigrate)
+  (qemu) quit
+
+  ### optionally update kernel and reboot
+  # systemctl kexec
+  kexec_core: Starting new kernel
+  ...
+
+  # qemu-kvm ... -incoming defer
+  (qemu) info status
+  VM status: paused (inmigrate)
+  (qemu) migrate_set_parameter mode cpr-reboot
+  (qemu) migrate_set_capability x-ignore-shared on
+  (qemu) migrate_incoming file:vm.state
+  (qemu) info status
+  VM status: paused (suspended)
+  (qemu) system_wakeup
+  (qemu) info status
+  VM status: running
+
+Caveats
+^^^^^^^
+
+cpr-reboot mode may not be used with postcopy, background-snapshot,
+or COLO.
diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index 9d1abd2..d5ca7b8 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -11,3 +11,4 @@ Migration has plenty of features to support different use cases.
    vfio
    virtio
    mapped-ram
+   CPR
-- 
1.8.3.1


