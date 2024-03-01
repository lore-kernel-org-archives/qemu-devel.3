Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15A5C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 21:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgAI7-0001Nt-FB; Fri, 01 Mar 2024 16:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgAI1-0001My-Qz
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:19:34 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgAI0-0007KC-7Y
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:19:33 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dc0d11d1b7so23826575ad.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709327970; x=1709932770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bDwdHISmLSY4krXDpn1gbWdD12mP21WT+zg/WfUsNtc=;
 b=gHdFzk9sIetff4NYjdh5mhkjOp3qqPtxSkraU61c97bUeU8wCoMFePWJuKB9+871bk
 yMIPsraSpoHW5UbOUQTMNJOaaGw6fYWXc/JcqlteQQkKD/ewr5TsJpnBkLUlD+ZFYlJk
 SyZbvFQT7kj6mGMZHvYWOLdoYHJKCK4kV8kg0oEWtVeO8CzP3eIMszOFo4l/vxhZEGw0
 DvBr5cWZDJ+57MZFLb7/geyr/DzRlnym5LigOWZ75AZ+iofUH9M0mrrKyMEvc2Eh2oPE
 RyWLHHIYneEp9KK5Iht/WWj31pDbul3xLGdNhNY6UaeQoKaNb9f1c+Q4alwbWkCXU6uy
 2qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709327970; x=1709932770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bDwdHISmLSY4krXDpn1gbWdD12mP21WT+zg/WfUsNtc=;
 b=EEwed90ZaZzxmMiqxrUsMLK63fR2tVkFR47DGvuQWZmMBWs4+nE2b+b6OkXR00Wm/p
 7haGZfhV2AQp95PkmCZj7fJaKV+tEFtHmASe/jV8Vrm1MK35rfuy8rzSpo+AfnonGWy4
 Bx6awNN4BcwAcYRDp05ssleA8SsbnyIvXiLJPY2jMyH+RQjQzMWxyc4ZouKzxAEurjMs
 XxI1tb4X+8mH8un48xMCDyah/++cY92oWw1utPGLH8YLcGkcvIc4FlMK+YtmM4NRggfy
 h7IqKeecvcE/7oAXNKeS8VQx7Hr2rYWATFttItLvl6M7dsWp9Zvxno6l+O/xQq5T90Vr
 SMiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/mgUzza3dga/6IczqwajvPg4vHBAL86WatGOj1EEbu4EFlaSrfsmz3NE8bumMFzJtw6j6JI1uA0gO6WlhF63W2MrlAIw=
X-Gm-Message-State: AOJu0Yxj+fmp2y9QlNVpBQCGBcwR4q9qF3YkhFOhV2tFq7pwy/V2NYev
 dVHy32AukEKs3CQcD1Fzf2WnozNlB0YhfcOKHqS9/VIoAFEG8TZjXeV6UawUVbRH7LQcRh78eJJ
 p
X-Google-Smtp-Source: AGHT+IF8vs0EM/gYhIfDvPa7MD8epOTQKDafQdzBLTWOovXYObLqLTLca2v2QJjmNsZOJsK6hUoBig==
X-Received: by 2002:a17:902:6544:b0:1dc:7890:72d6 with SMTP id
 d4-20020a170902654400b001dc789072d6mr2576785pln.22.1709327970621; 
 Fri, 01 Mar 2024 13:19:30 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 r18-20020a170902c61200b001dca920ae40sm3898386plr.203.2024.03.01.13.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 13:19:30 -0800 (PST)
Message-ID: <f0dd2308-6a94-46b5-821f-12ab907d29ea@linaro.org>
Date: Fri, 1 Mar 2024 11:19:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target/arm: use FIELD macro for CNTHCTL bit
 definitions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
 <20240301183219.2424889-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240301183219.2424889-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/1/24 08:32, Peter Maydell wrote:
> We prefer the FIELD macro over ad-hoc #defines for register bits;
> switch CNTHCTL to that style before we add any more bits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/internals.h | 19 +++++++++++++++++--
>   target/arm/helper.c    |  9 ++++-----
>   2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index c93acb270cc..6553e414934 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -224,8 +224,23 @@ FIELD(VTCR, SL2, 33, 1)
>   #define HSTR_TTEE (1 << 16)
>   #define HSTR_TJDBX (1 << 17)
>   
> -#define CNTHCTL_CNTVMASK      (1 << 18)
> -#define CNTHCTL_CNTPMASK      (1 << 19)
> +FIELD(CNTHCTL, EL0PCTEN, 0, 1)
> +FIELD(CNTHCTL, EL0VCTEN, 1, 1)
> +FIELD(CNTHCTL, EVNTEN, 2, 1)
> +FIELD(CNTHCTL, EVNTDIR, 3, 1)
...
> +FIELD(CNTHCTL, EL0VTEN, 8, 1)
> +FIELD(CNTHCTL, EL0PTEN, 9, 1)
> +FIELD(CNTHCTL, EL1PCTEN, 10, 1)
> +FIELD(CNTHCTL, EL1PTEN, 11, 1)

These bits change definition based on HCR_E2H, which I remembered when I got to patch 5, 
which adds code nearby the existing tests of these bits.

It might be confusing to only provide the E2H versions, without some extra suffix?


r~

