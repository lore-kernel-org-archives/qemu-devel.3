Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16C3CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRwCA-0003sF-2z; Tue, 26 May 2026 14:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRwC7-0003q1-8h
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:07:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRwC4-0002de-JV
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:07:58 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QH1cN73147042
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 18:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6PECNvZMMV/mVcl85/ccfCAhzEabbbYgPKsRSZvoQAA=; b=dxS8f/Rllveui1bb
 1144mYb9OkoBKB/TwByYC41qM5JYYMRCHNAWLK3W7mj/QslNXW9/etnlrUOYEHmK
 tAUBlHp2HxHcJM8PMuWxxyrxdfnibB+wLABYfPA4S+0drGkynSjF/MX6rJNW4aGv
 +HzUkvWz55qZBpJ6Kj+e3ecXXhYzlddtIBwgz59h6mEPUTygviJkFFyHD7cHl+Om
 AyYanUlLWH3GuPHDvDHtW3Y7RZFbmsM1Ysu33gkpczb2qdQqs3c1366e+qxc0Xve
 e93YhmQz/iyMAGG0ycWpataWy/i3f4qCsjXnF491Xai/Hh2zhYu7FLIrUjjEH+pM
 7ASKXw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ed5v3ucaa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 18:07:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2fded513994so2932636eec.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779818874; x=1780423674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6PECNvZMMV/mVcl85/ccfCAhzEabbbYgPKsRSZvoQAA=;
 b=XKRHe38TiQudQoqvD34pDzmaNNk+eyf0DFEbvseoEtB8SR5qjemeeqWaoBs3Xo29R/
 tFtRvYExl8gyYPV0JzF0yC/jktD55Jo4eVsAube43oqrbMesuT3oQv0S+6p7Ooasin2N
 5ZOAuQNyuWgtL1GiF4V90+p7rA0g9si9OY6kj17BNydwi1i6Omiy77f3HDoX6YNNsDt+
 XbXpGJ80CGPs7ugBycvujr1GtAQdIqKzLLyQ/pE1W9fjOsvprid7xYlss6Z2RBp4yFua
 pAvA2IqpnY+1YBwx3J/fEFJRQ1Smy/d+9ttCAkAjF7O2h+QBn8kxkqDRY7BqQ9F5eQ4b
 J6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818874; x=1780423674;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6PECNvZMMV/mVcl85/ccfCAhzEabbbYgPKsRSZvoQAA=;
 b=MRdsMN9umvVDNmDpp5DsQ/OPsC64rXR3A2RpkYx0LGmYkshEhGcdF8I9XDCaXPvcBD
 vpOU8owdMCN7W0tKws7oMXDrRcZtLdV6GPd5r9eiMdp36EWGE57W4VwEcwwC11iUm+s5
 voptnvTGSR+2MnK4f5ks7vFn8k1s6JSLXrU5MTgqQZWMklCS+qgj4vRPQ8XeCS6ezGqa
 s7XZt49of1KWNwwQJhchiAhgf64zsM6uWymtabfRm+omZl0ZMfxErT41CMpgQXH2eOL2
 idvqL00N+RbBF6ss45tmXZ+6noAiIObymXlErItRh37bq3tj9E+Vm/wf8Cji9ikf6uFD
 XXbA==
X-Gm-Message-State: AOJu0YyLmhUL7SAL+0J9NJ4JY44rt0nrjHp4zmrWFYP/G5ji9k2+xSzw
 njozodphhNx73xJx31zLuz4DGN+BT3VPa/gS5b+P+05Ko8eiXJnoycV3GzgVopfrLL+qsGZPdPK
 udlmBrSFjIPQCeGqK66trNWOr8OatUJj3qp1/9LJWd5v8H6+/O/kcGH8FWw==
X-Gm-Gg: Acq92OHouN1X6y3jEQ7JURa7e0hTXmuua2GidjJTz8vySuSmGE/1Ow9MoGAbwAcJAw8
 Mkpf+Ndaqgq/5ruzaF9ER713pMA+wTpWNkXldGpS494i6FUbaSE15NkA5cuLtwphcly2vjtzebR
 4R+7q9l20vw2WfeME9aLSc0LjQw6xbY0v8qJQQYvw0dI9lMeE+Q6aCWE3qw6ryLIFjdaUCD0ZHJ
 D1VoBcFXEUnovmBi3dE90YKLH3VoFfn5U4URcECXsyvKHWdaDC1LTmo8ebYrTPdiqAKPDx9EoRW
 oW7N+4FMamhAPwb6tNMaVAMSLtf4B5Ku+CkIztFbqpTXtudvKCbzcThamcsQ+4Yeigh7DW6VTUL
 ucPnCC2gFPReaaoBZfIPn5m9iSLMqgQ2eEF3+3Yn8TXOQWSaErZJ0p3P0O85cWYtR+ZFdPjWoMD
 4xrbxq6AW4PdEB8A==
