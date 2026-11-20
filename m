Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58252606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hr4BE8Dv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULsc-0001I0-22; Fri, 20 Nov 2026 05:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULsa-0001Hl-5T; Fri, 20 Nov 2026 05:30:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULsY-0005Hs-DJ; Fri, 20 Nov 2026 05:30:03 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7wVSZ2487000; Fri, 20 Nov 2026 10:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9uKEeD
 5BZoWcKfV1kSpeDkX6+aA2NyERUiBFHs5Flk4=; b=hr4BE8DvlwIIiLwiP/tZB3
 RCWMNz32ZmIQwcLP+Eu2+Ng1z014dIKmrn/B1NzSMLzpt73WE7Pr1F0YZdGDPfEf
 9EHhknL0o3Yh7P6ryasQGQ6jGoCNu1p3UO+4IHwUA2rMMp67SMKW8KuZZja9IArp
 XYCjIBx40Kw7Gra5IjPWb8RFC7pnuDQQgHkTVq6Cknvf5SClisvxxBZxaRyI5UgX
 wmmBjyqHALWVLOYiMDWZ1U+F9u/2jpjP1OshkMcN9S5Xbxo5+bScJRZffvfysH8u
 B5wvPRSDlMsbbSdtEcJkxWjjKDcW7XXeHhy16eLF9I/aygqEEkN0D0iFKNE9FJEA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105x7dek-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 10:30:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7o4kW896150; Fri, 20 Nov 2026 10:29:59 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1bb5kjy4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 10:29:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AKATw1w33096336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 10:29:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7083958052;
 Fri, 20 Nov 2026 10:29:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C4A258056;
 Fri, 20 Nov 2026 10:29:52 +0000 (GMT)
Received: from [9.39.22.205] (unknown [9.39.22.205])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2026 10:29:51 +0000 (GMT)
Message-ID: <d74c4a1f-15af-4765-8ea5-ff507ee8f50a@linux.ibm.com>
Date: Fri, 20 Nov 2026 15:59:49 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests/functional/ppc64: pin machine types for
 hypervisor tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, peterx@redhat.com,
 farosas@suse.de, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com,
 gautam@linux.ibm.com, thuth@redhat.com, amachhiw@linux.ibm.com
References: <20261120095854.35941-7-asahu1x@linux.ibm.com>
 <20261120095854.35941-9-asahu1x@linux.ibm.com> <awAbwZ_w992RXUDY@redhat.com>
Content-Language: en-US
From: Aniket Sahu <asahu1x@linux.ibm.com>
In-Reply-To: <awAbwZ_w992RXUDY@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: GsdPBNDC9y-TiMGj_VleIoLyLQIwtVOZ
X-Proofpoint-GUID: QjU4JpHlBbTT6mV__59_cr040Pjrr0KC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfXx7BQh402d0n2
 bHMtcLuXabLyRUvL7DmtTbA3C+8TtP7nCpZM6vVx5E2UygQI+Ta65PtZm3Z0lvXMndTwQGKPXHf
 0KrbabO5difcM9rf6lUgu8q8gcsZN0pSlV6KiUcV3J228bgi6twt3I8hFCcI+SvHOFBfPRU5glr
 r0QfhvXSLEzHyR/6gyO6oJZkdCZvnuJ1gmVFSgyaxkzDe9FGjuxWjnd8U27ugzZrx4a0pVU1Fys
 CHRukEN0R/BpCR7L1widLOpeA4Ek02QwsgTvQWdGnVI4RouYegJs/uTkPVM69iMEt0i2E348UJz
 A3a/Y4L6Cei8PuEhpsu1W4ra/hH5nSoM+qRe0Z1L2y+xDf8pJ+3EGNqG2hIzcMxTuSsfIHZ7aXG
 Ce8H+HPYPKpoNn9E7IvgG9ikhqzdWWRbxhvXwl/Mq3+8hF/n3Voy9eOTNEkRRjUP/maO7ssR1QK
 zEwwG/VusjXWX1BLBiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfX58l3LiNoIW5c
 ZHoXhUsQSo09kIXVKTQmmx1f0hVGypqYPSCpD/Y+qoY2vEmYkCT1z11uY5gsHFQdJCzWqN+JKrR
 6uaLEghNWFv/EAyu1JwhcBUEdwOc2aw=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6b002128 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=1eOxSAtIvkPYLxiDPXsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200041
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

