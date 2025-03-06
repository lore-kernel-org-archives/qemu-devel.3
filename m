Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E128CC19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpyj0-0006gE-9V; Wed, 05 Mar 2025 19:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3g-bIZwwKCrglYZgfcqrcdYlemmejc.amkocks-bctcjlmlels.mpe@flex--nabihestefan.bounces.google.com>)
 id 1tpyix-0006fo-3i
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:04:27 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3g-bIZwwKCrglYZgfcqrcdYlemmejc.amkocks-bctcjlmlels.mpe@flex--nabihestefan.bounces.google.com>)
 id 1tpyit-0006Zc-Ll
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:04:26 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-22380c707d3so577345ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 16:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741219459; x=1741824259; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=u4FPgBDeNgIVnuSeJEm4bRvq4c3lMQnGzsPghs6/QjQ=;
 b=3iRHX/+9D4ACqVViUJIx7B5EkDMJCEeBTq45iUSqc2PjjcnQQzCb8bfJ9sIVUS6QEG
 f3rXOorUS5jctN2Ls/6E23Hmqc434NwovkBbP+ZbPmLAe4EZTzZJdMlNAPgJUAYe2R8D
 YQIYNpeyMnK98ZV4YX5CcN0icSiZHvFIzmKpeG6q8XcoRcakccCaLOGoL1VxkOI5eyz6
 MVeaewUOGWKoH/F41aUmhKpuwvpOIG6a2BBEO2Rsr+dBW69ISKNgTerR0qarjg5D/gIy
 7I7mI5q5kdoBaxPHLhwTCPg5O+iZ3Lla7DExt7WEW8sNfm4wCyXjbBjuRdWmESYEyf1X
 BtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741219459; x=1741824259;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u4FPgBDeNgIVnuSeJEm4bRvq4c3lMQnGzsPghs6/QjQ=;
 b=icWLLQOVR0MQ2DxlBOXFmIDOy/vwrck03mplJJq8mAxn+KrK/ROZsBamWwounAL/Gz
 p+MtU7X2Eut+1qBCCk0PFlyvwJQIyKQ4tHiZt5fqAQgC/qhf1iu9cStUC48rO3yBv5xB
 9T12Q1J6AwmUs1lStWQlhYOS+4/911zHtOBS3qWLCblgVDoAvcKTLkgZ4uePC19NagH+
 3eBQUtcjHRY4WCfKvm0377KO/qxhSyXYQsMZwrIdSkUkRUDfM5KgASRyT2mDIXfN/DZd
 FN947cKoexTZLK62XqwsKBukBsHNVkfHMOJZtJF+gDtN3B9CSUDkT6KooB0uvaoiI3jx
 ZBAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA1zCVD289COPHBNtN/FXENbiKTL8bJBIXZDcui+Sbhu1D12Ns/qTn6hjhWHPefuGsZKoQ9dip1Sx1@nongnu.org
X-Gm-Message-State: AOJu0Ywa7nxSaLS4Q6AkWE4SB8FUe4L91ilf4ZIbng+ctWqcvsup3HZQ
 NgwO9guGq9YjIjxbp1YOobdABd6y3FUoSwlWOnN2QYj+CAIBuEg1o1wcvkBCAUjWB8GrHyi2Q31
 JeH8dhmeusMtvjOWD6xqJJoZRLw==
X-Google-Smtp-Source: AGHT+IGxWKn5gJePM45C0yaWVXwlXJ76ei1b7AHX2s96vbt/FXfSM40IfI26nQSSJA78ZUPiCD+2Q6b2w3Sn65xn9TA=
X-Received: from plbkz11.prod.google.com ([2002:a17:902:f9cb:b0:220:d28d:8218])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f54c:b0:220:e156:63e0 with SMTP id
 d9443c01a7336-223f1c66badmr60288055ad.8.1741219459287; 
 Wed, 05 Mar 2025 16:04:19 -0800 (PST)
Date: Thu,  6 Mar 2025 00:04:04 +0000
In-Reply-To: <20250304064710.2128993-2-jamin_lin@aspeedtech.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306000408.2088020-1-nabihestefan@google.com>
Subject: Re: [v5,1/6] hw/misc/aspeed_scu: Skipping dram_init in u-boot
From: Nabih Estefan <nabihestefan@google.com>
To: jamin_lin@aspeedtech.com
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3g-bIZwwKCrglYZgfcqrcdYlemmejc.amkocks-bctcjlmlels.mpe@flex--nabihestefan.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

> Setting BIT6 in VGA0 SCRATCH register will indicate that the ddr traning
> is done, therefore skipping the u-boot-spl dram_init() process.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Tested-by: Nabih Estefan <nabihestefan@google.com>

Thanks,
Nabih

> ---
>  hw/misc/aspeed_scu.c | 2 ++
>  1 file changed, 2 insertions(+)
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index bac1441b06..50f74fbabd 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -157,6 +157,7 @@
>  #define AST2700_SCU_FREQ_CNTR       TO_REG(0x3b0)
>  #define AST2700_SCU_CPU_SCRATCH_0   TO_REG(0x780)
>  #define AST2700_SCU_CPU_SCRATCH_1   TO_REG(0x784)
> +#define AST2700_SCU_VGA_SCRATCH_0   TO_REG(0x900)
> =20
>  #define AST2700_SCUIO_CLK_STOP_CTL_1    TO_REG(0x240)
>  #define AST2700_SCUIO_CLK_STOP_CLR_1    TO_REG(0x244)
> @@ -930,6 +931,7 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST270=
0_SCU_NR_REGS] =3D {
>      [AST2700_SCU_FREQ_CNTR]         =3D 0x000375eb,
>      [AST2700_SCU_CPU_SCRATCH_0]     =3D 0x00000000,
>      [AST2700_SCU_CPU_SCRATCH_1]     =3D 0x00000004,
> +    [AST2700_SCU_VGA_SCRATCH_0]     =3D 0x00000040,
>  };
> =20
>  static void aspeed_ast2700_scu_reset(DeviceState *dev)
>

