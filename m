Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064B3C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM04M-0004q9-E2; Tue, 25 Jun 2024 02:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM04L-0004pj-4B
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:54:21 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM04J-0004uu-DB
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:54:20 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ec595d0acbso27645111fa.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719298457; x=1719903257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UySjzv+2JdHEvnpXeR3HI1Rtg6290dWP+wYHzkrUzmU=;
 b=FP1HQ3JI8FcoJB1fquAjpoqc8rsSySKLK9EUENTQZ7S1lxlMY5rtjY9ABLRXJDyADG
 1MafUP/IfiUvBIXFfp3nBipLA95zzWZcLppfx11TECWayfHTmVzLI+xMPeQPKiJlurY+
 x3UT3Mw6hIxr74SMaFM8J3jSS9GSaa6c8CX/8M7hdqpoocxnzAnAk4LtEprIcdmqN6FE
 dLT+DOs3GGQY/1EGaBPRYeeaujk719Pw4HoJMgSntDSuwSdy3NnFYPAC1xdfZ0XK0jD+
 GgxLgGJgE/S9cx1DOFzXGrSXwWtIfzOceg6RiedACzKAPGCsKA7UakqktYzhZx7lWXw4
 agpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719298457; x=1719903257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UySjzv+2JdHEvnpXeR3HI1Rtg6290dWP+wYHzkrUzmU=;
 b=DTXRFnaxaA4uhY4uj3JX+bNs+R6aV21i7o1qlQcLfXc33YOY2CGq/BwSFJO5vRyuhT
 YTr/JiqE2bbQkJ6QUCjhMENoN5aOLNS8SXEQB+piKLZtj/BaGB1Ftwal+/oKz5VuZdeg
 +TNGI5roTOdOUeqsilPnkMmkc0054oxDuvlkVowCevqA8nhES7RevfNcEV1Q3wYdgZIF
 OtAxQDMLTOADMHDZHz+y3RjSgCFQk4B1V04YDoiBFHN4Y5Ngipnj7PQhooHo0VsWyS4W
 zRDWHDl9JsUIySBlLeJnuAlx10NCJelqYthpkMGQaI4lngAgAcxlRtzEe+D3lGBDWSlL
 OHAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2BgEIXA39WIsupVxWxUKum5qY4Umi12I0E/+Fmt4we1txz8x0iFz7qR5jSUFxS90mc28EGFhFmbrbwIuScBakvyiegYU=
X-Gm-Message-State: AOJu0YxU3w9qBNJ56t1Unf9zGbpeqYjF6Nvkr7Z272glXIn8djK4HDhq
 g7JHUMk+m/gU6rcPMdo7cwkr+C33HZSt0kIHV1FtS4lR1aipL3J0Nbn7NkBeZUk=
X-Google-Smtp-Source: AGHT+IGv3ef8S/3zoTLQ+Qw1/+pvY2LGqSODAv4vD9mpSFtmdAKRqzSV3bdc8eA+z9vpualjDixHKQ==
X-Received: by 2002:a2e:a98e:0:b0:2ec:5d83:32cf with SMTP id
 38308e7fff4ca-2ec5d83332fmr56099721fa.34.1719298456708; 
 Mon, 24 Jun 2024 23:54:16 -0700 (PDT)
Received: from [192.168.69.100] (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424817b5554sm164195525e9.26.2024.06.24.23.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 23:54:16 -0700 (PDT)
Message-ID: <e4571375-e659-479e-a4b8-00c82b227417@linaro.org>
Date: Tue, 25 Jun 2024 08:54:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed: Deprecate the tacoma-bmc machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
References: <20240625060927.440589-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240625060927.440589-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

On 25/6/24 08:09, Cédric Le Goater wrote:
> The tacoma-bmc machine was a board including an AST2600 SoC based BMC
> and a witherspoon like OpenPOWER system. It was used for bring up of
> the AST2600 SoC in labs. It can be easily replaced by the rainier-bmc
> machine which is part of a real product offering.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   docs/about/deprecated.rst | 9 +++++++++
>   hw/arm/aspeed.c           | 3 +++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ff3da68208ac..3f036c79a45a 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -256,6 +256,15 @@ images are not available, OpenWRT dropped support in 2019, U-Boot in
>   2017, Linux also is dropping support in 2024. It is time to let go of
>   this ancient hardware and focus on newer CPUs and platforms.
>   
> +Arm ``tacoma-bmc`` machine (since 9.1)
> +''''''''''''''''''''''''''''''''''''''''
> +
> +The ``tacoma-bmc`` machine was a board including an AST2600 SoC based
> +BMC and a witherspoon like OpenPOWER system. It was used for bring up
> +of the AST2600 SoC in labs.  It can be easily replaced by the
> +``rainier-bmc`` machine which is a real product.
> +
> +
>   Backend options
>   ---------------
>   
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 40dc0e4c76db..823faff36a81 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -1379,6 +1379,9 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
>       amc->i2c_init  = witherspoon_bmc_i2c_init; /* Same board layout */
>       mc->default_ram_size = 1 * GiB;
>       aspeed_machine_class_init_cpus_defaults(mc);
> +
> +    mc->deprecation_reason = "redundant board. Please use a similar "
> +        "rainier-bmc";

mc->deprecation_reason = "Please use the similar 'rainier-bmc' machine";

>   };
>   
>   static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)


