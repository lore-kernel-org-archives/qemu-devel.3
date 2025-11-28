Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306B7D116F1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 13:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOycl-0000KL-Hg; Fri, 28 Nov 2025 08:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vOycj-0000J6-J6
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:34:57 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vOycf-0002FB-Rj
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:34:56 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-298287a26c3so22178985ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 05:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764336892; x=1764941692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Oed7guEiMFIUjqFV6V/FyM5X4LSVpI9atMyIT+dp2s=;
 b=lGOqYchgxLiKhPp/ny8wwnkGEcuJUB1fdHLpIFfj3U+MJk/fTE78se+YjCkIKyxnje
 7TSmzM5dZ/phk34kfzegKfobIxS9+N1Xstwlu3rpfB1p1gLihaTPublSD2W9ip4c6cLu
 kGmon89IL4wLYvb73DhbzZyCAmGHkfNUuCTR7UZcAHaI6PDNuQPeRyXasT2+m8il9/WQ
 m00DaXk6FI0fGW9FYwAa/kqQuqjpu37X642s5tHE7DjC4XcqmTKd4G6lPchG9HbGsEBC
 nGR8P9vrd5jnQvVHq+3a/y6dlHBwQJTDhH86lx3swZ+MLlRb7DbxfLFTtNDkXqcOCLRj
 R4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764336892; x=1764941692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Oed7guEiMFIUjqFV6V/FyM5X4LSVpI9atMyIT+dp2s=;
 b=mjiEWiCE7pBStuWDMGwD/nwwmxbul+t6HM3aBqzLx/B2h7jf19UIPam1adZNwfI+Da
 GzV7QTbLIWYQDPXmsssrk6J5dPphb+z8xc11r0MYb0v6ztzOdnk9DfNhJ2/Sv+iAepaw
 E6DcHGXd8YctGoxAzFvvodp1sGRoQ5EG0x0SDlZ/UaEhk0VqMrRCyL0OfzqQCcA/IuT7
 NqrOEDAYinjMRX15gTcuKBkMX025uDb5kihnnU+VdiV8h+zS2RhQA/GQVCAuhgTDgxWW
 bgT9tGt5ety1kCtgErFlLALsKh1un5x4S9+qdUtLhDoNP5ShzigkMhiwW+cjCnKEV6Vw
 UNYQ==
X-Gm-Message-State: AOJu0Yx2H2TdggKgJADd/OVOM6QFOrYlN4I6H/8oa8l67oO4XMQRj9kw
 RXuk0F2Z8c/yR9Tu0640jQimoGFHDUBvBkAdbjGtD2x1bSXfFQpRbetn
X-Gm-Gg: ASbGncuGPa1lK5xvlbsH008+teCNedRaz8gw9TWBOh6lYA3tF6UPBr/5RN6Vv6j/gGP
 NhMpXl+2ZkFstiYkUBVPSAEKqVXYICUuj7AzSSls64vsi9gmA+YNdYsce0BCJAKI5Q5tHW6Vent
 eSUEG5NQwsJghKHP6NJSR/t3GQMTcjLw1UUC5BT3+n3yMa5yiQhgpsZkFaHnuKQN5sExPuUNdZB
 NigdsQAiJiAft7/SSyv/mmveb53tKE6YsVa2rI6p2KqXZvbUWN9d4yD20yHM1tjtDnehOmBPcYY
 OrWKbYzpz7yqdpETQgJW41gE/lDqtWOibNpJwUIR6RT7sBudJBwIZ/EG+nYatN3EacjCDclOG/L
 prgy8sENl89pwjayc6q0I4MC5o0jAYMQpB9pDFCCrNgRqacRNnR7W8scnWXKhfi/5bfzAeUW3ci
 LNynKQztvggeChDV57yYT+QAoWwZypDsSd6UUTyw7p/Sc9vlKx9oJl+8eW3uVs/c8J8aFKWzsxi
 cKFLCMYH70=
X-Google-Smtp-Source: AGHT+IG/0xugKzBQedv41NTEc9o6P1BKyVfhfafPxqKJevE/xkTE3pgx+Diva2VHgn5MsxW0JjPwiA==
X-Received: by 2002:a17:903:4b03:b0:28e:9a74:7b58 with SMTP id
 d9443c01a7336-29b6bf35a4emr298235155ad.31.1764336892304; 
 Fri, 28 Nov 2025 05:34:52 -0800 (PST)
