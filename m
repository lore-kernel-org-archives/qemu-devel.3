Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EAECAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 13:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1m11-0002Jt-8P; Thu, 25 Sep 2025 09:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1m0q-0002EC-Iz
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:27:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1m0Y-00042d-MJ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:27:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so6436385e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758806842; x=1759411642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NjMPQE377yWC4BwZprcuIrqn9Y8wpLi9x+QBGTW/6Sg=;
 b=x49s5KrzHg670rfu0xaiiMXiANVDLAEPQ6A86iU2xxUbFq9CY6yRpxoH63o5THfYKo
 nT5ZW6wcKFB3ZG1oT+PSZvPEBakxdN/zjFUxN3WReuemhUqtnH2CFpomvCgcrnbbT8mH
 xcM4gVWQu/x3KmtKOdq5D3JDSzI72pKsb5lCpsoj5g7l7psYHwyZd/zq8UuymMjwCXwU
 tASd9VDsjVbzXejyEhBxoxsUb0m0Q0zgZRD90K6LcWVMZjyfsXd7tf0p8KAkcmo7MSTq
 93wyDl3bXj4fB2/rogrHDEDfa+GQvZoTQJbpNVlI7a5IygSrafiLlTu0Q4BmI/Y5zd2X
 QoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758806842; x=1759411642;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NjMPQE377yWC4BwZprcuIrqn9Y8wpLi9x+QBGTW/6Sg=;
 b=QASC5/vHMPm1cj5Htutc04/y6KnWj8WjSpFLH/5vNSX2Oc0Q4fBmN5N91IV1Ujgdpv
 QaOOSMLx5Kw6vr2yC21ewi1hyKcCdW/2jdOxEyvRAt8RfuXWXA86Z7AGBwW29bp5DgYP
 C4ZhoYS2lQWivKx/3Rkljl4/hztlz4EayOVHV8KTyWBAxZ3cApU0KilQ5gQwTrktvw2D
 1bOPcI5u0IXwWJKDD4O4NkoQlxZsbOEO5pavZni5sWpra6z6rVy8bmKOC856ePjhgdKc
 5qZYp/Z0ZCMIETVgwsaIpcH59QemxmDvgZ6g64NYgqFenXwsTeZTt49JpUhs0Mcystyx
 Bo6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnzUGJh6+9ULR8caHgnJnZhtdpHcifOjca8Lkalir/NjMxuO5/oW8604SJ6h/3Um80EXgwbYQThRyo@nongnu.org
X-Gm-Message-State: AOJu0YxGsnyPpqITYNpzaTFofpH6AkXaAwphYcK/eQN3rGPdksDtNYTM
 X5xwC1VlPbVcazc45Jw3AwnjoG3cQxxH4n4uX6W2EQTLMdINSuy0dRCMIh1RIyZypzc=
X-Gm-Gg: ASbGnctk2iF+Gutj+/03xTYdxAxpwmlapo2mwOPFblphRK57gdscLnSQCpZn0MveXaX
 jibWVaprbNtNFIBUXTJDEUMG7DRNwAv7TE5up9BRqHnUNuZvB32lz4vKwqfLEk0b4hj5z4sceT1
 /0y/htlL1iBO4Uad2yDbX7KE+mQhy3UcevaaPeTmWIuPsrPyUgmkvJaTQNHIlAGo8PFPRMCnD02
 ZkxGXUbPdSNQs2SUogteHkeUfkX+NegCAp8xRfsAa7L/6oLRt0paaunOimVahv/YaPGgebv9AYd
 fk6bDKRtMksHUoKvHMrGSHWDrj7M+3oTsC4mnBp3R46tDiMDtzxQ/DVIGbMmMO+5ioNhJ5eSG58
 LLB7HDlNVBYWk5R1JwVEBC9CHQttOToeHJok19hOZ5O09FgbUrQqoXu5WrYPul394AQ==
X-Google-Smtp-Source: AGHT+IHepAVNDYnXo+HoiFAVGkMxexzv2w/1SL4VQcKgBX0N/MySC4a1fq2OrNmSIhe8+cIJK50CQQ==
X-Received: by 2002:a05:600c:8b65:b0:46e:36f8:1eb7 with SMTP id
 5b1f17b1804b1-46e36f81fbamr22679275e9.10.1758806842258; 
 Thu, 25 Sep 2025 06:27:22 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e32bd164fsm18956365e9.1.2025.09.25.06.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 06:27:21 -0700 (PDT)
Message-ID: <f6585a63-a32b-4a8a-aeab-ddb68ab3bc87@linaro.org>
Date: Thu, 25 Sep 2025 15:27:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/36] target/arm: Move cpreg elimination to
 define_one_arm_cp_reg
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-24-richard.henderson@linaro.org>
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

On 16/9/25 16:22, Richard Henderson wrote:
> Eliminate unused registers earlier, so that by the time we
> arrive in add_cpreg_to_hashtable we never skip.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 123 +++++++++++++++++++++++---------------------
>   1 file changed, 64 insertions(+), 59 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


