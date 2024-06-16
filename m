Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDA1C27C53
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 18:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIumu-0005fm-D5; Sun, 16 Jun 2024 14:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIumr-0005fI-Tq
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 14:39:34 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIumq-0004rE-EH
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 14:39:33 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2c2c6277ef3so3024697a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718563171; x=1719167971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y0whSaGs0Xb1H7zbB+JZu7tGyUaEXqwwgTP8pjulQKw=;
 b=lFaUcwoJ48Cww/eBg8ER27Rf3Pnmtq6qcalhc6IhJhD+TKAzji8T/QcRmIqYo21ISN
 jh/Wgk6c7x5OyEfBY2PvR7I0Vbb94eW0/3ej6jNI7LDfiyaKdXs+HM1bkKIhwUqbihzP
 gSCjL2o2vkyVvNcgfBBOlarHx3O1e7wSUZZpokPPgKITGpIsgt2qgVX0i+VjTqeDbFKa
 ZIaKgZPIKr+MkveNFMLkNUPREu1rbcgszsQxzmALNRwV09u1obP9dzjybhtNmBn+Lv/+
 cJpEqtAQz0/frgI85KK2xs6+zI7V6oQut0rS1MQ5v8MfvEXMv6vIBOLXPB7MM9e/8p8y
 2Bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718563171; x=1719167971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y0whSaGs0Xb1H7zbB+JZu7tGyUaEXqwwgTP8pjulQKw=;
 b=VRwrFomcxWo7Ig+PEpYY9egFQhv8foy4AL7fc88DLR5/FnptHDrDSzFpkcETfMZxjO
 jfnEFGgnr4pWwdwpTkdq6th0wA4rjkHvsldQKNAQqvN9+LumsJ6F7UplXE6ARHQ6pTLG
 lxrsLU2/t7nGvbaBcepWoZj+fjoGOR7sgnXiTGwL/tyM2HyDxd9aH1QJcnrZqsMpiPF6
 w8q1zXsMrhM3F7FDS02pDC2nahMfGOJAwB5JNlanI0JGisJP1b0BzP61Bd4EZ1JSmEDz
 KVKDxo/1zkjSzQo4ZGNZIrrPJAS1NjQzu+5FzIpG3CTHFnuO9iCMLvX5SB0DYR5dONX6
 oT1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9XH2VTAW12qo5gDGpPHdcWHxP+OL3CbMNuvfU4ehbHToFtgR8TYxw3Q88PQY4LBIE3zepG5TIoBEMNcswObT3XINfzGo=
X-Gm-Message-State: AOJu0YzAkvAZjVcwCjo8WMDekQ8I1JTkqDB7HmPsmjggIBK+uF5VtHC0
 wvy79pxs7Dw0ngJDB/4oAJJDEiWN9ZJbMjtBkvQ0DDqVV+ioSi45T3l+xCC+yQrp1+WCjWEYq4i
 E
X-Google-Smtp-Source: AGHT+IGMUYVlxdbvY4dLovpJ+J0juWkfQbKl7yjoe6lsw9bAXYd481rTHEJ3B13OakHanOuKlt/vHA==
X-Received: by 2002:a17:902:d482:b0:1f6:f336:899f with SMTP id
 d9443c01a7336-1f8628062bbmr81607015ad.54.1718563170792; 
 Sun, 16 Jun 2024 11:39:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e55f74sm66493675ad.62.2024.06.16.11.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jun 2024 11:39:30 -0700 (PDT)
Message-ID: <7f883f16-ed2b-47f7-b31f-a92f42fddfb8@linaro.org>
Date: Sun, 16 Jun 2024 11:39:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: use signed denominator in sdiv helper
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
References: <20240606144331.698361-1-chigot@adacore.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240606144331.698361-1-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/6/24 07:43, Clément Chigot wrote:
> The result has to be done with the signed denominator (b32) instead of
> the unsigned value passed in argument (b).
> 
> Fixes: 1326010322d6 ("target/sparc: Remove CC_OP_DIV")
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   target/sparc/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/sparc/helper.c b/target/sparc/helper.c
> index 2247e243b5..7846ddd6f6 100644
> --- a/target/sparc/helper.c
> +++ b/target/sparc/helper.c
> @@ -121,7 +121,7 @@ uint64_t helper_sdiv(CPUSPARCState *env, target_ulong a, target_ulong b)
>           return (uint32_t)(b32 < 0 ? INT32_MAX : INT32_MIN) | (-1ull << 32);
>       }
>   
> -    a64 /= b;
> +    a64 /= b32;
>       r = a64;
>       if (unlikely(r != a64)) {
>           return (uint32_t)(a64 < 0 ? INT32_MIN : INT32_MAX) | (-1ull << 32);

Queued, thanks.


r~

