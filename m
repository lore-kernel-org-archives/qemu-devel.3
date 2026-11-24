Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A1606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c9FiyRHA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVoGq-0000Zf-Im; Tue, 24 Nov 2026 06:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xVoGj-0000YE-Lr; Tue, 24 Nov 2026 06:01:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xVoGh-0001Ka-FK; Tue, 24 Nov 2026 06:01:01 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO35APT1271944; Tue, 24 Nov 2026 11:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=N8ogMGUUootNSdMUe
 70penjIxTPgD82KqMJylRFzaDI=; b=c9FiyRHAkMs8SDCe9f0s4thHLotUteZV9
 siS18NtcJHr7AQ/pmJbuOFdalTCDywupg/zHOMEj+GsKDiG/9lut7cT2s5mBcfqX
 3MZ4H7/TKNAl6S9kmROHr0nAkYP2GAUfLtgxA3SkP42dXJoDP9WwsnC/Qr3nDjMB
 3HPkgrEG8eb+/RsGINStgfoOF+i32GRvkNWHi0hZaIaEEGd9ME2g+RZvV52eUBkI
 isGeTO+1CUImhK0l9ILVqFhzTkNZWeCnGeNeObO45g01rAiqlAN5FTMjh204CesC
 CmuM/Cj+GLU5333hvdZCmBo4kTR8TfPXS0WvdjRS0bT5iVS14r8vA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g16xjh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 11:00:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8w1UZ3890931; Tue, 24 Nov 2026 11:00:56 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4ha7kn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 11:00:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AOB0s8r21299760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Nov 2026 11:00:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD3BA5805D;
 Tue, 24 Nov 2026 11:00:54 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EFE55806C;
 Tue, 24 Nov 2026 11:00:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.26.151])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Nov 2026 11:00:49 +0000 (GMT)
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
Subject: [PATCH v3 2/4] tests/functional/ppc64: add pseries security caps test
Date: Tue, 24 Nov 2026 16:30:28 +0530
Message-ID: <20261124110030.30097-3-anushree.mathur@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124110030.30097-1-anushree.mathur@linux.ibm.com>
References: <20261124110030.30097-1-anushree.mathur@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: DY-xMBfiihL_NhuHqx5G_GENwT3G7opS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfX7UEXyJA3Yb2/
 JTRNNreXAgz7mrlqWqjPLxmba1xAkgDRMVmKgyVMUzTT2n3yjtdS4Z+yMF9rEF/zjFjoG+cEm8h
 vhq/4IDZD43Yhos+1hBWddXYGfjBJE8=
X-Proofpoint-GUID: Dw8J6J9YCap70sfEIRmGCrroWF7FgbVP
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b056e68 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=N76r180sS3mbWU9IQwwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfX/PoeRyNQszbh
 ZF+7tgQ674BEOClNl6s8qTKmF4vpY/vSO0IdjXDo7D2LPp0fSgSslu0M0szWq5q0004Fbhe/wiS
 t9G8qywEpFYVSQWSYVJvidxS0N4HuWYiysJNeTpk4DDiGsXbeOcI1CbqlhC+lZsUjXpvlk1aG3A
 6p+jGKRN3CWjQ5zf2yR3dt1KPyeZ4Mrvrl/WNUM/tU2el3XrNuIQVKkzmJ3p6HIgnnz3mYdTSfO
 lZ+RL2yTSAZH/rhqVNmD4OpCe6UyCFtI8mjWrPSy9QGvNuN4AJ7VrY38All6fFiUsLWdbtYZom0
 jMn83XoYNjAbhBR36yUJk/tOTvf8EpSiDA1jWwt2gmTIu9I+x0JlgrGsTkCgW37ltsGGCn7u7w1
 qIzcNffFR2O56pzMqlzKwYDvFdRfp60h6f/qxTIymAnfBudNAXfgYlBADN/UHBK6zcwrrEObqjr
 keHD4f6qdmNgt2dz/RQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240041
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Add a quick functional test (no Linux boot required) that checks that
the pseries machine type accepts its security capability options and
reports them back with the configured values, and that backward-compatible
versioned machine types can be instantiated, using the QMP interface.

