Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16423CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 15:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2X4W-0004au-Jc; Sat, 27 Sep 2025 11:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2X4T-0004Zz-Ak
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 11:42:49 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2X4M-00013G-Od
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 11:42:49 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-78118e163e5so1170473b3a.0
 for <qemu-devel@nongnu.org>; Sat, 27 Sep 2025 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758987758; x=1759592558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iOeV/JQwtzpVpDo3fSTXQDCvZvAjwAUUYVvvgEo9T7M=;
 b=qgci98t+aanIRNo+9W0S9ywH1WS4eq/ETmwMIgyB6vwG4s6aOAAD8Z35QPsPpFfpQQ
 6CGW6RLYWfjQlUHNIeSi/tHcp9HjGhLhcVcPrI9wsDAfXOygqqgFa4lXDmz15Bi18pUJ
 gCRXbPbsJGiNjpdhMZtvUWy4U37+lqxxfIhu0RVr6+K2rdokLszpZDR4ysairdxYpDDI
 IP7AMMyTjQRcNqCva6Yr0IxBZMhWD5pEA5YbCFwHxLPpH627VksfgyKVsKMJ3qNh9CUT
 x3Q5SzLTEDU8um4qLt3CeYkfFWZrwGzr7jV9wqNoEumjcnmISLGusM5moDWv+x7YEDtV
 u3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758987758; x=1759592558;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iOeV/JQwtzpVpDo3fSTXQDCvZvAjwAUUYVvvgEo9T7M=;
 b=ckTWRdpG7QD/zk+O6Va9CmrSca/v4upLrzVQ44lAjNbQ3NAduudli8UtifDvSOJm7X
 cV2BxjJe8C9uxJSosVUrovCvYTe353MRdr1sL1TSEYDfgAYSkcL8a00/dJNyRN0EB2kG
 B0oRJwtGXYmotMpDu4OGuwzC3TqkLfvmF+CzasS8CMhDTA4Dzb+u1wZBembDHUoP6gIB
 hdXSWYDNIX4dieUpiqtu0Z/VJSwGTNF9Ox+82ucbFnAVcgmhl/oL4BDTDrupuJ98WGP/
 DTjum+JnEKtGE/xb9NODhMu9fhqjkFhkfFPN8zWiue8R6MHRtryBOQlVWrXgri+ULpyJ
 aeFA==
X-Gm-Message-State: AOJu0YxVztsRzCiFzkbjOe2xvIyASxOoR5KzztPSnlXtcQXrCKF0g+LI
 jgk8Xk0w1uwmsNJGrzboebtcfm1KsMGcSUtaEOTuzbU+1oXeWUy3uFY7dUiVF1cT2LwIWEc6IHo
 K7vszRn2ADg==
X-Gm-Gg: ASbGnctJwvBsetSlaVCHSVF9HpQC9JzgnOVXKx8Oi/QoV2xBuf7MvJVYOgvIVr95Z66
 7FpIg9PTfLZwI8epMD+t8rIGPnN1jD3ExDGMtK738DpekHwHZNRkxhm2wrA3wXUrVLjgPVe/vwt
 rEjnAT/VU3GKBfAv2El9cW7hLt3TZNT+1ejtTeFfuaWXs0zfkTwlyfvk/Hi4yrS6/AwHIeNHXHK
 VvEiSLYffmErHlUny1nsgTl37KsFML4bOpr+IS96oHLkFmYJStHCubWRp+LfAEFLFkPkfvBWRFW
 KlYMgulhHpz2Gg38aL72mkcUtxzOpckx6xYKjQywX+G3vbebIoBIzNOTWxRPBkVfO9cIDHDFRU/
 9RyihkCGUH3wZIvCEd++yyudR39fGlOrFV1ApaR+pcurnP48=
X-Google-Smtp-Source: AGHT+IGvDd+My1KOmQvVivvc5MGhIJTxVvGFuYYXwAvQ3ivhC3jU8kQvIvCt9XpBjThW9GV1tyr+ig==
X-Received: by 2002:a17:902:f60b:b0:25d:d848:1cd1 with SMTP id
 d9443c01a7336-27ed6dff83bmr100531495ad.15.1758987757905; 
 Sat, 27 Sep 2025 08:42:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6716167sm84019905ad.44.2025.09.27.08.42.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Sep 2025 08:42:37 -0700 (PDT)
Message-ID: <91c4c68b-a294-49d8-9eb7-7a155e2a4881@linaro.org>
Date: Sat, 27 Sep 2025 08:42:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/44] target-arm queue
To: qemu-devel@nongnu.org
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 9/26/25 07:08, Peter Maydell wrote:
> Hi; here's an arm pullreq...
> 
> thanks
> -- PMM
> 
> The following changes since commit 95b9e0d2ade5d633fd13ffba96a54e87c65baf39:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2025-09-24 12:04:18 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250926
> 
> for you to fetch changes up to b71e2b281a23aca474e128a8487efb07e29f4019:
> 
>    target/arm: Implement ID_AA64PFR2_EL1 (2025-09-26 13:43:33 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * reimplement VHE alias register handling
>   * replace magic GIC values by proper definitions
>   * convert power control DPRINTF() uses to trace events
>   * better reset related tracepoints
>   * implement ID_AA64PFR2_EL1
>   * hw/usb/hcd-uhci: don't assert for SETUP to non-0 endpoint
>   * net/passt: Fix build failure due to missing GIO dependency

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

