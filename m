Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0D7CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdnt-00079u-DR; Thu, 28 May 2026 12:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSdnq-00079c-ON
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:41:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSdnn-0005Ru-Gz
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:41:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8veEp3546066
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 16:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2bUluZ9F+NJHwNYzI2ehv3Bp3qp/WE50+Xadx2XJtoA=; b=HlCraGMamoei5F1h
 fyXBv6ofOt7yQ50iK2wwfLzXo0EpQ/nDX0Jhqick3Pw7gQYxc8epSQg5+V567jIy
 1NGJM8yw4obohC/ziKN73CWsN8XiXHYI7t3ko3IAa5m9UNF8yrg8y+sbqGZovWbt
 pflcN+1GNAzCtdoszYbvIDITjNOqvFVbLkMsDaVah9qCbtWLh3Thuoa3T67yTLmL
 6MIyhtNjistG06xGx8rRshTMEpoqqk3C0OJ1F3PbfKZU+4Nn4RcWlDq0Ayt8hwkY
 vnd4mjWJ8ZQWQQunrNWo/mr/fxNQSdr9G1/02ZNu7rFLjtoSY9I3JZ0iEF/0RhMW
 kJszPQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y3uqgy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 16:41:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304d8e9563eso2273177eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779986504; x=1780591304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2bUluZ9F+NJHwNYzI2ehv3Bp3qp/WE50+Xadx2XJtoA=;
 b=Vty5cpjlG3//u/Bm1Ml6yDmb//pi3UTUY6fHat+5WmleuvVlc0DvgU4fS2M5IDCJ4n
 1/MtVwUfA9swCAH38JdSMxM4WZIvubhYk/diMh3saAQy/HgrwBhIyfLXpeG6A+5qnro/
 dMUiooAwRd0Lg89arHOc4fHGveX8swr2Z3IAh9ga/cTwm2aJhrV5/2eaWmPtONeSvc4d
 RtDq5XMa+V522ob/luG7UbcpjtS3mrpSwUH1pEDjDqH2QbTg5dtsTYxk244F/gyI3+BP
 N0P3y5SS1nzoY1+ljL+YvctSZmMuexny5/00wyAGxa5ru1nQgA2AMFzHLGxGLAfFPp/z
 3w8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779986504; x=1780591304;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2bUluZ9F+NJHwNYzI2ehv3Bp3qp/WE50+Xadx2XJtoA=;
 b=ZZazZpDgrkY3fH5v4G6Qtf83kNAAU3wuLQK8jzYI6tMUPDXYvb9q8T3HxbNEOm1rP3
 0kr8dJsCewNLui6fTw9M7RN2PbWHpBWovbhyZvcXX/atPxqs98QteOSKtvzS5mMqIbKU
 MjDaIUEimpBHJj+PXvkex2JslCUJ0Dk7VGdAjO8eUMFUhgdDaW6iikUaJbiONDMbDdWj
 lbYrVG1ODgUsLo0lGlpOf1sKSk4X4X41nfbvc7GVFcFyr7I0Y5y2tc8pi56YdKd5m5iR
 Bgq2FW1JJVay1HZC2BXHILrTuWlRBMvGuBQZuNABwumCtZX2j4wRrEo1VUteaROr5xRe
 AeWA==
X-Gm-Message-State: AOJu0YzkZL7frd07hN8/ZzL1LmNcOhr+8QK5YfgIuiW+kMlkwXyQWZdV
 HpqeijWHJvpL/ucQWFNvAfm10ZkwALPWGOB63srznOmcM/4EKPuznICioRR0NrpGN+9y/VKF9AT
 KpyLgHxBa2jXbIB0pvXiv8JwUGFs5Xi6Dq5FEvEZ6Vfme9dzHxaQAi1qBAg==
X-Gm-Gg: Acq92OHvl2WUBq2aAox2Y/BJ1v+NBlCWFkt3dAsr5ARaW58FrhwNWBBQqTGXHGE3QbY
 MvawJGTXHwhixlO/Dqwjt86gZ6S8QMReBs+uj1H7TH8pZstqTSqOYe7MmmLS7CVm1d89YYPCbmt
 u8/wgUVocOjBh0xJu704Pr+FVzhoK21nKtQmKL/0GwPs+6JsX8mHlnoicSEU1dk0j4lJEeSsEIo
 2PC+Rn3IU2y6oiVbDFUmpAB9xL5XcV72iTUOWrCSEUWUV802AVurol4iqtuSGU6PsrEnN9b6orp
 bbQEvGtmTpdVFpiG2bMcUSTNnWc3ex9d0pg7zerwu+/wXj0nAEK6kX2pk94M6FP65uI1xm6QBm5
 Uq6THkCoOIZvJkwqhnf3JRz2bYfXc17gptFvFpGx7Zu3L8TNMEehrH1/GT4G4ASMmRHIgs0jY1c
 IhORMPrtFP8AGGQlrs4j/6RLwj
