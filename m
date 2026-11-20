Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B586B606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GReMQ6/O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULP6-0008Lu-A9; Fri, 20 Nov 2026 04:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULP4-0008JI-FD; Fri, 20 Nov 2026 04:59:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULP2-0007eT-CA; Fri, 20 Nov 2026 04:59:34 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7vK0d1293091; Fri, 20 Nov 2026 09:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/CmY5R
 xOUsflJE/Xm5KUbWCbqwX2qwl+Hmc3VMhHPag=; b=GReMQ6/OvJue4MuPIGAS0e
 LoTdCcQ2oP5+RfEyqOhaq4OUqaZptR9+WROPSdlbCSh52ZY6Ha/K/Nxlw9i0FHcc
 wico1+WufWv75tTKlhIV4qPWLwdjGe8liLiEXYgtLJUruDF+gndJTHLQBTG8OSrj
 SgmYP0MD1zLxz9Wj0me09tULqNJqU32eQ6VQTmaD3zQLdUH34dknaRmhB4iHfjCq
 pYVSFocF+uX29GD3LwzeJi5MSnuNrukt5tMptt0bV0nSoqmLgz1qxv2S91Z1ePQL
 MHm/5/JNCnqcj+eojqCCYl67kBvT8aAxYAe/zW4mw2OOYKSPkrS2WcMAFJyU8W5A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w768r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 09:59:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7oE2i3921021; Fri, 20 Nov 2026 09:59:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9xfbsn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 09:59:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AK9xO4Y46924226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 09:59:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EA792004D;
 Fri, 20 Nov 2026 09:59:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE67520040;
 Fri, 20 Nov 2026 09:59:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.205])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2026 09:59:19 +0000 (GMT)
From: Aniket Sahu <asahu1x@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peterx@redhat.com, farosas@suse.de, npiggin@gmail.com,
 adityag@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 rathc@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com,
 amachhiw@linux.ibm.com, asahu1x@linux.ibm.com
Subject: [PATCH 4/5] tests/functional/ppc64: dynamically resolve NVMe device
 path
Date: Fri, 20 Nov 2026 15:28:57 +0530
Message-ID: <20261120095854.35941-11-asahu1x@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261120095854.35941-7-asahu1x@linux.ibm.com>
References: <20261120095854.35941-7-asahu1x@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: KlNDw6LDy4K0RtGY71yrhNFm_-8f3Dy4
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6b001a01 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=L2EOhuFDJk7fRtCACkYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9FomuN-qAGxoQpyA2RCEDfUaFxnpBcmR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX27l3DFXjjY9G
 3XC8M7FCFcNLpAyoBlAMfhpbCcKKUO1kjDqfOffuEatQHOM6+8MdZAUTGFCs6KjuL924YAn5/ud
 qCxHBHbeWKB0rOJa28occoBgpujtA1I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX3uLvKwm0is+u
 sQh3MzZccZ/SSwsH4gMJY/7Y4jxqNkumDjkDayslDzKbZVO0eVE2k9HsHLYCbuqD0dVj1EDPPWN
 tBKWV7RjI8xSQhH8m7a+8FpoEUUsmgzxQaAQewlDZ0K7ekBZcKRcoSAPD6VLoMLhHuGMKdPH5cb
 shPHRU50oOlCFNC8rJ1oVG6uCh8TCENR3Dlws3BbpYRh4u9JXiIhIZIizPYNp0y0tsHtH1yCHqd
 3nQiFpXNGr8cdQtV7jMO0UJt5+qgHN/Mgbv4kE2JliPkVRrW3t7btCtv3lUDQAIzflmIqBthVU5
 DNEWHstFrTH/o/FIIJOYsRTSEd74vtUAmzojihe+diw1mgjwHSYa6qPdDX3PmRvPTucQhubq09Q
 JBxFW7Cyyjx4Yi7fmdzzOhO0hPkqu12aZK7Jf2HqbLpG9+YArKPsS6rVl1K72gFENLkKlkB2YDz
 T/Z9ZidwLXlKM2Vr2Cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200039
Received-SPF: pass client-ip=148.163.158.5; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Do not hardcode the NVMe device name in L1 as it depends on the PCIe
topology of the machine type (e.g., pseries may enumerate it as nvme0n1
or nvme1n1).

Add _resolve_nvme_dev() method to query the kernel for the actual device
path, and write the L2 launch command to a script (/tmp/run-l2.sh) to
avoid terminal line-wrap breaking shell argument parsing.

Also add '-cpu POWER9' to the L2 QEMU command line to match what
kvm-hv.ko in L1 sees, and add comprehensive debug logging throughout
do_test_kvm() and do_setup_kvm().

Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
---
 tests/functional/ppc64/test_hv.py | 87 +++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/tests/functional/ppc64/test_hv.py b/tests/functional/ppc64/test_hv.py
index d983e5229c..567313fb6c 100755
--- a/tests/functional/ppc64/test_hv.py
+++ b/tests/functional/ppc64/test_hv.py
@@ -10,6 +10,7 @@
 # later.  See the COPYING file in the top-level directory.
 
 import os
+import re
 import subprocess
 
 from datetime import datetime, timezone
@@ -100,9 +101,51 @@ def do_stop_alpine(self):
         self.vm.wait()
 
     def do_setup_kvm(self):
-        ps1='alpine:~#'
+        self.log.debug("do_setup_kvm: installing qemu-system-ppc64 in L1")
+        ps1 = 'alpine:~#'
         exec_command_and_wait_for_pattern(self, 'apk add qemu-system-ppc64', ps1)
+        self.log.debug("do_setup_kvm: qemu-system-ppc64 installed, loading kvm-hv")
         exec_command_and_wait_for_pattern(self, 'modprobe kvm-hv', ps1)
