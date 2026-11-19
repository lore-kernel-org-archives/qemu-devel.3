Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC1D606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LFGTSxe/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTvfZ-0004Sr-D9; Thu, 19 Nov 2026 01:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xTvfG-0004L6-BI; Thu, 19 Nov 2026 01:30:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xTvfE-0005tT-5p; Thu, 19 Nov 2026 01:30:34 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ4jHuW3324077; Thu, 19 Nov 2026 06:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Ome7GrWPFjmkhpK2E
 0dYx3KMEx0gnR50d7CJNFY1CRs=; b=LFGTSxe/8vhL4q3RYdUeHxsylWUM7ccCY
 sTkY6Zncf+EkeRdBe+I52znZGzdA4jJID3IY32Kf9rI+hqPU37ADzClT8/eNmHjx
 9JuA6YcPgMgHXPlUQM5mG7jOw3AKtY7/xyPLzMQCmtm7uPyre33iP2N2wRxpLD2x
 XQlVQ1nguuZx6LwQeU+VE2nex6V1SDj4cjWwZRrkshYJABcad4xKklK/w/tFeVMD
 n2+WEWnR8+59/kQqq2bxpTMFuDUoHuHND2Jop/T59pAgH3w6Bf5KmO0w0yFae9Sq
 e+JTMBRMaa3aGVqnIa7ZnDQSY4EDXPrg2xYvcBlOCFqEi8uU7UTfg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nf090-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 06:30:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ4rN8X063061; Thu, 19 Nov 2026 06:30:28 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6tkep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 06:30:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJ6URNu24052324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 06:30:27 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7B395805D;
 Thu, 19 Nov 2026 06:30:27 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEA1B58043;
 Thu, 19 Nov 2026 06:30:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.221.175])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2026 06:30:22 +0000 (GMT)
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
Subject: [PATCH v2 2/4] tests/functional/ppc64: add pseries security caps test
Date: Thu, 19 Nov 2026 11:59:48 +0530
Message-ID: <20261119062951.83498-3-anushree.mathur@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119062951.83498-1-anushree.mathur@linux.ibm.com>
References: <20261030131025.32219-1-anushree.mathur@linux.ibm.com>
 <20261119062951.83498-1-anushree.mathur@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyNSBTYWx0ZWRfX5ACXwqUFcz+a
 vRJT9UAH86Erf3GrAwWqCWEJUrntuLI/5kKhk/HJKmTmFmiCPpru+u2k7fAMLM3rue1iN6+TjJr
 qUh2omrM/Ss10xLOCmq0/V0MfECy4J+TQvKqxXpM1oaV8pOhbJicrHSAYaQrkg8iyqYEa5vLCYZ
 6U4RvpYXcNSSKGkGZstcLVAPrec70BhwibKY7nVrB769bD2KRUbXqxPnJg0DQLqaCIyNZ1iOdUA
 E/Ui57jOwOdDnPMCDkNsKiF6MzaZOayeQOhX+HeRmDFidtUQ5paLNu54D0onPr1k732zkxK4vc5
 MF01yLqAFWWpqXx75l9AnQvD+r/M1kebB3rlhJ8wqAK85BZDDOOjn51cBytPLQLusYOKmFUM2jQ
 ghPUDVzr5cWIo2iSYJs6OcN3R6DaX+7pnWJphFXNUEw2xUKlGJZadmyxh3UdXnzob1FByFQd2Wo
 /Otx898a2Belftgqj7A==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afe9786 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ap8TLsdQcWgLwmS6zZkA:9
X-Proofpoint-GUID: s3zgFI06cKxK6oK-xjsaZiGbygQhSLQ-
X-Proofpoint-ORIG-GUID: HwU-VJFt0ZIC9vC7aJ7LwHGauyAEgx38
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyNSBTYWx0ZWRfX4fQbXXajBkkJ
 gduCH4tielrolrzLvfmbLclAEGXjIjuM78NEzfXsInMRuwM79a+B6088viFKyzWoaWwLgYeMfQ6
 FtfAfFMKi/MFkjg4gfHDZVaRsJjReD4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190025
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a quick functional test (no Linux boot required) that checks that
the pseries machine type accepts its security capability options and
that backward-compatible versioned machine types can be instantiated,
using the QMP interface.

