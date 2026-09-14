Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CE6C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6GWO-00021p-9f; Mon, 14 Sep 2026 19:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1x6GWM-00021N-3Q
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:55:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1x6GWK-0004DU-07
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:55:33 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN1XYN1491700; Mon, 14 Sep 2026 23:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=J3Y7WP
 r2dvqMduScZrcGEyqKfY5VAUFLPUTn3kXcdA0=; b=ZB9OWFQIDoZYNvrLEYgUXO
 nBreCJ9lXCsL8hVWNozcd/i0dtbnQFxevWs47sP5KeuzaXN2ysrhFYwiOe93s1IK
 XUlifLvmyyhJDnkYD15kNKgxfG0uixsaXS5+TMUEBZgyRtfLVL/5znpMgW8BVRrw
 10VhY7asHJtJHhB78Td7Iih6TaX22kKFeXxYc67YHCOyOw2ZKVqJ3K2L10vaDCzu
 3KEgnUdCo4Teg3ApGimBMfpCoGRvlJ9IHKZveIeVb4h3QuKd1h9A1IaMz0xjKtA1
 PGLKBo21f3gUAZfjUHyFv7/KnYhMuJ3UkHcPxUaIfn/HhbbTBOd5YzJHHgKpbA2w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq4eum-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 23:55:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN553v3060097; Mon, 14 Sep 2026 23:55:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnjjgrkgy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 23:55:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ENtPJo45416934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 23:55:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC8D6200A2;
 Mon, 14 Sep 2026 23:55:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D3AB200A4;
 Mon, 14 Sep 2026 23:55:25 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.56.140])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 23:55:25 +0000 (GMT)
Message-ID: <178f2862-6110-4b72-9f6c-ef91963a89a9@linux.ibm.com>
Date: Tue, 15 Sep 2026 01:55:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] tests/tcg: improve check for working cross compilers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-3-alex.bennee@linaro.org>
 <22dca41b-3833-45d2-912f-b05a77d7d883@oss.qualcomm.com>
 <aqexk7afMhWLxf3w@redhat.com> <87a4pjddg5.fsf@draig.linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <87a4pjddg5.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMzNyBTYWx0ZWRfX0npcrF3qOoBM
 d2/s1ypu+bR0Aeeg+RpA+jbO+2J6oSECHxfuFEC0mQLVwD3nnoGhOAHXNCetANx+ekwsTvVP7lU
 Qj7vcd4qq53WuiEBuX+NX3oU57X4IQwDVXkGo3FwT+u0ZZHOp0cViKXqLKnlUSJ9uydDrrIUlt1
 lblG0ILCjy+AaY1vkJH3e8UqhRWOdAC2ZizcbSBEl8jUhgoxGy8JwqvXmtjavJ9O7K2ClBWOjJC
 chd6/88ubToo75RovFI37cr2TaBGHS9wCCuJmvSBOWNUfMU+IfaqqDBWdIPtjH0s/U2/ACxstMj
 RraDIX9jNQWCN9j3eXVsyV+IeC/zO3w3ShEI4W3kp3RxF/13GSmg9JZKJQEAtqwmaeYapiGL5eH
 ioCRzszfxhrlzbL5hguivEDkE3Q1O+coBwLnEWeRYqHBBsi+OyqI+dlAviK174pRjckZC0Sq4aL
 fvHryekChWXF1iir/Ow==
