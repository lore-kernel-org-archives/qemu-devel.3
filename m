Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385FBCA0FE7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 14:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqYc1-0007v8-OA; Mon, 25 Aug 2025 10:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uqYbx-0007uS-N6
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:55:53 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uqYbv-0004RV-4e
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:55:53 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-246151aefaaso29530215ad.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756133749; x=1756738549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sSew+fkQvu+k086nQoRhde2nK4xteVbP5aJi2pbHq4U=;
 b=fvI+2T6JGADmB/7kimTXXmO+Nt3b8ZS/eWonVGlBA+z4NUB5EgYwUcK8rbHF0+4Wuo
 2hdmrG6JpeBlhDLFm86eMRIcN5hD2jC3z0LsZ0xCzgkWiGqIGXy4gKNMPJtqoWrrQUNX
 mvXRtGVtP4KcJewc1/jTeyNp+zBTSvEhJOqGidf/3TZCTTzXWTdbTvw3XS6zHfcxSBAG
 U8Zg67fDZZUz8w0Uk3wVE5ET0CF59jmNqWKPDxtfHx4XX71iUnYr1n/+8OIv2SasIRw2
 vkU7sATd3dXhZ9YfHJg1O5+kqcI+TxGIDYRZwo85gL//YAZQmYsuvyB1UnCLdMHFIoVL
 F2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756133749; x=1756738549;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sSew+fkQvu+k086nQoRhde2nK4xteVbP5aJi2pbHq4U=;
 b=Gs7Y8VuZMqrf/2lZRj40XgGwiWqTzsLoPpdr6zCATv7zaMPLV8lZA0jnIfgDOEJb/O
 oSPDXvE0in/8u89/v5urZwL3xL23yKLNcYLFsurtcdG3/AT0QA9FAdJYA8r4D6Uw4GMe
 g+hr3mEY3eeUMTPJQTluxVcSAw11A6p/vdjsX9zRZWQ+i3j/BuPHdIH1BHLcPsWbLU0i
 er9rO2tskrmfhsAGZ4Nf42+v1OP86aiadtPjP/c0Uf+99DVeH/9WEG2wX5Ty7G8jRWIN
 CwvnqFzkxVwpeZSYVVrcvfJsDYuaHXNl+DhhhtzgEiHN07MV9wrItpFFuyBo4adLyFuO
 G79w==
X-Gm-Message-State: AOJu0YwaEkJlNA0pPss1gCRZZusFSDxQ2ivV7Wy9/R0iPKe+Ug+mB6cX
 imUSzViCB1PoKPvFfptaQ+o4hmceeLYuoTJ3bvmEC5tHhnSudKdJZnwUotMIm8PQ5gI=
X-Gm-Gg: ASbGncutfSa5fY7zV2D6FHITKlrVCOv2xFUjgubLjmxBzUal151oOnfqZHxAGedDG6b
 2YbsIJfLIv39T1kmsdL1anUxef0xVczg0y3WxwVeKX40ilMweG3YEauz3RynKX7JFY/kQ9dZrq7
 4CM0xZM/wPN7lcuTmhboSuBxc9FU2GaClt2QAJ3DXXosUS3s+QlrXhTgCZXL+inB18n3kSClu9k
 n57sP7YeNImyTqBlKfiIc4f1Ue7OuikgW0QJZy/UMdjlX1e8yg15uCJsttO5VT+1EVytB+F7HTu
 3rUTwfmkGaS404NTJiIig1IWYTiMn1SJX1gHUqfLJfT/ACOsCaD5MMt+DB4ZMGAsrJs0GRzvrB9
 95U+q6uCP58Mdkk9dXDEL1ggZ6bG5SGrQ/A==
X-Google-Smtp-Source: AGHT+IEVKGvk2K0iCjlgHwOMs4yUt28Bo6wHO5OIoHPkLdmfTr2/n9L3vi0QiLfRc9o28lHjQVB5/w==
X-Received: by 2002:a17:902:c408:b0:237:f757:9ad8 with SMTP id
 d9443c01a7336-2460238bc7bmr191506445ad.1.1756133748630; 
 Mon, 25 Aug 2025 07:55:48 -0700 (PDT)
