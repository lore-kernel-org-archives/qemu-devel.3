Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46602C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 09:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzZNa-0005VT-4X; Wed, 24 Apr 2024 05:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzZNV-0005V7-UL
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:57:26 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzZNU-000837-Cr
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:57:25 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41aa21b06b3so24410375e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713952642; x=1714557442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SJq9k/F4E/DI20pJ/4+qr9oTkkg3vgba9fcPK4UT7io=;
 b=COd12O2wK0/K9ZfhJX+Rrm5yqExwN5KPwu/wi8mE8KDPBTbS3UGndSJtrog1UAyeoB
 6YNYkgZ4iLGAl2TE6dg/85PepxixnhTiXUIs4upbVqK2e2oyL1OUmBLwkMVbuwvjGjaT
 5lFErjuNLyMpgEr2iXar5CD2uAj9zJ66PGJmsWnKdqr1gp9TbrssD1vdMfy/fcPn8b8E
 U9yUX7X303U2s4vpYHxVISAVmkHokek5j1cM3I3Hj/eNzITGHeuNfehYu3MoQP5+hxR9
 xJmcae/ZSFBL2aRbGUyPOHa99+giBdxBbXsqxKPgt8jo+ZDigAMMQqhHnCN0Z4SJ4G6v
 3THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713952642; x=1714557442;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SJq9k/F4E/DI20pJ/4+qr9oTkkg3vgba9fcPK4UT7io=;
 b=GohSjGN3T4+O4yiEigP6FTnc++eG2x9f+qa5MEZMLUgdTgS1o3GXjgivFuB6p93kR7
 GF6HZ2Cl1+iPzqUkGbpzCYUXDDaL/jy7p3EGBEAW3d8eZ4qY2FkKIVoz2bRHxHzlfznf
 RrRJx8Pa6mUMxOy9M7rCOkd4VhWTwS4CC3GEgPcvDY8ZFp8bF2Zmi/h32DUVY3MN7lKc
 fCjJhaKTpO4dOY6cpjFAjf7/N3MNY58dKrKtmGanun/p8FEhjhBs4P54ZpaD78siVutP
 TvFszzw1m3iZT32VIPL4qSLgAqgT9/HHjMvsDQoV7xZkDJSJCK7IUitHZM36CzVn00Cr
 0KWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE4q9z9rAP23sLJXBwhoh90cJF4BsQc6RLoE2vrNewoNtMoqYODc2Cv9Zt8R9ZDXYHOna9foCGM+KvK2XS0un6el4CJHk=
X-Gm-Message-State: AOJu0YxvD7aRWOavKi2hxuUPR2OE0vCXBOXSGzHrcOd5CJEAuEIVz1Tl
 D+bHZZpH5OTCMKv5y12cFpUtWcavlnk4MJKtcfTjh9zqSTbsJxoVXqTpwhkdtgE=
X-Google-Smtp-Source: AGHT+IEDN8R2JZw0OmOUXDYO+040F/N93WfINE4HnvuzfNTiHnvWhc/ehkUAxa42LlN5Kkj8bsPkUQ==
X-Received: by 2002:a05:600c:4ed0:b0:419:d013:758f with SMTP id
 g16-20020a05600c4ed000b00419d013758fmr1573629wmq.33.1713952642182; 
 Wed, 24 Apr 2024 02:57:22 -0700 (PDT)
Received: from [192.168.1.102] (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr.
 [176.184.51.42]) by smtp.gmail.com with ESMTPSA id
 je1-20020a05600c1f8100b0041adf358058sm3388312wmb.27.2024.04.24.02.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 02:57:21 -0700 (PDT)
Message-ID: <14fbd0a8-de17-4686-9304-ea384a094828@linaro.org>
Date: Wed, 24 Apr 2024 11:57:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] checkpatch.pl: forbid strerrorname_np()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, alex.bennee@linaro.org, mjt@tls.msk.ru,
 ajones@ventanamicro.com
References: <20240424094700.453356-1-dbarboza@ventanamicro.com>
 <20240424094700.453356-3-dbarboza@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424094700.453356-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 24/4/24 11:47, Daniel Henrique Barboza wrote:
> Commit d424db2354 removed an instance of strerrorname_np() because it
> was breaking building with musl libc. A recent RISC-V patch ended up
> re-introducing it again by accident.
> 
> Put this function in the baddies list in checkpatch.pl to avoid this
> situation again. This is what it will look like next time:
> 
>   $ ./scripts/checkpatch.pl 0001-temp-test.patch
>   ERROR: use strerror() instead of strerrorname_np()
>   #22: FILE: target/riscv/kvm/kvm-cpu.c:1058:
>   +                         strerrorname_np(errno));
> 
>   total: 1 errors, 0 warnings, 10 lines checked
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   scripts/checkpatch.pl | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7026895074..be0982246d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3056,6 +3056,10 @@ sub process {
>   		}
>   	}
>   
> +	if ($line =~ /\bstrerrorname_np\(/) {
> +		ERROR("use strerror() instead of strerrorname_np()\n" . $herecurr);
> +	}
> +
>   # check for non-portable libc calls that have portable alternatives in QEMU

This should be added here in the "non-portable libc calls" section.

>   		if ($line =~ /\bffs\(/) {
>   			ERROR("use ctz32() instead of ffs()\n" . $herecurr);


