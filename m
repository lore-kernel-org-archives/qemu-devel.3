Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06E2C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNmQ-00084R-Or; Fri, 23 Aug 2024 02:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shNmP-000816-Mw
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:28:13 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shNmO-0005d3-2J
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:28:13 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a869f6ce2b9so97184266b.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724394489; x=1724999289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L9cq5SSqR0fe7bHR0w6kL76yTFiFNv8uUr6KDGyS7nk=;
 b=Zox+KxIgBJ0qqNiUOJhnevnEmqQDDrYKs9JbdWUDeQA91jjRMrFbmqxCvucWC2omud
 ezQP1D0l05OnuolkCHlwp1Bk13RWIA5X2uon0MEy2hkRDXwNiEPSQTnos6+JXk0Pi1aV
 vBbPR0JZoWkYyHGxODleR/MujFEruEjKGvWQ6SJIRMm9bxycdTXC0S2h8YH0TfjR1+bf
 XJoxrYMlvXK4TjdukWbdRs2Pp938iZ2U5y5nznLj1rjeiXxqy4baInsMyJcXk3kW+Eoz
 rq/8pQON7gkIAR+O8Fy7HMONTthEGaDcvUOh68Bd3f1ibA2S07vXYhzFCQaOu96BVp9k
 GKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724394489; x=1724999289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L9cq5SSqR0fe7bHR0w6kL76yTFiFNv8uUr6KDGyS7nk=;
 b=dMwhpAW6maVvGgPEOldt3e1jSjusQDoFwZNdwvdiQ4vc5jsFuWhmKxqFvXDK6EI0FB
 xmuePspZnkrBTI2Tw+viz6ZF2+S2eDWyN+8NtICxhC1CskdbhMGnSbunogaHKzShNFf4
 xR/BSTdg4afBFhABmxbyrtZf1KK6VksHUQe010d9PJcir3reky/gmPX+ihOhHTGDj+bM
 uYN7rOT70ExqKroapiuEGYlUSWvKZXKTF0k5yuUDf4jXMtnZ5JwjtDGJ50KN22Lhgzro
 imtpHVhID6E5sq8X8qeSWUg5lMl0Fpwcq6/HIJTzHWQ4CsLK4lT0Akw/NKs3ejTtMgoA
 jPmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnVmst90gw9cVQb/QIXXGwVMcC3A68MzH6ERZAsIrDFQmHbOKFtOxxxptlvfkx177+viUtRwHNX9E5@nongnu.org
X-Gm-Message-State: AOJu0YxaEMiGpSdM7CsugXUqCEjZB8jMUwbt/wPRX2G65g2FaCeuzebU
 Z4iiBY7LVHM82jGrXOwIXCVoKfyw2j3a1ixJTbfcaPJOpCIRlPr2VoXQzmnzx2Y=
X-Google-Smtp-Source: AGHT+IGF44Ih51H56V6Fc+e+6ooJy/PPeqkudNMsvyd2uC/lM3N06sfNvUlMStbuA57YVvPFfTLr6A==
X-Received: by 2002:a17:907:72d0:b0:a86:8196:e04d with SMTP id
 a640c23a62f3a-a86a530539dmr76107166b.39.1724394488875; 
 Thu, 22 Aug 2024 23:28:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f220dbesm208907966b.27.2024.08.22.23.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 23:28:08 -0700 (PDT)
Message-ID: <b2b37ef6-1eb6-4572-81a9-7c1406373d23@linaro.org>
Date: Fri, 23 Aug 2024 08:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2] hw/arm/sbsa-ref: Don't leak string in
 sbsa_fdt_add_gic_node()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20240822162323.706382-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240822162323.706382-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22/8/24 18:23, Peter Maydell wrote:
> In sbsa_fdt_add_gic_node() we g_strdup_printf() two nodename
> strings, but only free one.
> 
> Since the string is actually entirely constant and we don't
> make any use of printf's format-string operations, we can
> drop the g_strdup_printf() use entirely.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> A small once-only leak, so this is 9.2 material. Spotted
> with clang leak-sanitizer.
> 
>   hw/arm/sbsa-ref.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


