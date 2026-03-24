Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC9AFEC118
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w58pV-0006xb-8a; Tue, 24 Mar 2026 16:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1w58pU-0006xC-HJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:58:24 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1w58pT-0006yG-17
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:58:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486ff201041so38602785e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 13:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774385901; x=1774990701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=or4gydKa0WQ8LJoYBqRR2/fe1enyIXs4mWK0LmQVX4A=;
 b=c/w6iMkmlLn56QusO2Yf0hsjwnN5PXi98jePtRg6S+V7ZD+zbUorRgDYWBXWFwPqe+
 c9WQwGP+E6FasbeZnPX+XRWWOJqsCw4g+cF94a7zWI4qZZmTJDdUC6GFSQ2cQxffJ4ks
 zGW6+qBbE7Ek2wiLhLU71KqsQ50SpXszHTGWidbeOkW/WbgzcIrS2Nj8MrPvTtChuXXE
 adYyCuaz+Sj9lzueb1IzqF9AleHmBh1x3vSNL/bWKWHZG4H7hO8b5gCuQ63bKQOIfqa5
 6AhdG5B64AUImxGz1TeaJKnplLi18xrmPtAMCJf9V4VWrkemR0Pc2RA0R/0OYsalogNd
 yhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774385901; x=1774990701;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=or4gydKa0WQ8LJoYBqRR2/fe1enyIXs4mWK0LmQVX4A=;
 b=gR49+Pn4E0g2lv3F0mIjA8xDYWQOz7iscKITUKaNBuP+e1OcqvjRkCLbvJ4fADOTwY
 bE3hgxlaHiN1kAxVPz1J//VyC/k0CTb8hnck3tHXpKTpaTfu1plfbvcRLGb7RR2vx7q3
 gAcplULimgy0vk4XsWV07WmTdjIjJm9yDN+mu1xe/lLfsvm4iEbbsz2SkvZfq+31Vs0W
 pY0bBiS3rgXlscE6ByfYwq96d05Bu194cHLJ7SLMINdS9hXize9saS5SvYz86ghDWMz+
 fjUAWRqsxbmOAFnrNumQxS+isJeChB2JQGfNJBgFqJQUacjql66Z6gF9o+iWb52EkDco
 cTQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKy+2gbA9ZiOMDr9B3oH2zeVgQ0leWAT2XxTeN9UjpMnRE60CEjc9wlF97prmTBUBGnaOC0U2CqxS2@nongnu.org
X-Gm-Message-State: AOJu0YyCYT8TEHMeHp8z8DNWBLBJS1EyU7cr5A2yuU522OyBkmtnGXbS
 D19vwembPE6dklhJixMrmRyU8Yb5If7GsYazZ47b0Ww7cDLUYfb9dhfC
X-Gm-Gg: ATEYQzweBCIEHgPXazV9/zMe+HkqfH3ZWjSHYQ8xFNpLSMrkjSTnk0vjNX4faCvwyD6
 ZsDGw/XoAGT0M8YAkfTsNQdNj7dF4QIsWAgG/R3tb7AsGGCYJtb5eoice37OmCA0ZzXg7UEO7Ux
 iKemPoLGG150nLFfordyEUMJ6eR4+1yJHlL3VbgVEBJuzASQZKHSLNBskBEYPnZNWfuHKCbEWc2
 ChywNVuO2gwv8nktFNzSd4CeJc/6Ra4WMEcu79kwjtGIf6wbcNOY8MgDFvGXsnNtOPu8EAzfeeL
 FVwBEiQdXmlt7BgSjVh/KHcliSNy0XQSngn0GD7Lz0/f6adpqkwWgEddgai+brjIAlMIUROggbC
 drHS7C4rElXtxkOxarJVMdEkXp5BgX/Y2/bEGOnTFasalYk4DPS7AXLTSjiXMXsRAB1DCiWhat1
 rP0hnTTzXgrjruVIT92kMPAe+yrZCCe/2hM0qCIQSp53FD2QWeD150zvDJlq5X67NVNyDqQYd7Q
 QilqZRxUU4qF5S15gGoABeoas6vARn9cbWOngdmybRjQzc=
X-Received: by 2002:a05:600c:3511:b0:486:fc5f:1ab9 with SMTP id
 5b1f17b1804b1-48715feab33mr17763785e9.14.1774385901255; 
 Tue, 24 Mar 2026 13:58:21 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-24e1-d500-204c-1ac0-c53f-1a0e.310.pool.telefonica.de.
 [2a02:3100:24e1:d500:204c:1ac0:c53f:1a0e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487172bbdf2sm4070985e9.4.2026.03.24.13.58.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 13:58:20 -0700 (PDT)
Date: Tue, 24 Mar 2026 20:58:20 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>
CC: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 1/7] hw/arm/sabrelite: Open code DEFINE_MACHINE_ARM
In-Reply-To: <0528e7cd5cff7ce171b0aad0093a5e77e07c139a.1773866323.git.matyas.bobek@gmail.com>
References: <cover.1773866323.git.matyas.bobek@gmail.com>
 <0528e7cd5cff7ce171b0aad0093a5e77e07c139a.1773866323.git.matyas.bobek@gmail.com>
Message-ID: <8C7E8510-66CE-4AA2-ADAC-F7549D04A16B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Am 19=2E M=C3=A4rz 2026 19:13:08 UTC schrieb "Maty=C3=A1=C5=A1 Bobek" <maty=
as=2Ebobek@gmail=2Ecom>:
>Open code the DEFINE_MACHINE_ARM macro in preparation of creating
>SabreliteMachineState class=2E The name field in TypeInfo initializator
>is left as string literal since the macro would expand into this=2E
>
>Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas=2Ebobek@gmail=2Ecom>
>---
> hw/arm/sabrelite=2Ec | 23 ++++++++++++++++++++++-
> 1 file changed, 22 insertions(+), 1 deletion(-)
>
>diff --git a/hw/arm/sabrelite=2Ec b/hw/arm/sabrelite=2Ec
>index db5669c5c2=2E=2E40ee8196ac 100644
>--- a/hw/arm/sabrelite=2Ec
>+++ b/hw/arm/sabrelite=2Ec
>@@ -114,4 +114,25 @@ static void sabrelite_machine_init(MachineClass *mc)
>     mc->auto_create_sdcard =3D true;
> }
>=20
>-DEFINE_MACHINE_ARM("sabrelite", sabrelite_machine_init)
>+static void sabrelite_machine_class_init(ObjectClass *oc, const void *da=
ta)
>+{
>+    MachineClass *mc =3D MACHINE_CLASS(oc);
>+
>+    sabrelite_machine_init(mc);
>+}

Yes, this separation of concerns looks cleaner!

Since this function will be merged with sabrelite_machine_init() in the ne=
xt commit, let's merge the two functions here=2E This avoids the intermedia=
te function and makes the next commit easier to comprehend=2E

>+
>+static const TypeInfo sabrelite_machine_init_typeinfo =3D {
>+    =2Ename          =3D MACHINE_TYPE_NAME("sabrelite"),
>+    =2Eparent        =3D TYPE_MACHINE,
>+    =2Eclass_init    =3D sabrelite_machine_class_init,
>+    =2Einstance_size =3D sizeof(MachineState),
>+    =2Eabstract      =3D false,
>+    =2Einterfaces    =3D arm_machine_interfaces,
>+};
>+
>+static void sabrelite_machine_init_register_types(void)
>+{
>+    type_register_static(&sabrelite_machine_init_typeinfo);
>+}
>+
>+type_init(sabrelite_machine_init_register_types)

With the above:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

