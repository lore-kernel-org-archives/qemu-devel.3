Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC43C25B4F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 17:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5TrP-00078U-KT; Fri, 10 May 2024 13:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Tr8-00074p-L1
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:16:27 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Tr4-0001Z9-Uc
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:16:25 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a59b49162aeso554540166b.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715361381; x=1715966181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vuRVizTWzm/68BFIUrzt8k0RVtaJwIY+9hUeiFE98VQ=;
 b=epYcvhzP1CG0oG0TBzRTyhA0IXTlT+Hfz06n0qwQAV5Zrhk5U/H/2Pdl2mlxy9u6hJ
 ck56N0dbpJWblcWR0GzCcB8FT3cWU5cRf9zbZR8qJR/A8kz9N0irOoJ8WRZP2FSHHizy
 E0O30QkjovVC/fdjyqSWtuxdCwv0/NgjQHmi2hkcLdWfijT2TVAGk1Ur22fylR1NIL2r
 Udn3JxD1C2njFYUlhUjcJNA1T5Ib8T/EC1973g5vHMqHnXWCZMDBkUBzae/ayZGyqeld
 1xTTylMbENo3lrZiFTxQCMHZbUGzsyBpsoRivG+7cl89W9ourkr0iVYFHB7JI4rZKJ/Y
 fnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715361381; x=1715966181;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vuRVizTWzm/68BFIUrzt8k0RVtaJwIY+9hUeiFE98VQ=;
 b=DeiLMK08Bg5D4/QkOrIkYTKz1EarROJMb50n1x2RGOVO0nKB3aYh+s6fPk0JR1XebZ
 QUyb5DngvOsyLaC3oEj9CMQswJJUBA2j0BffNVdp/HolZfravE32zmlH49a21BvvBXvB
 INTGJqLsm6UocXbI34SuMdEP3y8BbW3km8tLuROgxgw/toO4liRkYlhYinXhxlgT4lKu
 5rtqkMjHJ6FpixrybBBvFn+/aP5a8fK9MkBKMTN3UmTX5a/JSsG7Ong5aTlmugohRsOH
 QO70lxfkZPWdrEJmnS8JCcY0q96IQrk0AoEL/LG27mBMpJfuJov8WySKtmMIlMlHf0Bf
 96eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDumPO2NQTNOGrbm6HohXIROI9dfSrZZrbkn2OLOzMPzZWsXty48mBuRgVo69kaewPSnGm47tWVyr/sQwx/Xf7+XDDChE=
X-Gm-Message-State: AOJu0YwQxOot6OCCXjImLoOeaw1QjV52OFM4f09dTPP0M3p+wzcw14do
 rxsHppqk+3lJQztx2sjiLMB0zSCKCzqftHMC2nDMx+QuXZ6Qien1mAJkr7ZuI9Q=
X-Google-Smtp-Source: AGHT+IG2y5KHhVOpNC3OIz6bWqqZ6eZmgtvMKIIW5GmPn3BLJiHnVnXraeFRz/vK8GXnVGfPdKx6zA==
X-Received: by 2002:a17:906:40c:b0:a59:dd90:baeb with SMTP id
 a640c23a62f3a-a5a2d641583mr243090666b.48.1715361380813; 
 Fri, 10 May 2024 10:16:20 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1792206dsm204315266b.91.2024.05.10.10.16.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 10:16:20 -0700 (PDT)
Message-ID: <72849956-04b9-4d52-9f32-098a2ea691a6@linaro.org>
Date: Fri, 10 May 2024 19:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/41] target/sparc: Enable VIS4 feature bit
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-42-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-42-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 2/3/24 06:16, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/cpu.c | 3 +++
>   1 file changed, 3 insertions(+)


> @@ -882,6 +883,8 @@ static Property sparc_cpu_properties[] = {
>                       CPU_FEATURE_BIT_VIS3, false),
>       DEFINE_PROP_BIT("ima",      SPARCCPU, env.def.features,
>                       CPU_FEATURE_BIT_IMA, false),
> +    DEFINE_PROP_BIT("vis4",     SPARCCPU, env.def.features,
> +                    CPU_FEATURE_BIT_VIS4, false),

I don't see any current CPU with this bit enabled. Nitpicking,
maybe use "Allow enabling VIS4 feature" as subject? (I suppose
you tried using -cpu foo,vis4=on).

Could we add the M7 to sparc_defs[]?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


