Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B6AC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Gvi-0005Es-I8; Mon, 14 Sep 2026 20:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6Gvg-0005EN-Bz
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:21:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6Gvd-00009h-NL
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:21:43 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EMxdvB1983822
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /KVdwbkcK4eyt0tZyNmoCW3c9cx4HAPpYbCW04+agWk=; b=eM8ivh2LJ9X6AGmi
 uPTVqrI5AL0OoSY9Etf8XCzAmpzLUJl1tAgzMBeOdMa2qA3756cRq1KpyKATje8q
 FbMb4QuACyB97buh00OE7+4dK1QKHDFkQdswO/gQjvsOStyY2Cnx4C8SWwmmaFMw
 ScIddKINQFkGYn1rQiDeYugSESlgPNL0319tGP58TV7uxC+eOSj3Xds+vOILn11X
 UqbkiQVlUaep+qroBGBI2KKik5AziO+e1GGAaB5x9miunPHMzFcC/Syw7hOvnn9n
 fCfVvTdzNq09kYGexJR6X51kFIZc4XuzUcCaqTXcfkyI+AcXQPPk6wqwJy3DJcNo
 A3PqXg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpnet18kp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:21:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2dd1631d291so43102475ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789431699; x=1790036499; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/KVdwbkcK4eyt0tZyNmoCW3c9cx4HAPpYbCW04+agWk=;
 b=km/Ncnwb30INqLxebhhWMynMhI9atDK7+fHS1lH4AYInSTacMa+J2XnU/Z5jhBMJ1C
 603g2ZOBZ7qLdWI9rU1Xt9/VT95ISZSBP1Edh+ci3wJ5bi7NJLLcQpEZweBxt3VIPGd+
 PWw903rlLcoJOGM0++mCE+0OKSREpIFQwpF4/NSm4bJgNQiIuaSPho9MOYu5OZYgouht
 ZAhUqXGPoOVaHlpa30Y5bBmAZIrU7Fv+8eskoqJ4hxZe0sqadWNQIpwLMKBAMz3cKsR4
 oNZk5rarBg57HJcoTnyUMR1zZPqGBDGUgMqamdn2sWWCVm5FqILJAHqkuj9ptBZBXLXW
 7I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789431699; x=1790036499;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/KVdwbkcK4eyt0tZyNmoCW3c9cx4HAPpYbCW04+agWk=;
 b=0Z+u0oKaxoC+dr3bHrm6vYUVPWrCrqb+rLXpcZXHsnW4qsF0FQSZ83j7O34CqetWPr
 fhi3CwCKsLq2g0QvI28GR2sHgOButONP0KlgZ/UaB+3fOsBWpPNrSvSr+/ur4qj6045u
 o8h86YlACDXeeJ0wYHEfiUF8bqAM+UgEgt895yVeCYCZMVWPUsXtmjYOKoZStHqizMc3
 d5YClYaFYoOXEckoFjLHdZF1uEhqpusWTJHHNM9L8f5ObsI4vXwy/H5KUSZENdMcPHM3
 k9Swn/FQF2PE2gM7Usl7TGbzCrmQ06PZ9vU9uGYLvObgLwi4H6lhrdtjj6fjo4HTST2f
 GYoA==
X-Gm-Message-State: AFuF++lEfW3uh4mWaUzJQrWx+6O+7xpZl79TySCUI9bgZ4FyNLbWbTrQ
 MtarKxisXqrdHZtV13gZSIUS/RtTeC+3Zo9gGny05pTD8N5uSVBGizgpWDxA/z8XnpeF6mA5Qkv
 q4RGnHKhldUFcrNVWIOGJupAtAxQi5sOXQ7T/O3oyQIxKnCp6noCaz8gISA==
X-Gm-Gg: AYBFou21+lAcJvVZs3FYtzCc+Em1i9hJ7d7Yka8veK7jKF19cM2jP9xzVDnwVh5lOGc
 72HHsUXo70Z4oXNPz6ieo5ct0nSkOHbPbazsA9Gw35cfEuh0DSb7ZR/LQJ4PxEY57jK3yphPSLN
 d4agfyOvGFFp9Wss5mnmYRmsZGIVD5a6AdDvDP/x8+Al2SzjbrjYcKcUMkb/zJ9Y/EjOBQwJjMj
 bBGwIvNjyoohoR/HxwJquj8JotZpUVbxRmtlxc/Zbhx5AoEliO3qxVBqwDdvMHTSnKaypFjRDqe
 ZCPsCr91XPnLuaLmYxYqquR1kb2+A+or4DqQHchIHYzgOlgqEVu8LMd+L6aZZUuM8WST8f7fzsp
 ElzGhIHw2YOKIgsA605e6eMSOlhbg0X0h9AKuFgLG3Uste70Hn78991tuN5y2fy1BpO7f
X-Received: by 2002:a17:90a:d008:b0:39d:f5b1:e35f with SMTP id
 98e67ed59e1d1-39df5b1e456mr6653721a91.25.1789431698560; 
 Mon, 14 Sep 2026 17:21:38 -0700 (PDT)
