Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D90C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 12:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWDxs-00069X-9H; Mon, 30 Jun 2025 08:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWDxl-00068K-Jl; Mon, 30 Jun 2025 08:50:21 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWDxf-0000NR-Fq; Mon, 30 Jun 2025 08:50:20 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bW5b838jpz6DJ3B;
 Mon, 30 Jun 2025 20:49:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id CBD151402EC;
 Mon, 30 Jun 2025 20:49:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Jun
 2025 14:49:59 +0200
Date: Mon, 30 Jun 2025 13:49:57 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 25/32] hw/acpi/ged: Prepare the device to react to
 PCI hotplug events
Message-ID: <20250630134957.00006326@huawei.com>
In-Reply-To: <20250627095620.3300028-26-eric.auger@redhat.com>
References: <20250627095620.3300028-1-eric.auger@redhat.com>
 <20250627095620.3300028-26-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 27 Jun 2025 11:55:14 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> QEMU will notify the OS about PCI hotplug/hotunplug events through
> GED interrupts. Let the GED device handle a new PCI hotplug event.
> On its occurrence it calls the \\_SB.PCI0.PCNT method with the BLCK
> mutex held.
> 
> The GED device uses a dedicated MMIO region that will be mapped
> by the machine code.
> 
> At this point the GED still does not support PCI device hotplug in
> its TYPE_HOTPLUG_HANDLER implementation. This will come in a
> subsequent patch.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Maybe call out why you aren't following the advice in the
docs for device_class_set_legacy_reset() to use the resettable API. 

One other question inline about setting of the event bitmap in
ged_realize rather than create_acpi_ged() in virt.c

There is not obviously right answer to where that should be but
what you have here seems inconsistent with existing code s
a comment may makes sense if you leave it as it stands.

> 
> ---
> v3 -> v4:
> - add qbus_set_hotplug_handler
> - root bus is not passed in acpi_pcihp_init arg
> 
> v2 -> v3:
> - pcihp_init and reset are put in ged code instead of machine code
>   (Igor)
> - Add ACPI_GED_PCI_HOTPLUG_EVT event depending on use_acpi_hotplug_bridge
>   (Igor)
> 
> v1 -> v2:
> - Introduce ACPI_PCIHP_REGION_NAME

> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 92b931758f..fc84bfb34e 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c

> @@ -427,9 +437,13 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
>  {
>      SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      AcpiGedState *s = ACPI_GED(dev);
> +    AcpiPciHpState *pcihp_state = &s->pcihp_state;
>      uint32_t ged_events;
>      int i;
>  
> +    if (pcihp_state->use_acpi_hotplug_bridge) {
> +        s->ged_event_bitmap |= ACPI_GED_PCI_HOTPLUG_EVT;
> +    }

Maybe a comment on why this belongs insider the GED code rather
than being provided in the event_bitmap from virt.c or similar
as is done for all the over elements of ged_event_bitmap.

Particularly as you get the acpi_pcihp property in create_acpi_ged()
in patch 29.


>      ged_events = ctpop32(s->ged_event_bitmap);
>  



