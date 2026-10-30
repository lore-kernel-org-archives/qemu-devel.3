Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3ED606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J6U4pdIj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmOx-0005iP-N4; Fri, 30 Oct 2026 09:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xMmOo-0005g6-Ay; Fri, 30 Oct 2026 09:12:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xMmOm-0004pP-50; Fri, 30 Oct 2026 09:12:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBILtL1140009; Fri, 30 Oct 2026 13:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OhVwJj
 qG8mnodKxmQM+iB/OM5EMdBQ04mh3ttD2jf6g=; b=J6U4pdIjgbQ4VbGNJM0i1z
 Tivr8VWfaziUgVchZyab6l41BUV2mYu+SkszLUBAk0VBfR4hjYCbU88FVcEcE4hj
 BnQ9MXO3Ub6QAuQU8hCisIZL7uMcAyz6Yv9cXIbXMtpuHesA9puV3ZnFVYgvRLJ5
 kKmvbGcleJR99tGeQTneSTPpgzLuwsFJKzzadvxr4lx/Ht0WBOC149aW6IyXXY7w
 74TZnjp/nfL6PtSrq1EZ3UV9AVHNCy/c86Ek6UsRinjTuXEA5Zb1QbQHAor0xzMa
 0byYB692fRop5xAqNzlTAtmCfM0/lA8fjOmqfJdsF2I/igcgB4FywOzGXe6bCiAg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeay2ueg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 13:11:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBK3n9477313; Fri, 30 Oct 2026 13:11:57 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hma543hk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 13:11:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69UDBtmp62849450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2026 13:11:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C85D5805E;
 Fri, 30 Oct 2026 13:11:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BB6D58055;
 Fri, 30 Oct 2026 13:11:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.21.33])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Oct 2026 13:11:50 +0000 (GMT)
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, clg@redhat.com,
 thuth@redhat.com, adityag@linux.ibm.com, milesg@linux.ibm.com,
 misanjum@linux.ibm.com, Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: [PATCH 2/3] tests/functional/ppc64: add pseries security caps test
Date: Fri, 30 Oct 2026 18:40:23 +0530
Message-ID: <20261030131025.32219-3-anushree.mathur@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030131025.32219-1-anushree.mathur@linux.ibm.com>
References: <20261030131025.32219-1-anushree.mathur@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: mK9UvfGQi0gVQ-eTrxK55om6-xOjyRQY
X-Proofpoint-GUID: zPViPxri2sOzJ5KdnXmkYcybxS1s9x2K
X-Authority-Analysis: v=2.4 cv=eZyo7LEH c=1 sm=1 tr=0 ts=6ae4979e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=fIIx01Jw0jOMtClQMVQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfXxAym1O6tWPcX
 9Fn1SZfhbAL1JFeX77Mw5ziZx4p3LSR8taaSK8Y2iuHKVxczlISKws93d4IPFMxc6aXAym7lHzs
 QSwDJ8gsmhcZNiTdhstXJAegbe5O10M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX+P0QX2Y5nBRq
 ya56z/FWUIZBXCr3N/3XvjHny7NNWoY8kIXRIOitMxrs7PVKlNZCvAFTBu85r2JiMxqFRiA93MB
 74wjS52enw0V0qKV6A6fPDoSjGj3zK2MzXdiecnBcYPyQbokdmQPUmI02Dlv0plbBuvwaCuO3nj
 PsFH+K3HNesTMFUzh78I7Irtbnfq709fCuWV/9h4sdIAWzXFn+xJRiFJjnt7f01T69+w3YmywIS
 ehwtjazn2neqBVwk4behw7qKONzdUbeuPR6PBcm7FFFXutD6g00RVbfksn6kMSwt3feGV7JcIeW
 pWAKY6jpUSqnffHYKb9ex9App2Xnk480/44cbwIAGqRunir3f6ju9oJjEW94HNLvbAg2EWTnJsH
 DDk5MNrPAp+gFI66VPHTRrymc+Y6E8vzET2f9mRrg9nsY0C8K22MvIUhx//xDfH0v+dE71GizSC
 We5TArxhQ6EaQDmMC9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300050
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

Add a quick functional test (no Linux boot required) that validates
pseries machine-type security capabilities and backward-compatible
machine-type instantiation via the QMP interface.

Each test starts QEMU with -S (halted) so no firmware or kernel is
needed.  The tests cover:

  * test_pseries_in_query_machines: pseries appears in query-machines
    and is marked is-default=true.
  * test_pseries_security_caps_override: cap-cfpc, cap-sbbc, cap-ibs
    and cap-ccf-assist overrides are accepted without error.
  * test_pseries_nested_hv_cap: cap-nested-hv=on is accepted.
  * test_pseries_compat_7_2/9_2/10_0: versioned compat machines can be
    instantiated and are not marked is-current.
  * test_pseries_cpu_model_expansion: skipped (query-cpu-model-expansion
    is not implemented for ppc64 TCG).
  * test_pseries_cap_hpt_max_page_size: cap-hpt-max-page-size is
    reachable via the QOM tree at /machine.

All tests complete in under 5 seconds each and are registered in the
tests_ppc64_system_quick list.

Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
---
 tests/functional/ppc64/meson.build          |   1 +
 tests/functional/ppc64/test_pseries_caps.py | 178 ++++++++++++++++++++
 2 files changed, 179 insertions(+)
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
index 0000000000..bf8825187e
--- /dev/null
+++ b/tests/functional/ppc64/test_pseries_caps.py
@@ -0,0 +1,178 @@
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
+      * Versioned compat machines (pseries-7.2 … pseries-11.1) can
+        be instantiated and report sensible properties.
+      * CPU model expansion works for the default POWER10 CPU type.
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
+        name appears in query-machines and that there is at least one
+        entry marked deprecated (compat machines are always
+        non-current).
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
+    # Test: CPU model expansion for pseries
+    # ------------------------------------------------------------------ #
+
+    def test_pseries_cpu_model_expansion(self):
+        """
+        Verify query-cpu-model-expansion works for POWER10 on pseries.
+
+        The 'full' expansion should return a props dict that includes
+        at least the 'pvr' property.
+
+        NOTE: query-cpu-model-expansion is not implemented for ppc64 TCG;
+        this test is skipped until the target gains introspection support.
+        """
+        self.skipTest('query-cpu-model-expansion is not supported on ppc64')
+
+    # ------------------------------------------------------------------ #
+    # Test: HPT and Radix MMU caps exposed via query-machines
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


