Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D94CCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETTd-0008H8-CA; Thu, 30 Oct 2025 10:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1vETTa-0008Ge-1n
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:18:06 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1vETTU-00050Y-10
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:18:05 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1vETTD-0008QC-Gb; Thu, 30 Oct 2025 15:17:43 +0100
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1vETTC-006E6H-39;
 Thu, 30 Oct 2025 15:17:42 +0100
Received: from localhost ([127.0.0.1] helo=[IPv6:::1])
 by ptz.office.stw.pengutronix.de with esmtp (Exim 4.98.2)
 (envelope-from <jlu@pengutronix.de>) id 1vETTC-00000001VWE-3Iiq;
 Thu, 30 Oct 2025 15:17:42 +0100
Message-ID: <c4482a93895563f2570c1632f9d4cdd0eade1255.camel@pengutronix.de>
Subject: Re: [PATCH v5 2/6] hw/sd/sdcard: Allow user-instantiated eMMC
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, "Daniel
 P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,  Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Ahmad Fatoum <afa@pengutronix.de>
Date: Thu, 30 Oct 2025 15:17:42 +0100
In-Reply-To: <e37fa4ac-b1c9-4b95-8904-7435d351f5a6@linaro.org>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <90fc6201696fcf0e5fd0493365bc32b217aa9d6e.1760702638.git.jan.kiszka@siemens.com>
 <aP9dvF1unTtLrSdQ@redhat.com>
 <9d287284-1cb2-4126-b7d7-9c57b32ce408@linaro.org>
 <aP9nCeWC-qr248iZ@redhat.com>
 <e37fa4ac-b1c9-4b95-8904-7435d351f5a6@linaro.org>
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

On Mon, 2025-10-27 at 13:44 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> On 27/10/25 13:35, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Oct 27, 2025 at 01:23:56PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > > On 27/10/25 12:55, Daniel P. Berrang=C3=A9 wrote:
> > > > On Fri, Oct 17, 2025 at 02:03:54PM +0200, Jan Kiszka wrote:
> > > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > >=20
> > > > > Enable user-instantiation so that PCI-attached eMMCs can be creat=
ed for
> > > > > virt machines, for QA purposes for the eMMC model itself and for =
complex
> > > > > firmware/OS integrations using the upcoming RPMB partition suppor=
t.
> > > >=20
> > > > IIUC, the 'emmc' device wants an 'sd-bus' but this commit talks abo=
ut
> > > > it being PCI-attached ?
> > >=20
> > > Sigh, it should not, but it got introduced this way and we didn't
> > > have time / energy / good reason to rework the code, which currently
> > > just works.
> > >=20
> > > SD / MMC cards -> plugged over external SD bus
> > >=20
> > > embedded MMC cards -> no SD bus, directly mmio-mapped.
> > >=20
> > > >=20
> > > > Can you elaborate on / illustrate the usage example for an end user=
 ?
> > >=20
> > > Saving time by testing virtual hardware, without having to implement =
a
> > > real model.
> >=20
> > Ok, more specifically, what are the suggested QEMU command line
> > args to make use of this with PCI ?
>=20
> See patch #6 documentation:
>=20
> +    -drive file=3Demmc.img,if=3Dnone,format=3Draw,id=3Demmc-img
> +    -device sdhci-pci
> +    -device=20
> emmc,drive=3Demmc-img,boot-partition-size=3D1048576,rpmb-partition-size=
=3D2097152

For example, our current use for an earlier variant of this can be seen her=
e:
https://github.com/rauc/rauc/blob/master/qemu-test#L79

  if "$QEMU_BIN" -device help | grep -q 'name "emmc"'; then
    echo "found emmc support, enabling"
    truncate -s 64M qemu-test-emmc.img
    QEMU_ARGS=3D"$QEMU_ARGS -drive if=3Dnone,id=3Demmc-drive,file=3Dqemu-te=
st-emmc.img,format=3Draw"
    QEMU_ARGS=3D"$QEMU_ARGS -device sdhci-pci"
    QEMU_ARGS=3D"$QEMU_ARGS -device emmc,id=3Demmc0,drive=3Demmc-drive,boot=
-partition-size=3D1048576"
  fi

We enable this only if our patched version of qemu [1] is found. For ARM
bootloader (OP-TEE and barebox) development and regression testing, we'd us=
e
this as well (with the RPMB emulation). Avoiding the need for a custom QEMU
build would help a lot. :)

Best regards,
Jan

[1] https://github.com/qemu/qemu/compare/master...jluebbe:qemu:user-emmc#di=
ff-e90f7f7336bf488567604b94aa0a3f5d272e392bca2e1e5c33c65f094c18466d
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

