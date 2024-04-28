Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE625C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cep-0003oA-EB; Sun, 28 Apr 2024 18:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Cen-0003ne-8a
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:06:01 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Cel-0003pD-96
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:06:00 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e3ff14f249so28830615ad.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714341957; x=1714946757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f8RcUuZYzJJ51i53MmQws1qt+Wxu1AdZ5KD44y3Jxyk=;
 b=ni2Z2tN0QuUJ299iikXoWiE8bXAp/OfylJoo/dUSdhQiSQyXOrP16Jr/JIJbnpVZ+v
 U1j+pFSddlaWRj67wUHsLBAL8i7T79XjNozHK+OMRFKQUEptxWhu1INkpDZ3PDHtLziL
 xqTS71MmH9wpWQ8iCB6R2D3fgtqUa5b86PZGvlt+TWZbLc9rxKPcIFLWAEZZb1R/O9IS
 0af9zrl/7FslZNCFdfssneQkLFhGXj+Odo9O7ii1YH751lNdoMTyQTlbSjLKKFIpWICa
 fE1hmPpOSh78CI8xNeduRd3YUwOQArDWN4cgaGuWue+bHfJiScYAcm7eT68MEXnMjpb5
 /GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714341957; x=1714946757;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f8RcUuZYzJJ51i53MmQws1qt+Wxu1AdZ5KD44y3Jxyk=;
 b=pZcOpXhJHiYecmSzpa48UcXRPYODjDi+B6BKS/sfNmKPPnbdZE/si6kBZj4F+9DuCF
 ZjJ6CghkPYS2ki0myTsnsH/J9EFtoMSm5cb+vDETqmaa7+xKizDCeifBU/Iagag80iKH
 vVTPTTI1JtdH7bDTZfflfIRRrWvcXVXLbc3mtQxIdpxgsMvLd8yKMZsd6RKUWf0vus8o
 kYL27xHhlYUl+EE8c4MLxB02bywl+XZYJwsP5NnuO5YAccQkriRt66E14Z1vRNiiDebR
 oylJaUDe9N1M7uJVq/4qAnXoA5eozYdH6EXBnMYwme5BSeFEKlUY44O6CGjJmMHsnN01
 9iVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3vWukC0p20UOXuPcsxqL/O/6JGVFLPcuwXF7pK8uGJEhX+CWJjJEniMRXLt0oNx1Rej8lnLn8Wn65ovZ52yI/p8NzZ80=
X-Gm-Message-State: AOJu0Yz8nvqEJhEZs3RkNdlQb7PtYsaSLqfGfU1s8/3xkGerIjESNYqI
 UTU1mjZNZUd6FqYljsTRXkhJGK8FzRzygXJbNURGwUTWnwdJNwSF+nFOelVNyr0=
X-Google-Smtp-Source: AGHT+IGXW5Ul1wDBAyjS8fmBkSBtBuD+Zpt9+6nZD5e8ArSeoIHK3uoPq1bL+P9ojMeN4d7a0B3waw==
X-Received: by 2002:a17:903:41c2:b0:1e8:7906:5be3 with SMTP id
 u2-20020a17090341c200b001e879065be3mr6670314ple.18.1714341957238; 
 Sun, 28 Apr 2024 15:05:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a170902ab9500b001e5119c1923sm18867882plr.71.2024.04.28.15.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 15:05:56 -0700 (PDT)
Message-ID: <5f78d0f9-6406-4cdf-938b-5ca44a3b50e7@linaro.org>
Date: Sun, 28 Apr 2024 15:05:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] accel/tcg: Use cpu_loop_exit_requested() in
 cpu_loop_exec_tb()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240428214915.10339-1-philmd@linaro.org>
 <20240428214915.10339-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428214915.10339-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/28/24 14:49, Philippe Mathieu-Daudé wrote:
> Do not open-code cpu_loop_exit_requested().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

