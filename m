Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31101C9EC92
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfILd-00077F-8z; Mon, 12 Jan 2026 08:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfILW-00074K-8z
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:52:39 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfILU-0008W1-O1
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:52:38 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so41454105e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768225955; x=1768830755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K9JWlejBc4rJq/6IJN7dz2Frbj1iREEM8zcq+8sYb9Y=;
 b=W50TgepElvaH8WTgPQrFlb7bcvaxCB6bclCW9/GXvE0PdqCnPxznuP6rrPq+q6UTsn
 SQVr0Smzhp1Ea2yA2TBq+nxcVI8Gp+UXIKCpbI9PiT+YagMiNTTzge0j2gmPHfH0qrTm
 Qn1xXBohEnA2kRBo2SqTEpN6Mfm0Yft2rLxJhmGn4yPngylDLZE67mksk7jNtn6ThsrK
 t50ZG9lWYn0MFx5uw0NCCKDkybpjlD1zkKGw1aV9J2RKkDF61I5Lf5960xa3+6ya17z7
 Wry8OKRBz5J6VJyN6rRiloJqLPoI6X6Ypzh+7tx+71FoK2shu4y3zyUAvDCE05mksk4R
 RBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768225955; x=1768830755;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K9JWlejBc4rJq/6IJN7dz2Frbj1iREEM8zcq+8sYb9Y=;
 b=GPC83qDfFZcVAQ9yu3hZ+gMsADJbC/vGA3V/Xs2mj0sl+3glfuplXl0883blFscv4O
 eay3nrSB9NMw5K79nzSP054e49OvA4N10MCE8KmnXh7FUtgKXgZLmvy9vPWxu2OV/Og/
 FUXZ21I8TYyZCt/CN1Ujpy/oFpLnkzsz7kDfsN9idwL53mDhzPz1x/MCT/Pbwr0rVSei
 QOi13zpgqwOW8To4KutKGlPosdbAPyOJLRMXcEp68v7bREQRXqi0iMaQDlIidr/6nq+o
 BApMYbFA1Zr723zM4BTr4+Q5N/NBZ7TumBfjOCJDV7k+MBQcwIk6q9zod7qNoHYCTAeb
 xVaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXK5h1RFTgmfv4IagXZJpovSw6DpB95CC6VuDhjrjFrKZrOo9CjOSwtrk7VrMGbixKSr+FAjt3lmQW@nongnu.org
X-Gm-Message-State: AOJu0YxTT235TPMBX9t59qQENPk8Vp64fE8+tjfoCnvIpXv0f8v2ZFPf
 afPphF/4mp4fyGJVHDgtXJSMJ7PgaAdVskT2J0EQB8mjYcC0QtbwN/RWlVYO01zn6ElO2aax19B
 8TM3wy9vL/w==
X-Gm-Gg: AY/fxX7hv5ptIAtvcBntXaOjqBQX4dlAskUgFmN8Ea/G/BET2UqFQ4pzHCP+rvenIle
 URrLHI9AcNAOlY3f7+Ine8SxTT6sFzCqGUpRUsXjVFtEhOEizrMZdaL7urWDp6j102bO00ZiIal
 K3oQRXrV2pHimibgCgsmMtdUyu5YT4DUBSIvSGd7V2c1zuyX/t8FNUBcm9wAXv8Stkaom1CdFDQ
 VszpgL0FQ6B6tKlY/F4JZLrY7cgw/QkOYthU7/zeilVsrThwlSqdgA6vYtgprTLKSjBoehmgm1S
 epmG0QXZuAP9UXla1WwzYmPJIcmZbhnAwVe5jVhJiPPZyJatHhqbTpKNp0v0g/VY4Xt1qE5RA8K
 5VfVK/VmszjK05ZuC55MptbG2d7hi2X64vB06+R4tIeoNzLjJlc6DVV6LwuDytSL8pKy9n+l9/J
 VRIXFEVda5jrYQ04DV15WHTmjztqeeMapEY8XRdpK1L40iH8x+xO4WPw==
X-Google-Smtp-Source: AGHT+IE6AGfpe/sx0ztn+Ss9Y0awKCBP8O1owWhPZXdzk62SJgVY0vBXVW6Hp7AMIg0U4g3AhdH4Lg==
X-Received: by 2002:a05:600c:630f:b0:477:7658:572a with SMTP id
 5b1f17b1804b1-47d84b3b606mr167346655e9.20.1768225955033; 
 Mon, 12 Jan 2026 05:52:35 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16d2sm40162618f8f.13.2026.01.12.05.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:52:34 -0800 (PST)
Message-ID: <ee7d17b2-13c9-4214-b796-8a2ea79548a5@linaro.org>
Date: Mon, 12 Jan 2026 14:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/15] target/s390x: Restrict WatchPoint API to TCG
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260112131457.67128-1-thuth@redhat.com>
 <20260112131457.67128-9-thuth@redhat.com>
 <2b4efec4-1c47-408e-9a87-a62c37e5bb01@linaro.org>
In-Reply-To: <2b4efec4-1c47-408e-9a87-a62c37e5bb01@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 12/1/26 14:47, Philippe Mathieu-Daudé wrote:
> On 12/1/26 14:14, Thomas Huth wrote:
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> By inverting the 'tcg_enabled()' check in s390_cpu_set_psw()
>> we can let the compiler elide the s390_cpu_recompute_watchpoints()
>> call when TCG is not available. Move this function -- along with
>> s390x_cpu_debug_excp_handler() which was introduced in the same
>> commit 311918b979c ("target-s390x: PER storage-alteration event
>> support") -- to a TCG specific file to avoid compiling dead code
>> on KVM. This restricts the WatchPoint API calls to TCG.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Message-ID: <20260107130807.69870-2-philmd@linaro.org>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   target/s390x/s390x-internal.h  |  2 -
>>   target/s390x/tcg/tcg_s390x.h   |  5 ++
>>   target/s390x/cpu.c             | 30 ++++++------
>>   target/s390x/helper.c          | 38 ---------------
>>   target/s390x/tcg/debug.c       | 85 ++++++++++++++++++++++++++++++++++
>>   target/s390x/tcg/excp_helper.c | 32 -------------
>>   target/s390x/tcg/meson.build   |  3 ++
>>   7 files changed, 108 insertions(+), 87 deletions(-)
>>   create mode 100644 target/s390x/tcg/debug.c
> 
> Thanks for taking this patch, but Richard said this WatchPoint
> API shouldn't be TCG-only:
> 
> https://lore.kernel.org/qemu-devel/4be5bd97-21a5-40fe-9a9c- 
> a4e05b11a1ea@linaro.org/

As discussed on IRC, this can easily be reverted or adapted in
the unlikely case s390x gets another accelerator merged in QEMU
or KVM/s390x gets watchpoint support :)

