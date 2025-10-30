Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641C2CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVrr-0000QD-9w; Thu, 30 Oct 2025 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1vEVro-0000NU-EO
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:51:17 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1vEVrb-0004Rv-N1
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:51:14 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1vEVrS-0001z8-IT; Thu, 30 Oct 2025 17:50:54 +0100
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1vEVrS-006F5R-0N;
 Thu, 30 Oct 2025 17:50:54 +0100
Received: from localhost ([127.0.0.1] helo=[IPv6:::1])
 by ptz.office.stw.pengutronix.de with esmtp (Exim 4.98.2)
 (envelope-from <jlu@pengutronix.de>) id 1vEVrR-00000001aOj-3xXW;
 Thu, 30 Oct 2025 17:50:54 +0100
Message-ID: <e609ef19aa3d3ed9d7d9c105052f5d8550de5cab.camel@pengutronix.de>
Subject: Re: [PATCH v5 2/6] hw/sd/sdcard: Allow user-instantiated eMMC
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>
Date: Thu, 30 Oct 2025 17:50:53 +0100
In-Reply-To: <90fc6201696fcf0e5fd0493365bc32b217aa9d6e.1760702638.git.jan.kiszka@siemens.com>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <90fc6201696fcf0e5fd0493365bc32b217aa9d6e.1760702638.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2a0a:edc0:2:b01:1d::104;
 envelope-from=jlu@pengutronix.de; helo=metis.whiteo.stw.pengutronix.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 2025-10-17 at 14:03 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Enable user-instantiation so that PCI-attached eMMCs can be created for
> virt machines, for QA purposes for the eMMC model itself and for complex
> firmware/OS integrations using the upcoming RPMB partition support.

Perhaps reword to "Enable user-instantiation so that eMMCs can be created f=
or
PCI-attached SD/MMC host controllers (such as sdhci-pci) on virt machines, =
..."
to match the actual bus hierarchy?

Jan

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  hw/sd/sd.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d1e1bb4f0e..305ea251cb 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2928,8 +2928,6 @@ static void emmc_class_init(ObjectClass *klass, con=
st void *data)
>      dc->desc =3D "eMMC";
>      dc->realize =3D emmc_realize;
>      device_class_set_props(dc, emmc_properties);
> -    /* Reason: Soldered on board */
> -    dc->user_creatable =3D false;
> =20
>      sc->proto =3D &sd_proto_emmc;
> =20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

