Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43C5C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 17:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3ffK-00041K-F2; Sun, 05 May 2024 13:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3ff4-0003vD-41
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:28:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3fer-00020W-Jk
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:28:22 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ee0132a6f3so1988975ad.0
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714930094; x=1715534894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a6PmXlljicyUKu1kRZOlfnoIeOP8EKVaqj4Iw8qf/18=;
 b=lXmwgKCyBrkqC0f6A+gCff0YwWirTVnp4DRjPXhvOm1kF7hMbLX6jRTuKU0gpD4ctl
 mtEtcuxEpBk4M1u5YVacy5QIYUUZjrgLsMGYJN9HiwyVzDWgf1SZl3mZDZNAORZygO0M
 RUf3Z8OXFoRUgDb1ODuprw9v9oAALCpNZMWKKTDrIZYbVwUtw26l/PI0QO8089SqB0PY
 DZCBcGF9bBGZcr5OEiCNFGX367KyDhwSTuJIRrMywaeY29RDVGT7k0ISZA/WIe2L0MiJ
 jyc6OQVfT6vm8y3XBBplVDjUkhYhlhYUwQbJqWJgfMckW4FCrjFny21KDBz2o8IwkzXf
 8Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714930094; x=1715534894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a6PmXlljicyUKu1kRZOlfnoIeOP8EKVaqj4Iw8qf/18=;
 b=EoNx3tz9uAmqLkhQmNIVsLUs+4Ajy6Zt3r7W8YWTunKcoxAsnuYrxMpMAkaicKNWKV
 BL9Lk2Lahk4aOsdR1P+9XABaT58CToVShipCOdVz4WddhX0i316Bg6mFjZeuQLkVW00/
 AYt5SzOY4BBbqTIPk47J93bb1q5lMHAtoJmYbeZfJtOf4VvFTW8B/pypBXr8Vyl9V6B6
 Vm9A+qZDE4NIyyNQ5fyxaIfgFj0oIHuRTLdCAoZFNS/fOc1otC8sifq4C+BD/H0J8AxE
 IHEjwPbNiPodTbXaVS0zQ8Uu7AZcxCwKJWc66v9TXC3rO4gT4grR8QEywf34zhES8lAu
 kIdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhZQJ++AgOe3ofnwA58ptxpXtPM7C716oZEkvlCHDAKV5Hj1jhKpXFzs7GLPUjUmJHuMkS34AISc5qmWjAU87leNn1PvE=
X-Gm-Message-State: AOJu0YxxRfVFhfU0UpNgKdXYNYduVzz59Nt86dLT1D0AWXGB8ngTfzhE
 NR+iQdaIyvCSR9isq4he4vuWq6OdPO1HjkUwRUUCxVNHt6uyYZRz7g9+J+Dxttc=
X-Google-Smtp-Source: AGHT+IEetWSgSB97VQ8qw7S7pz3Hpzg8H/3vMHBZmPW4DLZof0OB9bBQTSdtLYEwTYD/kpyotYad1A==
X-Received: by 2002:a17:902:cf0a:b0:1e1:3300:702b with SMTP id
 i10-20020a170902cf0a00b001e13300702bmr8825038plg.15.1714930094454; 
 Sun, 05 May 2024 10:28:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a170902f0d500b001dd02f4c2casm6761544pla.164.2024.05.05.10.28.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 May 2024 10:28:14 -0700 (PDT)
Message-ID: <f2b8b540-9e3f-4366-a721-52bafaf2b30d@linaro.org>
Date: Sun, 5 May 2024 10:28:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/exec/cpu-common.h: Rename PAGE_BITS macro to
 PAGE_RWX
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240505121008.44A0D4E602D@zero.eik.bme.hu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240505121008.44A0D4E602D@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 5/5/24 05:10, BALATON Zoltan wrote:
> This macro can be used to abbreviate PAGE_READ | PAGE_WRITE | PAGE_EXEC
> for which PAGE_RWX is a better name and renaming it also shows it is
> not related to TARGET_PAGE_BITS.
> 
> Signed-off-by: BALATON Zoltan<balaton@eik.bme.hu>
> ---
>   accel/tcg/user-exec.c      | 2 +-
>   bsd-user/mmap.c            | 6 +++---
>   include/exec/cpu-common.h  | 2 +-
>   linux-user/elfload.c       | 2 +-
>   linux-user/mmap.c          | 2 +-
>   target/cris/mmu.c          | 4 ++--
>   target/microblaze/helper.c | 2 +-
>   7 files changed, 10 insertions(+), 10 deletions(-)

Reasonable.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

