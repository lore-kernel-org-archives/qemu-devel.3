Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE60C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzm5-0005yD-Jz; Thu, 20 Aug 2026 06:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@web.de>)
 id 1wwzm4-0005y1-MF; Thu, 20 Aug 2026 06:13:28 -0400
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@web.de>)
 id 1wwzm2-0001HP-Oe; Thu, 20 Aug 2026 06:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1787220802; x=1787825602; i=jan.kiszka@web.de;
 bh=zs+zrWvyvphFF2/BgQmKiWjJIkP6UhPtUx4gq2oQztM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=enV/1W88EJl+eXPqOrXu4d+UX53mCtSqwyXcYKdawQtZGeCStg4o9H/cgvDkIVGY
 sn5tDkj/cqpWULupfrVNhW2JKK/91te4bn0Yu8YBlPzqGGec9HGct+gsT6xgxWjBm
 PlW4IuTNRAAAUmnydCQUfxks4/Hvpn8G7qw5FGqiLYJ8FFSaKuI1ZAq95TUDXB+H7
 B8DCTD+HX93xn5bHwUR3nWE+UfuR7Od+dvD9GSWcAGr9Xvj+lvqNBpj0Vvpk1P0lA
 /o4R0okGqDZ7Ltn10RVqaV2DCyDSAwdyB/wHd6kTUvOeVUuzCbC/RfhodX3UTol7y
 ukOnibVuE59V4g56ew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qhD-1x0YY33FrR-000V8u; Thu, 20
 Aug 2026 12:13:22 +0200
Message-ID: <36b30ec6-30cc-4d91-adf4-d901c12d23f1@web.de>
Date: Thu, 20 Aug 2026 12:13:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] arm: Remove the 'musicpal' machine
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260819185430.3467629-1-peter.maydell@linaro.org>
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
In-Reply-To: <20260819185430.3467629-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0p3FXNdm/zTnmlVwpDzDPn1EMhbcY5JyZWBtHOpWqROsfP+l3pV
 Oo2bWkDCSGzIGM7Gz4AQ9tyQKFC2zg7UbF/k7udiJPNTlWLisehOrcnShgakfzHon8/2AZt
 04Or0GikjwniZXurBZ65eMYKWVLj1E3FweY4ZQwiPgumVh6q4RqofkP3wbL1yT8L+rGRGaQ
 vJ8Gcd+c0G46LpPSzYtSA==
UI-OutboundReport: notjunk:1;M01:P0:9n68JAx7UU8=;2leoRTxS6pQGWbNZlM+WUguRKp0
 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
 =
Received-SPF: pass client-ip=217.72.192.78; envelope-from=jan.kiszka@web.de;
 helo=mout.web.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19.08.26 20:54, Peter Maydell wrote:
> The 'musicpal' machine emulates the Freecom MusicPal, which was an
> "internet radio" released in the mid-2000s.  The stock system used a
> 2.6.16 Linux kernel, but as far as I'm aware, support for the
> hardware was never upstreamed to the mainline kernel.

Right. I once talked to the developer at Freecom behind the software,
but they were already in maintenance mode and apparently had neither the
power nor the will to influence Marvell on this.

>=20
> There are a number of reasons for deprecating this board:
>  * The hardware is now solidly obsolete
>  * It was never supported in mainline Linux
>  * The SoC is a Marvell one with no public datasheet
>  * The only QEMU changes to it have been the usual tree wide
>    updates and refactoring work
>  * We have no test image for it that we can distribute
>  * The only bug report we've ever had about it has been one of
>    the usual "bug found by static analysis" kind (#4135)
>=20
> But in fact we can just drop it immediately, because in commit
> 59754f85ed35 ("target/arm: Do memory type alignment check when
> translation disabled") in 2024 we broke the boot of the standard
> firmware image for this board.  (The image's u-boot does a LDRH to an
> unaligned address, which is UNPREDICTABLE; we used to let it through,
> but that commit makes it take a Data Abort, so the image crashes
> before it boots the kernel.) Since nobody complained, we can deduce
> that nobody's actually using this machine.
>=20
> This patchset first fixes up a couple of places (notably the
> pflash_cfi02 tests) that were using or referring to the musicpal
> board; then it removes the board, followed by the devices used only by
> that board.
>=20
> Strictly speaking it's possible that somebody is using this machine
> with some other image that doesn't have the same "does an unaligned
> LDRH" problem the stock firmware image does; but it seems unlikely
> to me. We can take the standard "deprecate for two releases, then
> drop" route if people prefer that.
>=20
> I do also have a patch which reverts the "take a Data Abort on
> unaligned access" change for v5 and v6-with-SCTLR.U=3D0 CPUs, which I'll
> post separately.
>=20
> thanks
> -- PMM
>=20
> Peter Maydell (5):
>   tests/qtest/pflash-cfi02-test: Don't use musicpal machine for testing
>   hw/arm: Remove spurious WM8750 dependency from Realview Kconfig
>   hw/arm: Remove the 'musicpal' machine
>   hw: Remove Marvell 88W8618 devices
>   hw/audio: Remove wm8750 I2C audio device
>=20
>  MAINTAINERS                             |   10 -
>  configs/devices/arm-softmmu/default.mak |    1 -
>  docs/about/removed-features.rst         |   10 +
>  docs/system/arm/musicpal.rst            |   19 -
>  docs/system/target-arm.rst              |    1 -
>  hw/arm/Kconfig                          |   16 -
>  hw/arm/meson.build                      |    1 -
>  hw/arm/musicpal.c                       | 1388 -----------------------
>  hw/audio/Kconfig                        |    4 -
>  hw/audio/marvell_88w8618.c              |  315 -----
>  hw/audio/meson.build                    |    2 -
>  hw/audio/wm8750.c                       |  738 ------------
>  hw/net/meson.build                      |    1 -
>  hw/net/mv88w8618_eth.c                  |  403 -------
>  include/hw/audio/wm8750.h               |   30 -
>  include/hw/net/mv88w8618_eth.h          |   13 -
>  tests/qtest/meson.build                 |    6 +-
>  tests/qtest/pflash-cfi02-test.c         |   38 +-
>  18 files changed, 36 insertions(+), 2960 deletions(-)
>  delete mode 100644 docs/system/arm/musicpal.rst
>  delete mode 100644 hw/arm/musicpal.c
>  delete mode 100644 hw/audio/marvell_88w8618.c
>  delete mode 100644 hw/audio/wm8750.c
>  delete mode 100644 hw/net/mv88w8618_eth.c
>  delete mode 100644 include/hw/audio/wm8750.h
>  delete mode 100644 include/hw/net/mv88w8618_eth.h
>=20

RIP - no problems with this. At least it was allowed to turn 18 years
in-tree. ;)

Acked-by: Jan Kiszka <jan.kiszka@web.de>

Fun fact: My real device that once motivated this reverse-engineered
machine model is still alive and basically working. Its hard-coded
web-radio service is dead by now, but manually entered streams still
work. Only the power supply had to be replace a while ago.

Jan