Received: from [192.168.0.102] ([187.75.38.174])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3254af4c347sm7227998a91.18.2025.08.25.07.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 07:55:48 -0700 (PDT)
Message-ID: <3e69b7de-bd13-44fa-8fc8-d5294fa2ca9e@linaro.org>
Date: Mon, 25 Aug 2025 11:56:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, qemu-arm@nongnu.org,
 1844144@gmail.com, Jan Richter <jarichte@redhat.com>
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <53b6e23f-5328-42c6-9c58-97ddbf3e5b29@redhat.com>
 <CAAjaMXaS6kpq9uOdd6Jgh7JXu5JUtrFjzPUdz5UfAJ+=ASg14A@mail.gmail.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <CAAjaMXaS6kpq9uOdd6Jgh7JXu5JUtrFjzPUdz5UfAJ+=ASg14A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Manos!

On 8/25/25 08:00, Manos Pitsidianakis wrote:
> On Mon, Aug 25, 2025 at 1:31 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 19/08/2025 16.39, Gustavo Romero wrote:
>>> The goal of this series is to remove Avocado as a dependency for running
>>> the reverse_debugging functional test.
>>>
>>> This test, the last one I’m aware of that relies on Avocado, requires it
>>> because of the need for GDB to test reverse stepping and continue.
>>
>>    Hi!
>>
>> Please note that there are currently also some efforts going on to extract
>> the GDB part from avocado into a more self-contained python module called
>> aautils, which might help here, too:
>>
>>    https://github.com/avocado-framework/aautils/issues/82
>>
> 
> There's also https://github.com/cs01/pygdbmi which I have used before,
> it seems like it does the same thing as avocado's gdb module but it
> could be missing some functionality

Thanks for the suggestion. I recall now that I've hastily looked at pygdbmi
when writing the mte.py test.

I don't think it misses any functionality for our current purposes here, but
it has its own runner so we'll be using two different GDB runners for the
tests. I´d like to avoid it and stick with the simplest runner which doesn't
add another module dependency. The same for the test interface.

In general, pygdbmi seems more than it would be necessary for the GDB tests
we have currently. I would like to keep the tests as easy as possible to
be executed manually and I think that adding another API rather than GDB's
own Python API, currently, will not help.


Cheers,
Gustavo

>>> In this series, we leveraged the run-test.py script used in the
>>> check-tcg tests, making it a GDB runner capable of calling a test script
>>> without spawning any VMs. In this configuration, the test script can
>>> manage the VMs and also import gdb from the test script, making the
>>> Python GDB API available inside the functional test.
>>>
>>> The test is kept “skipped” for aarch64, ppc64, and x86_64, so it is
>>> necessary to set QEMU_TEST_FLAKY_TESTS=1 in the test environment to
>>> effectively run the test on these archs.
>>>
>>> On aarch64, the test is flaky, but there is a fix that I’ve tested while
>>> writing this series [0] that resolves it. On ppc64 and x86_64, the test
>>> always fails: on ppc64, GDB gets a bogus PC, and on x86_64, the last
>>> part of the test (reverse-continue) does not hit the last executed PC
>>> (as it should) but instead jumps to the beginning of the code (fist PC
>>> in forward order).
>>
>> At least the x86 test used to work for me most of the time, it just fails
>> occasionally. Same for the ppc64 test if I disable the powernv subtest there.
>>
>>> Thus, to run the reverse_debugging test effectively on aarch64:
>>>
>>> $ export QEMU_TEST_FLAKY_TESTS=1
>>> $ make check-functional
>>
>> I gave it a try, but this did not work for me, the test was not run at all
>> anymore. Are there any patches needed on top?
>>
>> Anyway, shifting to a different test harness here makes me wonder whether
>> the whole reverse_debug test should maybe be rather moved to tests/tcg
>> instead, where we already have the basic support for the stuff from
>> tests/guest-debug/ ?
>> The aarch64 would require a different guest payload, of course, in that
>> case, so not sure whether it's feasible?
>>
>>    Thomas
>>
>>


