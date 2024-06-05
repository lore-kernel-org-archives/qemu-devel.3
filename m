Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AD4C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 22:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEzHl-0001Os-2N; Wed, 05 Jun 2024 18:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEzHj-0001Og-Tx
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 18:39:11 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sEzHi-0003NE-Cu
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 18:39:11 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70255d5ddc7so270836b3a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717627149; x=1718231949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=21fz3KYil8KM6bGo6tkSuc5vCtRf2bbU6nXKd1rZSRo=;
 b=LzSrR4OW8d4dPW+zIX/kybuNVkIE0HOu76QQQ3K+SBNCu7+BvZ3ds+GvMZL5bZ8XnN
 iJPV56O6sQ5r9wel1vsigKSQZmpY+LSRAJ3dVUIs0LmDzkQ19gs2FPrSiz9h73d6QbDh
 /uAhTHJu4Wbt5R6HapvUNMOlChZgNFMq98O3w5a/re4EP6tY4BO6p+eDMTFpfDvX/rgb
 YFs/utVu7PF9cZwnjp2rOewZr6LLWmGZ1oC3VCHhKwz7sE1MpR7KHnVl9C0v5ulyvyeX
 ICuIs1Fwcs5aLeY87kh/OU7NB+sAxPS2boil3TPaXFojAC4zvc/+6V840wXVhYtze4ui
 8spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717627149; x=1718231949;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=21fz3KYil8KM6bGo6tkSuc5vCtRf2bbU6nXKd1rZSRo=;
 b=IuhwnxL6IErrds6hqjnp0BFS20gI9qUBcNCdVDlRWiu/hfcm3lnqY62Fb5AhotDCRE
 a/2rFIjsBiN978zWlpg1XKVAxt09EdVlceqtzE4VvIBSvZw8Wsak47ZzuAvkpXq40WXI
 OhoHHOIkGL4G7pX9rXgmTvlV9cE1kjxv3ALafVgFL42LT3gXNAhvTlRkcq1y0cD9+qBt
 ahdX6Lh4ymDrnD8fWNfUfNrq3fCRguwaNPZ49pGU7zRYu04itjHJ5lO74Z6ICAl9+ci8
 JEzY8pbhMkwXIyq/IdWXOaKmxD3Pg1Xai4v+tabBJ5Cq0a/hDlv8YglfcTnO7/ez+Qlk
 K0Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSDf9Qae/cEYyO6GmqYkPn16t+Q1hAXViZU2LxeOWxPjXqKpdP4BdMgfAkwtjT50AyI3RgytGPilGvh9osM38Ms63quRk=
X-Gm-Message-State: AOJu0YzpsmWtnJ26PcPrhylHKZn1jHZ8T3rpkae0usluxP9iqiIqUrEv
 +0larl/PO8tdG6HCMH9VlLlWOQApqzEFYkTk9whvV1nePSDR2qvmAoS44NQi3Ow=
X-Google-Smtp-Source: AGHT+IGIkLxgKkdELHQblXCrpQ4LTF6phT8U20E2FUIEhCuifFX7wMb7wtnwOboDOSHc6Tmy0vH1Zw==
X-Received: by 2002:a05:6a00:b4d:b0:6ee:1c9d:b471 with SMTP id
 d2e1a72fcca58-703e59e4616mr4186937b3a.25.1717627148599; 
 Wed, 05 Jun 2024 15:39:08 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd39b090sm16260b3a.75.2024.06.05.15.39.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 15:39:08 -0700 (PDT)
Message-ID: <b9826606-3952-417b-8a08-f1db31a2cf7b@linaro.org>
Date: Wed, 5 Jun 2024 15:39:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg/plugin: Fix inject_mem_cb rw masking
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240605222531.28399-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240605222531.28399-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Thanks for catching this Richard.

I did the same mistake in plugins/core.c as well, could you fix it as 
well as part of this patch?

For complement, rw are enums,
R is 0b01, W is 0b10, and RW is 0b11, thus it work as expected with &.

Thanks,
Pierrick

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

On 6/5/24 15:25, Richard Henderson wrote:
> These are not booleans, but masks.
> 
> Fixes: f86fd4d8721 ("plugins: distinct types for callbacks")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index cc1634e7a6..b6bae32b99 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -240,13 +240,13 @@ static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
>   {
>       switch (cb->type) {
>       case PLUGIN_CB_MEM_REGULAR:
> -        if (rw && cb->regular.rw) {
> +        if (rw & cb->regular.rw) {
>               gen_mem_cb(&cb->regular, meminfo, addr);
>           }
>           break;
>       case PLUGIN_CB_INLINE_ADD_U64:
>       case PLUGIN_CB_INLINE_STORE_U64:
> -        if (rw && cb->inline_insn.rw) {
> +        if (rw & cb->inline_insn.rw) {
>               inject_cb(cb);
>           }
>           break;

