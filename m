Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA7DC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 03:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPZou-0008LF-KC; Thu, 04 Jul 2024 23:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sPZot-0008KR-EX; Thu, 04 Jul 2024 23:41:11 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sPZor-0003Nr-Nk; Thu, 04 Jul 2024 23:41:11 -0400
Received: from [192.168.68.112]
 (ppp118-210-145-155.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.145.155])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 49C5D20127;
 Fri,  5 Jul 2024 11:41:06 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1720150866;
 bh=qz/mGvu3wG8HLxNI7YHtOWWbBV1t1vAFTBeS+dIApW4=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=XhL1U/9+qEhope8vYOD3/36x5NyUC3zUme9SohnJJQ7z5jWgvcAukfHWvHul3SoGe
 +ReKddQwGQzOutbuny9e0JU+VwgaTe6VT+S7FN3TJtDgVP2CohqpP7XUinWCnwjRMN
 tLOIOcAK9phh6FLL7O+9iMHY5b85uBi6llAb2uuAH+/QEssBcqWoDPOi/jk3RnpayY
 qxEwgo9h4+ayRqZfVb5ZvAiiwXGuQWI7XNnyDwWWVZOnYvcz9RZsKO71tW1DF3KwXN
 fnbNnfJDvdYMpKLY+TE5IIUkzAKZHOmBacw8IPSJse4Y+8sqHwx9Fn7Rjfc1U66fYh
 BDC5P/SUKEcRw==
Message-ID: <f50579b99ef8883dac5fcfc1606a45abfb8bf85f.camel@codeconstruct.com.au>
Subject: Re: [PATCH 5/8] aspeed: Set eMMC 'boot-config' property to reflect
 HW strapping
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Peter
 Maydell <peter.maydell@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Date: Fri, 05 Jul 2024 13:11:05 +0930
In-Reply-To: <20240704053651.1100732-6-clg@redhat.com>
References: <20240704053651.1100732-1-clg@redhat.com>
 <20240704053651.1100732-6-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Thu, 2024-07-04 at 07:36 +0200, C=C3=A9dric Le Goater wrote:
> From: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> When the boot-from-eMMC HW strapping bit is set, use the 'boot-config'
> property to set the boot config register to boot from the first boot
> area partition of the eMMC device.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/arm/aspeed.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 756deb91efd1..135f4eb72215 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -327,7 +327,8 @@ void aspeed_board_init_flashes(AspeedSMCState *s, con=
st char *flashtype,
>      }
>  }
> =20
> -static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool=
 emmc)
> +static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool=
 emmc,
> +                               bool boot_emmc)
>  {
>          DeviceState *card;
> =20
> @@ -335,6 +336,9 @@ static void sdhci_attach_drive(SDHCIState *sdhci, Dri=
veInfo *dinfo, bool emmc)
>              return;
>          }
>          card =3D qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
> +        if (emmc) {
> +            qdev_prop_set_uint8(card, "boot-config", boot_emmc ? 0x48 : =
0x0);

0x48 feels a little bit magic. I poked around a bit and there are some
boot-config macros, but not the ones you need and they're all in an
"internal" header anyway. I guess this is fine for now?

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

