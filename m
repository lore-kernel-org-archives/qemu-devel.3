Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEA7CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 18:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3emQ-0008Ct-9V; Tue, 30 Sep 2025 14:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3emM-0008Cg-AD
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 14:08:46 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3emJ-0004Ne-Qq
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 14:08:46 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-27ee41e0798so77959815ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 11:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759255720; x=1759860520; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PzA6XqcEOahUXX+qN84ilcXJlbNzVeUnzYLbAF/PVOU=;
 b=Iqv1WWwP+7M/CTWOIOpWRHwO3DpW/6SLVnIWCoazGPtSunblqnyU1cWdQGjjM5nkSg
 SJMEr0U7Ge/7TXx4KixVOsoHEm++ov9ttHZ2yApnR5wxr6MSW8tJTyUFkNfLM7LDsU66
 AjY+PIEzzwDzvoBQ0DArkVT2OJaiyhzJ9WliaOAzRs5cfBfF44pgIE3wm1sln6uZ6PnP
 yrQk0Sk998ZGD436565exwicalzHxn4dGlyJ+nKUD4J7jdBJ2NJRV3zgZnof8hI8T56u
 wDGJP5vIOW8TFEzI7vTklAs4/LuCppnoJzpLgY+GV8QPytiVrmFi6KBFAb6ZKlhKe+mU
 Tx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759255720; x=1759860520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PzA6XqcEOahUXX+qN84ilcXJlbNzVeUnzYLbAF/PVOU=;
 b=t5tD1Ua+JE6l+XZB5E21TJmD+BdN0Z4OorTNuIMU+ob5vNNn2QjZlHcQ3l2KxF+Im2
 kO6+o8E5fPYxJ8MfNFPRRV0g8irXksJDheFHAqpdxotXiF8NC26ixn3n53bPN+p8NsXJ
 XcXaQt7pT1ada81AQo+pkWJTSxH1e76ehAKr6R5ebeVHEge+Z3GRk2/aJ93KOuuavEHv
 x1JAceL/EnwtIXNM3PM362EkaNKHjIUxdpjUUhPErbMBjbnhHxLou8UE36WTMGLQHXhp
 r0AQPGdAcbySf6woi/sPWPkvemOFFDcmGfbKOnOcnyR8W4UdI3yUP5VPV0/yMMZuTolF
 nmCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXprk0yIswL/MAHI9D+loar6aq7MRBJ9S72DGcN9CJe9MLzA962LDAcy3w/GjNpx0IQelRLgs2HXsRB@nongnu.org
X-Gm-Message-State: AOJu0YxdLTK3Pbettck6BqGEm+3ennY0W4kAfkZYFBOyrh6mh6pGCifG
 A5R7wjJZH+tMBMZIiaulQms8aljzZv9s0/ryWvoL0NDpguv29y3yRDamowABanP9/3k=
X-Gm-Gg: ASbGnct3TOAmBL/6f54XrgDzGknjkAu0o5aZ3oDrtJ3OPorEkC2Wu3zQpTnTjNiPAzC
 bRAW0PLNOKUKo0lE7Jo6IM7uKgtgGMqi5YRj6mqVUM43Q5TQ0PbvjfAejgEs/M/o1Bf00dimiFT
 96nnByO93A5G8au/ODM4Qy5i48Nj/PwFWXbFrbpsZNsy2hpwzdkqBSkj0B1kmqJdNWLVubBvgzF
 opbekQBbR92t/K7HyWWUIOGrorJUU3QR0Qcv7tGdrImHWXDK1urRGTN9358FNuetfcoMVl0JyTV
 J1Td6XibGolwf5g1A5ero4fay9WQ53Vx5BhRIhwBcoi7/EXKAs+gM+Z7PV5KwQW+9ARWAXiaWVa
 nXCJoqaK5XdOWprptLf6xdwWW2JBqgcKUH9ImBOePqSgm1Uq+UfNjeuG3PW2qHKkr6ncoDQ==
X-Google-Smtp-Source: AGHT+IHep+ki6CkVsFfA8nX6rK0peH6o8V0+WnmUDWdMqo9s2XcbDh5qn9yrwOgQAHtgVkSftPyfqw==
X-Received: by 2002:a17:902:ce0b:b0:270:4964:ad7c with SMTP id
 d9443c01a7336-28e7f28e2admr8714455ad.2.1759255720210; 
 Tue, 30 Sep 2025 11:08:40 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27eea801b49sm138585805ad.23.2025.09.30.11.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:08:39 -0700 (PDT)
Message-ID: <b1977422-1773-4ca0-a073-02ad90938c65@linaro.org>
Date: Tue, 30 Sep 2025 11:08:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/34] single-binary: Make riscv cpu.h target
 independent
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com
References: <20250924072124.6493-1-anjo@rev.ng>
 <427722cf-c91c-4c2f-b5a0-8d127c3dddea@linaro.org>
 <6c899106-ca29-4165-8769-2376f5eb5b07@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <6c899106-ca29-4165-8769-2376f5eb5b07@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 9/29/25 7:03 PM, Philippe Mathieu-Daudé wrote:
> On 30/9/25 00:44, Pierrick Bouvier wrote:
> 
>> On 9/24/25 12:20 AM, Anton Johansson wrote:
> 
>>> Quick question to correct my understanding. AFAICT riscv64-softmmu is a
>>> superset of riscv32-softmmu which handles 32-, 64, and 128-bit ISAs, so
>>> concerning single-binary do we for the time being only need to support
>>> riscv64-softmmu?
> 
> You are correct in that they are all part of the same architecture,
> the register bits accessed being a mode of a CPU.
> 
> IMO The "superset" view comes from QEMU historical development, and
> I suspect a generic riscv-softmmu could be sufficient here.
> 
> 
>> Overall, most of the changes you do are correct, widening types, and
>> combining low/high part in single 64 bits integer. For this last part,
>> I'll let Riscv maintainers decide if they agree with the approach.
>>
>> However, the main issue is that changing size impacts migration
>> (VMSTATE_UINT.*), which would suddenly create a breaking change when
>> importing 32 bits machines.
>>
>> We have two ways to deal with it:
>> 1. call it a day and make a breaking change.
>> On Arm side, we were lucky to not have cpu structure defined with any
>> target type, so the problem was not found yet. But we observed that
>> other architectures would need a solution.
>> If Riscv maintainers are ok for a breaking change, this is the easiest/
>> fastest solution.
>>
>> 2. introduce a backward compatibility change, to selectively import size
>> if we import from a past QEMU version. In this case, we would keep the
>> VMSTATE_UINTTL but adapt it to do the right thing when restoring, either
>> writing 32 or 64 bits.
>> I didn't dive deep enough in migration restore code to see if it's
>> easily doable, or not.
> IMHO we should really avoid (2). The only problematic architectures (wrt
> migration) are PPC and X86.

Indeed, it looks like a nightmare and an excellent maintenance burden.
I saw after sending my email that Alistair was open to a breaking 
change, so that's a good news!

