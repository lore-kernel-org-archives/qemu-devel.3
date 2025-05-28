Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9278C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJrn-00085Z-OJ; Wed, 28 May 2025 12:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJrV-0007zH-VE
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:42:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJrS-0007i3-U8
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:42:41 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCq7ok028826;
 Wed, 28 May 2025 16:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=n+NWh
 LpU+WnA7qzz2cX4k7PhKZJW81YslIcvFwxtCWE=; b=ZiDnVfsJCkyMg9koUoH7J
 RsC6i1joMdYV0MU9Pwx0egDrIvgafBFSJkf+4vWeyrvPcsNkL2ZKOuWAqjOAfVcX
 ncZCUWszTBKigJBcwXMCDnyZiiWDYK63JSljZ9LJ//TqvN4ZerBllmav5BGi/cXc
 ryGqX+dH2K4fqEF9K4ZMriSBmTdLmiFtzqi77WchAqrh5dOiTSXGtffuzyxGgECM
 azbVq1MRn/EomniaHZEaamrgog4T8tEC7h/j2Q1O7J1Ed8odntYTf0cOwAuaU2Lz
 hQAvVvZvTmPsQjT65fcYqrLedQaeS/yWpeNoJmj+S4JEyAyPV5HCmXdcYitBEfYB
 A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s6aan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:42:30 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SFi0kq027795; Wed, 28 May 2025 16:42:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4janrmt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:42:29 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SGgStd025769;
 Wed, 28 May 2025 16:42:28 GMT
Received: from localhost.localdomain (dhcp-10-43-12-51.usdhcp.oraclecorp.com
 [10.43.12.51])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46u4janrk1-1; Wed, 28 May 2025 16:42:28 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [PATCH 13/13] acpi: hmp/qmp: Add hmp/qmp support for system_sleep
Date: Wed, 28 May 2025 12:42:18 -0400
Message-ID: <20250528164219.2247-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250528163545.2143-1-annie.li@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0NSBTYWx0ZWRfXy4LbvNrR8GNP
 2fPapbSiebRVfwk+uLYjVK+BTc/y+4iw+9o4U+YDSga19BYNObuklJ2kdECboHpUPf5NfYFYOaI
 fKHsjEuLf0/FiL85A5aFKbVAe9l148fQUAvhxe012GVcreis3eXgfU36PeTK10GKKb0dDEA1JlH
 6TaguWLhDYfcvj6en2PCwMxEelxQGDwOcd83ErpbhSLdhtWMP8svW0vNJgyf70oFxEs698+/EKi
 W3O1Lkdi2bvbmKMFLmfzSibJDl1RJ0gFGMqZjXajP/lqJxEwfC3kZ23JyEbrSbFRfxCEWkK4giQ
 CGpKlq5iPwx3XsaYv6eiR+i8B/HCOkIoncBhy8hEKezumu+AymqZlrZZFZ2BJWhL7ktc8VyxKX8
 KKX0CCEuy0Hion0Hy4PiOzP8mChq/V0i5M4dzSsbEDCWq9XNfctYiPkSGZlxrAuqj9Hh2XWD
X-Proofpoint-GUID: YTwYKirBBRnriAFzzrgZusBWv-r5YXBY
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=68373cf6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=chHaGow_Xe9aAjHtMDoA:9
X-Proofpoint-ORIG-GUID: YTwYKirBBRnriAFzzrgZusBWv-r5YXBY
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Following hmp/qmp commands are implemented for pressing virtual
sleep button,

hmp: system_sleep
qmp: { "execute": "system_sleep" }

These commands put the guest into suspend or other power states
depending on the power settings inside the guest.

These hmp/qmp command are in '*_*' format, it is intended to do
so to align to existing 'system_*' commands.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hmp-commands.hx            | 14 ++++++++++++++
 hw/core/machine-hmp-cmds.c |  5 +++++
 hw/core/machine-qmp-cmds.c | 11 +++++++++++
 include/monitor/hmp.h      |  1 +
 qapi/machine.json          | 20 ++++++++++++++++++++
 qapi/pragma.json           |  1 +
 6 files changed, 52 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 06746f0afc..12f08f3444 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -639,6 +639,20 @@ SRST
   whether profiling is on or off.
 ERST
 
+    {
+        .name       = "system_sleep",
+        .args_type  = "",
+        .params     = "",
+        .help       = "send system sleep event",
+        .cmd = hmp_system_sleep,
+    },
+
+SRST
+``system_sleep``
+  Push the virtual sleep button; if supported, the system will enter
+  an ACPI sleep state.
+ERST
+
     {
         .name       = "system_reset",
         .args_type  = "",
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index c6325cdcaa..f8a7c1de88 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -189,6 +189,11 @@ void hmp_system_reset(Monitor *mon, const QDict *qdict)
     qmp_system_reset(NULL);
 }
 
+void hmp_system_sleep(Monitor *mon, const QDict *qdict)
+{
+    qmp_system_sleep(NULL);
+}
+
 void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
 {
     qmp_system_powerdown(NULL);
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 1bc21b84a4..80b877d8cd 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -12,6 +12,7 @@
 #include "hw/boards.h"
 #include "hw/intc/intc.h"
 #include "hw/mem/memory-device.h"
+#include "hw/acpi/acpi.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-machine.h"
@@ -277,6 +278,16 @@ void qmp_system_reset(Error **errp)
     qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
 }
 
+void qmp_system_sleep(Error **errp)
+{
+    if (!qemu_wakeup_suspend_enabled()) {
+        error_setg(errp,
+                   "suspend from running is not supported by this machine");
+        return;
+    }
+    acpi_send_sleep_event();
+}
+
 void qmp_system_powerdown(Error **errp)
 {
     qemu_system_powerdown_request();
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index ae116d9804..e543eec109 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -43,6 +43,7 @@ void hmp_quit(Monitor *mon, const QDict *qdict);
 void hmp_stop(Monitor *mon, const QDict *qdict);
 void hmp_sync_profile(Monitor *mon, const QDict *qdict);
 void hmp_system_reset(Monitor *mon, const QDict *qdict);
+void hmp_system_sleep(Monitor *mon, const QDict *qdict);
 void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
 void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
 void hmp_announce_self(Monitor *mon, const QDict *qdict);
diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795b09..3efaf82f7d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -361,6 +361,26 @@
 ##
 { 'command': 'system_reset' }
 
+##
+# @system_sleep:
+#
+# Requests that the guest perform a ACPI sleep transition by pushing
+# the virtual sleep button.
+#
+# Since:10.0
+#
+# .. note:: A guest may or may not respond to this command.  This
+#        command returning does not indicate that a guest has
+#        accepted the request or that it has gone to sleep.
+#
+# .. qmp-example::
+#
+# -> { "execute": "system_sleep" }
+# <- { "return": {} }
+#
+##
+{ 'command': 'system_sleep' }
+
 ##
 # @system_powerdown:
 #
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 023a2ef7bc..285ce82e9b 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -23,6 +23,7 @@
         'set_password',
         'system_powerdown',
         'system_reset',
+        'system_sleep',
         'system_wakeup' ],
     # Commands allowed to return a non-dictionary
     'command-returns-exceptions': [
-- 
2.43.5


