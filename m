Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2D8606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=F3CBKXeQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWurN-0007Rj-DR; Fri, 27 Nov 2026 07:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xWurL-0007QJ-7w; Fri, 27 Nov 2026 07:15:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xWurI-0007Yv-Fr; Fri, 27 Nov 2026 07:15:22 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARB52s11293555; Fri, 27 Nov 2026 12:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=V8u/FJ
 sfjywdiNskiO/V2s6Oh3eVA5jfWu+hGXFwFjs=; b=F3CBKXeQCNseI8YxWz28HH
 EvJ8Mucu9zcHipEACvgcasStGlAFMiIbAuHoVpusTXfEKcteY95As14hDekIvYm4
 rypRdxyc4RcTAlbMKsyCHYEW/vzPSs2fK1MMBB6AHKB7L40UA5XkZsDe5G5f4yZI
 FaLj7yI/lsKIUgXnYOdk05QZ+r8wkf7BLr7KmLKDJHcDwLiJQCvWXtjFOfYwwTdU
 pRmmdT4lC+lCZkSk00nNeEzjb/DM6Ug880K3URdETHJ9rxz+YarPdl6dcPyAh1eJ
 SripbxBmvpfevur0GIC4O3lIMnr/a59kaTkHiXdNljlzSj3yeymWlqW10Gc8+pTw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3nqt4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Nov 2026 12:15:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARAoPh62611009; Fri, 27 Nov 2026 12:15:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfaa569-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Nov 2026 12:15:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ARCFGjV3146376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Nov 2026 12:15:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A67F5805D;
 Fri, 27 Nov 2026 12:15:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC22F58065;
 Fri, 27 Nov 2026 12:15:12 +0000 (GMT)
Received: from [9.123.12.1] (unknown [9.123.12.1])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Nov 2026 12:15:12 +0000 (GMT)
Message-ID: <63437a1f-f42a-4b0c-ab58-6dfdbd2abee1@linux.ibm.com>
Date: Fri, 27 Nov 2026 17:45:11 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] tests/functional/ppc64: add pseries security caps
 test
To: Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, misanjum@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20261124110030.30097-1-anushree.mathur@linux.ibm.com>
 <20261124110030.30097-3-anushree.mathur@linux.ibm.com>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <20261124110030.30097-3-anushree.mathur@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b097456 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=BR34Rf8PEsJhmb2Ouy8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0OCBTYWx0ZWRfXy3htgGRlDkLV
 Q9aFvu6OBrJaLXb9Yn3yzkvYZamI7FLW7T0/vZIsU6ZXzD6uZ5uD84IkJ60oIdEGg/Gpphsypz7
 lVvoTGHE1grtRJ6CdB+NUf5T/HfRrE8=
