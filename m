Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC34606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oN99ZMRs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVEi-00030m-HV; Mon, 23 Nov 2026 09:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xVVEY-0002z2-TR; Mon, 23 Nov 2026 09:41:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xVVEV-0000dX-SH; Mon, 23 Nov 2026 09:41:30 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDZEGJ3742662; Mon, 23 Nov 2026 14:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ADdSE+
 nv6XhVTF+blc+7A7ueu1/l7c4LxBSCzDjv5Vc=; b=oN99ZMRsStgY0e17Jxflnz
 JLk0paO7Acz9Dj0uidaYbAFU7meKrCEO8HP25BBnnO6CfdlQfhA46+O3bgeDiKlw
 +76lHuxWlan4RaT8vAEAuAKpZeJ6vKwvDDX8u2sMdTYV8ODrY7lRmqP0GiXAHuNY
 x0CUfc29tPbuhr4lznUpzOdqWFzP3SFU6MGJCAr7nnuDLWTi0x6DhW9maeHs4tjz
 Vm2GYB9S+9a4Ygd3+1IXDRusLr0dw8wlOiajx6yCoqteuOplt3JuV1tq26b+YXHk
 fUN2xDoxyxXnDCTZkpNQ6JuMwF2+Tf1HyhK2ycUrZvs3+hPelvTqg6/xkmBQFUnw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkbmns-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 14:41:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDJUh81976097; Mon, 23 Nov 2026 14:41:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3rayeud5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 14:41:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ANEfMl320316700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Nov 2026 14:41:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C809558058;
 Mon, 23 Nov 2026 14:41:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4E1E5805B;
 Mon, 23 Nov 2026 14:41:18 +0000 (GMT)
Received: from [9.123.12.1] (unknown [9.123.12.1])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Nov 2026 14:41:18 +0000 (GMT)
Message-ID: <4b58787b-182b-4df5-b479-1a5c87931192@linux.ibm.com>
Date: Mon, 23 Nov 2026 20:11:17 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] tests/functional/ppc64: add pseries security caps
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
References: <20261030131025.32219-1-anushree.mathur@linux.ibm.com>
 <20261119062951.83498-1-anushree.mathur@linux.ibm.com>
 <20261119062951.83498-3-anushree.mathur@linux.ibm.com>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <20261119062951.83498-3-anushree.mathur@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfX168+nIbIBFt5
 YQWZhko7hUe984bZMngCsPW/bBEdneT+xmJBnK5i4ZX3smqpzfTtjkMOVPpntHb8juDfGa9omV8
 2laADT5ke6F/gEcvosxlTvcL0hZMGXmzAOtQOE4eqnSPb8xtDmTZs4KsA4F+Lpv7sZ7F5P/BP3j
 W0HDWRR/8BVQLTu0N7FpGp8OlGoz9LW2lTq6hgnbnUYi4XAL2cC/jdFLmqAa4SpnnDwAx8j0eMn
 8uIxS24pEFeFJvFeGdwGB2WkGitRcvYhWLL8ogcmVyTxcpku1/rpxe5uEbH2pl92hvLRTyFfvhA
 lpWXlNlKO9uvioOP+Y1gZs76R9xProdJgGiZO8rFIUr7v7iBEHH3LQ5njuzqegtZYfYqYUk9laK
 bd7XHCUAZdZHLTO6qCWV5Uj/WbNCQ732/O9p/GX8mgd4yYC+Zrb/yhJuAVF9FMNIUdyB5VS//i+
 m+IGS5+B9w6fN6qjGmg==
X-Proofpoint-ORIG-GUID: URLS8w9gN2ba_wKWinB8rUyX1fMLNGIj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfX2DvTyN/KDtVH
 BBh1nKVyZtVUyzEm/D4VJM4TPJSz3W0KaaQ9JuVWQx5tDPZXC4zkj3NK7r5T+d1qQFaibM5SDNF
 ivdn0M9NepK6qCzbOkc2c/+zl6UHzlc=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b045095 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=RUb66nHFPt7xCKYcQ8EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wlA9fxz5f3WgmAbh2gBM7FQDrtPKvsCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230058
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

