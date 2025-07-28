Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DAFC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 19:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugTcH-0000fd-Rm; Mon, 28 Jul 2025 15:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ugTc6-0000aS-Un
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 15:34:27 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ugTc1-0003qL-Av
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 15:34:21 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-24049d1643aso6616935ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753731255; x=1754336055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RIwtv8grNVaNpxosptnFPK53lP31J2AZBYg2FCOKjqg=;
 b=xmSaG4sAqdo/0WM3LaxWJj6kSmnRPzCbQFQ14LhA5Ufd/G+tLdh8KlQ8zgBzD/LTJg
 Za9dzNakmqUD1KlbBSQpmcK5dWfMlKbEMEqbyzKARS7GvNduYoBSoJ7YjRr887lVHF7u
 xuKz2eQ09Jzq3BIHfXCOC46rAEY3tzClf0Z+4pkxL6/ISUO9B1fwrXpc9XVl14YKFudR
 YNAQD/X+di4k+W+1/GoXsvxkuSApPKXpXMFyBMqLNBY/rvEpyfUYreNdVyIZIn/NkGFy
 8wOLr9KUsPcxJSPEmk3XcCZnG/5aHh0XT1cAS10iBwRj8uZMiB35yOQXGPvMyZ7iIwLf
 rwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753731255; x=1754336055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RIwtv8grNVaNpxosptnFPK53lP31J2AZBYg2FCOKjqg=;
 b=IhDLMnxTxFsMx32278Do5T1rLJGmwW6znc/nhh77DRRT90DkGT9je5L4E4scpqM8ES
 9P0rFifuAnvaB9frbKGhInhQVO1THkE1mYY4DQsMFH5b6gfdLoyHEtXrwSZo543xjBr/
 3xFz1Yqoa/7JYEU0+YAmByseCcGgsBsYStgypc25YaDYoa6pr+XC3jWONNX+vC/ssHGk
 RgxwGMUBPjdJmLD+4AvyV8kKvIjSJ/DilBkU0b58cvOBFgYpFKrgByNhKuxRVM1swxgK
 gizcloF9ExAV3CIRQ7NhWKnsAz7AMaTIKXBxMLFa7u2DfTpngF938A65oe5Osv1pNvFm
 PHUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/cNM/P0e7+e93TVJp1vLpkP+29U/DF3r/sizQys5YdmDoiInL/fuFe8nwS+s8VLr2pMYhtTstbr5l@nongnu.org
X-Gm-Message-State: AOJu0YwCGvacf2nkvb2PvK7B3hbEPntw895qqkU3YBRG05mvrMEYpMNv
 GKir5F7Gqj8BoMdE3FhHuBN5RN1wh9XfMIiNJcUtJ5rjGV8ElO35zgWLbdz7s8adj5s=
X-Gm-Gg: ASbGnctUKPblipAywgWqvLDhlvyHMbUjcGxdQGj1Cdv5R0gaWf162oWxGHo0jEVSEyQ
 ryKA82qXN0RBVhTZ2LJfPsdZvwTzkox+lksmYZnRSLpC6pHk/gl6+GB3D0wf3QuY9Owrh1PPcDo
 KJto/AYwoiiUxAwXHTJGk5O3X+iM2Hz6S4faWb/eM3AcskaNXQgPVeDI0P3zvoBA4ZfDysks2dc
 OzVx2iRcNmuIu+EhF8ho+mRkR5RlVlwwoWrSjudsktA/uwsO+EgywRKrx7LEXNCU7x0h2OHju+V
 j1Tsp33wbZxdotihv4j3cyLLdlB9j3HiE7svps1WCmAvgzdCP/AHcijpMtK5cyyGsTaApz1FCBj
 vABxtl0cCnEDkXGU6eHOvnyUrS58THlAru0s=
X-Google-Smtp-Source: AGHT+IEgknH361BnArDw9Mq3Rj8/54M+lFWaB2vgGywPxHvTSZYQFo4dyqScpLtgcp4QakHEA6HDTw==
X-Received: by 2002:a17:903:15cf:b0:234:c549:da0e with SMTP id
 d9443c01a7336-23fb3129f72mr179389935ad.47.1753731254613; 
 Mon, 28 Jul 2025 12:34:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe4fd224sm59861305ad.82.2025.07.28.12.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 12:34:14 -0700 (PDT)
Message-ID: <144f0930-af30-42b0-849c-99242d3f09ee@linaro.org>
Date: Mon, 28 Jul 2025 12:34:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] single-binary: compile hw/intc/arm* files once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
 <bfdd8821-a7f7-4648-a389-124426da6d15@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <bfdd8821-a7f7-4648-a389-124426da6d15@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 7/28/25 2:39 AM, Philippe Mathieu-Daudé wrote:
> On 25/7/25 22:19, Pierrick Bouvier wrote:
>> Move those files to hw/arm, as they depend on arm target code.
>>
>> Pierrick Bouvier (3):
>>     hw/arm/arm_gicv3_cpuif_common: move to hw/arm and compile only once
>>     hw/arm/arm_gicv3_cpuif: move to hw/arm and compile only once
>>     hw/arm/armv7m_nvic: move to hw/arm and compile only once
>>
>>    hw/{intc => arm}/arm_gicv3_cpuif.c        |  2 +-
>>    hw/{intc => arm}/arm_gicv3_cpuif_common.c |  2 +-
>>    hw/{intc => arm}/armv7m_nvic.c            |  0
> 
> Alternatively add arm_common_ss in hw/intc/meson.build?
> 
>     arm_common_ss = ss.source_set()
>     arm_common_ss.add(when: 'CONFIG_ARM_GIC',
>                       if_true: files('arm_gicv3_cpuif_common.c'))
>     arm_common_ss.add(when: 'CONFIG_ARM_GICV3',
>                       if_true: files('arm_gicv3_cpuif.c'))
>     arm_common_ss.add(when: 'CONFIG_ARM_V7M',
>                       if_true: files('armv7m_nvic.c'))
>     hw_common_arch += {'arm': arm_common_ss}
>

The problem with this approach is that we need to aggregate hw/arm and 
hw/intc arm related source sets, and the last line in your proposed 
change does not have this semantic.
Regarding meson, hw/intc subfolder is parsed *before* hw/arm (see 
hw/meson.build), so we can't reuse the same source set, defined in 
hw/arm/meson.build.

This old commit (7702e47c2) was the origin of having interrupt related 
code in a generic folder, but I don't really understand the rationale 
behind it to be honest. It seems to be an exception regarding all the 
rest of the codebase, thus the idea to bring back things where they belong.

I'm open to any other idea someone would have. Peter, without 
necessarily a working solution, do you have any preference on where 
those things should be?

>>    hw/arm/meson.build                        |  3 +
>>    hw/arm/trace-events                       | 79 +++++++++++++++++++++++
>>    hw/intc/meson.build                       |  3 -
>>    hw/intc/trace-events                      | 79 -----------------------
>>    7 files changed, 84 insertions(+), 84 deletions(-)
>>    rename hw/{intc => arm}/arm_gicv3_cpuif.c (99%)
>>    rename hw/{intc => arm}/arm_gicv3_cpuif_common.c (92%)
>>    rename hw/{intc => arm}/armv7m_nvic.c (100%)
>>
> 


