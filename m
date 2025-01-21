Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B606C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJNh-0003pZ-S1; Tue, 21 Jan 2025 13:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taJNf-0003oa-GV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:53:43 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taJNd-0006F9-Bk
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:53:42 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so44155735e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737485619; x=1738090419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1mp4kixCqNF5aY/wzjvtuJsTc0Evfg7uUcJP3WcQbTQ=;
 b=KFjRmxjbO+fAJp6oNFs7a6XMgRF5H5Gd4d6BH6+izvwinVz675b6qCDASO4hW1Zorx
 zk+3CI0wIKAAnE0+SdGHjmvNeVuaRM8F66O8oHIcns0iSuBY5/JOFx9vPiJE6DKBQLxc
 lMBw6KtI8zlTkVHHVuCaHpI6yvhZG446dXwA/EhiSkU5q8nbNQOeaYoX5lYc04fImrcl
 3TsjY/+HVuySwl3CDwDaHvX8Yh9zn02jPd4EfWlB8HgRdM00QW3SHTV+/DESep2q1e8s
 1i8VCNHrKExZD2jSaKnWPA74m2uwWdoUXPi+xD2RYRJkFxoPn22sTyHTe4aj31zB9jCR
 K4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737485619; x=1738090419;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1mp4kixCqNF5aY/wzjvtuJsTc0Evfg7uUcJP3WcQbTQ=;
 b=B6UW4add9UuUY6Nny44Ew4tLx5R+Kz6K/emlxwODQE424AJYgINVGI7PBIFkq/CHqe
 u3nBzAU8DFRPFmQiuvLlR6khj764nrfeSY4OQO7Wp91t87NQ1MD8oULIqz7F7EEVuw55
 OqFq87pa1OHSFtCuHl6BIsU1Bc62xKGfUxsCkjFX7L3e1T59Kr/0YNGc9Me6YZEDHY0f
 NcTYX7m7a1oUyAcFFTlyRjAxVbmdxNXlXWhMzL/ja4PtHhn4qTSEabiqz5Xcz8BTGzbq
 am0QRvfxAywSN9B3pFNT2Ib3piHqM0GfIzGK8jqBoz+DzNUh2rVy+6Qpi1VxPvvzA/wL
 g1cA==
X-Gm-Message-State: AOJu0YwFVYOm/KShHXgN9TOc6uNen4oV3EVDk8cNiDgzXxMcL4E4jNKx
 de8VM0iksQ7J4fF8YOPiEk052YLKDq+s4JrPnsWB+0nKiqhxIPbVitc94kYZoZ1ojYZIHRoKpuY
 jAiQ=
X-Gm-Gg: ASbGncu6/MkM0okojqZU2b2fx0lkK/p0bwp1+6ariVpMvW6BNTG7GE41luwCuLehH2u
 gyQachU9x7MLqhl2nrz5f1kE2JRpTkzv5Fjc8iyjA7AhJz0YHm51I7aONqGD7JHyFL86wqvIRiF
 3xVlTyJBLjQAJZtRPv8WtwSFohTtf0pdndDlf3mG5XsgTgDrwv4Ov58qoMFUe1iX6RSzlZRAzyX
 6Qb3FUEf2BiXMJtjaGit+aB0yRru2FTeVRl9T6TM9MQmOf84sM1tzqXOLfRgx4FFky2kPmbzeos
 8gMqFEk5s/sr6wZlHSjHNKbcaYVS9TDt5eRGdQ==
X-Google-Smtp-Source: AGHT+IGO8yqv3zKETuNLrHZbLjKMOpTtPhjzdTGGrEX0ZlfKUrs7B3cHEUln8mfJuSHcc0Xq+c2jWg==
X-Received: by 2002:a05:600c:450c:b0:434:a91e:c709 with SMTP id
 5b1f17b1804b1-4389145145fmr157533605e9.28.1737485619042; 
 Tue, 21 Jan 2025 10:53:39 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b171e68bsm5143915e9.0.2025.01.21.10.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 10:53:38 -0800 (PST)
Message-ID: <67ed0028-e559-40d1-8266-0a220021b244@linaro.org>
Date: Tue, 21 Jan 2025 19:53:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] hw/core/generic-loader: Prefer cached CpuClass over
 CPU_GET_CLASS macro
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20250121114056.53949-1-philmd@linaro.org>
 <20250121114056.53949-9-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250121114056.53949-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/1/25 12:40, Philippe Mathieu-Daudé wrote:
> CpuState caches its CPUClass since commit 6fbdff87062
> ("cpu: cache CPUClass in CPUState for hot code paths"),
> use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/core/generic-loader.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index fb354693aff..0ddb3a359a2 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -48,11 +48,8 @@ static void generic_loader_reset(void *opaque)
>       GenericLoaderState *s = GENERIC_LOADER(opaque);
>   
>       if (s->set_pc) {
> -        CPUClass *cc = CPU_GET_CLASS(s->cpu);
>           cpu_reset(s->cpu);
> -        if (cc) {
> -            cc->set_pc(s->cpu, s->addr);
> -        }
> +        s->cpu->cc->set_pc(s->cpu, s->addr);

I guess we can directly use:

            cpu_set_pc(s->cpu, s->addr);

>       }
>   
>       if (s->data_len) {


