Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4A7CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsioA-0004UY-FL; Fri, 05 Apr 2024 08:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsio8-0004RM-OA
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:36:36 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsio6-0002Su-Sq
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:36:36 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a46ba938de0so299119666b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712320593; x=1712925393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J++kL632WorLPspweMLHSNtAS0vD2cY3cqlzSiz77LE=;
 b=Xg3eyGjq1QFyP5ps6b0G2Pfwq94dbbTJYbYOYCCg+YwFG4AXBZKsZWQpaKFz2/49JP
 VRQjrsSQrzAB0F8rx5uhTih6MWWK0F2ZnYmz8m36qnsbuIoJ0QGZ4b2QWY1xCK8cC6Y/
 KclgO6aOE44QmKD/+7q46YF9XKzdEwYj50Kv7mrM1xLz0AR+1/ROxgl+4C9jt494q1OS
 0FmpeBK4OBuqBWx10M3ThltS+B8gFjlNh+N4/7YisBuQBHC/grox4iTgXCvNsJlh2Z76
 wkoFC566hmU6iDuY/b91z/SjNmKjxdW0Wqs1Q6fkB8xAMYllSYm3B2Vos/12QteMMVfb
 J0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712320593; x=1712925393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J++kL632WorLPspweMLHSNtAS0vD2cY3cqlzSiz77LE=;
 b=ceCiudbLH7Y+Btqx3/n/S1JwggC+aRao6dxaCR2WCYhjr4ghJzjwC+2xyB2xBufELN
 rI3p3cHaFhK4JhyuAxUAUeA+nCBuvg1ka49vABrHeSpdezIgEqZb2DPIs6ggUlhKWZNw
 /SDikG79sQo2N/DQ2Gba9RzL5OxGsvy82oRBzOYBHD/zey6Ix6NXkk/iKK/MDe0aKMrq
 gTH7k9K93ipTmMqp1UChK1skB7I1MwU6GyP6NWTuE0i2kBlYpqP432ZK1HlTd3rL1XrT
 5laLDvco9rL2IARnmCu/1rzk9dUkwB+FXqSDhcO4b3Z9NhAA9GHa+irY+C882LWj1aTJ
 UaZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGhVg3qkAif+j4+vBt+NFWFg/BmHapy8FVDm1Ul68kcAG1WgSTiQot/kAZJslSpfRpb89QWBTuhEXCf/CsYdJTO/0MYL0=
X-Gm-Message-State: AOJu0Yzh1bVebad9RfFko0AuygbPzX9He+V/rMuQ8KlxmFENKXc9RBet
 jLYQwnrtox81TDjtkPHmWZM5+jFD7YuCI96a3lmgOy2YSe33dBw36Q+T9fmPL55MKxOPVJVf4EX
 N
X-Google-Smtp-Source: AGHT+IEyFNkCxUgc364LVsMFZnQntdJPYrpvBHMB0OS/dY/Og7ONtvi/aUtNFcxptHLZuqvpJxNWTg==
X-Received: by 2002:a17:906:6899:b0:a51:a788:c568 with SMTP id
 n25-20020a170906689900b00a51a788c568mr1027438ejr.31.1712320593232; 
 Fri, 05 Apr 2024 05:36:33 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 gs9-20020a170906f18900b00a4e07f8b6bfsm789125ejb.59.2024.04.05.05.36.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:36:32 -0700 (PDT)
Message-ID: <253570a2-2b27-47aa-af9f-a2d6966be654@linaro.org>
Date: Fri, 5 Apr 2024 14:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/32] accel/tcg: Cap the translation block when we
 encounter mmio
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-6-richard.henderson@linaro.org>
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

On 5/4/24 12:24, Richard Henderson wrote:
> Do not allow translation to proceed beyond one insn with mmio,
> as we will not be caching the TranslationBlock.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


