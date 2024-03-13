Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D58C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkN2S-0003lF-1D; Wed, 13 Mar 2024 07:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkN2L-0003ko-4O
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:44:46 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkN2J-0002HC-F4
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:44:44 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33e162b1b71so6244184f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 04:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710330281; x=1710935081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YiBLyKUiP5fWogCu58cDeSiwf0mKYYrCZi1EDZXDNis=;
 b=yv+zh1J7WBX+psXqd58/drbe8klSVqflx3vYpgEyRAYzuBc6GWqpivH9/vVyY76itT
 mjvaAB7/ClWWCJiNIOvfikD+HBobn6SyhdOA1gRuibinQWjtl50QlXMO7Y+gAAey54NH
 SKnValZ56mvxnVdC5GPEfxIGmtcoe9vlh8tiXmK5U0rSia4u8SnnGj8YD0AdlcJSHxd1
 +NXghq9SKddnFAFSI9d+L5C5ilcr/Xkjo26XeVbTbEbQnciNmSkGHSjEDreuAQ2myURY
 Z/k/FNYiz60PX8zQ+2RBUWQPOwUown+tCZ6eZyiS3xwGgjx8OJSCGiFZMhsO7zaeCGnL
 jJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710330281; x=1710935081;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YiBLyKUiP5fWogCu58cDeSiwf0mKYYrCZi1EDZXDNis=;
 b=jZ+BleVK9dKMrbUbxYIBFwwJVf37tNM90g/Oix+WdFU0/AlCG7ypkJj5RuhOruOY2i
 e9K4sdMh/Tb5KHaxkE30g1c9yJ5jtwCmc85Ef8tUCzRyQ5E+JZYHeH7JLVe3NzozyK/I
 Ocj/8jDwSyiSMxVSijzBwmvN+HNgtB4s93le0vdV/bPgatOB8rzlaIMhs/MuJz8uPeZH
 ImF4gSiIFavHUiEPck/YaOaRtOajJlmeOZjz0GFrD91sFTjiKOT2AOTIeOcv5zh6GULJ
 3711qPC4t3MR6I9QYOk9wERYZ2ignn1JibpuY68n20yZQxWGsh6eyTfNxwv8GQl2MCkq
 ICng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXugiF4x0DBn8UyQkyGSpTANUiWhWw77kyFrcveDP0Gh69FukfYa/84p/o++cP9ubcUrZO37f64tn1UVgI6HGaVeb4UKHs=
X-Gm-Message-State: AOJu0YwzXKT3IHtzXtvJX/zO8I+wPlTnyZ3CTSON4hpVwbKFdma/kWJL
 /KWRRXa2BaXscO3rsubDY2JjhGO43UY3S+TbJj3HryDheCMJTiyZcrT71/7w07s=
X-Google-Smtp-Source: AGHT+IEJsAmr6xZkTqwxvI4q+XNe8oSnCGOffYfMlBwr4gRq+9nQaqRYQqihLjoNAEPXxltgNL9cKg==
X-Received: by 2002:a05:6000:1b86:b0:33e:79dc:1867 with SMTP id
 r6-20020a0560001b8600b0033e79dc1867mr1556178wru.29.1710330281590; 
 Wed, 13 Mar 2024 04:44:41 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6046000000b0033e122a9a91sm11417556wrt.105.2024.03.13.04.44.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 04:44:41 -0700 (PDT)
Message-ID: <8c197bfe-0cab-47dd-beec-c9752d434a47@linaro.org>
Date: Wed, 13 Mar 2024 12:44:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/avocado: use OpenBSD 7.4 for sbsa-ref
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org
References: <20240313-sbsa-ref-firmware-update-v1-0-e166703c5424@linaro.org>
 <20240313-sbsa-ref-firmware-update-v1-3-e166703c5424@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313-sbsa-ref-firmware-update-v1-3-e166703c5424@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi Marcin,

On 13/3/24 11:08, Marcin Juszkiewicz wrote:
> 7.4 was released in October 2023, time to update before 7.3 gets dropped.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)


> @@ -180,23 +180,23 @@ def boot_openbsd73(self, cpu):
>           self.vm.launch()
>           wait_for_console_pattern(self,
>                                    "Welcome to the OpenBSD/arm64"
> -                                 " 7.3 installation program.")
> +                                 " 7.4 installation program.")
>   
> -    def test_sbsaref_openbsd73_cortex_a57(self):
> +    def test_sbsaref_openbsd_cortex_a57(self):
>           """
> -        :avocado: tags=cpu:cortex-a57
> +        :avocado: tags=cpu:cortex-a57,os:openbsd

IIRC for some reason we must use one tag per line... Even if
named 'tags', this is handled as a single tag, so we couldn't
filter on "os:openbsd". We need:

   :avocado: tags=cpu:cortex-a57
   :avocado: tags=os:openbsd

>           """
> -        self.boot_openbsd73("cortex-a57")
> +        self.boot_openbsd("cortex-a57")