X-Received: by 2002:a05:7022:785:b0:137:8921:4feb with SMTP id
 a92af1059eb24-13789215187mr1008813c88.36.1779986503486; 
 Thu, 28 May 2026 09:41:43 -0700 (PDT)
X-Received: by 2002:a05:7022:785:b0:137:8921:4feb with SMTP id
 a92af1059eb24-13789215187mr1008786c88.36.1779986502809; 
 Thu, 28 May 2026 09:41:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-136b2b1f2a6sm10376371c88.4.2026.05.28.09.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 09:41:42 -0700 (PDT)
Message-ID: <5a4eedbb-483c-40ea-a4dd-b34a4b7d7b6e@oss.qualcomm.com>
Date: Thu, 28 May 2026 09:41:40 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87o6hzx2np.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zexX76cqA9MWRhHcVYmlkqbFheKAdxh5
X-Authority-Analysis: v=2.4 cv=JMYLdcKb c=1 sm=1 tr=0 ts=6a187048 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=aH6wyVqFEdXD62tIoK4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: zexX76cqA9MWRhHcVYmlkqbFheKAdxh5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE2OSBTYWx0ZWRfXzB6OKGas5ZHD
 XSHhc2iDry5xyzsiKElc8VYOOeaVUK0YhBDAq+QDNUW4RxO3P4/VJ9/2UkA647L8eCSeVg1xB+p
 YiJtnjW2k0JAmTnVwVKfjqvXMuc0UqKGtKJUScyPMMNONDH0VET2j6EMPJRSCiZB3sJNybkfbQD
 MvlPVFPzNTb7xWhGAMq7MoDkoijFyUqmaE1+rIrI/fwRqXAGSulJmyom0++Z6ZqlyOJ7szKWyWd
 +fVCIn/IG7YSIC0cT+R5y5dCk2TotAqd3pXY8UhDc5sSLJ125ks5hCsbEMWrophRv8BIZm/1ZMR
 tzKLh6xiJH/y6QmTSgSXsLv6cfgbOIzaug0TzjFCjbQ2SghJS4Cb9XTu4W8wRUcep5BaHHaxxOS
 AIIf4fS9HPuLgfwjJsKztHUvbA8cgBY5dzsL/3Abi6Ag0zz8fV4gn97IWNM5OFWUBjG8KCwTiOn
 uxqV9ekSVwbtj7ueCeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280169
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

On 5/28/2026 3:13 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 5/26/2026 11:17 PM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
> <snip>
>>>
>>> What do you mean? I run check-tcg all the time.
>>>
>>> Which containers fail to build for you? The main cross-compiler one
>>> (debian-all-test-cross) is built all the time.
>>>
>>
>> Build is working out of the box now.
>> However, it seems that only tests for aarch64, arm and x86_64 are run
>> when using containers without having installed cross compilers.
>> Maybe it's another carefully handcrafted feature of tcg Makefiles?
> 
> Works for me over here. Do you have podman or docker installed?
> 
> It's true the Makefile has to jump through some hoops to compute
> TCG_TESTS_TARGETS from TCG_TESTS_WITH_COMPILERS (config-host.mak) and
> CONFIGURED_TCG_TARGETS (via $(wildcard *-config-target.h)). Is that
> where it fails?
>

Maybe, I reproduced that on two different machines, with different
architectures. As you know, Makefiles are complex to debug, which is one
of the reason I would like to get rid of it completely.

I prefer to spend time replacing this, instead of investigating N days
to understand why a dependency is missing (similar to the current patch)
and solve it by adding new cryptic lines in an existing Makefile.

> As I've said before I'm not wedded to Makefiles, in fact I would look
> forward to a world when I can run an individual test directly from
> meson. However I'm not prepared to throw away functionality, especially
> the ability of new developers/testers to build the tests without having
> to install cross-compilers. That would take us back to the *before
> times* when TCG tests where hardly ever run and tended to bitrot.
>

Sure, I agree with you. The transition should not change anything,
except how to run a single test. We can easily replicate the container
functionality in meson I think.

I just had the impression, previously in this thread, that instead of
saying "Sounds good, let's explore the meson approach", the tone was
more "this is wrong and this can't work, please don't touch this". Maybe
it's just a communication issue.

I made the effort to show a minimal example to prove you can compile
stuff without having to declare a toolchain in meson, which was the
"blocker" you mentioned. The rest, multi files tests and using a
container instead of an installed cross compiler, are just small
details. The key is "we can build a custom binary using a custom command
with meson", and that's all we need to move forward.

