Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39EAC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x69C3-0001Ut-3q; Mon, 14 Sep 2026 12:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x69BW-0001E7-0x
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:05:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x69BT-0005n7-NH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:05:33 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0dQi1200558
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 16:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EBjnOn4AhOKPbK3hOSaFor82Gjg4QPk4gpOYAm9v8II=; b=IVDXeNCGAubdsMjI
 hqYQ0LDffNsN+hZcEy88dED43tAsSHyPz96BZ1sPowExd3wIh/QWqmGufEPCZbhg
 RBncOePaZfiNm3+QSglyTqC2cETGhEZYL2VMHY8w5iKrmfzwsPS+nYKZkeWHiMD3
 HPVi8qCncVA0c3mfCMIClIyvnNu12LEmXoby1N2EI+65/GW+gVo2b9oBB0KBF2bk
 KFRh1HAxHY5A3bnEqcq76QwYuM2ylMuMHVS3M/yWzTc77XPJyGjipd1HivNytHzN
 NuGJMb/9gBSDmD7TnUJMPVI5CTpgdRC+y2lQvoKoInQuR7lZK9VGf5Y5o6pDZchl
 3bgXbw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdevsrq8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 16:05:29 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-448d51840c4so3179170fac.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789401929; x=1790006729; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EBjnOn4AhOKPbK3hOSaFor82Gjg4QPk4gpOYAm9v8II=;
 b=K6w/dG8mZ9xhl44iPTU1P0Bjo473k2qcbXjWwdMn7RWdcCbHOEvha04WrApDYNl8YS
 SS09nGShKaeBv2zYNhzQQdgVBGl7v90w9UDyFwQ0MXk65W/7zZGyeb9rWVe6GsyPRUSZ
 GZqeNCnYFBE4lHAnWUjEL7RM7O3zNjjAxqRdoy+ix6Wc1XxL6vcYvzO8J9SoPn77sggM
 JSCUnKA+123/iymQ766P2EmWYG+YvfdCIqAaT30AfZldfOVfi059RQSV2TRv/Rg8crwd
 ETwuRoL6pog3iqGeyUmQrMQQAPbgOccZgQAvLYohfxi0Z6tVvJZgOHm1jp6mD+gXYJF8
 P+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401929; x=1790006729;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EBjnOn4AhOKPbK3hOSaFor82Gjg4QPk4gpOYAm9v8II=;
 b=dKsyAqKoA9HFDw0GqGRaS3D/wF31v4TGpSBl8OLq7V04jpzilvKu39ydFniP8GWLEd
 ybsLsvLCueVypCok2gSuoM2wB5ejiy1VqdW+VYow42zeeAC8C21/lhgDHQUQQ7MTQeSu
 Am6r3drB+V7u7TyHRudnEHiPCWR3j2YcyxLig7ZyfEBX/Ir7xoQ0Q3WJJPd4wysrIZJ5
 niCmlG3OemNF9Lo0iMsp/2u3l5KESWcW66b+696wYwRGryph/fVb4NzKjviNtzSQgMc8
 ekJYldcwetDt2s7D3XYtQwV+swOUXhpkpdc2NnlcU1ZoxLCzn1xpMGCUVsLYL67yW1RV
 TSiA==
X-Forwarded-Encrypted: i=1;
 AKwUvByPDmcCA2YHPxRzY0d2VvnGNqO37RKpBRRAvRrAUTbLzWwbPjhC3KQWb6OUBFN2RYg9BcUrBWxSau9O@nongnu.org
X-Gm-Message-State: AFuF++k7RzHjzMgJo6ig4BVKwHDYzoI15Zqked2C0wg8/zRl+J3GhZFe
 7vEOUoVvyRo1Im/DgrspgAYK4bXtUnx2Tq2RTeuKYBKfqSkQf3XLTBsK3HXwqxDsM2Xzq3HIpvW
 E4aZ10oYDAZl+ZkPoGvFcGwCLzMfrtDAmBDbNdQariNjm35D8evmDkCZqFw==
X-Gm-Gg: AYBFou3BNSlQBvM77E1yjehG+RtC+AFrKkkdzqp44Pe4BUC1rtxvzdn38CfFtzTUHQf
 pI2lD9Hspa9WxBxsUf62MjbLEbZ7OcCleo41ufMo+wZVfSEGKHkhLfui9r8U9r5RmSqCMU559d0
 pemmp3kiKV9HeU0cIHohpN9/z87MeZc5aQfIGOWglTyJxyCxcCPBMhvT5bzzV0K2D6/TBfHvYDH
 TxeJp3ih5iOx6LZ7KKtnQN7fz+4LLQ2cfHsUUh/+iLGdZafaVfHaw9T9xBDDeXaAdm+lSdue3O5
 xmhyvjAmiZgy00u51XbVYNc+brWc6oa3oStS1znjN7fpELC9mfFYlKd1tT8sl8pwdsspbtA5J28
 q0hisd6yUtvbnX/4s+IN1r5iKX8zIUnI4lMdRNtiwEQNkp7GBZSzllVUy9mRbz36ynyF9