X-Received: by 2002:a05:7300:ad06:b0:2c8:6361:ab2e with SMTP id
 5a478bee46e88-3044905b650mr9448242eec.8.1779818874015; 
 Tue, 26 May 2026 11:07:54 -0700 (PDT)
X-Received: by 2002:a05:7300:ad06:b0:2c8:6361:ab2e with SMTP id
 5a478bee46e88-3044905b650mr9448217eec.8.1779818873326; 
 Tue, 26 May 2026 11:07:53 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230b25sm13986432eec.15.2026.05.26.11.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 11:07:52 -0700 (PDT)
Message-ID: <8a878679-733c-451c-8053-663a74f8d4a7@oss.qualcomm.com>
Date: Tue, 26 May 2026 11:07:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] tests/Makefile.include: add binary dependency to
 run-tcg-tests-% rules
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-4-alex.bennee@linaro.org>
 <74e8bc86-cd81-43f9-b5cb-7e3de3bcd3d0@oss.qualcomm.com>
 <87tsrzl138.fsf@draig.linaro.org>
 <093614fb-ced1-4b15-b1e1-5da755f87237@oss.qualcomm.com>
 <87cxymec7b.fsf@draig.linaro.org>
 <5bd51a1a-4079-4073-bbd8-f0206a1ad458@oss.qualcomm.com>
 <0f73d717-1621-4c3f-9c5e-9bfdfaffb0b8@oss.qualcomm.com>
 <877bor9vor.fsf@draig.linaro.org>
 <7d58926d-a36d-430f-828e-7ebdd9cc4eb5@oss.qualcomm.com>
 <87qzmyzbut.fsf@draig.linaro.org>
 <06092208-1b56-4fea-8d92-bf035fbd0fa3@oss.qualcomm.com>
 <87fr3eyrvp.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87fr3eyrvp.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE1NyBTYWx0ZWRfXxoESG+CUaKCq
 EaQoi4Tthu2v/ZSXXXTmZHU1VTRPqmEE6/jyyjZ0bvxpCrK5QzJT9RYGhu4tbBS8LQP4EDY7s3f
 PldxRVRW/R4vf0293BE2fFZABdfqTPQ/HGLzrOiqpnQkLdU3VMvOhsPdmxpv3huI/xcoQJ2E4Eo
 ZMO/tzkonL5sSJAPTrgQiWNUcFqF1bOKLRn90eg/1BLeHiVhR86zEsDGy26480triD2Fjr+lYDd
 KqYpj+IzEDDoQUjNbxx/xfl7Ld5sfxYr25Yq1Oelm6GV9Hw4m7D4s52coq2OVZxw4XCRU1Rkc8F
 fUT1mQIj6cx61tCsyZkBucdRZ26gtIXTZdo5LnoZ9pEqhmu3pL0b+WVJDn0wrjivTbwRGH0VLUC
 8VS3lrAead0nzx0ovKteM9KInjK/VGwfm8rgjdIBMh9Bi/SDI1WMuz3Rir8pKw0+G/455TtPrfX
 yDFBANciOd5ideAj65Q==
X-Authority-Analysis: v=2.4 cv=Zc4t8MVA c=1 sm=1 tr=0 ts=6a15e17b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=ukH1R-b_AAAA:8 a=EUspDBNiAAAA:8 a=R3v0vUnM9xIF36UBXe4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=zUGFzhdS3I8ccRoxxLmr:22
X-Proofpoint-ORIG-GUID: gqN5lz7snos721S1utaN0-yRnwOi3LcT
X-Proofpoint-GUID: gqN5lz7snos721S1utaN0-yRnwOi3LcT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260157
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

