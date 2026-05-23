Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0EBCD5BB1
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 12:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQl8J-00071H-Oj; Sat, 23 May 2026 08:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQl8I-000719-I1
 for qemu-devel@nongnu.org; Sat, 23 May 2026 08:07:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQl8G-0002aC-UX
 for qemu-devel@nongnu.org; Sat, 23 May 2026 08:07:10 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso45495445e9.3
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 05:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779538026; x=1780142826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PV4RnEfpUJLzdgXHCtEydVhJ9hmvdxbiFs2e/GgHLDQ=;
 b=lHVT1k9KF4jMXiJkwkR6Rt+/ARB+AUtX3s8TKy2Tg3nMlVdHXe+AueXRjsF4nzbwnh
 xSW4zIGpihfU+ZZ0QlFFLE8WKeK0mBTFSNCQH2xPstQMkG+usWTV1Mo0OHCZllaB7Bal
 bxXDVIyOCd+CMoQM6CYC7tXxVqFKTL3M6HuqmjQFCIH7pWNbwi6TYxAaDqtbEHcXiKcf
 D7PTqC2A/o5ecMNbMXJOHFOTU5EbClWg3XeYUCEyA6Syxa2ggxGX2w8wt6N3nNvJ5hmT
 xgnz4H+6EXM2vR2f8YLjlEM+V8MDvHsBW74Q/SG4fogJ96DaKRrK0Lw5hlDb04uWLD4o
 X/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779538026; x=1780142826;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PV4RnEfpUJLzdgXHCtEydVhJ9hmvdxbiFs2e/GgHLDQ=;
 b=El5BSkaQ+zeIi6AQlxeV2sIJUVe12ji5NVCx7LY4nqa4CXeiLseKWhD34wagIZAQYG
 Vwy3DTqg+iAFksHXCUSi5e2UdB3zVQNORfvawrUxEXuNGebxaPY32EKcPdOcqHLt2SeY
 wRfNW3BnPQVj2fl3jT2gewPou0LsZ2okuvxPJToZP0cfQr2nQjZPKwt68VMdVI9mcZMt
 LyKbS5dGIGvf4lRarZoJ3EBsGnO4N1frHUzk46S+yn9Lgu+7EjC9g2sMZ7n3W7NaaCg4
 5TSX9UwBoq0GNbLvu8bOjcxoxNNw+Ia8f/mrBKpJyolwoD5ZiV9gq7jicvgeaGSRj9Bx
 +62A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Poa1vDiUPL1O4meJo9gZKgTciMaVWgP7POksoFVaWfm+vgkHz/Brgd8/hxH7vwUYaEnZQ/DIz4mOH@nongnu.org
X-Gm-Message-State: AOJu0YwCYGyVtd/hNlc2Xw8go0kEvLvhohsgIARiGtuiChHq3GSluasD
 v7ayTXzjGDAlhObBsN+qSc1akyVgNSpDIjGFv0jPacQBWOV2JifF1cGKbUDn5RbtCLw=
X-Gm-Gg: Acq92OGG48p3rNMpuLIorB5nGf4WqQPsGVqjDz3oze1bw9MJI8vFWaB4ViU1XuV08wl
 8CpsQcePKvOA8RSZ0txEOcucdXjL/Kx021l0RuhlsUsqiRApyz40F/Aj9Bun0RvnyZ7Jl7OH+iS
 qUZbsvZITkrzyXubNiNJ8bv+eK86AWwFDvwHmCDUQ0EU0Jg3RcY2Y1QozXygFe2cn4lPIilnFr1
 4BJe64kSRF+PVrqf2BplDHi6FN63Obq5hRsQdLkpYlbt58fzq9IbRqtC8voUUsbiYe70sNBTHn+
 lwEgT5dSSvK1577/exFvr5MuGvc4wYgoMGj3WIVqq+0qEI515wMLNEZkyxZSqVn5UolElLbzhGM
 G+LkqhXIeecpmixlO28K7e7LZ+LsLE3GYWlaA3MwPNLByNwIB25TN9/mUpdM+1uA11MfvnyOm2b
 aCjDAOQOA/gTWc/n2fjRuWqoZYu1/F+Co7ACYzOCcGu1yuwmNXSlww9H+uIbXb/CoduikBcYwm+
 gk=
X-Received: by 2002:a05:600c:5298:b0:48e:51f8:eb39 with SMTP id
 5b1f17b1804b1-490428e0b24mr114705995e9.28.1779538025970; 
 Sat, 23 May 2026 05:07:05 -0700 (PDT)
Received: from [192.168.1.117] (88-180-58-130.subs.proxad.net. [88.180.58.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045282201sm123887425e9.8.2026.05.23.05.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 May 2026 05:07:05 -0700 (PDT)
Message-ID: <4b7c4629-e77a-4d97-9b90-a19060471a2c@linaro.org>
Date: Sat, 23 May 2026 14:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/39] MAINTAINERS: Fix F: in "QDev"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-31-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521080511.999266-31-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 21/5/26 10:05, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we moved qdev headers from
> include/hw/ to include/hw/core/.  Update it now.
> 
> Fixes: 3775d19906 (include: move hw/qdev-clock.h to hw/core/, 2025-11-27)
> Fixes: d1000ecae2 (include: move hw/qdev-core.h to hw/core/, rename, 2025-11-27)
> Fixes: f7889f86bd (include: move hw/qdev-dma.h to hw/core/, 2025-11-27)
> Fixes: 78d45220b4 (include: move hw/qdev-properties.h to hw/core/, 2025-11-27)
> Fixes: e1e9a72500 (include: move hw/qdev-properties-system.h to hw/core/, 2025-11-27)
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

