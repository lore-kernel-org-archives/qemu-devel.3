Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3D6C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 13:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp5Uu-00005j-OH; Mon, 03 Mar 2025 08:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp5Uf-0008SK-H2
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:06:03 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp5Uc-0004Se-FM
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:06:00 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43bc30adad5so5168635e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 05:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741007156; x=1741611956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RyLZCqNSpgnRk0wvUnEiBPuTTrec3Ig7km3xSg0ZUgY=;
 b=JMsDlF8ktTJx6MKvaId6tgcZq44L4zSUR7+DZxQuaRcyUtf/SP6+dKu/BRkp5ufZho
 sHnmgJT4kNsrzpwXL9Xs7QndkV5ApDqiKZh6HRvpPeK5Ejc9W4Tse9PkaokdslxdJO+R
 jXVpcHpVzfNKu2pJeGmtrkd7kS0SgsP8sMWRBmpDCXyRgKKPBdsijt5ZI+bWMS3GU791
 hVf7hP/9iFPGBpaGei3GBUdmGoGgWRWPrXBj0UGmoz2tqM14BwoDIQeRUt5p0x3O/gJN
 8GSEUjXymGpLL90pRLzCi42So5+f8gtMFT4r0E69yJPc6ZQ21DwBjATRmH3gNB476zqa
 FBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741007156; x=1741611956;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RyLZCqNSpgnRk0wvUnEiBPuTTrec3Ig7km3xSg0ZUgY=;
 b=CCxF8Iao/BR8UEZYDvgHO5kzRpj7m4vpAY8f6Ae56hqkRcrldorqRDcrsdyMYvpAfA
 xAYcNevO9ukdFNc9MRU69KVLXm1iihmBJNPpuqXObFZhEl9QwG1C+KIzV49rHWvjsz7R
 loa93rOdZevafA2Yf/b4AlsP8L+3qtNt1k6sXentevojgNSZmZaW1Q98oAC3CY5mblW/
 65r3SnFs/6I3KiLQvVMRuqRbgVhPKpyws61J+wOGDOkMg0JmgOfm3jhc+3hGNlTvHSHQ
 6mU6HQppvC5OE90/8luIxRD2MU0erqAUf6BRxqSUENe18CwQKpCKYLqbiBQSf3olyYhr
 +9IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrKuOLWkTrw5azjBHZ2L4SfiKOd0CTvcGcjq3TdMMrTrcG+oFZVgGzHLuNvnxQWY/umU+p0vh6WI7X@nongnu.org
X-Gm-Message-State: AOJu0YzKJ8er2kkmrbE22rVL6t/MX6IXwGgh/P+CqoOi/SXl1fOf1Y/i
 bpsq/oWJ/CdQt4EsRD6674s9cR1lJehQfNKYBoXApDsdJ4T+bluta+WiSjyJj90=
X-Gm-Gg: ASbGncu70C3k2r2aivcl6Vp8v8IUUJ3V9hrc5GFSF+7J29D/wDpptTTB6wSwVilkiOg
 x0yaIG9+72zeul60qIhzXBECdtvposou1a7q/d1ptwQromCIyF4fvijJCD7nSHGGl+AJgzS9GxS
 j4qDjQN+zSwi0jZxgQw9aBEELkh1xx3QJX+KnqsNo2O4waDqNxWtdPJEoLPawZv3xgMFHFmu45C
 J1myP30gMevS/fzi6hLOwc4D6K3b5y7nN0wt9wfVr9YaUtmnqwCuTWrdXGDpcFnyIJ5RBl/9XGJ
 kQUBawNbnPvXaOfKdGDQAhgk81sgXjwpgfxG1LYiqnGPVLtAFCelF6rS3yqtRiI3T8fu8rXNwwC
 qFFsUhnAW/2Tk
X-Google-Smtp-Source: AGHT+IEEHpv+77IO6inZvBd33f4TLjVp15C/XpDTzCheLcMQZ69jSZ/j2bJ+5IfL4HjuOBpPyypezQ==
X-Received: by 2002:a05:6000:2b04:b0:390:df7f:c20a with SMTP id
 ffacd0b85a97d-390ec9c19a2mr8384507f8f.33.1741007155871; 
 Mon, 03 Mar 2025 05:05:55 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e484489esm14771600f8f.68.2025.03.03.05.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 05:05:55 -0800 (PST)
Message-ID: <46c17165-35c7-4e21-968a-40968c4d50d5@linaro.org>
Date: Mon, 3 Mar 2025 14:05:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] hw/arm: Remove printf() calls
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250227170117.1726895-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250227170117.1726895-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 27/2/25 18:01, Peter Maydell wrote:

> Peter Maydell (5):
>    hw/arm/omap1: Convert raw printfs to qemu_log_mask()
>    hw/arm/omap1: Drop ALMDEBUG ifdeffed out code
>    hw/arm/omap1: Convert information printfs to tracepoints
>    hw/arm/omap_sx1.c: Remove ifdeffed out debug printf
>    hw/arm/versatilepb: Convert printfs to LOG_GUEST_ERROR

Thanks, series queued to hw-misc (with the suggested trace event
name changes in patch 3).

Regards,

Phil.