X-Proofpoint-ORIG-GUID: VyZw1bmXYz9H32QgjwId5su4nqLw-aLD
X-Proofpoint-GUID: BfuzUZqEj9to33gc0LZu6l_pOaW-6jpK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0OCBTYWx0ZWRfX/gd4qkzQPZ6Y
 LK40hcMHf+iG3rEQHn1YMCKAyYYruEKm7yh/uuHTwtkez0D30k1ijz2c7IfICY6p2ZFPckTv6gK
 QCGT8u+dq12D4iunwdIujwwylAN9O64S9wq94DIQ7e6o0YD4u+Z3PvYUxkWVWGjjtM97sJVGo7r
 xEVv/buFdI0FPKT2zMlEHsdAXhnQibitq4dN8ZWIrWhLLxLSAoATnyFhFLl82yLdEec5tocEzJU
 Wy9thQd0pygwPhDGVQL+b8Q6rOp94lfdNJ41tDJIFde3Xm19zpN0LWOiO4rznIFKK2wB3Xl3S65
 E8rYU3Yp+BpgjtTcix1EadqWnVJEmO6Yk1xyxf5Pv7zmCpTCmLs8LAMOFUFZQB658lNgBbblTC8
 jrkMnXZElmRB+58A7yi5DRNjOj8HmBXAbz4QTF3n4H4SSWmz8m1Nu6T+wNnysg9F7ozulchy9l5
 0IB8ZzF0sQB3/oSgShQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270048
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 4:30 PM, Anushree Mathur wrote:
> Add a quick functional test (no Linux boot required) that checks that
> the pseries machine type accepts its security capability options and
> reports them back with the configured values, and that backward-compatible
> versioned machine types can be instantiated, using the QMP interface.
> 
> Each test starts QEMU with -S (halted) so no firmware or kernel is
> needed.  The tests cover:
> 
>    * test_pseries_in_query_machines: pseries appears in query-machines
>      and is marked is-default=true.
>    * test_pseries_security_caps_override: cap-cfpc, cap-sbbc, cap-ibs
>      and cap-ccf-assist overrides are accepted, the machine starts and
>      qom-get on /machine returns the values that were set.
>    * test_pseries_nested_hv_cap: cap-nested-hv=on is accepted and
>      qom-get reports it as on.
>    * test_pseries_compat_7_2/9_2/10_0: versioned compat machines can be
>      instantiated and are not marked is-default.
>    * test_pseries_cap_hpt_max_page_size: cap-hpt-max-page-size is
>      reachable via the QOM tree at /machine.
> 
> All tests complete in under 5 seconds each and are registered in the
> tests_ppc64_system_quick list.
> 
> Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> ---
> v3: check the cap-cfpc, cap-sbbc, cap-ibs, cap-ccf-assist and
> cap-nested-hv values with qom-get instead of only checking that QEMU
> starts; dropped the redundant "pseries" from the -machine arguments;
> the compat machine check now looks at is-default (is-current is not a
> query-machines field, so the old assertion could never fail).
> 
>   tests/functional/ppc64/meson.build          |   1 +
>   tests/functional/ppc64/test_pseries_caps.py | 169 ++++++++++++++++++++
>   2 files changed, 170 insertions(+)
>   create mode 100755 tests/functional/ppc64/test_pseries_caps.py
> 
> diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
> index 45468087cb..d91209f041 100644
> --- a/tests/functional/ppc64/meson.build
> +++ b/tests/functional/ppc64/meson.build
> @@ -14,6 +14,7 @@ test_ppc64_timeouts = {
>   
>   tests_ppc64_system_quick = [
>     'migration',
> +  'pseries_caps',
>     'vmstate',
>   ]
>   
> diff --git a/tests/functional/ppc64/test_pseries_caps.py b/tests/functional/ppc64/test_pseries_caps.py
> new file mode 100755
> index 0000000000..2b2d33229f
> --- /dev/null
> +++ b/tests/functional/ppc64/test_pseries_caps.py
> @@ -0,0 +1,169 @@
> +#!/usr/bin/env python3
> +# Copyright (c) 2025 IBM Corporation
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import QemuSystemTest
> +
> +
> +class PseriesCapsTest(QemuSystemTest):
> +    """
> +    Quick (no-boot) tests for pseries machine capabilities.
> +
> +    Each test starts QEMU with -S (halted) so no firmware or kernel is
> +    needed.  The tests exercise the QMP interface to verify that:
> +

Review comment by sashiko:
[LOW] In tests/functional/ppc64/test_pseries_caps.py (PseriesCapsTest 
class docstring) and the commit message, the claim that -S means no 
firmware is needed is inaccurate. spapr_machine_init() in hw/ppc/spapr.c 
always looks up and loads slof.bin (vof.bin with x-vof=on) via 
qemu_find_file() and load_image_targphys() before -S takes effect, and 
it exits if the image is missing. -S only means the firmware is not 
executed. Reword the docstring and commit message to say so, and note 
that the image must still be present in pc-bios. Also, 
test_pseries_nested_hv_cap passes the experimental x-vof=on with no 
stated reason. cap-nested-hv is validated in cap_nested_kvm_hv_apply() 
in hw/ppc/spapr_caps.c independently of VOF, so x-vof=on only switches 
the required image to vof.bin and makes this one test depend on an 
experimental x- property. The reason test_hv.py uses it (avoiding slow 
SLOF boot) does not apply to a -S launch. Drop x-vof=on or add a comment 
explaining why it is needed.

> +      * The machine type is visible in 'query-machines' output.
> +      * Known security capability properties (cap-cfpc, cap-sbbc,
> +        cap-ibs, cap-ccf-assist, cap-nested-hv) are accepted and read
> +        back with the values that were set.
> +      * Versioned compat machines (pseries-7.2, pseries-9.2 and
> +        pseries-10.0) can be instantiated and are not marked
> +        is-default.
> +      * cap-hpt-max-page-size is reachable via the QOM tree.
> +    """
> +
> +    timeout = 30
> +
> +    # ------------------------------------------------------------------ #
> +    # Helpers
> +    # ------------------------------------------------------------------ #
> +
> +    def _launch_stopped(self, machine='pseries', extra_args=None):
> +        """Launch QEMU paused (-S) for the named machine and return."""
> +        self.set_machine(machine)
> +        self.vm.add_args('-S', '-nodefaults')
> +        if extra_args:
> +            self.vm.add_args(*extra_args)
> +        self.vm.launch()
> +
> +    def _query_machine_info(self, name):
> +        """Return the entry from query-machines that matches *name* or alias."""
> +        machines = self.vm.cmd('query-machines')
> +        for m in machines:
> +            if m['name'] == name or m.get('alias') == name:
> +                return m
> +        return None
> +
> +    # ------------------------------------------------------------------ #
> +    # Test: basic pseries machine is visible in query-machines
> +    # ------------------------------------------------------------------ #
> +
> +    def test_pseries_in_query_machines(self):
> +        """pseries (latest) must appear in query-machines output."""
> +        self._launch_stopped('pseries')
> +        info = self._query_machine_info('pseries')
> +        self.assertIsNotNone(info,
> +                             'pseries not found in query-machines output')
> +        # The default/latest versioned machine carries is-default=True.
> +        self.assertTrue(
> +            info.get('is-default', False),
> +            'pseries alias should be marked is-default=true',
> +        )
> +
> +    # ------------------------------------------------------------------ #
> +    # Test: security cap overrides are accepted without error
> +    # ------------------------------------------------------------------ #
> +
> +    def test_pseries_security_caps_override(self):
> +        """
> +        Verify pseries accepts all well-known security cap overrides.
> +
> +        These are the options used by the KVM nested-HV path in
> +        test_hv.py.  Check that QEMU starts cleanly and that each
> +        capability reads back through qom-get with the value that was
> +        set on the command line.
> +        """
> +        caps = (
> +            'cap-cfpc=broken,'
> +            'cap-sbbc=broken,'
> +            'cap-ibs=broken,'
> +            'cap-ccf-assist=off'
> +        )
> +        self._launch_stopped('pseries', extra_args=['-machine', caps])
> +        for name in ('cap-cfpc', 'cap-sbbc', 'cap-ibs'):
> +            self.assertEqual(
> +                self.vm.cmd('qom-get', path='/machine', property=name),
> +                'broken',
> +                f'{name} should read back as broken',
> +            )
> +        self.assertFalse(
> +            self.vm.cmd('qom-get', path='/machine',
> +                        property='cap-ccf-assist'),
> +            'cap-ccf-assist should read back as off',
> +        )
> +
> +    # ------------------------------------------------------------------ #
> +    # Test: nested-HV cap is accepted
> +    # ------------------------------------------------------------------ #
> +
> +    def test_pseries_nested_hv_cap(self):
> +        """pseries must accept cap-nested-hv=on and report it as on."""
> +        self._launch_stopped(
> +            'pseries',
> +            extra_args=['-machine', 'x-vof=on,cap-nested-hv=on'],
> +        )
> +        self.assertTrue(
> +            self.vm.cmd('qom-get', path='/machine',
> +                        property='cap-nested-hv'),
> +            'cap-nested-hv should read back as on',
> +        )
> +
> +    # ------------------------------------------------------------------ #
> +    # Test: versioned compat machines can be instantiated
> +    # ------------------------------------------------------------------ #
> +
> +    def _test_compat_machine(self, version_str):
> +        """
> +        Helper: launch a versioned compat machine and verify that the
> +        name appears in query-machines and that it is not marked
> +        is-default (the default is always the latest version).
> +        """
> +        self._launch_stopped(version_str)
> +        info = self._query_machine_info(version_str)
> +        self.assertIsNotNone(
> +            info,
> +            f'compat machine {version_str!r} not found in query-machines',
> +        )
> +        # query-machines only reports is-default for the default (latest)
> +        # machine, so it must be absent or False for a compat machine.
> +        self.assertFalse(
> +            info.get('is-default', False),
> +            f'{version_str} should not be marked is-default=true',
> +        )
> +

This test seems a little weak, as it is only checking for "is-default" 
value is either False or is missing (which could be true for incorrect 
values as well)
It would be better to atleast have the machine name property verified as 
well.

> +    def test_pseries_compat_7_2(self):
> +        """pseries-7.2 (vmstate reference version) can be instantiated."""
> +        self._test_compat_machine('pseries-7.2')
> +
> +    def test_pseries_compat_9_2(self):
> +        """pseries-9.2 can be instantiated."""
> +        self._test_compat_machine('pseries-9.2')
> +
> +    def test_pseries_compat_10_0(self):
> +        """pseries-10.0 can be instantiated."""
> +        self._test_compat_machine('pseries-10.0')
> +
> +    # ------------------------------------------------------------------ #
> +    # Test: cap-hpt-max-page-size is reachable via the QOM tree
> +    # ------------------------------------------------------------------ #
> +
> +    def test_pseries_cap_hpt_max_page_size(self):
> +        """
> +        Verify that pseries exposes cap-hpt-max-page-size in its
> +        machine properties (it is used by migration compat checks).
> +        """
> +        self._launch_stopped('pseries')
> +        # query-machine-props is not a real QMP command; we use the
> +        # object model instead.
> +        props = self.vm.cmd('qom-list', path='/machine')
> +        prop_names = [p['name'] for p in props]
> +        # The property should be reachable via the QOM tree.
> +        self.assertIn(
> +            'cap-hpt-max-page-size', prop_names,
> +            'pseries /machine must expose cap-hpt-max-page-size via QOM',
> +        )
> +

Review comment by sashiko:
[LOW] In tests/functional/ppc64/test_pseries_caps.py 
(test_pseries_cap_hpt_max_page_size), the test only asserts that the 
name cap-hpt-max-page-size appears in qom-list of /machine. The property 
is registered unconditionally by spapr_caps_add_properties() from 
capability_table in hw/ppc/spapr_caps.c, so the assertion passes even 
with a broken getter or setter. Unlike the other cap tests in this file, 
it never reads a value. Suggest qom-get on cap-hpt-max-page-size 
asserting 65536 (the latest pseries default is 16, and 
spapr_cap_get_pagesize() returns 1 << 16), and optionally setting 
cap-hpt-max-page-size=16M and reading it back.

Regards,
Utkarsh

> +
> +if __name__ == '__main__':
> +    PseriesCapsTest.main()


