Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDD4C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVGW-000397-4z; Wed, 08 Jul 2026 12:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVGN-00035K-59
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:36:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVGJ-0001tL-Cx
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:36:42 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GL05T3256330
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 16:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hVKG80IeqdI8Tv1B+k4hMJ8zc4cqZ9JGDAQHRzjO5+U=; b=M6ML5Az1dsLevokU
 8SXqcWbH9XtMuZjs1NohKYK6JTDypnQrluTTWkmqIGDcXOVVnS25gKOvxgUn6dGS
 ARir2hC3G9spgPw1v0QmQ80XjTVCrRFA4p/YZjwYDZBdq5IKsIlBM5B9mvpnqLhD
 7eV/tV7f5ECkJQYLZtlNUZMFweQAJlt0tcvf7D9rl9kIlPolNuZFe2zXK+e9TXqX
 yAvrWQGYIfQPWHyWtf6eixCYqrA6IbWLyzo/CEdnCkV1NKYCt8UNvToCruyFtBtX
 5961+xhVH3HlpVqpY0NaqbpBWAqOnlQ/8KjZ3GN4ILdjAxyWpKkU+/nE6vAY2Pvf
 7D2cNg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqw8551-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:36:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c85a298cd62so879611a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783528597; x=1784133397; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hVKG80IeqdI8Tv1B+k4hMJ8zc4cqZ9JGDAQHRzjO5+U=;
 b=exruJ4xUPul3Z5GEJQV2tGdcLXX0o5rB7MTwZL29RHh8Z58hv1NIZ0pmcSK9unS7pt
 4xKhb85N8kRkw+OsHRF/R9rL0XUOrGDvL+CIkHvJBG90HAXX0tzVDvjTWFHgBEEi7Us2
 7PCjlwxgPAcBMefpOmDBfyljnqFnw10wgU+F34tPYqZMVOrhhf16IpJ0yNhrws/ew5t8
 J0SKHqB4uwL4YRf8f2MZAx5gk/juGS9UOIRjMYsYzGdkNmZVyluYQW9d3VhXIU0W2Hig
 wQClbj95dRNidu5VfINo+1E15lqTKGvN2hnvL6d70jH6MBTLDyGRRPixuManSdagZaC/
 2ppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783528597; x=1784133397;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hVKG80IeqdI8Tv1B+k4hMJ8zc4cqZ9JGDAQHRzjO5+U=;
 b=kps0kzSfEZjrTJAnVP7YSJqpM+fYpSQNtO+PHgCthPj7fTSG/y2I1MpqlbmRyEUNPu
 MP0S8X05Mn1vEEI/i2o8+003EzIfaowJ9nyfPzNdWh/rmMHKw/UyPHj2ds105SzU2PCe
 KX0IDAwq6gDHvvBIbXYm+DBRq2cxaf/ebuzeaR72Ap0GUhhFy1j78Ubi3Ls7FbAUb/EQ
 ohK9YrTQyUm0prPPbku1/pFnN3gFutJAkP4Ok8P+NB9lYKv8dGaHLcPPL6wZIEq+XzuC
 Eb2mNFihfKfGLd+0ZXXhVos22mwnUU7fVhDmEoMsNb+8n7pnZA5NKnojSB312XrED/9O
 l9LQ==
X-Gm-Message-State: AOJu0YyGvUvD5GKXEhqh1sCJHT5QQj/fZs4j5dpD8HSeLGkvUD7bWWkY
 BFTbPPgr/cKQYsapWrFenvZfWGisyuMIQ8n+MS5+Cn2HNlPxtkn2WIaI/prITHMoWKjc5x1PTC/
 RxKW+LG8XUw2WqAGpIoGZ1cmhSEEZdyygD0HFWbHzB3WmIS15TgpYjWKEWw==
