Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD2FCD11DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 18:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpurP-0000Y1-49; Thu, 28 Mar 2024 14:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rpurN-0000Xn-LJ
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 14:52:21 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rpurM-00032N-7E
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 14:52:21 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 134EF4E605E;
 Thu, 28 Mar 2024 19:52:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id wubAWF9IEmeT; Thu, 28 Mar 2024 19:52:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1E0994E6061; Thu, 28 Mar 2024 19:52:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1C0297456B4;
 Thu, 28 Mar 2024 19:52:17 +0100 (CET)
Date: Thu, 28 Mar 2024 19:52:17 +0100 (CET)
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
Subject: Re: [RFC PATCH-for-9.1 14/29] hw/i386/pc: Move
 pc_system_flash_create() to pc_pci_machine_initfn()
In-Reply-To: <20240328155439.58719-15-philmd@linaro.org>
Message-ID: <2725fdba-465e-7f74-c354-57b88994a2ed@eik.bme.hu>
References: <20240328155439.58719-1-philmd@linaro.org>
 <20240328155439.58719-15-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-671172952-1711651937=:36462"
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

--3866299591-671172952-1711651937=:36462
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 28 Mar 2024, Philippe Mathieu-Daudé wrote:
> pc_system_flash_create() is only useful for PCI-based machines.
> Move the call to the PCI-based init() handler.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> hw/i386/pc.c       |  2 +-
> hw/i386/pc_sysfw.c | 10 ++++------
> 2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 5b96daa414..33724791fd 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1679,7 +1679,6 @@ static void pc_machine_initfn(Object *obj)
>     pcms->fd_bootchk = true;
>     pcms->default_bus_bypass_iommu = false;
>
> -    pc_system_flash_create(pcms);
>     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
>     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
>                               OBJECT(pcms->pcspk), "audiodev");
> @@ -1694,6 +1693,7 @@ static void pc_pci_machine_initfn(Object *obj)
>
>     ppms->acpi_build_enabled = true;
>
> +    pc_system_flash_create(PC_MACHINE(obj));
>     cxl_machine_init(obj, &ppms->cxl_devices_state);
>
>     ppms->machine_done.notify = pc_pci_machine_done;
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 541dcaef71..167ff24fcb 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -93,12 +93,10 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
>
> void pc_system_flash_create(PCMachineState *pcms)
> {
> -    if (pc_machine_is_pci_enabled(pcms)) {
> -        pcms->flash[0] = pc_pflash_create(pcms, "system.flash0",
> -                                          "pflash0");
> -        pcms->flash[1] = pc_pflash_create(pcms, "system.flash1",
> -                                          "pflash1");
> -    }
> +    assert(pc_machine_is_pci_enabled(pcms));
> +
> +    pcms->flash[0] = pc_pflash_create(pcms, "system.flash0", "pflash0");
> +    pcms->flash[1] = pc_pflash_create(pcms, "system.flash1", "pflash1");
> }

This could just be inlined as it's called once, then no need for assert 
and a separate function.

Regards,
BALATON Zoltan

>
> void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>
--3866299591-671172952-1711651937=:36462--

