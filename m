Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D699C48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 20:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbRVa-0002Hu-Kd; Sat, 17 Feb 2024 15:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRVZ-0002Ha-6N
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:42:01 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRVX-0008UG-Sk
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:42:00 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e09493eb8eso3292047b3a.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 12:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708202518; x=1708807318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z0UqvPkpb9ecPBq7dVKSHXlt2oGkZD2BEKAVLZck7Z4=;
 b=VYEY5vTVZiQKnIHYvxTNVo5nsPNWTRLM/VPYmfrRlfdoDjdTL7NmFPPQASo1i9arSR
 QXaG6NecALxzAh9MWaeK2xXvbdGPHPmE3oCUQsLPP8rDQqhhDieq0Fq3H26SgsUQQbXS
 rFZPgV4fqIUvq10po3futZOCV8zL6PhtLVzitsX1hnwvI8cVTQxmLXz6uf+U7fZvv/3G
 S8ydYYjy0/n9h6O9vmkgbwXe0ZLVz3U0UHGbqV2yk5F8FVIQRriYjkrxHv8GntZ8HEnv
 hoLlmqwK5OL0G+PZe/kIfsUKrY3j81SapCoPYocCgU+N83Hra5wvIvv00L8O6yK8jWzV
 N2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708202518; x=1708807318;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0UqvPkpb9ecPBq7dVKSHXlt2oGkZD2BEKAVLZck7Z4=;
 b=pC6dpJwZUSlWf+myYRqlpKkPvvDxIH0Mx8xP11PhDRtYoK5Ruy8MPfSTNApbjm1Koq
 9UWRlgB/h6pL1YWFe/mqDfQZ3HvOJIc60JSt6WE44YcKfs1ler8balWPTSHb//pDt+WK
 95LzHNCyveh02QERmVG0LbrrKzjH0YJ3Rd515WA6+oZsWp+818/YJutmc6ncKgan5O69
 GTgMDCAkdE9VpudZjBvwCwLhID7AjW96LX3jxw0VlbxsDqT2sbBpUISCPkIWg6sOlouR
 o26HNB3OJRk4/DBGXTGXLV9huRZLIvK4FEZKxQNCy88RVlEyR7Z5ZE7iiTtSmzuZwpim
 PeMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGww34xQrQp3B3hzGEXBZen7Kz5MqIp8Tc1+rWd4Ux5TMyD7El1k3iYxPLG2FLz65ciK09j/tfHcV290qv6L4NvfWJbMI=
X-Gm-Message-State: AOJu0Yy40bh8mLt3eGTWbkeU5HSGuEEoV789KGUJihTtA9peG4b2pGIz
 MCea72QLbCFDC4zwW381LY8VY0wSzOOJ8CrcNCMVFhc57ZxjtNnW0KkCn8OLAHY=
X-Google-Smtp-Source: AGHT+IF+W585RP8//p3e7tK3fa/JyAfftPhcDrBHBY/IHS505gG6spQdGLAb83xueeaoYD4WmSxqrw==
X-Received: by 2002:a05:6a21:8cc1:b0:19e:cbe9:63b with SMTP id
 ta1-20020a056a218cc100b0019ecbe9063bmr11755465pzb.3.1708202518531; 
 Sat, 17 Feb 2024 12:41:58 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 n15-20020aa7984f000000b006e0651ec052sm2049388pfq.32.2024.02.17.12.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 12:41:58 -0800 (PST)
Message-ID: <9a7edc62-c18a-4d23-abc5-78ba11ae0be0@linaro.org>
Date: Sat, 17 Feb 2024 10:41:55 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] hw/arm/exynos4210: Inline
 sysbus_create_varargs(EXYNOS4210_FIMD)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240216153517.49422-1-philmd@linaro.org>
 <20240216153517.49422-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216153517.49422-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 2/16/24 05:35, Philippe Mathieu-Daudé wrote:
> We want to set another qdev property (a link) for the FIMD
> device, we can not use sysbus_create_varargs() which only
> passes sysbus base address and IRQs as arguments. Inline
> it so we can set the link property in the next commit.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/exynos4210.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

