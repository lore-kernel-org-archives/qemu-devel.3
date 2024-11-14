Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40C1D6A228
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf7i-0008G1-6W; Thu, 14 Nov 2024 14:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBf7f-0008EA-Iu
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:03:19 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBf7d-0002RB-CY
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:03:19 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ea76a12c32so802333a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610996; x=1732215796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rih358wJwMiZGOQCVS2076aLPZOXo/1Z1k5jdI90a6U=;
 b=DdEYrT4+83fX3mpgOX/g0O0Ak8eCT6qxS/6DS9cf5/H9moZf0VPoJjNvhoAfrDb3S1
 JonEDO6LLJbf402sl4M58BOQU/owspPDXzbFZbEW/Sa4r0rxEhY/nqFOiBoD+8Gx+Krn
 wprqGB3X+KPKkphzHoh4srb1c/BVxvOKN49i4xb+otjoHusB8x3hHkG8q1d66ques31s
 T3z8irqxZ7Qmu8YzhlGlr2vQvE2kLCh+2uZW3ks13ERC6rXaR8n4Kpiqq4FDuGnOZtGb
 t/F8AG8waDv5wybY6UDLlNi4sowT+80CKkIMN+BFDljtBGMJOYkMKxtdc0+6E+Jm6C2G
 Zvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610996; x=1732215796;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rih358wJwMiZGOQCVS2076aLPZOXo/1Z1k5jdI90a6U=;
 b=o64feZxFsb12e7MuN6o05zT+Ciy/w8NgYmWq7wlj23l8Mtiwa4WE0i4UvoizkPaZtq
 sfxAP+EYNEdCGXfFFeTz+DOHNammBTGG13Nfnz3fxuql6zkkcS1nN1Ft34RfnSTjcqk2
 QHzURM4F+ak2avcqr9dTfwueeT8SauwFtUYQoDcJmkwCFaXBtjTdh82Qratas0tx4X2K
 c3/+RPybcM8IbuQfcF6oXkwuvRqTZaVdJDVMKk9g0ydn7AM1c2OF3zorjQN2nvxm70HJ
 20tFIkS7+MIHi4YpVf8POU599NhbeaiFI02mmUIkMBshN6owAhXO4MWPbJf+afSQCN6X
 LgFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBdYAzIuSlU1n2XZ/BHQXnmaZlUeTvyM9wBiGC3a9XWYHXP997R7ioByfiIA+yveXNyFv/cJzxWrhq@nongnu.org
X-Gm-Message-State: AOJu0YzreNWsN+4Kg+k4eGw6KaHP7AGQaTt9N1A+ZyG0BGRhKg5wXwDt
 7gqaQofqncx/BAxDmwuvsa/258IUrsuSbeMDmZ+Ez/ejdT+bRkYEK6h2uF9VkxI=
X-Google-Smtp-Source: AGHT+IFMZlfLlYP7zrEa9dB05YZT7+BppqP7DMQmFHS+WzGkV8dx/owwo9Gyp6pIZRCLVjxGUXGpCQ==
X-Received: by 2002:a17:90b:3eca:b0:2e2:c421:894b with SMTP id
 98e67ed59e1d1-2ea154f7474mr5808a91.14.1731610995788; 
 Thu, 14 Nov 2024 11:03:15 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea06ef71a6sm1533266a91.8.2024.11.14.11.03.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 11:03:15 -0800 (PST)
Message-ID: <e7fc7e52-6bea-41f3-8369-6b8e5285a71f@linaro.org>
Date: Thu, 14 Nov 2024 11:03:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] target/arm/cpu: Restrict cpu_untagged_addr() to
 user emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241114011310.3615-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 11/13/24 17:12, Philippe Mathieu-Daudé wrote:
> Move the #endif guard where it belongs to restrict
> the cpu_untagged_addr() implementation to user
> emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d86e641280..12b8466542 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3355,8 +3355,8 @@ extern const uint64_t pred_esz_masks[5];
>   #define TAG_GRANULE      (1 << LOG2_TAG_GRANULE)
>   
>   #ifdef CONFIG_USER_ONLY
> +
>   #define TARGET_PAGE_DATA_SIZE (TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1))
> -#endif
>   
>   #ifdef TARGET_TAGGED_ADDRESSES
>   /**
> @@ -3382,6 +3382,7 @@ static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
>       }
>       return x;
>   }
> -#endif
> +#endif /* TARGET_TAGGED_ADDRESSES */
> +#endif /* CONFIG_USER_ONLY */
>   
>   #endif

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

