Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4399C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0Ln-00046F-F6; Tue, 25 Jun 2024 03:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0Lm-00045u-2h
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:12:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0Lk-0008BB-Fh
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:12:21 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-361785bfa71so3984420f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 00:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719299538; x=1719904338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=raG4cteYJraVdb7UcG9T/DTMnavOPjxxWaC9g1jlx3s=;
 b=zdyC7m2bNcIh38mwiMerj7xsmiW63h8cQPch/lnAx8wPDI7URFS/v3FVfhNiwwtCLO
 T4/1F1tvYFNBh1tzEYDMiLgmGSLH/Uo2IzcqTYVzpAUt6ef1l5IL43lo+N4RXeJ7eb1S
 MBin6VCR8hgE+UMprH1z0EP97oYoiBI5zNOZQBRADQhdc9wqULC8YeC6//RUQRGy8LmO
 ULcWLaeUlAB240mvXkpzGgB5DgPKi6SXUEhZ9ThMc3MxlOoAyj5DrE9FKBNDBD1TAsPK
 DG4velSAKaDzZJHX0PpNTzM/qNa3EIcNNoeqTUKHaI9VkDgfPePZKDwXnOPQcv5KYxrh
 ufbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719299538; x=1719904338;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=raG4cteYJraVdb7UcG9T/DTMnavOPjxxWaC9g1jlx3s=;
 b=tOKzbNYIzD6nrgEYFCEaLgvUXqWALRW3LUFs4nbxJG19HlaTpC+iPqLIfGOpa2REvT
 FJufvrcGEWAXsruD3KAos8/oz2MpOhGII7fPky1J6NX2m8KWh/yhz9I2nDDI8xzTX2LB
 B8BNLZ4P3gsRshTDaaLLxXyyRSFPs6Xp76vCQi339Bb/WGImtYMVWQDOXJ7lqKzLrmg0
 Za4ibUszB29bVVEGiFb5DJfWfTNLbXiXKvipNGz3zZN4+ldoAsEZ2ESxtG8ph+tGN2mu
 +ZkqmEnr7j8n7zue/HysbD5Iob32VbDdVWSHuVS3qc9uffKUoJ38HpZetSJfbXnKTu3S
 7yKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzKxJm/QEWiOs3S9VmnOVjSMuxFZgzrAdsZzv0JMz2Q86KO6MTNLr/UP88fIxomMoaDLkDKRFVFwaxKGyvL5ubaIJeSSo=
X-Gm-Message-State: AOJu0YxFqTmRGrrcyUS6X5Q0sVtaL6vY4VvE0VbMHwfK/t/lIwuTfov+
 H9cTnVaBekUwkqquo7e6WpAb5TuUutimu24Sm03L/8wcdib7xRK1x9EB/f6bW8roURH6Im1Vfea
 /
X-Google-Smtp-Source: AGHT+IFpKqU78m5wHvOiGfR1hPWPeZdIpOztmd7M2qA9wsoWATRWe8frUUYWpp0Ouys1sxPfsgZuDA==
X-Received: by 2002:a5d:694c:0:b0:366:f323:f59b with SMTP id
 ffacd0b85a97d-366f323f70fmr2892417f8f.1.1719299538417; 
 Tue, 25 Jun 2024 00:12:18 -0700 (PDT)
Received: from [192.168.69.100] (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663ada00e7sm12058484f8f.112.2024.06.25.00.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 00:12:18 -0700 (PDT)
Message-ID: <a9283599-403c-440a-9880-05fb382162a0@linaro.org>
Date: Tue, 25 Jun 2024 09:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aspeed: Deprecate the tacoma-bmc machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
References: <20240625070830.492251-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240625070830.492251-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 25/6/24 09:08, Cédric Le Goater wrote:
> The tacoma-bmc machine was a board including an AST2600 SoC based BMC
> and a witherspoon like OpenPOWER system. It was used for bring up of
> the AST2600 SoC in labs. It can be easily replaced by the rainier-bmc
> machine which is part of a real product offering.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>   Changes since v2:
>   - rephrased deprecation reason
>   - remove extra line in docs
>   
>   docs/about/deprecated.rst | 8 ++++++++
>   hw/arm/aspeed.c           | 2 ++
>   2 files changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


