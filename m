Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A87AC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 10:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqd3-0003IN-SD; Mon, 22 Jul 2024 06:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVqd2-0003C6-GU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:50:52 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVqd0-0008FV-Lo
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:50:52 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3686b285969so1769137f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 03:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721645449; x=1722250249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PN2oRhooOrosFKFvJdWTgpacvxKpiFQ+3KpU2AqSwOE=;
 b=dpITkosuVELoawqyT4vIlrfP/Mso+k3I95zU79IM7NQrvtBYSvDGg9Qc0lwTU7ICSU
 Pf7aGbn3KVL54GpA8MkZEQHkSzprdlLFpW29N001jQd78wEqR07M57z6QUBKpTFyFbyT
 4WkUOSPExz+Qn3LRZ9mQ4MoMC7Erw6Gc6B8VnRo/0B6pJt0cdxvEMwg/6T2PQXd6/5/e
 dNSN3wSdj9xerLop+YQlSOd+8sXwXFiVXk232L2F8KIKAIxIohitc6sKOm7rAkhfM9p/
 QJw7Hs/Q4KUV+5bZblZfRK/Fb3xHbW1ss9FDa9Zncoq/Lsv5tOadSIY65oOYtgLW2AfN
 +L1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721645449; x=1722250249;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PN2oRhooOrosFKFvJdWTgpacvxKpiFQ+3KpU2AqSwOE=;
 b=Fr+qsABArJoDmVI30U8/UD5puX1KyQbeNSyWldVDBhXIGIK5EuW2m7/nsl/0K6o3v7
 FAaGdv9S3Ch99AQPC3coeRlGXMptMB7mHWORy4lxD14M2im5y9zq+ZfTPKFeKg+FJku9
 qxX62DZQ/p2pgWLLc8SLkb7X2Ids9bb+FWzUCgIocDX27eiEXd8SUCV2N6SjD4YkEkS5
 ntoiLvJ2iJ2dJf/NrPSfbMEnSSDlJxeqf68jl2/kYZ2GZk5HESMQypOYNLo44kEQYXvD
 QDJW4jmVj3ncDCViR/fvXB83t5e0cTxwY5C/5/mTlcegAtBU1C0IiB497wFm/MuKwBbC
 UtVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGyYjiETpiePAEoLAJfB/XxnVl4CM1sWezLeo3XFCQuS2o7GF3Wa6pCy7gECZledwM3Cjqcb1PsF/RsF/H6AI5u7ECOB4=
X-Gm-Message-State: AOJu0YxmZj9RQvyNuuHzUdt4imFxQ7k4BJZ0uJzt8ryWdRN9xlKEH6/q
 xcLjdqHE8DwPSuXnik1L0xavyqDb1FDKBFnTH4Mg0Dkbv4d6SHsCqHVFCCTUe4w=
X-Google-Smtp-Source: AGHT+IEibaFNo9EMIi0x2i2qaGzLlQEWe219oabrn6FAI4x+ldS8SxEH2l4xJJaQN/H4OLPH4KH5uw==
X-Received: by 2002:a5d:5f43:0:b0:367:4383:d9b4 with SMTP id
 ffacd0b85a97d-369bb2ab66emr6002809f8f.56.1721645448831; 
 Mon, 22 Jul 2024 03:50:48 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ecbd5sm8146209f8f.100.2024.07.22.03.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 03:50:48 -0700 (PDT)
Message-ID: <0a3ab138-955a-4af5-8643-479075fd21e1@linaro.org>
Date: Mon, 22 Jul 2024 12:50:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/smmuv3: Assert input to oas2bits() is valid
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 eric.auger@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org
References: <20240722103531.2377348-1-smostafa@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722103531.2377348-1-smostafa@google.com>
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

On 22/7/24 12:35, Mostafa Saleh wrote:
> Coverity has spotted a possible problem with the OAS handling
> (CID 1558464), where the error return of oas2bits() -1 is not
> checked, which can cause an overflow in oas value.
> 
> oas2bits() is only called with valid inputs, harden the function
> to assert that.
> 
> Reported-By: Peter Maydell <peter.maydell@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA-H=n-3mHC+eL6YjfL1m+x+b+Fk3mkgZbN74WNxifFVow@mail.gmail.com/
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>   hw/arm/smmuv3-internal.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


