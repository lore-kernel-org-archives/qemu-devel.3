Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCE1CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsj1j-0001yh-1m; Fri, 05 Apr 2024 08:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj1h-0001wJ-Id
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:50:37 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj1f-0000MM-Tx
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:50:37 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-69629b4ae2bso13403926d6.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712321435; x=1712926235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DkapTAwJ5yw0kInjgA2qx+BNlupdRFHhwQfMjRq0tfE=;
 b=G+us7qey9pR71Js9aIe4KV8U1JUGwQZJIEMfKlxkTxsfDDVueAs3Wc8Qg6Ry9fxfRG
 Hlm02KgI8ovdcMNxXH33cf3uk8ugqYYrK8yvQmp2Pz87aaaLw24DdTVhkmA7Fz7XyF4b
 exZIdRLgOv1anAOnuK6bpnJZpiCVtFyXjhQM8SNDcI5o0J3p6EK8QbB3da/Bd3y+1ggQ
 IRkyvqHa1PvM1/JYWskcOAl9tX1eUS+1lAALlqp5lN8dECO3mOLqMiz5D+GjYV90XHdm
 vW3J9imr6R4W+T0XipujiK10gOJvZozajdI574NRrFRnQaRCbUhONEfBD7Sej2f47pQG
 h5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321435; x=1712926235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DkapTAwJ5yw0kInjgA2qx+BNlupdRFHhwQfMjRq0tfE=;
 b=Mv6GxvGRB8vACuqwuOZnD4g7DR4UAxlrBmOL+iap0T1efWiLUq49mt0xZFbe2PLwVL
 QyZVWZbiY4SuQPHYNgP8Y0oIrssl8MTdOv1Ua1fApmpDVGAM24KpzNUhW2DPBNkTfSU2
 UIBXzRxdQth9FI7fVpHEBH8fMOslgQi+7ePFBu8CIiFfHh9vCRknmPLERX3gUikbtY0b
 2GBHcOeHHk12Z3rB9z7eDOUIloiAYxMZzD9zqvkHf+GlV6fESnXBSfoflZmSYc3W8+2S
 lOetpdgVu1pT6ectMLydVGKh/znA+Agww1CORG6Gogkx802jxS7qLgAeoMmx7mX2Xcp2
 txMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkk/dsJpY8q+13PL7yjEqhS72Wk/pKTfV5+EJYNsKammZZ/OUvKt7Ze5v87hFBclJIt1dekTCBQQr1sY3hc7EeMQiD2z4=
X-Gm-Message-State: AOJu0Yy3ujXp8iB4o628IrdhcaCyEOXkwWHrgCsNL+8PNLjlfkBDchyI
 6wHu0lQ8jdRYfIWARNeHQIysZqfPtXwtIQ5ddE6m3AJswPVmQI3TQucdl9P0hBA=
X-Google-Smtp-Source: AGHT+IGSluPNZ6FYLXg049pupGKjXMch1OCipoJls0N8l3oTUJmbBSIegitVvxSza6KGMlaRRLYbkg==
X-Received: by 2002:a0c:ef0e:0:b0:699:4493:26d6 with SMTP id
 t14-20020a0cef0e000000b00699449326d6mr469343qvr.29.1712321434762; 
 Fri, 05 Apr 2024 05:50:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a0cca04000000b00699047948besm385537qvk.59.2024.04.05.05.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:50:34 -0700 (PDT)
Message-ID: <2fde4060-9716-4246-919f-455d31841705@linaro.org>
Date: Fri, 5 Apr 2024 14:50:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/32] target/cris: Use translator_ld* in cris_fetch
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-28-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=philmd@linaro.org; helo=mail-qv1-xf36.google.com
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
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/cris/translate.c | 25 ++++++++-----------------
>   1 file changed, 8 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