On 5/26/2026 10:58 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 5/26/2026 3:47 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 5/25/2026 11:43 AM, Alex Bennée wrote:
>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>
>>>>>> On 5/25/2026 8:46 AM, Pierrick Bouvier wrote:
>>>>>>> On 5/23/2026 1:56 AM, Alex Bennée wrote:
>>>>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>>>>
>>>>>>>>> On 5/22/2026 12:02 PM, Alex Bennée wrote:
>>>>>>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>>>>>>
>>>>>>>>>>> On 5/21/2026 6:17 AM, Alex Bennée wrote:
>>>>>>>>>>>> Explicitly set the appropriate QEMU binary as a dependency so we can
>>>>>>>>>>>> ensure they get built. This is especially important for MacOS which
>>>>>>>>>>>> otherwise only builds the unsigned binaries on a normal "make all"
>>>>>>>>>>>> run.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I'm not sure to see why it matters. tcg-tests don't make use of hvf, so
>>>>>>>>>>> unsigned binaries are plenty for it.
>>>>>>>>>>>
>>>>>>>>>>> Which other binary is this building that is not built by default?
>>>>>>>>>>>
>>>>>>>>>>> In general, if something is not included in "all" target, let's make
>>>>>>>>>>> sure it's included there (meson.build?) instead of adding a workaround
>>>>>>>>>>> here. Not only tests benefit this, but anyone doing a build on a
>>>>>>>>>>> platform that might have optional binaries not built by default.
>>>>>>>>>>
>>>>>>>>>> If you have a suggestion on how to make that work I'm all ears.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I would be happy to help, but I don't understand what the goal is. I
>>>>>>>>> have three questions that should help to provide a suggestion.
>>>>>>>>>
>>>>>>>>> Which exact test command do you run?
>>>>>>>>
>>>>>>>> make check-tcg
>>>>>>>>
>>>>>>>>>
>>>>>>>>> ```
>>>>>>>>> Explicitly set the appropriate QEMU binary as a dependency so we can
>>>>>>>>> ensure they get built.
>>>>>>>>> ```
>>>>>>>>> Aren't they built by all?
>>>>>>>>
>>>>>>>> Apparently not.
>>>>>>>>
>>>>>>>>> It seems to be a dependency, at least for check-tcg:
>>>>>>>>> .ninja-goals.check-tcg = all test-plugins
>>>>>>>>>
>>>>>>>>> ```
>>>>>>>>> This is especially important for MacOS which otherwise only builds the
>>>>>>>>> unsigned binaries on a normal "make all" run.
>>>>>>>>> ```
>>>>>>>>> Why do you need signed binaries for testing on MacOS (hvf?)?
>>>>>>>>
>>>>>>>> In a previous iteration I made configure spit out the unsigned binaries
>>>>>>>> to config-target.mak but the request was to fix the dependencies
>>>>>>>> instead.
>>>>>>>>
>>>>>>>> It all works on Linux so I'm not sure why MacOS is being so weird
>>>>>>>> because the meson emulators target mechanism should be the same.
>>>>>>>>
>>>>>>>
>>>>>>> Just tried now, and it does not work on Linux neither (make check-tcg
>>>>>>> does not build any target beyond tests). Maybe you forgot to clean your
>>>>>>> folder?
>>>>>>>
>>>>>>
>>>>>> The root issue is that tests/Makefile.include is included *after*
>>>>>> evaluation of ninja-targets in main Makefile. Thus,
>>>>>> .ninja-goals.check-tcg is ignored.
>>>>>
>>>>> So this replaces patch 1/16 - I think we have a circular dependency here.
>>>>>
>>>>
>>>> Indeed, I didn't notice the duplication. While it solves things under
>>>> Linux, it doesn't trigger any build on MacOS, which is what you observed
>>>> also. I wonder if it's a gmake vs whatever-make difference.
>>>>
>>>> Another solution that seems ok on both platforms is to use (harmful)
>>>> recursive make:
>>>>
>>>>  .PHONY: check-tcg
>>>> -.ninja-goals.check-tcg = all test-plugins
>>>> -check-tcg: $(RUN_TCG_TARGET_RULES)
>>>> +check-tcg:
>>>> + $(MAKE) all test-plugins
>>>> + $(MAKE) $(RUN_TCG_TARGET_RULES)
>>>>
>>>>  .PHONY: clean-tcg
>>>>  clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>>>>
>>>> Or maybe just leave it as it is? Doc already mentions build should be
>>>> done before running any test to avoid missing binaries.
>>>> Hopefully we'll completely move tcg tests to meson one day, so there is
>>>> no need to deal with make idiosyncrasy anymore.
>>>
>>> The blocker for that to happen would be meson knowing about anything
>>> else than the host compiler and singular cross compiler.
>>>
>>
>> Meson indeed supports a single compiler + cross compiler at a time.
>> However, you can directly generate cross binaries using a custom_target
>> or a generator object. This way, meson would generate programs without
>> having to know it's a C compiler. Since all files are single source,
> 
> That is an incorrect assumption - the softmmu binaries especially have a
> multiple objects which are linked together.
>