X-Gm-Gg: AfdE7cki8dY2ybb5NwBtaKMTWp8hRFTets8dp5/fYQ0VwIG3T6x++rehTrXV7acByDy
 14wcjp6dRrcpx0Qx36suZVshaQkkDGeqtG45uNf6nKFRlCjBNSqgyaijFj0e1F9WTemJd9kvxh9
 5nLs03dXJAm55bTCe/F3RpzY4ea6vdS5E9coafG1OjElTByD2c6xj6XIWXbJ2Xyv4Tzhj5reyd7
 ZY14mzPPVvDETUyCG+w0eOE0XmDBIhQVhXoAQttzUfW6Qbyqb/7SznmwkcXtO+PG1FtccSKN04U
 vVzRgy2pyE6P2Nvjuw2CxDzRx1Xjt4xkFHZgKVSglggDSIdYAPd8HFXlBBbsPLInRz+9ioq1yvA
 IVKuApsLZrx2+q+Z8y8ql+rctN5Xq0p8x4+2Zv/PwyIxlP7n1Zp1RSWcJ4UKhf57IlEyj1yfqBL
 bzKIE=
X-Received: by 2002:a05:6300:6ccd:10b0:3bf:9cbd:9a36 with SMTP id
 adf61e73a8af0-3c0bcee90b2mr2379806637.26.1783528596547; 
 Wed, 08 Jul 2026 09:36:36 -0700 (PDT)
X-Received: by 2002:a05:6300:6ccd:10b0:3bf:9cbd:9a36 with SMTP id
 adf61e73a8af0-3c0bcee90b2mr2379775637.26.1783528596039; 
 Wed, 08 Jul 2026 09:36:36 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483dec6sm22409075eec.11.2026.07.08.09.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 09:36:35 -0700 (PDT)
Message-ID: <422b0dd7-b3a2-45fc-a76f-43c18f95c426@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 09:36:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 87/91] tests/tcg/xtensa/crt.S: align .text section
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-88-pierrick.bouvier@oss.qualcomm.com>
 <CAMo8BfJg09ca6Kxw0WLLj0SQLBcOCwYmSN=e3u063oY-fgrdfw@mail.gmail.com>
 <99d7064e-50f3-4947-884a-6f6c14f2cee2@oss.qualcomm.com>
 <84fddbf3-e523-4a23-b95e-cc6102e459c3@oss.qualcomm.com>
 <CAMo8BfKGqu=GbDhp525Oqt4VVCC7cPSYZ5obsUuuFQYKvreeKQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAMo8BfKGqu=GbDhp525Oqt4VVCC7cPSYZ5obsUuuFQYKvreeKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE2MiBTYWx0ZWRfX+41GXOLPcZPm
 HOZO5g/NJRCN9uV45M4vjZjMeuSp6GC5m7+BkBvLbZZF+e0CFReGUSIhNmUS65cUsul5OOs6/38
 hJSsCAqNlfEZbxkg9L7t7lBxZzmFTGypIfihKo0zIoVknlz50uZSDYzkR6cSu58mX8ZBdzIRsYc
 DWR3Bt/Lwnhp027vmyhBSBGu6yzdECWviB5XRevnaxk4JhDOiDbWF8CXAZlSAboWLrPl2WBi5qV
 grR+fSWvC1oadEOzZdnoZczHp0JQNeZxRWsDwbj72g3MWfaQxPZAZIZRjoqv2/rFBG6zwXmUZOK
 80WbCOJg6pZvfmR9h0R/Mmux3UBE5yfI40amwyy3aUZVpwnWDFAIVtYWJTnP/4NOBUE7PogEaJi
 dZmmKQ8YKEyR/OJgznc88yU2Z3txSRsaumL9XnYVbGRGmC1wFuPE3q9ohrFGcqxkj6fxJXjaUAH
 X4ALyhMEjbk0PSDskww==
X-Proofpoint-GUID: R13xxE5YOI7uZlJKZkkJkCNCxj8QK2Rz
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4e7c95 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=YbdBfhNLAAAA:20 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=vC3XxjlAgSN79agTcR0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: R13xxE5YOI7uZlJKZkkJkCNCxj8QK2Rz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE2MiBTYWx0ZWRfX+cWwaZTHBXAT
 XpMkz5/vuCZa7qD2gq0eB7LuIlHwiuHb3oYycjZahFKOeTPNqTABtm6dVSqFQvrg5j0UGXriEaE
 rlzlWOihi/MfJggYePXiMUkGyoyCsaI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080162
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

