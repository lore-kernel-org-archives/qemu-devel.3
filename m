Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE74C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OQb-0003RR-E8; Mon, 29 Apr 2024 06:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OQZ-0003R4-Mn
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:40:07 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OQY-0002st-0K
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:40:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41b9dff6be8so19096555e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 03:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714387204; x=1714992004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PSPGEfl0JSM+17itBgiGSBxPfmKo5z/xwtT0fe7wMDc=;
 b=PWIAGyFIhB63Trda56HI1fdDdn3/6xxUkRzed7H03mPXHQP8IOyX3vcCiGu4sax/SN
 cJyKpTdSnevFMhY41O0vcaPTidBDM9A46lrfHe6N8qRCLyqBbU66BaWTdMFKm3CT3/t8
 5jNjgn+iDz+6gqG+xJMwelQDvX8AKboYHBbR+K9q4nxQjmDm0q/D+3+QydJ7gPnJkFw9
 Hh2dbFZvAGMpLOpK8X4MYpfWQe1bl890YqcFFOXNPzp8BmgEdDKLoTv7KJejQGtpV54Q
 odu2kkCnScIuh1rTK8tzdB/Q4rSzAr6q5YWOJVpuny+3lUWJk+Co/znca0U3Z0hnmSgj
 NdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714387204; x=1714992004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PSPGEfl0JSM+17itBgiGSBxPfmKo5z/xwtT0fe7wMDc=;
 b=YR4/c1yNPT0hq41+3Bt2jnq1+Hft/UPrjlYyAnz8LKpFXVGLKf/+vaKB8D/5gI+7RF
 XvqeOS9pO9Zt1JnO08m/SrOCz7GmYYsVIJWktfo/2zxYzY+dT1wdZMQvrd8N72GCTULY
 kq8vawEDyZhMpd9q0HbwUGDYZLsXk+yRaTIb14wdn8AEZ+w2eoY1aRTq/dajg5yR4G+g
 kW1krGlynu8MybC+g0W6HqExRz9Mz7T+K93M7qYDPh3FPdLjd4fEcD9grczhB5laZlW4
 O7pXN+UGvR+2RUZ479Q2L4XRBc5mmRkn25JWwpFEvQ9M1Tp0cBTVHkxp+cNtcfcNJ/uB
 iAhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX50/9RmNJBrq2fo5XDaQLR87UxNBg+8D+13sS8MjLE5m5brnz4ix9bVXQepW8q15y8MwaqzAQjFJutdGegYkzljJ2F1Aw=
X-Gm-Message-State: AOJu0YyFHuFDn15xaJPGM9c4AjK1+UXgeCBf9/24SSR4f+xKFZ2VCi+g
 r9H4Zp60wbabuKZTzN94fsJ2sEy90tDnISkSwuNl9auoPNljs0+BBi0W9Ri9Y0o=
X-Google-Smtp-Source: AGHT+IESfFzvY0UE5w/kfdUUrYIxyS9II2yTjO9eGGgjF11R+iEYo5XNL0EvXY/qEn1WAEt08x0smQ==
X-Received: by 2002:a05:600c:b99:b0:41b:c24c:8a2a with SMTP id
 fl25-20020a05600c0b9900b0041bc24c8a2amr4844477wmb.13.1714387204346; 
 Mon, 29 Apr 2024 03:40:04 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0041aa570bcd3sm24110731wmo.35.2024.04.29.03.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 03:40:03 -0700 (PDT)
Message-ID: <06ffe18f-a5be-4a06-b3ab-dd0333ce8654@linaro.org>
Date: Mon, 29 Apr 2024 12:40:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/33] plugins: Copy memory in qemu_plugin_insn_data
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:
> Instead of returning a host pointer, copy the data into
> storage provided by the caller.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/qemu-plugin.h | 15 +++++++--------
>   contrib/plugins/execlog.c  |  5 +++--
>   contrib/plugins/howvec.c   |  4 ++--
>   plugins/api.c              |  7 +++++--
>   4 files changed, 17 insertions(+), 14 deletions(-)

>   /**
>    * struct qemu_info_t - system information for plugins
> @@ -394,17 +394,16 @@ struct qemu_plugin_insn *
>   qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
>   
>   /**
> - * qemu_plugin_insn_data() - return ptr to instruction data
> + * qemu_plugin_insn_data() - copy instruction data

"copy of "?

>    * @insn: opaque instruction handle from qemu_plugin_tb_get_insn()
> + * @dest: destination into which data is copied
> + * @len: length of dest

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


