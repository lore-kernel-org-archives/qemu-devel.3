Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01ADBC5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSoS-0007TB-Sm; Thu, 27 Aug 2026 01:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzSoM-0007SR-Re; Thu, 27 Aug 2026 01:38:02 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzSoK-0002Sg-5d; Thu, 27 Aug 2026 01:38:02 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id B24E2EC012A;
 Thu, 27 Aug 2026 01:37:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 27 Aug 2026 01:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1787809076; x=1787895476; bh=+mCjXoth4Le30Hs19TlIAwUeDAUiQx5w
 lwyyXe5tZZ8=; b=dmxWSh8ws7A3s+ZNeDqNoi4Yl+y98JIiq++1cxEv3PteIAzB
 XpnybYzt5gknerrI/drDw3IaK6BKrHDKu1qhX8FCsx4/JOdFhyHkcrleQskLrZF5
 tzCuX2zaXAb7k/07T9dJA2IDw609dt5X8ZXAqRxrm0/WDr0fIIiB1QfjqcqEAL3N
 mpF3OeNy8EFDwxkL3T+x+NqbtUqC6nhl1e6i+sg1J6Vm4aKZITHWvs02Vak/Yb6n
 ogmgneaqj8Kyf12xOnuksO9aTyH0bSssdo/1M+jFL9XadxWcwltfZZ1aAP3F8cXS
 EOpOzOXEHfSCIVh1/MIbbD4yUlMCtE/SNSquYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787809076; x=
 1787895476; bh=+mCjXoth4Le30Hs19TlIAwUeDAUiQx5wlwyyXe5tZZ8=; b=a
 RJECmbJUD85EkP5mwx/Mq2Tv/aU369EOD50ahwd9ZAjii6rrOIVa491+eI/N2k6W
 hea13FMl0deS4aBNmWTedOF6DddJ5OgvaVX0lZshPd0zXsr2WHY3xZrdX3HGDM6a
 tS8fNnjVxUgSBzY08zMlzW7Ax60RPyy3wfkczq+vumnPkObdyLRJHNpCScnjV7Df
 wST0YOXIuxL3fxtiETAXThXzomzH1qwBdHVyVzr0v/3ieDg1hleL6e/T+btEjAjn
 eGlaATlZ5nS7CzVSF2a3BZWqDxiNg3sqzvZZ7RHxzENs1MUidKcybkgmUXTqitGi
 WiZ3G9fGxK3jX6Mh/vjtw==
X-ME-Sender: <xms:M82Pah0cernEvpSnei6_AF7gw-sifw8GHp9jiubJ9cplUVrwa8VYjQ>
 <xme:M82PaptlCwOeY3Ci5GsNfaR0Ott8cwcmed0G9si7Gvy1anpfTCmwmAEqj8vzB7PDX
 lDZFbgY2cizgzetyHupKu-aK7JVmUitFFnVGjG9Y3cAoQ_CbeZZObA>
X-ME-Received: <xmr:M82Pagkv-UEdEWhMogVM8QtkGsYj1LSjpEe9gyl_xZLz3YSjCwJ4VaX9o8MYhtXWwH2UZobbAN9n7IQVb5LkPPgue4c>
X-ME-Proxy-Cause: dmFkZTFr5Khk0hnoPo3hr1tAQnrUpRBiYv3THCUXV4xHo4PuqEsl9OTRcSz1YGo5CXYzUz
 uVf5P442UGDVBZ82XS+XzRLYoxSmemZoVXNe32WyusYf4mBFrgFQ9JBrc46HOG1xmHM3Ev
 ExDX06tHF9Qu37R09vwAlvZYp/wmTKGnyZkKjO9EFzVuC61c+8w6RbrSZZfj71hZZmXfRu
 w4IPcIvUgZBltzHQRjtl1WbjgBCw5RxdUsIycCwLMvP6cWHyh9dCjHK3yOaSCE89X4vfVt
 C1Bw6z9bBEyshuMLGWvY4NBIMqdhqgpS398haismQMNHJXp3X0EOL0AG+TRmeFhM3KJhar
 EQFk0XV4vRiBVAPjiAWsJ5ZHXy1h2pQrpajDmvbZWoaPwAClK+bo9RO1iSrHt6gukbhJC2
 fqVnsqMJNP+ebnu+6rfChxlt0zb1Mf3+PjXAAhsxIOkA5pjYOXjeJpE2G0kgRjwBr0DTWq
 I7/RrmbSYIf4gO3K8nZOtfcyqn12mkiJfskF4OrJTne+asCfoibJTba5unhNQ3YyulnE8N
 qPpvVNDabEl0PiWQ8CiyAPFS1PMhf1nF3E7VUJeFtpUXn4PeOFaEwZoPmU0JR6/EEdFK9n
 yZDAmFoxgEpnREdj4D94owAs0lhn+eabctStXl6iWIOekv5+yzSVJr1hJQTQ
