Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F6AC2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYQp-0004C7-No; Sun, 04 Jan 2026 19:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYQm-0004Bb-P5
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:26:44 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYQk-00006R-FY
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:26:44 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7ba55660769so10247778b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767572801; x=1768177601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aw+Id6V50lFZ9fv84slTDpy/nQMxE1WQ2x1zFB1IAJM=;
 b=PHbrh9kTqt+YcwPM4ox1hyDuSp6y4jDs6wYJkDjuxdMw4FAH5Ox6KGLizt91rCgfHN
 x24DIddlTYH25K+hK8EuBgegqrm02VEncto1EqIs9mb0Hw6MviP/WQrayPvLGbPjMJ/1
 EPHlPBsTMTt1tk7PBSHVSHNBqglZ4k4AYN4wcp7cVSbHeV0R2VgpkV/FFhVZjLxby71F
 7lStjDFG3B+sEq7VOFO8jHeOSx66bW3zvIBsZSCYwGpE2C5vCRXYnFTbtFZwb4vOawj0
 AAogLE1mwFvXCJrQXLlOrtdbcUo8JgZzQdkCQYHIGNYiRxjKDwiR45xHV0xtlykq84JC
 I7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767572801; x=1768177601;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aw+Id6V50lFZ9fv84slTDpy/nQMxE1WQ2x1zFB1IAJM=;
 b=oEhYSYfo07ccJVFT5KIzfa2821dzLAMq4ZxHo0loYwslEAKV9npxCxHCdn1+cWgcWy
 dF/FHc4nj+Gy+4gf85hQUd+Oi+K6cIAE8lyA01fFKJcyMAkdldpdOXD3sij7sM8EDZnD
 6/G8BuLm0SDBFyOfBE5jlYgLlelSQVAVixsy8I2EXoVonEWxIsg1FUefPKdSSA4Rl02R
 dyT8Vc8Obf5wUi7EZMEdP6hrPCIhnwTjOrqiEUQ+RjgrkN+D0Z1SE/3jzJj63ouOc0tQ
 WzSm7kyY3L37x+UV80HYidN4MZbxjpsadjUjVasAEDIGzOMpOdwWdgBSIBK7l05SXepg
 1MnQ==
X-Gm-Message-State: AOJu0YwAk9WRc30cngDEqh+9ornftKL6+OJjlcb/Uc90V92JOuyht+KV
 swSjCiEyqlj6bW5ME1nJUeRiie9p5RvgneOARO6MuJCObibX/9GnclhrQpVlTJYPpCXDx3YdB0L
 VWKbRnAk=
X-Gm-Gg: AY/fxX4SnLd4us5MOqyY/Dho5zqOAQuQKTgw5WQcYLpP7NzknChZps0P2IlKfsof3ql
 SDVibQMwyM0hTc+2x/4wXuqEwSoKryhDQ+UwIGVPC9ujAZeINfsS/DUkO0EZXG5VsEtaxXbQpZA
 DW5mhfbM6PDzF3KZZRW24UvF5OxLN8ecblX/eTpbpuTZmQAtaJ53fJSSy16HqUim/kekCHRJGLt
 ItNXX08JTnJsLiyddOdUPgS5j85JTzf3mrO6Ah2XgC+n8nEpG/s28DZSnGqoGvC5KAd9mPlWWb1
 w3Eu++AR20w14Gz6Fe2k9mvFlrlPPF6XoSF3VaIXgxV6yctL628R6J7ealVF8exjUTVscJKZF60
 vTDLx+lpw/fmnLMpohMs51aNakFkf1QhSXjYWldfzAOC/TEKEDlfsCJgWHSNLIe2f4YtuHYIz6G
 Xwo2UDCU9Xj9rHEFjIP6A7DzGfY5TPCw==
X-Google-Smtp-Source: AGHT+IHxHTUbuSeewI4c1INtVdo0csgdMVSOEBrjEHB5mgyBIgL3oAsL2DCFYAez3JexCcjLK9N3wg==
X-Received: by 2002:a05:6a21:328b:b0:371:83a0:5b5 with SMTP id
 adf61e73a8af0-376a77f10c7mr46310435637.12.1767572800779; 
 Sun, 04 Jan 2026 16:26:40 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7c5307c7sm40420407a12.28.2026.01.04.16.26.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:26:40 -0800 (PST)
Message-ID: <ef338a7f-b207-4577-bd24-857b8276b675@linaro.org>
Date: Mon, 5 Jan 2026 11:26:36 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] target/sparc: Replace MO_TE -> MO_BE
To: qemu-devel@nongnu.org
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224162642.90857-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 12/25/25 03:26, Philippe Mathieu-Daudé wrote:
> We only build the SPARC targets using big endianness order,
> therefore the MO_TE definitions expand to the big endian
> one. Use the latter which is more explicit.
> 
> Mechanical change running:
> 
>    $ sed -i -e s/MO_TE/MO_BE/ \
>          $(git grep -wl MO_TE target/sparc/)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/ldst_helper.c |  6 ++--
>   target/sparc/translate.c   | 58 +++++++++++++++++++-------------------
>   2 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index 2c63eb9e036..a87a0b3eee0 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -1169,7 +1169,7 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
>           break;
>       case MO_16:
>           ret = cpu_ldw_code_mmu(env, addr, oi, ra);
> -        if ((mop & MO_BSWAP) != MO_TE) {
> +        if ((mop & MO_BSWAP) != MO_BE) {
>               ret = bswap16(ret);
>           }

This appears to be a bug in one of the previous changes in this area.

Since the endianness is contained in oi, cpu_ld*_code_mmu has already honored it. 
Swapping again makes no sense.

Everything outside helper_ld_code looks fine.


r~

