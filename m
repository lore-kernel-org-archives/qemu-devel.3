Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF8ACD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 21:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUskQ-0002Sk-KP; Wed, 03 Jun 2026 17:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUskM-0002RS-MD
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 17:03:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUskJ-0007Hw-Pi
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 17:03:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653JZ5kp1039436
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 21:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YOyiiGvLyzJ5lPW+qRIUgntNvI5whldcE4+IuyfOcm4=; b=JFufnc6lL2fn8Tgf
 4XSW4TAi4I3T2t3L2EwnGcbwBqHKeMLE+Jbv7oFeBN+SAkCDRl8rNliWJusCawlx
 cxLensJj07FpCQ3NWzAOEUNzZ2gm7ggBse/ioSZKRnUbFCQifT+LMAeWAt1WUiaJ
 Td8N15W2OvoQleV2kA7A5m4HZV/n9ksfkm9MkvZD0bqEzAUScwRWXqouxFfo0YmH
 qFUwds3fVY2Fy+9N+39HmtmqRhs596/tgACn1ISGmyIpbMHjXVs0o4RTzDMxgHj2
 YVJBpxNjK6GXLOmj53dXPVcVSttF5orVazuJ/OkrJ3BA7nIIzReGGxiGJRIoKbb/
 vbKijA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejtj8ga2j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 21:03:25 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304dd917645so6285048eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 14:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780520605; x=1781125405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YOyiiGvLyzJ5lPW+qRIUgntNvI5whldcE4+IuyfOcm4=;
 b=IyXnz2Ez7EqiDNWvYuYc/hGgVed/ZQkcO1RNglMA0TOL5pF+31BXMlIBVQO5zT0h8X
 /QTNwuMLRVH7byel4ect3JJtjRbhLl7QvDJLiD//au/5w7SgYcjEYkIxF8YTfQPw5alp
 hQT3sFluTtIWee7uRPxuY6cGgjSsYCmPcce3FiW5KlOhzsLHKsaz2J8YLNAFFmuC78rM
 G6rV0iP5tHzxf16DyEUCNHIzf2EX/iK/E4VaVVy+ZIGnvnP+gPYXyM5fK+z8ywNRkAx4
 gprZtM6nM90Jrs5rGMJ456RVzcZzc476tuarNVB7Nwg8zJXoYEjkaHBDhyUtXvt7udQD
 lW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780520605; x=1781125405;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YOyiiGvLyzJ5lPW+qRIUgntNvI5whldcE4+IuyfOcm4=;
 b=CYwm04/EmvliXmC6a+9S4T/OjNqGas3xK15XYSgHGatWiSVrRRsqq9/rbzXIIq0fEs
 38FpuSyRYKSs2PrsHV6xCq27FEE/4DNuNExIhCG4ytsIuV7gDI6tRMdtj41atWKM0dRk
 7+kKVo1M8h4RudNw8BsE80dPtRUKPx4UiI9wMXsZrCuTqglebKkx+hvEJkinaC1WDJQU
 pTvUs9KO2XYYL5oatvDF7mI0Jc3rje7euOZgUKTujmgIDyW7sGKErT1KywCmCI/xDoTr
 Gn3NHcnbSoO/UFmBGOPPPEWSU1KqhZvYrd4I4VkqBI8FkXeoPK1VHvr8cbcZim57lm1g
 eutw==
X-Gm-Message-State: AOJu0YyFip4J+bKg6t9725+807icCVqEllL34v/h1rZXEuAsIUQHY5qu
 a2juf7dgIUMZxqr/7ED5y/EP9Bu/EO3Gy0QAwljtDbwAHF+a04q0oJWA8YPq5mUYQPRi2Gcvnl/
 ILSywGS840Sc+RhJITfu16sGJfvoGCXXOdT7JfXx9mIBZKt2oZQ+Cmxe5FQ==
X-Gm-Gg: Acq92OHmA5oaBolL725hobca1wmV1/wiCpEV5bhfN/Zk77ifUUikPVsrywbYu3+RK91
 e/QLG4JiQP3g47zT/hzJlxViaJEdu3FXRULqS8r8V4JB9uWd1BmoD7YIUraIevlwbAaiUIWJHH5
 3PlwSuJREnuRMAc8FwXR5uk8xDuKXC1pZiPdIwdNaA/iAhqYiEYe2+2TR7RTv8+FePMQLE3t/Kg
 5hyWhsdYBL/+BJB2DEK64S+cVZS9seq4T1JeXtUVlSNMPAj2Wfk+w5mxMaOZsGRt7IPTpKXUYwG
 ggapewl73lXyyo6nDvM6WN3IcRy35ZpvkLR6gXK5XVDhqDbqX2sqy3BSJi7oeEsZ519dXyb1AI6
 nwFgNrO8ZLy05PBcKA9AbYqWJdNCd0tF94gwWEKvbg1uN2NScpUDtaPTCQTRWTSDbO7skocAZwt
 8yfj58EnlGFM26aFZV9/a+TX79