custom_target can solves this.
*Most* of tcg tests are single source.

>> it's not a problem, since we don't need to declare them.
>> Generators have the advantage of being less verbose (you declare only
>> once how to use them) than custom target when used several times.
>>
>> https://mesonbuild.com/Reference-manual_functions_generator.html
>> https://mesonbuild.com/Generating-sources.html#using-generator
>>
>> See a full working example below:
>> ```
>> $ cat meson.build
>> project('cross_compile_tests', 'c')
>>
>> cc_aarch64 = generator(
>>                find_program('aarch64-linux-gnu-gcc'),
>>                arguments: ['@INPUT@', '-o', '@OUTPUT@', '@EXTRA_ARGS@'],
>>                output: '@BASENAME@')
>>
>> tests = [
>>   cc_aarch64.process('test.c'),
>>   cc_aarch64.process('test2.c', extra_args: '-lpthread')
>> ]
>> # we need a target that actually uses tests
>> executable('test_aarch64', 'empty_main.c', tests)
>>
>> $ mkdir -p build && cd build
>> $ meson && ninja -v
>> [1/4] /usr/bin/aarch64-linux-gnu-gcc ../test.c -o test_aarch64.p/test
>> [2/4] /usr/bin/aarch64-linux-gnu-gcc ../test2.c -o test_aarch64.p/test2
>> -lpthread
>> [3/4] ccache cc -Itest_aarch64.p -I. -I.. -fdiagnostics-color=always
>> -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -O0 -g -MD -MQ
>> test_aarch64.p/empty_main.c.o -MF test_aarch64.p/empty_main.c.o.d -o
>> test_aarch64.p/empty_main.c.o -c ../empty_main.c
>> [4/4] cc  -o test_aarch64 test_aarch64.p/empty_main.c.o -Wl,--as-needed
>> -Wl,--no-undefined
>> $ file test_aarch64.p/test*
>> test_aarch64.p/test:  ELF 64-bit LSB pie executable, ARM aarch64,
>> version 1 (SYSV), dynamically linked, interpreter
>> /lib/ld-linux-aarch64.so.1,
>> BuildID[sha1]=8162b8f045880c75118958ad46be78ed75bb708d, for GNU/Linux
>> 3.7.0, not stripped
>> test_aarch64.p/test2: ELF 64-bit LSB pie executable, ARM aarch64,
>> version 1 (SYSV), dynamically linked, interpreter
>> /lib/ld-linux-aarch64.so.1,
>> BuildID[sha1]=eed48625e02cd436a2708f94e5dd9ce6d5c162a9, for GNU/Linux
>> 3.7.0, not stripped
>> ```
>>
>> We'll need to remove the mechanic to build cross compilers containers.
>> In my experience, it's clunky anyway and fails when building several
>> from scratch. Try it yourself after cleaning your docker/podman images.
>> It's just better and simpler to expect user to install cross
>> compilers.
> 
> That would loose a bunch of functionality and doesn't help users running
> anything that isn't Debian.
>

Out of fedora, who does it exclude?
We can still provide a fat debian container with all cross compilers
embedded for people who don't run ubuntu/debian.

>> The only thing that prevented me to implement this before is that I
>> didn't know if concerned maintainers would accept it, or just hold onto
>> the precious handcrafted Makefiles, into which so much energy and time
>> has been spent.
> 
> There is no desire to hold onto Makefiles, but I do want to keep the
> same capabilities as the current system. The driver for containerising
> the compilers was that setting up cross compilers is a barrier to
> contributors who want to be able to add and build tests.
>

Personally, this "smart" layer has been a barrier even on Debian, since
by default it tries to build them, and it fails from scratch.
Give it a try by purging your docker images, and run a make check-tcg
-j$(nproc). I doubt anyone is really running check-tcg with this in real
life.

But well, if the cross-container thing is *really* a blocker, we can
just wrap build and run in a script per cross compiler, that does
docker/podman build && docker/podman run and call that.

Now we solved the problem with system tests, and cross compilers, is
there another thing that is absolutely needed from Makefiles?

>> If it's not the case, then we should definitely move into the direction
>> of migrating all this to meson, and rely on meson tests infrastructure.
>>
>> Regards,
>> Pierrick
> 

