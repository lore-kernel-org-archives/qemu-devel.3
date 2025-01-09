Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02AAE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 12:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVs8E-0005uo-3z; Thu, 09 Jan 2025 07:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVs8A-0005qN-Hz
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:59:24 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVs84-0000de-EL
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:59:20 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso9277885e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 04:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736427554; x=1737032354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LFNUroakmeucu45HwqrH43wltLtFFWMrC2tCBeJXXAg=;
 b=xmibxQIj6enimG4Hk4mqF+65LxS66sFMzEy6Jnay1Sk3wBf84z+k+x+Wz/ptRqKOHy
 5LkgRhcIPbV6peUh+xt+SmaM88OBAqF4YIB/5w9bnzp3Zb/NQOxsGaJY7K2X8GR/PVBE
 ismVl0qEm4cTI1DbEBLikJ0BHrfPssK5/VtIMzkgOiK961RGZJ2RJqGnJTMa3P3dQ3W1
 RSvgbDnpFZVBzaMXKNw8gQhlcNJbiVZvWtXP4mPzn6fPZluE8jHHcM0DE3+mmSi4aeNR
 fM1C/BgEe32E2bfht3U/klXoZZ/MgCL4h8Q0Wk8Pz1n+7RVLPiqBl7bebyFBrWrAsZLz
 69dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736427554; x=1737032354;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LFNUroakmeucu45HwqrH43wltLtFFWMrC2tCBeJXXAg=;
 b=UN2qH4BS8MNkvlxskyEIL6y77JNBEo6tEzk6Wyh6L0P7uA5ntKImXIcHlo5R9bT+H6
 weleM2LbaoFGmpbTD2+uDj9aZaGjJTkgu3vYxR1A8EBEvQw1DcCQ6rroBVF9UgT7/dQT
 KMl0trnGFVGwHszR+7Mz3MqYQPgnED2t4/n/fA3W56SkKn2DmuOpQZRArvoFbYyh3sB5
 rF+Cym9Sb5X4OyqhSOKj32gb5czvZ0ah9tUKX7jVDVZDzcB4g6eBmHnjPCCEN/Spj20u
 yDavo010Ugjxs+Q1QS6X7cA1Pq6f4WXKlPzbbLQCHQ2XmIbjpIeToyV+9zr2m4sYjc+l
 T2Dg==
X-Gm-Message-State: AOJu0Yx6aYwnP7IcnD70/zEJ4RZski8vP2nVY+EYBcbOYtGKQrsiCiJt
 i18Wi0EMToLVL7MPvhG/Tadj8M19D2PBfOjzj8NHorwTTRk7OdufJB/pQDb/bG44Fq5nM99n4Zr
 aUjQ=
X-Gm-Gg: ASbGncsUBtjGlNZOqPAntfbn5fuNu1QemZkrncQaQAfRMdbdfBssdRHI0EFl54410g9
 f5wUnmfwuPZR5LdmW8S9ZlKWlozTDmizelzaPf5Haq9LFY7mNJFcG/uwld9yuj7iKy09KfNGYW8
 YWUsyAOQBympRr3qQuVKgVJLEcel0iLIkSeYo3Au0ymUU4ga3oLO5SNRxpKPMgDqjFgjv9dF5yp
 5XehMl+nY5j7j+8paLa/bBDs3uWDgXGaPoaSjvhq1nXHfhrZ4u9cuS8PcPgFqbuKj0Hg715fDKx
 M7szvVcUN2ls47axYlW6POtj
X-Google-Smtp-Source: AGHT+IGUAvW28NfByP9PxwacHcO8xtZdkmr41QlfVQx8AIJuET01GvOcJbkrHYDnHUYqk78b9Vr/zA==
X-Received: by 2002:a05:6000:4b04:b0:386:4a24:1916 with SMTP id
 ffacd0b85a97d-38a87317c6dmr4923735f8f.55.1736427554596; 
 Thu, 09 Jan 2025 04:59:14 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3838a3sm1790792f8f.33.2025.01.09.04.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 04:59:13 -0800 (PST)
Message-ID: <98233d06-2ec0-42e2-bbba-9723378ef8ce@linaro.org>
Date: Thu, 9 Jan 2025 13:59:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1? v2 0/4] hw/sd/sdhci: Check ADMA descriptors can
 be accessed
To: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>
References: <20240731212501.44385-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731212501.44385-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Cc'ing more SDHCI developers.

On 31/7/24 23:24, Philippe Mathieu-Daudé wrote:
> Since v1:
> - split patch
> - do not return MemTxResult from get_adma_description()
> - single DMA read in SDHC_CTRL_ADMA2_64 case
> 
> Based-on: <20240730092138.32443-5-philmd@linaro.org>
> 
> Philippe Mathieu-Daudé (4):
>    hw/sd/sdhci: Reduce variables scope in sdhci_do_adma()
>    hw/sd/sdhci: Reduce variables scope in get_adma_description()
>    hw/sd/sdhci: Read ADMA2_64 descriptor with a single dma_memory_read()
>    hw/sd/sdhci: Check ADMA descriptors can be accessed
> 
>   hw/sd/sdhci.c | 117 ++++++++++++++++++++++++++++++--------------------
>   1 file changed, 70 insertions(+), 47 deletions(-)
> 


