Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9473BCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umba9-0005Vg-T8; Thu, 14 Aug 2025 13:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba8-0005Ug-F5
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba6-0002qm-3I
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:40 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECg3mj028292;
 Thu, 14 Aug 2025 17:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=lo6X3UMp0cHGTVVBmKXC6tE1Dq+dM5ocqlmIJ3zKhLY=; b=
 AYTXthg3luew6B/VqSyP1ga/MhIToHnauNqLRLIEOYvEFNN33gpRPtvcStpI4Jga
 6ZrJEPq6QF6pe0qiBOJeyqmogQw19WaDoikaikdXeaOXgMbIXgpR0gISXWhCd46d
 uZpG17W0Y0T0ZmsDB7wZkXtiJZgOwpsDW1jucs1CGM2vsX23gfM3rQR8/kgONsUv
 NqL6GJo6oGvxMc9lJjEXQzFrgJfZwLmud/frJ49ddS916woUW31+OHm00QYXirGT
 Db2mfNopM5/6WuqDzlyqU48xpgE8Ah21vutLBV/+xepBnN0ts7P8l/yrc4gJBU9R
 74YFRf5D3/RSt/94S1tk9A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48guchayyh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:35 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57EGYax4009640; Thu, 14 Aug 2025 17:17:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvskbs35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57EHGwuM038225;
 Thu, 14 Aug 2025 17:17:34 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 48dvskbrx5-9; Thu, 14 Aug 2025 17:17:34 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 8/9] migration: cpr-exec docs
Date: Thu, 14 Aug 2025 10:17:22 -0700
Message-Id: <1755191843-283480-9-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508140147
X-Authority-Analysis: v=2.4 cv=Eo/SrTcA c=1 sm=1 tr=0 ts=689e1a2f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=OdD1Jf7BiRZ0qi4wpjQA:9 cc=ntf
 awl=host:12069
X-Proofpoint-ORIG-GUID: BDfB8vq0eHI17upq3L1nbcQREcnxIcnH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDE0OCBTYWx0ZWRfX2g81twGbQLWx
 hSEtIzav3Eo6oUJhpJyjaECk00rXS+WTFT0nYZ4squlVB6FBAcCsFJetk6nsf3Kn/zj2kuY9MMR
 5PC1reh77eOJtVSKRBjXrIJzeTorF1wLLQfvajlj54SbriXFCtb6cghm50E+6qzcf1wGJhzZlih
 pVHHK8QTpPiY2Zuk5DDcYRzYYYF6YkojLsxnbLNDoVMSI2eVTWqNjaHy6LOHtatOKVWgJhAWDD/
 vf/ANNRSaVn6tHD3UmsKLR+4NGmf2qN8kHq1eWsbjDeAbxur5Gp5r9wz1gOXcAhRFVicKGMNwa6
 n7UsfHD2GHF5F7IdqETfGsLqsFB1wRnqoC3SPBlCJQKaSRgju4oxOlUsfkuYvJZCUH1ikYcGazU
 74IreZc5VhWvY3O/XJFfUO8ySK5zDcNZeYt225Pu73UAISaqIogRPhjMOWrO/1yX/rN7GxpE
X-Proofpoint-GUID: BDfB8vq0eHI17upq3L1nbcQREcnxIcnH
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Update developer documentation for cpr-exec mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 docs/devel/migration/CPR.rst | 103 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
index 0a0fd4f..abc9a90 100644
--- a/docs/devel/migration/CPR.rst
+++ b/docs/devel/migration/CPR.rst
@@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
 VM is migrated to a new QEMU instance on the same host.  It is
 intended for use when the goal is to update host software components
 that run the VM, such as QEMU or even the host kernel.  At this time,
-the cpr-reboot and cpr-transfer modes are available.
+the cpr-reboot, cpr-transfer, and cpr-exec modes are available.
 
 Because QEMU is restarted on the same host, with access to the same
 local devices, CPR is allowed in certain cases where normal migration
