Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0CAFED2FE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 10:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0d1j-0004J8-A1; Thu, 12 Mar 2026 06:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1w0d1d-0004I2-8U; Thu, 12 Mar 2026 06:12:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1w0d1b-0003QQ-GQ; Thu, 12 Mar 2026 06:12:17 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62C3SiMN2853554; Thu, 12 Mar 2026 10:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xBI8GH
 S3yM21JLVvcbHS8HPbOhCOH+2o9uKyb3CS7c4=; b=jcPUfmLYyBJSrftcnGhnSg
 VPVhjli7uhJPDBxHQ92tf9mRWLt3y+i7uAQru+LFQCJK7r95JmZPtAJCf+qTMA+o
 CpRzejO5Z2NBlqPg1FCKrUaL88+tb01lAZ5VQX+vWZIFjgsczZjdvbWKwqXhz7Kh
 57Lw6VrXPdO2tG60jGl8Dwih/qVXkwORlQh+VgbTFgG2YQrPYPy0oOj7dYRiWv9J
 myJQEjdSfoB5fC1y2Vn7dfhijU8u9w0y07m6A0NdVjSFoLubLFU2BVwMni+DZ8xJ
 m7BTaIkRvGIidd1815a9ROoxqjx7f8C7bvBB2+4LBeUrrlaNidcso7YupkJ1Ou9g
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91j3w1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Mar 2026 10:11:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C9jVSU020802;
 Thu, 12 Mar 2026 10:11:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9hv18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Mar 2026 10:11:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62CABuVD49545628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2026 10:11:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75B2E2004F;
 Thu, 12 Mar 2026 10:11:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D57DB2004D;
 Thu, 12 Mar 2026 10:11:55 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.88.140])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Mar 2026 10:11:55 +0000 (GMT)
Message-ID: <c776bbc1-6021-45d0-a5ca-74e50d906f4f@linux.ibm.com>
Date: Thu, 12 Mar 2026 11:11:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tests/docker: add gdb-multiarch to all-test-cross
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-2-alex.bennee@linaro.org>
 <78c8b024-6dd5-4f1b-a19c-c7a71c7acc9f@linaro.org>
 <7e6cdb4b-4cb8-4968-acce-56db2f0ee307@linaro.org>
 <97506340-18a4-4691-8017-110ab2fc76b8@linaro.org>
 <3c2bf09d-245c-4de7-b55d-37085ef24545@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <3c2bf09d-245c-4de7-b55d-37085ef24545@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: alHXxI1I6TJ9TjST1ukU8HYU1ekFO1b4
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b2916f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=3_ro50KVStqSI-_O7f4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA3OCBTYWx0ZWRfX1VR3nCwZzwkK
 ZBSztEiRG/2Bw4ojyzm/F6gUJne8vtwrYgcCSfOfHcbBqoH7L2OL/xi+K/wuZE7WvJcA6kn2dcv
 2DzN0XvQoZhIe+vYj+1JRRme78XSCSss3UTOjFGWE4uFhpRbRGlh5SNqr8Uro2yWs14E9oBvyRz
 PjmlB5ZxMbxTvDKRWGO97C8TlICAaJsvOhjkYHKVxztwvax3lwOQw7xCA0AlZAW+3p6mBxrF/tX
 qcbYdre8zh/8djnH3hTBYWBvHCJ8GlVnrLl+5B6zr5xmbnj9sgTlc9a/dF78pmjAKcUuRAkspII
 oEiFheg4Ipcy9i5/jW5qgqae+YWj0IhJGOrKGlsyEZDC3J2QVS7IcyXJtnPTv26AlO9pWmMBouD
 bB3tKy07udF1dWCLzPetHV6N60BsTPjCicMzy1ATgvD8vJ95bmq9NoCf2tD9p6Zmxx9BYWlfrp0
 rKwgleLyhzDrz/ys/tg==
X-Proofpoint-ORIG-GUID: alHXxI1I6TJ9TjST1ukU8HYU1ekFO1b4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120078
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/11/26 00:28, Philippe Mathieu-Daudé wrote:
> On 11/3/26 00:22, Pierrick Bouvier wrote:
>> On 3/10/26 4:07 PM, Philippe Mathieu-Daudé wrote:
>>> On 10/3/26 23:33, Philippe Mathieu-Daudé wrote:
>>>> On 6/3/26 17:17, Alex Bennée wrote:
>>>>> This allows the gdb integration tests to be run as well.
>>>>>
>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>> ---
>>>>>    tests/docker/dockerfiles/debian-all-test-cross.docker | 1 +
>>>>>    tests/lcitool/refresh                                 | 1 +
>>>>>    2 files changed, 2 insertions(+)
>>>>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> I'm getting:
>>>
>>> Python Exception <class 'gdb.MemoryError'>: Cannot access memory at
>>> address 0x45001fff
>>> Error occurred in Python: Cannot access memory at address 0x45001fff
>>> qemu-hppa: QEMU: Terminated via GDBstub
>>> make[1]: ***
>>> [/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121:
>>> run-gdbstub-prot-none] Error 1
>>> make[1]: *** Waiting for unfinished jobs....
>>> qemu-hppa: QEMU: Terminated via GDBstub
>>> warning: Could not load shared library symbols for linux-vdso32.so.1.
>>> Do you need "set solib-search-path" or "set sysroot"?
>>> make: *** [/builds/philmd/qemu/tests/Makefile.include:66:
>>> run-tcg-tests-hppa-linux-user] Error 2
>>>
>>
>> To add more information, we tested it on GitHub, our machines and 
>> GitLab, and for an unknown reason, it only fails on GitLab runners.
>
> Also we tested on our local Linux machines, where this test pass
> for all our targets ;)
>
>>
>> Which is unfortunate since it is where QEMU run its CI.
>>
>> Regards,
>> Pierrick
>
FWIW it passes on my laptop as well.

Does this test fail only for hppa, or for other architectures as well?

I'm asking because it may have something to do with /proc/self/mem or 
with the architecture.


