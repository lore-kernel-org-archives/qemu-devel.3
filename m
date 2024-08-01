Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA9DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 11:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZUMj-0006Yn-4Q; Thu, 01 Aug 2024 07:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZUMh-0006Wc-AN
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:53:03 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZUMf-00036d-Mb
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:53:02 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2eeb1ba040aso111140611fa.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722513179; x=1723117979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hlRV1J11nRpbipjxFE5QaEkaBKh5+SDcSE8U3WlJp0s=;
 b=TbhiDjYv0xkfCbMJOcXHK2CDoa+muKEsBpQBjaJuK1tvPi16m82Lp4RhYpY4wXeJ/K
 echa78E2xUV8tL5vtzrtB67HpInd5ud8VFF3jnAPGmV3Z39EkIPb1nQQ97+dFsnSqox2
 AWe9+6FgQ5oC1f4cngcydZcg4Nr186R3/wWm2gFW9Ao0u+wpnNAfx+lz8BG2jMHTghkf
 EJ5V1yWkXpBCBlVwBF/hmZU4P+dKzKZdnPw00Kl6uUv0AM/SUeUckKqijPgrtxbr0Y0y
 5aYWsmSBD/Sgk8QyekOMIlhz96jWe6E8ro6Ew2HsdxGZ43yEMiJQpvYkQGXfzbghVQMt
 gdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722513179; x=1723117979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hlRV1J11nRpbipjxFE5QaEkaBKh5+SDcSE8U3WlJp0s=;
 b=kJ9dNUzCFyoCCskOOlkV0G06JgJ8OkJtrgbBdW2LkbXsqYk4c7NngLhrEA74ZtbWSp
 CksyywDMzUTk3dJVSmh5HHIrhVXxgKrjTHsZN6oEy1AdShTxqKjHNuuNkH0F8oNCixIJ
 wStw+u8XYzcT/91tWqzmDEf+GN3AVzvgC5Iv05Bs2vWRbnHO8wryr7/vMyNNgeb4xkLO
 eytNK5ZgEXjhGXhM9j0IObFp/K+9nyBzdz3HpIZcUJa0//utdi6xJSAi4xCe/1VCkBft
 AtOv+ANAh1LLsSwSiNmHkqdke30Zz/OuC/TfMeiwYpfHYAqQVnXFkLvqX+3Apge8mk4D
 WIkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZyZ9Bf5kVNskF08mOLRggddbTT9A1ZLZKQ53qq5fxYWrdMQND3XW5n3jimX9V3sH02+Gl9ml74SQuoWWfvQylyqM3nY8=
X-Gm-Message-State: AOJu0YxJvgk7DvhTQ8Cgg/wMXE7ZC4jtkBXiHrEJOLdxLgOYlhcHHRLM
 php65u3bJGo01YhLLO2hnB7d0KRPTxtPIlpZWWL7Zf8CNYzVdadmpe1NHT0NGNY=
X-Google-Smtp-Source: AGHT+IEzbiahKcYhHoEDds5DaXtAgvY65OIqfiDDAkjW3PWD1Ac5bRhXWIBCscgFKQA6rwtLk7sfEA==
X-Received: by 2002:a2e:b16d:0:b0:2ef:3130:6362 with SMTP id
 38308e7fff4ca-2f1532db5admr16785781fa.39.1722513179103; 
 Thu, 01 Aug 2024 04:52:59 -0700 (PDT)
Received: from [192.168.33.175] (206.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb9d786sm55119955e9.44.2024.08.01.04.52.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 04:52:58 -0700 (PDT)
Message-ID: <9f961fc5-6f3f-4451-b60f-ea29fb033e4f@linaro.org>
Date: Thu, 1 Aug 2024 13:52:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include: Fix typo in name of MAKE_IDENTFIER macro
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20240801102516.3843780-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240801102516.3843780-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 1/8/24 12:25, Peter Maydell wrote:
> In commit bb71846325e23 we added some macro magic to avoid
> variable-shadowing when using some of our more complicated
> macros. One of the internal components of this is a macro
> named MAKE_IDENTFIER. Fix the typo in its name: it should
> be MAKE_IDENTIFIER.
> 
> Commit created with
>   sed -i -e 's/MAKE_IDENTFIER/MAKE_IDENTIFIER/g' include/qemu/*.h include/qapi/qmp/qobject.h
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/qapi/qmp/qobject.h | 2 +-
>   include/qemu/atomic.h      | 2 +-
>   include/qemu/compiler.h    | 2 +-
>   include/qemu/osdep.h       | 6 +++---
>   4 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