@@ -324,3 +324,104 @@ descriptors from old to new QEMU.  In the future, descriptors for
 vhost, and char devices could be transferred,
 preserving those devices and their kernel state without interruption,
 even if they do not explicitly support live migration.
+
+cpr-exec mode
+-------------
+
+In this mode, QEMU stops the VM, writes VM state to the migration
+URI, and directly exec's a new version of QEMU on the same host,
+replacing the original process while retaining its PID.  Guest RAM is
+preserved in place, albeit with new virtual addresses.  The user
+completes the migration by specifying the ``-incoming`` option, and
+by issuing the ``migrate-incoming`` command if necessary; see details
+below.
+
+This mode supports VFIO/IOMMUFD devices by preserving device descriptors
+and hence kernel state across the exec, even for devices that do not
+support live migration.
+
+Because the old and new QEMU instances are not active concurrently,
+the URI cannot be a type that streams data from one instance to the
+other.
+
+Usage
+^^^^^
+
+Arguments for the new QEMU process are taken from the
+@cpr-exec-args parameter.  The first argument should be the
+path of a new QEMU binary, or a prefix command that exec's the
+new QEMU binary, and the arguments should include the ''-incoming''
+option.
+
+Memory backend objects must have the ``share=on`` attribute.
+The VM must be started with the ``-machine aux-ram-share=on`` option.
+
+Outgoing:
+  * Set the migration mode parameter to ``cpr-exec``.
+  * Set the ``cpr-exec-args`` parameter.
+  * Issue the ``migrate`` command.  It is recommended the the URI be
+    a ``file`` type, but one can use other types such as ``exec``,
+    provided the command captures all the data from the outgoing side,
+    and provides all the data to the incoming side.
+
+Incoming:
+  * You do not need to explicitly start new QEMU.  It is started as
+    a side effect of the migrate command above.
+  * If the VM was running when the outgoing ``migrate`` command was
+    issued, then QEMU automatically resumes VM execution.
+
+Example 1: incoming URI
+^^^^^^^^^^^^^^^^^^^^^^^
+
+In these examples, we simply restart the same version of QEMU, but in
+a real scenario one would set a new QEMU binary path in cpr-exec-args.
+
+::
+
+  # qemu-kvm -monitor stdio
+  -object memory-backend-memfd,id=ram0,size=4G
+  -machine memory-backend=ram0
+  -machine aux-ram-share=on
+  ...
+
+  QEMU 10.2.50 monitor - type 'help' for more information
+  (qemu) info status
+  VM status: running
+  (qemu) migrate_set_parameter mode cpr-exec
+  (qemu) migrate_set_parameter cpr-exec-args qemu-kvm ... -incoming file:vm.state
+  (qemu) migrate -d file:vm.state
+  (qemu) QEMU 10.2.50 monitor - type 'help' for more information
+  (qemu) info status
+  VM status: running
+
+Example 2: incoming defer
+^^^^^^^^^^^^^^^^^^^^^^^^^
+::
+
+  # qemu-kvm -monitor stdio
+  -object memory-backend-memfd,id=ram0,size=4G
+  -machine memory-backend=ram0
+  -machine aux-ram-share=on
+  ...
+
+  QEMU 10.2.50 monitor - type 'help' for more information
+  (qemu) info status
+  VM status: running
+  (qemu) migrate_set_parameter mode cpr-exec
+  (qemu) migrate_set_parameter cpr-exec-args qemu-kvm ... -incoming defer
+  (qemu) migrate -d file:vm.state
+  (qemu) QEMU 10.2.50 monitor - type 'help' for more information
+  (qemu) info status
+  status: paused (inmigrate)
+  (qemu) migrate_incoming file:vm.state
+  (qemu) info status
+  VM status: running
+
+Caveats
+^^^^^^^
+
+cpr-exec mode may not be used with postcopy, background-snapshot,
+or COLO.
+
+cpr-exec mode requires permission to use the exec system call, which
+is denied by certain sandbox options, such as spawn.
-- 
1.8.3.1


