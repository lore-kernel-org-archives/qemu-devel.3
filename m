Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1F9C54E5D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 01:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkDQz-00051U-Qo; Tue, 12 Mar 2024 21:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkDQx-00051L-P7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 21:29:31 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkDQv-0000wB-BQ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 21:29:30 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2218da9620cso3509405fac.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 18:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710293367; x=1710898167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0nCvQJnGgqZ8j6TUlu4MQnsXDICVgh6A8WsY5qyoAT0=;
 b=sPNiTVpBaFyjRvmxpgphkrUSzvKiEUE5TUcSjYEH/CAxWi3a410Kd0HFpWCN3b09zr
 QUafRZtGtvKr23FFLlcLT5jkVOhGDbAreddpYD0DxaPH5+I2fN1AQbSB4vMLMamBKQts
 /VrfjTeGk+EpFiLC8jYiA0sf2uBVk95Wt1FB6j39FXru49Cx78hFrWsd+GEsCXXVkCrw
 +ca1TWMzqveYL+HEtJ3dfkoC9HLHQWtXZFf/rCCWE1oYA2WNwMWpirv20D0iZ90IpVWh
 pUr9+MH1zhwjc2jm9HfNLUfrS6GE3xJUiQ80gtfCCSNjxndvQ8BjVu5XKo/+feRg1HRO
 e2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710293367; x=1710898167;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0nCvQJnGgqZ8j6TUlu4MQnsXDICVgh6A8WsY5qyoAT0=;
 b=aEubSdgkgPSAQ9fJ3nCm4TeU8DzSomt296r4m/xvtImGQfStZd0mGrNMeON6ujOSEH
 JY8/7M5QXOy17vCzcrTz+ZZmrCEUeFDn3kL0hAz6TC2doHoTTHt4xWqMKArTlqdvV3py
 zI6nY50ecsAjjCPsASlOPJhwDjaoaXYN6TO09IJYZp5PUl2bcc0n7axw2LNJRJJ7uREs
 TxVIdU3J+75I7fyA6j/GqttnBHUdJ2tcWEOfGI2t0RZx+YAaJbVd8l7JT2YZ8qOMosxE
 yG770lPle8ZMVkTjGbKeoUkZaS8kEtjXVl9+F949qyZwvYeqG6b6a4IaGGTNRZ98pRl0
 ocZg==
X-Gm-Message-State: AOJu0Yx3s41QG5SEUaSJjf5nB3eLQq/NBIIqtpy/1gMUtVo5bs1mnOYb
 2QPQtlCYjU6pY9pDgEJJIQ2nPyYSgI+Np9N+aEq4AE5u4Npnv3a4QHa1SDxj355tHnUzYkrjakW
 J
X-Google-Smtp-Source: AGHT+IFmXhPQhvohduBywnxw16L3wAE/pFoEY3njwJFr9ILKPCAg8ukz11ICmyEHWipqW3Hwb89Kwg==
X-Received: by 2002:a05:6871:590:b0:21e:5f83:e698 with SMTP id
 u16-20020a056871059000b0021e5f83e698mr12716920oan.52.1710293367357; 
 Tue, 12 Mar 2024 18:29:27 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 g5-20020aa79f05000000b006e6a52307dcsm1806619pfr.122.2024.03.12.18.29.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 18:29:26 -0700 (PDT)
Message-ID: <f25c6f13-d535-4e58-92ff-f2b22e80720e@linaro.org>
Date: Tue, 12 Mar 2024 15:29:23 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] tcg/optimize: Fold andc with immediate to and
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240312143839.136408-1-richard.henderson@linaro.org>
 <20240312143839.136408-2-richard.henderson@linaro.org>
In-Reply-To: <20240312143839.136408-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 3/12/24 04:38, Richard Henderson wrote:
> +        /* Fold andc r,x,i to and r,x,~i. */
> +        op->opc = (ctx->type == TCG_TYPE_I32
> +                   ? INDEX_op_and_i32 : INDEX_op_and_i64);

This and the next two patches also need to handle vector types.


r~

