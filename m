Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C158AC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 09:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBWnF-0000SV-7g; Mon, 27 May 2024 05:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBWnE-0000SG-Bp
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:37:24 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBWnC-0005KW-FE
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:37:23 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5295dadce7fso3844620e87.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716802640; x=1717407440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=98HExPg7WH7IeeLiCebIdJ65EUuHdinqNzsoI+BnCs4=;
 b=FgwFuYAXuuN+BU4i6X6DTOQggNM7O0saPwenQPtzvSaiCs4bV2Op52xcU2uxBjoT+9
 hrjR/BL5f/lxIPrY6UvkOUTBu4/9bxFkdEmL31YZt+BIRRPCh+IKRvGqzjUExRW+2uFl
 k6bfR4Xc1St+40x01FdE0iCB6EkOn59Bv7ehY/aWXpYpHl3/29FDuPs/1OUxinkbEUpp
 IJ4hds89O7mgBNdRPxj2ZLEzKbAkLVfi+DHDWZkRHuJtH2YPGzRXFRZOoVhVZovlr0TE
 V35TRHsCESB51LOS7Jiv81mnxXG4QxEOqFSsSxZ7Qf7n+e18MfH2O5+UGhuXdh0QNMeE
 Idjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716802640; x=1717407440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=98HExPg7WH7IeeLiCebIdJ65EUuHdinqNzsoI+BnCs4=;
 b=Y/8b5t8rtnJMR7d1G0qg7EEDvHtY7TmuafwjhF5Q6cnHUk3jUdP4AHuzZ6854RcPhp
 O5Q2zT0t9yCSjyJlUHET/VBfV3mupPGTGwr7KwM+R32GqdWuBArqrcV07jCU8WDrStYi
 szYmIlMESTAZ5kuO9TqBugIhuQZcmhsdUmRldrjN65aXCK8WjUi8pA3mzFr2MP5Zn74r
 1XYHIQPpfrJxBdlszfYVnHC+flTz5Zi+hjOlEZckE2RcpAlF+f8DkXk3ehtgPkMbTqnq
 ulA2pALGNUJbYSrtvWBsWbXg3qFjJEeZ8jmFZxmWatGZUtaI7WzcE4G3aoxQhZhEO0Bc
 hDrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv3lXIx4MGmDWHSTb5W9edDvF4AXFNB94xXc1CwVizy02+nPp1oWVgWIQbZDnyji17DGfr5XFq9UYuL7gUR/6UUzGdDGI=
X-Gm-Message-State: AOJu0YzqCcTfn+WtCKf8InQ0lCp5jCF61hO9/Cs12fPjM+Prjse/UzgM
 GI1uHswVr0zcKtGi/qDcpKyHraG7N+xgMurD4R/HWGhS/2q6haSgOdAtlYm5SfQ=
X-Google-Smtp-Source: AGHT+IHUhARjQ3VaWpLBTf3SuCrEcadQ0g3qu/te65YbERZ8igAr/QLma5FEukl7pHrHYekS5OPLHw==
X-Received: by 2002:a05:6512:388b:b0:523:aac1:b559 with SMTP id
 2adb3069b0e04-529663e6304mr5306695e87.44.1716802640354; 
 Mon, 27 May 2024 02:37:20 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4210e63ea39sm74680825e9.30.2024.05.27.02.37.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 02:37:19 -0700 (PDT)
Message-ID: <98e4926e-efbc-4ea7-9b4b-5c2227dd455d@linaro.org>
Date: Mon, 27 May 2024 11:37:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Init tb size and icount before
 plugin_gen_tb_end
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
References: <20240521210604.130837-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240521210604.130837-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 21/5/24 23:06, Richard Henderson wrote:
> When passing disassembly data to plugin callbacks,
> translator_st_len relies on db->tb->size having been set.
> 
> Fixes: 4c833c60e047 ("disas: Use translator_st to get disassembly data")
> Reported-by: Bernhard Beschow <shentey@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Oops, missed.
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


