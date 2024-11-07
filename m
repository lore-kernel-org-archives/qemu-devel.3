Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB10D5AE7D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zLC-0001sZ-Cr; Thu, 07 Nov 2024 05:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zLA-0001s8-Kd
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:02:12 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zL9-0005lw-8N
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:02:12 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso118075066b.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 02:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730973729; x=1731578529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A/vgu0qEYSx2AwLLrlh6x/5wM97m2tFAL6j6k8SaOhU=;
 b=AxVhDcb8ZC4Z8HaWREtz/Ql1ZT195unRHMU2POe/yKj861uqVEheUi3LDY5dpq02Ef
 /+PwOLhJD0n2kKe/S8RKIL305RqmEuXSygC1IzHePq7rLUgwn+3E3V/SFW98TcdtC09f
 B3ntFQ8xKyIhhRJzShZzJ07p9uXxP1mn7CXK2Fqpv/vtCIxt8e/PwisNwj9n4KyCLDvM
 lk9ltqholKCLjYDd2OK93idvdmVB2qvX2fYb10Fu0CxT6XIBmZIWFUtESl626TvhnTN7
 3CxdD1SYiNAxGWV+3KMtjSlprSeDhYZzVTy3zC3O4c/XR+32aj6od/cOso9EuVEGBDT7
 9img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730973729; x=1731578529;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A/vgu0qEYSx2AwLLrlh6x/5wM97m2tFAL6j6k8SaOhU=;
 b=oYUb5YrqN7BzVtodPtUh6mt11sGAYX8IdlCW8om8ctJ+h8JUnpxyuLylNEnjRrzdyX
 lXCYViLSkKCGAwFiBI/Kt2KzSxL/xQlIdG8o5odri5Svv8cJtLdvF4XmXkF8rS4Jn1ue
 YLGStBDIA3dQrZD8HCEHBhQOKdPUE1aq1nQwnpTWqyJdksVCOIJW9QGMGeXE0Sf0oTCa
 hR+LOc1WVbi1B7RaGuMnHN18ocVtJHYtxGikceIeHG9Nkj1/g4qr7nreYE1fwUyXW/QW
 Z+GXLtUTdFybwmZJKFLnhTBJBLCriPZBrrTPtvKZjd8NqnrWcltqLlUd5d5BlqNDOmr0
 vWsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDa+ee10Mp89xisbGjw7pTiHV2EVFiPSfUX/1YL/Yy1QMxr91Vo7GWxMXXv+c0AnpRtwDqr7B0LCwU@nongnu.org
X-Gm-Message-State: AOJu0YyPingGbNFv8ZuEeQuVbJZ3CnTuR5AW2HqfQV3Uu7AhdnhS6g61
 +9y7wpC1XZDo1Nn5rkpZBqBI/H6+3+4M+09l33KoiUfVXUuAmO+hS0Z81TQWDGI=
X-Google-Smtp-Source: AGHT+IEAysxUWf1qfrwWEOnPhhtB/zfWasVieSAAIWg5LOEvRV51vcvvuqDPrl+E1wnGqwFGKXrU3w==
X-Received: by 2002:a17:907:3f85:b0:a8a:5ff9:bcd1 with SMTP id
 a640c23a62f3a-a9e65576a5emr2097350866b.21.1730973729614; 
 Thu, 07 Nov 2024 02:02:09 -0800 (PST)
Received: from [172.16.23.118] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a4a9a3sm72845266b.69.2024.11.07.02.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 02:02:09 -0800 (PST)
Message-ID: <98ac6c46-5135-4b05-8b98-ffd22e00af33@linaro.org>
Date: Thu, 7 Nov 2024 10:02:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/m68k: Mark devices as big-endian
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241106184612.71897-1-philmd@linaro.org>
 <20241106184612.71897-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241106184612.71897-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x633.google.com
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

On 11/6/24 18:46, Philippe Mathieu-Daudé wrote:
> These devices are only used by the M68K target, which is only
> built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_BIG_ENDIAN (besides, the
> DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
> using DEVICE_BIG_ENDIAN.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/m68k/mcf5206.c  | 2 +-
>   hw/m68k/mcf5208.c  | 6 +++---
>   hw/m68k/mcf_intc.c | 2 +-
>   hw/m68k/next-kbd.c | 2 +-
>   4 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

