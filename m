Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0314BC47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXb4-0006qs-Hz; Mon, 29 Jan 2024 14:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rUXan-0006cj-Rh; Mon, 29 Jan 2024 14:46:57 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rUXak-00078K-HT; Mon, 29 Jan 2024 14:46:52 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9FB514E6012;
 Mon, 29 Jan 2024 20:46:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id JX1PHC9kVR1W; Mon, 29 Jan 2024 20:46:41 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 99D024E6006; Mon, 29 Jan 2024 20:46:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 966427456B4;
 Mon, 29 Jan 2024 20:46:41 +0100 (CET)
Date: Mon, 29 Jan 2024 20:46:41 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 =?ISO-8859-15?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, mzamazal@redhat.com, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Laurent Vivier <laurent@vivier.eu>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 01/29] bulk: Access existing variables initialized to
 &S->F when available
In-Reply-To: <20240129164514.73104-2-philmd@linaro.org>
Message-ID: <fd790685-a98f-9cd5-c117-dac96564a71b@eik.bme.hu>
References: <20240129164514.73104-1-philmd@linaro.org>
 <20240129164514.73104-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1985250681-1706557601=:22604"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1985250681-1706557601=:22604
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 29 Jan 2024, Philippe Mathieu-Daudé wrote:
> When a variable is initialized to &struct->field, use it
> in place. Rationale: while this makes the code more concise,
> this also helps static analyzers.
>
> Mechanical change using the following Coccinelle spatch script:
>
> @@
> type S, F;
> identifier s, m, v;
> @@
>      S *s;
>      ...
>      F *v = &s->m;
>      <+...
> -    &s->m
> +    v
>      ...+>
>
> Inspired-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> hw/display/ati.c              |  2 +-
> hw/misc/macio/pmu.c           |  2 +-
> hw/misc/pvpanic-pci.c         |  2 +-
> hw/pci-bridge/cxl_root_port.c |  2 +-
> hw/ppc/pnv.c                  | 20 ++++++++++----------
> hw/virtio/vhost-user-gpio.c   |  8 ++++----
> hw/virtio/vhost-user-scmi.c   |  6 +++---
> hw/virtio/virtio-pci.c        |  2 +-
> hw/xen/xen_pt.c               |  6 +++---
> migration/multifd-zlib.c      |  2 +-
> target/arm/cpu.c              |  4 ++--
> target/arm/kvm.c              |  2 +-
> target/arm/machine.c          |  6 +++---
> target/i386/hvf/x86hvf.c      |  2 +-
> target/m68k/helper.c          |  2 +-
> target/ppc/kvm.c              |  8 ++++----
> target/riscv/cpu_helper.c     |  2 +-
> 17 files changed, 39 insertions(+), 39 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 569b8f6165..8d2501bd82 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -991,7 +991,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
>     }
>     vga_init(vga, OBJECT(s), pci_address_space(dev),
>              pci_address_space_io(dev), true);
> -    vga->con = graphic_console_init(DEVICE(s), 0, s->vga.hw_ops, &s->vga);
> +    vga->con = graphic_console_init(DEVICE(s), 0, s->vga.hw_ops, vga);
>     if (s->cursor_guest_mode) {
>         vga->cursor_invalidate = ati_cursor_invalidate;
>         vga->cursor_draw_line = ati_cursor_draw_line;
> diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
> index e9a90da88f..7fe1c4e517 100644
> --- a/hw/misc/macio/pmu.c
> +++ b/hw/misc/macio/pmu.c
> @@ -737,7 +737,7 @@ static void pmu_realize(DeviceState *dev, Error **errp)
>     timer_mod(s->one_sec_timer, s->one_sec_target);
>
>     if (s->has_adb) {
> -        qbus_init(&s->adb_bus, sizeof(s->adb_bus), TYPE_ADB_BUS,
> +        qbus_init(adb_bus, sizeof(s->adb_bus), TYPE_ADB_BUS,

Probably should change to use sizeof(*adb_bus) too. Although the next line 
is the only place the adb_bus local is used so maybe can drop the local 
and chnage next line to use &s->adb_bus instead.

Regards,
BALATON Zoltan

>                   dev, "adb.0");
>         adb_register_autopoll_callback(adb_bus, pmu_adb_poll, s);
>     }
--3866299591-1985250681-1706557601=:22604--

