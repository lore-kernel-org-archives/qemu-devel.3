Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3611CD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXNwm-0007kV-41; Wed, 10 Jun 2026 14:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXNwk-0007jv-CA
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:46:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXNwg-0007ak-Dd
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:46:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AIhRbd2405686
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TxH0yAqsdXCcW7rktAkEwH4i1kR2KWX5hSOKgcpSlnE=; b=KuU/YdOPqeCs5i0z
 WA3wS1simYnlAgTu3hwfx+NDek09ym1qa80HVY8Qq8kMXt7t36HajSijrJIL7gcV
 PS5Nu7EnIeD45eQzsUW2azv+ILwaNuHYrdx2L3riTopfbLcHLj8zfbYcPSj729Ha
 OPD7a6hd9MeUjY4KMg9NHOuMPEtbVokxw+BjiGX91lX0KFHrXrcf/sJWF8C2UPxU
 IuHsKox+gpQcOIJfSePpUvb/Ri6rrpEiudlzbT1OU8l16K8Z0cFyFBMK+UC+VUOz
 NpAgpE5N/U+064wL5Tl/omG0wOd7TdpxY6Ql4hEZ70pW1DhXeWPs9hUpra4eyPc6
 imI0Vg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqdeug0er-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:46:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3074d4102a9so5448196eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781117191; x=1781721991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TxH0yAqsdXCcW7rktAkEwH4i1kR2KWX5hSOKgcpSlnE=;
 b=VD0CK3EvHGZHjaX95MU952jIGlrA3YG2uUNlaUcQIS/aF7HUUPrK0qNKxzd7RYv/M6
 cuPtyk/FTLd3jt2U0rW1CuhMMjS5OOND4YXRH3Uk8v/jOKdbefoBdw9+ia+WVMzedljF
 jRNMPSFIutejNqxvJKNiRqJhTqy/w3ba6C3NOObK3NwLi65kcNIj99B7KiJGoUrET2Fa
 SmYaCF0NBAJoX9pDS3hPT3l9vGjPNx3X/93QKNQJhSGQAfHZolcdAMuGWZfm246MMHPc
 RTKJyQJmAKAc02We3Su3MuWflB0Ab6rIWjnch7ePuz4F1Dgdfq6zqgPSFKChs7b/HT1T
 LoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781117191; x=1781721991;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TxH0yAqsdXCcW7rktAkEwH4i1kR2KWX5hSOKgcpSlnE=;
 b=m5dD2Fm50lepmLs2QH7sg03zZmBpXhzKZK0YjVVO1zrXB05DoeFs7F+2ORcy6obJfE
 TEYW2+/eqLCKZPOp3V5Or0wKndrJWc+xWbdjsn6WQHrwT4WLkFkL4hcQhzn6sVJWmw6W
 MSfkFSdC/UTEaR0jKXde1jY6skj8GU8XQViBw7JUAY5aXldlpZ6suAp8rCvVqTicYMX+
 /0HXBeDPcBOxPntKQX4lSuQYZ2YsE54NlICHTwVOuKNTGF2Pn8NAzkGLCHjGmGosEmlr
 iJrB45vLRlezyQcdOE0LfMwHrZPQsyvs35jgagmLDGTMi7d6/ZzKIOJz3jS2r/p9EzVD
 TMkw==
X-Gm-Message-State: AOJu0YyByKAMlMikEUPj8EqD9zZQZCx95vCJ6G+Eluj2X3tv8PFWrMUa
 pxAocouP+MSpVM6oSjJwf/46vVDvDxP8kJ8r0/oTfrtTqXuIggyKK5ci6J6h4lx/x51feOdqYxV
 3n/bV9gt8G6WNnYgT1OLQSkbpOjqO6p6+lOfXXvhHc5eUheDBXfzAtM1O/A==
X-Gm-Gg: Acq92OEBTgRBpWpjawd+ItBc/Mtl5lAQ4nwVA1Cymf6Ig1DbLgImjOX0D4df8azsOI1
 eFdRrxtL78ijIpFiUeecI/W+jGtUoSf3hsdWAAKnQ5yrANiwfG+GgRiYVaq5rnhF9mZf1Uy7/Eb
 SPomo57wYIrayrkXYW8Q2+rDnkd8Tz0wS/4EPS3OweV9Xmp7eukDfbXTtMtZX6Zp1115bb28DAt
 8EJ6AmNdrGXGFSYSiQNWNJn1kIUSVCaTZd2DhfIXYjDlkIFz5aFCF0hHXSYkKe8hGHW0TeKVxpH
 R0XPXnBOqBG7VagYoo+qLiMpHSsGwu+YSE+BzNbWLWeJiSw2ZZcLezCjC70A2AGMuT68jzmrpC4
 NME09fTJ98hfGUM3Y8sbR8kplqlKuw/hHyclN8OC8sY4EsSPFyrZ9gArrPX1pbJneHoTaNWFmSA
 tyJz0WR54IBWjpk9u7y+pSt2zq
X-Received: by 2002:a05:7022:6ab:b0:138:267:af4a with SMTP id
 a92af1059eb24-13840b19990mr268529c88.8.1781117191206; 
 Wed, 10 Jun 2026 11:46:31 -0700 (PDT)
X-Received: by 2002:a05:7022:6ab:b0:138:267:af4a with SMTP id
 a92af1059eb24-13840b19990mr268488c88.8.1781117190565; 
 Wed, 10 Jun 2026 11:46:30 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5489d17sm18812365c88.1.2026.06.10.11.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 11:46:29 -0700 (PDT)
Message-ID: <149e8456-cfb2-4d98-9adc-69f7748293cb@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:46:28 -0700
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
X-Proofpoint-ORIG-GUID: EPuR5SOGauTfVVES8Lvp9OnMgSB3ZYYN
X-Proofpoint-GUID: EPuR5SOGauTfVVES8Lvp9OnMgSB3ZYYN
X-Authority-Analysis: v=2.4 cv=HJvz0Itv c=1 sm=1 tr=0 ts=6a29b108 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wXoOh2Y6ts7LvPVPfYkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE3NiBTYWx0ZWRfX/mmGXjIZNou+
 dTcMKqZZUasTqSl8Bmc5mFXgZp5EO59Qid+TcQ+dQrCijAXMBl8Gxv6vxwwH7p9taAXxo967uRa
 lmW49KVuvA8+DYzkEmW2q+uBxmAws0qVfUloNWfgibt+y4VuFFG616j45UQJRYQo2d9KVrZbRab
 /5WFRAZ3Czt7xjx0UFxm8kJ1c+YGJbjn4zLvOgIW1G2aez1Gzb48bbaio96Cn+0mlL8Bn7YgvQk
 BrvXXnUNvmqdA0rMwuf3Buqpl1IXSoOw+rlkZRglfVdrHT7r9AlAY/cMfcjzFODw4te+Nb0VOyP
 aFOSOistSTKuaMnlJWgo6gbrTqcr8WEufB7QgzHeG93bB+ALgCc7IH+ySZIoA5f7/7Pc0oCQPx+
 TiIwwTOHIRI8OrgRQOnmgj5TYVcGEb+8QShWgj1OYNisbdpHxoHfTzR8XSYOpvJliypywwLam+t
 OO/1pCZ5aOjpMOUMX7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100176
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Sent here:
https://lore.kernel.org/qemu-devel/20260609214745.772536-2-pierrick.bouvier@oss.qualcomm.com/T/#

> What we can't do is merge piecemeal so I'd want a complete conversion
> before we merge so we don't end up with a half-functional port to meson
> in the tree (the bane of QEMU's API conversions).
> 
> <snip>
>