X-Proofpoint-GUID: NURemSL9SS1cMoOULp17kygqUxkG7Y7P
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa88970 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=b4LDLZbEAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=YS6Yfe__cX80-eF0oX8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=20T61YgZp4ItGotXEy2O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NURemSL9SS1cMoOULp17kygqUxkG7Y7P
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMzNyBTYWx0ZWRfX7R7S75/JNrZw
 snyHPZBnlb6pIdIMrjDSRYPdAnnlAjTONliKKI9fd0SFyp7fsV20JY3d17HDIzLvqHOJCh93Knk
 5KNedHv20e+FaSfhorGW9t5uJAoZmkw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140337
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/14/26 18:07, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> (trimed cc list, add Ilya)
> 
>> On Sun, Sep 13, 2026 at 10:08:52PM -0700, Pierrick Bouvier wrote:
>>> On 9/10/26 11:14 AM, Alex Bennée wrote:
>>>> From: Daniel P. Berrangé <berrange@redhat.com>
>>>>
>>>> When it finds a cross compiler, tests/tcg/meson.build tries
>>>> building test_cc.c to validate that the compiler works. This
>>>> includes "stdint.h" as a witness for working C library, however,
>>>> that is not a good choice as it can be provided by the toolchain
>>>> alone:
>>>>
>>>>     $ rpm -ql gcc-s390x-linux-gnu  | grep /stdint.h
>>>>     /usr/lib/gcc/s390x-linux-gnu/16/include/stdint.h
>>>>
>>>> As a result, if you install the s390x GCC cross compiler, but
>>>> not any C library, meson decides to use the host compiler instead
>>>> of the container:
>>>>
>>>>       cc for aarch64-softmmu          : aarch64-linux-gnu-gcc (from 'debian-all-test-cross' container)
>>>>       cc for loongarch64-softmmu      : loongarch64-unknown-linux-gnu-gcc (from 'debian-loongarch-cross' container)
>>>>       cc for riscv64-softmmu          : riscv64-linux-gnu-gcc (from 'debian-all-test-cross' container)
>>>>       cc for s390x-softmmu            : s390x-linux-gnu-gcc
>>>>       cc for x86_64-softmmu           : x86_64-linux-gnu-gcc (from 'debian-amd64-cross' container)
>>>>
>>>> Eventually this results in failure to run 'make check':
>>>>
>>>> [33/40] Generating tests/tcg/s390x-softmmu-hello with a custom command
>>>> FAILED: [code=1] tests/tcg/s390x-softmmu-hello.test
>>>> /usr/bin/s390x-linux-gnu-gcc /home/berrange/src/virt/qemu/tests/tcg/multiarch/system/hello.c -o tests/tcg/s390x-softmmu-hello.test -static -MMD -MF tests/tcg/s390x-softmmu-hello.d -Wall -Werror -O0 -g -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I /home/berrange/src/virt/qemu/tests/tcg/s390x/system/../../minilib /home/berrange/src/virt/qemu/tests/tcg/s390x/system/../../minilib/printf.c -I /home/berrange/src/virt/qemu/include/hw/s390x/ipl -march=z13 ../tests/tcg/s390x/system/../head64.S ../tests/tcg/s390x/system/../console.c
>>>> In file included from ../tests/tcg/s390x/system/../console.c:8:
>>>> ../tests/tcg/s390x/system/../../../../pc-bios/s390-ccw/sclp.c:11:10: fatal error: string.h: No such file or directory
>>>>      11 | #include <string.h>
>>>>         |          ^~~~~~~~~~
>>>> compilation terminated.
>>>>
>>>> Adding more include files to the test program ensures the
>>>> meson probe makes a better decision.
>>>>
>>>> Fixes: e5d084d622b1 (tests/tcg/meson.build: check host cross cc is working)
>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> Message-ID: <20260910100120.2076092-1-berrange@redhat.com>
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>> ---
>>>>    tests/tcg/test_cc.c | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
>>>> index d3614a01fe6..fafee055b40 100644
>>>> --- a/tests/tcg/test_cc.c
>>>> +++ b/tests/tcg/test_cc.c
>>>> @@ -1,7 +1,11 @@
>>>>    /* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> -/* Include a standard header to make sure cross compiler provides them */
>>>> +/* Use some standard headers to ensure the cross compiler provides them */
>>>>    #include <stdint.h>
>>>> +#include <string.h>
>>>> +#include <stdbool.h>
>>>> +#include <stddef.h>
>>>> +#include <stdio.h>
>>>>    int main(void)
>>>>    {
>>>
>>> Ideally, we should do separate tests for system vs user tests.
>>> System ones are always compiled with -ffreestanding, while user ones should
>>> provide a C library.
>>>
>>>  From this standard:
>>>
>>> https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2023/p2338r3.html
>>> ```
>>> A freestanding C implementation is required to provide the entirety of the
>>> following headers:
>>>
>>> <float.h>
>>> <iso646.h>
>>> <limits.h>
>>> <stdalign.h>
>>> <stdarg.h>
>>> <stdbool.h>
>>> <stddef.h>
>>> <stdint.h>
>>> <stdnoreturn.h>
>>> Most of <string.h> is required (strdup, strndup, strcoll, strxfrm, and
>>> strerror are excluded). This includes strtok, which requires global data.
>>> ```
>>>
>>> Maybe for now we can just remove stdio.h from current patch, as it's not
>>> supposed to be provided in a freestanding environment.
>>
>> A huge number of files under tests/tcg/ have a #include <stdio.h>
>> currently.
> 
> They are all *-user mode tests though, which do need a proper libc.
> 
>>
>> In the example build failure in the commit message, we have
>>
>>    tests/tcg/s390x/system/../console.c
>>
>> which does
>>
>>    #include "../../../pc-bios/s390-ccw/sclp.c"
>>
>> and sclp.c has
>>
>>    #include "s390-ccw.h"
>>
>> and that header has:
>>
>>    #include <stdbool.h>
>>    #include <stddef.h>
>>    #include <stdint.h>
>>    #include <stdio.h>
>>
>> hence the 4 headers I added to the meson check.
>>
>> So AFAICT, our code is expecting stdio.h to be provided in a
>> -ffreestanding build. Have we got a more fundamental mistake
>> wrt our use of -ffreestanding, such that it is relying on
>> unintended functionality ?
> 
> They shouldn't - but s390x seems to be doing something funky here. Ilya
> can you explain what s390x is trying to do here?

s390x used to use SLOF headers before the meson rework.
I remember that Pierrick mentioned there were issues with checking out
the SLOF submodule, but it seems to work for me.
So I've posted my version of the fix [1], please take a look.

[1] 
https://lore.kernel.org/qemu-devel/20260914235113.272992-1-iii@linux.ibm.com/

> 
>>
>> With regards,
>> Daniel
> 


