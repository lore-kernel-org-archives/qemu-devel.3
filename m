Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE67606A320
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JYzBKvEJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUxAw-0008Hg-2s; Sat, 21 Nov 2026 21:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xUxAv-0008HT-9D; Sat, 21 Nov 2026 21:19:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xUxAt-0006lq-G0; Sat, 21 Nov 2026 21:19:29 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AM0ZAiN2073048; Sun, 22 Nov 2026 02:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=R8xjdX
 6VEdwa84Uv1+fusQUpdfbe9bdJZcLvS0Cddes=; b=JYzBKvEJzT1PL5jvL5SyIh
 pvWEHXtrSzop9kbyy1Wike6k5AGfvqvTHdYjXvte0zgPrJUT5XVjby8iI2mR2Hvq
 i+EpgwoL4kVCBip/WLOoMgSFx3n0ePkPgqFpEVdl6bqo4QU8vI6pNze7TP6Yn8wI
 RxAdrTKHlXQgXbSIIIZ5FKuVPkqBekyjFlRnixEG/wppY8s+2x4z+xVBDxmjvlBV
 E4lVccndloYHM2bMK07MYajeeEeP38EBW8b8hrPqH1qh0BX2Km7ULuEcuYeEYMLB
 Ks4ZE3X8m8VsjyHMD2kY8XirFlF1j6TqrNJw5ts1BjiZb62dL7QzBeGw+6znNRRA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p44aar-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 22 Nov 2026 02:19:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AM0JHHU2538680; Sun, 22 Nov 2026 02:19:21 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j34n4vq5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 22 Nov 2026 02:19:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AM2JKTC28902112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 22 Nov 2026 02:19:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2D8C58056;
 Sun, 22 Nov 2026 02:19:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF8BC58052;
 Sun, 22 Nov 2026 02:19:14 +0000 (GMT)
Received: from [9.124.222.212] (unknown [9.124.222.212])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 22 Nov 2026 02:19:14 +0000 (GMT)
Message-ID: <497b4b73-07b8-4c53-af59-e62a3043ec8e@linux.ibm.com>
Date: Sun, 22 Nov 2026 07:49:12 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] tests/functional/ppc64: Fixes and improvements for
 hypervisor tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, peterx@redhat.com,
 farosas@suse.de, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com,
 gautam@linux.ibm.com, thuth@redhat.com, amachhiw@linux.ibm.com
References: <20261120095854.35941-7-asahu1x@linux.ibm.com>
 <87y0an4he9.fsf@draig.linaro.org>
Content-Language: en-US
From: Aniket Sahu <asahu1x@linux.ibm.com>
In-Reply-To: <87y0an4he9.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAwOCBTYWx0ZWRfX4nBWtYGJWQrQ
 EOqz6cCvNJ5a7WWYnmrgJDCscTbAncKSiqbyDfx7dlL/AsGW15BoAZLQhHv4Vo70l4egdHZKUhM
 ycLVjhpHSF1+uS9Vk4yJwpZJl+gaTMI=
X-Proofpoint-GUID: ABsw6JyM3UEY_uMT3FZrhWjwtd9JEUjA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAwOCBTYWx0ZWRfXwmoI+NQwlbzy
 eGoLHrqn3xNXNydZJimV5mmD5yfhb/RCr0g04uzSVTsZwf+5e9NtCOj5JjheqM01AZ9sJMdUw4L
 H/CvraiqLimlz+PdlAKZuIjNBU7dexTubhMD1xOxBE+O1o5W4TM65rBPxQ6B8696rkJx1Z1HL7a
 wL9UbYmNKpdiRzYL45VeXh7Uuo7wgKXWR3bhxqwp7WgYdlP0t+FmXGqlHiWhI+03iFGmL/xTPnY
 lHySEaEdSsT6BQgqgOe8A+FbKuKmoLEolw8b/AV8+Ki07hfSIXd0rH773M+PZVXRAsDsJHHCSCV
 R/Pz95dg1jgr7tCQYSJIB+zbfmGsXNzdXs1WKzgpWhqS6t7czxrd0VoKR8N+6qRnfxSMA1Mhati
 NA66n0CWoAgKzpdRwmVOV8wwcPwK/lkTYPpx4oay9zySKNKfe1MURIocM1eUE5kTeaFP1J+ZTI8
 Ydwxbm6jJXVsaT2dtfQ==
