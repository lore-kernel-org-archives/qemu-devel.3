Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B591F606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EMdAtu72
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTvfX-0004R7-19; Thu, 19 Nov 2026 01:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xTvfD-0004Kr-22; Thu, 19 Nov 2026 01:30:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xTvfA-0005Tr-IP; Thu, 19 Nov 2026 01:30:30 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ4jG2D1531860; Thu, 19 Nov 2026 06:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6n16mv
 NJsEEIpRyHreXXXAE/cMs1czam33NMUNflIxE=; b=EMdAtu72xAmLcDH9APM7Kv
 Dro0HAQw4hYcqzKGILkrdAjkp7Lq6eal3+mOPxFwmt2TfXWEXrrD2+wnc07q7XaS
 5yxdiTcZPEuqs8YboAjV+cfsKoSwGfeLVh0vWObEmS+uxucKLEPfQt9OiErDf3YB
 EAGNHY9ZoLYmUsQodY6VXQeLtGAVWt0H9ERHQ7JyQFqg2l6U2aOiGILLNFbZy8Gg
 hvEtiJs1XGKSZatIimaipvSzkpskp4iQ58e7B4JDXJuy96Od1jMhnItgNTguDaLQ
 oFyYs5r9o931Y7Eh9C830XPR2UsQjUA8lJe5FSkxJB8ZeFziOgL/8IaovyI9Xakw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rpyuq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 06:30:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ4xPbf2919850; Thu, 19 Nov 2026 06:30:24 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1bb5by6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 06:30:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJ6TVFw27591412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 06:29:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43D8558055;
 Thu, 19 Nov 2026 06:30:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7E0158043;
 Thu, 19 Nov 2026 06:30:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.221.175])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2026 06:30:15 +0000 (GMT)
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
Subject: [PATCH v2 1/4] tests/functional/ppc64: add pseries CPU hotplug test
Date: Thu, 19 Nov 2026 11:59:47 +0530
Message-ID: <20261119062951.83498-2-anushree.mathur@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119062951.83498-1-anushree.mathur@linux.ibm.com>
References: <20261030131025.32219-1-anushree.mathur@linux.ibm.com>
 <20261119062951.83498-1-anushree.mathur@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: VJOJL-HOXrP7MLmi98FZ_u9PtL8Evmz0
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afe9781 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=sa340zWXXxNFbS3KqbkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyNSBTYWx0ZWRfX5gWQzayxP27j
 /0Zb1+GhlOmJdEGx6bkSbpQEP4Aq0hJ5QXlSSRMwvYT7SQzWSR3rrlK2/3spdOptjorb3xqKlRZ
 yLeMEfUN3Jii+lJkCaDb03ArfdVsmC0=
X-Proofpoint-ORIG-GUID: yANXytZn0J0xEuJ8knALzAf2RpZBzM66
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyNSBTYWx0ZWRfX8/zJFxRqFl9m
 +BisSrA5r/okrN9uln8dEbvsyh5xrNj7UNVrY9vHHyINszhn/8t+oSHgmhgbRuXk2m4NbPksbVL
 REv+uDRbz1d/V9IFFUQAnqJrWJQ7M/QBq1Df8M7wIjJaSMP5p5y4aR8L8TuZCOeWKFsCIuwCW2v
 Efq8l1tPs5rvO29VrZnVQo/dovrs+XxRTqMEks4xCuMSJYBWtGH9vMlmS+NboNqKiQfFCpQguQQ
 4DgzGDFdEykGbGRBxB7VOlx036LnnMdnXoQZNc75K4Suys9odjfpPiSbv6ns6Uj8kAsHVATSpLX
 fhhXFLMa2xRPmu5Y6hwUkROvc4Bovkgd29YXZoYlrseWvaYuKu+oF7ZwauXY3+QMBR/ew6Dzg/K
 dLRJP5HNzD4y2jatYvqkN0Q+E7vkZ6E9DsMKQhhibHRpPMeIa2gQg2XA5YTB9i/PBbmucd0IvtN
 0z4F5o9WpfLk6p7HIPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190025
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

Add a functional test that exercises DLPAR (Dynamic Logical
Partitioning) CPU hotplug and unplug on the pseries machine type.

The pseries machine supports adding and removing CPU cores at runtime
via RTAS calls made by the guest.  This test boots a minimal Linux
kernel with a single core (-smp 2,threads=2,cores=1,maxcpus=4), then
uses QMP device_add to attach a second core, verifies the guest sees
it via /sys/devices/system/cpu/online, and then removes it again.

The CPU driver name is detected dynamically via query-hotpluggable-cpus
so the test remains correct when the default pseries CPU changes in a
future QEMU release (e.g. power10 -> power11).

