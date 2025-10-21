Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F10CCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 05:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB58W-0000Ai-Tx; Tue, 21 Oct 2025 01:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@web.de>)
 id 1vB58U-00009u-Ns; Tue, 21 Oct 2025 01:42:18 -0400
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@web.de>)
 id 1vB58S-0000sf-Ii; Tue, 21 Oct 2025 01:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1761025288; x=1761630088; i=jan.kiszka@web.de;
 bh=7naeRqF9F9UlOiHcJtUMZj/LBIp63n0fHmAEm+9Knm8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qkLW9IbzsObnsjTPDJeUDGw8LsvHEAEN9kXplq3OIUPZccZcVgOzovq+0Ovg8/kY
 6ydXV7vzd6VmqvFz2VCiIVleW7lHSFAX2SoVb9B0Ni70/uRGK65qaEKjO9lfu2F/N
 Lf2EZObEjD8aEj9tx+as4+MfhWjRSMxR0FndYbVUl45u9E7j2YsbP+y9uSx0VhgpL
 sRGV2LRCMIoMoLBIv0QZF0pfFc1RPVxrRRpjayCHTNDi1YLUXkKxTF0+Q/ZHOZrhi
 Kt1RHi3uKIAQD6JI3RArdipaApRCTaQKGtSPs649OqSTW7QNPxhY5QG9KV5Zpprrq
 ndl0LVLBor0qPCzVuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.10.10] ([95.157.49.24]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTvvy-1ukEsk17Hm-00NT3x; Tue, 21
 Oct 2025 07:41:28 +0200
Message-ID: <29fe5291-9517-4c47-a16a-6de639bdd932@web.de>
Date: Tue, 21 Oct 2025 07:41:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/30] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Samuel Tardieu <sam@rfc1149.net>, Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Felipe Balbi <balbi@kernel.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020220941.65269-9-philmd@linaro.org>
From: Jan Kiszka <jan.kiszka@web.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@web.de; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzR5KYW4gS2lzemth
 IDxqYW4ua2lzemthQHdlYi5kZT7CwZcEEwEKAEECGwMFCQWjmoAFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQQATGR9dXLPfXK9tPtpnYUKn0F72AUCZlj8RgIZAQAKCRBpnYUKn0F72EwQ
 D/49OlL8Dg8zPSSEC35eXcKZH7+bi19kNbWztr/dr9XO6YBGXhfgBNn8HqnlbSu+1ApyVjhL
 0oL28uFvfIzLj3/qkbPCuPJ2MSOvtVYVlsBhp4lUWo4LmwlYEqhXmVrpYxPnNdJPsiyl9aaU
 mDzdr3sRnJNdUWZfmXp80FbC0hBiOcKhx+lprMEIjN4UEQtOtKc4SG4wdg/1VEalhoIcKmUN
 +p0GBCEYp3KDy2RoyhhhHdxoL3CLbgcKavDrYrgPsFGa8KlH/UIwk9s9PHa9i+JExkTynqqE
 PhDQJq7zY3hhG2vYXmE9M5H3/vveUFQQIxM5j20Y7YzpVYDoMpcdu8MuIIIAaisIYKkSHps3
 /dDScjBdLu9g0V2yIecXGvbYaeTHM/A0NguL+sW4xTTR/9vj64u+0EhC5bF8PNEUWXvHIDNC
 XcnmDn3VEvM39juimpOEdNGOcunA9evFbDJznVEBmK2qEHfdfZr09dCpltxzLXZI101pFgEq
 MBCPR381u2e6dhXY7obm0Ke+RkL6/qDrqDP2BzJrThAiZGe4MgbmlG0hN/eh2iUlQDxidDgj
 5/xA30OP7vGMIK0iHDsLhxDEc4BdW0WXHOO/eBHTMGfu6YiKOf6MeO7xicuFv3kYrS2opv1r
 1wYPoUzNO1lgHzKxdPyHuPL4IylNrRXFWSBxO87BTQRmWPoZARAA2+arluDNHmljyI6mOmgv
 7xwpqRC5kvxzGuc5QNHVpcQjxI5HITfFuDwfjTDlxRCbiiyxbOvrOfypTaJP5BioOHyE31XH
 fgUHf2EZLN6hYn3JFPpMaF6U3Nm5LE7S7oj5HMhZowaYfwRprN+ZrzgNDmhDun0G2roh2kJ2
 K4FEDPmA+LhaEDi51kz5gY3HKD7oiQ2n8y8cI+K/iR+HwP+M8w2uThW31at4nmBqoga7Y7QR
 b+XqVbxitc6EPkXPoefnQlj8Atot3F01FX9MKHqRfJlFxXDYWPhIfL74dZcXw9+c9giXmLcT
 HAOOC6dOpAK6Vg4xiXXXfjk5lJBVnmLQHWgqY/xiLbiXEGZGmk3oh6jz6271zN+ta7b2sFxV
 M1Jb6FtUm+/0nhPwbVqMZHmToLKqLlz045RS2qby7uYPTDzYpo5GKrpAEqv/nvDDCj/hBL9w
 QBVRRrzRN1JTUYfqaQagVGYqpM4OKtoX3k454r4Aoc15b308fTOgSZrg52AIaOAQOr0YeA6+
 y2EyyMBo4LiLrkHD9hDTfpd9p4ncteeMwhKef0b+CvEmHVXoK0O61olC4A8/VUFqNswI6E4B
 SoNwBN7ow8uFdlZ3bZDEWKcMLopQg0PgaW+YsX2xcmeKFRrOhd44bVjeVLuNxYR0gqlL/BQs
 5eOAMhrpVWFO4U0AEQEAAcLBfAQYAQoAJhYhBABMZH11cs99cr20+2mdhQqfQXvYBQJmWPoZ
 AhsMBQkFo5qAAAoJEGmdhQqfQXvYTd4P/AnTapTnwWRghTWfCn+LaUaXjd0xpnpBkaaIVGwT
 Lx2IllvEr5goBLgaJEvi8d6cjyUAmGQ1ywquO4LC3Z4VXENmSjQq6/coa4+pB8XtUqr9UjIc
 Q/HQalughXv5m4ivcBDAyKsrOy9F8v5YAhcWbMJQVt3lNmWnHaNHw8y4iZvSNAvYj2c5CYCE
 46KrIiIv+XN3gmNrNjhDS/VT14h9Rj0Hx2dt6LojH/qI1We5MnC48/pxa+QNeMPwe7h487i+
 rZwPgLRgq3nQ53uui0itxw9Lwu+evbGf4/JBio5VLQvs5tI9N4jyOoIvGHgp/W+BfLC6QZQX
 ZaqPQQfrqqDOhfMzHyHw7KowdK/6u1niWiPDSnxcDThj7qPdzfllMgYtsmAlzDoAVIn5tE+h
 2390h0KWwOesHCj1iagAtohWsTQ6MHCYo/S7RKjpU6AjLQwXpA8HIUb6q1jdZg1y4Pmr/Kh+
 JA87Kil/M8083wFhca5FwP5BaUdybDMzZr3sbZDdpDiwgh5MptM8+WN78WmLW1xtsE66ifFq
 ZFiBPEk1IUGvQJHs4LnFze6+rkq81vCEF8QSJ2cBSMgYDNH/388jas04RU9eUDK2FKoYVmX3
 zuD3jSTlGH13R9dwOq21NMusROzpLqGtNRKjYvcqsiwPID4IPw4TqRrSvCqJArHWLE25