X-Proofpoint-ORIG-GUID: XhqTM13zeuzvaH6WdgUoXPAyagly4TN_
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b02512b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=QsAAtPqVoXNInit7G4EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_06,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220008
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
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 20/11/26 9:36 PM, Alex Bennée wrote:
> Aniket Sahu <asahu1x@linux.ibm.com> writes:
>
>> This series fixes several issues in the PPC64 hypervisor functional tests
>> and improves their robustness and reliability.
> Just a quick note to say the power hardware we have from OSUL doesn't
> expose a hypervisor so we can't currently run these tests in the
> upstream CI. Do you know of any way we could get such hardware added to
> the CI?
Hypervisor tests are part of the thorough test run (mentioned as hv in 
the meson.build file), and if I remember correctly, only quick tests are 
run as part of the CI on gitlab. While the changes I have made would 
benefit everyone who wants to run hypervisor tests or the thorough test 
cycle on their machine for ppc64 systems, this mainly helps us target 
clean CI runs on our internal CI systems. Regarding hardware 
availability in OSUL, this is something we need to look at and plan for. 
Will talk with my team about this!
>
> Also I should note it would be nice to get:
>
>    https://gitlab.com/qemu-project/qemu/-/work_items/3207
>
> addressed. Let me know if you need access to the system.
Noted, taking a loot at the issue, will correspond via the work item 
comments if I need a machine.
>
>> Changes in this series:
>> -----------------------
>>
>> 1. Replace deprecated datetime.utcnow() with datetime.now(timezone.utc)
>>     to avoid deprecation warnings in Python 3.12+.
>>
>> 2. Pin machine types to avoid CPU compatibility issues between the L0
>>     QEMU (which now defaults to power11) and the L1 Alpine guest's
>>     packaged QEMU (which doesn't recognize power11). This fixes
>>     "Register sync failed" errors in L2.
>>
>> 3. Add kernel command line parameters (console=hvc0 usbcore.nousb) and
>>     early panic detection to fail fast when L2 encounters issues, plus
>>     retry logic for apk update to handle transient network failures.
>>
>> 4. Dynamically resolve the NVMe device path in L1 instead of hardcoding
>>     it, as the device name varies by machine type (nvme0n1 vs nvme1n1).
>>     Also adds comprehensive debug logging throughout the test flow and
>>     writes the L2 launch command to a script to avoid terminal line-wrap
>>     issues.
>>
>> 5. Increase the test timeout from 1000 to 6000 seconds to accommodate
>>     the longer runtime due to apk update retries and additional testing.
>>
>> Testing:
>> --------
>> All tests pass on our PPC64 test machines running Ubuntu 26.04 in an
>> LPAR.
>>
>> Aniket Sahu (3):
>>    tests/functional/ppc64: replace deprecated datetime.utcnow()
>>    tests/functional/ppc64: add kernel params and early panic detection
>>    tests/functional/ppc64: dynamically resolve NVMe device path
>>
>> Misbah Anjum N (2):
>>    tests/functional/ppc64: pin machine types for hypervisor tests
>>    tests/functional/ppc64: increase timeout for hypervisor tests
>>
>>   tests/functional/ppc64/meson.build |   2 +-
>>   tests/functional/ppc64/test_hv.py  | 140 +++++++++++++++++++++++++----
>>   2 files changed, 117 insertions(+), 25 deletions(-)

Regards,
Aniket.


