Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185BFC6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 20:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnOe9-0007Ed-1t; Thu, 21 Mar 2024 16:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnOe5-0007EH-0w
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:04:13 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnOe3-0004fW-JB
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:04:12 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6b3dc3564so1025004b3a.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 13:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711051450; x=1711656250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pE1e2gFVa8yuwM59cmW1xmZplZTPgIGtsa2xyLvXNIk=;
 b=ou2wQ+VCmg4KtAUxPJcXMIOaNceBKuMhexSZwzgImp3KrPWnpJjYTQ3VBU8oxmWTmT
 qyF2NJsjm5ZCT9f9fBPfAHwscMTP39MWHkD00QRdJgRlAx5TiRaXgjWg/Qym4dJgPqAC
 kcVnI3cGgg/GiVZheaB28AQyH/8Ps7uBhXAe7HMAQrL+A55krdpp1Kc1loXY6+tkLVOZ
 b2BYBRppZjtgHMrR9ro+AxtEgA4POUUoSG7FW8mcTB/YdwqnP0aZdc8ZAvUiKkqO+UKX
 GSKoGG9GW+PaJ9rXi8VN2pCeOFEPo+AiU3lidkpDX7rEpv7zqovkiv7Grzaj2FpFWahF
 vGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711051450; x=1711656250;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pE1e2gFVa8yuwM59cmW1xmZplZTPgIGtsa2xyLvXNIk=;
 b=t9HkT80bx74QN6YOA/wlIdpjNLKIcW3K+FTp4LOCCg96XnUU9Q4eVhhlV4VdnKHaeI
 nXWYpX2sl1D4bf8tEyRAJhMg45NRiUdidM10EEIuTxOZN8CThyXnU2m3neYUcCo9prml
 lkKiHjd8U92b3ZOWfPCE4UfFseZIGaLlAqEW1Z8pFrbLhlc62jPm/BscKFF0B5aQk+7+
 Wg102JfZ3u5HIzKpnDk/jJOcHLcWijuijL8YrqgzRexos7i/42MyvJfCTpdD6HzfuLi/
 B3ux+IEOWXISAi/yr5qFB+qMqXNLSVztGJd/lARgjbcZOeU7bO3RU3zuvha4yUhIrvcT
 qk3w==
X-Gm-Message-State: AOJu0YzKShONmfsF/PXaM5Yjkckm6q7ulkcCsmVxLTpcrVs3+tIgvJyd
 j5zhyLxOR0Bds/9yRz2N7UlzMObPU8T0oT2cGbWAzYOH5GBnxTiRezcjUj511v+QaahGoqS8Owa
 l
X-Google-Smtp-Source: AGHT+IGHWxxUTYp0sT17vi7BlR3u+SZUVKlFfVK3Qznd7tiAjeQ7lFgqoRjx6fWrRJ9TpSOrWugQhA==
X-Received: by 2002:a17:902:f708:b0:1e0:78f3:fa1 with SMTP id
 h8-20020a170902f70800b001e078f30fa1mr557589plo.38.1711051450256; 
 Thu, 21 Mar 2024 13:04:10 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 a11-20020a170902eccb00b001dee1e0beddsm232159plh.246.2024.03.21.13.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 13:04:09 -0700 (PDT)
Message-ID: <4baef8de-ecf3-4285-8848-61248cb4670d@linaro.org>
Date: Thu, 21 Mar 2024 10:04:08 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/hppa: add: fix trap on overflow for narrow mode
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240321184228.611897-1-svens@stackframe.org>
 <20240321184228.611897-3-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240321184228.611897-3-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 3/21/24 08:42, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/translate.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 4d2b96f876..74a9ea0cd8 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1122,6 +1122,9 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
>       if (is_tsv || cond_need_sv(c)) {
>           sv = do_add_sv(ctx, dest, in1, in2);
>           if (is_tsv) {
> +            if (!d) {
> +                tcg_gen_ext32s_i64(sv, sv);
> +            }
>               /* ??? Need to include overflow from shift.  */
>               gen_helper_tsv(tcg_env, sv);
>           }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

