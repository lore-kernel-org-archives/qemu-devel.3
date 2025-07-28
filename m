Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E53FC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 21:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugVqP-0002AU-Pz; Mon, 28 Jul 2025 17:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugVqN-000281-6A
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 17:57:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugVqK-00015j-RK
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 17:57:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so30149195e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 14:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753739831; x=1754344631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JR9jIU+mklwnt3YnSo7l8TqiKAq/OXOxIlZ8mTE0Uw4=;
 b=m3GIRvvI/UUUEKdeoy4bPbx7u8KWFAcEGJAmOfAcv4l0W8r3SQfLeLSaB9YWb+XX5v
 wXw98gId9aMauaf3pLxnN03DRecILtGw1IBwOswB4PqTJWyDjjVeEgWoNvr3kguWG0Qu
 k16akIyXlwZGHvfQf5UG17KRHod12cKSqpyu5WfZSKI7rcK+c3zjxZbwfaUsDmvEuOVb
 XFVg2w8Ag7pgoSAcWTtj1RjsgWlcVoEWWhf1Bolv4u6Dz2D3MFvulbTrMuvDy6mufP5N
 TIKN8KsfI9FwmuBLrdbUHpeg8FmLZwgxyM6B0xNRKq/fwHATekrVeqEflyGUYmhXX2Al
 oGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753739831; x=1754344631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JR9jIU+mklwnt3YnSo7l8TqiKAq/OXOxIlZ8mTE0Uw4=;
 b=opQvWGOrKfqhZTLoUxI2ijaDhJPCA+aSabrwW/IHXtdTBJ0m/t9Y1sk5lgllUpj9mV
 qRK7lSUJHJ0Lh9g9irtMoWKbYedYPmIhF3RsFoETrMjqeXWaR+9PMj/RAX/Pl4KPsDBD
 eAG5dqw8+M6I8cI12r+HVg13dqvdJaepGE9j2BmvqfWlV8i4eClkge086rQJ3tRJ20Z0
 djtda7fmrKJu6GvnMst5r58gIJf00N+lCBe+GQrN3WwuwcvHjI7K50tQXy+ipx6CXzWM
 /xkFXFy/vZuRpBTrTSt6ntYZAyZV2EwhamB2tK6ddNSB/gNZ9UFWsyiMI/eSzU0s7UHA
 m1Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkxqn1c0YO9CDNJQC2CQI04FV/FRlD9Iyk4karSSKKBFYGe/zAybeovIjz5drBCWWkpaq5q0sRzwqL@nongnu.org
X-Gm-Message-State: AOJu0YzARlaJ5NAR0aCJRlIa8tlF5JyqeeoOP7B8RjQl3A3UURaPsdCG
 67l77AGUrXN2aUmR9PWGGpGoaVo6aNWUq7KKDC//BG+sjbYnkijSpnfdZFPcoADCHgk=
X-Gm-Gg: ASbGnctWBDwoN1xKMF/HHJJBprR0d5geSobAxR1ubmlX5cPFV3KdY+CPM2hthTykGzY
 ajYVtdgT+HUp6cXB+uok4O1YL92iyuEuhcCM2wdU8bL5J5brTWfCeR+Wc0fqShpVdAM3Gd0yRL3
 SvgjwEbmmorF6hh3Yh4qjwwr9LXkPaNrcX6bWTMjnTPfuj3KP4djhFU60ECxMoa/Jle9PYYb0oa
 wSnh8LgLmwN64PIvgZflP1OaLHVJjQV2dJwu4mLH3Q2kTBe1lbKLo6oxBoPrAei/EF0uZqJK7Br
 6D5NXMr++bgsTmGvz9QtlxZ5tI8YfW9ItDqBWTbMb2bIh8qdJoaY9YOsfy0HUpbYg/WDjfrWvN3
 /548xSNmwqwE7u4/FIOsB2jsbjoA6ljq8JJwxIYxIMsyx2TqzWdWzbF1mbO9W90qQnw==