X-Received: by 2002:a05:7300:6ca1:b0:304:835e:fd25 with SMTP id
 5a478bee46e88-3074fa571ddmr2880218eec.4.1780520604957; 
 Wed, 03 Jun 2026 14:03:24 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca1:b0:304:835e:fd25 with SMTP id
 5a478bee46e88-3074fa571ddmr2880184eec.4.1780520603964; 
 Wed, 03 Jun 2026 14:03:23 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db55f60sm4341750eec.6.2026.06.03.14.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 14:03:23 -0700 (PDT)
Message-ID: <bab26b3e-58c2-4009-b230-4cf54b620a49@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 14:03:21 -0700
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
 <8a878679-733c-451c-8053-663a74f8d4a7@oss.qualcomm.com>
 <87a4tlz897.fsf@draig.linaro.org>
 <86385e93-5425-4145-8a9f-0f72ed5de022@oss.qualcomm.com>
 <87o6hzx2np.fsf@draig.linaro.org>
 <5a4eedbb-483c-40ea-a4dd-b34a4b7d7b6e@oss.qualcomm.com>
 <87wlwfsay4.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87wlwfsay4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: t_wTmALW9ryG2my-NFYhFnYrZ1Kiflv3
X-Proofpoint-GUID: t_wTmALW9ryG2my-NFYhFnYrZ1Kiflv3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX61BnInl4NYLF
 bDfkiJz+zFB/Q7lCmYXwM9oBQeMGGtRmM3NpyuxlYWR5O26GtmUVD0Fa7l/8PLvHcXECjPHpdHG
 cEOyLJHnTPZZ3hXeDGn2+Z53Anjdjjbkubte+te2lKTOCDEB+siW8gpE4qN606uuDGzASIT2K7B
 bOR2OUgYjIsFKUKnBi4k9Sa4D7rJJW516UWHGqucsgksjX8123NWvKINiJY5dY4zrlL7tqYcVSN
 zYunhvecExmLHQgiGg3kK+XEGVtDaohS9UUwr+I8lOoK7qe64/dnZd7lnFd2q6oqxoaX5P2v9Fg
 vKqCaE6w4heF+hGWxLq6W5ctZGAm/lKzbVxEXGYZstvBN0vWwaahMfa9YHTQlBtikweqn4JV6d2
 VTJjGufsCAFRrAy6F7Cz4co6c3PYeagm3PdMfbcY/OteD0Zq1q+/fWQ+u6GOYZ0dx3pZ6tWAxfm
 Q2tZff4caGa/xj10xvw==
