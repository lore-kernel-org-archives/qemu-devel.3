Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BF8C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OyH-00027U-OK; Mon, 29 Apr 2024 07:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OyD-000228-US
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:14:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Oxz-0001za-HH
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:14:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41b782405d5so31959305e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 04:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714389276; x=1714994076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LNiXN643jILQJ7gXR0sUPr4lZH7OVsdLlWDvctjhb/w=;
 b=mON8UcEdOVH6mD8qwqaB+G5uDFmLKYJBMq1wPC754t8fsxe7qJSI/e37XBmZXVBFA3
 89xUFjc+xlRFi6Z2jf1E4tzJssQ2KV5mA9ejIsw56H2yTqo42M1BP5gcJhv57UjJ+i+5
 8GrTN/HoGcmFmoVZs7t7GAQsBksFaO29ot7x6lNkBq0ZsFTvwtcN1Rm0YJoTM2Sg+fwy
 aDFnoywOz9Sn13V14q7oNxx2+6xJAJQzd31dBhjQNyzX2lqTYKrP7KPFHTBfNKwpNLk1
 yWBHGlKUGTk4XZ/LDAZrLJxAVyZT/wIpr+tMIRbwr6fsZ9KSwRPrDlguyXCKQzfVmHs8
 r4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714389276; x=1714994076;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LNiXN643jILQJ7gXR0sUPr4lZH7OVsdLlWDvctjhb/w=;
 b=o/A8Ghkd7YvjBLT8Up3dRL7oYsJS6ksmJSaqi4AICYxXPgBHFbRrOMARlPTXFVMkA7
 ZLt65Tc5ySOvKG+uR0P9lsXViLR1iS2aVtphdN1GEa6k85jg35e/S3NMFa4N2ErRfTMR
 DYtZTDlxsAhNTF9dgg6F8RkfFad5D1djQzCf5Vbl2Wlp6N51Wz1ZLGU/kPEeuuaH1XG8
 Xv/VX/7oqTrj88f91ttuTgRkc7Cs/WixXnxIXQxGlJmGAxeqikLEptI4PLuV1Af42v4J
 6DVGU0/GrpuoXgvXdf+zKjFL6n9eiXFT3r19Z1mWa4T0T8QSn6JjyBXC206+ckTt/4wB
 5fAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/XMXsKRwzzKVghoWd9nQqLoJgrrOfTBqz0gD6tcT4mFcC6D0DSE0BDPmoPezOW8l6b0IksmJjCWlKBkxYkiIre/tu/NA=
X-Gm-Message-State: AOJu0YwB4v1I8EIBUJFM9uyTtTOnF1ILf6bTTLVMJUijNcCUrO3/N3dq
 cifpuWxCigOHikFJdNPgkPP6LVtdUvf3+TYWne3vx76lwwCwn+CFSU48PjpqpHg=
X-Google-Smtp-Source: AGHT+IHr6f5m6rlXyUenlvsVpFsA2c+1xQnSi5vAOa9yFx+ccayODBTvqv0KfOgMlmfZr/bQPNwRvg==
X-Received: by 2002:a05:600c:474d:b0:41b:e244:164a with SMTP id
 w13-20020a05600c474d00b0041be244164amr5780934wmo.6.1714389276418; 
 Mon, 29 Apr 2024 04:14:36 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 t15-20020adfeb8f000000b00349ff2e0345sm29354674wrn.70.2024.04.29.04.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 04:14:36 -0700 (PDT)
Message-ID: <e8af0d3f-6884-48b7-8923-ea560c758a7c@linaro.org>
Date: Mon, 29 Apr 2024 13:14:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] util/bufferiszero: Introduce biz_accel_fn typedef
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424225705.929812-1-richard.henderson@linaro.org>
 <20240424225705.929812-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424225705.929812-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 25/4/24 00:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   util/bufferiszero.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)


> @@ -178,13 +179,15 @@ buffer_zero_avx2(const void *buf, size_t len)
>   }
>   #endif /* CONFIG_AVX2_OPT */
>   
> +
> +

Spurious new lines :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   static unsigned __attribute__((noinline))


