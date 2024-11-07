Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF532D5AE7C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zIz-0000ZG-Al; Thu, 07 Nov 2024 04:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zIx-0000Z0-Ph
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:59:55 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zIw-0005NM-5O
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:59:55 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9ed7d8d4e0so102904766b.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 01:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730973592; x=1731578392; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jTMMTkC4Z4K/M0+uXpDCfhKM5aOC9BIavkRvvTWTvf4=;
 b=aoIg1jJjCkproJy+LjKrug0AKGZz3SXC/JqOdQhQUp2ETFdePAsbL5wcc4ZGQ93znD
 Ok+HYRqhJJEHPO4u/P2cZmIGGDCHASyOFL002L6EicpDsyuKEj7wrr6Yhnrc1KStVic2
 CXkji+IBot3eXnrHxmfrvDGtueelQ3QrsEyMVhkSkBaYUJbwgkFeuOO/2tcmRpZ+3WHv
 2E/wEkVi0bXS1g8wTV55U8JeiKNg6e5W0Sds33jymfn6jKZ7t2kWvSqlwzVYDAML00Tu
 5VJV9minapbN/frCc/VSOiMHVA6/A71p6yB6X9jhXqrGDvEAYCPI/ZnSGwitlIIC5f7E
 AAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730973592; x=1731578392;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jTMMTkC4Z4K/M0+uXpDCfhKM5aOC9BIavkRvvTWTvf4=;
 b=SJ4oNWMfohex/1Dmqs0bE0u37T5iekIpGvlGJ6ijn1LqBgfyk532XHa4BbprHg3pT+
 o5xJEBJ38IZAKn3bIRbuUViBQqqgPfULFppsS+33qVKTxGWpInKHrv7OaUrD5fte53MH
 yX5VPonspH2tWBjqM4toDqo+v7rIOQZ15jMqAgnRsc3+So4IqQmo86MRyxyAeRVPq1NI
 O2s8VUaL7XObjwbIN+whRf8fJJpP8ff+XnCJ+pBD6VXH7kpEadHfwm23lyfBKRS1GcXL
 Xn452pmgU7BjNwZEV5RhQXLyfH3UHI8gQWMa2zsMZXO1mpLrcZ4WerPURCw8oSF1iQE/
 DR2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp5PDIjU2Tnwfts0ioaQz4I0EW/vJ5jXUo+3J8m0u1Kxn0OM+fWQ+wsoXeDoZHMYgwMOJKcHRhFBVD@nongnu.org
X-Gm-Message-State: AOJu0Yyzk5YugP1x/eDvzRrJFt3v9Vz5W4b4lMi674RUyUQva9BxQlqI
 2biCqB5zmZmmzvE3Rys/NifTyf3VfFXEvI1I6SEwcPjZD+yJQAhvVJPz8Pj1+Yk=
X-Google-Smtp-Source: AGHT+IE0oWPO959yDh26k9QovRiKxj/4L9ukAlXgD/8OLJqiWGLan6dZ+pfvZz/TTcEKWYnkyIxxtg==
X-Received: by 2002:a17:907:9727:b0:a99:762f:b298 with SMTP id
 a640c23a62f3a-a9e655b92f9mr2212973366b.41.1730973592386; 
 Thu, 07 Nov 2024 01:59:52 -0800 (PST)
Received: from [172.16.23.118] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a4b5f1sm72897266b.60.2024.11.07.01.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 01:59:51 -0800 (PST)
Message-ID: <7ccd9857-31ec-4a68-8634-e0d8b79be345@linaro.org>
Date: Thu, 7 Nov 2024 09:59:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/i386: Mark devices as little-endian
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241106184612.71897-1-philmd@linaro.org>
 <20241106184612.71897-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241106184612.71897-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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

On 11/6/24 18:46, Philippe Mathieu-Daudé wrote:
> These devices are only used by the X86 targets, which are only
> built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_LITTLE_ENDIAN (besides, the
> DEVICE_BIG_ENDIAN case isn't tested). Simplify directly using
> DEVICE_LITTLE_ENDIAN.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i386/kvm/apic.c         | 2 +-
>   hw/i386/pc.c               | 4 ++--
>   hw/i386/vapic.c            | 2 +-
>   hw/i386/xen/xen_apic.c     | 2 +-
>   hw/i386/xen/xen_platform.c | 2 +-
>   5 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

