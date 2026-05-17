Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0847CD4F4B
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOewi-0002mT-Q0; Sun, 17 May 2026 13:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOewh-0002ly-65
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:06:31 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOewf-0004o5-Om
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:06:30 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2bd9c3b550aso10013025ad.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779037588; x=1779642388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gPwUEWkrWiQScPrq/E2sdz0XwJmhjgBT6pOwJ/CF44s=;
 b=mjLfSLvyBQH9EC/zzysyG2DKME1kgFB3PnRzGxVgOHFFx1udeHz6SavxO2T2gOa194
 OpbNuLWKfC+z24AQzspYe7QQqBGGYxqQ9pVP7Ejj535WPlPo3kk6NkSd2dx4H2vELRMO
 KwJrIlyXA2PK3RkUBfQAUxhC0wjKQzbcYNWtiz9sk1zL+iF1I4y+jZmGb/jHIybbINFt
 fLrichHWKdCXQwUmoJZBkBamwyuI6r2ygJJnyrm12lwpSsONRIC0BmiPQd2zUwAM+NE0
 t8nOjumxR6Xxae3z9GdV5WIaaF1cnRtW9qWHFrcT+nlt+3NDbfUE567hiufeklOkgk9/
 bDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779037588; x=1779642388;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gPwUEWkrWiQScPrq/E2sdz0XwJmhjgBT6pOwJ/CF44s=;
 b=Sqs6QCX2luhj8lRIVYKrYPllr5cawm0MyZfcDcUg8h3qLMuHYvaaDPk9QJGkTuzMzK
 rKKJ9/rXSe2wubmJCHkmm59h3VhG07wxmk97GLwOIjxVSJmWooZttDkNtvPqw3ivGgLM
 hJWF93+K4ZNAYCDRi848z5s0fmfviUOMAD6LF467j7mDJvMNkrzC13710LUUQujTmJbu
 PGuAFgWMKaMvmfy5gYI5pGHA0HSogJW7E+aW1t7zP5MSAuskJIkw4bV89yYggPDwsbUi
 DE67xaAiNVSaQb98I8UExT6SsdYtnBjGrBIPA07ztd4MNreizzASfgm8PIy44xKQxzzv
 LXtQ==
X-Gm-Message-State: AOJu0YzFA58CQJdPluO0I8sMa4Z/D5a9aT62MF7ASPoDoiyt5XQfdkHx
 lzSZ59fU/3DpzFSFovrQF7C6Ps1wKOranSUH6ahci6H4PMnq2NmOSohrp8Ped5t4d6WblQljPSx
 L4z3P
X-Gm-Gg: Acq92OFUZFXtb/aSUCaQgHSQBPJZ3EqGk/gCWszwJ4u2Yul5c/JfZqF+Ix6H11G/CXJ
 79FidFeT0qRhHN2yfss5xm1akoHpPWRywIleXN6BM8aaCVX3YF/LqplCSIAlWILax+BWtPjJUFI
 Bq0dph8L7c64vkAJR/PzrTq7LK33DqAsyNjRnsx6R/r70LLMYrXYHdOVvl3dAn5U95vLwpumblx
 rtJWYFS7AgnxPXDzYO23g8CdIFP/+TMmofvqjCSqOlf6he/Bm9H8RAkJK0QknZLl63efBHol+I6
 FQzpTIIlTGPrQLVNhPgPCOdr6REwXWQGO0tgwylmDsvX9gZDXacgO3LeVTQ4i2/KqgSWcj9iWNE
 cHTjm9HytwSK8srGWBJ+7MhCQHBMjH0b77WkizBqQFWMl2+1FjEdHUQL3SYMvCWYeWRJa+0tMOE
 UN/pNpzg5wsK+M32z913sr4o09pCb9M1XIR/mmnGhp5VWx5n0=
X-Received: by 2002:a17:902:db06:b0:2b7:aba0:ac10 with SMTP id
 d9443c01a7336-2bd7e7bdd1cmr127590815ad.11.1779037587822; 
 Sun, 17 May 2026 10:06:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5fc60sm126540645ad.9.2026.05.17.10.06.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:06:27 -0700 (PDT)
Message-ID: <46b7ce21-4a03-4569-8f00-2049e181134d@linaro.org>
Date: Sun, 17 May 2026 10:06:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] hw/arm/omap: Remove unused omap_mpuio functions
To: qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512203414.3633237-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 5/12/26 13:34, Peter Maydell wrote:
> The omap1.c file includes some functions which used to be used by the
> other OMAP SoC variants which we removed a while ago, but which we
> missed when doing that removal.  They have no callers, so we can
> delete them.
> 
> This code was the last user of hw_error() in this file, so we
> can also remove the hw-error.h include.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c        | 26 --------------------------
>   include/hw/arm/omap.h |  3 ---
>   2 files changed, 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