X-Received: by 2002:a05:6820:8c6:b0:6b3:5c73:2188 with SMTP id
 006d021491bc7-6c53f2524d4mr1686768eaf.5.1789401928992; 
 Mon, 14 Sep 2026 09:05:28 -0700 (PDT)
X-Received: by 2002:a05:6820:8c6:b0:6b3:5c73:2188 with SMTP id
 006d021491bc7-6c53f2524d4mr1686735eaf.5.1789401928468; 
 Mon, 14 Sep 2026 09:05:28 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9b359sm26545099eec.14.2026.09.14.09.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 09:05:27 -0700 (PDT)
Message-ID: <e2447adb-7bb3-4ae2-af52-73f6855bdc51@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 09:05:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] tests/tcg: improve check for working cross compilers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-3-alex.bennee@linaro.org>
 <22dca41b-3833-45d2-912f-b05a77d7d883@oss.qualcomm.com>
 <aqexk7afMhWLxf3w@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aqexk7afMhWLxf3w@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: f5bKz64Gvdd81GlTQwgNSyBZvlf5eAF8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIzMCBTYWx0ZWRfX3BW3VwdLML21
 ry7vgu7/hPOOJ9f5IdpxZGwPzDDXsQudX1jD3ksNo/2jMpt8+mmVRTLxo9OVg/Imxat2jt8BKlh
 qkLkeuS6nkOwB/I1ud77qdhhpyDqyR4=
