Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA84CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGGt-00067O-UA; Tue, 23 Apr 2024 09:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGGq-00067E-M9
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:33:16 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGGo-00052O-HF
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:33:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-343d7ff2350so4276002f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713879192; x=1714483992; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EKT0/x9xaQbXz5zb6BYKxAy5WQtl3b+cNfjjL2axToY=;
 b=CG7R6r2XpnQaoeN1HGSv9P2NqX9jnxiygphVbmDBt+UnYUNpzVkqUXwN+l31fYawWX
 VSnQf0eHt2ACo/nSJthK/1BW3OvVPtsEpPn+tJDbK6UANSWM63tvAKEmaZx5ZnSnTjoH
 2IMEp6gdyQ/srd+pBN5Fs1rJVjZDTR974s8ygVGMmQni3PL020OuDjDrGA8xxZvafyVF
 Dwg+wC8bChwBAq07LXKFwGZK3EwRq71akKNmmLWYxk1IQvQ4+4q2yphtoPb1FK/kBdJw
 Nb7ZfmrzKBSxEY/rTZFh9nKvwS/2oii2M9ScTQDIwP0M1ilXXFNT3bgroeNXfbpp/r7i
 znbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713879192; x=1714483992;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EKT0/x9xaQbXz5zb6BYKxAy5WQtl3b+cNfjjL2axToY=;
 b=KZKcT122OmkMm6+AMWw56qnm35oRKwwZBuqPP+19CsPxTm/URLfSwxhMA8gUT8E9x6
 eNDdHrmMnR02Src1OalrUTfAeQlG4Uv2SpvZJSHvM8DpQEdRDacjfQtPaLnIzV5D4F+Z
 t6YPR5ibLhbTRPq6SPXvl0206uScGispba+Tc5w/ksxrbQFdIJXlz6WKhZwTUzmhFXab
 oEsbXwfKXc+4rECHUHqYMnG50MBx3Nu41p1SXbtMJPOo5QN+tNZoRsQIEnsjY5H5ruM2
 KIWIwbIALy04HFKOAiA9ABF0ZELVZMIgNt5NotUBLysrnuQXd0E1L02MAiQ1eLZrAVyV
 GBxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1xCMeTC7njx4+1o3o/SSRaBA2hXhLFFhljUWf8InWu8awgY3nLPrdj1hPzSKBgwFHbqhbJAamCv6/a4RFYcv983RgUsw=
X-Gm-Message-State: AOJu0YyHSdY32qkAuFF4qZPW8HhL1w18rpWyfggsDZYrhnoooyjuuAIy
 U6YlS3MJOwoOqYxKZP5GmjogS+71V4Try5Hs2uRRIOlT8GedVXsIT0LOxsS2scE=
X-Google-Smtp-Source: AGHT+IEunVPQswGvRJ3W9QGMiWtL9KrqWY4STMSlmPfq3K59/xZceEo3/fUJvYu3lglWQudgftGb5w==
X-Received: by 2002:a5d:5cc1:0:b0:349:8ae9:b01f with SMTP id
 cg1-20020a5d5cc1000000b003498ae9b01fmr8021549wrb.1.1713879192088; 
 Tue, 23 Apr 2024 06:33:12 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 f8-20020adff8c8000000b0033e7b05edf3sm14559448wrq.44.2024.04.23.06.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:33:11 -0700 (PDT)
Message-ID: <44cfcba4-295c-48f1-9fb4-0ac5156417f3@linaro.org>
Date: Tue, 23 Apr 2024 15:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/22] tricore: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-22-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423131612.28362-22-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 23/4/24 15:16, Paolo Bonzini wrote:
> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> Continue with TriCore.
> 
> No changes to generated config-devices.mak file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/devices/tricore-softmmu/default.mak | 7 +++++--
>   hw/tricore/Kconfig                          | 4 ++++
>   2 files changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


