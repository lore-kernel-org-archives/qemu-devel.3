Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2060C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqcI-0007tC-O4; Thu, 09 Jul 2026 11:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whqcH-0007sa-4t
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:24:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whqcF-00084n-73
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:24:44 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669EwOX32062311
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 15:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vS+yPt8FdrBTLV2AKvGQqNrx2yB0XZgdg+hUg14Tq7g=; b=gbAdNW1EaelgOwPs
 KL87pUQgJBxBsuVJS+AVgmsqtj2RgjfC5b0nz7DOHHde9zzVcILBlbPx6yIcHVRX
 6okjGGRAgs3j2khzn3yGl1nOyFOKILWf4NHcy5qBLeOon+WSG330Bj58rSjbeCH/
 r/aTb7PEiza7rfilahW9JA7iNOWd4sLIs75/Q5WZAyIf4PIxP4gdg+YiWMFx2Ryv
 U0bqGQO8AaQsc4LO95JpFrpYOQsvC+Px2iy1zCy8oH0OuCgWRgjLMXa+kxTbfk6W
 zvRC8QFL9Nbjt/TKkZsXqaJnAG3wCU7giU58wvqZlPmEWJlDPj2DPeeo//FDgHKU
 2bLl2Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvj845v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 15:24:41 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85a298cd62so2006319a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783610681; x=1784215481; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vS+yPt8FdrBTLV2AKvGQqNrx2yB0XZgdg+hUg14Tq7g=;
 b=TOGCjXVn+sAX1ZYrt5/1YDPTQzUse6+x1VLe0TDpS93OybL5ZIGVnme+eR6eomdTUP
 CVFu8GDHZ6AIajlwYFtv2+zjEPhmsV3qYMriL/E0u6lBAx9iqg6zBBQ507I4QViJ++2H
 R7y3vjs/5aafKqH7gfFELklSgMPGGET8/WLd7vPaXt6SJfxgUjBMTkVJb1tLk1nOwJFY
 4NK+tMqb1q0fmpi4zqKY2ZsSH5V7scSEzm7CVjWPO9uVSDOouNLT6J0iqJXcZNTJm6vz
 Ek6aWmWcrrzquKYH1HgwjLXTSMRxT5t3diPtJeWBhXIpRV5OReFMNebJq8+iGnZyXukh
 H86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783610681; x=1784215481;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vS+yPt8FdrBTLV2AKvGQqNrx2yB0XZgdg+hUg14Tq7g=;
 b=DUFJwVz/DGsQzqdYnmIbKZzwQGIDgcg50y/8Unxrw/IbIWykjoC6fhCHxuqacljotD
 A2R58EAqNX4JRO8iQbJq1dS7nwbsjEFJCEu/bKqaoc+IBJ8VOlwE3dV/LO+rpF3PVRjK
 ft+gBNUjbMCpmh1hFDzKUyU7QVhyUbeOMfqr15gtw/DLdIPpzRAWWJnux9XE2Iz8NahZ
 xECRfVlyeP6yEQvJslaglNWhBA5dbJaYAsZd9w54ea9cK4EI95EJ9oqH304yTFmchDSh
 +o04fKuvh7SRFOLjVoYm3Bsmc54jwCEZ3bDzuIXRY7pKbNf1gZTaUkAsBqkMou7sEIaO
 85qw==
X-Gm-Message-State: AOJu0YxBzO18MVjIj2999Cqgs5/ysQVRZWfSmiEtBDlAAdoN9RZ2lfEb
 Mq4m3KdM4s3UzCuPBHvt8I+uumLsZDGgafoqC+K2mc1ysMruUON2H5L0WmCE0t4hdsp8rRmkoGk
 m83RrI8NyzBzkjus0jJQ7hHBFYFcLYy25cW6h6Rpg6a9PebvA27O9pBj99Q==
