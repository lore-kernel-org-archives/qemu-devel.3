Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03040C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVu9-0005go-5F; Tue, 04 Jun 2024 11:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVu7-0005eq-NC
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:16:51 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVu6-0003aa-3K
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:16:51 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a634e03339dso643621266b.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717514208; x=1718119008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6S5svVme6jmsHGdrnGv5XcfKvAPAa5t/G7UCBLirySs=;
 b=ov3Iz3yB09iHGawuq1+/mk2ZRjOfi/4fqgZpUhSm8fWt/qsgsjyvbQ1gdS39sSO+fy
 ngoz4GZawumm8nHDLggiJFZj88T4BZ+MzUGRYHMX6diF112pAKU9O0MGWF4a3dhiU7Uv
 j0DRpbSoAVn64Th7QQMkLypJv9EHL0BHTqXZpEHmLnwdhT6L7pssxwNZuodRD4/MmABg
 vg3yDXI65d3sYQBiVL8OnsLgaAQsVfqJqUsXJsIt+lnpsTXdHeowVrpRGOKZReyt4T+3
 j8mE/rc2knKCuj7XACAVl37dTiejIBs94LrBcV8MjY6ndSVdvIxp5DKNXMSzKVKG6MlQ
 RLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717514208; x=1718119008;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6S5svVme6jmsHGdrnGv5XcfKvAPAa5t/G7UCBLirySs=;
 b=h6kofLO2HbiXa7eS0tvDxUZ/aYGjYYebjzySyF/oJxtjIrketUnn3kHtpxdN2s+vG1
 FnzP9upgAAX9E5NCnYL9dR3Pd5AQMW5LaNB2S0QIbcWmSOLo6CwDb75ieFYqpbNB8UJ4
 1SAu/0IJQeLaRaRGzK0sQNBdAJgn8im6JD6tSHG2RARhDk+IiJ7pAg7RcqGk9oyJJZ6R
 h1fqHqvXUvVrv3l9318jZpWoeImB5UK2TR3CMPhCC8mMakTD3fPqwLnbvuxPsGTEgMzf
 Dp965Z2WX5e+6pFsWS7aqZX7IiVMmC3kgnqRemM74VH6djP6MY7EqedgOdJ8vFf7yqz1
 KRbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN3sq/Rdp0Tn7fH0cmrHH8ZlXlacrHqYGxmjqxYIcDpm4BI7gdnqYKcay8bzNvjpSZ+N5x6q/avjFqaDms8df+WueQwh0=
X-Gm-Message-State: AOJu0YwWae0so6wXAQY0AGEvy4rY7j0rxXNm/5Fzt3G3+iib5sD66Vbg
 6669+xW/Zs0xAu1DfTJt12/m0n/d4CiPUGJEQzFcAwGSUx0gySUzVNyCGKgm9pk=
X-Google-Smtp-Source: AGHT+IG5Uh+UrFLty23z8Mdkc8dV5jX+Tlz2t+NWzpvteweWs4QXx+kqz29kFH5M5ATs/zYrsiczKg==
X-Received: by 2002:a17:906:b20a:b0:a68:ab53:50e7 with SMTP id
 a640c23a62f3a-a68ab53545bmr516836566b.69.1717514207675; 
 Tue, 04 Jun 2024 08:16:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68b143ce90sm507172266b.182.2024.06.04.08.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 08:16:47 -0700 (PDT)
Message-ID: <ad67aa17-90b9-4621-8ac4-f117d6294e19@linaro.org>
Date: Tue, 4 Jun 2024 17:16:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] scripts/coverity-scan/COMPONENTS.md: Fix 'char'
 component
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240604145934.1230583-1-peter.maydell@linaro.org>
 <20240604145934.1230583-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240604145934.1230583-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 4/6/24 16:59, Peter Maydell wrote:
> The 'char' component:
>   * includes the no-longer-present qemu-char.c, which has been
>     long since split into the chardev/ backend code
>   * also includes the hw/char devices
> 
> Split it into two components:
>   * char is the hw/char devices
>   * chardev is the chardev backends
> with regexes matching our current sources.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   scripts/coverity-scan/COMPONENTS.md | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