X-Google-Smtp-Source: AGHT+IGjfPVitJpskvA1M5LTrf6l6c0EJ2+3DVF171BZ4frhM9YzDN00BQeJrUj4+Au7Z8aY/1cUSw==
X-Received: by 2002:a05:600c:1914:b0:456:c50:1b3 with SMTP id
 5b1f17b1804b1-45879bf0bd8mr72005465e9.29.1753739830629; 
 Mon, 28 Jul 2025 14:57:10 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705ce775sm169816105e9.32.2025.07.28.14.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 14:57:09 -0700 (PDT)
Message-ID: <62c947c3-0e16-4484-83cc-3aff3a694041@linaro.org>
Date: Mon, 28 Jul 2025 23:57:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] single-binary: compile hw/intc/arm* files once
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
 <bfdd8821-a7f7-4648-a389-124426da6d15@linaro.org>
 <144f0930-af30-42b0-849c-99242d3f09ee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <144f0930-af30-42b0-849c-99242d3f09ee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/7/25 21:34, Pierrick Bouvier wrote:
> On 7/28/25 2:39 AM, Philippe Mathieu-Daudé wrote:
>> On 25/7/25 22:19, Pierrick Bouvier wrote:
>>> Move those files to hw/arm, as they depend on arm target code.
>>>
>>> Pierrick Bouvier (3):
>>>     hw/arm/arm_gicv3_cpuif_common: move to hw/arm and compile only once
>>>     hw/arm/arm_gicv3_cpuif: move to hw/arm and compile only once
>>>     hw/arm/armv7m_nvic: move to hw/arm and compile only once
>>>
>>>    hw/{intc => arm}/arm_gicv3_cpuif.c        |  2 +-
>>>    hw/{intc => arm}/arm_gicv3_cpuif_common.c |  2 +-
>>>    hw/{intc => arm}/armv7m_nvic.c            |  0
>>
>> Alternatively add arm_common_ss in hw/intc/meson.build?
>>
>>     arm_common_ss = ss.source_set()
>>     arm_common_ss.add(when: 'CONFIG_ARM_GIC',
>>                       if_true: files('arm_gicv3_cpuif_common.c'))
>>     arm_common_ss.add(when: 'CONFIG_ARM_GICV3',
>>                       if_true: files('arm_gicv3_cpuif.c'))
>>     arm_common_ss.add(when: 'CONFIG_ARM_V7M',
>>                       if_true: files('armv7m_nvic.c'))
>>     hw_common_arch += {'arm': arm_common_ss}
>>
> 
> The problem with this approach is that we need to aggregate hw/arm and 
> hw/intc arm related source sets, and the last line in your proposed 
> change does not have this semantic.
> Regarding meson, hw/intc subfolder is parsed *before* hw/arm (see hw/ 
> meson.build), so we can't reuse the same source set, defined in hw/arm/ 
> meson.build.
> 
> This old commit (7702e47c2) was the origin of having interrupt related 
> code in a generic folder, but I don't really understand the rationale 
> behind it to be honest. It seems to be an exception regarding all the 
> rest of the codebase, thus the idea to bring back things where they belong.

Yeah, you are right. What was suggested once was to move them to
target/arm/hw/, being architecture dependent / specific.

$ ls -l hw/arm | wc -l
       97

hw/arm/ contains board / soc / arm-specific hw and helpers (such
code loaders). Nothing wrong, I'm just wondering there is room for
improvements.

Personally I'd rather keep hw/arm/ for boards / soc, and move
ARM specific components (like GIC, NVIC, SMMU, timers to target/arm/hw/.

Anyhow, I don't object to your approach :) For this series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> I'm open to any other idea someone would have. Peter, without 
> necessarily a working solution, do you have any preference on where 
> those things should be?
> 
>>>    hw/arm/meson.build                        |  3 +
>>>    hw/arm/trace-events                       | 79 +++++++++++++++++++ 
>>> ++++
>>>    hw/intc/meson.build                       |  3 -
>>>    hw/intc/trace-events                      | 79 
>>> -----------------------
>>>    7 files changed, 84 insertions(+), 84 deletions(-)
>>>    rename hw/{intc => arm}/arm_gicv3_cpuif.c (99%)
>>>    rename hw/{intc => arm}/arm_gicv3_cpuif_common.c (92%)
>>>    rename hw/{intc => arm}/armv7m_nvic.c (100%)
>>>
>>
> 


