Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DA5C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 09:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfyrO-0006d4-2Z; Mon, 19 Aug 2024 05:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sfyrL-0006b2-UV
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 05:39:31 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sfyrK-00070v-3U
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 05:39:31 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7a9a369055so398746466b.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 02:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724060368; x=1724665168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WZR2wo7glRF7OOI1Qdgt6BsZQnmRkJxP0gRiBjk2BGo=;
 b=AauJ+bB05BK1cn/nyopGUwiBODD/FY9VEto+8OVIAR9nwEE+GEgAyOFRpJl6TvmKd/
 WJD9NiVjXT7t9o8PQLP42kRvBL/dYAcXb+FsHQF0PjnCI2jvlxPaWu0mugFAh4BsNW0B
 nkGCO4s880twmjlNEm3TolhQXnG6KZRMbrZ+MfL9Sb8/e1OTTpI6SGaFAwYYcRbreUCg
 StSQsJ6xjEgQ+uusMrWKqimjBZPuk5cuMENb0R27SGGoQhUuu6Vyv1X/TzlmfSMeGpIA
 YIFxVYtWejOYBFAdVpYF6WbkUW+fCmEpaAluA0qhyq3wxvDR5UUbf0d/L5pXwPJuJ96+
 7HWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724060368; x=1724665168;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WZR2wo7glRF7OOI1Qdgt6BsZQnmRkJxP0gRiBjk2BGo=;
 b=w5GHVe7yT2IMT9vnurjMACn3LpMsd2+pLLSS0UMNGijv+Ub72g7h7+bypki7hWlwrY
 3Ee0AnyZEyEAiRWYv4Oi0WWtsZXMJ0iaCdzhpEmMQRboXn51Wq9wcKUcfRXsHf1rwXLu
 3LzxaQoGypoPYwkqHa0XkA6X5NfOWDSLN8xUyKvydUP9BDh00wJyr+k0kz+BsoshPihj
 yKDGl7lFvfI9JawedZXFcEK1MBeuftf8qJCyk5/TIPzkpQBhIviaeTfhulA4h0Q2JLWD
 yzJujGJloXZFf7PUdH6fYqi0P3mLGbz9Pd6l6JK/OVzhyrZFQLXdhUq6Xsdf6yL1j+ri
 zQGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgkk2RNlf/tGIlVQki1nOWj3Uhe3vOJ3aUlgQ7H9Jv29du3wHAS1gJO3Cao7E8SxMKy8YtOZxDr9DnqU/NUwVIeSbVv5g=
X-Gm-Message-State: AOJu0YypirakX/LaWjnGPTb45g2jINvqE2Bx8uoDlpyAlGUj4F8UAmAH
 +w8T55V2LLXWcXveKeEoYLF8P4tEW9cYIYpDQPl1pJkwrmaCD6qBxMyCJoeofvg=
X-Google-Smtp-Source: AGHT+IEvn/r2uTFLA6ujjReVrzN7OE/8NR9J/fYE5LX2QB/s4lWj+DTrUrVDWMTDb1MST/V43kr4dw==
X-Received: by 2002:a17:907:868c:b0:a77:e48d:bc3 with SMTP id
 a640c23a62f3a-a83a9fed300mr514263666b.19.1724060367333; 
 Mon, 19 Aug 2024 02:39:27 -0700 (PDT)
Received: from [192.168.200.25] (79.186.29.241.ipv4.supernova.orange.pl.
 [79.186.29.241]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c687csm607207166b.9.2024.08.19.02.39.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 02:39:26 -0700 (PDT)
Message-ID: <454683fd-e40d-480b-a767-8cee95fc9624@linaro.org>
Date: Mon, 19 Aug 2024 11:39:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/arm/sbsa-ref: Use two-stage SMMU
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Eric Auger <eric.auger@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>
References: <20240816161350.3706332-1-peter.maydell@linaro.org>
 <20240816161350.3706332-5-peter.maydell@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20240816161350.3706332-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x629.google.com
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

W dniu 16.08.2024 o 18:13, Peter Maydell pisze:
> Now that our SMMU model supports enabling both stages of translation
> at once, we can enable this in the sbsa-ref board.  Existing guest
> code that only programs stage 1 and doesn't care about stage 2 should
> continue to run with the same behaviour, but guests that do want to
> do nested SMMU configurations can now do so.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Yay! Another step in getting (S)BSA ACS pass done:

Operating System View:
  304 : Check SMMU S-EL2 & stage1 support          : Result:  PASS
Hypervisor View:
  352 : Check SMMU S-EL2 & stage2 support          : Result:  PASS

Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

> ---
>   hw/arm/sbsa-ref.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index ae37a923015..396abe9c1bd 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -621,6 +621,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
>   
>       dev = qdev_new(TYPE_ARM_SMMUV3);
>   
> +    object_property_set_str(OBJECT(dev), "stage", "nested", &error_abort);
>       object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>                                &error_abort);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);


