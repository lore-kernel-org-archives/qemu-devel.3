Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84772FF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABVf-0007Gg-PW; Tue, 07 Apr 2026 14:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABTJ-0002LR-FW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:25 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wA7As-00044x-6r
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 10:13:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso45457335e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775571180; x=1776175980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vhNFuVMyD8d91K64/eizCPsT0jlx41WFClEk6zeHy7A=;
 b=yphyps62T3dFU79BUBjlxVmwEnK/JjNq4NeKM+qT7ftGTyd2unmCxdT3oGwiOR/we9
 ZJLiSIfX4mzAuyJoJy8ocyj1z0ggIgK9ee9TdijmK7fS1mqnSxKNb0nqjT7rMBs2VbCJ
 gafePgaX8ASy7ZNVz9b7zev/JjfVQJAF7yKNtv71IsQJrqGa/mjpiiRiRGb8IMjLD1/p
 3z27dC1cEe+Eeor1xLShrYVceIoHx87LOsx86udQUvLrkFK1RyrwwiAuQaJUx27ZStbd
 Hx/jRsMYwPb+sv0Ew7VLQ0rjXNfDyV6D2ZpuuGhSuYf5obciO1yvyfocv/z25j5ulg89
 j9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775571180; x=1776175980;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vhNFuVMyD8d91K64/eizCPsT0jlx41WFClEk6zeHy7A=;
 b=OE4lpOk9PXJ7Pb6nhgey4KjKqnUQoKX+VsQOqhxAagAN/m3AIQDHfbgspUDHKwDdOQ
 SUUenHHTd7C1uuij53x02M4aGH3fT7Bb4gGsp3Xwou8YEy7dNTUHJ1FyTl99FqqxawJx
 DzuRmoi2RiuXTWxSmhpH5BeUTDKwRIaQDNFdwvYVVKJMe/1nJtEoG0aayisTqRyAm8TX
 XEgoV3k79sYV1sSkZi+DWTmQeDzOdB2DYSL7AZ8WaLmnn3gijmqn5GQHd3X5j3pzWPMK
 USMdDY2tSGhPTihpa+bLY91aK/Nt15oKeO3Nd/on+B7VRu5gxLzLC5sdhIdQ32s8d8m/
 P6FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg5mQLDc2d8uI4+MbVpOj12KRQYnMuuDIiN9Wt2PMHU4oqz10nyma1JfCzJ8r/ueyXBw7/qCXWUclD@nongnu.org
X-Gm-Message-State: AOJu0YwUeHR9tD3lt4H917FTRKf/H1/8RpYvDRvI4YMqi3POCoFSjHAW
 Q2h0jayy9nKGbO8/gyOfMV9iBOhMqQqzhkiaOOYOm4oEvXBJli8ycdMWlb1Eg580rGw=
X-Gm-Gg: AeBDieu0Qz5xaF60B6UjcGKpWegWKI4NwqvTxdU5zzJwornEUvznB0nzwNasn6/0FFE
 r5MRrpb1XNeYb0vK1NfF2qtIjEewLgKVy1bfbQwft93bcQJCVMuNAt6rpoDJZfLLscJNVB2pBil
 eU/KbXx/1MSIwVBD9ttDCuu1/CPhCzGxZ0UeXkMiCog2spMqjy+MvENsgM0+wGXv9RwTpdmMMmW
 NgoW9ct57GGrE5i8tb0enQJAPeO0C/SJUC3tRy4LXuDZogJxSy8t524LByItNapfnNeQB5ZfNI9
 yvS7++UmYrP1INoAVLXzuBj0bLbmbuJdSDCnEURB+Hrir5x/++Ie5WME/O2HrHnILHgIX1EGBY1
 eusup8kfj2YFJ0cdOJBS98d6oNYkbQgjCIBqQYVjwRv5XOaFnhwEZR03xsoH4TfpMC+9IMiyH3H
 YJSeQ+IEXVrfTMrVKt0UBIt0JynmlNOFVctC8=
X-Received: by 2002:a05:600c:3b1b:b0:485:3fd1:9936 with SMTP id
 5b1f17b1804b1-488996b02a7mr243931045e9.5.1775571179594; 
 Tue, 07 Apr 2026 07:12:59 -0700 (PDT)
Received: from [192.168.69.228] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48897fdd2cesm146176085e9.4.2026.04.07.07.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 07:12:58 -0700 (PDT)
Message-ID: <172ff713-a646-4a2f-880a-8d47a812c0db@linaro.org>
Date: Tue, 7 Apr 2026 16:12:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] target/riscv: Set endianness MSTATUS bits at CPU
 reset
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-4-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260406154935.144674-4-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 6/4/26 17:49, Djordje Todorovic wrote:
> When the big-endian CPU property is enabled, set the MSTATUS_UBE
> (User Big-Endian), MSTATUS_SBE (Supervisor Big-Endian), and
> MSTATUS_MBE (Machine Big-Endian) bits during CPU reset.
> 
> This configures all privilege levels for big-endian data access,
> matching the RISC-V privileged specification's endianness control
> mechanism. Instructions remain little-endian regardless.
> 
> Also update the disassembler comment to clarify that
> BFD_ENDIAN_LITTLE is correct because RISC-V instructions are
> always little-endian per the ISA specification.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4537305dfe..eed5afd27e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -716,6 +716,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>               env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 1);
>           }
>       }
> +    if (cpu->cfg.big_endian) {
> +        env->mstatus |= MSTATUS_UBE | MSTATUS_SBE | MSTATUS_MBE;

You are clamping endianness, which doesn't look correct.

> +    }
>       env->mcause = 0;
>       env->miclaim = MIP_SGEIP;
>       env->pc = env->resetvec;

