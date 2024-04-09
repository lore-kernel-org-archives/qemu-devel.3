Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA48AC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruDKK-0007Zr-W5; Tue, 09 Apr 2024 11:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruDKI-0007ZF-W9
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:23:59 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruDKG-0002Nx-Gf
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:23:57 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51381021af1so9304017e87.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 08:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712676234; x=1713281034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=akSPS8/YlbSYkjb2CsC0dc+xHGAwntHL6xTWsAJYL5g=;
 b=tGV/c80iFLwvZxjooKScR1lrJ3Aq9RNMNMNqaByhVmj7OwVB2MUlsH900iPQpX2k8k
 rk9yXdMVvOn1ufOYYrHJLzIWUIBAUUlDixWbEuZr7Dtwmq5C05z9P5oQGJwYmRdLxb2b
 fDZek+WjrRkbS+ONlx/Y9K/2NGGBKAj3M9ml1fpLOWEs0C2L6zt2ZMSTEZdrkUsG3pyR
 Zs0p8RhJrDJH/ZZv5o/UiLSioWUMsDDjNt+ozwcxk1kgXh1HfXSNjAb9Kdf1eK6bY4jF
 wPOjhvwtYd6CxdPsTRu32TVvbn9y5zOgU0OexRnAiGBlCOAffP5q6SXGzGQz3AEd2+21
 ZKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712676234; x=1713281034;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=akSPS8/YlbSYkjb2CsC0dc+xHGAwntHL6xTWsAJYL5g=;
 b=j/XpLfWQXjRDTJ8mtwvusoYYefdlJy0sWDncWsWNr8AS0NxGeOpyn8Kd3Up965COt4
 4QqjjLCbRDrxXjgQl8BSFaEtiXDK68SX9P2/6aD9ftCi7D/tDso/oVegAh1/dPZcT5qY
 HMqw88lcuE2imwhyWF84xTPxopUxJeA9EE7LuEQIJm6qDeowenTeG/43qoneDIUaTjcN
 WKiZ0K4oX1EGiIctQKFEJ8pK06jNbxIA1vCsn0bRXPJ9DJwPCkBoNpP5E1w7SQy4oxU1
 vWRo59yCAWDJHtM1EnhmfczSoOT0I62HM53aPfXQ3RMWmYCI13XXIug6zn2ZYNXJkkXJ
 R5uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmFASz7EJIHt6vvVtfxtidTa00BZ0Gjr1J508KuHNyM0DWeqCKvIn+qSx/ggFNdW+zQPoQtXcbzLuiKn2GsJliB0mNL/s=
X-Gm-Message-State: AOJu0YzbzHTNbmdkd5ofmB173yMCwfH/P3OoCQR8zoIfNXJReQHIJ6NY
 Na/AJSS5wyeBc6YdrycR4w1m6c4g8inmlmGO5l6VLzSsRFULc9Nf2fEJS09RG2s=
X-Google-Smtp-Source: AGHT+IG1cEryIykr9IaqCAOkKG6bRzknf3oKYuxCfbfHgi1O7XGAw/AA/3prwFs+dSZT4vI+HoCsaA==
X-Received: by 2002:a19:a416:0:b0:513:ca40:fafc with SMTP id
 q22-20020a19a416000000b00513ca40fafcmr10061867lfc.11.1712676234248; 
 Tue, 09 Apr 2024 08:23:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a17090618e900b00a4655513f0bsm5802694ejf.88.2024.04.09.08.23.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 08:23:43 -0700 (PDT)
Message-ID: <c1cc9fac-f227-434e-a0b5-d4826f26c9a5@linaro.org>
Date: Tue, 9 Apr 2024 17:23:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/i386: Preserve DisasContextBase.insn_start
 across rewind
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

On 7/4/24 00:32, Richard Henderson wrote:
> When aborting translation of the current insn, restore the
> previous value of insn_start.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/translate.c | 3 +++
>   1 file changed, 3 insertions(+)


> @@ -3123,6 +3124,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
>           /* END TODO */
>           s->base.num_insns--;
>           tcg_remove_ops_after(s->prev_insn_end);
> +        s->base.insn_start = s->prev_insn_start;
>           s->base.is_jmp = DISAS_TOO_MANY;
>           return false;
>       default:
> @@ -6995,6 +6997,7 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
>       DisasContext *dc = container_of(dcbase, DisasContext, base);
>       target_ulong pc_arg = dc->base.pc_next;
>   
> +    dc->prev_insn_start = dc->base.insn_start;
>       dc->prev_insn_end = tcg_last_op();
>       if (tb_cflags(dcbase->tb) & CF_PCREL) {
>           pc_arg &= ~TARGET_PAGE_MASK;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


