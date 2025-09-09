Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BC3CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvyOn-000478-BM; Tue, 09 Sep 2025 09:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1uvyOl-00046o-FD
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:28:39 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1uvyOi-0008Ss-If
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:28:39 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1uvyOa-0006o8-3n; Tue, 09 Sep 2025 15:28:28 +0200
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1uvyOZ-000Qdj-1U;
 Tue, 09 Sep 2025 15:28:27 +0200
Received: from localhost ([127.0.0.1] helo=[IPv6:::1])
 by ptz.office.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1uvyOZ-00FmkC-0w;
 Tue, 09 Sep 2025 15:28:27 +0200
Message-ID: <4d7760a559948fe8b16517fd4a17abde0606bae5.camel@pengutronix.de>
Subject: Re: [PATCH v3 6/6] docs: Add eMMC device model description
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>
Date: Tue, 09 Sep 2025 15:28:26 +0200
In-Reply-To: <2a8d6226903d8dcf9615b5ac5a40522b6bf2f7c3.1757422256.git.jan.kiszka@siemens.com>
References: <cover.1757422256.git.jan.kiszka@siemens.com>
 <2a8d6226903d8dcf9615b5ac5a40522b6bf2f7c3.1757422256.git.jan.kiszka@siemens.com>
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
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

On Tue, 2025-09-09 at 14:50 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  docs/system/device-emulation.rst |  1 +
>  docs/system/devices/emmc.rst     | 52 ++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 docs/system/devices/emmc.rst
>=20
> diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulat=
ion.rst
> index 911381643f..36429b1d17 100644
> --- a/docs/system/device-emulation.rst
> +++ b/docs/system/device-emulation.rst
> @@ -101,3 +101,4 @@ Emulated Devices
>     devices/canokey.rst
>     devices/usb-u2f.rst
>     devices/igb.rst
> +   devices/emmc.rst
> diff --git a/docs/system/devices/emmc.rst b/docs/system/devices/emmc.rst
> new file mode 100644
> index 0000000000..3bd70c0e94
> --- /dev/null
> +++ b/docs/system/devices/emmc.rst
> @@ -0,0 +1,52 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +eMMC Emulation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Besides SD card emulation, QEMU also offers an eMMC model as found on ma=
ny
> +embedded boards. An eMMC, just like an SD card, is connected to the mach=
ine
> +via an SDHCI controller.
> +
> +Create eMMC Images
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A recent eMMC consists of 4 partitions: 2 boot partitions, 1 Replay prot=
ected
> +Memory Block (RPMB), and the user data area. QEMU expects backing images=
 for
> +the eMMC to contain those partitions concatenated in exactly that order.
> +However, the boot partitions as well as the RPMB might be absent if thei=
r sizes
> +are configured to zero.
> +
> +The eMMC specification defines alignment constraints for the partitions.=
 The
> +two boot partitions must be of the same size. Furthermore, boot and RPMB
> +partitions must be multiples of 128 KB with a maximum of 32640 KB for ea=
ch
> +boot partition and 16384K for the RPMB partition.
> +
> +The alignment constrain of the user data area depends on its size. Up to=
 2
> +GByte, the size must be a power of 2. From 2 GByte onward, the size has =
to be
> +multiples of 512 byte.
> +
> +QEMU is enforcing those alignment rules before instantiating the device.
> +Therefore, the provided image has to strictly follow them as well. The h=
elper
> +script `scripts/mkemmc.sh` can be used to create compliant images, with =
or
> +without pre-filled partitions. E.g., to create an eMMC image from a firm=
ware
> +image and an OS image with an empty 2 MByte RPMB, use the following comm=
and:
> +
> +.. code-block:: console
> +
> +    scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img
> +
> +This will take care of rounding up the partition sizes to the next valid=
 value
> +and will leave the RPMB and the second boot partition empty (zeroed).
> +
> +Adding eMMC Devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +An eMMC is either automatically created by a machine model (e.g. Aspeed =
boards)
> +or can be user-created when using a PCI-attached SDHCI controller. To
> +instantiate the eMMC image form the example above while assuming that th=
e

s/form/from/

> +firmware needs a boot partitions of 1 MB, use the following options:
> +
> +.. code-block:: console
> +
> +    -drive file=3Demmc.img,if=3Dnone,format=3Draw,id=3Demmc-img
> +    -device sdhci-pci
> +    -device emmc,drive=3Demmc-img,boot-partition-size=3D1048576 rpmb-par=
tition-size=3D2097152

Missing ',' before rpmb-partition-size?

Thanks,
Jan
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