X-Received: by 2002:a17:90a:d008:b0:39d:f5b1:e35f with SMTP id
 98e67ed59e1d1-39df5b1e456mr6653659a91.25.1789431697853; 
 Mon, 14 Sep 2026 17:21:37 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b97994sm51576578c88.12.2026.09.14.17.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 17:21:37 -0700 (PDT)
Message-ID: <091273a3-a78a-4948-9400-0764323a3988@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 17:21:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] tests/tcg: improve check for working cross compilers
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-3-alex.bennee@linaro.org>
 <22dca41b-3833-45d2-912f-b05a77d7d883@oss.qualcomm.com>
 <aqexk7afMhWLxf3w@redhat.com> <87a4pjddg5.fsf@draig.linaro.org>
 <178f2862-6110-4b72-9f6c-ef91963a89a9@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <178f2862-6110-4b72-9f6c-ef91963a89a9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwMyBTYWx0ZWRfX6spfeUDIrwSV
 o5yDGCvOhnzgLb+79hq/Ha9C839DRssUMPr4JIVfTG7BSnroUvrfFm1ZzMoAD/YmkonCk+MlPls
 IqKDRuf/V3dZr8f5ZBOaPu8NEnQi2KQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwMyBTYWx0ZWRfXxQ0NrzAQ/QcK
 DZbDTCq3vg/WxhTMIVCt1w84anhbJxjrrjC1o+gtl2z5OIDdhgBwHpS3gzf+VWu+8rozIlutsFA
 jMAitHoVvizzHoAMzf3Im5Kndc+9G+d8YLe8T/728TGtQHDsuztsdfISeXFInpYfRgan03gV5qO
 9N95Dp744Fhei43OVIjfrPcZrxvfb1d/9d4zAo9D8L0wzRv2CJTDwKKKEsx00kRpYqq4HDq9rGe
 hchjTES3895MWmMioGBuvRbb5/LS74mctyapSvBownZVaMSjNIO4GnRa8iztBT0V1Bj8UFl4w7s
 OF64ugsrqTr38SFbLSTiY3XWAywG3GCY6tkxwPCFDWsHX+RTTui3PeOTJq+mvf1QwatSaaecqiX
 3UC6MuA7dmCsrpx95FCqhcZdYrb86hNwAKbgp296usCboz2i3gT4YsdgkbThtsxiulGDcDve5gr
 bfTQJ6L+xurUXWfdsGQ==
