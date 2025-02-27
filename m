Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66583C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 22:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnma3-0004Nv-Sf; Thu, 27 Feb 2025 17:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnma1-0004NS-I4
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:42:09 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnmZz-0004vX-3u
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:42:09 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390ec7c2cd8so165502f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 14:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740696125; x=1741300925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DkHNvOcbFw9eu6HJFOv2Ll4rBXmAyy9qp7bQdlUk4nc=;
 b=MjxXcvrezQ0wRPq5SvXLXSSePDgdoYQJTnyAgFm/nFUxMVRNC6L/1vqRa84NWSJb2K
 a6N/CQnS96pulsZLquzU7NHud+lmNzw8r0jCX6JywdJqggpby6kLLIdfpY60C6acPcJR
 HRqh5/2csJXAWDvseT6EAZg5h6m5wurTrRE8ZPoBrbWqkB/bXA1VmFcLxJ03Pf+VlYR/
 mtjPpjn1WOEGuZnW8sJzvkzouokeSLwpgEFzNdASfvdW5zyCgZ/TVXd6b3mtan40E49V
 J+WuuK3PwFo+efi8woCp8cuD9yO/1SfM8+e3QjyNMOo2UMh1oK/14ZFZ2kpNQrekieBi
 qJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740696125; x=1741300925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DkHNvOcbFw9eu6HJFOv2Ll4rBXmAyy9qp7bQdlUk4nc=;
 b=P/5UL9xAY8qfdIr15VPq6Jh9rtaSWvkUutRpf/bKYBvKSWV+0wpX5Ri4+w1+BW8TEk
 8xmls3WOY+Vx0l9rTIvzEFNMug9xiqWDQlmfZhBT1gJFVmvxp/1BSPtM2yjQBan2W1mi
 HevsgWL1/B0HXp7UlIX0p2C/WRQDTRHd2+4VASxS1wd4lkv5HLs9UEeQNBwOO/+eMNH2
 vxZ1Nkt55747AhJyAM+UZgJLo3D0VoOd9DFS8WObvKM4X1dRqf7pN+Hoiey7h6rGHN7q
 kHyf8etbq8xrpgelN+9NLsKG17HJqD0Cg4dK65lGlex0wEs0CnhNuhpZJNaa2kuSV8st
 3h0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKAlr5pJqMRHsSo3EZ3YRahqf88nJA+k6/lrAzxwoGaMK39TJ797Ne4tn07lNyAd8VteyCCiR9Se77@nongnu.org
X-Gm-Message-State: AOJu0YxxN/I3Uk+z4MrGBwHFlpzDBDGNctvXbnRvBjHyQwxOJIVmbE9D
 wo+SIJ2GMOYISvzCs0MKj4kZw3Obkfka7wYDfeR1AthqnZ0Af9szJV6cMZDvPLIKyclznK+7noj
 yv0JetQ==
X-Gm-Gg: ASbGncsnQqFutpt/jRldb7fTuIcRBcRWdOkzgSTxZaNudI94BgnyhT4+pgcGHq3diup
 B66klFPN/s/SCDuAJG3Exsg0D0csZU+UssGi7gN1jjMIA8o9Ct5KBgoZn6R4bS6sfqdMPo/UuGi
 k9+WWvG5xVfxeiO/vW2oru+/nziwbVKnWv3WA4jiymdO3Dn9d9feIFs9dGSgKsQ2ZTt/pdR1yJ3
 RujI/vNTEQiUUpFQyhgPAhf46AmgL+B0lCfcuCtZDfAkCNpNpxBeGbkXYaGPhdMIrNF++gvGrHC
 yZN0m6Ba7bmU7kiARD+YbmQ66aw2ciJLtFudibYYTzUltSIxwlbeSUJvXjV+9b7OkCtINQ==
X-Google-Smtp-Source: AGHT+IEUB2pDjhmfEwkXuI8/1RSktcv5da/gEj7xotLTMh5YGjaUVmxWQ7hq4MNqN9AqceZBGzApNQ==
X-Received: by 2002:a5d:59ab:0:b0:38f:4acd:976d with SMTP id
 ffacd0b85a97d-390ec7c9860mr847035f8f.9.1740696124900; 
 Thu, 27 Feb 2025 14:42:04 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795d44sm3247449f8f.8.2025.02.27.14.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 14:42:04 -0800 (PST)
Message-ID: <c4637381-0cdc-4ede-a16d-52ae5049d73d@linaro.org>
Date: Thu, 27 Feb 2025 23:42:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 044/162] tcg: Convert div2 to TCGOutOpDivRem
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-45-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-45-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        | 24 +++++++++++++++--
>   tcg/aarch64/tcg-target.c.inc     |  4 +++
>   tcg/arm/tcg-target.c.inc         |  4 +++
>   tcg/i386/tcg-target.c.inc        | 17 ++++++++----
>   tcg/loongarch64/tcg-target.c.inc |  4 +++
>   tcg/mips/tcg-target.c.inc        |  4 +++
>   tcg/ppc/tcg-target.c.inc         |  4 +++
>   tcg/riscv/tcg-target.c.inc       |  4 +++
>   tcg/s390x/tcg-target.c.inc       | 44 ++++++++++++++++----------------
>   tcg/sparc64/tcg-target.c.inc     |  4 +++
>   tcg/tci/tcg-target.c.inc         |  4 +++
>   11 files changed, 88 insertions(+), 29 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


