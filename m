Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D922CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 16:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuD4P-0006bJ-1F; Thu, 04 Sep 2025 12:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuD4M-0006ab-7D
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 12:44:18 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuD4G-0000tf-Sl
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 12:44:17 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3df2f4aedc7so767767f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757004249; x=1757609049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WOnq3LCrEezycwHF3OwLwEhdgJXDrimxklj4eNyqm8A=;
 b=CUbli+KDREYEMVx2JIQKdMKbcobGpNAH8Q0/+l05/D0Nhxq1c1Z1iZDGLbWHBA/8+c
 Qus2/+s/jff5scyO1cFoXiyWJTs2qMTLD8+XW5uqbLLPuffwQiBYRVpotjt0eySTidYD
 +Q5BoxD6QaDgzn4j9hyavT9Sig01vrYuzORrV6nJXKmYvLJJZposGvzhYZbcw7EQyX3y
 PImK/ASVm0ZdwnfkNdURwQ8BFnbQA2O+xn+LiRHxeT9opYlhjjZyZ8uwzhxOBIlE1aqn
 sO9je7l1ekAY0SySiGQpw8DjoJmRa3T+RNKKsqFRzgI2Ezk8bzeff9J9SODsMCNDwwFU
 O9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757004249; x=1757609049;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WOnq3LCrEezycwHF3OwLwEhdgJXDrimxklj4eNyqm8A=;
 b=Mf9dtknwfQ/ZZlWzOC7S5YuyIE+vvWjO9DkBvPrklj9LXDMNKzkFsTTvvMRZyftzZ1
 lLD00MDqnRfAmwCA257FDomagMvUYwACAipt/C+FrPZRh8D3ftW7cxjsuQBWDDVhAtB7
 ociw3AS9qk9gahsJLlFTiZmSWmfdJOPldF8/GovLvG/rEUVHSjGspuAtWAFyemO41YZI
 hGjVcRxVTAkHTXFI0ulSPnDkqXm1AQZKttvLwsArLQckvRtaCsQtZDKII1T2lAMnVmJt
 EBdFNm3Vs2znhVGgHVfPaNrOR7AzgRIrB211PDVwTsqDoqWv/9IRZqTMZuxnL3vmWv5s
 f3ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnKpbzOTyNBZ//aFime2cmDLh1xdm2YDExcNmgs9SHbz2fugk2pXVEzI9G8ClWmQBA/LnUrrdIq3vd@nongnu.org
X-Gm-Message-State: AOJu0Yw4PLV9/x4AR3BePVjSS2Q8SgD4YwSNVZAqMKn3bzc0igZpfkd6
 pJsS9UIKImozWgeh5ifCLpRgj+Lf8cRad+Sf0G96vQaP64OgUMN6wGCWywFvcE5HPRw=
X-Gm-Gg: ASbGncsdUWXg0G72ySa4pTpITkftion6MQyoADF4lVm1ZOrBRehrwZcAlQzUCS2oXua
 CN+oOcHLUyB3g68wHMdR/DGUGQ5ARYSpd03DNXV4cZE2ZzI/KgSfXyCV3yd+Ktlbmp3mwbgxpaZ
 qkxLW1cSw3G1M4ajQEASYYdJjc03J8EEgJ+EUxucFpspNsXRZJrj9y7Sv+DbFzQIQiZV/wHa7iw
 59gnaVHJvNfbdmwBZCvRj8wzUXmRakQf/V9nGaFdVH7l+FQEcN8lvs0FQOTYeuusoPhfoIUBujQ
 BAacDsy4Nt8rI8GFxclXcKfTNGm0NQNoid4YcMzLSs25/mZR5gu/ZT1zoKR2NKGJQGWMV1Lw7Qf
 NvaBBnRwnnmoB/Wov2n68HPmUMEbLjvbHHF4/vdFSBVnRK0dRHItHfz/TWubfSRhH384+CEx83M
 xTcGdDRQ==
X-Google-Smtp-Source: AGHT+IHxjQ5+a4YzLzDnVdOHgY8Xjt47xIeZJgc3RnhGOJblnyyvj74JjU0mWG44JoDP/qMlx/Up/A==
X-Received: by 2002:a05:6000:2011:b0:3cd:edee:c7f1 with SMTP id
 ffacd0b85a97d-3d1e07a4d63mr14279747f8f.56.1757004248988; 
 Thu, 04 Sep 2025 09:44:08 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f30fe02sm365769355e9.18.2025.09.04.09.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 09:44:08 -0700 (PDT)
Message-ID: <611cba04-c567-439e-8f52-4d5f74828083@linaro.org>
Date: Thu, 4 Sep 2025 18:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: allow partial decode of v8 STBAR
 instructions
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20250904161026.804239-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250904161026.804239-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

On 9/4/25 18:10, Mark Cave-Ayland wrote:
> Solaris 8 appears to have a bug whereby it executes v9 MEMBAR instructions
> when booting a freshly installed image. According to the SPARC v8
> architecture manual, whilst bits 14 and bits 13-0 of the "Read State Register
> Instructions" are notionally zero, they are marked as unused (i.e. ignored).
> In effect the v9 MEMBAR instruction becomes a v8 STBAR instruction on a 32-bit
> SPARC CPU.
> 
> Adjust the avail_32() logic in trans_MEMBAR() so that if a v9 MEMBAR
> instruction is executed on 32-bit SPARC, the equivalent of a v8 STBAR
> instruction is executed instead.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Fixes: af25071c1d ("target/sparc: Move RDASR, STBAR, MEMBAR to decodetree")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3097
> ---
>   target/sparc/translate.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index b922e53bf1..9efefe41c6 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -2832,7 +2832,15 @@ static bool trans_STBAR(DisasContext *dc, arg_STBAR *a)
>   static bool trans_MEMBAR(DisasContext *dc, arg_MEMBAR *a)
>   {
>       if (avail_32(dc)) {
> -        return false;
> +        /*
> +         * At least Solaris 8 executes v9 MEMBAR instructions such as
> +         * 0x8143e008 during boot. According to the SPARC v8 architecture
> +         * manual, bits 13 and 12-0 are unused (notionally zero) so in
> +         * this case if we assume the unused bits are not decoded then
> +         * the instruction becomes 0x8143c000, or the equivalent of STBAR.
> +         */
> +        tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
> +        return advance_pc(dc);
>       }

You could avoid replicating this and do

     return trans_STBAR(dc, NULL);

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