X-Authority-Analysis: v=2.4 cv=PKKaavqC c=1 sm=1 tr=0 ts=6aa88f93 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=b4LDLZbEAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=G12K5T6oz_a9BqPcWhgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=20T61YgZp4ItGotXEy2O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0Wuu3RmRT9r3KSdnaXp7uNMXg55xmifa
X-Proofpoint-ORIG-GUID: 0Wuu3RmRT9r3KSdnaXp7uNMXg55xmifa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150003
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 9/14/2026 4:55 PM, Ilya Leoshkevich wrote:
> 
> 
> On 9/14/26 18:07, Alex Bennée wrote:
>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>
>> (trimed cc list, add Ilya)
>>
>>> On Sun, Sep 13, 2026 at 10:08:52PM -0700, Pierrick Bouvier wrote:
>>>> On 9/10/26 11:14 AM, Alex Bennée wrote:
>>>>> From: Daniel P. Berrangé <berrange@redhat.com>
>>>>>
>>>>> When it finds a cross compiler, tests/tcg/meson.build tries
>>>>> building test_cc.c to validate that the compiler works. This
>>>>> includes "stdint.h" as a witness for working C library, however,
>>>>> that is not a good choice as it can be provided by the toolchain
>>>>> alone:
>>>>>
>>>>>     $ rpm -ql gcc-s390x-linux-gnu  | grep /stdint.h
>>>>>     /usr/lib/gcc/s390x-linux-gnu/16/include/stdint.h
>>>>>
>>>>> As a result, if you install the s390x GCC cross compiler, but
>>>>> not any C library, meson decides to use the host compiler instead
>>>>> of the container:
>>>>>
>>>>>       cc for aarch64-softmmu          : aarch64-linux-gnu-gcc (from
>>>>> 'debian-all-test-cross' container)
>>>>>       cc for loongarch64-softmmu      : loongarch64-unknown-linux-
>>>>> gnu-gcc (from 'debian-loongarch-cross' container)
>>>>>       cc for riscv64-softmmu          : riscv64-linux-gnu-gcc (from
>>>>> 'debian-all-test-cross' container)
>>>>>       cc for s390x-softmmu            : s390x-linux-gnu-gcc
>>>>>       cc for x86_64-softmmu           : x86_64-linux-gnu-gcc (from
>>>>> 'debian-amd64-cross' container)
>>>>>
>>>>> Eventually this results in failure to run 'make check':
>>>>>
>>>>> [33/40] Generating tests/tcg/s390x-softmmu-hello with a custom command
>>>>> FAILED: [code=1] tests/tcg/s390x-softmmu-hello.test
>>>>> /usr/bin/s390x-linux-gnu-gcc /home/berrange/src/virt/qemu/tests/
>>>>> tcg/multiarch/system/hello.c -o tests/tcg/s390x-softmmu-hello.test
>>>>> -static -MMD -MF tests/tcg/s390x-softmmu-hello.d -Wall -Werror -O0
>>>>> -g -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack
>>>>> -I /home/berrange/src/virt/qemu/tests/tcg/s390x/system/../../
>>>>> minilib /home/berrange/src/virt/qemu/tests/tcg/s390x/system/../../
>>>>> minilib/printf.c -I /home/berrange/src/virt/qemu/include/hw/s390x/
>>>>> ipl -march=z13 ../tests/tcg/s390x/system/../head64.S ../tests/tcg/
>>>>> s390x/system/../console.c
>>>>> In file included from ../tests/tcg/s390x/system/../console.c:8:
>>>>> ../tests/tcg/s390x/system/../../../../pc-bios/s390-ccw/
>>>>> sclp.c:11:10: fatal error: string.h: No such file or directory
>>>>>      11 | #include <string.h>
>>>>>         |          ^~~~~~~~~~
>>>>> compilation terminated.
>>>>>
>>>>> Adding more include files to the test program ensures the
>>>>> meson probe makes a better decision.
>>>>>
>>>>> Fixes: e5d084d622b1 (tests/tcg/meson.build: check host cross cc is
>>>>> working)
>>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>> Message-ID: <20260910100120.2076092-1-berrange@redhat.com>
>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>> ---
>>>>>    tests/tcg/test_cc.c | 6 +++++-
>>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
>>>>> index d3614a01fe6..fafee055b40 100644
>>>>> --- a/tests/tcg/test_cc.c
>>>>> +++ b/tests/tcg/test_cc.c
>>>>> @@ -1,7 +1,11 @@
>>>>>    /* SPDX-License-Identifier: GPL-2.0-or-later */
>>>>> -/* Include a standard header to make sure cross compiler provides
>>>>> them */
>>>>> +/* Use some standard headers to ensure the cross compiler provides
>>>>> them */
>>>>>    #include <stdint.h>
>>>>> +#include <string.h>
>>>>> +#include <stdbool.h>
>>>>> +#include <stddef.h>
>>>>> +#include <stdio.h>
>>>>>    int main(void)
>>>>>    {
>>>>
>>>> Ideally, we should do separate tests for system vs user tests.
>>>> System ones are always compiled with -ffreestanding, while user ones
>>>> should
>>>> provide a C library.
>>>>
>>>>  From this standard:
>>>>
>>>> https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2023/p2338r3.html
>>>> ```
>>>> A freestanding C implementation is required to provide the entirety
>>>> of the
>>>> following headers:
>>>>
>>>> <float.h>
>>>> <iso646.h>
>>>> <limits.h>
>>>> <stdalign.h>
>>>> <stdarg.h>
>>>> <stdbool.h>
>>>> <stddef.h>
>>>> <stdint.h>
>>>> <stdnoreturn.h>
>>>> Most of <string.h> is required (strdup, strndup, strcoll, strxfrm, and
>>>> strerror are excluded). This includes strtok, which requires global
>>>> data.
>>>> ```
>>>>
>>>> Maybe for now we can just remove stdio.h from current patch, as it's
>>>> not
>>>> supposed to be provided in a freestanding environment.
>>>
>>> A huge number of files under tests/tcg/ have a #include <stdio.h>
>>> currently.
>>
>> They are all *-user mode tests though, which do need a proper libc.
>>
>>>
>>> In the example build failure in the commit message, we have
>>>
>>>    tests/tcg/s390x/system/../console.c
>>>
>>> which does
>>>
>>>    #include "../../../pc-bios/s390-ccw/sclp.c"
>>>
>>> and sclp.c has
>>>
>>>    #include "s390-ccw.h"
>>>
>>> and that header has:
>>>
>>>    #include <stdbool.h>
>>>    #include <stddef.h>
>>>    #include <stdint.h>
>>>    #include <stdio.h>
>>>
>>> hence the 4 headers I added to the meson check.
>>>
>>> So AFAICT, our code is expecting stdio.h to be provided in a
>>> -ffreestanding build. Have we got a more fundamental mistake
>>> wrt our use of -ffreestanding, such that it is relying on
>>> unintended functionality ?
>>
>> They shouldn't - but s390x seems to be doing something funky here. Ilya
>> can you explain what s390x is trying to do here?
> 
> s390x used to use SLOF headers before the meson rework.
> I remember that Pierrick mentioned there were issues with checking out
> the SLOF submodule, but it seems to work for me.
> So I've posted my version of the fix [1], please take a look.
>

There is no problem to checkout SLOF submodule, but I simply thought it
would be cleaner to not have tests transitively trigger a git submodule
update.
If it's not a problem for anyone else except me, I'm fine with seeing it
reintroduced (see further comments on your patch).

With the right test Daniel added here, we should skip host compiler, and
rely on cross containers instead, which provide a libc.

> [1] https://lore.kernel.org/qemu-devel/20260914235113.272992-1-
> iii@linux.ibm.com/
> 
>>
>>>
>>> With regards,
>>> Daniel
>>
> 

Thanks,
Pierrick

