Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0D1C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 19:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc8jY-0000iM-8G; Sun, 26 Jan 2025 14:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc8jQ-0000hA-Ap
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 14:55:45 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc8jN-0002nk-Kh
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 14:55:44 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so6548754a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 11:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737921339; x=1738526139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k/VcBzCgSZMRn5BGbBxU096iXq4FkgwntnoR7v0hF60=;
 b=bYOp3ovYJ9Gs76E6mAyXXKB+2kls+FKn/ga/Zzk/Dt78q4Jw5i3ZRZkZO2faJLVYng
 Mj+WdYaBCYwTt83GN68bIVZ4iupGH5IkK/FwtiwqdPgIXqum46WxJq5vbhsiSRy0PlMC
 4o7fHNcaSsVSfVp/7Zf4C+hT0P6jyXdTOkoQKwgZoWnGpltVBrcv4zkdPp+Y6bUqv0iV
 66WXLeuPPGTP3Rp+XeygrD+kUK/4S4lxABhVUfFWUMWQxTuUJGfi6dOiYg/fRw2oA+nY
 +q8GlMkG0mOV3QLh//n4MC9izaUupVkI9VjuBOSL0rxT58KMLFEU8FGIFBNmGSBE+o6c
 /UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737921339; x=1738526139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k/VcBzCgSZMRn5BGbBxU096iXq4FkgwntnoR7v0hF60=;
 b=rZkCpFuZB0GJ5hNP/AfHq5EUC+crrfXjrrNiKjDTb14GZV8026vHsQuO0fghJOZ5cx
 iI90ikzJ/R8EzIrsBPhpAXV83fNZy+nfrzmTrRhodjYU/0fvaiHJgBlYY3BL9iZXwYNl
 r0gsOuTClHobmkjxQAzK1aN2Ixw/rxD1mP5Rs9uPWYMyE+/8EwuaE4GpXoxyu8zQjAtG
 OSSHElqBeYDBzZmK27a39BTceqqqa5doh/KYp1DLoaTOPVS6mI9pTQELlz+KQnID3yeZ
 cI3FTTa/BSF7ve/pl+/15fNQh2oOZMELjp8IgA2qUcTuNu5Dg+IDFDz51cZAr4Uy6+Gb
 0ynA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFZFY9Hxl5s5LXnCGq3HiJELlj/quJYik7Q0fFEauIV7weaLB7yenGcSk1pFnbsNvQxsblnSf6BlpL@nongnu.org
X-Gm-Message-State: AOJu0YxyxyniWkpw7KpMTCOsNZm73msGy1xT8opb/NpQH8ebgQkOwyeY
 uFvosECmXvbQGkO4H4s+Uek+S5ivu+9xRXphv/vzgPEyZb9vZlaS9mreDKUar0g=
X-Gm-Gg: ASbGnctu18Qb6FdPGcjIMl4CHsaP0ZwxeVZFSnN4fu8e0XKSMxnx7De2rLaK7BgiwaP
 hkeeVhZph5uGiYdb45PglrztPQSHxEgS1dLqIPPjY0ICAmoVn7yrUXP6LUDzkS5V23jfVfl7ONk
 bVf/rNCVEZ+oHQN8/JOhCxCqVn0TxsUyOhRlyJsjwoDXtW3UrF0cCR6nwf+SVOFheNd8b1GwprD
 lTzu50gZYrQIgNJrSErV91YloLomSN36169rBet1AbZ6mEBYt6xQscrrSQxiFel1sKQFPcJ44zR
 S3rL0juylPFeXF4i4IJmbvyEQnNGrXzs5d7brwKSot94g1kg4z64j2weSg==
X-Google-Smtp-Source: AGHT+IHkPOqmTCjp5vaq/+XEVF4ezQ8MyiAJ8YKEj+eBpJYARUzB5sl2GUtr7fAvVdhnF62+x0fMUA==
X-Received: by 2002:a05:6a00:a09:b0:72d:80da:aff with SMTP id
 d2e1a72fcca58-72daf9c1dfcmr48758529b3a.9.1737921339455; 
 Sun, 26 Jan 2025 11:55:39 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a77c4ecsm5519455b3a.121.2025.01.26.11.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 11:55:38 -0800 (PST)
Message-ID: <ea6edd46-f1f6-40b0-bf89-c7f6f68bee87@linaro.org>
Date: Sun, 26 Jan 2025 11:55:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] user: Extract common MMAP API to 'user/mmap.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123234415.59850-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/23/25 15:43, Philippe Mathieu-Daudé wrote:
> Keep common MMAP-related declarations in a single place.
> 
> Note, this disable ThreadSafetyAnalysis on Linux for:
> - mmap_fork_start()
> - mmap_fork_end().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   bsd-user/qemu.h        | 12 +-----------
>   include/user/mmap.h    | 32 ++++++++++++++++++++++++++++++++
>   linux-user/user-mmap.h | 19 ++-----------------
>   3 files changed, 35 insertions(+), 28 deletions(-)
>   create mode 100644 include/user/mmap.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

