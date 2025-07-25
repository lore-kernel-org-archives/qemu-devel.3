Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC51C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 23:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufRya-0002TK-4H; Fri, 25 Jul 2025 19:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufRyX-0002RL-U9
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 19:37:18 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufRyS-0006JX-MM
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 19:37:17 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3135f3511bcso2250656a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753486631; x=1754091431; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=39WnHk1Ef1m1rrroEu3T7Bp1/++nz2Cts187zD/UmVU=;
 b=zc5Suje9CeNuQElUqMkm8Z9+SaP3VIeKQTu5f/n+U+tzYeeaURpbynd4474tv8p7ep
 7gxyDNCjy+jCBalkkS8x84MkHluki1cWBD8b2LnRkPLLr3WEAxYCPqs1O0XSlJupLlDM
 CMPoIphwhMX6NAGWQupeEml4TdqNaeutLeYv4sVNYWf8PWrYAyimPrTaFJ7C7VJcDPsX
 R1vx6agVFgsrCdwDQN4ugI9N35XkkpdiOVzjuL5GkXyjf/a/K9CFTU/5+h6m03juqdNP
 WC3Z9o9bxwxTxbgKt3Jo5XJi5VMTcrkbLIzSzLZwfyyEvQ0VAldqf7yZtzdJKHlGvEkO
 IHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753486631; x=1754091431;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=39WnHk1Ef1m1rrroEu3T7Bp1/++nz2Cts187zD/UmVU=;
 b=bGQ08489Y6D/DSy03Y05LOhk+YJILnkCnIYYy3dIx9PXXCf6MSoJxx/DDTiR9NDBC5
 v8nEUe4a0QPi+kL5yLK7Q+tXEXcPOoQLe16Ywj7r/iLMeGiIb2mNOFMD/qsDdJgOxn8Q
 k0rhxzejsXOOS9PeaQWd57hP7cL9oYMWV7d8eJypLDOKRNIiTPTz5CeGXT31oSC2G7RL
 XeEiSSw6zdJorWxMtGTvmNhtB7F0e1W2C/M/3oQm+ct2N8U7+Ni22q+t/0a+zNt7ynsB
 fcUsSVxy4FNloseLPQBVHsQV/SDLPeW4D9DpEZ2SAW2Ilsf0Vydh3aBcX1GAeE5YwBhU
 PqTw==
X-Gm-Message-State: AOJu0YxlA3ET+ivjh/bP70ZVIJ1PmrpuBd6nHvkMOZK+wB3yLCioHvn6
 kquf2quxUEVRms2BeJT7e/WFGpPgxZMsE95/Qcp5OVgGYF0wO+ga0M8h8HYtLXdKDogiIHpnMrN
 t0bji
X-Gm-Gg: ASbGncspvvMyiUMIFW/JztbBDMNEX0rp+4F2tFQYzZTqY8fVb475cjdb0qZG5YNIAjA
 VlGlDAEHREH2MM8euoG2fxuGhXEDr/8jiYKpd1+WXwLSB90iPJlRTkaDdHdBd0iWKLmcwIO9utc
 MOi4U0bbaLotV0Lmq0UswoviVMArr/ERl0kqGH1M69e5IS4vFO8rtMBR7dRcI0+Z9NNHWWwwuzK
 8ylrfoGy07mas4xV/yzAllS7xpR1TJyTQnwvvF76nmEJS7lOzErhe6h+CB0FfBRRFVu8CnbpELo
 AahNg0uKvd7rbzw7uT2YDm38bvSQcryYkvgRQjG+uUlzvaa7OsLWhAQizf3nLu0h5ccL48L+1ut
 XHQ69pSGy5qO+mnDlDW6FnSV9njMxPj4iLxMwzSdKMd3fw22GucyWWCkwWdgG3iPHQnbfyBnGZR
 BOqFwMXO7XXTg4
X-Google-Smtp-Source: AGHT+IEiFfLTFlMowac3W/nglsYCJb8hML4lfcoqmNcyUGpbYwfAFnj9/dGy0kijPxHgJu8I2QKXtg==
X-Received: by 2002:a17:90b:584b:b0:312:1508:fb4e with SMTP id
 98e67ed59e1d1-31e77a00822mr6134297a91.17.1753486630816; 
 Fri, 25 Jul 2025 16:37:10 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f568a3asm621205a12.6.2025.07.25.16.37.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 16:37:10 -0700 (PDT)
Message-ID: <8a2db402-7193-4d73-ac0e-09390c2525c4@linaro.org>
Date: Fri, 25 Jul 2025 13:37:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/17] target/loongarch: Move some function definition
 to kvm directory
To: qemu-devel@nongnu.org
References: <20250725013739.994437-1-maobibo@loongson.cn>
 <20250725013739.994437-2-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725013739.994437-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 7/24/25 15:37, Bibo Mao wrote:
> Move function definition specified with kvm to the corresponding
> directory. Also remove header file "cpu.h" including outside of
> macro QEMU_KVM_LOONGARCH_H.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/virt.c                  | 1 +
>   target/loongarch/cpu.h               | 9 ---------
>   target/loongarch/kvm/kvm_loongarch.h | 4 ++--
>   3 files changed, 3 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

