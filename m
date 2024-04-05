Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE0CCD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsj7W-00014b-7u; Fri, 05 Apr 2024 08:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj7U-00014G-SJ
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:56:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj7T-0001TG-2t
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:56:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-343eb6cc46bso292985f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712321793; x=1712926593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ibi5jO96FnZRkd71t1uriYj38RVK7PhAExySA78q0ro=;
 b=Ch5Ood1e0Xu3ggmFQK7jiAh4IsCwmf2XgKiubrjNZiLuInTwMSwPnf5RY6mwJ2iRAs
 0tNBhNV/nSky+S4iHk/XyvrSHddH+qu7YRIBPQ9icMUkaIySmtQlynZw5Qd0n8vKzxPr
 TP7H1Hj4kzm472qoV/9dRRj8zaUZgWt1dEafKt1YdN/PYJaf8XCbUKoWYWv3COA2Aw+x
 UsgvAahsIUnILlzkKPwPetbW+6Y7xU0TX/U/xse2mUVquG1+Rex87lt2fX3AQNOWrJU4
 ZlTwE4oSINi6G4FEp7KBQRsi1cBFP88TfdmmQO41H3QwJIkJFAeasyY6Xpn+yLN0vtmB
 dF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321793; x=1712926593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ibi5jO96FnZRkd71t1uriYj38RVK7PhAExySA78q0ro=;
 b=bHbCKPDYl+UQhEhSopEz9015D6Rocbo8Hf5estFCQI5Ie1KIJHrl4HlZfet4OmRBqy
 gjejcb9c4kl7a0dzTyM8KWHM34MDAZEHO7A2kJx5cAV4FaTxgQRCHwKMiCqGTmFDnJg8
 7Bcs/FSZz0C7PPZRyZM0xUB355kgW2A3mbUVEhLvTT/rZRnLUgZzLR43fnXha8Edx5FZ
 tRa+4zAwVf+ZJrrqvg9zGtyIPl3IFyHSkKBOA/j2x8ITps0PNM+SdITqhDZdemXJaHbT
 sOn2HXJC/suyv9UmCT1BgqijxA2dGmgdB7Q84OcpCi/tQRlj/fcZZOfrpqK2EKVH1W2b
 oxtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmtwfbrlixnUTCjEWKMFtfx+KvipvhhN2dn778eG4HnfOjvhAFe2LyYDloCWtXQIgY90zUDbTvNoxauEIgxC2Bvc0ke+E=
X-Gm-Message-State: AOJu0YxXRiD67zmCWjjIuawdN8ojOOQbNjGktl2zz5rJU2mv8ibfFsZz
 wMaYIqWltwysbp0XwyYDhV/GQ2Gp47mDqmMufQCw9qkJoo7q92Zx8yYx6vRzqzw=
X-Google-Smtp-Source: AGHT+IGWjfDZ7/clzRevHJpvChy6N6Lx+RfZFRHqmiYOTOhOMbWat3ELpIBjNORFUp5db6TQ78tVow==
X-Received: by 2002:a5d:4045:0:b0:343:471f:fe54 with SMTP id
 w5-20020a5d4045000000b00343471ffe54mr1066682wrp.28.1712321793582; 
 Fri, 05 Apr 2024 05:56:33 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 dm14-20020a0560000bce00b003437a76565asm1971601wrb.25.2024.04.05.05.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:56:33 -0700 (PDT)
Message-ID: <9924f61c-0f6f-464d-9d26-147c69bb7b13@linaro.org>
Date: Fri, 5 Apr 2024 14:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/32] target/avr: Use translator_ldl
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-27-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
> Cc: Michael Rolnik <mrolnik@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



