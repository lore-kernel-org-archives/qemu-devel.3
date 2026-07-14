Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3FBC44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 18:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjhmS-00028x-Kf; Tue, 14 Jul 2026 14:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjhmI-00028R-GO
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:22:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjhmG-0000Yi-Hl
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:22:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EGCIic1727079; Tue, 14 Jul 2026 18:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qVfRHP
 hUd2dpCr1fyY0KgafGNrF/qRus4pDmgIOhNto=; b=aD0yDai9gs9G89DnHeEc0Q
 Iu+dztHSIcLMiAmvVWnQJlsrEZWoQelz4qKSQRVo9bB57sfy2XU/XOF3joIBvrv6
 fnMQBNIfy0VaYRU3puQg+IAU6515DMrW+FswHC3n/hU+l9awQU1xI7XGOf12nZps
 MRJaELvVkEhPvv27xBXsqipDETrgyzRJDD63cSgdEhzWnPM29n2o2emKDLFKyuM/
 8Du4gLauwMgu4ooahyddszXK32DHA5h5eRrs3Qs8xgz6qmcxtgkQBMjXJVK2lWkF
 hue2sa+xRScXnmQA6Tbyt1zV8dAnhd/9xpJTPZEVVW0P6bIv0CNUL9zWSRnv4nTw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a75w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 18:22:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EI4bhI001679;
 Tue, 14 Jul 2026 18:22:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jv4yw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 18:22:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EIMduv52166936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 18:22:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CD9F2004B;
 Tue, 14 Jul 2026 18:22:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4242B20040;
 Tue, 14 Jul 2026 18:22:38 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.27.233])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 18:22:38 +0000 (GMT)
Message-ID: <3a4c0e61-23d3-4baa-878c-a31c7fc2a8c8@linux.ibm.com>
Date: Tue, 14 Jul 2026 20:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 82/98] tests/tcg/s390x: user tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-83-pierrick.bouvier@oss.qualcomm.com>
 <584dbebe-6105-45a6-ae4d-d0fb4fc6eaaf@linux.ibm.com>
 <24690de5-8178-41bf-94f6-cd383f599b2a@oss.qualcomm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <24690de5-8178-41bf-94f6-cd383f599b2a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX0+TjMwqro1OE
 YY2g97+M5UVL6wfIysZa+LUuQMLGXg7jZXwSzUzB+98gtrtSAT0em5b+BE626E5Xuo4x+kexYta
 4aFWXYXmVzPjMmU+EEimh2E04VYqk5A=
X-Proofpoint-GUID: ElKVREdY-EhfnTLV7A_EzD68uGbyaTP_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX8HfxlUdaQNS3
 O8f6AzVcZcYTwdLWt85ggpTYHgh7OKOf4uoO3aVExzZQ9JOHDwvhgKZrjKL0rp0vsT+k198APA8
 ZK9mac/gxHxNMB4up0o8k+2IBybBXxSiaSy65IOm5bxMiOSeSx8xRHdqQxm7LN9uhWehR3upAO/
 Rq1cOz+FGgLDMMixqp9UfvtzUBvYKjHatL8sAfXlwLayvLhJyTlvuNyL39xvpT/HKpP4EhEqVz5
 kWfUku2Oo6ChPdZN6JitQkQlHAuF8cE3K5O80vMg/V7kdxUDvpYJLuF1lwntbTjFmHaudl1jMEu
 gi7xuRODFPLn+2P4yG7KOzJe9d0iuMS+3bEDQauwmhx4OyUcr+CAbhx1daj6Yyg2Rw8GQyYbyLm
 2xK8s2vvle0RMmfLu5h2ZQd+djUNI9j1/faNPsrvM1ArnQ96XwpbReJJdJFTygkp10pUBclya+K
 Vlrff++m+v54xplUdCA==
X-Proofpoint-ORIG-GUID: DPf7GMGpemC0m_jwVj3M4MQG1bLeGNoC
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a567e72 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=EUspDBNiAAAA:8
 a=NNwXQtxxdktGI4-D13UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140188
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 7/14/26 17:43, Pierrick Bouvier wrote:
> On 7/14/2026 1:54 AM, Ilya Leoshkevich wrote:
>>
>>
>> On 7/10/26 23:43, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>    tests/tcg/meson.build           |   1 +
>>>    tests/tcg/s390x/Makefile.target | 127 -----------------------------
>>>    tests/tcg/s390x/meson.build     | 138 ++++++++++++++++++++++++++++++++
>>>    3 files changed, 139 insertions(+), 127 deletions(-)
>>>    delete mode 100644 tests/tcg/s390x/Makefile.target
>>>    create mode 100644 tests/tcg/s390x/meson.build
>>
>> In general the s390x tests work now, however, I get:
>>
>> 155/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-fma
>>                                          SKIP             0.09s   exit
>> status 77
>> 156/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vfminmax
>>                                          SKIP             0.07s   exit
>> status 77
>> 157/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vs
>>                                          SKIP             0.06s   exit
>> status 77
>> 158/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vcvt
>>                                          SKIP             0.06s   exit
>> status 77
>> 159/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vlstr
>>                                          SKIP             0.05s   exit
>> status 77
>> 160/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vstrs
>>                                          SKIP             0.04s   exit
>> status 77
>>
>> with the series. Without the series these tests do run:
>>
>>    TEST    fma on s390x
>>    TEST    vfminmax on s390x
>>    TEST    vxeh2_vcvt on s390x
>>    TEST    vxeh2_vlstr on s390x
>>    TEST    vxeh2_vstrs on s390x
>>    TEST    vxeh2_vs on s390x
>>
> 
> Can you please run one of the test in verbose?
> It will print the reason why it was skipped.
> $ ./build/pyvenv/bin/meson test -C build \
> s390x-linux-user-vxeh2_vcvt --verbose

$ ./build/pyvenv/bin/meson test -C build \
s390x-linux-user-vxeh2_vcvt --verbose
1/1 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vcvt RUNNING 

 >>> 
UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 
MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 
ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 
MESON_TEST_ITERATION=1 RUST_BACKTRACE=1 MALLOC_PERTURB_=146 /usr/bin/env 
sh -c 'echo "compiler feature z15 not supported" && exit 77'
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― 
✀ 
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
compiler feature z15 not supported

> I guess the cross compiler is not detected, and we need to find why.
> With following questions, we should know what's missing.
> 
> - Do you have s390x-linux-gnu-gcc installed?

Yes.

> 
> - Does this command work?
> $ s390x-linux-gnu-gcc -static -o /dev/null tests/tcg/test_cc.c

$ s390x-linux-gnu-gcc -static -o /dev/null tests/tcg/test_cc.c
In file included from tests/tcg/test_cc.c:3:
/usr/lib/gcc/s390x-linux-gnu/16/include/stdint.h:11:16: fatal error: 
stdint.h: No such file or directory
    11 | # include_next <stdint.h>
       |                ^~~~~~~~~~

Apparently it's the same issue. Fedora doesn't ship cross glibc headers.

> - Do you have podman or docker installed?

Yes.

> 
> - What is the output of this command?
> $ ./tests/docker/docker.py probe

$ ./tests/docker/docker.py probe
docker

> 
> Regards,
> Pierrick


