Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00249C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4K5n-000580-37; Tue, 07 May 2024 08:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4K5l-00057T-OJ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:38:45 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4K5Z-0004ak-KQ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:38:45 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e3f6166e4aso11820831fa.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715085512; x=1715690312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UBSq2RMcY9fl37gax+Rjx/LmYoBzU4/WQEwZrHu405g=;
 b=jGF5Tb5BAKlA0Bz6fjSWu4+uqicCmFT3Ig+Vyv2zSTd4hpz0NNvEzur4SDf2VijaXz
 gKTl386lxI1uSBTF2wJHvGECRA1jZT9My5VliZpSM+X00zWHzyzn4c0YoGLRxejM1aNA
 7d6TcRXJUvs6ij50gV2e0OS7loTvV5Sexwu9m1Ug4bEGqOzaOJHEIKoQ5PcpJNwYcm+r
 AL7krq/UGV0jQlGxf96rDGNh6fN/B5uQASwqgm4B/xl2RczafRDMPYQK4vfTbBu9dD2N
 Rt4ROCyV5JD4GA+bS6/tic9ojAZsIC3QmSOrRmI0EnxPDLa6CkKXA4bT9bQBjWS1n4Yf
 j7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715085512; x=1715690312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UBSq2RMcY9fl37gax+Rjx/LmYoBzU4/WQEwZrHu405g=;
 b=s7O7iAezrPc3c8k3Lv+EldfWDH7877oYL74N6x8/bWiiDHEFhwoYVOAN49hCoo2HZ9
 eulVxGTVxd3j37IyGlWhECOzS5sJWMu7EAkzVK3cI2pTF6sCGZOWyZNzqOEZn6pSu1vy
 ZSrC6WpG92OrSswX5AwoYYnjbIOUs5uf3L8Xm+n0gaDrW8Xe0Jgyxfs9BdBkBxB7Jmzz
 QBntoMllq4m4rJhKrq2O9az2QWrajIUagCifY5lYkI/enNnVF8Dx7wrNUC2F/FVnFaze
 uNWgnOJ6v8/CPTiPuK2qy1YfJ9ksYnFxBLQzFDruwxsAepEoc4/u/UGDjQuSI/mno0F2
 mxVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7bZeI9VkQlSuXilz97ZZTp272NoWKHhwpN6r1ZonZ0ugNXsaNfaYWbgYnnbAU3Hr75VgULxHLR3dalVX7GsVIxbLeNvM=
X-Gm-Message-State: AOJu0YynFAObT+g6J4llWo9wndPjDxVIVmHCV+srrlI2qtmcl25OuPMz
 RaqEMxU1AH2KtcR6/spliGdg4F38HWe0PtoHU1BBeH3qIwZSHwse0nfrOqYQOXs=
X-Google-Smtp-Source: AGHT+IG7bNj5yG4hL1u7SvHMebA5iLw7geo+1ME2vXcb0npvJW5RRHuq/7tO6j6v2AuYQRk/8cN4KA==
X-Received: by 2002:a05:6512:3d87:b0:51d:a208:2282 with SMTP id
 k7-20020a0565123d8700b0051da2082282mr14654682lfv.51.1715085511499; 
 Tue, 07 May 2024 05:38:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 uj4-20020a170907c98400b00a599f876c28sm4708352ejc.38.2024.05.07.05.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 05:38:31 -0700 (PDT)
Message-ID: <dc856203-92b8-4184-85b5-98e541787164@linaro.org>
Date: Tue, 7 May 2024 14:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] system/physmem: Per-AddressSpace bounce buffering
To: Mattias Nissler <mnissler@rivosinc.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, john.levon@nutanix.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20240507123025.93391-1-philmd@linaro.org>
 <20240507123025.93391-4-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507123025.93391-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/5/24 14:30, Philippe Mathieu-Daudé wrote:
> From: Mattias Nissler <mnissler@rivosinc.com>
> 
> Instead of using a single global bounce buffer, give each AddressSpace
> its own bounce buffer. The MapClient callback mechanism moves to
> AddressSpace accordingly.
> 
> This is in preparation for generalizing bounce buffer handling further
> to allow multiple bounce buffers, with a total allocation limit
> configured per AddressSpace.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> Message-ID: <20240507094210.300566-2-mnissler@rivosinc.com>
> [PMD: Split patch, part 2/2]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/memory.h | 19 +++++++++++
>   system/memory.c       |  7 +++++
>   system/physmem.c      | 73 ++++++++++++++++---------------------------
>   3 files changed, 53 insertions(+), 46 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



