Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDCC606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oVR6cHQP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULP2-0008EN-2h; Fri, 20 Nov 2026 04:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULP0-0008E1-IM; Fri, 20 Nov 2026 04:59:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULOy-0007e3-Lq; Fri, 20 Nov 2026 04:59:30 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7uRVD2649792; Fri, 20 Nov 2026 09:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=21rq0SF50BsTusTuJ
 qRCQdZ7mQRRWZdu/b/yC1gWJSM=; b=oVR6cHQPAlOOFh+4Lh6D4ANBb0KB9F687
 J6DEZzVEJeoHCZCd2qETdOLZuJpi9knob7/P5ryp+sxL2DshdzIna/lZIZnixGm0
 EEEqzRTkrLZc03WETVrrK1FjuIwoofU+P3g9K9Sh16bEU+MVe2wVzcy34PRXirIc
 gW7efCEgjsW7vOztfZOgJN4Q5UDeh0AYrQLpzzce5C9kYg/10gIn4SOUTzhUIiYz
 oKK8pavhMJiJPwRNdRe3zrXRKEbhYOfcw38ZMZbntAEkt2LSFLvvXpJPOARg5v1G
 DpklNTsi73aiKVah8oc4bZu74Y/Msdg2D9Z6ms4DRFXOQwkrvRDjw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nqjuv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 09:59:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK84pce145272; Fri, 20 Nov 2026 09:59:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j23dwd0q9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 09:59:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AK9xJxB18022806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 09:59:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45FA72004D;
 Fri, 20 Nov 2026 09:59:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC5D420043;
 Fri, 20 Nov 2026 09:59:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.205])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2026 09:59:14 +0000 (GMT)
From: Aniket Sahu <asahu1x@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peterx@redhat.com, farosas@suse.de, npiggin@gmail.com,
 adityag@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 rathc@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com,
 amachhiw@linux.ibm.com, asahu1x@linux.ibm.com
Subject: [PATCH 3/5] tests/functional/ppc64: add kernel params and early panic
 detection
Date: Fri, 20 Nov 2026 15:28:56 +0530
Message-ID: <20261120095854.35941-10-asahu1x@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261120095854.35941-7-asahu1x@linux.ibm.com>
References: <20261120095854.35941-7-asahu1x@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfXxqzIllNXu/nV
 OiUPnSv0r7DNh2DzQUpCDPo180n0LQrzVHiCXeQ65wb1ePV5NsuSZmbBz+CmY/tXytgQaNuLW+N
 4kalhJj9zwokup4pgIFuQrfuG4vQ1vmPPQVHmPXniK+GJs+gwcvbmSNVdYPMRoVsNRTZnZaU/Tq
 nmPM+eskUlrTK5/3Yi7dUKobnKxKH8Ux1Kg771Lq1EO8vzYhNYwuwdqjn8xPRLATb2Tx4I7OawH
 W0NOjN2qms1fDQ1rcn1x3yLWfpwypn2kfARfzYFVJ9gnutv2lOEA7GF2xEufa5Du3IswEfpFP4O
 x+WrzgVr8WDwUQFztdDtFlK2xmYwwneNOu+v42GPKf6wmhMRzgfQ3SHhPqDIhMvWjzZtRlf+mvW
 dk0gPtW6VVmvWpkdWD+xonTx9ao2TFexksG1rs6IL4vOt9wgYj6WP8ahDtNSV9avaRyw6AF/hT+
 35VOWwqggqzy2hU89OQ==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6b0019fd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=jwu5jcRAUhPRygd0sEUA:9
X-Proofpoint-GUID: v7V5dO1hN0ts_JMFjHZeThCROYi_kzgb
X-Proofpoint-ORIG-GUID: EWappiGMUD9h5uX1QY0oCbA0p07vSaPK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX0IfjZvGwqHdc
 NBLCAgDJWxDQG4W52lIHcAIIW35gRTq6G/H0AQ2CpSnf86ZIjvGIE7/VsqZb9kuYGhzKVyQvkAZ
 8jEBQpxNqtZZAN80gQLnkbhWl+y+NoA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200039
