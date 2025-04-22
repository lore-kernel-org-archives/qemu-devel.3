Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53277C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GY0-0006RS-BX; Tue, 22 Apr 2025 12:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GXy-0006RB-E7
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:32:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GXw-0008Sa-DI
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:32:34 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so39918315e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745339551; x=1745944351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ySdJDaTSexe75doWhVcIol2cBvWs0juY+3OLcCkiiz0=;
 b=jlJzLzxHXxLutiezl9re2o/7MooJzyHWj5gjE3fT7L2FERKruZhW2i4YELJcxgTPXD
 yQ5XVtM6jV1I+cjmXd9qHQ3xPWTPcgzcpE0huOhbDfqlrxFEaGC08bIRxpe0wr4dsEmO
 xcheaAbWhdSjwQCCHjIg27UnEy4n8l9UO+PAUooc1TzAyVNiRkfi/D6Vwxr2OyXG+EO1
 F3tu1fD0YbGLxd8sryxVAZ0iaKnMEw+z+ryeM6zmEq7eyJohxXmY6umgeehqKOgeTVPc
 myQSFJ3coHQj7JrEkPMIV4gxu3cHitv70KZumkoS5xN7EVuBgVkjPtfEGF9PjaF6bR4h
 fQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745339551; x=1745944351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ySdJDaTSexe75doWhVcIol2cBvWs0juY+3OLcCkiiz0=;
 b=JuDiruYLBstkQ/ryXBpRB5WWjh804ivTZ19rstHbjbBqLr5aqGAsclYvi4VXdmlmQi
 Ed7icseaX3WMSwOp55vpNMm0xy70MZc+MmvTwx/b3uMpYunRNp7gDg34bsQJ5vva9RDG
 ta0KHEn6oOr0jj48KBhrY9Z7qU7h27m8wRbX2A2O9VO+EF9tG2/1dw5WFWIMH0ISiwpa
 8QraUKf9PFgLKqqrq01danzCcAiddidSXaxsGzrN5I4N0Xu9zr9QedThFs0fqYGBiyat
 U6vSKbMf5jn2ngohfPgJdxhKg3P4MktubivAlr2gz78DHxvTbRag3y/tUAhS9hAU8+UU
 RqnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdO7YCY7D5hCRyZJ8oAjiaN9M2syhtL8W5Mc0WY+HNwNpz9/a89bzCRCI1KMTxsVa4rnYfKpkYmlqA@nongnu.org
X-Gm-Message-State: AOJu0Ywrs+MAJWE2yckC6eA6ExetPUs0y1udASz3DT+najf1pQau2rD3
 babEd9wxE0EY/+feu5heyZZ3n24VG6NPNrQknFHUOcgKbOA/qpoqr4Nw5+S6RC5Z3oFy++vmQnu
 s
X-Gm-Gg: ASbGnctG8TsVhOhpZhPSyDousRYi7JquvwOb+31flqlMu7VIjOa+lsU4djXAXngk3fz
 TnLJRf45aRUs/qMCFzbmjFnz8fxGxcdTWsHcsaX9u+8VWKBfDXDfHNwFlkj3IJbwxtWGUIRxuyL
 e4V3vnwBtcPQl73b0acN3xwKvcgtTSaBSy0XDBqTWw7iz1JeB3wSqUKzYoHaVb1f4aKNyMdhgOS
 HxhL2nipu6DlPRu4jATwqWxTrM47IPRwJwu/aNH5nxhdI59M0PNiXrbBvrtVZBDyeUo1m2PUNEq
 D1LXxdhLIjsSdhyXk0tR/LijOxttT2dgBohyLc4O5Bomau79+3m2jCi6PlhkGRqXTNQ0kYL4qh7
 dnE3rmMLy
X-Google-Smtp-Source: AGHT+IF1IYGnkyhfVo58ehmYYmd8WRaw23EW0Tbm1gACw/c0yTKl3S4A+sHRtmzklEhcLc2+6wXu2Q==
X-Received: by 2002:a05:600c:4688:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-4406ab7fa86mr135134865e9.7.1745339550876; 
 Tue, 22 Apr 2025 09:32:30 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acc82sm181415045e9.11.2025.04.22.09.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:32:30 -0700 (PDT)
Message-ID: <17b0a24d-332b-49b6-bf23-c1fced4733cf@linaro.org>
Date: Tue, 22 Apr 2025 18:32:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 127/163] target/openrisc: Use tcg_gen_addcio_* for ADDC
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-128-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-128-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 15/4/25 21:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/openrisc/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


