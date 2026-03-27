Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA9110F285E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Awg-0003md-3P; Fri, 27 Mar 2026 13:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6AwI-0003b8-Fx
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:25:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6Aw9-0004zc-JP
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:25:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-486ff201041so22008925e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774632331; x=1775237131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zI5QaXTnIOjlK6C/SyEx+11Jh7bNJ6caAxTn6y9A5qE=;
 b=NMquCroV3eEZAfWwZx8i+p/cHIdltVspA9+tBUYqLF+0C98KANyhxO38TC0GgQ/arp
 tW2e1zeXosSyF1z9EULoOtMPnJO74fAYmCDdHm/BrBvqX4Oyz+IoIbYNIyLuu+5bfauQ
 bLSXAAG/wiQvi+nSaVj8d7fILuNzrJyRSi33MNqHf05rUtNxmOuq2o5++pXSexl97djf
 DpmxJGZLJaUzcOQTUq7w6yaPJcKG9vlEl1ewAmVrU6grVPuGZkGCeW9tUJv28DjUV3iy
 x7QqNcliIVqDs6h2Ub7t5XkrRq0On4x9JM68NV6kqzzHkQdtrxR0Ny/GxLVvlxpPWUcC
 5D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774632331; x=1775237131;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zI5QaXTnIOjlK6C/SyEx+11Jh7bNJ6caAxTn6y9A5qE=;
 b=WlMC/1WZXPaIn6qa3NdqRe8Z8yux9e8Oc7m8x/h0axujb864mPGQa3Vb6Efwi92ytt
 ZpsJRc6tnZRm2VY7qMieHqzdIXTwsqCquQlA183vkRHFJe1kE6t8qVCMHqWw0YrtCfaq
 JTMX5qjezphN8oFLd+/J++ywgqrl42rslpYIHP9lTiBEeY1LS5QPpF/APYSf03NIdoPh
 UWnZWVtuGhLnZaAUPHzqSgXr5gXtmLoUpsXpSmIIQ8tdMi3nyWXFeJTkVrrM41EkKEmZ
 1VWt4RZlpGctqxBWSHVC8KulnFu1+OF5QdMbbWyUE+Qljx5iB2VkTsNuHVlCH1R3TStJ
 /wCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR0aFX7RK+zsQbm7LqX+mZkd2xRLpSIUPIDXM+PO4Sl1jogVtmcck2b71PhZKadZNdymI7A3MjpGzm@nongnu.org
X-Gm-Message-State: AOJu0Yw33NK/owIPvKGWmZqfcD7WdKJ5JBRoTjJLEvf19LgM6OaDZf2c
 tirlio83Z0Boihs05rFKU+Sdq2OmRz8jEpYt3ENWIpCZQbowq8QNLniGPkVf/02x+M4=
X-Gm-Gg: ATEYQzzMEsFZuvtByk0SOx+3AjGDPFgmW1PeSsc39HLmheA0VbuE5BBnjcRGhpzm5uZ
 16GS8akocQvfaeNBC6KW5rP48Gmyzc+FhWSozwQN/iSypCb3Qi+dV1XXDGYZp3Co4o28EAYbE2a
 0cAuOE4cbO0sTqfvprC7DvrlT4XAWmDbCUpxWNFO6OEUvsfnDDk91e3w6gTbsLeQSka+8IVOchs
 jBQotf5rQ9SPVPuVOagbVVp3FA2BrzHBSM9WIpnAq130L/16WRk5fVMYJVp7trm63x6zh4pRQRq
 1GCKRAPWS3fhd9bfK2eKBPKq2vJyKPpM673rRFvYc7Sr8+qIpRzhbU8BMmvMO9pKuT0pzTNfEyF
 6jS8BWe4nmeV1yrlXwN1Vpwq0hfOrd+ebogtweEb9zVabizroiHT1QEPlYH6X1giOHxBfky4QaI
 enaDYo4pEB5mPSFFooZqTEvPBxtk2KDnvAQ95Ap5/yD7VXlEqDrwJASG0c3JF3NQ==
X-Received: by 2002:a05:600c:c113:b0:487:1114:d431 with SMTP id
 5b1f17b1804b1-48727ec3c36mr44225875e9.18.1774632330689; 
 Fri, 27 Mar 2026 10:25:30 -0700 (PDT)
Received: from [10.202.147.66] (109.243.130.77.rev.sfr.net. [77.130.243.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919df6d4sm15724356f8f.25.2026.03.27.10.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 10:25:29 -0700 (PDT)
Message-ID: <c9559814-8cee-4ec9-bb20-3555054851f5@linaro.org>
Date: Fri, 27 Mar 2026 18:25:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] target/arm/tcg/translate.h: remove TARGET_AARCH64
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-5-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327165042.604105-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/3/26 17:50, Pierrick Bouvier wrote:
> We need to stub a64_translate_init and gen_a64_update_pc.
> At this point, we don't need to do anything for aarch64_translator_ops
> since it's just an external symbol.
> 
> We can now include target/arm/tcg/translate.h from common code, since
> all target specific bits have been removed, or can be specialized with
> specific defines.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.h | 10 ----------
>   target/arm/tcg/stubs32.c   | 17 +++++++++++++++++
>   target/arm/tcg/meson.build |  1 +
>   3 files changed, 18 insertions(+), 10 deletions(-)
>   create mode 100644 target/arm/tcg/stubs32.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