Two variants are provided:
  - test_pseries_cpu_hotplug_tcg: runs under TCG on any host arch.
  - test_pseries_cpu_hotplug_kvm: runs under KVM on ppc64le hosts with
    kvm-hv loaded; skipped automatically elsewhere.  An explicit
    /proc/modules check for kvm_hv is added because on ppc64le the base
    kvm module can create /dev/kvm without kvm-hv, which would cause the
    test to error rather than skip.

x-vof=on is intentionally NOT used: VOF skips the SLOF firmware path
that sets up the RTAS event interrupt, causing CPU hotplug events to be
silently dropped by the guest kernel.

Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
---
v2: assets now from raphael502/qemu-ppc-boot instead of
legoater/qemu-ppc-boot (same files, same sha256); wrapped long URL
lines for checkpatch.

 tests/functional/ppc64/meson.build         |   2 +
 tests/functional/ppc64/test_hotplug_cpu.py | 185 +++++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100755 tests/functional/ppc64/test_hotplug_cpu.py

diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
index cb3c745624..45468087cb 100644
--- a/tests/functional/ppc64/meson.build
+++ b/tests/functional/ppc64/meson.build
@@ -2,6 +2,7 @@
 
 test_ppc64_timeouts = {
   'fadump' : 480,
+  'hotplug_cpu' : 480,
   'hv' : 1000,
   'mac99' : 120,
   'openbsd' : 240,
@@ -19,6 +20,7 @@ tests_ppc64_system_quick = [
 tests_ppc64_system_thorough = [
   'e500',
   'fadump',
+  'hotplug_cpu',
   'hv',
   'mac99',
   'openbsd',
diff --git a/tests/functional/ppc64/test_hotplug_cpu.py b/tests/functional/ppc64/test_hotplug_cpu.py
new file mode 100755
index 0000000000..bd01bc2022
--- /dev/null
+++ b/tests/functional/ppc64/test_hotplug_cpu.py
@@ -0,0 +1,185 @@
+#!/usr/bin/env python3
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
+class PseriesCpuHotplug(LinuxKernelTest):
+    """
+    Test DLPAR CPU hotplug/unplug on the pseries machine type.
+
+    The pseries machine implements the PAPR CPU hotplug protocol: the
+    hypervisor presents Dynamic Reconfiguration Connectors (DRCs) to
+    the guest, and the guest uses RTAS calls to accept or reject CPUs
+    that are offered or withdrawn.
+
+    Topology used: -smp 2,threads=2,cores=1,maxcpus=4 — 1 active core
+    (cpu0+cpu1 online), max 2 cores.  Hot-add core-id=2 → online goes
+    0-3; hot-remove → back to 0-1.  Verified via /sys/.../cpu/online.
+
+    Two variants are provided:
+      * test_pseries_cpu_hotplug_tcg — uses TCG, runs on any host arch.
+      * test_pseries_cpu_hotplug_kvm — uses KVM, requires a ppc64le host
+        with kvm-hv loaded; skipped automatically on other hosts.
+    """
+
+    timeout = 480
+
+    # Buildroot image built for pseries (ppc64le little-endian paravirtual).
+    ASSET_KERNEL = Asset(
+        ('https://github.com/raphael502/qemu-ppc-boot/raw/refs/heads/main/'
+         'buildroot/qemu_ppc64le_pseries-2023.11-8-gdcd9f0f6eb-20240104/'
+         'vmlinux'),
+        'fc20d5820ad83ed514ac5f88af7e2692d47ab7f36dab290cdb137d05b98502f5')
+
+    ASSET_ROOTFS = Asset(
+        ('https://github.com/raphael502/qemu-ppc-boot/raw/refs/heads/main/'
+         'buildroot/qemu_ppc64le_pseries-2023.11-8-gdcd9f0f6eb-20240104/'
+         'rootfs.ext2'),
+        '6fd31e2300e9921d1192aa5c997760fc8bc40a18513cc466c56902f72d61fd23')
+
+    def _boot_pseries(self, accel):
+        """
+        Boot pseries with 1 core present and room for a second core.
+
+        -smp 2,threads=2,cores=1,maxcpus=4 gives us:
+          * 1 active core  → cpu0 + cpu1 (2 SMT threads)
+          * 1 spare core slot that can be filled by device_add
+
+        accel must be 'tcg' or 'kvm'.
+        """
+        kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        self.set_machine('pseries')
+        # Do NOT use x-vof=on here — VOF skips the SLOF firmware path that
+        # sets up the RTAS event interrupt (epow/check-exception).  Without
+        # SLOF, the guest kernel's pseries_hp_wq workqueue is never triggered
+        # and CPU hotplug RTAS events are silently dropped.
+        if accel == 'tcg':
+            self.vm.add_args('-accel', 'tcg,thread=multi')
+        else:
+            self.vm.add_args('-accel', 'kvm')
+        self.vm.add_args('-smp', '2,threads=2,cores=1,maxcpus=4')
+        self.vm.add_args('-m', '512M')
+        self.vm.set_console()
+        self.vm.add_args('-drive',
+                         f'file={rootfs_path},if=scsi,index=0,format=raw')
+        self.vm.add_args(
+            '-kernel', kernel_path,
+            '-append', 'root=/dev/sda console=hvc0 rootwait printk.time=0',
+        )
+        self.vm.launch()
+        self.wait_for_console_pattern('buildroot login:')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+
+    def _get_hotplug_cpu_driver(self):
+        """
+        Return the spapr-cpu-core driver name for an empty hotplug slot.
+
+        query-hotpluggable-cpus lists all possible CPU slots; entries
+        without a 'qom-path' key are currently empty.  The 'type' field
+        of any empty slot gives the driver name to pass to device_add.
+        This avoids hard-coding a CPU version string (e.g.
+        'power11_v2.0-spapr-cpu-core') that would break when the default
+        pseries CPU changes in a future QEMU release.
+        """
+        cpus = self.vm.cmd('query-hotpluggable-cpus')
+        for entry in cpus:
+            if 'qom-path' not in entry:
+                return entry['type']
+        self.fail('No empty hotpluggable CPU slot found')
+
+    def _do_cpu_hotplug(self):
+        """
+        Shared hotplug/unplug logic, called after the guest has booted.
+
+        Confirms cpu0+cpu1 are online, hot-adds a second core (cpu2+cpu3),
+        verifies they come online, hot-removes the core, and verifies they
+        go offline.  Finishes with a clean guest poweroff.
+        """
+        # Confirm initial state: cpu0 and cpu1 online, cpu2 offline/absent.
+        # Use /sys/devices/system/cpu/online which lists only truly online
+        # CPUs — sysfs cpu dirs exist for possible CPUs too so ls is wrong.
+        exec_command_and_wait_for_pattern(
+            self,
+            'cat /sys/devices/system/cpu/online',
+            '0-1',
+        )
+
+        # Detect the correct driver for the empty hotplug slot dynamically
+        # so the test works regardless of which CPU version pseries defaults
+        # to (power10, power11, etc.).
+        driver = self._get_hotplug_cpu_driver()
+
+        # Hot-add core at core-id=2 (supplies threads cpu2 and cpu3 in SMT-2).
+        # With threads=2 the available hotplug slot is core-id=2.
+        self.vm.cmd(
+            'device_add',
+            driver=driver,
+            id='hotcpu1',
+            **{'core-id': 2},
+        )
+
+        # Poll until cpu2+cpu3 are online.  The sentinel is built using a
+        # shell variable (echo hotplug_cpu_$R) so the full string
+        # 'hotplug_cpu_done' never appears in the command text.  This avoids
+        # a false match on the shell's echo of the typed command, which
+        # exec_command_and_wait_for_pattern scans before any output arrives.
+        exec_command_and_wait_for_pattern(
+            self,
+            'until [ "$(cat /sys/devices/system/cpu/online)" = "0-3" ];'
+            ' do sleep 0.5; done; R=done; echo hotplug_cpu_$R',
+            'hotplug_cpu_done',
+        )
+
+        # Hot-remove the core.
+        self.vm.cmd('device_del', id='hotcpu1')
+
+        # Wait until the kernel acknowledges the removal.
+        exec_command_and_wait_for_pattern(
+            self,
+            'until [ "$(cat /sys/devices/system/cpu/online)" = "0-1" ];'
+            ' do sleep 0.2; done; R=done; echo unplug_cpu_$R',
+            'unplug_cpu_done',
+        )
+
+        exec_command_and_wait_for_pattern(self, 'poweroff', '#')
+        self.vm.wait()
+
+    def test_pseries_cpu_hotplug_tcg(self):
+        """Hot-add then hot-remove a CPU core on pseries using TCG."""
+        self.require_accelerator('tcg')
+        self._boot_pseries('tcg')
+        self._do_cpu_hotplug()
+
+    def test_pseries_cpu_hotplug_kvm(self):
+        """Hot-add then hot-remove a CPU core on pseries using KVM.
+
+        Requires a ppc64le host with kvm-hv loaded; skipped automatically
+        on other hosts.
+        """
+        self.require_accelerator('kvm')
+        # On ppc64le the base kvm module can be loaded (and /dev/kvm created)
+        # without kvm-hv, so checking /dev/kvm alone is not sufficient.
+        # Verify that kvm_hv is actually present in /proc/modules.
+        # This check is ppc64-specific; other arches (x86, arm, ...) use
+        # different KVM modules and rely solely on /dev/kvm.
+        if platform.machine() in ('ppc64le', 'ppc64'):
+            try:
+                with open('/proc/modules', encoding='utf-8') as f:
+                    if not any(line.split()[0] == 'kvm_hv' for line in f):
+                        self.skipTest('kvm-hv module is not loaded')
+            except OSError:
+                pass
+        self._boot_pseries('kvm')
+        self._do_cpu_hotplug()
+
+
+if __name__ == '__main__':
+    PseriesCpuHotplug.main()
-- 
2.55.0