Each test starts QEMU with -S (halted) so no firmware or kernel is
needed.  The tests cover:

  * test_pseries_in_query_machines: pseries appears in query-machines
    and is marked is-default=true.
  * test_pseries_security_caps_override: cap-cfpc, cap-sbbc, cap-ibs
    and cap-ccf-assist overrides are accepted and the machine starts.
  * test_pseries_nested_hv_cap: cap-nested-hv=on is accepted.
  * test_pseries_compat_7_2/9_2/10_0: versioned compat machines can be
    instantiated and are not marked is-current.
  * test_pseries_cap_hpt_max_page_size: cap-hpt-max-page-size is
    reachable via the QOM tree at /machine.

All tests complete in under 5 seconds each and are registered in the
tests_ppc64_system_quick list.

Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
---
v2: reworded the commit message to say what is actually checked,
fixed docstrings that did not match the code and dropped the skipped
query-cpu-model-expansion placeholder test.

 tests/functional/ppc64/meson.build          |   1 +
 tests/functional/ppc64/test_pseries_caps.py | 162 ++++++++++++++++++++
 2 files changed, 163 insertions(+)
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
index 0000000000..9ef3f48bb1
--- /dev/null
+++ b/tests/functional/ppc64/test_pseries_caps.py
@@ -0,0 +1,162 @@
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
+        cap-ibs, cap-ccf-assist, cap-nested-hv) are accepted.
+      * Versioned compat machines (pseries-7.2, pseries-9.2 and
+        pseries-10.0) can be instantiated and are not marked
+        is-current.
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
+        test_hv.py.  We only check that QEMU starts cleanly (no launch
+        exception); the actual cap values are enforced by separate
+        migration / capability tests.
+        """
+        caps = (
+            'cap-cfpc=broken,'
+            'cap-sbbc=broken,'
+            'cap-ibs=broken,'
+            'cap-ccf-assist=off'
+        )
+        self._launch_stopped(
+            'pseries',
+            extra_args=['-machine', f'pseries,{caps}'],
+        )
+        # If we get here the machine launched without errors.
+        machines = self.vm.cmd('query-machines')
+        aliases = [m.get('alias') for m in machines]
+        self.assertIn('pseries', aliases)
+
+    # ------------------------------------------------------------------ #
+    # Test: nested-HV cap is accepted
+    # ------------------------------------------------------------------ #
+
+    def test_pseries_nested_hv_cap(self):
+        """pseries must accept cap-nested-hv=on without raising an error."""
+        self._launch_stopped(
+            'pseries',
+            extra_args=['-machine', 'pseries,x-vof=on,cap-nested-hv=on'],
+        )
+        machines = self.vm.cmd('query-machines')
+        aliases = [m.get('alias') for m in machines]
+        self.assertIn('pseries', aliases)
+
+    # ------------------------------------------------------------------ #
+    # Test: versioned compat machines can be instantiated
+    # ------------------------------------------------------------------ #
+
+    def _test_compat_machine(self, version_str):
+        """
+        Helper: launch a versioned compat machine and verify that the
+        name appears in query-machines and that it is not marked
+        is-current (compat machines are never the latest version).
+        """
+        self._launch_stopped(version_str)
+        info = self._query_machine_info(version_str)
+        self.assertIsNotNone(
+            info,
+            f'compat machine {version_str!r} not found in query-machines',
+        )
+        # Compat (versioned) machines are not the latest, so is-current
+        # must be absent or False.
+        self.assertFalse(
+            info.get('is-current', False),
+            f'{version_str} should not be marked is-current=true',
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