X-Authority-Analysis: v=2.4 cv=f4p4wuyM c=1 sm=1 tr=0 ts=6a20969d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=wXoOh2Y6ts7LvPVPfYkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030203
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/3/2026 12:03 PM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 5/28/2026 3:13 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 5/26/2026 11:17 PM, Alex Bennée wrote:
>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>
>>> <snip>
>>>>>
>>>>> What do you mean? I run check-tcg all the time.
>>>>>
>>>>> Which containers fail to build for you? The main cross-compiler one
>>>>> (debian-all-test-cross) is built all the time.
>>>>>
>>>>
>>>> Build is working out of the box now.
>>>> However, it seems that only tests for aarch64, arm and x86_64 are run
>>>> when using containers without having installed cross compilers.
>>>> Maybe it's another carefully handcrafted feature of tcg Makefiles?
>>>
>>> Works for me over here. Do you have podman or docker installed?
>>>
>>> It's true the Makefile has to jump through some hoops to compute
>>> TCG_TESTS_TARGETS from TCG_TESTS_WITH_COMPILERS (config-host.mak) and
>>> CONFIGURED_TCG_TARGETS (via $(wildcard *-config-target.h)). Is that
>>> where it fails?
>>>
>>
>> Maybe, I reproduced that on two different machines, with different
>> architectures. As you know, Makefiles are complex to debug, which is one
>> of the reason I would like to get rid of it completely.
>>
>> I prefer to spend time replacing this, instead of investigating N days
>> to understand why a dependency is missing (similar to the current patch)
>> and solve it by adding new cryptic lines in an existing Makefile.
>>
>>> As I've said before I'm not wedded to Makefiles, in fact I would look
>>> forward to a world when I can run an individual test directly from
>>> meson. However I'm not prepared to throw away functionality, especially
>>> the ability of new developers/testers to build the tests without having
>>> to install cross-compilers. That would take us back to the *before
>>> times* when TCG tests where hardly ever run and tended to bitrot.
>>>
>>
>> Sure, I agree with you. The transition should not change anything,
>> except how to run a single test. We can easily replicate the container
>> functionality in meson I think.
>>
>> I just had the impression, previously in this thread, that instead of
>> saying "Sounds good, let's explore the meson approach", the tone was
>> more "this is wrong and this can't work, please don't touch this". Maybe
>> it's just a communication issue.
>>
>> I made the effort to show a minimal example to prove you can compile
>> stuff without having to declare a toolchain in meson, which was the
>> "blocker" you mentioned. The rest, multi files tests and using a
>> container instead of an installed cross compiler, are just small
>> details. The key is "we can build a custom binary using a custom command
>> with meson", and that's all we need to move forward.
>>
>>>>>> But well, if the cross-container thing is *really* a blocker, we can
>>>>>> just wrap build and run in a script per cross compiler, that does
>>>>>> docker/podman build && docker/podman run and call that.
>>>>>
>>>>> We still have the remnants of that in the docker.py script although for
>>>>> most containers we moved to invoking docker (or podman) directly.
>>>>>
>>>>
>>>> Maybe that's why I encountered issues in the past, and now it works out
>>>> of the box.
>>>
>>> The original script attempted to deal with caching layers and the
>>> consequences of custom USER/UID on local machines. Nowadays it is mostly
>>> used as a basic wrapper around "probe" for the runtime and is still used
>>> by the binfmt_misc and toolchain wrappers.
>>>
>>> For porting to meson it might be worth just having a minimal wrapper
>>> just for building rather than mess with it.
>>>
>>
>> Yep.
>>
>>>>> Also bear in mind the containers are also used to cross build QEMU
>>>>> itself. 
>>>>>
>>>>>>
>>>>>> Now we solved the problem with system tests, and cross compilers, is
>>>>>> there another thing that is absolutely needed from Makefiles?
>>>>>>
>>>>>>>> If it's not the case, then we should definitely move into the direction
>>>>>>>> of migrating all this to meson, and rely on meson tests infrastructure.
>>>>>>>>
>>>>
>>>> To add on top of this, I would be happy to help with the transition, but
>>>> I want to make sure you'll accept it first, with a list of
>>>> requirements.
>>>
>>> For check-tcg the requirements are simple:
>>>
>>
>> Thanks for listing them. We can have specific test suites to address the
>> categorization. For the rest, there is nothing custom targets won't be
>> able to solve.
>>>   - support building tests with containers
>>>   - handle all existing tests
>>>     - per-arch *-user and *-softmmu
>>>       - including post test validation checks (conditional-diff-out, validate-memory-counts.py, etc...)
>>>       - per-target overrides (some targets are broken for some tests)
>>>       - custom QEMU_OPTS for some tests
>>>       - including sub-arch tests (e.g. x86_64 includes i386, mips64el includes mips64 etc...)
>>>     - multiarch tests for all *-user targets
>>>     - multiarch tests for all *-softmmu targets with boot.S
>>>     - gdbstub tests
>>>       - don't forget gdb feature probing for arch and arch features (e.g. GDB_HAS_SME_TILES)
>>>     - record/replay tests
>>>     - tcg plugin tests
>>>       - modulate plugins over tests to avoid combinatorial explosion
>>>       - filter some plugins from general testing (e.g. patch)
>>>       - filter some plugins based on mode (e.g. syscall)
>>>       - specific plugins with specific tests (e.g. patch, memory)
>>>     - support build variations
>>>       - compiler feature probing to gate tests
>>>       - custom cflags for some tests
>>>       - alternate cflag builds for some tests (e.g. sha512-[vector|sse|mvx|...])
>>>       - build scripts (e.g. test-mmx.py)
>>
>> I have a proposal: How about I give it a try with a specific target
>> (let's say aarch64?), to try to cover user, system, and multi arch
>> tests, without the cross container as a first step.
>>
>> This way, we can focus on testing part, agree on what works, what
>> doesn't, and iterate until having something nice.
>> Then, we can add cross container support, and finally add the rest of
>> targets. Once all of them are implemented, we can migrate check-tcg
>> command to this.
> 
> I think that's a reasonable plan. We can certainly test and review
> patches as we try different things out. aarch64 is a good first target
> as it has user, softmmu and plugin specific tests.
>

Yes, this should give us a good taste of what it will look like.

> What we can't do is merge piecemeal so I'd want a complete conversion
> before we merge so we don't end up with a half-functional port to meson
> in the tree (the bane of QEMU's API conversions).
>

100% agree. Even if it's a slow development over months, we'll replace
Makefiles only once all the features are properly covered.
 > <snip>
> 

Regards,
Pierrick

