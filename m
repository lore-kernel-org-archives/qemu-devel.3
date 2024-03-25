Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0500EC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohRu-0005es-2u; Mon, 25 Mar 2024 06:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rohRs-0005eH-AK
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:21:00 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rohRq-0005nY-Fx
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:21:00 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a46dd7b4bcbso507878966b.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711362056; x=1711966856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GN0UDNTJxt/XIm4/wqhSOJJoH69f/+XSW/qPUKPziAA=;
 b=D03G5fVhxBvTApro3ljlmV5L9+wMM+xt95IfR1dr4maB0M3xj5EV3l/RDsM6QS2RRN
 Xz+O605Irui0UTORGU389Dt5qst628uHNxY5hH+9qjNgSF/UzHHQMhMbrJpSeMwZ6aMP
 5n6ZLxvUp2j9DjxWBu2eE2FOUrfmgapjjbhQubWoXgR3TgZTg0ZCtaMRUFR3b9JVYVYP
 SFTxWwD0nU6mGnF1vgICqdk5ssOvAa/onCuK/LvWNO/GOTe6m+BmBnI8gQQkSQah/fvA
 OZpiUJY/YELL0ghkwjFArviWYokgEhl5MzLNiaVhkck4RUevVbMWAdVYaTIuZcX+bi+A
 Bt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711362056; x=1711966856;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GN0UDNTJxt/XIm4/wqhSOJJoH69f/+XSW/qPUKPziAA=;
 b=OQFuvPo8uFIESUXDafvLA7roSKXMFpiRAp85VAJFAtsrhC0MMkbsdlN1vSzZAqpuDe
 z7sHsM6UYTUG1y+kdGtyV7gnjCDw2bhf7inm37HciK5bomGSOQO1bYCGSQ6zp5kuvU0c
 rpSMjbLBzdPcmowVQgAkcl6vJkmKyo9zE2cAITFsUHXS9572kzIy7Vd/Jc2+huT3VERY
 jQ+7yFelm+XrLmsY72lzxFzVQl1QyQY75MvndaI0u2/GgPPzj+6D1kKz9KSeBjN7g4Pm
 //UzLYFqdVHzU/q1xQ/yoZ7A2S8PqWg0nWjwO5P/Prwn5VslNMSpa7gcwd6sBgg0XCnw
 s4dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsAJnuuSOonA7qtQRq9q9VuSmDGws5TTpUSoGiKFNRgTv4tizv/cniotb8/8DuWZox/erKAQ+BRsA7jn58lMEFKxSnykQ=
X-Gm-Message-State: AOJu0Yx8epyA5LuIjihNZ4InrJXMQghuy/YBqj1eMbcgyjuhjnIr4wW6
 ZZHZ3DVq57HR504CjEwL+/ank5Vb4HTCxLsE1yOWcxnrQMUgWcYv1KcXVy5TZpR3CAYRgNrQZ6g
 g+cu9QQ==
X-Google-Smtp-Source: AGHT+IF4cGIY2uJqkrTpa3xOaS1fsZLLQHXzP6WIbj7UDLjwnlxABm1qvUdegBaukavxPDwkqKo/IQ==
X-Received: by 2002:a17:907:9719:b0:a47:4162:766e with SMTP id
 jg25-20020a170907971900b00a474162766emr4876384ejc.22.1711362056133; 
 Mon, 25 Mar 2024 03:20:56 -0700 (PDT)
Received: from [192.168.130.175] ([92.88.171.150])
 by smtp.gmail.com with ESMTPSA id
 hy8-20020a1709068a6800b00a46c0191306sm2885132ejc.213.2024.03.25.03.20.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 03:20:55 -0700 (PDT)
Message-ID: <2ba82b40-cb26-41aa-be70-41ce5abddb24@linaro.org>
Date: Mon, 25 Mar 2024 11:20:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/17] esp.c: move esp_fifo_pop_buf() internals to new
 esp_fifo8_pop_buf() function
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
 <20240324191707.623175-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240324191707.623175-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 24/3/24 20:16, Mark Cave-Ayland wrote:
> Update esp_fifo_pop_buf() to be a simple wrapper onto the new esp_fifo8_pop_buf()
> function.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)


> +static uint32_t esp_fifo_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)

If future cleanups, maxlen can be unsigned (size_t), anyhow:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +{
> +    return esp_fifo8_pop_buf(fifo, dest, maxlen);
> +}
> +
>   static uint32_t esp_get_tc(ESPState *s)
>   {
>       uint32_t dmalen;


