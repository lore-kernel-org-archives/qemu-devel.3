Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8379C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpymw-0001V5-6K; Wed, 05 Mar 2025 19:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3dOfIZwwKCqsYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1tpyml-0001Mb-C4
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:08:24 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3dOfIZwwKCqsYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1tpymj-000724-JX
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:08:23 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2fede63f32dso397423a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 16:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741219700; x=1741824500; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=UyjiFGUgfhIevwFcnNYqsTxfpyZqsh+g52PkrRzwRGo=;
 b=e0Fk6GHFJMipGibu9Z2Xi0c14FTh1ZmRq9+BAT2xFVydyoIMgBZt722peMRYLaQmqY
 mabshmbkAqKtzT4lqwZ80zaXYFSW6xfKunvP7gzOeLd0VUUg42TCp8GRt46ZzUQx9tTo
 eY18V4LGj+kn6MMMYznRenpwM4imTlfywBjFtGAIEa7zPgv2ct3uzkQer/JajUokpY42
 FnNecZjz6o1NCg/EE+5Kh6ISNRL3Vh8gnfftMIjhl4l0nWewM9zcE6+j3+S7a1GGJArV
 rAlLy5kTtWXRzRulMM4I77s4aM613KiilII1oG+y9Xb/+QmvnvqIjLYhoGy7focc3PFm
 2nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741219700; x=1741824500;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UyjiFGUgfhIevwFcnNYqsTxfpyZqsh+g52PkrRzwRGo=;
 b=KvXnjoewiCrCC4n7BRPvQiLyWG787Q774sOpjzU4SrpzAeybPCFxU7410U11Nk2a6E
 lCm2/MAwyR0qnzZisdfm/vfqmfiBGlpzlFbRNsrOvO3mDXXZ8j1KQr6RstHFuWcmQMIC
 PE105iS249HUgv8fIihb8N5AmhfJSg+jD6YadRJ86bIdnXcOLTx6ppBw/wWFB+C0qDEg
 uhdvJEO6uMHvYAadZG1f7pDmIHnvCoGigZi2ecj3K5l0lLXkwVob/OEUHadetgMkcvV+
 FtiLZFOzaS8SQ3LhHH2u3SRqcIyZqWxlffMLYSka0jDevVS4/6FcLdTa7l84hBAhFNNP
 r3qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxOVnYYnh/E28q739bzgA57bUXPG7DQRCUkdoyZqUVZPtDu1Cq4KKuUpgiN9WFR6z5FbGV6e7iWVLd@nongnu.org
X-Gm-Message-State: AOJu0Yy4wscX+t1NZpoFfHM+SBDlKvHWBG5mIlLyFML4b4+gQN6VI1ep
 6r/snoDCYz554r4kJM+bHR/p57wFla2+IEcVtTr5Dvm+qKhJIt3yTZ4VU9n2/QmK50YecfPBl7M
 bxCJpQ9XRcMmLkSZVEUhdQxy1JQ==
X-Google-Smtp-Source: AGHT+IFFcHEZYlKd4zyzyME9x2X0Y5fg//iTVj58oW0uk84bylAEXG5uRnjF9w3zkMWzwgwr1KsmMSZe8VGHKTyGsts=
X-Received: from pjj3.prod.google.com ([2002:a17:90b:5543:b0:2fc:1e77:d6b6])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5688:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-2ff497a921amr8789665a91.11.1741219700056; 
 Wed, 05 Mar 2025 16:08:20 -0800 (PST)
Date: Thu,  6 Mar 2025 00:08:14 +0000
In-Reply-To: <20250304064710.2128993-7-jamin_lin@aspeedtech.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306000816.2098104-1-nabihestefan@google.com>
Subject: Re: [v5,6/6] hw/arm/aspeed_ast27x0.c Fix boot issue for AST2700
From: Nabih Estefan <nabihestefan@google.com>
To: jamin_lin@aspeedtech.com
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3dOfIZwwKCqsYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> Currently, ASPEED_DEV_SPI_BOOT is set to "0x400000000", which is the DRAM=
 start
> address, and the QEMU loader is used to load the U-Boot binary into this =
address.
>=20
> However, if users want to install FMC flash contents as a boot ROM, the D=
RAM
> address 0x400000000 would be overwritten with Boot ROM data. This causes =
the
> AST2700 to fail to boot because the U-Boot data becomes incorrect.
>=20
> To fix this, change the ASPEED_DEV_SPI_BOOT address to "0x100000000", whi=
ch is
> the FMC0 memory-mapped start address in the AST2700.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Tested-by: Nabih Estefan <nabihestefan@google.com>

Thanks,
Nabih

> ---
>  hw/arm/aspeed_ast27x0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 92487bf229..10e1358166 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -24,7 +24,7 @@
>  #include "qemu/log.h"
> =20
>  static const hwaddr aspeed_soc_ast2700_memmap[] =3D {
> -    [ASPEED_DEV_SPI_BOOT]  =3D  0x400000000,
> +    [ASPEED_DEV_SPI_BOOT]  =3D  0x100000000,
>      [ASPEED_DEV_SRAM]      =3D  0x10000000,
>      [ASPEED_DEV_SDMC]      =3D  0x12C00000,
>      [ASPEED_DEV_SCU]       =3D  0x12C02000,
>