On 7/7/2026 11:11 PM, Max Filippov wrote:
> On Tue, Jul 7, 2026 at 11:10 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> On 7/7/2026 9:30 AM, Pierrick Bouvier wrote:
>>> On 7/7/2026 6:45 AM, Max Filippov wrote:
>>>> On Mon, Jul 6, 2026 at 3:43 PM Pierrick Bouvier
>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>
>>>>> Needed, else we get this error:
>>>>> dangerous relocation: l32r: misaligned literal target: .text
>>>>
>>>> This flag wasn't needed before because crt.S hasn't been built
>>>> with text-section-literals, why is it needed now?
>>>>
>>> Previously, .S and .c were compiled in different steps, with different
>>> options. Now, with meson, we have to provide a single compiler command
>>> for all the files (no intermediate steps), which is a *hard* requirement
>>> to save user from dealing with compilation details in arch files.
> 
> This sounds a bit restrictive for the tests, no?
>

It may appear restrictive, but it has not been a problem for all the
existing tests we have. In practice, only xtensa has such a structure,
with this distinction between .S and .c that use/don't use text section
literals. In such a case, I prefer to unify things instead of twist the
workflow until it works.

The alternative would be to give arch files full control of how they
build all their binaries, which is much more verbose and error prone
than the current approach. (Note: I tried that first before having the
current design where tests are just declared).
Also, it pushes all compiler details (is flag supported, is it available
or through docker, how to build container?, ...) back to arch files.

Also, because meson can only have one cc and cross cc at a time, we
would still need custom targets for everything, which is really not
something anyone wants to write themselves, trust me.

>>> One consequence is that .c + .S combination gets
>>> -mtext-section-literals, which triggers this. Easily fixed by adding the
>>> .align section.
> 
> Ok, not having literals in the text section isn't essential for the existing
> xtensa tests. But not being able to do that deliberately feels a bit strange.
>

I'm sorry xtensa uses a corner case, but fortunately, this simple align
makes things work as expected.

>>> I can add this in commit description, if you're ok with this
>>> explanation, and accept the patch.
> 
> Sure. Feel free to add
> Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
>

Thanks!

>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>> ---
>>>>>  tests/tcg/xtensa/crt.S | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/tests/tcg/xtensa/crt.S b/tests/tcg/xtensa/crt.S
>>>>> index 909872cd385..de8fd8c1cd7 100644
>>>>> --- a/tests/tcg/xtensa/crt.S
>>>>> +++ b/tests/tcg/xtensa/crt.S
>>>>> @@ -6,6 +6,7 @@
>>>>>      jx      a2
>>>>>
>>>>>  .text
>>>>> +.align 4
>>>>>  .global _start
>>>>>  _start:
>>>>>  #if XCHAL_HAVE_WINDOWED
>>>>> --
>>>>> 2.47.3
>>>>>
>>>>>
>>>>
>>>>
>>>
>>
>> While at it, any chance you could give some hints about how to compile
>> for xtensaeb? I didn't find any compiler flag, and out of modifying
>> target/xtensa/core-dc232b/core-isa.h to set XCHAL_HAVE_BE to 1, I'm stuck.
>>
>> I doubt it's the right way to do considering that it was not needed before.
> 
> You can download a compiler for the core `test_kc705_be` from
>   https://github.com/foss-xtensa/toolchain/releases/tag/2020.07
> and then either run qemu `configure` with the option
>   --cross-cc-xtensaeb=xtensa-test_kc705_be-elf-gcc
> or run tests with
>   make test-tcg CORE=test_kc705_be CC=xtensa-test_kc705_be-elf-gcc
> 
> The `CORE` variable chooses both the argument for the qemu `-cpu` option
> and include directory used when building tests. The `CC` chooses the
> compiler and linker.
> 
> I usually run configure with some compilers for little- and big-endian xtensa
> and then run tests switching the core and compiler.

Sounds good. I'll add it to our debian-xtensa-cross, and uses it
directly for xtensaeb.
In case you want to run this with other cores, feel free to answer with
a list with their names and toolchains, and I'll be happy to add all
needed suites, so there is no need to set any CC and CORE, but directly
offer check-tcg-xtensa-X-softmmu suites. The good side is that everyone,
including our CI and you, will be able to run the *exact* same setup.

Cheers,
Pierrick

