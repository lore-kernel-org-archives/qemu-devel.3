Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB49C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 18:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjhzh-0000jC-VT; Tue, 14 Jul 2026 14:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjhza-0000hv-RW
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:36:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjhzY-0002iy-Rw
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:36:30 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EGCDHr1786328; Tue, 14 Jul 2026 18:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bw4SjM
 e4zGF0X+rAm34m0Ay5Q7eTyOU4pydGtNNrRps=; b=bkUhljZZR18B6qQrTiSIJW
 rSUq37NVTmeHrc9629pc8RA6Nsycr3tBkV9YPX5Tj77yHRq/gTrJJ1phcwbRUA6j
 XkwY7q6k4em/c1zzdDMmcD2iIvsIwmbnQ7+dkk6/nBJWvaEV6/GbfCheUaHySnZT
 KwzoI/zR6uEXaSvUscKVh3tZ8b+MlQxqqsc+UN7nXQ+g/ViCoiGLrBntih+2qZAV
 IqHwyD1ppfOYvmQ73A19fxLWSzKysjzNZVjmVvpC+gbNkCyMEGLelbAPEsMQmTBR
 ImrtNEV65Q4Sn03kJoI703bKlHKuUxDjZibYJvkQCfi7zL7gvxdU6YJ40MY8R8DQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbq8v6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 18:36:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EIYaAC015001;
 Tue, 14 Jul 2026 18:36:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy3w59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 18:36:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EIaNVM50069940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 18:36:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F31820043;
 Tue, 14 Jul 2026 18:36:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F10CF20040;
 Tue, 14 Jul 2026 18:36:22 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.27.233])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 18:36:22 +0000 (GMT)
Message-ID: <fd573325-c8bc-458a-bbe2-041d4e6e3206@linux.ibm.com>
Date: Tue, 14 Jul 2026 20:36:22 +0200
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
 <3a4c0e61-23d3-4baa-878c-a31c7fc2a8c8@linux.ibm.com>
 <62ec55ea-59c4-4b70-8e12-c04bb0cb998e@oss.qualcomm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <62ec55ea-59c4-4b70-8e12-c04bb0cb998e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a5681aa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=EUspDBNiAAAA:8
 a=wS49S6NDasQa3zVQveMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfXzHyz7hPk5GrB
 2wEyYkuVXt+GpfYYdEIV8iYMcBnKxSO7rbEclaYN9IzVPozBPfK8k90ZW7kBEie6vCHQ48ISutD
 OrZXq71N+242RM341BrDNqC1FGIpx7WhMgTE9M+eOsJpM2RxBbmx5z6CNFpmgtVsFHCAFW2Ljcq
 /9vDRTrdAmFYyzobzBxoWLsaFgqeb74eUNVvjvggFJviSQx83Buj7onR0FfYj+/DVN5auhJK2kJ
 TN7GGlZsn+VC9cfOjJ/Qkyc5SZZzGyPtEFOxPYHyUUoPybuBxcn4FErRmw9WOQ+HTHWIF3HuzYn
 RoxowvDK2xB54K7jNjXT5f2MZHBrlCom2z6/1bFzFUO7W73XLhFUMa31wSmk/83DCuYg9LrTz9K
 GHyCb22vjjGqVJEmAoqIfNhUFUnmdLyXoR4+p6Qkj0upwpBbKP5EQaitWDmHe8mTAAORPT5AAXl
 Z8690DSgvHUGgKs9Xjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfXwSGAXYhn+jV3
 tyzXIx4JaIdAywtDymNKKqi27BaTx89cVyfEKfjMFYExM2A60DjBPUlVIAAAlV+Rl0U+1gdw/g5
 gYtckeG9d1TAfi8cXleasgvm+Bf4aMo=
X-Proofpoint-GUID: 1XPV0X2FsKU3nk5DKv2bIsEu3qJX5qcG
X-Proofpoint-ORIG-GUID: K8oVeSZK0p4lxaCP1xUWxq0rNNegZFyN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140188
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



