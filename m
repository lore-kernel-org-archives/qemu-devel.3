Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80230C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGdZ-000155-QP; Tue, 21 Jan 2025 10:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGdX-00010K-8e
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:57:55 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGdV-0002Hm-I5
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:57:54 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21bc1512a63so107824935ad.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737475072; x=1738079872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WldscwekoNWxOz+Ci2TkEmSI7wCEr+VrRrK2jDxnITc=;
 b=iqnHd5PnK1jPqWpYPBW86GavTqaZZQQ4/3q5JjJZGaKYZwVEw3ug2dhbSjIY5q4XcP
 6u/4xBqI3DR1Mo8ouyQtbe/vgBRfRW1jbE9Li3GJTpjOCg57qwQxMcYnysjKKaZyJJgM
 6qD0F18bi3+uNlIXUXGF1JQY9Bew19iVUBQYMKh8OxgUgeeJWFKoRCt89QB5Qv3NnLJ0
 tvhky+QB/jIQ7Bww5rBcDD+DceGzE/krZcBN0RLEtjkaY2sgaK1FgYEhRww21Ydw5nX2
 WKfXLwCbSc12QSmNr4D40zO4+8lZmjdSUTnbtID0A8ast4iNje67knM+vkHJBLnmph0c
 tiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737475072; x=1738079872;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WldscwekoNWxOz+Ci2TkEmSI7wCEr+VrRrK2jDxnITc=;
 b=J80ec5nS01/F3jyyzn5jlMqXXVqbU5Ev5YiZdvjEgwI4Cxywt5RvJH2RWNA1MtOE6n
 H/hCX6Zzw+ktSx4Y+AN0wfumh4VN0/6h5k9JlekuoetzD1vYii5VXp/7winXvgwl3oou
 HQHciiC2ACtYBNFvazV4S03eTFMreUz9YfK6jAX9abn7KxF/XwEHJ7vN62eslC3LcYke
 1o5cwABP+17omtRPItWsW6ETwy7GAeJpYCtQjZErLEAkifAkS4163yUtuk+MIqDPsqBB
 1tc/K1ZB/cyLj0mkOkBr994k5R71q1OhkCATcvTa5SMvacpNvuJd/XZFFQ3sIKFpiHXu
 hEaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNeonm/Ub3/pxwlvKboK5tHtAe6gXlFbumVYyJm+jKKZcZoqNhPvvfEkWcMag/k4sJqCyiq7h7AB2h@nongnu.org
X-Gm-Message-State: AOJu0YzIej9rgZnLwvJ1MXOBqGgF59PGYlU2kTdEJZ9jS9/j00PoDdxt
 zdIE74YPlA00aa5tBgsTqQlKJinzBe9pSFlUCAbdE9jt5IOAE8alxPS4l4tNg5I=
X-Gm-Gg: ASbGncu0Q8Fra/FZ/7Lx9kQU7zsa57Ojxl4zL2oVDmu88v8QHZms87uxl2hIZDyJ/nC
 /tNpvD8Q91TKPqAA6iz5eUiMQV/bfsXYumH5m4ij+5EhRF2pLBHhjj7MKhoO8kTqvQseYwqiyC7
 kw1VAqHI1yuoQctlphbdxPH2BRsh441XN39a4wWP8wNGHiNwQ+/90Kt+qnLGviTFC3D/aylkDxY
 dj1leV8ODdpp04D8S/a1sYePue19Y7ZzulZsSE8Z/e0M8J9nj/g4slG48kk3WSpu2odDiseyh8g
 ykYp20JfPGJWAxGgzifouvfUwbr9HgrR5i4m
X-Google-Smtp-Source: AGHT+IFBCJLFK+bOHOjHUs+sjPb0IX4J/S7OhQ4KmrCOhYA9YLJAWVTHdLhDUH2NTN38lrohxe1Q9g==
X-Received: by 2002:a17:902:d2cb:b0:215:b74c:d7ad with SMTP id
 d9443c01a7336-21c356307e6mr274617235ad.36.1737475072059; 
 Tue, 21 Jan 2025 07:57:52 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ceba9afsm79813075ad.74.2025.01.21.07.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 07:57:51 -0800 (PST)
Message-ID: <4b25151e-8c0e-4d36-9bfb-41e144aacd2d@linaro.org>
Date: Tue, 21 Jan 2025 07:57:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] disas: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20250121114056.53949-1-philmd@linaro.org>
 <20250121114056.53949-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121114056.53949-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/21/25 03:40, Philippe Mathieu-Daudé wrote:
> CpuState caches its CPUClass since commit 6fbdff87062
> ("cpu: cache CPUClass in CPUState for hot code paths"),
> use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   disas/disas-common.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/disas/disas-common.c b/disas/disas-common.c
> index de61f6d8a12..57505823cb7 100644
> --- a/disas/disas-common.c
> +++ b/disas/disas-common.c
> @@ -67,9 +67,8 @@ void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
>           s->info.endian =  BFD_ENDIAN_LITTLE;
>       }
>   
> -    CPUClass *cc = CPU_GET_CLASS(cpu);
> -    if (cc->disas_set_info) {
> -        cc->disas_set_info(cpu, &s->info);
> +    if (cpu->cc->disas_set_info) {
> +        cpu->cc->disas_set_info(cpu, &s->info);
>       }
>   }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

