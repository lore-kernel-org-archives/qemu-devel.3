Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CC4C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 17:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj0xB-0000fu-5h; Sat, 09 Mar 2024 12:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj0x8-0000fY-Cf
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:57:46 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj0x6-0005hL-Pq
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:57:46 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4131804e695so9376315e9.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 09:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710007062; x=1710611862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IxhJSXqEKqcC23yHFxKKlvN5nLzDVZ7x48xn7IH8dks=;
 b=VcwsTSQt9tNuDLV7hN6DcBdoqIIq3H42EbYZfNEkuOJm/L0zGees2+l+6+yBQKCKGP
 Ev/EDz1QcqG70vg2puufkOr43KG96Wb8Ri072mmVowkImgEfAbpv/ZaQVWILWKdD34Vs
 qafYgdEcElgAYVkjCOJnaFGpiz47vQkpDvKOOKNk9Arv/jVv2kBaCBNG6nmTm6dwMKZR
 I7ylz3WGUrnl4JWrp2wzs/zB5vr8BKIGv/1XRs8YkyMuc/wmP3pqKGPD8nVV9XIEhhWE
 KGXDgm4cq4M8f1fqGJYmxweSUIZC2NqTbxp3LZuy7Nju3Yy4QzR8hQq8xIeNaS1dQ66o
 VfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710007062; x=1710611862;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IxhJSXqEKqcC23yHFxKKlvN5nLzDVZ7x48xn7IH8dks=;
 b=SDlKbZsvHMo7hVF6zpNlaNQKeqSLiWI8jH6sUF2qOTh/itdovUW/6Ud5yEO9IOkCHo
 Iir6QXqUxQ3o9AwpFhBQO7sLWwlRvSFzcniRaWMjYufEXPzdMkGTWh8UIFLLiEDMhiwI
 5aFyiicDNp9w6sTjyCFvvNoG1eSuhiAa4TmXjvx4bftEeNbvZZqecrAChha8IuJVvzmA
 F35h+S7QsRFgT7HzpHN4sW4IehpUveHlUQVO6GiCsWEaUDUBC8z8ySSVc0oLx2Wykv7H
 OLn42tyRVMPFH6wRbNdgft8rCUMFgVipvzzN3kNRShxjBZaYblY3GrytzEa/soaeR3Dd
 SQHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6rz2YiIP5XyBdTyUJKfQZKw0IDO13YHFdyMVoLLjSnfKff4J2xo0+89bJ820RC1UimxlAqGxI+xE6QrudxbLk4iqgsps=
X-Gm-Message-State: AOJu0Ywjv0F9R1cYfy9KTdubTT/z4Dz5yIhX/7zg83pz9RE4ZoHfy8dn
 aI7SGOypl8VJ3L2z419M846k0e5fPyI9erHHz5DhTZuJOJDnn5r+BwWKMPc3l6M=
X-Google-Smtp-Source: AGHT+IHJsIeY4EeBf7fylBaWPyNEY02hZjOrSlN/oeSpydAHABkxt5BgyhrNsQ+PlxZds0lWKb/XVQ==
X-Received: by 2002:a05:600c:4708:b0:413:12bd:a8ac with SMTP id
 v8-20020a05600c470800b0041312bda8acmr1976423wmo.7.1710007061802; 
 Sat, 09 Mar 2024 09:57:41 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 n34-20020a05600c502200b004131b2d3b8esm5177319wmr.41.2024.03.09.09.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 09:57:41 -0800 (PST)
Message-ID: <b37abc0b-8a7b-44f2-9eaa-c258214b161d@linaro.org>
Date: Sat, 9 Mar 2024 18:57:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcg/aarch64: Fix tcg_out_cmp for test comparisons
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, qemu-stable@nongnu.org
References: <20240309175102.726332-1-richard.henderson@linaro.org>
 <20240309175102.726332-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240309175102.726332-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 9/3/24 18:51, Richard Henderson wrote:
> Pass the type to tcg_out_logicali; remove the assert, duplicated
> at the start of tcg_out_logicali.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 339adf2f38e ("tcg/aarch64: Support TCG_COND_TST{EQ,NE}")

Oops, thanks.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target.c.inc | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)


