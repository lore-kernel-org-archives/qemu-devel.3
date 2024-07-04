Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D33FC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPR0Q-0004JD-16; Thu, 04 Jul 2024 14:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPR0O-0004IV-3b
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:16:28 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPR0M-0000BA-Bp
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:16:27 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7066f68e22cso644651b3a.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720116984; x=1720721784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8wxdDhrJj5m9EBv+KsTaak4F5a5JHE5zuinYQ+oTD74=;
 b=MeeyHbVjj81IZln0geVc7LZwz+y2hbqTPgHx4qN56Y00TXK8KwjPjZhp8GRIRJJonr
 aT6pL5DRVJTDDAsJd+TgwuVYrvPodP8UA2WuuqmwgiDwivQZu8TvpzqD4MJUDg2j056G
 p2y0gJ2xxvMyYXktKRZHETxjBR7Re6JgaGdkUhF9z5e9YCsU9QpImL9X2pDkxiOULATy
 SRO4ZCjPp2KOz9hunxh9OWtjo/a8EyrfNmAHWA6gNJqIlY4CF7+tmjgXygtiOy8Rmc0F
 KMLA9q9GKL9VdGxXmiNN13CcCcG7ZhOBmCR23LHhTsKMxXPy0kHcp9zzBYd8zeTbww8d
 vURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720116984; x=1720721784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8wxdDhrJj5m9EBv+KsTaak4F5a5JHE5zuinYQ+oTD74=;
 b=mxoBOVQrPMxkmNIZr5SsOJ9rVA1U/al2LxstWAEGHNlChZw9IpAtTv5y7RTy55CwmR
 4Fpry+94UD+rp68Hs/lq7d7Xkfb9mjMGcjkNFz8n4gWv/thyfDEt01rmfWB7HoP6AeCo
 dpWNzfM4npV7kxPu+lmJ5QZIdTsePlK+wu2y15gU6yoO8dhIGo/dIcA+etqai9StzF+E
 b2PDVVvag8zaFubMfRhus3kzGD07abpacZTPLS7KjmiBq/zym7HhWG8Zah0qR5rVnLDv
 ABB+ZGGjctj4t6eReVqYNbMHIP9kTYppfO7qra2sEaLvu8MOS8wtrZNFRY/r1lqZ1vMe
 XBVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4j+zBF7b3D8jSuOtn5huAOB8/JKWRCkwAWCX7hsqyid/Ws6k81RjveGmOUMCfQLoDHkvskgSE4raZIYjfGjrvUVB17fY=
X-Gm-Message-State: AOJu0YxPgKyRsm1ZHhq/cl3hYBoCZJybAyj6pQr8CoyJBqh10UH1yAu2
 CqiJsb1/bVcpE2OalV6Vy/wblmCX7uzb663pGDa/vmuXRITIltXDyIa5z9sNPL3z71wMLkJyXjB
 L
X-Google-Smtp-Source: AGHT+IHMjwHCvwrbeyhUYUQKS8SURYUIpVt1GZpSz6DuEllCRIqrTP+D9IAl6lHCPwoOF0ThS1GnMA==
X-Received: by 2002:a05:6a00:13a7:b0:706:5e33:32d5 with SMTP id
 d2e1a72fcca58-70b00afe62bmr2645485b3a.33.1720116984151; 
 Thu, 04 Jul 2024 11:16:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080246c90asm12518290b3a.59.2024.07.04.11.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 11:16:23 -0700 (PDT)
Message-ID: <ffd0e577-95e0-4cfb-9500-9e2dee993fa6@linaro.org>
Date: Thu, 4 Jul 2024 11:16:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] meson, i386 changes for 2024-07-04
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240704095806.1780273-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 7/4/24 02:57, Paolo Bonzini wrote:
> The following changes since commit 1a2d52c7fcaeaaf4f2fe8d4d5183dccaeab67768:
> 
>    Merge tag 'pull-request-2024-07-02' ofhttps://gitlab.com/thuth/qemu  into staging (2024-07-02 15:49:08 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 188569c10d5dc6996bde90ce25645083e9661ecb:
> 
>    target/i386/SEV: implement mask_cpuid_features (2024-07-04 11:56:20 +0200)
> 
> ----------------------------------------------------------------
> * meson: Pass objects and dependencies to declare_dependency(), not static_library()
> * meson: Drop the .fa library suffix
> * target/i386: drop AMD machine check bits from Intel CPUID
> * target/i386: add avx-vnni-int16 feature
> * target/i386: SEV bugfixes
> * target/i386: SEV-SNP -cpu host support
> * char: fix exit issues

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


