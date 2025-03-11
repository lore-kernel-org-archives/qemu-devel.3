Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1839C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3jS-0002dK-9D; Tue, 11 Mar 2025 13:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3jI-0002Sl-Uj
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:49:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3jB-0000xd-B7
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:49:24 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so111934125ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741715353; x=1742320153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6KXK5vxubErb1bQ7k58GZF2PimqFKqHY9iN3Bpc9e/s=;
 b=UNkmPZ1blG52056bSBuNUGQ9k5/bSE03CtKdZ179e+B7FAupBAnBaPSgdmYXYuR+bf
 m2p3qSZTVXAvFgCsVC28SJQBEkwe1DMnnMZsSB8WhisgzZAzkcHiiCgkeDWcERcuBfIs
 Tdw5r0gMqx+ckKWXJ/2YExqIeLW++yvXKhWJi599ZaH/q3MQxa37nc9CxAw0JE3kas0X
 3MW9F7TDfdyGEQfqWlprVOAw4WZN2gWuw0KBCubK3E1BQvTJQOxRbzSUneqD/K74E6Ts
 U+oh7i6mBeUPIiJ4InV9PZ1Re8DFP+d/218VbBcngc0ZexFgBeRJx8QbQMFWNZ48H/ca
 9nnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741715353; x=1742320153;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6KXK5vxubErb1bQ7k58GZF2PimqFKqHY9iN3Bpc9e/s=;
 b=Dh5RmXUJHREcIzPvC5i3X/dM9738i7EaWl9ctmh2sGaVWLBRqwyBEhb+dWhlSQEH8H
 u5yjZgEsAwfaSPYpsNlPD9AbaCx4U4VddP9WEffciOM4EDZrXEbWmv5mMoRbpnUJAb42
 Q55d2p7sDWA11RvXIj4xkItXsGpoXmjNBPRY/f17TqDTkQ3MmJGEHkQNLCgY8cu+ak4m
 DJdM991/uolcgqV3VNQA67tlK/qo+A9Qj1lvFM30VF9+VDou6O9uxH1+gDZ4Of6KNXK/
 Agss6oeZ5QKgS9ITTwjFDCqC6KLu2ePbGgoWaSYBmf9TjazRtGdCOOMwBtD8AkolQiFg
 YjsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfLoXXXe8O+JmZ5tRzz89JEbqQWh5vk5SxxQbOq10RI1R6dFF0CAitSWqztyrQBVu1VuNF9wnn026Z@nongnu.org
X-Gm-Message-State: AOJu0YzaIExZ15Z4oM5/S0lSML1MQm+XaeV8NFC7NVkCv37joVIuyxlw
 fG9xgvhZBpujRlhrU4yXlInESAxTBpujqHZk1WybXwAS5rIjkI/yABPoyIGAoKQ=
X-Gm-Gg: ASbGncs5XmS7QAti00TvyyVSt23cUmOPtc7S+jCH0DpuJC3INdQyShGOun/PUZikIDW
 zDtTgpGWzQFLOjV0ECMQJ4/s4LOUsl62uscxx873UMv7vneHCi9g2tsFf5CRlvpmKa7vV6Lwf4T
 6zFqVRDa264rfxnN8xwO+5laewf+yiLSosWN+bNad5uO3uwNjlqBJSVqH84QzkiAiYDaar9+ygo
 X9LqEWEu6P9Q2PvhQgRMXw4jWkrfCKwGamn18SF8H4WjcKyTcv1MGsZkAe/mkgDXLo0tY2vzhMa
 o4B+vzs6D+qWgJ3XBbvdz8uMzYM9MxYoAoGOuCtvWaLYq1xOkzlzP+gZ6FxvZOew/p+1iGwO4HR
 Qdkn0kc17LWvMtImlegU=
X-Google-Smtp-Source: AGHT+IHvGnosyQ5H3D9SAurD1rtaShieHPQhACgGjD3us9Mlon8RnnjMV9DHO90fzHL57LRgBwE2Ng==
X-Received: by 2002:a05:6a00:3e28:b0:736:4e67:d631 with SMTP id
 d2e1a72fcca58-736eb8a17c0mr5885147b3a.23.1741715352590; 
 Tue, 11 Mar 2025 10:49:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a95af6b5sm9232424b3a.81.2025.03.11.10.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 10:49:12 -0700 (PDT)
Message-ID: <02e4ea65-1619-4dfd-a85a-f4190863d667@linaro.org>
Date: Tue, 11 Mar 2025 10:49:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] arm/cpu: Store id_isar0-7 into the idregs array
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-10-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311162824.199721-10-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/11/25 09:28, Cornelia Huck wrote:
> From: Eric Auger<eric.auger@redhat.com>
> 
> Signed-off-by: Eric Auger<eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   hw/intc/armv7m_nvic.c     |  12 ++--
>   target/arm/cpu-features.h |  36 +++++-----
>   target/arm/cpu.c          |  24 +++----
>   target/arm/cpu.h          |   7 --
>   target/arm/cpu64.c        |  28 ++++----
>   target/arm/helper.c       |  14 ++--
>   target/arm/kvm.c          |  21 ++----
>   target/arm/tcg/cpu-v7m.c  |  90 +++++++++++++-----------
>   target/arm/tcg/cpu32.c    | 144 +++++++++++++++++++++-----------------
>   target/arm/tcg/cpu64.c    | 108 ++++++++++++++--------------
>   10 files changed, 243 insertions(+), 241 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