On 11/19/26 11:59 AM, Anushree Mathur wrote:
> Add a quick functional test (no Linux boot required) that checks that
> the pseries machine type accepts its security capability options and
> that backward-compatible versioned machine types can be instantiated,
> using the QMP interface.
> 
> Each test starts QEMU with -S (halted) so no firmware or kernel is
> needed.  The tests cover:
> 
>    * test_pseries_in_query_machines: pseries appears in query-machines
>      and is marked is-default=true.
>    * test_pseries_security_caps_override: cap-cfpc, cap-sbbc, cap-ibs
>      and cap-ccf-assist overrides are accepted and the machine starts.
>    * test_pseries_nested_hv_cap: cap-nested-hv=on is accepted.
>    * test_pseries_compat_7_2/9_2/10_0: versioned compat machines can be
>      instantiated and are not marked is-current.
>    * test_pseries_cap_hpt_max_page_size: cap-hpt-max-page-size is
>      reachable via the QOM tree at /machine.
> 
> All tests complete in under 5 seconds each and are registered in the
> tests_ppc64_system_quick list.
> 
> Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> ---
> v2: reworded the commit message to say what is actually checked,
> fixed docstrings that did not match the code and dropped the skipped
> query-cpu-model-expansion placeholder test.
> 
>   tests/functional/ppc64/meson.build          |   1 +
>   tests/functional/ppc64/test_pseries_caps.py | 162 ++++++++++++++++++++
>   2 files changed, 163 insertions(+)
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
> index 0000000000..9ef3f48bb1
> --- /dev/null
> +++ b/tests/functional/ppc64/test_pseries_caps.py
> @@ -0,0 +1,162 @@
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
> +      * The machine type is visible in 'query-machines' output.
> +      * Known security capability properties (cap-cfpc, cap-sbbc,
> +        cap-ibs, cap-ccf-assist, cap-nested-hv) are accepted.
> +      * Versioned compat machines (pseries-7.2, pseries-9.2 and
> +        pseries-10.0) can be instantiated and are not marked
> +        is-current.
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
> +        test_hv.py.  We only check that QEMU starts cleanly (no launch
> +        exception); the actual cap values are enforced by separate
> +        migration / capability tests.
> +        """

I think the other tests also apply these cap overrides, but none of them 
verifies the values. Maybe we can include the test here only to check 
the cap values using qom-get.

> +        caps = (
> +            'cap-cfpc=broken,'
> +            'cap-sbbc=broken,'
> +            'cap-ibs=broken,'
> +            'cap-ccf-assist=off'
> +        )
> +        self._launch_stopped(
> +            'pseries',
> +            extra_args=['-machine', f'pseries,{caps}'],
> +        )

Nit: passing pseries in extra_args is redundant.

> +        # If we get here the machine launched without errors.
> +        machines = self.vm.cmd('query-machines')
> +        aliases = [m.get('alias') for m in machines]
> +        self.assertIn('pseries', aliases)
> +
> +    # ------------------------------------------------------------------ #
> +    # Test: nested-HV cap is accepted
> +    # ------------------------------------------------------------------ #
> +
> +    def test_pseries_nested_hv_cap(self):
> +        """pseries must accept cap-nested-hv=on without raising an error."""
> +        self._launch_stopped(
> +            'pseries',
> +            extra_args=['-machine', 'pseries,x-vof=on,cap-nested-hv=on'],
> +        )

Nit: passing pseries in extra_args is redundant.

> +        machines = self.vm.cmd('query-machines')
> +        aliases = [m.get('alias') for m in machines]
> +        self.assertIn('pseries', aliases)
> +

Maybe we can also add a check to verify the cap-nested-hv value using 
qom-get in this function.

> +    # ------------------------------------------------------------------ #
> +    # Test: versioned compat machines can be instantiated
> +    # ------------------------------------------------------------------ #
> +
> +    def _test_compat_machine(self, version_str):
> +        """
> +        Helper: launch a versioned compat machine and verify that the
> +        name appears in query-machines and that it is not marked
> +        is-current (compat machines are never the latest version).
> +        """
> +        self._launch_stopped(version_str)
> +        info = self._query_machine_info(version_str)
> +        self.assertIsNotNone(
> +            info,
> +            f'compat machine {version_str!r} not found in query-machines',
> +        )
> +        # Compat (versioned) machines are not the latest, so is-current
> +        # must be absent or False.
> +        self.assertFalse(
> +            info.get('is-current', False),
> +            f'{version_str} should not be marked is-current=true',
> +        )

There is no such property like is-current, I verified from the 
query-machines output.
info.get('is-current', False) always returns False, so assertFalse 
always passes regardless of the machine. So, the assertion can never 
fail and the test always passes.
I guess you meant is-default.

> +
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
> +
> +if __name__ == '__main__':
> +    PseriesCapsTest.main()

Regards,
Utkarsh


