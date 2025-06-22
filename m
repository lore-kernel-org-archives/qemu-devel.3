Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F421C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTBTg-00088L-C2; Sat, 21 Jun 2025 23:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBTd-000887-Tl
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:34:41 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBTa-0000IB-Ag
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:34:39 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b26df8f44e6so3634886a12.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750563277; x=1751168077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BwxD2iPz6rDfpuej8EkZP9xWHI+e/mJimQ1uYo1hg6k=;
 b=aj74jdS4acMW3WXuSmlYlPTLb/TW0Lkj2fgSRM6Wxm1O8YHyBBZcrAz4Nc8W+jT+Xl
 V5aXTZqZHmVJ7y3p5sdLlsRxxZfxI5u081WypBAlTFVW22zi7SNyVPhTT3oCFO9EuuPx
 gnsRO9ClRRsRBClYydPYyIwHT2A6MVM4ecVtk4n067vXf3eQ/Dsy5T1xRVKVrISwGrkZ
 hxAKZMgOsNAXaXR/RNC4CyiE+/rWDZME9M1mDT75Wl4TD29CuXAlT5Pn+QQptqoGardv
 St1f5Fzz7S++QTZt7FhP0oCHTSxPQudaf5tXhq5U6fvRo/LoaNqqlITtDmuK/bRgTm74
 TFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750563277; x=1751168077;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BwxD2iPz6rDfpuej8EkZP9xWHI+e/mJimQ1uYo1hg6k=;
 b=sv7mfHWwqUgU84LvcUasJBhcwz/SUIMMnFPzj4WwXwPZK/ELPvuImo8r32wuXSm1ue
 ydPwiPUQJRPRtToEMGvVu1DH770yMWQ9t1rz2jAhxLPSn4YBhmqZC2+VoyYmuWUd4pYx
 OmfV73Lv5jsO4loZC5C6j8CWDBIC84qHhqO9VOa6M0QSC55bJDkdbeg96hjIxanyauWg
 uzAaZ173oHFizGBQIltRDp36WZ9xSAdWSXSmCgwrjYF/DPY8c1o500lcx+qPLwU6nP5T
 IyU3GMpM35x3FOwjpf1CyZ/5XriY6Hf7FjgumRtNQBx2lDkgtO4wNOmQy5XwxZk8pMoa
 Jhmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVigu6Korl9W9h2syILZYr4LWnYMcSJHxftmrgXpxeX3KHom+NPEmtqNrtk4p2EvWduEhUctZ90am3N@nongnu.org
X-Gm-Message-State: AOJu0Yz1dPs3eMVQpfeiVP+EL80fbwZICrRwOMzTFXiGexnLs89BP20J
 HovwZ5kB6ngkHtBXR8Up2o9a53LvrtBqp4+6FetnSs4wnN7FrzrMvaBWjXaDQ4fs7aQ=
X-Gm-Gg: ASbGncvInQhh644D6WXr9Y28F+zdh2B7NGtadAXOjMyoAYYskeQfHul/rTsyf532QKa
 Q27ML4IU4J9baPYoVZue7VPhvt2nQ53DZEAzcVS0wLCM7K8anTCpmiKcOPy3Va9lz/3UtCkRlkF
 57zRSa0lDfxlqZzyczTiOYSTwP2Qlkeom7Y1WydHb1zVPvQI9PR0w99+w3BmmyikmYnNbytSFHr
 JBZZum/VUPRuvLhEbhdt2vpyA0OIwCjN+fqpWdqW7OtBtZidn1RsHggR3VwgThyRW7sC+pW8SBr
 fsLZc84RYzAcEbRa+ixf3wxw1989AxicTuBkqTV9b2f++BM4uq3jGhUCx9N2i3bAAwPKztQUGqO
 uMiTOQ8cijQKiiWB0cHCWu/Yslj7W
X-Google-Smtp-Source: AGHT+IGGSHRG01Z6hi6JD7IsJMsNWPh6D09yy8kR+xZuam7gr1N36m82e/OBex1xxPbdTnxR5fjO1w==
X-Received: by 2002:a17:902:d48b:b0:235:c781:c305 with SMTP id
 d9443c01a7336-237d991825amr168864865ad.24.1750563276639; 
 Sat, 21 Jun 2025 20:34:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8393541sm52376785ad.27.2025.06.21.20.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:34:36 -0700 (PDT)
Message-ID: <c40413cb-0697-4672-abcf-36a2b06f2058@linaro.org>
Date: Sat, 21 Jun 2025 20:34:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 40/42] accel/split: Call
 TCGCPUOps::rebuild_tb_hflags()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-41-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-41-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Call TCG rebuild_tb_hflags() when transitioning from
> hardware accelerator to TCG.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index 615faf1d96b..4b058034252 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -40,6 +40,8 @@ static void *split_cpu_thread_routine(void *arg)
>       assert(swc->allowed);
>       assert(hwc->allowed);
>   
> +    assert(swops->rebuild_tcg_tb_flags);
> +
>       rcu_register_thread();
>       sw_force_rcu = mttcg_vcpu_register(cpu);
>   
> @@ -69,6 +71,7 @@ static void *split_cpu_thread_routine(void *arg)
>                   r = hwops->exec_vcpu_thread(cpu);
>                   trace_accel_split_exec_vcpu_thread_hw(r);
>               } else {
> +                swops->rebuild_tcg_tb_flags(cpu);
>                   r = swops->exec_vcpu_thread(cpu)

You should not need to do this before every exec, only on transitions.


r~