X-Proofpoint-GUID: f5bKz64Gvdd81GlTQwgNSyBZvlf5eAF8
X-Authority-Analysis: v=2.4 cv=ftpJ914f c=1 sm=1 tr=0 ts=6aa81b4a cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=b4LDLZbEAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=0qKRNlLXlS8saNQJCFIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
 a=20T61YgZp4ItGotXEy2O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIzMCBTYWx0ZWRfX8RYnPzu4AUKC
 nF+1bsxs1Nnq97YcusbpTIXSCZU3dRP4GTWve1zrH5MTMP7EMdVE9AlCYG9Tka3nVBYqbWAZMjK
 MGG9tS8NeysAQy/2sHHcNuYcp6hYgSFiHwTg+jJ2pJFVWC0vH8faUtGmsnEhaEYdfDUVCgdNWZR
 WrimHp1DRMOVU+/uhv8GjIp5AdcmFBukiVCwQc356ta7S3rUzfjwCOyGi21HPMBrV9nybkj6DX7
 UPYIhkif4+cxoFmUbTxxnd68jl3Tpx80NLXF3u1/Ip68vxuApCcAfZXODu667R10uutx4EqfSUu
 iOuG1IXjIIlKutauSgczoAkp67U63LTqH0L9bGHPWQth0YJSxAdaO6YM0F3XOMFidL/0KIBSuSt
 Nree3VkrciY8lt++U0/eM87zXSp1qer3Ht10Rd77ZnkGuoEmUrxnLRysLR7JunUQ9Rgi7IL04q2
 cOWrvYj5r3MXuXIF7BA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140230
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/14/2026 1:34 AM, Daniel P. Berrangé wrote:
> On Sun, Sep 13, 2026 at 10:08:52PM -0700, Pierrick Bouvier wrote:
>> On 9/10/26 11:14 AM, Alex Bennée wrote:
>>> From: Daniel P. Berrangé <berrange@redhat.com>
>>>
>>> When it finds a cross compiler, tests/tcg/meson.build tries
>>> building test_cc.c to validate that the compiler works. This
>>> includes "stdint.h" as a witness for working C library, however,
>>> that is not a good choice as it can be provided by the toolchain
>>> alone:
>>>
>>>    $ rpm -ql gcc-s390x-linux-gnu  | grep /stdint.h
>>>    /usr/lib/gcc/s390x-linux-gnu/16/include/stdint.h
>>>
>>> As a result, if you install the s390x GCC cross compiler, but
>>> not any C library, meson decides to use the host compiler instead
>>> of the container:
>>>
>>>      cc for aarch64-softmmu          : aarch64-linux-gnu-gcc (from 'debian-all-test-cross' container)
>>>      cc for loongarch64-softmmu      : loongarch64-unknown-linux-gnu-gcc (from 'debian-loongarch-cross' container)
>>>      cc for riscv64-softmmu          : riscv64-linux-gnu-gcc (from 'debian-all-test-cross' container)
>>>      cc for s390x-softmmu            : s390x-linux-gnu-gcc
>>>      cc for x86_64-softmmu           : x86_64-linux-gnu-gcc (from 'debian-amd64-cross' container)
>>>
>>> Eventually this results in failure to run 'make check':
>>>
>>> [33/40] Generating tests/tcg/s390x-softmmu-hello with a custom command
>>> FAILED: [code=1] tests/tcg/s390x-softmmu-hello.test
>>> /usr/bin/s390x-linux-gnu-gcc /home/berrange/src/virt/qemu/tests/tcg/multiarch/system/hello.c -o tests/tcg/s390x-softmmu-hello.test -static -MMD -MF tests/tcg/s390x-softmmu-hello.d -Wall -Werror -O0 -g -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I /home/berrange/src/virt/qemu/tests/tcg/s390x/system/../../minilib /home/berrange/src/virt/qemu/tests/tcg/s390x/system/../../minilib/printf.c -I /home/berrange/src/virt/qemu/include/hw/s390x/ipl -march=z13 ../tests/tcg/s390x/system/../head64.S ../tests/tcg/s390x/system/../console.c
>>> In file included from ../tests/tcg/s390x/system/../console.c:8:
>>> ../tests/tcg/s390x/system/../../../../pc-bios/s390-ccw/sclp.c:11:10: fatal error: string.h: No such file or directory
>>>     11 | #include <string.h>
>>>        |          ^~~~~~~~~~
>>> compilation terminated.
>>>
>>> Adding more include files to the test program ensures the
>>> meson probe makes a better decision.
>>>
>>> Fixes: e5d084d622b1 (tests/tcg/meson.build: check host cross cc is working)
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Message-ID: <20260910100120.2076092-1-berrange@redhat.com>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>   tests/tcg/test_cc.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
>>> index d3614a01fe6..fafee055b40 100644
>>> --- a/tests/tcg/test_cc.c
>>> +++ b/tests/tcg/test_cc.c
>>> @@ -1,7 +1,11 @@
>>>   /* SPDX-License-Identifier: GPL-2.0-or-later */
>>> -/* Include a standard header to make sure cross compiler provides them */
>>> +/* Use some standard headers to ensure the cross compiler provides them */
>>>   #include <stdint.h>
>>> +#include <string.h>
>>> +#include <stdbool.h>
>>> +#include <stddef.h>
>>> +#include <stdio.h>
>>>   int main(void)
>>>   {
>>
>> Ideally, we should do separate tests for system vs user tests.
>> System ones are always compiled with -ffreestanding, while user ones should
>> provide a C library.
>>
>> From this standard:
>>
>> https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2023/p2338r3.html
>> ```
>> A freestanding C implementation is required to provide the entirety of the
>> following headers:
>>
>> <float.h>
>> <iso646.h>
>> <limits.h>
>> <stdalign.h>
>> <stdarg.h>
>> <stdbool.h>
>> <stddef.h>
>> <stdint.h>
>> <stdnoreturn.h>
>> Most of <string.h> is required (strdup, strndup, strcoll, strxfrm, and
>> strerror are excluded). This includes strtok, which requires global data.
>> ```
>>
>> Maybe for now we can just remove stdio.h from current patch, as it's not
>> supposed to be provided in a freestanding environment.
> 
> A huge number of files under tests/tcg/ have a #include <stdio.h>
> currently.
> 
> In the example build failure in the commit message, we have
> 
>   tests/tcg/s390x/system/../console.c
> 
> which does
> 
>   #include "../../../pc-bios/s390-ccw/sclp.c"
> 
> and sclp.c has
> 
>   #include "s390-ccw.h"
> 
> and that header has:
> 
>   #include <stdbool.h>
>   #include <stddef.h>
>   #include <stdint.h>
>   #include <stdio.h>
> 
> hence the 4 headers I added to the meson check.
> 
> So AFAICT, our code is expecting stdio.h to be provided in a
> -ffreestanding build. Have we got a more fundamental mistake
> wrt our use of -ffreestanding, such that it is relying on
> unintended functionality ?
>

Looking a bit further, it seems that this is the only example of system
code pulling this header (through pc-bios), which might be a specificity
of s390x firmware.
That said, it's not the end of the world, and as we mostly use
-linux-gcc variants of cross compilers, it should be safe to expect them
to come with a libc. Let's keep the patch as it is.

> With regards,
> Daniel

Thanks,
Pierrick

