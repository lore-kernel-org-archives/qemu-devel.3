Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADAAC2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcY5V-0006tL-KN; Sun, 04 Jan 2026 19:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcY5T-0006t2-N9
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:04:43 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcY5S-0005xB-3u
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:04:43 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7f0da2dfeaeso14488647b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767571480; x=1768176280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YVBTjyEoDmtgtbSaVoUjA4FiUIcizWmehVyiSHhJW64=;
 b=wuykB6LVCBDHEa7iCiyWInl38i5013SDUU4iPb8r/pco7bv0liZo8C9XU/fCuVwF/x
 87M6YtST7a70oak0Ob/YmmNqNM8oULKmLdzcrnjqEPcQzzNOcSOMi4OlD4czixC4S0y9
 OH2YvRSj/yt6ov4bQ46XY5O2P70C2xhT2uZ/IB2+j3rZKBGydxydh7j2HPEunEJU82YH
 DToEsOwp6aIHEdaya/NMqTkJGiX9HAkTH4yXBw4qdNZMlVbL6VdUnlyyXnnnnDhJAdJJ
 291S3RzmbufFbfMd9wCm4oJIuZKqOs5x8cb/P/L1rg6+41eGYBstd7mMwLS0lqYoKtIk
 GkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767571480; x=1768176280;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YVBTjyEoDmtgtbSaVoUjA4FiUIcizWmehVyiSHhJW64=;
 b=Jz1XUNyb2SzZ5DU1jX1/9Cwehp11912bmn6B6IR4GeCvD/qpSwALT2j//zClwSbikW
 G0OwTPTHy/Dvc4v2BUNtMSdmnSExSeMOOeIGREb/G1Ii2W4GlxIzVWiXW8E+NiP7qVxp
 ZM5BYUJcQDOIUa6WMUF1+AgFr1eCsTGfbbva9AhY/Xi0IDm3Xab8H3DfvAmNa3Ed1OfU
 qEHuLVPzsUl81mrkyO0y5kSnARTpT2AWHVKbwV7lK5KXPC0kLeGvmjx8lPOvBPhFajCu
 bQgGZLqy6CZv5pw4vNagjrRTnmz9fiA9SrU9sWklVnPUm/ZIjlV8IWOJkkImU+8ZZc/X
 Xg0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzow4IWlQA5Xa0BEkhy7cU1GZUa0nnJSwkVEwY9h9+azv+zmF5qG6KLKs5hJ/NbGxD3lnNVKLS1g1P@nongnu.org
X-Gm-Message-State: AOJu0Yxm9uXOmo5codDJE9hQ9zLJsicw5ZC/mEHT4lfTsTVMsWVRyepg
 obB58UQuCYROcSSAY+Ej3q4KvJYbiN/2WTAOtLgXatCTon5JzApj2VPWAnai/sQ7hrCbJ49D+q5
 /16Ca/Tg=
X-Gm-Gg: AY/fxX4CP/Nnhmwv5kTXn3wpxABRQ5eiJfGULN0Nh38CmfOMTdqqnmn/zhnymhJWHKg
 rO95ZhwEgXF3T+lGkE3as8zcBmfBCfSpUFaW5u4wN8I6qEcNSGn7f4IesMa5fcl3piVvqeg/BoL
 Ydp1KSFGofT5zeuosnKzvk+LNjUr7wLPPcpuFGpSTFMq2RcAt8ZFnD4WdxeegQNPrURYlo7VpgX
 kDS64LqFRbvOy3uT6T1IQuww1rSz6TRxLEB9ZXoodABBoLlAzYj3iWi1/clW0t+FanCZeSMEOqn
 bj5iaf7SfU3o0JXuoKUUH7J+qVt0N2GkqlcdlO+jogHaaWVBrsd291wYdRB2C49W5zEROvin4uE
 2413XVlpVKpF4gyQooAKyYHRHABKHi4lhdJImDlAYHr2uTwY39RyOZtnFsktB1zzxnFyQCvw8+6
 bNdxGiW85vVTRZCuzeXtzubWMeNWLLS6hAaYKaOXCO
X-Google-Smtp-Source: AGHT+IHrcwoCajRwN1y8gIy0Xojm6zANHGMJwVK4Y2S4+DKJcG7JNdTIl6ky8nh+nEC/inhTQ6ysQQ==
X-Received: by 2002:a05:6a00:348d:b0:7e8:43f5:bd0d with SMTP id
 d2e1a72fcca58-7ff66f590fdmr41890105b3a.34.1767571480456; 
 Sun, 04 Jan 2026 16:04:40 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e88cc1csm46103745b3a.65.2026.01.04.16.04.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:04:40 -0800 (PST)
Message-ID: <4821f5cb-1953-498e-b42c-547e64f13a2d@linaro.org>
Date: Mon, 5 Jan 2026 11:04:34 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/hppa: Use explicit big-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20251224160942.89386-1-philmd@linaro.org>
 <20251224160942.89386-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224160942.89386-3-philmd@linaro.org>
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

On 12/25/25 03:09, Philippe Mathieu-Daudé wrote:
> The HPPA architecture uses big endianness. Directly use
> the big-endian LD/ST API.
> 
> Mechanical change using:
> 
>    $ end=be; \
>      for acc in uw w l q tul; do \
>        sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
>               -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
>          $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/hppa/); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/hppa/gdbstub.c    | 2 +-
>   target/hppa/int_helper.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

