Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB510C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHZk-0007px-BU; Tue, 23 Jul 2024 11:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWHZi-0007nc-OS
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:37:14 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWHZg-0006iv-Jj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:37:14 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52efaae7edfso2923327e87.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721749029; x=1722353829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n91GRGqIm3DCerbqoVmbxxcgccj2pxp6vBJiaLeyOJI=;
 b=ZZER7p/GSxjFPNVLE5R+hKrPjcYA5csmjG0L+btDt/3NPSdzeQ1/dl3cqkkQS/NWdG
 pwCDMlNUwMAM/Fne5+PguWc9YYKGbYkV0J31vvGbBf84sOnYoKP/U2R9WCs5Fzdy3mq4
 BK0aAYnfLWk+BtZWRniluYgOJ3JXPQwUfhp2De8gpIEHAkOy6RJ28Qxw04zSUyqaZ13x
 d8JOXsaHd4WU03kZdfx9HrAiOz5wMUkT0hCQ1/Q5mNQ6usPnLWRAxbaGn8BK7MP3A6Ge
 ez++pbaYA51JlkwtARGIhDxFjsKrAFA9SUEVYOeTR/N5ScDQpn+0e25FqIUauJ34iC6W
 6Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721749029; x=1722353829;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n91GRGqIm3DCerbqoVmbxxcgccj2pxp6vBJiaLeyOJI=;
 b=sxRt0Qts3DSifjLscklH0tpdcUzUd2XjAA0uwBcTwNMweq9dlVcXg5b0VQAeGO68AU
 kh+MRqaQrwAp1yqS5uiddn79KUNYSRaA3+LwktLQTehDVz49iG7vkuBKzO3eL/UzxFwt
 uLMIMJlQhhyt2OH6C8JAAaE0PjkTYDB/H/hBaJ3pZeuPzoANUZqXX/rdWGUYF+hs4UDI
 0z4fYWv/Zk2/tJ6eheDHL2buIAGTarzSRR5AsvIsrRbq+U75HDR8tw1g2Prf+z4H1mUY
 7iXOn4EpFf5x/ysRqFEA7JdQDVw0AkQrhz2TOldhtpXLy/+9dwabRq52PJWBnSHCzxu1
 Pdlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9HQ4EjdsqISNAo64ybtJZjdY4opSurqfb0T/Cv/Wt0k5/P4m+3V8QaW8gXTzPv+OsIlvh16HFXd2dGYhx6PTZQu5Zdsg=
X-Gm-Message-State: AOJu0Yz3oFbu0+sOSuqYS2vej84iuA6wSo7wDmmcSvoJ46kA66LfQToj
 aldneFlUAC6+W2F+l7Bho6vC+7kgB+zvkZ4FXoYNfrx/yFNMps3wfVck1h5KiXc=
X-Google-Smtp-Source: AGHT+IFOjqrVn+hBe54kUtayeME9x9gskul2HfudPBGCQHh+j1H80w6TTD68saRfBVcKeZxlNQC7Og==
X-Received: by 2002:a05:6512:1250:b0:52e:e3c3:6476 with SMTP id
 2adb3069b0e04-52efb895e52mr5890951e87.42.1721749028640; 
 Tue, 23 Jul 2024 08:37:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6929827sm178049935e9.34.2024.07.23.08.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 08:37:08 -0700 (PDT)
Message-ID: <f3558004-946e-4620-924d-5e6e2402a259@linaro.org>
Date: Tue, 23 Jul 2024 17:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/tricore: Use unsigned types for bitops in
 helper_eq_b()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20240723151042.1396610-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240723151042.1396610-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 23/7/24 17:10, Peter Maydell wrote:
> Coverity points out that in helper_eq_b() we have an int32_t 'msk'
> and we end up shifting into its sign bit. This is OK for QEMU because
> we use -fwrapv to give this well defined semantics, but when you look
> at what this function is doing it's doing bit operations, so we
> should be using an unsigned variable anyway. This also matches the
> return type of the function.
> 
> Make 'ret' and 'msk' uint32_t.
> 
> Resolves: Coverity CID 1547758
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/tricore/op_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
> index ba9c4444b39..a0d5a0da1df 100644
> --- a/target/tricore/op_helper.c
> +++ b/target/tricore/op_helper.c
> @@ -1505,8 +1505,8 @@ uint32_t helper_sub_h(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
>   
>   uint32_t helper_eq_b(target_ulong r1, target_ulong r2)
>   {
> -    int32_t ret;
> -    int32_t i, msk;
> +    uint32_t ret, msk;
> +    int32_t i;

We could even reduce 'i' scope to the for().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


