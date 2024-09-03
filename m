Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3031CD37AA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slaDk-0003GA-31; Tue, 03 Sep 2024 16:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slaDY-0002aY-U4
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:33:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slaDW-0006R9-Ng
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:33:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42c7a49152aso38745475e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725395609; x=1726000409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ca9lXDEfNJ38bmK48yAITPRV01n3jZp6CajOfc0GnMo=;
 b=sXc3qPIW48CB5EnoPoPFh2HLec3KNVygj+gscaBG1t4ZFFqB6w/erVoVPBNFYU4V3V
 uuTCWUcIBfGQ32E9Sf+QSCq5Tfw3pgqRPpIkO8EvH73sgVaPCaNQiJ3xq6cQfdeik18k
 XHXXCfn0dgGNOOwvEgcEqaVSuuU/FhrSTSm+J1L7fTlbGyhtSiMAkC/aeJudpJBg8hM8
 83MLnbzkhSSW2lGHuri2oFsaFpz+plXOUiKaqkkz6MtL0bUwkdKoKh7UmiPK6fbimHZK
 qaMdN5Ui8rv5xCHKJ+LaUVRH0hXGphwSFlu7+kZV5tyOGhzbG0+Wnkj0LSGb4P2sMcPa
 cjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725395609; x=1726000409;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ca9lXDEfNJ38bmK48yAITPRV01n3jZp6CajOfc0GnMo=;
 b=A7glyvkjd0IGvGB5nRBQIdVnksmH8Ts7pGMyYgF34BKGloeCoU1F0E5cJYE7o5Uoay
 6aU5iVZDnuQCpR36pn1Pc42g4X8my2juJhVsxiMM9oVt6L2j4pGl6LPFPr0Do7v2G43l
 A152FL427UUvtoKkSunQ/sopDqsFneWJhQQPGyYT76qvs/AiLin0UN96ZONTy64UU5JN
 +Bf983atLHDeWb6CmPS1ZVfprJP+00MLe5Aaa2Ntywp/vC0MPAJ+QnzUpaF5DxYZUJXO
 u44pcovAPv2APc7tZ9OvR9/4s63MIHyEanGvP7oA5Ri1PGdjAH2ZObA5vlie/9hDGc1K
 dssA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS5kmEMbNGnNV1mpjK0phacXI2c21IV5jzv4EQIQxDlkBK01F7P2kI7RGOFa1XF2U+yMLYhzh8aBtO@nongnu.org
X-Gm-Message-State: AOJu0YxMi+iG/Lq8mx+1fT1Wwply7swz5wMUP5Hwj6n9ZBEqsAHD/m5r
 XJcewKZ1ICVWiziTg2mrCrg9v/C5bEvSLF1QFbKcR4Bz7R7yFNXBFkZMs+/v9DI=
X-Google-Smtp-Source: AGHT+IGq5Evnstat5oUeOBg0Lpn6Sp+fw6YEjW8y/7gjsP3AruZyzvprT7kzdPvY4CF4cjTFsbWiHA==
X-Received: by 2002:a05:600c:4695:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-42bb020d194mr163456165e9.35.1725395609173; 
 Tue, 03 Sep 2024 13:33:29 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df79b6sm180851965e9.22.2024.09.03.13.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 13:33:28 -0700 (PDT)
Message-ID: <f7690a1e-84ab-410f-953a-e719ffd0e4fb@linaro.org>
Date: Tue, 3 Sep 2024 22:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 41/53] hw/sd: Remove omap2_mmc device
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-42-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-42-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/9/24 18:07, Peter Maydell wrote:
> Remove the OMAP2 specific code from omap_mmc.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h |  5 ----
>   hw/sd/omap_mmc.c      | 63 -------------------------------------------
>   2 files changed, 68 deletions(-)


> -struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
> -                BlockBackend *blk, qemu_irq irq, qemu_irq dma[],
> -                omap_clk fclk, omap_clk iclk)
> -{
> -    struct omap_mmc_s *s = g_new0(struct omap_mmc_s, 1);
> -
> -    s->irq = irq;
> -    s->dma = dma;
> -    s->clk = fclk;
> -    s->lines = 4;
> -    s->rev = 2;
> -
> -    memory_region_init_io(&s->iomem, NULL, &omap_mmc_ops, s, "omap.mmc",
> -                          omap_l4_region_size(ta, 0));
> -    omap_l4_attach(ta, 0, &s->iomem);
> -
> -    /* Instantiate the storage */
> -    s->card = sd_init(blk, false);
> -    if (s->card == NULL) {
> -        exit(1);
> -    }
> -
> -    s->cdet = qemu_allocate_irq(omap_mmc_cover_cb, s, 0);
> -    sd_set_cb(s->card, NULL, s->cdet);
> -
> -    omap_mmc_reset(s);
> -
> -    return s;
> -}
> -
> -void omap_mmc_handlers(struct omap_mmc_s *s, qemu_irq ro, qemu_irq cover)
> -{
> -    if (s->cdet) {
> -        sd_set_cb(s->card, ro, s->cdet);
> -        s->coverswitch = cover;
> -        qemu_set_irq(cover, s->cdet_state);
> -    } else
> -        sd_set_cb(s->card, ro, cover);
> -}
> -
> -void omap_mmc_enable(struct omap_mmc_s *s, int enable)
> -{
> -    sd_enable(s->card, enable);
> -}

Yeah, few less legacy users \o/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