>>>> But well, if the cross-container thing is *really* a blocker, we can
>>>> just wrap build and run in a script per cross compiler, that does
>>>> docker/podman build && docker/podman run and call that.
>>>
>>> We still have the remnants of that in the docker.py script although for
>>> most containers we moved to invoking docker (or podman) directly.
>>>
>>
>> Maybe that's why I encountered issues in the past, and now it works out
>> of the box.
> 
> The original script attempted to deal with caching layers and the
> consequences of custom USER/UID on local machines. Nowadays it is mostly
> used as a basic wrapper around "probe" for the runtime and is still used
> by the binfmt_misc and toolchain wrappers.
> 
> For porting to meson it might be worth just having a minimal wrapper
> just for building rather than mess with it.
>

Yep.

>>> Also bear in mind the containers are also used to cross build QEMU
>>> itself. 
>>>
>>>>
>>>> Now we solved the problem with system tests, and cross compilers, is
>>>> there another thing that is absolutely needed from Makefiles?
>>>>
>>>>>> If it's not the case, then we should definitely move into the direction
>>>>>> of migrating all this to meson, and rely on meson tests infrastructure.
>>>>>>
>>
>> To add on top of this, I would be happy to help with the transition, but
>> I want to make sure you'll accept it first, with a list of
>> requirements.
> 
> For check-tcg the requirements are simple:
>

Thanks for listing them. We can have specific test suites to address the
categorization. For the rest, there is nothing custom targets won't be
able to solve.
>   - support building tests with containers
>   - handle all existing tests
>     - per-arch *-user and *-softmmu
>       - including post test validation checks (conditional-diff-out, validate-memory-counts.py, etc...)
>       - per-target overrides (some targets are broken for some tests)
>       - custom QEMU_OPTS for some tests
>       - including sub-arch tests (e.g. x86_64 includes i386, mips64el includes mips64 etc...)
>     - multiarch tests for all *-user targets
>     - multiarch tests for all *-softmmu targets with boot.S
>     - gdbstub tests
>       - don't forget gdb feature probing for arch and arch features (e.g. GDB_HAS_SME_TILES)
>     - record/replay tests
>     - tcg plugin tests
>       - modulate plugins over tests to avoid combinatorial explosion
>       - filter some plugins from general testing (e.g. patch)
>       - filter some plugins based on mode (e.g. syscall)
>       - specific plugins with specific tests (e.g. patch, memory)
>     - support build variations
>       - compiler feature probing to gate tests
>       - custom cflags for some tests
>       - alternate cflag builds for some tests (e.g. sha512-[vector|sse|mvx|...])
>       - build scripts (e.g. test-mmx.py)

I have a proposal: How about I give it a try with a specific target
(let's say aarch64?), to try to cover user, system, and multi arch
tests, without the cross container as a first step.

This way, we can focus on testing part, agree on what works, what
doesn't, and iterate until having something nice.
Then, we can add cross container support, and finally add the rest of
targets. Once all of them are implemented, we can migrate check-tcg
command to this.

What do you think?

> 
> with meson TCG_TEST_FILTER should be obsolete.
> 
>> I'm a bit tired of seeing patches in your subsystems get stuck for
>> weeks, without any proper review, to finally be (re)posted again in a
>> new series, blocked for more weeks, and finally reach upstream one month
>> later or worse. It's truly exhausting for everyone contributing in such
>> places.
> 
> What can I say - reviews are welcome. I always list what patches are
> still waiting for review in the cover letter. I should also add for
> testing/next I try to be extra careful that regressions don't slip in
> because keeping the testing sub-system stable is important to support
> things like bisection.
> 

The main issue with your personal workflow, which is "reposting existing
series concatenated in a new single series", is that it adds a lot of
latency. Basically, if one patch fails, or is not reviewed, the whole
thing is blocked. And that is a problem. I don't see what it's supposed
to achieve, since it's halfway between a series, and a PR, without being
one or the other.

TLDR: the problem is how long things are between receiving reviewed-by,
and being in a pull request in your subsystems.

For instance, in current series, there are multiple sub series. Some of
them are fully reviewed and ready to go, they can be sent as PR
independently.

I remember you mentioned several times that you like to have a "single
branch". I have the same workflow, and it absolutely does not prevent to
send multiple PR or series in parallel.

If tooling is the limitation, please take a look to those (ugly) scripts
for inspiration. AI can probably rewrite this better than me in 10 min.
With this, sending a series or a PR is a complete no-op for me, I just
wait for CI to run, and send it when ready 2h later.

# prepare a PR from a given list of series on the mailing list
# it ensures every commit is reviewed and passes checkpatch
https://github.com/qualcomm/qemu/blob/pbouvier/master/pull_request_publish_from_series.sh
# it uses this script, which is used to send a series or PR,
# pushes branches on github/gitlab with CI on both platforms
https://github.com/qualcomm/qemu/blob/pbouvier/master/publish.sh
# Then I send the PR (from existing branch) using:
https://github.com/qualcomm/qemu/blob/pbouvier/master/pull_request_send.sh

Saying "people have to accept my tempo" is not acceptable. Fix the
tooling instead.

Regards,
Pierrick

