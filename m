Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F67ACD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 18:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpupJ-0008BR-Ja; Thu, 28 Mar 2024 14:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rpupF-0008Ar-13
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 14:50:09 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rpupD-0002bc-9l
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 14:50:08 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CE83F4E6060;
 Thu, 28 Mar 2024 19:50:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 0upp1RZ_X_JD; Thu, 28 Mar 2024 19:50:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CC71F4E605E; Thu, 28 Mar 2024 19:50:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C93987456B4;
 Thu, 28 Mar 2024 19:50:01 +0100 (CET)
Date: Thu, 28 Mar 2024 19:50:01 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 Anthony Perard <anthony.perard@citrix.com>, 
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [RFC PATCH-for-9.1 13/29] hw/i386/pc: Remove non-PCI code from
 pc_system_firmware_init()
In-Reply-To: <20240328155439.58719-14-philmd@linaro.org>
Message-ID: <1578f958-8464-f124-3a40-464f932161c4@eik.bme.hu>
References: <20240328155439.58719-1-philmd@linaro.org>
 <20240328155439.58719-14-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-274745813-1711651801=:36462"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-274745813-1711651801=:36462
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 28 Mar 2024, Philippe Mathieu-Daudé wrote:
> x86_bios_rom_init() is the single non-PCI-machine call
> from pc_system_firmware_init(). Extract it to the caller.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> hw/i386/pc.c       | 6 +++++-
> hw/i386/pc_sysfw.c | 5 +----
> 2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f184808e3e..5b96daa414 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -956,7 +956,11 @@ void pc_memory_init(PCMachineState *pcms,
>     }
>
>     /* Initialize PC system firmware */
> -    pc_system_firmware_init(pcms, rom_memory);
> +    if (pci_enabled) {
> +        pc_system_firmware_init(pcms, rom_memory);
> +    } else {
> +        x86_bios_rom_init(machine, "bios.bin", rom_memory, true);
> +    }
>
>     option_rom_mr = g_malloc(sizeof(*option_rom_mr));
>     memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 862a082b0a..541dcaef71 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -202,10 +202,7 @@ void pc_system_firmware_init(PCMachineState *pcms,

Maybe also rename to pc_pci_firmware_init() to make  it clear this is only 
for PCI PC machine now?

Regards,
BALATON Zoltan

>     int i;
>     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>
> -    if (!pc_machine_is_pci_enabled(pcms)) {
> -        x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, true);
> -        return;
> -    }
> +    assert(pc_machine_is_pci_enabled(pcms));
>
>     /* Map legacy -drive if=pflash to machine properties */
>     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
>
--3866299591-274745813-1711651801=:36462--

