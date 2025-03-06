Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1240C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpyka-0007SX-43; Wed, 05 Mar 2025 19:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36ubIZwwKCiEK78FEBPQBC7KDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--nabihestefan.bounces.google.com>)
 id 1tpykY-0007SC-1b
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:06:06 -0500
Received: from mail-oa1-x49.google.com ([2001:4860:4864:20::49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36ubIZwwKCiEK78FEBPQBC7KDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--nabihestefan.bounces.google.com>)
 id 1tpykW-0006q8-6m
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:06:05 -0500
Received: by mail-oa1-x49.google.com with SMTP id
 586e51a60fabf-2c1ffbc81e1so39800fac.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 16:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741219562; x=1741824362; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uNu3P7y19nGx7rFiXxP9tYKmxh/Cdz8S4IOkXEmb16s=;
 b=SMtlxTCAswEMybGTCbz7/bpNhraiRqVhKephyXl4jrxJd/VcL7QRqPGGPvHh8BSl2r
 VK5qzR0utu9IzhjsGnFTQpmWdFeAQOeVC94hXYXW0Ta9YDEkrSIX7pKxQxGSm/sy7USv
 B2vZYVp5NJxXt1cXfK+mF8APt/kbNijoNyUd3YKdFz38USL9frxQ55XmmCNX7KCneGDx
 ZTOvTTqy5Qy2ybBct2tW4HMMr90c91xw33kg4hqDb/b/fPaPSLh2K4aeerr2NEqq6+YB
 YouE3YAmDT1m6VKnnSyvr/A8slB99V5BBx9fUQVSbET2ZWczecl+/+/IIzvmuPgBkonX
 v3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741219562; x=1741824362;
 h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uNu3P7y19nGx7rFiXxP9tYKmxh/Cdz8S4IOkXEmb16s=;
 b=HrqFxnIkAS2s+o16SH/gHJrzX5r16x226ERSgXSm4IUs2iTw1IWoAvJFvoePAG+zpv
 mby6wTJoJipKvTsil2tEG6aSABDWj3htML9qurHTB2aN7KLTmEiuzfnjJWCxpsHMw/ui
 kP2IJsw+jscNuJfWWxC782gGfr2QhNWP/PmO4JoXss8Zj+rLSvqxUAWpXQ36chFz9jkx
 xb6Ld+zL9X5TmP8bBj0b2vJNDItXKyZLjxA7U8JzYKC53Y5ipW3/uWeZ4lpLhdBkJ1tY
 ZPW2bb3aKcVxCzl9+emca2dvMIYNoSXH60CTx1rE/z66y7LdDXEpzAD3R/jJVG1shv1l
 4C3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB6fpWuX0zZPVyRoKQXvAMQBY9AOQsHv9FTVyFCScjFhKQOGCnZWYTxFN0RuYCd+hpBKp0wPn+zODA@nongnu.org
X-Gm-Message-State: AOJu0YyG/atWtk0aMILeOXcJEPuLDT7IGae23NjxPNIXTbvOzwcGb51X
 FcY+9/nhZNGXvPJhhx73/PZvDCCH4aNp9NN2l9C5ghWXVUJPsXKcEf5S0pJ7bS59s8gZSUe1Wvq
 Kph7qwonY800CN64qxPTHa1N1KQ==
X-Google-Smtp-Source: AGHT+IH1j3zJ/i5veDhN33VclHiChDQ7YJJhr70l0dfcfyMIg6698QdoNIFVpxWWC5jdvqABl90xqWMk3lCy+jEg6nc=
X-Received: from oabxa2.prod.google.com ([2002:a05:6870:7f02:b0:29e:6524:e13e])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:e409:b0:297:2763:18d4 with SMTP id
 586e51a60fabf-2c21c96650emr2657319fac.15.1741219562108; 
 Wed, 05 Mar 2025 16:06:02 -0800 (PST)
Date: Thu,  6 Mar 2025 00:05:57 +0000
In-Reply-To: <20250304064710.2128993-3-jamin_lin@aspeedtech.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306000557.2092401-1-nabihestefan@google.com>
Subject: Re: [v5, 2/6] hw/misc/aspeed_scu: Fix the revision ID cannot be set in
 the SOC layer for AST2700
To: jamin_lin@aspeedtech.com
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::49;
 envelope-from=36ubIZwwKCiEK78FEBPQBC7KDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--nabihestefan.bounces.google.com;
 helo=mail-oa1-x49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Reply-to:  Nabih Estefan <nabihestefan@google.com>
From:  Nabih Estefan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> According to the design of the AST2600, it has a Silicon Revision ID Register,
> specifically SCU004 and SCU014, to set the Revision ID for the AST2600.
> For the AST2600 A3, SCU004 is set to 0x05030303 and SCU014 is set to 0x05030303.
> In the "aspeed_ast2600_scu_reset" function, the hardcoded value
> "AST2600_A3_SILICON_REV" is set in SCU004, and "s->silicon_rev" is set in
> SCU014. The value of "s->silicon_rev" is set by the SOC layer via the
> "silicon-rev" property.
> 
> However, the design of the AST2700 is different. There are two SCU controllers:
> SCU0 (CPU Die) and SCU1 (IO Die). In the AST2700, the firmware reads the SCU
> Silicon Revision ID register (SCU0_000) and the SCUIO Silicon Revision ID
> register (SCU1_000), combining them into a single 64-bit value.
> 
> The upper 32 bits represent the SCUIO, while the lower 32 bits correspond to the
> SCU. For example, the AST2700-A1 revision is represented as 0x0601010306010103.
> SCUIO_000 occupies bits [63:32] with a value of 0x06010103 and SCU_000 occupies
> bits [31:0] with a value of 0x06010103.
> 
> Reference:
> https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2023.10/arch/arm/mach-aspeed/ast2700/cpu-info.c
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Tested-by: Nabih Estefan <nabihestefan@google.com>

Thanks,
Nabih

> ---
>  hw/misc/aspeed_scu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 50f74fbabd..545d004749 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -910,7 +910,6 @@ static const MemoryRegionOps aspeed_ast2700_scu_ops = {
>  };
>  
>  static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
> -    [AST2700_SILICON_REV]           = AST2700_A0_SILICON_REV,
>      [AST2700_HW_STRAP1]             = 0x00000800,
>      [AST2700_HW_STRAP1_CLR]         = 0xFFF0FFF0,
>      [AST2700_HW_STRAP1_LOCK]        = 0x00000FFF,
> @@ -940,6 +939,7 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev)
>      AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(dev);
>  
>      memcpy(s->regs, asc->resets, asc->nr_regs * 4);
> +    s->regs[AST2700_SILICON_REV] = s->silicon_rev;
>  }
>  
>  static void aspeed_2700_scu_class_init(ObjectClass *klass, void *data)
> @@ -1032,7 +1032,6 @@ static const MemoryRegionOps aspeed_ast2700_scuio_ops = {
>  };
>  
>  static const uint32_t ast2700_a0_resets_io[ASPEED_AST2700_SCU_NR_REGS] = {
> -    [AST2700_SILICON_REV]               = 0x06000003,
>      [AST2700_HW_STRAP1]                 = 0x00000504,
>      [AST2700_HW_STRAP1_CLR]             = 0xFFF0FFF0,
>      [AST2700_HW_STRAP1_LOCK]            = 0x00000FFF,
> 

