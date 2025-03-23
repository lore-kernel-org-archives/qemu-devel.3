Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB9CC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 21:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twSpY-0005CH-8B; Sun, 23 Mar 2025 17:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSpW-0005Bm-70
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:26:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSpU-0006S2-Fq
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:26:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so21419595e9.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742765159; x=1743369959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S1XrmgFb4Zh2r5gWwqr8ad3uzEoXBkR1m6/3+ZgSJ+4=;
 b=vbZLwVayAKfFzI4q6Fc230Fp8fMcJCwkW+v3EGGXtRn9wiLidbqc19Vu/l0cK9A5qS
 ViHbvKxjIqyqfn5mOrAaVulWshZBx4lSCpubfyoHvaBsjtxlorcKFt9HYFRxs4liH//n
 1Q/fpnhkqjQs5XgOUzboH+RVsEq7CzxC+l2oDR7JIP1B1FUAc4ZI8FCOgm4ff0UsKFfg
 sCyR6VC/uqtOICZMIR5f6Dupo8Y0jHdZ23Ioace4g3CY15meUfclkDdZVaGj1nGyT2pv
 IXB02MTbPmCRLrnqVty+hIvgkQVXgcX2XeZ7PknmiFilXS4xjmWn+de7ByZZCtH1rLjr
 xggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742765159; x=1743369959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S1XrmgFb4Zh2r5gWwqr8ad3uzEoXBkR1m6/3+ZgSJ+4=;
 b=LM51OWjgcIMKQGTCcUPkUI+eV7qaWGP/HOpGHvXpCPlvlCzvO1iZjzdYolQP1qMhwT
 KXXASOUpRCDmaiks84yGH+6YkdG1ZU9GYmG0lkHDvf9Q6Qy0Mg9ehyZJ0r9k0XF0Ccc1
 BQDiJVEzt0lPJYu0AX+uoYmuN1+HUr1wD4ccdUdL4TX2GF47czhAIThEfw+CTp7dRY4d
 dyaCnT42gGSg3eVaUMAbqOCPLBj85sCvry0IWC3kmXmWc4rLpBS9dLDfeOcR/W87SNjY
 NlLT7ByyHEzWWaPahDA6/ULXdTAp8L/v9WCztJUG6XYazEw+VPM4eTu6WKrty8ZRd76q
 IU/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5td225+UxmIj94cKJnFvNo45bbeJvTwumemK4Vq/4gqyJBcx5SQ/faHNoM3NFJqCF3EAnA5f4ucNv@nongnu.org
X-Gm-Message-State: AOJu0YyssqjhXTf+NktWAxfyn++snq3DRCs354xBREtiq9/SELGtKIXj
 6ipIVmQ68JueYZXPZKVVhNDmGf7QyvgMBhW9C+U0RhfjHE02uVHqEg+PPb6gtIU=
X-Gm-Gg: ASbGncutGD9Rx2GdzV0cdWbLkAdmpmtYVrS8FzXgvUIDxLOBEDJsPGq5BoBEkR+UC8E
 byb9M3JBToYFDOlAcPo6I8U6pzvKKxmJQHzcHSVtZeb69dHn2bDebfblZ8aDi5yVub25EE1FLE8
 WkilncVhb2OA12ZgX1xsKCGqMFgkVFD4RUAsLB4Ek53uECIuwr72Rlyy+OlI6fipGg2NwmCo87z
 0W33cR6X7vZnr4O3+A/xX04XvlM1kmVE6PDYj31lp83aoDY9zgZ8klxkvpiKk/ho0wD/ko09Kon
 pvZcoGABXU1R7OlpM1mReYMS+5UVjlA3i2904iY3L9Qdl4LJ6yAJE0BD4o7uKY4Gz+ur3uzQTYm
 J3mspOhyHWlEa+RlzmQ==
X-Google-Smtp-Source: AGHT+IEK9kb9nSuGW2WBE2Bq85j3NLxC+rmSiplVjHrRT0HefJ5Fd5weD6ueGRjJIcXaUWgHvVguaQ==
X-Received: by 2002:a05:600c:1551:b0:439:4c1e:d810 with SMTP id
 5b1f17b1804b1-43d50305391mr102167705e9.9.1742765158655; 
 Sun, 23 Mar 2025 14:25:58 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd9ec29sm97983675e9.30.2025.03.23.14.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 14:25:57 -0700 (PDT)
Message-ID: <cb49a47a-41c0-48ff-9911-9143f99c196c@linaro.org>
Date: Sun, 23 Mar 2025 22:25:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] hw/core/cpu: Use size_t for memory_rw_debug len
 argument
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250323173730.3213964-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 23/3/25 18:37, Richard Henderson wrote:
> Match the prototype of cpu_memory_rw_debug().
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h     | 2 +-
>   target/sparc/cpu.h        | 2 +-
>   target/sparc/mmu_helper.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


