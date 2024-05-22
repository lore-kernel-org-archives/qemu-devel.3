Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A73AC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 17:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9pUk-0008MA-AG; Wed, 22 May 2024 13:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s9pUg-0008Kb-Nb
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:11:16 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s9pUd-0007ll-IT
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:11:13 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5c229dabbb6so1287022a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716397868; x=1717002668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AcVKnwBzn+ufikjvreuvHHDbnlRfsupYxPjb4m/40tQ=;
 b=nZP+CoXMemjz3VJxaj8/5Yl3C2PuxJv3vGYipIoRJgWGs0PvSc6uKQ+O3WES3KAZHI
 Cpu+1j5FPMR/8lo/T6jBnR7NxnKmg1vRm/oS7SaGjza2575ov25DIpOVPuYObfey9Jei
 EUPsDzAruUGTGFM2jj42cWvhjKMX3l5ymjB3kQRGMbP0sL+sQaeK8aaB62ftq7/ZROWk
 6aAjDp6FtrlNpDeLxbD6uZwQWZ1EEceAiqtW7CFxt2jwZJB/VuAybvDz7pYFXlm9v/Ey
 rrFl6TTRLKPJBHE/x3/1Jpq33p42QU6igAyydqsw6y0N7RM9rX2UNw4CnFtfi7C65SxA
 E8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716397868; x=1717002668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AcVKnwBzn+ufikjvreuvHHDbnlRfsupYxPjb4m/40tQ=;
 b=V9BqRALEUrI1vkpAjv/Z2kdQr4umq526Ep+SKX5j42UgkKUu3t8d1wOfx/9BcUuHsZ
 nY07rE5PijjPJVhFAp90LGKdZFqx8m0YmAoYTpkJZuFddzk/Mo4e3ZeEAusoWHIKKneA
 l4XDNnij0+i6EA+pfemb40uBKOzENpIUM6Kjd59lk3MpNfR2IAMcaMW8c0lJTVVT2voA
 PwwCj4DYLDzdlFkbqSpFNLUiE+me/E8RinnCZ3XMDrieOp58DoXCMQwH3OItRk8E3h7y
 HepjKwwBM42GKNKgVdbl/kbhV+eGbNputy5CoudsNQZc5wbnBFcAv7nAvwJfgYGP96jO
 /I/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxDkp1kqpgfZZELzeHL70r5nBYITpUhnI/AZaj5eswyp0r7AgJkbVklvxV3+1/fOf/+IsgcnU5YNYXAJvxvOWPSTS1kX8=
X-Gm-Message-State: AOJu0YzF86VBj6RLBbp4si4vjs+Cg/If7HLqFXbVerQ25yV3HFfIcoT1
 QTL1Qa71UOG2Qd5rkhtmaQ8wfpBMkfV5NGvg3NX7WqgbIEbZchwcthUvZ1Ja1kk=
X-Google-Smtp-Source: AGHT+IGzwsYGBTUZOPz/PHt/MlJ8Vxp11EtUAlAfVm5jHQEhk/5e1o2blLdt8XNI/Smw4A7/I2fdvA==
X-Received: by 2002:a17:90a:e549:b0:29d:dd93:5865 with SMTP id
 98e67ed59e1d1-2bd9f5e49d6mr2493253a91.46.1716397868294; 
 Wed, 22 May 2024 10:11:08 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bdd9ef08b5sm12126a91.14.2024.05.22.10.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 10:11:07 -0700 (PDT)
Message-ID: <48bd7bb4-aeca-4117-88f2-1eb320aa1e36@linaro.org>
Date: Wed, 22 May 2024 10:11:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Init tb size and icount before
 plugin_gen_tb_end
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
References: <20240521210604.130837-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240521210604.130837-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

On 5/21/24 14:06, Richard Henderson wrote:
> When passing disassembly data to plugin callbacks,
> translator_st_len relies on db->tb->size having been set.
> 
> Fixes: 4c833c60e047 ("disas: Use translator_st to get disassembly data")
> Reported-by: Bernhard Beschow <shentey@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index c56967eecd..113edcffe3 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -214,14 +214,14 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>       set_can_do_io(db, true);
>       tcg_ctx->emit_before_op = NULL;
>   
> +    /* May be used by disas_log or plugin callbacks. */
> +    tb->size = db->pc_next - db->pc_first;
> +    tb->icount = db->num_insns;
> +
>       if (plugin_enabled) {
>           plugin_gen_tb_end(cpu, db->num_insns);
>       }
>   
> -    /* The disas_log hook may use these values rather than recompute.  */
> -    tb->size = db->pc_next - db->pc_first;
> -    tb->icount = db->num_insns;
> -
>       if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
>           && qemu_log_in_addr_range(db->pc_first)) {
>           FILE *logfile = qemu_log_trylock();

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