Each test starts QEMU with -S (halted) so no firmware or kernel is
needed.  The tests cover:

  * test_pseries_in_query_machines: pseries appears in query-machines
    and is marked is-default=true.
  * test_pseries_security_caps_override: cap-cfpc, cap-sbbc, cap-ibs
    and cap-ccf-assist overrides are accepted, the machine starts and
    qom-get on /machine returns the values that were set.
  * test_pseries_nested_hv_cap: cap-nested-hv=on is accepted and
    qom-get reports it as on.
  * test_pseries_compat_7_2/9_2/10_0: versioned compat machines can be
    instantiated and are not marked is-default.
  * test_pseries_cap_hpt_max_page_size: cap-hpt-max-page-size is
    reachable via the QOM tree at /machine.

All tests complete in under 5 seconds each and are registered in the
tests_ppc64_system_quick list.

Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
---
v3: check the cap-cfpc, cap-sbbc, cap-ibs, cap-ccf-assist and
cap-nested-hv values with qom-get instead of only checking that QEMU
starts; dropped the redundant "pseries" from the -machine arguments;
the compat machine check now looks at is-default (is-current is not a
query-machines field, so the old assertion could never fail).

 tests/functional/ppc64/meson.build          |   1 +
 tests/functional/ppc64/test_pseries_caps.py | 169 ++++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100755 tests/functional/ppc64/test_pseries_caps.py

diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
index 45468087cb..d91209f041 100644
--- a/tests/functional/ppc64/meson.build
+++ b/tests/functional/ppc64/meson.build
@@ -14,6 +14,7 @@ test_ppc64_timeouts = {
 
 tests_ppc64_system_quick = [
   'migration',
+  'pseries_caps',
   'vmstate',
 ]
 
diff --git a/tests/functional/ppc64/test_pseries_caps.py b/tests/functional/ppc64/test_pseries_caps.py
new file mode 100755
index 0000000000..2b2d33229f
--- /dev/null
+++ b/tests/functional/ppc64/test_pseries_caps.py
@@ -0,0 +1,169 @@
+#!/usr/bin/env python3
+# Copyright (c) 2025 IBM Corporation
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest
+
+
+class PseriesCapsTest(QemuSystemTest):
+    """
+    Quick (no-boot) tests for pseries machine capabilities.
+
+    Each test starts QEMU with -S (halted) so no firmware or kernel is
+    needed.  The tests exercise the QMP interface to verify that:
+
+      * The machine type is visible in 'query-machines' output.
+      * Known security capability properties (cap-cfpc, cap-sbbc,
+        cap-ibs, cap-ccf-assist, cap-nested-hv) are accepted and read
+        back with the values that were set.
+      * Versioned compat machines (pseries-7.2, pseries-9.2 and
+        pseries-10.0) can be instantiated and are not marked
+        is-default.
+      * cap-hpt-max-page-size is reachable via the QOM tree.
+    """
+
+    timeout = 30
+
+    # ------------------------------------------------------------------ #
+    # Helpers
+    # ------------------------------------------------------------------ #
+
+    def _launch_stopped(self, machine='pseries', extra_args=None):
+        """Launch QEMU paused (-S) for the named machine and return."""
+        self.set_machine(machine)
+        self.vm.add_args('-S', '-nodefaults')
+        if extra_args:
+            self.vm.add_args(*extra_args)
+        self.vm.launch()
+
+    def _query_machine_info(self, name):
+        """Return the entry from query-machines that matches *name* or alias."""
+        machines = self.vm.cmd('query-machines')
+        for m in machines:
+            if m['name'] == name or m.get('alias') == name:
+                return m
+        return None
+
+    # ------------------------------------------------------------------ #
+    # Test: basic pseries machine is visible in query-machines
+    # ------------------------------------------------------------------ #
+
+    def test_pseries_in_query_machines(self):
+        """pseries (latest) must appear in query-machines output."""
+        self._launch_stopped('pseries')
+        info = self._query_machine_info('pseries')
+        self.assertIsNotNone(info,
+                             'pseries not found in query-machines output')
+        # The default/latest versioned machine carries is-default=True.
+        self.assertTrue(
+            info.get('is-default', False),
+            'pseries alias should be marked is-default=true',
+        )
+
+    # ------------------------------------------------------------------ #
+    # Test: security cap overrides are accepted without error
+    # ------------------------------------------------------------------ #
+
+    def test_pseries_security_caps_override(self):
+        """
+        Verify pseries accepts all well-known security cap overrides.
+
+        These are the options used by the KVM nested-HV path in
+        test_hv.py.  Check that QEMU starts cleanly and that each
+        capability reads back through qom-get with the value that was
+        set on the command line.
+        """
+        caps = (
+            'cap-cfpc=broken,'
+            'cap-sbbc=broken,'
+            'cap-ibs=broken,'
+            'cap-ccf-assist=off'
+        )
+        self._launch_stopped('pseries', extra_args=['-machine', caps])
+        for name in ('cap-cfpc', 'cap-sbbc', 'cap-ibs'):
+            self.assertEqual(
+                self.vm.cmd('qom-get', path='/machine', property=name),
+                'broken',
+                f'{name} should read back as broken',
+            )
+        self.assertFalse(
+            self.vm.cmd('qom-get', path='/machine',
+                        property='cap-ccf-assist'),
+            'cap-ccf-assist should read back as off',
+        )
+
+    # ------------------------------------------------------------------ #
+    # Test: nested-HV cap is accepted
+    # ------------------------------------------------------------------ #
+
+    def test_pseries_nested_hv_cap(self):
+        """pseries must accept cap-nested-hv=on and report it as on."""
+        self._launch_stopped(
+            'pseries',
+            extra_args=['-machine', 'x-vof=on,cap-nested-hv=on'],
+        )
+        self.assertTrue(
+            self.vm.cmd('qom-get', path='/machine',
+                        property='cap-nested-hv'),
+            'cap-nested-hv should read back as on',
+        )
+
+    # ------------------------------------------------------------------ #
+    # Test: versioned compat machines can be instantiated
+    # ------------------------------------------------------------------ #
+
+    def _test_compat_machine(self, version_str):
+        """
+        Helper: launch a versioned compat machine and verify that the
+        name appears in query-machines and that it is not marked
+        is-default (the default is always the latest version).
+        """
+        self._launch_stopped(version_str)
+        info = self._query_machine_info(version_str)
+        self.assertIsNotNone(
+            info,
+            f'compat machine {version_str!r} not found in query-machines',
+        )
+        # query-machines only reports is-default for the default (latest)
+        # machine, so it must be absent or False for a compat machine.
+        self.assertFalse(
+            info.get('is-default', False),
+            f'{version_str} should not be marked is-default=true',
+        )
+
+    def test_pseries_compat_7_2(self):
+        """pseries-7.2 (vmstate reference version) can be instantiated."""
+        self._test_compat_machine('pseries-7.2')
+
+    def test_pseries_compat_9_2(self):
+        """pseries-9.2 can be instantiated."""
+        self._test_compat_machine('pseries-9.2')
+
+    def test_pseries_compat_10_0(self):
+        """pseries-10.0 can be instantiated."""
+        self._test_compat_machine('pseries-10.0')
+
+    # ------------------------------------------------------------------ #
+    # Test: cap-hpt-max-page-size is reachable via the QOM tree
+    # ------------------------------------------------------------------ #
+
+    def test_pseries_cap_hpt_max_page_size(self):
+        """
+        Verify that pseries exposes cap-hpt-max-page-size in its
+        machine properties (it is used by migration compat checks).
+        """
+        self._launch_stopped('pseries')
+        # query-machine-props is not a real QMP command; we use the
+        # object model instead.
+        props = self.vm.cmd('qom-list', path='/machine')
+        prop_names = [p['name'] for p in props]
+        # The property should be reachable via the QOM tree.
+        self.assertIn(
+            'cap-hpt-max-page-size', prop_names,
+            'pseries /machine must expose cap-hpt-max-page-size via QOM',
+        )
+
+
+if __name__ == '__main__':
+    PseriesCapsTest.main()
-- 
2.55.0


