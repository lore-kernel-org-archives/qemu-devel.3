Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C40C47BE1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 00:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdH3W-0007MI-J6; Tue, 06 Jan 2026 19:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdH39-0007Hr-7I
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 19:05:19 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdH37-0006r2-B9
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 19:05:18 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so12051305e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 16:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767744315; x=1768349115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O0XTDCUYQOdJCn3SkzFUg2nTqvISV8zcdWZvnxPwgEM=;
 b=NO0zP7h5SRYtAMoSY99yQyB29XrQi5bD3G/N0uAhG/x2KdHsL4yfwZ0WsXQpDLlalq
 eVRacz8K4IPgr3rYq5k5ZS1ljsBtnLjoO+DCfDh7ChznNzjsZIMSFyOhzhusm+rguzQr
 ioLM9Zza6qz3HtW64/iUKfXVnzIAtWDMW8LKBwUM/gyX2ZIfCvm9H6z/b447SpWXzFMl
 pUiRj+hZwGuDS2MhWN6wwOnrLh7ZbV/ZHPrjQw/K3vEOKQP8r9evJ0TKb8rc7O5doaRu
 xyPuI8pilGHkgNZb9BPaTjsBNgPJOJYocSefjamuSdLaelhOTfU/rJUsb6LItoC5Js7J
 uFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767744315; x=1768349115;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O0XTDCUYQOdJCn3SkzFUg2nTqvISV8zcdWZvnxPwgEM=;
 b=c/KED7rcBqbne/p9eswB517HhoVY3USgBSCdzgR7q0ZpzbVOkfgC1WwoIGKLF/K0w/
 /R9w+f2zc7i/5jwR/sAHv8gBz5zRkJ2fP/iPNB2cGlVlGBc9zN3bZsVdRWE+XCBfMDBt
 rP8ADSYK9cFuZ/eqipStPrsQNtTSNc8m5Iuec/tNXBYe23QBggbawoChubcaVDu54PB/
 kDK+FQXVWlUl3Aajrinwpor8NNUZofabAH4Wkh0I2+eT6daciAnf2uR3Mai0VpMj8Zjf
 UvGiQacgnEN2MtVFyEsYILRXjZCQZ0NM2oJRsJhtFfg4dBvUHSYYyAN7A7ct5ACQpTcR
 Imsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFkssYEdIXeeOFf5Ywv3Ac5IP6ZxAj5feq3oU2QnuGMAMU4jzczjjzOKipLXVfbCcvoA1SG9A55uKo@nongnu.org
X-Gm-Message-State: AOJu0YxGQ8VtEaZU5jR95W/s8/Qpw5aIbbJCfu52F/q2YG+fggqUlOn9
 k/kYxIhQRDIAl/2JpimZ9FpnjVWyyqtlN+oLjmus3qFQCwEiVVFvL2e7igzVyzMfzvJSiqz0USP
 xZhRhkWw=
X-Gm-Gg: AY/fxX59k6pqiB3y6Ew4IYv244nhG6ekPL+pDezfHwEngdiVyBpFBjMu6Kb5d6lhWxo
 +7g81jozEATNMrpz0+WPl8E7gZbQ/NZZx/PPlS5xxqEoXLkXNVXUUFkAQrjEDNRTChkP04kvLpO
 R+sy3Fvk+73VZfkZhpCJVrTZd0ntFUKdsMZdhetWRiVM9HTPZK9IVebYBsfWfU02GKD+PWOfwwy
 Edk/O+OvG4cAYdwUmHDFrt89tSBRgqhlm3zidB12iLx3jmW9GTLQkxdf07VRICRyv52eMPYYVIo
 N55rZGd5b4v9S2cEE9ZKIWWY/v+kPRWAaHO5etUwV5PN7rZJisH4C0vY8hDRyzAkGyqsbc59+3D
 hSLt5fspMgXsZ1r5yt/7DIpqfmESs/vUi5bhjgSa6sUwWuMihWqkzPGjRFpf/3BOVlDL2XkxHtx
 N6t3JggxWjYr087f5FuORvd9LtTM8y6jezynmSkrggUNAFs+/inDnI5g==
X-Google-Smtp-Source: AGHT+IGze7DIPrR+YYsFsGX5hDWaDrjTPgAf7oMxSDlVnTi0BZqtqnaYR9Vn08+CtUZQ4l4Ng47cIg==
X-Received: by 2002:a05:600c:a08:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-47d84b2cf97mr4859765e9.14.1767744315521; 
 Tue, 06 Jan 2026 16:05:15 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e1adbsm7300181f8f.17.2026.01.06.16.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 16:05:14 -0800 (PST)
Message-ID: <e8dcafe4-32e8-45cb-9cd2-d18f2725d6c0@linaro.org>
Date: Wed, 7 Jan 2026 01:05:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: Save o_mask in fold_masks_zosa_int
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260106225204.5859-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260106225204.5859-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 6/1/26 23:52, Richard Henderson wrote:
> When adding o_mask to this function, we used it in a
> couple of places but failed to save it for future use.
> Also, update a related comment.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 9e397cc0df9 ("tcg/optimize: Introduce fold_masks_zosa")

I think this is:
Fixes: 56f15f67ea1 ("tcg/optimize: Add one's mask to TempOptInfo")

> Reported-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index c546e8910b..23278799af 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1088,8 +1088,9 @@ static bool fold_masks_zosa_int(OptContext *ctx, TCGOp *op,
>   
>       ti = ts_info(ts);
>       ti->z_mask = z_mask;
> +    ti->o_mask = o_mask;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


