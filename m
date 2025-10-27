Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48000CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMbw-0005DW-8b; Mon, 27 Oct 2025 08:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1vDMbt-0005C6-6o
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:46:05 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1vDMbj-0008QI-5O
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:46:03 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1vDMbX-0007r0-Uy; Mon, 27 Oct 2025 13:45:43 +0100
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1vDMbX-005htj-1y;
 Mon, 27 Oct 2025 13:45:43 +0100
Received: from localhost ([127.0.0.1] helo=[IPv6:::1])
 by ptz.office.stw.pengutronix.de with esmtp (Exim 4.98.2)
 (envelope-from <jlu@pengutronix.de>) id 1vDMbX-0000000825s-1kEw;
 Mon, 27 Oct 2025 13:45:43 +0100
Message-ID: <c432b92b0e7f1e6c19726029325f85efce242e5e.camel@pengutronix.de>
Subject: Re: [PATCH v5 2/6] hw/sd/sdcard: Allow user-instantiated eMMC
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, "Daniel
 P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>, 
 qemu-block@nongnu.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alex
 =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>
Date: Mon, 27 Oct 2025 13:45:42 +0100
In-Reply-To: <9d287284-1cb2-4126-b7d7-9c57b32ce408@linaro.org>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <90fc6201696fcf0e5fd0493365bc32b217aa9d6e.1760702638.git.jan.kiszka@siemens.com>
 <aP9dvF1unTtLrSdQ@redhat.com>
 <9d287284-1cb2-4126-b7d7-9c57b32ce408@linaro.org>
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

On Mon, 2025-10-27 at 13:23 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> On 27/10/25 12:55, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Oct 17, 2025 at 02:03:54PM +0200, Jan Kiszka wrote:
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > >=20
> > > Enable user-instantiation so that PCI-attached eMMCs can be created f=
or
> > > virt machines, for QA purposes for the eMMC model itself and for comp=
lex
> > > firmware/OS integrations using the upcoming RPMB partition support.
> >=20
> > IIUC, the 'emmc' device wants an 'sd-bus' but this commit talks about
> > it being PCI-attached ?
>=20
> Sigh, it should not, but it got introduced this way and we didn't
> have time / energy / good reason to rework the code, which currently
> just works.
>=20
> SD / MMC cards -> plugged over external SD bus
>=20
> embedded MMC cards -> no SD bus, directly mmio-mapped.

Hmm. This is not how I'd describe it and I've not seen directly MMIO mapped=
 MMC
cards.

Both eMMCs and SD cards are separate/physical devices connected via an SD/M=
MC
bus to a host controller. As both protocols are closely related, host contr=
oller
usually implement both protocols and can detect which one to use at runtime=
.

The host controller is connected to the CPU via a different bus, usually PC=
I(e)
(e.g. in a notebook) or just MMIO mapped (e.g. in an ARM SoC). SDHCI is the=
 most
common interface spec for SD/MMC controlers. So, you need to create two dev=
ice
(eMMC + SDHCI) for this to work with a generic x86_64 VM:
 -drive if=3Dnone,id=3Demmc-drive,file=3Demmc.img,format=3Draw \
 -device sdhci-pci \
 -device emmc,id=3Demmc0,drive=3Demmc-drive,boot-partition-size=3D1048576 \

If you emulate a machine/SoC which already has an integrated SD/MMC host
controler, you'd leave out the sdhci-pci device.

Regards,
Jan
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

