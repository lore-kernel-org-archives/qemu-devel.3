Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B882CCA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 12:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uohrH-0006au-4T; Wed, 20 Aug 2025 08:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uohrB-0006aN-Ri
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:23:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uohrA-00020U-2o
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:23:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45a1abf5466so5775985e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755692634; x=1756297434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8HeI1uRcU/esmaTJY9hjzK554PMX4M+9+ftf1EGxeME=;
 b=kl2zBosiA9K5eLnMhFpNHGvYXBRfuV1cr3C+pXr8bquujqdlrZO7i6pGtAZD6lPReH
 48Ygg/vXlarzZzUGrOdYRqkAtfG+RJ/Nb4lpCeJctX+Aj6/iN6+Pc367hhAbr2ilO4aP
 BgEv5/ynaB1iljvueTTS1t4GqJoZJ3mGCZUHSIBPF0OgLLBllJWo1QaDZ0wc93ilbOeP
 CYccddmGp/+sYVpzliKZY5mH8Y6sbZav/qc9wyWXMCTVbx4Of3l2wXO3jd/rjCoMCjLY
 G70t8/ul4CxYGRoa1GXfyqib80PDwp4YtA2+kRu2i4bvOMv6ZcwnaVWm3fSvxVa6UiY4
 jrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755692634; x=1756297434;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8HeI1uRcU/esmaTJY9hjzK554PMX4M+9+ftf1EGxeME=;
 b=T0VLyvpH9GbnF6ckR0pJcbJHujc9y3sXLzcogiLKjQJUHUI3V6Wrry2F18qDBAMTrO
 u7NWKEHyYxJpRh6I/hzhJRW4bvrVKUrkKFzYEbqBgrBN6r3D51X4x3IxRiUNYBMVvAIA
 nWtc8RH6ebi1H9XCk9gq2atw/YnpDsJmSJF/YqtCzOpXRNyHEVeuOMjneLveeyNXqbNW
 n4EENV7int/VFBucN/ZOWxml2aHZCsvk3p4umOEnItceFkyKLXxCRgZSwyeOfGm3dKFw
 y8U4CJg1Xw0JPH7omPigR27Zn2zVdaE6dDhEuw4NBBt3zP1tTfFZspg/0TwCADansm4P
 FFLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCWwARqPPNsF2kV669LmfuxpT65K2KO6pJJps0Xrq6zPqNgEAeAB/3HVdU6JoRKDf7pgOmU7jTc8gI@nongnu.org
X-Gm-Message-State: AOJu0YxbM6J1giMoIQyieN6vyMrWeDAqijpbmcOOMSyWxmDM8giB90aX
 Ym2IU6wSYxN3y7iQCxSv81/DDVt5o1U+362/Q9Zb2Dfa/kX6ekCA+APvkzu+eB8kz4A=
X-Gm-Gg: ASbGnctvK0BD68TyhQfx0gQ+OAgQ9d8aksng+UGn+4awwV5oTus+5a5BzKjm2c4IcZQ
 zyYf381EqiFj+KHw2iGkrhADXry7aVCmqnTM2wf+8Sq/4faaKislaAvMIzHlLOBbWZwAtGZKNcn
 sfZQl1cZa3gzKFfeU+64O6ykBFeeyRin2D8BypLwICIJxRl44khP5UuQxBGhFSH7So4V7nb5Gdz
 elGIVGByAl3LQQLVs0WVfmClwIuzgoQJMU50+JbIqPFcyOd9MjWADLfffk3npJ+i1U7TYOF20GE
 T0Jwo7MVqu46J60rQEN36+pCn8EedAmYfI5u32SjFebYn07UIeBKQjXSh2zY7szXdJ1a2HVsX07
 9URJXH/37m3v2E11NpTalVzfD4eWp84wNJhKpNEyLPDReek1ZJaXI5HMJcQ/Y75UyYbUexiM=
X-Google-Smtp-Source: AGHT+IGgPaxUHS+/LmoVQEweQHbJnnVyEhrOvNLz9iMHIeceRnv3Af1NP9JgI0S/ppmL69brV7F47g==
X-Received: by 2002:a05:600c:3f16:b0:456:1146:5c01 with SMTP id
 5b1f17b1804b1-45b43e972abmr58129315e9.12.1755692634173; 
 Wed, 20 Aug 2025 05:23:54 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0777884e8sm8201592f8f.45.2025.08.20.05.23.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Aug 2025 05:23:53 -0700 (PDT)
Message-ID: <5f62e29c-ad26-43d5-a479-c862862e95be@linaro.org>
Date: Wed, 20 Aug 2025 14:23:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 34/47] hw/arm/xlnx-versal: use hw/arm/bsa.h for timer
 IRQ indices
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
 <20250820082549.69724-35-luc.michel@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250820082549.69724-35-luc.michel@amd.com>
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

On 20/8/25 10:25, Luc Michel wrote:
> Use the bsa.h header for ARM timer and maintainance IRQ indices instead
> of redefining our owns.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>   include/hw/arm/xlnx-versal.h |  6 ------
>   hw/arm/xlnx-versal.c         | 28 +++++++++++++++++-----------
>   2 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


