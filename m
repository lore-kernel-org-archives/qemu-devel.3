Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838B1C9EC94
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfII3-0004hL-SD; Mon, 12 Jan 2026 08:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfIHy-0004f7-Hh
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:48:59 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfIHx-00084r-4W
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:48:58 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-430f5ecaa08so3032202f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768225735; x=1768830535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=URbsEyv6MSVe0u+ceuXm8YeqZvskrs5XxeVkkNt6Gp4=;
 b=v0gSPxTGVB/ESDgCWgM7198omDX7vtlzmeyBdori+fFJIKw9kGIez+SU0CU4LSP2AE
 tawQsWRFTXBmUIAIv3YewDXKoqmSb/J12ksUpajz6ZG/F6synj+iSMnMGwmfknS2A14t
 ACHfOWLt4DJHPXrXtNN5mA3cSUO/6YFicMDEK3zDT4+VFV9yCto4ODMJKb91HIpMeW3K
 ZFHSbC8gAkeEnIaRbBPAldrye0Ug+UwA5M7GojdoxqJ1p1ZnBa6oeGDGGRXY4zykwzLz
 XQnyFatPUAOL+DfkEXd2mtgbSmFhDyYUYB8razI1ES675Vu0d9ifkUtltcpen9jnFHsi
 3z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768225735; x=1768830535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=URbsEyv6MSVe0u+ceuXm8YeqZvskrs5XxeVkkNt6Gp4=;
 b=px7saVJHWGB4VVHB7W9fctg7bwpnVwwMZpKNJ7wekLdNUR9zEzQ9TRZ9y4wuLCapcb
 UHOX+tUW7M6saePiCgPYc1rLtdN57g5zIUxpBaP5Ss1zeYpEABNmRqAShqbauhO4oEt+
 fCG+rs6xptwtrR6chJkEF87Uh8rhmsXfIl4WFRvgAvsFXeCK0MUQZ6jyc4tTP9XxBsMK
 TmIa4NoPKUKXRdg/apr12WkJD5X8jMS61BIKkU8QUtEzpcRKO1VjKYVibSvotLlswfcS
 qkVFW27IsGlXUBaPhceiSWF0/6oeRRu6LWM3sKyT2VIF3tYUVSSu4P6Ql2JbLhDthVgc
 Kkqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNB7a8Hk0BSPGkUMsVweTs+BI+28H7uF+9zUp5YBZ8Ut8QEcPurEmAtU3ORqJXsLH8PWlFp5E9x2VG@nongnu.org
X-Gm-Message-State: AOJu0Yy29svZ6Yf84MddVC7N3/kJ62jDI2ruuzStv4IMM3eINkuW9nEK
 7QWL4p7TeJzBjOkfjM9MXV4137FGXroQ9n9VxJnZiK1dP0g5TFxEnbmanPT0kKX+r9ZV7UMq7PG
 g8TijqsE=
X-Gm-Gg: AY/fxX7m/uKyfhAIA10Jo/utLa+v9h/73TroE3OvitMwUF5HXhlYCFEQ+PGDoMm+Kaz
 YetHyYVH5EEKG+Ng9WDbheP8w9JJJirjwBUKMH2Vps+JKjBwKbSnl0Jx5ApyZaftm0+DVsnKfLL
 kN6vn1PZLAgqAH7XWuA8WzSGWZDvJwbFHRQIS0MCCFZfyRyM1J6zageSxx77H65Y0V2P6YsJFUs
 xG99ulLM0nfJlB3xfRh1RN4xJRDqX9ylxxRgHstMIQd1qSRp7xn3NEtW1Vp1//kWIQpnbSzZJuE
 Miu+8fchfL2YJGguTJB6xdDHwQn7hPCmMPSEPDoNfMbTY6qjCZnUkplEw9Ftocl6LYNGeBhqRhT
 LXnd3bcVI95iG5cQ0BdGfVLoHAZHZRamGnGEgyhPIy+GZQK4ZbmYRm/s0Bf71qswTXtx+Y2WNMp
 zDkR6ChKIRxwNab/GmwlWicNm46jA3KPmKE+dlqO6hAk4pAPXBiU346g==
X-Google-Smtp-Source: AGHT+IElZx/kYZ5puvvTFuQfG3t3Ao3TEES3Mxl6L3GiD29XSE7fjkc0TW1kH1HjgOKwc90aL92oGg==
X-Received: by 2002:a05:6000:1844:b0:429:b751:7935 with SMTP id
 ffacd0b85a97d-432c37742bamr22957408f8f.56.1768225735462; 
 Mon, 12 Jan 2026 05:48:55 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm36864185f8f.26.2026.01.12.05.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:48:54 -0800 (PST)
Message-ID: <54c03507-5c70-49d7-8afc-b59ed9c5ef8f@linaro.org>
Date: Mon, 12 Jan 2026 14:48:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/vof: Fix build error
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20260112124722.1029212-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260112124722.1029212-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 12/1/26 13:47, Cédric Le Goater wrote:
> Newer gcc compiler (version 16.0.0 20260103 (Red Hat 16.0.0-0) (GCC))
> detects an unused variable error:
> 
> ../hw/ppc/vof.c: In function ‘vof_dt_memory_available’:
> ../hw/ppc/vof.c:642:12: error: variable ‘n’ set but not used [-Werror=unused-but-set-variable=]
> 
> Remove 'n'.
> 
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/ppc/vof.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