Thanks for the review!

On 20/11/26 3:36 PM, Daniel P. Berrangé wrote:
> On Fri, Nov 20, 2026 at 03:28:55PM +0530, Aniket Sahu wrote:
>> Pin machine types to avoid CPU compatibility issues:
>> - Use pseries-8.2 (POWER9) for pseries tests instead of generic 'pseries'
>>    alias which resolves to pseries-11.2 (power11_v2.0)
>> - Use powernv9 for powernv test to ensure consistent PCIe topology
>> - Fix test_hv_pseries_kvm to use TCG accelerator (L1 runs under TCG,
>>    L2 uses KVM inside L1)
>>
>> The generic 'pseries' alias now resolves to a machine whose default CPU
>> (power11) is not known to the qemu-system-ppc64 packaged by Alpine,
>> causing the L2 guest to fail with "Register sync failed" error.
>>
>> Signed-off-by: Misbah Anjum N <misanjum@linux.ibm.com>
>> Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
>> ---
>>   tests/functional/ppc64/test_hv.py | 20 +++++++++++++++-----
>>   1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/functional/ppc64/test_hv.py b/tests/functional/ppc64/test_hv.py
>> index 8a1fca2cb1..d977038271 100755
>> --- a/tests/functional/ppc64/test_hv.py
>> +++ b/tests/functional/ppc64/test_hv.py
>> @@ -125,7 +125,12 @@ def do_test_kvm(self, hpt=False):
>>       def test_hv_pseries(self):
>>           self.require_accelerator("tcg")
>>           self.require_netdev('user')
>> -        self.set_machine('pseries')
>> +        # Pin to pseries-8.2 (default CPU power9_v2.2) so that kvm-hv.ko inside
>> +        # the L1 Alpine guest sees a POWER9 register set.  The generic 'pseries'
>> +        # alias resolves to pseries-11.2 (power11_v2.0) which Alpine's packaged
>> +        # qemu-system-ppc64 does not recognise, causing the L2 "Register sync
>> +        # failed" error.  The L2 script passes '-cpu POWER9' to match.
>> +        self.set_machine('pseries-8.2')
> If the guest needs POWER9, why not add a "-cpu POWER9" flag to the L1
> QEMU here, instead of making assumptions about what the machine type
> exposes.
>
> Using old versioned machine types in functional tests is undesirable
> as we automatically delete versioned machines after 6 years, at
> which point we'll need to address the CPU model choice anyway.
Noted - will take care of this in V2.
>
>>           self.vm.add_args("-accel", "tcg,thread=multi")
>>           self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
>>           self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on")
>> @@ -135,10 +140,13 @@ def test_hv_pseries(self):
>>           self.do_stop_alpine()
>>   
>>       def test_hv_pseries_kvm(self):
>> -        self.require_accelerator("kvm")
>> +        # L1 runs under TCG; L2 is launched with accel=kvm inside L1
>> +        # (see do_test_kvm).
>> +        self.require_accelerator("tcg")
>>           self.require_netdev('user')
>> -        self.set_machine('pseries')
>> -        self.vm.add_args("-accel", "kvm")
>> +        # Same CPU pinning rationale as test_hv_pseries above.
>> +        self.set_machine('pseries-8.2')
>> +        self.vm.add_args("-accel", "tcg,thread=multi")
>>           self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
>>           self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on,cap-ccf-assist=off")
>>           self.do_start_alpine()
>> @@ -149,7 +157,9 @@ def test_hv_pseries_kvm(self):
>>       def test_hv_powernv(self):
>>           self.require_accelerator("tcg")
>>           self.require_netdev('user')
>> -        self.set_machine('powernv')
>> +        # Pin to powernv9 so the PCIe topology matches (pcie.0, pcie.2) and
>> +        # kvm-hv.ko runs with the POWER9 CPU model.
>> +        self.set_machine('powernv9')
>>           self.vm.add_args("-accel", "tcg,thread=multi")
>>           self.vm.add_args('-device', 'nvme,bus=pcie.2,addr=0x0,serial=1234,drive=drive0',
>>                            '-device', 'e1000e,netdev=net0,mac=C0:FF:EE:00:00:02,bus=pcie.0,addr=0x0',
>> -- 
>> 2.52.0
>>
>>
> With regards,
> Daniel

Regards,
Aniket.