+        self.log.debug("do_setup_kvm: kvm-hv module loaded")
+
+    def _resolve_nvme_dev(self):
+        """
+        Determine the NVMe block device path that the ISO is attached as
+        inside the L1 Alpine guest.  The device name is not stable across
+        machine types (e.g. pseries may enumerate it as nvme0n1 or nvme1n1
+        depending on the PCIe bus topology), so we ask the kernel directly.
+
+        Returns the literal device path string, e.g. '/dev/nvme0n1', so
+        callers can bake it directly into shell scripts without any shell
+        variable scoping issues.
+        """
+        self.log.debug("_resolve_nvme_dev: probing NVMe device path in L1")
+        ps1 = 'alpine:~#'
+        # Print a clearly delimited marker and wait for the shell prompt so
+        # we accumulate all console bytes in one call — including any bytes
+        # that the terminal wraps across line boundaries.
+        out = exec_command_and_wait_for_pattern(
+            self,
+            'echo "NVME_PATH:$(ls /dev/nvme?n1 | head -1)"',
+            ps1,
+        )
+        # Decode, strip ANSI escape sequences and newlines, then extract the
+        # path.  Terminal line-wrap can split the token mid-string so we join
+        # all non-whitespace characters before matching.
+        text = out.decode('utf-8', errors='replace')
+        text = re.sub(r'\x1b\[[0-9;]*[A-Za-z]', '', text)
+        joined = ''.join(text.split())
+        # The joined string looks like: ...NVME_PATH:/dev/nvme0n1alpine:~#
+        m = re.search(r'NVME_PATH:(/dev/nvme\S+?)alpine', joined)
+        if not m:
+            m = re.search(r'NVME_PATH:(/dev/nvme\S+)', joined)
+        if m:
+            dev = m.group(1).rstrip('#~:').strip()
+        else:
+            dev = '/dev/nvme0n1'
+            self.log.debug("_resolve_nvme_dev: marker not found, using fallback")
+        self.log.debug("_resolve_nvme_dev: resolved device=%s", dev)
+        return dev
 
     # This uses the host's block device as the source file for guest block
     # device for install media. This is a bit hacky but allows reuse of the
@@ -110,16 +153,40 @@ def do_setup_kvm(self):
     def do_test_kvm(self, hpt=False):
         if hpt:
             append = 'disable_radix'
+            self.log.debug("do_test_kvm: launching L2 in HPT mode")
         else:
             append = ''
-        exec_command(self, 'qemu-system-ppc64 -nographic -smp 2 -m 1g '
-                           '-machine pseries,x-vof=on,accel=kvm '
-                           '-machine cap-cfpc=broken,cap-sbbc=broken,'
-                                    'cap-ibs=broken,cap-ccf-assist=off '
-                           '-drive file=/dev/nvme0n1,format=raw,readonly=on '
-                           '-initrd /media/nvme0n1/boot/initramfs-lts '
-                           '-kernel /media/nvme0n1/boot/vmlinuz-lts '
-                           '-append \'usbcore.nousb ' + append + '\'')
+            self.log.debug("do_test_kvm: launching L2 in Radix mode (default)")
+
+        # Resolve the NVMe device path inside the L1 guest first so we do
+        # not hardcode a path that may differ by machine type.
+        nvme_dev = self._resolve_nvme_dev()
+
+        # Write the L2 launch command to a script to avoid terminal line-wrap
+        # breaking shell argument parsing, and to keep individual lines short.
+        # nvme_dev is the literal path, e.g. /dev/nvme0n1 — bake it in.
+        mnt = f'/media/$(basename {nvme_dev})'
+        ps1 = 'alpine:~#'
+        l2_script = [
+            ("cat > /tmp/run-l2.sh << 'EOF'", '>'),
+            ('#!/bin/sh', '>'),
+            ('qemu-system-ppc64 -nographic \\', '>'),
+            ('  -smp 2 -m 1g \\', '>'),
+            ('  -cpu POWER9 \\', '>'),
+            ('  -machine pseries,x-vof=on,accel=kvm \\', '>'),
+            ('  -machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,cap-ccf-assist=off \\', '>'),
+            (f'  -drive file={nvme_dev},format=raw,readonly=on \\', '>'),
+            (f'  -initrd {mnt}/boot/initramfs-lts \\', '>'),
+            (f'  -kernel {mnt}/boot/vmlinuz-lts \\', '>'),
+            (f'  -append "usbcore.nousb {append}"', '>'),
+            ('EOF', ps1),
+            ('chmod +x /tmp/run-l2.sh', ps1),
+        ]
+        for cmd, expected_pattern in l2_script:
+            exec_command_and_wait_for_pattern(self, cmd, expected_pattern)
+        self.log.debug("do_test_kvm: L2 launch script written, executing")
+        exec_command(self, '/tmp/run-l2.sh')
+        self.log.debug("do_test_kvm: L2 QEMU launched, waiting for L2 login prompt")
         # Alpine 3.21 kernel seems to crash in XHCI USB driver.
         ps1 = 'localhost:~#'
         wait_for_console_pattern(self, 'localhost login:',
@@ -129,8 +196,10 @@ def do_test_kvm(self, hpt=False):
         self.log.debug("do_test_kvm: logged into L2, issuing poweroff")
         exec_command(self, 'poweroff')
         wait_for_console_pattern(self, 'reboot: Power down')
+        self.log.debug("do_test_kvm: L2 powered down, waiting for L1 prompt")
         # Now wait for the host's prompt to come back
         wait_for_console_pattern(self, 'alpine:~#')
+        self.log.debug("do_test_kvm: L1 prompt restored")
 
     def test_hv_pseries(self):
         self.require_accelerator("tcg")
-- 
2.52.0


