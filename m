Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C79C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn5E-0007FU-5q; Mon, 24 Mar 2025 15:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn4y-0006fK-JR
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:03:22 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn4v-0001uh-0n
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:03:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso30908585e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842995; x=1743447795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZUHuluhi4UvHIEMSDFPRL6dtoMdQvfvvFg+ylcnW6MY=;
 b=ydoGut8AoZWdmNvHhF0OAQSZqx58TOUV1M5UUiauyZQbgQw+ZGfAxmilsjUW/oXI0j
 EZhs5oebv6gSol4dqYG4bTg69u9WlCYU0jbRcoPo+ZABxPo9gJ2EPZpdJ6Iu/RZjruYh
 N2r0mhRcT0eCW6cWRsGcT894r2RtxBr+Ue68k6a+U5jDUfj8309O8decda4R76htoq7y
 gBakF3eDLU6YCyd6dqDp+O/iukBoo7S+OlY/PhYYNATFhyP1zBYbhZvOjij8HPr+SuSL
 dWX9uUFeDTjTL0tFrdRp5oSRvJyJqlesK2Z2/35VmM3P4s1cT+zZOxlIbSjPTayTRGzk
 /2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842995; x=1743447795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUHuluhi4UvHIEMSDFPRL6dtoMdQvfvvFg+ylcnW6MY=;
 b=KMO/BtP34fHV4imHDsVdB8nTGM8TGtirLiGOADkXvV7PkP9k656IMMArAxWqDZRU0I
 AJV7hOvmi0u8IxA2Cat7rksKqBqp0BltNeZ8B1RM/qdtsITWFvgMCoMQ703En027mn3R
 oqu1h56+mu9HqGj6wai753TFPMVua7+mEtJqYuJH7DBmtkmbUX1M+Wn1r6aigk0U9MGz
 OUtek+X4nZxIktYBGcgrcXPqp/WQRe5a+SySB4qqboP440KObnbGgv7qJY2F3EZM5sep
 pbd3uQrVeXG3aYeLiXmVZwMGj5+aN08gwUnS+5steGZrL8/LqfU6MhNVoiFhvfJsp+pU
 e8kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULYCU0jyEfsOVc2XUoHS505zGqdyZBDROJVBrejUv3UnJKqykjd717a+2pvHOODO3CPLZTWVypusmF@nongnu.org
X-Gm-Message-State: AOJu0Yx9PzXqpKZJWyA4Ki2U7mK5uNjs6XzIZyqM0G0Ofj7+B2lgGgrw
 wkIsp6gx3HEz1bp+4jsHmrXqTTVQaI3sg7sVwAwaC1k41zgIVOgRZRE9HMlzUGE=
X-Gm-Gg: ASbGnctOubofkFS7L9E2nmFfZedpNL/XDiSwuLVyZX4NMih1E+ZslrhTWZ4rKLCBA4M
 PE18O4SUG2dgbHdtBavLTXSgbijU77n7h8251O+ePXao8Evz+esla8HjDJtv8tp+DXm+xbb+l56
 AaP4cBB51b2vLSOifkHj1368QrK9jHf9CYd19pzsdCUU1MDcrbTvWx/YlyTsP96cBEcBP4vTOts
 yQbpkS+hgqiITW+mV+QlIrAPEPFPmu5hz5qdtmWTfnmhD9m8nRcJQ/oevHuuIPcWaTnuOYhhC3B
 ev6MWarkP7qJyIKXUfUTxHMeDa13tQWT2b//DS/5nFn3XftayMim8HTOhcvj1mT/tME3UblxHDJ
 CmOrffXTFAl8Z6gFt4g==
X-Google-Smtp-Source: AGHT+IHcy9Z+9uFQrPCKDwbc9j2dkTuXY5cH07XxgyfsgGrUFFCE7FVoCwVWjjDvAP2jH0W0kmN8rQ==
X-Received: by 2002:a5d:64e4:0:b0:391:412b:e23f with SMTP id
 ffacd0b85a97d-3997f8f9d24mr13686983f8f.15.1742842995173; 
 Mon, 24 Mar 2025 12:03:15 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f995423sm11552000f8f.20.2025.03.24.12.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:03:14 -0700 (PDT)
Message-ID: <9b51e17c-69f4-4390-9ecb-fb1f66f95742@linaro.org>
Date: Mon, 24 Mar 2025 20:03:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 0/7] cpus: Convert cpu_list definition to
 CPUClass:list_cpus callback
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250324184611.44031-1-philmd@linaro.org>
 <03280ae6-c89b-41a7-a9a0-4157cba8c538@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <03280ae6-c89b-41a7-a9a0-4157cba8c538@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 24/3/25 19:59, Pierrick Bouvier wrote:
> On 3/24/25 11:46, Philippe Mathieu-Daudé wrote:
>> Since v1 (Thomas review comments)
>> - Move s390_set_qemu_cpu_model/s390_cpu_list to "cpu_models.h"
>> - Correct 'target/s390x: Register CPUClass:list_cpus' subject
>>
>> 'cpu_list' might be defined per target, and force code to be
>> built per-target. We can avoid that by introducing a CPUClass
>> callback.
>>
>> This series combined with another which converts CPU_RESOLVING_TYPE
>> to a runtime helper, allows to move most of cpu-target to common.
>>
> 
> I think we should focus on a more general solution, usable with 
> machines, cpus, and devices, like the interface based approached we 
> talked about.
> 
> Having an optional callback, implemented on half target, looks like a 
> half baked solution. And it would not be desirable to do the same thing 
> for machines, and devices later.
> 
> In case CPU_RESOLVING_TYPE is ambiguous (because 64 bit type inherit 
> from 32 bit type, like TYPE_AARCH64_CPU inherits from TYPE_ARM_CPU), 
> it's better to declare another interface, non ambiguous, like:
> - TYPE_MACHINE_TARGET_AARCH64
> - TYPE_MACHINE_TARGET_ARM
> - TYPE_CPU_TARGET_AARCH64
> - TYPE_CPU_TARGET_ARM
> - TYPE_DEVICE_TARGET_AARCH64
> - TYPE_DEVICE_TARGET_ARM
> 
> I would be in favor to introduce this for all targets, so all of them 
> are implemented in the exact same way, and the pattern is easy to follow.
> 
> By using this approach and tagging machines/cpus/devices accordingly, 
> there is no need for any callback anywhere, and the listing code can be 
> generic.
> 
> As a bonus, we can assert all machines/cpus are properly tagged, 
> something impossible to do with the callbacks approach, which opens room 
> for a possible error, if one of the callback is buggy.

This is exactly the plan (and what I've in my local branch). But since
we need to remove the list_cpus definition (otherwise clash) I went with
this surgical cleanup first.