X-ME-Proxy: <xmx:M82PanV0ntmiXEKbotE1YUsNMmDLr2zOmODWM-YF4Dl6sE_kQ4-RWQ>
 <xmx:M82PakvKmGD-TFpYoOZG_p3Ykk0Zf-v4Bc_bjf0MVZQzV7BV95SzGg>
 <xmx:M82PaqqNoj1MVY9cjs4oAFU6-BrORbVXfDP3R571c4BrHJdR5fFpNg>
 <xmx:M82Pap7u4kvboAEK7a5XACnSxHOgEj9gSwnJXqC7FNEXIEK2HwCFWQ>
 <xmx:NM2PamflruzU5pGYiedx8pUCMx40Usc2nPI8orKFQ3LbuXBJ0ZagmUbK>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 01:37:48 -0400 (EDT)
Message-ID: <d88347aa69db68c498b593eabcd2377413ff4af5.camel@alistair23.me>
Subject: Re: [PATCH 0/4] Rename ssi_transfer to ssi_transfer8
From: Alistair <alistair@alistair23.me>
To: stephensportia@gmail.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell	 <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 	qemu-ppc@nongnu.org,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Troy Lee	 <leetroy@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@mailo.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Nicholas Piggin	 <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Kane Chen	 <kane_chen@aspeedtech.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 Glenn Miles <milesg@linux.ibm.com>, 	qemu-riscv@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
Date: Thu, 27 Aug 2026 15:37:46 +1000
In-Reply-To: <20260825040452.1322251-1-stephensportia@gmail.com>
References: <20260825040452.1322251-1-stephensportia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=alistair@alistair23.me; helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Tue, 2026-08-25 at 14:04 +1000, stephensportia@gmail.com wrote:
> From: Portia Stephens <portias@oss.tenstorrent.com>
>=20
> The ssi_transfer function comments say that it takes a word varying
> between 8-bits and 32-bits. ssi_transfer takes a 32-bit arg to
> transfer
> but there is no means to indicate the number of bits that should
> actually be transferred. All child classes of SSI_PERIPHERAL class
> have
> transfer functions that, despite accepting a 32-bit tx, only transfer
> a
> single byte; m25p80_transfer8(), ssi_sd_transfer(),
> ssd0323_transfer().
>=20
> The current implementation depends on the SSI model to know
> what peripheral model will be attached and what transfer size it
> expects which is error prone. If a SSI_PERIPHERAL model was written
> that
> accepted 32-bit transfers, it could not attach to any existing SSI
> models.
>=20
> This change updates the the naming of ssi_transfer to ssi_transfer8,
> as
> well as changes the return value and transmit argument to be 8-bit.
>=20
> Most ssi models handle this correctly already, sending a single byte
> at
> a time. There are a few models that are written to support non 8-bit
> transfers but there are no in-tree use cases that connect a
> peripheral
> to the SSI device. These have been updated to use 8-bit transfers.
>=20
> Portia Stephens (4):
> =C2=A0 hw/ssi: Rename ssi_transfer to ssi_transfer8
> =C2=A0 hw/ssi/pl022: Fix dropped upper bytes of ssi transfer
> =C2=A0 hw/arm/strongarm: Fix dropped upper byte of ssi transfer
> =C2=A0 hw/ssi/pnv_spi: Fix dropped upper bytes of ssi transfer

Thanks!

Applied to riscv-to-apply.next

Alistair

>=20
> =C2=A0hw/arm/strongarm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 7 +++++--
> =C2=A0hw/ssi/allwinner-a10-spi.c |=C2=A0 2 +-
> =C2=A0hw/ssi/aspeed_smc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 =
++++++-------
> =C2=A0hw/ssi/bcm2835_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 =
+-
> =C2=A0hw/ssi/ibex_spi_host.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> =C2=A0hw/ssi/imx_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0hw/ssi/mss-spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0hw/ssi/npcm7xx_fiu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 42 +++++=
++++++++++++++-----------------
> --
> =C2=A0hw/ssi/npcm_pspi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 4 ++--
> =C2=A0hw/ssi/pl022.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 12 +++++++----
> =C2=A0hw/ssi/pnv_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 28 ++++++++++---------------
> =C2=A0hw/ssi/sifive_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> =C2=A0hw/ssi/ssi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0hw/ssi/stm32f2xx_spi.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0hw/ssi/xilinx_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 =
++++-----
> =C2=A0hw/ssi/xilinx_spips.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0hw/ssi/xlnx-versal-ospi.c=C2=A0 |=C2=A0 4 ++--
> =C2=A0include/hw/ssi/ssi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++=
+++-------
> =C2=A018 files changed, 82 insertions(+), 81 deletions(-)

