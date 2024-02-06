Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2C6C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOYe-00027M-Jw; Tue, 06 Feb 2024 11:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXOYd-000270-B5
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:44:27 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXOYa-0005o6-Q6
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:44:27 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5112bd13a4fso872736e87.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 08:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707237863; x=1707842663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kmYhWOA87klpr9DBDCRadep4Zjk7/4AqwmEj7sc4Wyc=;
 b=J+LOA/MwpKpyZqV9whp0EuAlYq//87uoag1HjpdFzIptxdKFR71KTWNXmwMTtIGwao
 SdhCurqXx+xdSh3HAUUIhRtbnsnql3d9Ej1NiTjtU/oPuhWUR/tNWr60E4i9hQQlCGoj
 8gDxdZQM5dW3IxVkqpNeg3TUIhzxaqxvx6ZV6nrcyKHaXyqHkgusKSTgytSFDiUgg/Ug
 HFq0z1mS5vuo5nUmH0QcUy1YW9VNsLzAzgJSsm6lzrF8S9rpdL+bBUm/1CivoXyLQkk0
 uXqLsESRWDSW7zMMJS6SuedaqCKl4ZQ8upTvSm5zi1hP6/uXTyNcvEpZQFhv6KBXT1dX
 mUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707237863; x=1707842663;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kmYhWOA87klpr9DBDCRadep4Zjk7/4AqwmEj7sc4Wyc=;
 b=Niku1uQVN7mMcCGmfuN2oDnh4OcWPPwewbgq/hHlMAqEppAD29kF/veOtjzsUxF+3r
 qeR0wELOHsw21jY5gq+4jsfuKlDoTP+VVpopBDJ6TW83XLhR88xO/n9qh3he3jCjycBp
 8U5MkzuA3tI9WLcJXdkJ582VFJ2c0AOs5cnj2dbEphAh1NEvBDg6Q0fdoZ7iSW8Ss96a
 jek/6LsfTwT6ANOn3LV5SGdP1PhaPc868gvnz1mie7I/O4bicGrgM/BgAKxdjVsVXZ5M
 65uekEMVJXqfOtiSQUpTxx19OTA4NoS0nqVI82+i3VRqU1Oo9BNuXHXR7QOmrydfMyk8
 uijg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa0Njxr+4+Eqjevnt/pvpCoQ257Mjq2Xy1bmT5F9KXifGD9Jt0nQNUMYQlT9CWFB6jyfzbycPXTCzLzoaSkVQORoFCpyM=
X-Gm-Message-State: AOJu0YzjBXdhQaE1JeXDrtq5YNx/waw7UMiZNiV7TaxT0FhCZoW6ZSgH
 F6apdRg5OdiY9BJTwc2dpEpbwqfYLu1MXSC5eSY0siJpoKmJ2ck5/AvEGOv/IHE=
X-Google-Smtp-Source: AGHT+IFq+Froq1ud0rCQabOEeYxKKDAEctTX31XTnUXF1lwLuoVEDQeGaW7iiv90k5M0Ao5x0fuMhg==
X-Received: by 2002:a05:6512:71:b0:511:5936:c87a with SMTP id
 i17-20020a056512007100b005115936c87amr1179017lfo.24.1707237862907; 
 Tue, 06 Feb 2024 08:44:22 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV5jQ8Y5P0LGEZUyDih3KBpWbShTwsLFM69tV7EIHeBH0VpaNEg+akHHIft9e2Fl+ZAVYZg//Q3vrGFUh31/jWS3Ob+7W5ntlD6DBh26mSlU1+FJJXVmgHXTwY=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a056512109100b0051153069551sm280983lfg.214.2024.02.06.08.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 08:44:22 -0800 (PST)
Message-ID: <8a046117-f306-4128-a486-e1f29f168bb0@linaro.org>
Date: Tue, 6 Feb 2024 17:44:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] hw/arm/mps3r: Add UARTs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-11-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240206132931.38376-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

On 6/2/24 14:29, Peter Maydell wrote:
> This board has a lot of UARTs: there is one UART per CPU in the
> per-CPU peripheral part of the address map, whose interrupts are
> connected as per-CPU interrupt lines.  Then there are 4 UARTs in the
> normal part of the peripheral space, whose interrupts are shared
> peripheral interrupts.
> 
> Connect and wire them all up; this involves some OR gates where
> multiple overflow interrupts are wired into one GIC input.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/mps3r.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 94 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