On 7/14/26 20:33, Pierrick Bouvier wrote:
> On 7/14/2026 11:22 AM, Ilya Leoshkevich wrote:
>>
>>
>> On 7/14/26 17:43, Pierrick Bouvier wrote:
>>> On 7/14/2026 1:54 AM, Ilya Leoshkevich wrote:
>>>>
>>>>
>>>> On 7/10/26 23:43, Pierrick Bouvier wrote:
>>>>> Signed-off-by: Pierrick Bouvier
>>>>> <pierrick.bouvier@oss.qualcomm.com> --- tests/tcg/
>>>>> meson.build           |   1 + tests/tcg/s390x/Makefile.target
>>>>> | 127 ----------------------------- tests/tcg/s390x/
>>>>> meson.build     | 138 +++++++++++++++++++++++++++ +++++ 3
>>>>> files changed, 139 insertions(+), 127 deletions(-) delete mode
>>>>> 100644 tests/tcg/s390x/Makefile.target create mode 100644
>>>>> tests/tcg/s390x/meson.build
>>>>
>>>> In general the s390x tests work now, however, I get:
>>>>
>>>> 155/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-fma
>>>> SKIP             0.09s   exit status 77 156/164 tcg+tcg-s390x-
>>>> linux-user - qemu:s390x-linux-user-vfminmax SKIP
>>>> 0.07s   exit status 77 157/164 tcg+tcg-s390x-linux-user -
>>>> qemu:s390x-linux-user-vxeh2_vs SKIP             0.06s   exit
>>>> status 77 158/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-
>>>> user-vxeh2_vcvt SKIP             0.06s   exit status 77 159/164
>>>> tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vlstr
>>>> SKIP             0.05s   exit status 77 160/164 tcg+tcg-s390x-
>>>> linux-user - qemu:s390x-linux-user-vxeh2_vstrs SKIP
>>>> 0.04s   exit status 77
>>>>
>>>> with the series. Without the series these tests do run:
>>>>
>>>> TEST    fma on s390x TEST    vfminmax on s390x TEST
>>>> vxeh2_vcvt on s390x TEST    vxeh2_vlstr on s390x TEST
>>>> vxeh2_vstrs on s390x TEST    vxeh2_vs on s390x
>>>>
>>>
>>> Can you please run one of the test in verbose? It will print the
>>> reason why it was skipped. $ ./build/pyvenv/bin/meson test -C
>>> build \ s390x-linux-user-vxeh2_vcvt --verbose
>>
>> $ ./build/pyvenv/bin/meson test -C build \ s390x-linux-user-
>> vxeh2_vcvt --verbose 1/1 tcg+tcg-s390x-linux-user - qemu:s390x-linux-
>> user-vxeh2_vcvt RUNNING
>>>>>
>> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
>> MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
>> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1
>> MESON_TEST_ITERATION=1 RUST_BACKTRACE=1 MALLOC_PERTURB_=146 /usr/bin/
>> env sh -c 'echo "compiler feature z15 not supported" && exit 77'
>> ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
>> ✀
>> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
>>   compiler feature z15 not supported
>>
>>> I guess the cross compiler is not detected, and we need to find
>>> why. With following questions, we should know what's missing.
>>>
>>> - Do you have s390x-linux-gnu-gcc installed?
>>
>> Yes.
>>
>>>
>>> - Does this command work? $ s390x-linux-gnu-gcc -static -o /dev/
>>> null tests/tcg/test_cc.c
>>
>> $ s390x-linux-gnu-gcc -static -o /dev/null tests/tcg/test_cc.c In
>> file included from tests/tcg/test_cc.c:3: /usr/lib/gcc/s390x-linux-
>> gnu/16/include/stdint.h:11:16: fatal error: stdint.h: No such file
>> or directory 11 | # include_next <stdint.h> |
>> ^~~~~~~~~~
>>
>> Apparently it's the same issue. Fedora doesn't ship cross glibc
>> headers.
>>
> 
> And we should skip using it thus.
> 
>>> - Do you have podman or docker installed?
>>
>> Yes.
>>
>>>
>>> - What is the output of this command? $ ./tests/docker/docker.py
>>> probe
>>
>> $ ./tests/docker/docker.py probe docker
>>
>>>
>>> Regards, Pierrick
>>
> 
> It seems like local compiler was taken even though it's not working,
> which should not happen.
> 
> Double checking the part checking this, there was a typo on my side.
> Sorry, I checked this in fedora, refactored after and missed it.
> 
> Could you please try with following change?
> It should correctly use container version and compile binaries without
> checking if feature is supported.
> 
> ```
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -192,7 +192,7 @@ foreach target, plan: tcg_tests
>       cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/
> dev/null'],
>                         check: false)
>       avail = cmd.returncode() == 0
> -    cc_from_system = has_cc
> +    cc_from_system = avail
>       has_cc = avail
>     endif
> ```
> 
> Regards,
> Pierrick

Perfect, now it works. Thanks!

142/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-fma 
                                         OK               0.04s
143/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-sha512-mvx 
                                         OK               0.04s
144/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vfminmax 
                                         OK               0.04s
145/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vs 
                                         OK               0.03s
146/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vcvt 
                                         OK               0.03s
147/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vlstr 
                                         OK               0.02s
148/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vstrs 
                                         OK               0.02s


