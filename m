Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F8AE8FDA7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 16:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZAZA-0002lV-8M; Fri, 26 Dec 2025 11:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZAZ6-0002lA-DE
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:21:21 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZAZ5-0000j6-16
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:21:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so48161125e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 08:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766766076; x=1767370876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bfv/O1dZ6Ad7EDg3C8hk6hVIw0SY5HJxOdEjrH41TGc=;
 b=fOnSPxfjTVrGsaVLRnjqabM9jzuS1ZPQWIklbyKtce3zOIPxhpnaw+AIlHHlCuaa1q
 vWmtaZ4UOEXpYbnCQZmucdhUDAf+HEo3DMxxvLksHkUEASID4HhSCTgpxfnVd/tmtwi6
 dBqbyrI/HeT4jUEcHDd+w/4TxtqdrVUurZrR4yZj/vuN7dnZuGrVn8DKwqoVfbHila0O
 2QUngSTmNQUm3uAhWZfB063DJOWpuyZFUJZ+arxYexjNMHTgE+gp1UG7ADLHWhn9pwcd
 gOdhWhtq6XMXpJLL1yEUZJ1yW/TL/TYbHUBPAHyyUMXkwlkR2k7qVzbah61IxXO9+7tK
 zoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766766076; x=1767370876;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bfv/O1dZ6Ad7EDg3C8hk6hVIw0SY5HJxOdEjrH41TGc=;
 b=loldWXJaVQjxW73UaY6tgnvXuOOERv3k4HiYWAyDI1eJRbAWJMSFsNuMrqYv6rP/Ug
 xdFHsghOzAqxUHMhhbP23IgPjafeynJ5TOtnLGLJA5ljAzaiMw6ARkhjynzgHFjNvy27
 dsFtpKXy6ozbB7cwaK53O8lebcUl6xeuV4F6YwoTLllV+jji6buIPUKGrm0oRXw1IJGb
 NX1CR/pF6gfh//P8v5NJSJb7paPDqHSRnDvpzz4aduJCo+fzZHESTqCB0NbVznv9C0Q2
 pNCWenn4edWNFiqI1DqzKzOwe8WZMEoWpu6c4n/IJCaGOO2Uyb2m8P6hN5cDDxGyDjTl
 D/pQ==
X-Gm-Message-State: AOJu0YwxN8NesQlnhC1uchvetxnHESo7/zvLegL2hB2VrglN0/Gai8Wz
 qXDBg1Li57DpmNsaDJ6vz+vtt50zHmTqDi7XITNBA2xlGBjmM7vJ3E1lLVUVNX8NWlQ=
X-Gm-Gg: AY/fxX4whHpFI1y/yze0qCl0Sc9J+xIBlJUMHh2kZT+haZBDmT33zHWeKI3MP9JTzCh
 lfQ1CcFGsIIXJF4VMY11VAX8ucSu5I03PYwxw19gAbaZo5BSLxpvtpaZz4bmB1NqC2ec6r3TvST
 iM5HTtWWhkWJj1BroOabCYzl/jO9+CXcDXQzlWYfrRcEE/nZXs0hXcVbVuJBNahD9l3QkxZ56e7
 oNCXj2seRb891DNulrL+GCcEj1lA+aYwWR0wAoaVEJGH60T4FGRoOGoreXuBM9oRD937cFzEOmV
 ya6cIWHp3SVCngbqRON0Ma+I2VoL3XY0csSBoAzqvc0AF8PbDbo8ggx+P8BLAT/nTl6LGUMOm9V
 p7wURY1L5NCYQ4P/raZhDQz4D1VueBHAA4u8zxYIKHo+ywPQRE1xq+INtiqgpnPCt/Uzx3OsIPf
 c8VFBw02mObAXaEDTwZ6rEDMw65b7JMQP+ewxv8hvf4LK763FuCxjK9/ZQP1ZP/w==
X-Google-Smtp-Source: AGHT+IGZtPfuO3APzbmlrD8U2DTmMeN8I/4xte9LtuMNMOkroMc7ziKhDf2SJ+FTmOXsSet50yu4fw==
X-Received: by 2002:a05:600c:3106:b0:47b:deb9:15fb with SMTP id
 5b1f17b1804b1-47d195a0feamr266858615e9.33.1766766071822; 
 Fri, 26 Dec 2025 08:21:11 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a7b687sm188171755e9.6.2025.12.26.08.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Dec 2025 08:21:10 -0800 (PST)
Message-ID: <fb0743ca-57ca-4034-b9d2-16912e041450@linaro.org>
Date: Fri, 26 Dec 2025 17:21:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2] target/riscv/gdbstub: Replace ldtul_p() ->
 ldn_p(sizeof(target_ulong))
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alistair Francis <alistair.francis@wdc.com>,
 qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250325154913.95283-1-philmd@linaro.org>
 <87tt7g118p.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87tt7g118p.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi,

On 26/3/25 12:26, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Replace the few ldtul_p() calls by a generic ldn_p() ones.
>> No logical change.
> 
> Queued to gdbstub/next, thanks.
> <snip>
> 

This patch got never merged, is there an issue with it?