In-Reply-To: <20251020220941.65269-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VcRtcne3V+y1ADXbpAEU8tN4eMHOcnQum/mvGqcrHEmM/OIVL5o
 OeoS5VIfZMJyKmP5BU8IG7QxuLOXiNuudCku4oHx6/M437pctDoqNMc1ZDZ2WA01IG6eYF8
 +KnKf+lpuzq1b2pv/HRu8G0xPLKnVZOE1Y0yTmMtXKR/DwL+o1itbSXnUKSdgDX2yqbQYpz
 +tGMYw+kiVo/0+ShbKeiw==
UI-OutboundReport: notjunk:1;M01:P0:SS+/M1zVTtY=;69HyGMKv96aOAVpSTDSioGwVSeJ
 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
 bWe8w==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=jan.kiszka@web.de;
 helo=mout.web.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 21.10.25 00:09, Philippe Mathieu-Daud=C3=A9 wrote:
> Register machines to be able to run with the qemu-system-arm
> and qemu-system-aarch64 binaries, except few machines which
> are only available on the qemu-system-aarch64 binary:
>=20

...

> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index 329b162eb20..548c218a039 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -15,6 +15,7 @@
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
>  #include "hw/arm/boot.h"
> +#include "hw/arm/machines-qom.h"
>  #include "net/net.h"
>  #include "system/system.h"
>  #include "hw/boards.h"
> @@ -1346,7 +1347,7 @@ static void musicpal_machine_init(MachineClass *mc=
)
>      machine_add_audiodev_property(mc);
>  }
> =20
> -DEFINE_MACHINE("musicpal", musicpal_machine_init)
> +DEFINE_MACHINE_ARM_AARCH64("musicpal", musicpal_machine_init)

This is modelling a real, ancient device which only had a single CPU
type and runs the original firmware - makes no sense.

Wouldn't be surprised if there are more of this kind in the list.

Jan


