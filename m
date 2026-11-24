Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAAB606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pG8C9gBH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVoGt-0000b5-Pi; Tue, 24 Nov 2026 06:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xVoGp-0000ZM-1L; Tue, 24 Nov 2026 06:01:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xVoGm-0001Mr-If; Tue, 24 Nov 2026 06:01:06 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO34fvZ1260205; Tue, 24 Nov 2026 11:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CRXeGupO/YBSvY793
 Wda7fGVkoDkhtdll7szqI3vfCU=; b=pG8C9gBH+djFCTjm190PtWMvbt0VOX979
 FwNV5Aj6Oo0Q5lWri0nC7G1EKGYsTcceeRtwzQdEKBRRNh6jbh4R5jJAJRsj9YwA
 73kWuLZf53Z4wXPLgFcmk2hM5DuDTk0jVoWXJUdCsO4Ym7X4NVyM+HH3RRa8d2ar
 eTs0/Mt8qXkc1eeyaG+S4KKGvbPIifKPdLOkm6RiSXgoCwb9Mve9l9IaT4mZy4tX
 idqFUxz2oVtHjIeLYsUoqBcjT9xRgG3/UIXXUkt2ZUQ7NkIn0uup4bihaDmFece7
 DsXFn/jBNVHLnuWUUocDcRrm0kMKPFKow45e5nZ42RezbrZ2TKLzg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkfar3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 11:01:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8vBAK2838120; Tue, 24 Nov 2026 11:01:01 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3rayj0p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 11:01:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AOB10S764618842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Nov 2026 11:01:00 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4850658069;
 Tue, 24 Nov 2026 11:01:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C3D35806E;
 Tue, 24 Nov 2026 11:00:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.26.151])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Nov 2026 11:00:55 +0000 (GMT)
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, misanjum@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>, Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH v3 3/4] tests/functional/ppc64: add pseries virtio-blk hotplug
 test
Date: Tue, 24 Nov 2026 16:30:29 +0530
Message-ID: <20261124110030.30097-4-anushree.mathur@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124110030.30097-1-anushree.mathur@linux.ibm.com>
References: <20261124110030.30097-1-anushree.mathur@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfX4EEWDYOHYB4V
 9B0m9qtQX3nxZYeE2EE2GjrP36zhgl3+t+2XFMDSjrBa+3MG8avKk4I08TL8GNjbHWpiUSecjOi
 2/JKuB+761gZW1rd9/m6onoIn4RbWHuKLEtdMirrqg3rzvTJBWfyC1XwE9wYWXfDSCsYWnr5XFJ
 Pui98APINj6ug6K++z/KUfmZj2itVMS4HT0MYcbDU/rvUF/n2Qb1GwZwoCPquq+ll3ec3YsDqte
 Ag6gIfVTI6i2+uYpkzti4wbh4fanvBff9KwpPNhNWaRxYjn5UAsqYXqOSplFNv9UPtgZZgEiDBe
 X33QsVufV7vqmsjH9Z+o/1poNlZyHelwgnDEfDg9odbF7VF+/pDb+1VcWaqyflZ/V+GNTXiQ9G7
 EafN93Ser16XNleK8dBVKZTGvwSs/+1x2zCfxCmT5gJHM8EHzQNTvHEDj6MBD3+mRDxbvMlkalL
 8AOz4ghgHKobBa7iIRA==
X-Proofpoint-ORIG-GUID: KeWgDqsbC47dF4hzTrylCea16kb7p19O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfX9CEurGQOTAzj
 na/1RTtchhu/gp/L4RIruabL7gGai9wqDJtZnIo0u5LFsDBjK1gXQVDZJsylH8l9q1PY6r+0DO4
 BQaPihJXmI9wgZ64DDaKolfGpzV2kQ0=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b056e6e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=dgw9cCIVgmEBL8NrEksA:9
X-Proofpoint-GUID: EoSjHnJUSDiPbykpheyLysoDRGWkuCUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240041
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a functional test that hot-plugs and hot-unplugs a virtio-blk-pci
disk on the pseries machine.  It runs with TCG, and also with KVM if
KVM is enabled.

On pseries a PCI device added through QMP is only enumerated by the
guest once rtas_errd (ppc64-diag) handles the RTAS hotplug event and
runs drmgr (powerpc-utils).  Neither is in the buildroot image used by
the other pseries tests, so the test uses rootfs-hotplug.ext2: the same
image with those two tools added.

The test boots with a second PHB (phb1) present so that the guest
registers its slots, adds a null-co backend, hot-plugs virtio-blk-pci
into phb1.0 and waits for /dev/vda, then unplugs it and waits for both
the QMP DEVICE_DELETED event and /dev/vda to go away.  The root drive is
used with snapshot=on so the cached asset is not modified by the guest.

Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
---
v3: the rtas_errd start and the initial /dev/vda checks used patterns
that also matched the echoed command, so they always passed; they now
use the shell variable sentinel, and rtas_errd is verified with pidof.
Bounded the wait loops (60 seconds) with a failure message on timeout,
and the test now asserts that DEVICE_DELETED was received.

 tests/functional/ppc64/meson.build         |   2 +
 tests/functional/ppc64/test_hotplug_blk.py | 206 +++++++++++++++++++++
 2 files changed, 208 insertions(+)
 create mode 100755 tests/functional/ppc64/test_hotplug_blk.py

diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
index d91209f041..f483ce4d76 100644
--- a/tests/functional/ppc64/meson.build
+++ b/tests/functional/ppc64/meson.build
@@ -2,6 +2,7 @@
 
 test_ppc64_timeouts = {
   'fadump' : 480,
+  'hotplug_blk' : 600,
   'hotplug_cpu' : 480,
   'hv' : 1000,
   'mac99' : 120,
@@ -21,6 +22,7 @@ tests_ppc64_system_quick = [
 tests_ppc64_system_thorough = [
   'e500',
   'fadump',
+  'hotplug_blk',
   'hotplug_cpu',
   'hv',
   'mac99',
diff --git a/tests/functional/ppc64/test_hotplug_blk.py b/tests/functional/ppc64/test_hotplug_blk.py
new file mode 100755
index 0000000000..a1d0dbcee5
--- /dev/null
+++ b/tests/functional/ppc64/test_hotplug_blk.py
@@ -0,0 +1,206 @@
+#!/usr/bin/env python3
+#
+# Functional test that hot-plugs and hot-unplugs a virtio-blk-pci disk
+# on the pseries machine type.
+#
+# Copyright (c) 2025 IBM Corporation
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import platform
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+
+
+class PseriesHotplugBlk(LinuxKernelTest):
+    """
+    Test virtio-blk-pci hotplug/unplug on the pseries machine type.
+
+    A pre-built rootfs image (based on the buildroot image used by
+    test_hotplug_cpu.py) is used as the guest OS.  The image includes
+    rtas_errd from ppc64-diag, which is required on pseries to call the
+    ibm,configure-connector RTAS function that makes a QMP-hotplugged
+    PCI device visible to the kernel.
+
+    ppc64-diag is not packaged in Alpine Linux, so the Alpine+apk
+    approach used by test_hv.py cannot be used here.  Instead a
+    self-contained rootfs with rtas_errd and drmgr (from powerpc-utils)
+    already installed is referenced as an Asset, following the same
+    pattern as test_hotplug_cpu.py.
+
+    The test is run with both TCG and KVM; the KVM variant needs a
+    ppc64 host with kvm-hv loaded and is skipped automatically otherwise.
+
+    A second spapr-pci-host-bridge (phb1, index=1) is present at VM
+    launch so the guest kernel registers its PCI slots with rpaphp
+    during boot-time PCI probe.  Runtime DLPAR hotplug of
+    virtio-blk-pci into phb1.0 then works via the rtas_errd path.
+    """
+
+    timeout = 600
+
+    ASSET_KERNEL = Asset(
+        ('https://github.com/raphael502/qemu-ppc-boot/raw/refs/heads/main/'
+         'buildroot/qemu_ppc64le_pseries-2023.11-8-gdcd9f0f6eb-20240104/'
+         'vmlinux'),
+        'fc20d5820ad83ed514ac5f88af7e2692d47ab7f36dab290cdb137d05b98502f5')
+
+    # Pre-built rootfs based on the buildroot pseries image above, with
+    # rtas_errd (from ppc64-diag) and drmgr (from powerpc-utils) added.
+    # rtas_errd is required to process RTAS hotplug events on pseries and
+    # it execs drmgr to configure the device; without them rpaphp
+    # registers the slots but the device is never enumerated by the kernel.
+    ASSET_ROOTFS = Asset(
+        ('https://github.com/raphael502/qemu-ppc-boot/raw/refs/heads/main/'
+         'buildroot/qemu_ppc64le_pseries-2023.11-8-gdcd9f0f6eb-20240104/'
+         'rootfs-hotplug.ext2'),
+        '01ab3421d313e7765176eb27193fdb5837281dc3c8484eed140de8a3e65908eb')
+
+    def _boot_pseries(self, accel):
+        """Boot pseries with phb1 present and rtas_errd running.
+
+        accel must be 'tcg' or 'kvm'.
+        """
+        kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        self.set_machine('pseries')
+        if accel == 'tcg':
+            self.vm.add_args('-accel', 'tcg,thread=multi')
+        else:
+            self.vm.add_args('-accel', 'kvm')
+        self.vm.add_args('-smp', '2', '-m', '512M')
+        # Second PHB present at boot so the guest kernel registers its
+        # slots with rpaphp.  Required for runtime DLPAR hotplug of
+        # virtio-blk-pci into phb1.0.
+        self.vm.add_args('-device', 'spapr-pci-host-bridge,id=phb1,index=1')
+        # snapshot=on keeps the cached rootfs asset unmodified
+        self.vm.add_args(
+            '-drive',
+            f'file={rootfs_path},if=scsi,index=0,format=raw,snapshot=on')
+        self.vm.add_args(
+            '-kernel', kernel_path,
+            '-append', 'root=/dev/sda console=hvc0 rootwait printk.time=0',
+        )
+        self.vm.set_console()
+        self.vm.launch()
+
+        self.wait_for_console_pattern('buildroot login:')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+
+        # Start rtas_errd so that RTAS hotplug events are processed.
+        # rtas_errd daemonizes by default (no -d flag).  Wait (up to 5
+        # seconds) for it to show up in pidof and report the result
+        # through a shell variable, so the expected strings never appear
+        # in the command text and match the echoed command.
+        exec_command_and_wait_for_pattern(
+            self,
+            'touch /var/log/platform; mkdir -p /var/log/dump;'
+            ' /usr/sbin/rtas_errd;'
+            ' for i in $(seq 1 10); do'
+            ' pidof rtas_errd > /dev/null && break; sleep 0.5; done;'
+            ' if pidof rtas_errd > /dev/null; then S=started;'
+            ' else S=failed; fi; echo rtas_errd_$S',
+            'rtas_errd_started',
+            failure_message='rtas_errd_failed',
+        )
+
+    def _do_blk_hotplug(self):
+
+        # Confirm /dev/vda does not exist before hotplug.  The result is
+        # printed through a shell variable so the expected string never
+        # appears in the command text, which would match the echoed command.
+        exec_command_and_wait_for_pattern(
+            self,
+            'if test -b /dev/vda; then R=present; else R=absent; fi;'
+            ' echo vda_initial_$R',
+            'vda_initial_absent',
+            failure_message='vda_initial_present',
+        )
+
+        # Add a null-co block backend (no image file needed).
+        self.vm.cmd(
+            'blockdev-add',
+            **{
+                'driver': 'null-co',
+                'size': 1073741824,
+                'node-name': 'testdisk',
+            },
+        )
+
+        # Hotplug virtio-blk-pci into phb1.0.  The RTAS hotplug event
+        # (type 229) is delivered to the guest; rtas_errd calls
+        # ibm,configure-connector, the kernel enumerates the device and
+        # udev creates /dev/vda.
+        self.vm.cmd(
+            'device_add',
+            driver='virtio-blk-pci',
+            drive='testdisk',
+            id='hotblk0',
+            bus='phb1.0',
+            addr='0x0',
+        )
+
+        # Poll (for up to 60 seconds) until /dev/vda appears.  Use a shell
+        # variable sentinel so the strings 'vda_present' and 'vda_timeout'
+        # never appear in the typed command, avoiding a false match on the
+        # echoed command text.
+        exec_command_and_wait_for_pattern(
+            self,
+            'for i in $(seq 1 60); do'
+            ' test -b /dev/vda && break; sleep 1; done;'
+            ' if test -b /dev/vda; then R=present; else R=timeout; fi;'
+            ' echo vda_$R',
+            'vda_present',
+            failure_message='vda_timeout',
+        )
+
+        # Unplug the device and wait for the QMP deletion event.
+        self.vm.cmd('device_del', id='hotblk0')
+        event = self.vm.event_wait(
+            'DEVICE_DELETED',
+            timeout=60.0,
+            match={'data': {'device': 'hotblk0'}},
+        )
+        self.assertIsNotNone(event, 'DEVICE_DELETED not received for hotblk0')
+
+        # Poll (for up to 60 seconds) until /dev/vda disappears.
+        exec_command_and_wait_for_pattern(
+            self,
+            'for i in $(seq 1 60); do'
+            ' test -b /dev/vda || break; sleep 1; done;'
+            ' if test -b /dev/vda; then R=timeout; else R=absent; fi;'
+            ' echo vda_$R',
+            'vda_absent',
+            failure_message='vda_timeout',
+        )
+
+    def test_pseries_hotplug_blk_tcg(self):
+        """Hotplug then unplug a virtio-blk-pci device on pseries (TCG)."""
+        self.require_accelerator('tcg')
+        self._boot_pseries('tcg')
+        self._do_blk_hotplug()
+
+    def test_pseries_hotplug_blk_kvm(self):
+        """Hotplug then unplug a virtio-blk-pci device on pseries (KVM).
+
+        Requires a ppc64 host with kvm-hv loaded; skipped automatically
+        on other hosts.
+        """
+        self.require_accelerator('kvm')
+        # On ppc64 the base kvm module can be loaded (and /dev/kvm created)
+        # without kvm-hv, so checking /dev/kvm alone is not sufficient.
+        if platform.machine() in ('ppc64le', 'ppc64'):
+            try:
+                with open('/proc/modules', encoding='utf-8') as f:
+                    if not any(line.split()[0] == 'kvm_hv' for line in f):
+                        self.skipTest('kvm-hv module is not loaded')
+            except OSError:
+                pass
+        self._boot_pseries('kvm')
+        self._do_blk_hotplug()
+
+
+if __name__ == '__main__':
+    PseriesHotplugBlk.main()
-- 
2.55.0