Received-SPF: pass client-ip=148.163.156.1; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add kernel command line parameters and improve error handling:
- Pass "console=hvc0 usbcore.nousb" on the L1 kernel command line
- Add early panic detection in do_test_kvm() with failure_message
- Retry apk update up to 5 times with 10 second delays
- Add debug logging at key steps (VM launch, login, apk update)

This allows the test to fail early if L2 panics instead of waiting
for the login prompt until timeout, and makes the Alpine setup more
robust against transient network issues.

Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
---
 tests/functional/ppc64/test_hv.py | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tests/functional/ppc64/test_hv.py b/tests/functional/ppc64/test_hv.py
index d977038271..d983e5229c 100755
--- a/tests/functional/ppc64/test_hv.py
+++ b/tests/functional/ppc64/test_hv.py
@@ -63,16 +63,20 @@ def setUp(self):
         self.initramfs = self.extract_from_iso(self.iso_path, '/boot/initramfs-lts')
 
     def do_start_alpine(self):
+        self.log.debug("do_start_alpine: launching L1 VM")
         self.vm.set_console()
-        self.vm.add_args("-kernel", self.vmlinuz)
-        self.vm.add_args("-initrd", self.initramfs)
-        self.vm.add_args("-smp", "4", "-m", "2g")
-        self.vm.add_args("-drive", f"file={self.iso_path},format=raw,if=none,"
-                                    "id=drive0,read-only=true")
-
+        self.vm.add_args(
+            "-kernel", self.vmlinuz,
+            "-initrd", self.initramfs,
+            "-smp", "4", "-m", "2g",
+            "-drive", f"file={self.iso_path},format=raw,if=none,id=drive0,read-only=true",
+            "-append", "console=hvc0 usbcore.nousb",
+        )
         self.vm.launch()
+        self.log.debug("do_start_alpine: VM launched, waiting for login prompt")
         ps1='localhost:~#'
         wait_for_console_pattern(self, 'localhost login:')
+        self.log.debug("do_start_alpine: got login prompt, logging in as root")
         exec_command_and_wait_for_pattern(self, 'root', ps1)
         self.log.debug("do_start_alpine: logged in, setting system clock")
         # If the time is wrong, SSL certificates can fail.
@@ -80,8 +84,11 @@ def do_start_alpine(self):
         exec_command_and_wait_for_pattern(self, cmd, ps1)
         ps1='alpine:~#'
         exec_command_and_wait_for_pattern(self, 'setup-alpine -qe', ps1)
-        exec_command_and_wait_for_pattern(self, 'setup-apkrepos -c1', ps1)
-        exec_command_and_wait_for_pattern(self, 'apk update', ps1)
+        exec_command_and_wait_for_pattern(
+            self,
+            'for i in 1 2 3 4 5; do apk update && break; sleep 10; done',
+            ps1)
+        self.log.debug("do_start_alpine: apk update complete, Alpine L1 is ready")
         # Could upgrade here but it usually should not be necessary
         # exec_command_and_wait_for_pattern(self, 'apk upgrade --available', ps1)
 
@@ -114,9 +121,12 @@ def do_test_kvm(self, hpt=False):
                            '-kernel /media/nvme0n1/boot/vmlinuz-lts '
                            '-append \'usbcore.nousb ' + append + '\'')
         # Alpine 3.21 kernel seems to crash in XHCI USB driver.
-        ps1='localhost:~#'
-        wait_for_console_pattern(self, 'localhost login:')
+        ps1 = 'localhost:~#'
+        wait_for_console_pattern(self, 'localhost login:',
+                                 failure_message=self.panic_message)
+        self.log.debug("do_test_kvm: L2 login prompt seen, logging in")
         exec_command_and_wait_for_pattern(self, 'root', ps1)
+        self.log.debug("do_test_kvm: logged into L2, issuing poweroff")
         exec_command(self, 'poweroff')
         wait_for_console_pattern(self, 'reboot: Power down')
         # Now wait for the host's prompt to come back
-- 
2.52.0


