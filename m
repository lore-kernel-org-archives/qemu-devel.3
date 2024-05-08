Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56222C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 14:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4iJv-0001cR-U4; Wed, 08 May 2024 10:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4iJt-0001c5-7r
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:30:57 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4iJq-00026T-DB
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:30:55 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a59a0168c75so1173511566b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715178652; x=1715783452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qJeX4PTvGBUc/QZ27oUBczxM8HKxjR/gxBCc/BA1cII=;
 b=oRuU8YMA02uZeS6ieB4/8e1HSfB5yv3jZvof02kZgCz+o6ctuzTI8WzL8xwGGDkLCU
 Xe594qUihhtx+2qvSvwwP3vrTJ7TvQa6gDpjtWL1+OF8RlT8nveTV8GMaEpV6Y16qWVg
 lzU/v3QvbsQc6o3z2CBqLseBQlu9uJLH3hNlhEuVA/nj5F1JBiXO296jrW2DzRYdooc7
 cjS9PDhdsNu8WxEV8Eo+93XVYf14Bb4rOMNuN1nx9aI64Kw6NjXN2sj7J3pXj6KhfcJf
 ZQNamzKqnPMN3rrAefXfwhyTiAppeaVnJ6Kp8NZowCCKgK8EQA2NJXCk68jYYsigChFN
 sjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715178652; x=1715783452;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qJeX4PTvGBUc/QZ27oUBczxM8HKxjR/gxBCc/BA1cII=;
 b=KmhYxkRUIMQssKpd3mmEcG7f39EpHu6j8M79nQWUHq9ZO5r8I7l9PnIrq0oFgI5gEk
 MXRrir0nEWsNCwAzVO8tmjCuv6KX4OWZwGytw6jiQ0rRcqxuwfH+q1uwDetudI8Wl6fL
 TVBd1S8GaWwmSbC9JxvDxIw3FZv8o72A5Tj841AayUeETFx3ZesfrWZsguvXhHNIe0kZ
 xSW9UhVov9PFGNJH+8vFP9XEefWmEX0hkBWebBIrV3+fnWa9k+cWe4UnbdGjaqK+Z7mf
 LyhrNcb8SqN3bsIR2y9tZ/LCGHohc8mGJtSmyaUOOm0Fed+lRuMnCILyssjTm3zsrVxm
 1HKQ==
X-Gm-Message-State: AOJu0Yx+JEdOYpu6qwPgSrCF4l/XDGiom9w4dlfOGUtqUkyVFUPaUiuh
 Q2mzrK92cbMYADVoNcPDgn0W4j9L4hIEweYwIT62qil7pYnCo8c2PRjtOYhjBOnoagwBDIPDt/Y
 Q
X-Google-Smtp-Source: AGHT+IEq6JyPjgUiVC8YD3Kgnqtq2FaVGoBA5DJInxTDw0/A0BB5rSmWc49S6Lqo9+EIufr9QH/7Rw==
X-Received: by 2002:a17:906:2c09:b0:a59:bfab:b257 with SMTP id
 a640c23a62f3a-a59fb9f2e08mr160099766b.65.1715178651983; 
 Wed, 08 May 2024 07:30:51 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 b8-20020a170906834800b00a59b126af69sm5026190ejy.159.2024.05.08.07.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 07:30:51 -0700 (PDT)
Message-ID: <f860769b-22a0-44b7-8c27-f1cc099b24bb@linaro.org>
Date: Wed, 8 May 2024 16:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] crypto: Allow building with GnuTLS but without
 Libtasn1
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20240502095642.93368-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502095642.93368-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

ping?

On 2/5/24 11:56, Philippe Mathieu-Daudé wrote:
> Since v1:
> - split in 3
> - remove "crypto-tls-x509-helpers.h" (danpb)
> - include pkix_asn1_tab.c.inc
> 
> Philippe Mathieu-Daudé (3):
>    crypto: Remove 'crypto-tls-x509-helpers.h' from
>      crypto-tls-psk-helpers.c
>    crypto: Restrict pkix_asn1_tab[] to crypto-tls-x509-helpers.c
>    crypto: Allow building with GnuTLS but without Libtasn1
> 
>   meson.build                                         | 1 +
>   tests/unit/crypto-tls-x509-helpers.h                | 3 ---
>   tests/unit/crypto-tls-psk-helpers.c                 | 1 -
>   tests/unit/crypto-tls-x509-helpers.c                | 6 +++++-
>   tests/unit/{pkix_asn1_tab.c => pkix_asn1_tab.c.inc} | 5 +----
>   tests/qtest/meson.build                             | 3 +--
>   tests/unit/meson.build                              | 6 +++---
>   7 files changed, 11 insertions(+), 14 deletions(-)
>   rename tests/unit/{pkix_asn1_tab.c => pkix_asn1_tab.c.inc} (99%)
> 