X-Gm-Gg: AfdE7cleyp7Y/ndbBGN98u3YJd1UASKoHjcmDH32emrdtULSrlHi/VPP9rfDPTvKjc0
 shHsmqWApyPY1aR/bZhA/A4biLc/gLVSGd8xU1QVOG3qCpCPtum0f1gPOWIZt4n/4eP26eZQ+Fk
 Z6pySm8hNyVMTjj4v2rHlk6IfVKENUkhFoMfIzOVnthlVGDNdqdbeklH2Jmgl0w1EE9zi9bB8we
 cUg3lhsyAsaNftKOlavb8nGPZWDl7xk+cRoWAolLZ6x0dYSCFXua3Pn7I+mkGTH7P58c52SExte
 riFV4k4xrTmDVSFeun88gKlboh+Ee/yRD9/TEeMOiXGleZ15fQXHnnM3eRT4DUGa81xZqmJxxoq
 L5sDtF6TZDKl1akP1PwJfawwHMTwaOjIKTQu0DJ2CysbYzU85s8ki+UhWKQO8GfPT+yxmQKCcry
 wdBRk=
X-Received: by 2002:a05:6a21:39a:b0:3bf:9abb:a8be with SMTP id
 adf61e73a8af0-3c0bd0f9e0cmr9656123637.41.1783610680505; 
 Thu, 09 Jul 2026 08:24:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:39a:b0:3bf:9abb:a8be with SMTP id
 adf61e73a8af0-3c0bd0f9e0cmr9656056637.41.1783610679802; 
 Thu, 09 Jul 2026 08:24:39 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6594f9a0sm33420075c88.4.2026.07.09.08.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 08:24:39 -0700 (PDT)
Message-ID: <968352f9-089f-4409-800a-3efef59d114d@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 08:24:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 87/91] tests/tcg/xtensa/crt.S: align .text section
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
 <422b0dd7-b3a2-45fc-a76f-43c18f95c426@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <422b0dd7-b3a2-45fc-a76f-43c18f95c426@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE1MiBTYWx0ZWRfX9GGfWIrE4ys8
 QjXh/Xjl0E9ORW7fl0V1KynvLkhEY7sH4aKZe732qPw7sMwDvQ1jXbnwFEepZd7tr69bDzzsc31
 kPR8l75xHdsCLmhKKXLXc+aYLD8zwvCboNmrY9Im5Tyu75EbFmWkYl3HRwS+z+LGVVKwhD2pUDR
 J0+SvfzaSZsLEX8XPwiw+JqlabgENeClNZjVA0tiJ2vHwemGi+ta2abXFoVbhm5Yux/b6rIBkIr
 Dq4B2S8+RPZX8Yftgj4mOo1oAz+zBp7FD3vEmaTki7SAjg8t0QD5d0L102AEQrZefB2X41yeV+q
 GxHuPkESPcEyjncVmNzMjzKxdZna9ZnbBkPKkeleMGFcAxsplRBIxnVhNHkEk6/MIL1DK5G7ZIv
 a5zaEYS0StWkXO9fBhNkf0nX0lkEBhjeAoQiioxasx081uDbZ3V1qnVmGIPZDypXKdNYU4BGr7U
 /DkIycnG3IFFElmYCFA==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a4fbd39 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=YbdBfhNLAAAA:20 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=tkwA2rs3d6H_YYBlMgkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: iG2hmZti6UfMYY7c5ShiQiTWTgN5zMPb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE1MiBTYWx0ZWRfX31PjoSwmll94
 tZ94YRu+yY/XoWL/o6AJV24PWPQ3xgw3erX82tLRcgNkglcF7LGmqYWtTtS24VAzKCfWnLlVS0B
 ItOiOTnBeqGjddMdvbdKAeHA2JWpktg=
X-Proofpoint-ORIG-GUID: iG2hmZti6UfMYY7c5ShiQiTWTgN5zMPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090152
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

