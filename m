Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F35DC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 22:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rddzS-0003Zi-Ia; Fri, 23 Feb 2024 17:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rddR9-0004Mo-V0
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 16:50:32 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rddR4-0000kC-IR
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 16:50:31 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5a03384d67aso697832eaf.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 13:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708725025; x=1709329825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R+kqVhz6zPOGLRJQmu/yaid8WatTjhMmtCkTPkb18Hk=;
 b=Spu6q+ZQzAVkeFOso/ZSRQ+PMb204Ks0SjYqcrseH1YHMvujSC43p8X2HSClNjd+Lm
 vBJHLGzEJMEeyqmUtaRSS9dLV4GyMLZX0OqEmTQjbxlzSkYhISO9LDFbxOi/FdrD5jWy
 jIjz/z8MhTl6zD7An/GrzOsOvAzjLG5aXmcNY1X8T9emyLq6PG5BFZlBYckBOJzHu0D8
 qDLWngMmhgesdNIqr+yQ7Xaw7yMoKJVKp5wi9xWJr8EJIhLU2t1/zCipRIWc/p7guG6K
 CotGPHFmEx7HbS3Yx/jpBRysv4BGVJgNhLLjNVeHOslCsOnESMDFMjFNDxlzK5kAe+bD
 JYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708725025; x=1709329825;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R+kqVhz6zPOGLRJQmu/yaid8WatTjhMmtCkTPkb18Hk=;
 b=OINs0UuB8cM3EwVXS/odqnsj4zMktUwl/g0f4eJcYz+/qEJnxsTHPS7m9jVE2u+ILx
 n3iyjjP4vC4j37uWNDHhL6L/7A4wl34438WIH19VkLKFfn027Z1wwBG2yLa0WI0vBrZr
 9hKgF261aOwQxI4mYvAmBsYSoWe08FF4UtUuMZU3Uzn1j//34IYSPZTS5ySMa1xXVJby
 kg6vlN8XoODElmd2EyoZPqYQYqUHBReOoQd1cUiY0cjIBKkd8/oVXHAr9m4EzeNCuk0y
 lUVuLWzVEv5ZG0Jj+yN6je2P2y1hhVibkq8EfHerUO3KcTWHdBgSdLET/f5gXo/5rdvf
 MlEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOeM9bCdJ2haoZHnSLewi1N1F/+5DeP2FBwJ9Nv/vH2ERXKaGvvpoimVryqQNBaxQBTkFG5fRTFPGS7EVoq3vHB45f2UE=
X-Gm-Message-State: AOJu0Yx8ua6jeu2BxOMlL6F1E6D9ilvTReg/0pAfb/n8cVaRqw5VJVZS
 aAH84h7sWEVQbp+o/3UNfnRbu59DjZ6MJSsBha11fkBcsR/JJ3iopZ7GUpGONNw=
X-Google-Smtp-Source: AGHT+IFsM8gI2kWo/O3B64aDGmZ1IZEOqR/Q3bq5aS/jKIq2QpUyXOiQZn+JdRtMmYKNBu7PbejwIg==
X-Received: by 2002:a05:6358:483:b0:17b:335c:fa68 with SMTP id
 x3-20020a056358048300b0017b335cfa68mr776291rwi.17.1708725025159; 
 Fri, 23 Feb 2024 13:50:25 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 d188-20020a6336c5000000b005dc89957e06sm12691396pga.71.2024.02.23.13.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 13:50:24 -0800 (PST)
Message-ID: <73af6d15-17a5-4dc2-8eac-b0339e3765ba@linaro.org>
Date: Fri, 23 Feb 2024 11:50:22 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 21/21] hw/arm/virt: Add FEAT_GICv3_NMI feature
 support in virt GIC
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-22-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223103221.1142518-22-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

On 2/23/24 00:32, Jinjie Ruan via wrote:
> A PE that implements FEAT_NMI and FEAT_GICv3 also implements
> FEAT_GICv3_NMI. A PE that does not implement FEAT_NMI, does not implement
> FEAT_GICv3_NMI
> 
> So included support FEAT_GICv3_NMI feature as part of virt platform
> GIC initialization if FEAT_NMI and FEAT_GICv3 supported.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