Received: from ?IPV6:2406:3003:2007:2131:25ae:78e9:7f23:dcae?
 ([2406:3003:2007:2131:25ae:78e9:7f23:dcae])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bce4703a9sm46413175ad.42.2025.11.28.05.34.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 05:34:51 -0800 (PST)
Message-ID: <c4f85e7d-6311-4b27-b29c-58ad102bda41@gmail.com>
Date: Fri, 28 Nov 2025 21:34:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix i386 HVF compilation failures
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org
References: <20251126094601.56403-1-phind.uet@gmail.com>
 <8f6eb2ec-d6a7-49dd-b425-ee771d2f9be3@linaro.org>
 <66f442e9-87d9-4a62-b7ca-d29a1e1b9dc0@gmail.com>
 <768e0294-3f03-4ab5-b9d9-d188e43cbcb7@linaro.org>
Content-Language: en-GB
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <768e0294-3f03-4ab5-b9d9-d188e43cbcb7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=phind.uet@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 28/11/25 9:02 pm, Philippe Mathieu-Daudé wrote:
> On 28/11/25 09:46, Nguyen Dinh Phi [SG] wrote:
>> On 26/11/25 9:39 pm, Philippe Mathieu-Daudé wrote:
>>> On 26/11/25 10:46, phind.uet@gmail.com wrote:
>>>> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>>>
>>>> Recent changes introduced build errors in the i386 HVF backend:
>>>>
>>>> - ../accel/hvf/hvf-accel-ops.c:163:17: error: no member named 
>>>> 'guest_debug_enabled' in 'struct AccelCPUState'
>>>>    163 |     cpu->accel->guest_debug_enabled = false;
>>>>
>>>> - ../accel/hvf/hvf-accel-ops.c:151:51
>>>>    error: no member named 'unblock_ipi_mask' in 'struct AccelCPUState'
>>>>
>>>> - ../target/i386/hvf/hvf.c:736:5
>>>>    error: use of undeclared identifier 'rip'
>>>>
>>>> - ../target/i386/hvf/hvf.c:737:5
>>>>    error: use of undeclared identifier 'env'
>>>>
>>>> This patch corrects the field usage and move identifier to correct
>>>> function ensuring successful compilation of the i386 HVF backend.
>>>>
>>>> These issues were caused by:
>>>>
>>>> Fixes: 2ad756383e1b (“accel/hvf: Restrict ARM-specific fields of 
>>>> AccelCPUState”)
>>>> Fixes: 2a21c9244740 (“target/i386/hvf: Factor hvf_handle_vmexit() out”)
>>>
>>> Oops.
>>>
>>>>
>>>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>>> ---
>>>>   accel/hvf/hvf-accel-ops.c | 5 +++--
>>>>   target/i386/hvf/hvf.c     | 6 ++----
>>>>   2 files changed, 5 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
>>>> index 3e5feecd8a..e2cb8f202b 100644
>>>> --- a/accel/hvf/hvf-accel-ops.c
>>>> +++ b/accel/hvf/hvf-accel-ops.c
>>>> @@ -148,19 +148,20 @@ static int hvf_init_vcpu(CPUState *cpu)
>>>>       sigact.sa_handler = dummy_signal;
>>>>       sigaction(SIG_IPI, &sigact, NULL);
>>>> +#ifdef __aarch64__
>>>>       pthread_sigmask(SIG_BLOCK, NULL, &cpu->accel->unblock_ipi_mask);
>>>>       sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
>>>> -#ifdef __aarch64__
>>>>       r = hv_vcpu_create(&cpu->accel->fd,
>>>>                          (hv_vcpu_exit_t **)&cpu->accel->exit, NULL);
>>>>   #else
>>>>       r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
>>>>   #endif
>>>>       assert_hvf_ok(r);
>>>> +#ifdef __aarch64__
>>>>       cpu->vcpu_dirty = true;
>>>
>>> Don't we want the ifdef *after* this line?
>> Oops, that was acutally that I meant to do, I think I made mistake 
>> when formatting the code. I will send a new version to move the #ifdef 
>> line. Somehow the vm still work normally on my intel Macbook.
> 
> Does that mean you tested this patch and it works for you? I posted v2:
> https://lore.kernel.org/qemu-devel/20251126134434.14355-1- 
> philmd@linaro.org/
Aw, sorry, I didn't aware of this.
> What do you plan to change with it?
Generally,it is them same as your post.
Yes, I tested my patch and it works fine, however, my original plan was to
make the change similar to what you posted. I tried your patch too, and it
works as expected, I think your patch does it better.

Thanks,
Phi