On 7/8/2026 9:36 AM, Pierrick Bouvier wrote:
> On 7/7/2026 11:11 PM, Max Filippov wrote:
>> On Tue, Jul 7, 2026 at 11:10 AM Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>> On 7/7/2026 9:30 AM, Pierrick Bouvier wrote:
>>>> On 7/7/2026 6:45 AM, Max Filippov wrote:
>>>>> On Mon, Jul 6, 2026 at 3:43 PM Pierrick Bouvier
>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> Needed, else we get this error:
>>>>>> dangerous relocation: l32r: misaligned literal target: .text
>>>>>
>>>>> This flag wasn't needed before because crt.S hasn't been built
>>>>> with text-section-literals, why is it needed now?
>>>>>
>>>> Previously, .S and .c were compiled in different steps, with different
>>>> options. Now, with meson, we have to provide a single compiler command
>>>> for all the files (no intermediate steps), which is a *hard* requirement
>>>> to save user from dealing with compilation details in arch files.
>>
>> This sounds a bit restrictive for the tests, no?
>>
> 
> It may appear restrictive, but it has not been a problem for all the
> existing tests we have. In practice, only xtensa has such a structure,
> with this distinction between .S and .c that use/don't use text section
> literals. In such a case, I prefer to unify things instead of twist the
> workflow until it works.
> 
> The alternative would be to give arch files full control of how they
> build all their binaries, which is much more verbose and error prone
> than the current approach. (Note: I tried that first before having the
> current design where tests are just declared).
> Also, it pushes all compiler details (is flag supported, is it available
> or through docker, how to build container?, ...) back to arch files.
> 
> Also, because meson can only have one cc and cross cc at a time, we
> would still need custom targets for everything, which is really not
> something anyone wants to write themselves, trust me.
> 
>>>> One consequence is that .c + .S combination gets
>>>> -mtext-section-literals, which triggers this. Easily fixed by adding the
>>>> .align section.
>>
>> Ok, not having literals in the text section isn't essential for the existing
>> xtensa tests. But not being able to do that deliberately feels a bit strange.
>>
> 
> I'm sorry xtensa uses a corner case, but fortunately, this simple align
> makes things work as expected.
> 
>>>> I can add this in commit description, if you're ok with this
>>>> explanation, and accept the patch.
>>
>> Sure. Feel free to add
>> Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
>>
> 
> Thanks!
> 
>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>> ---
>>>>>>  tests/tcg/xtensa/crt.S | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/tests/tcg/xtensa/crt.S b/tests/tcg/xtensa/crt.S
>>>>>> index 909872cd385..de8fd8c1cd7 100644
>>>>>> --- a/tests/tcg/xtensa/crt.S
>>>>>> +++ b/tests/tcg/xtensa/crt.S
>>>>>> @@ -6,6 +6,7 @@
>>>>>>      jx      a2
>>>>>>
>>>>>>  .text
>>>>>> +.align 4
>>>>>>  .global _start
>>>>>>  _start:
>>>>>>  #if XCHAL_HAVE_WINDOWED
>>>>>> --
>>>>>> 2.47.3
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>> While at it, any chance you could give some hints about how to compile
>>> for xtensaeb? I didn't find any compiler flag, and out of modifying
>>> target/xtensa/core-dc232b/core-isa.h to set XCHAL_HAVE_BE to 1, I'm stuck.
>>>
>>> I doubt it's the right way to do considering that it was not needed before.
>>
>> You can download a compiler for the core `test_kc705_be` from
>>   https://github.com/foss-xtensa/toolchain/releases/tag/2020.07
>> and then either run qemu `configure` with the option
>>   --cross-cc-xtensaeb=xtensa-test_kc705_be-elf-gcc
>> or run tests with
>>   make test-tcg CORE=test_kc705_be CC=xtensa-test_kc705_be-elf-gcc
>>
>> The `CORE` variable chooses both the argument for the qemu `-cpu` option
>> and include directory used when building tests. The `CC` chooses the
>> compiler and linker.
>>
>> I usually run configure with some compilers for little- and big-endian xtensa
>> and then run tests switching the core and compiler.
> 
> Sounds good. I'll add it to our debian-xtensa-cross, and uses it
> directly for xtensaeb.
> In case you want to run this with other cores, feel free to answer with
> a list with their names and toolchains, and I'll be happy to add all
> needed suites, so there is no need to set any CC and CORE, but directly
> offer check-tcg-xtensa-X-softmmu suites. The good side is that everyone,
> including our CI and you, will be able to run the *exact* same setup.
> 
> Cheers,
> Pierrick

If you have a chance to take a look, I observed that test_timer.S is
flaky on xtensaeb with kc705_be. It fails with a probably of 25% on my
machine.

Regards,
Pierrick

