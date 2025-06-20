Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B142C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 09:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXgu-0000O8-AJ; Fri, 20 Jun 2025 05:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSXgl-0000LJ-Cc; Fri, 20 Jun 2025 05:05:35 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSXgh-0004lw-SK; Fri, 20 Jun 2025 05:05:35 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNs2J4pG7z6L59y;
 Fri, 20 Jun 2025 17:03:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id BD3DA1402FE;
 Fri, 20 Jun 2025 17:05:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 11:05:22 +0200
Date: Fri, 20 Jun 2025 10:05:20 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 15/29] hw/i386/acpi-build: Use AcpiPciHpState::root
 in acpi_set_pci_info
Message-ID: <20250620100520.00006e4b@huawei.com>
In-Reply-To: <20250616094903.885753-16-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-16-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 16 Jun 2025 11:46:44 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> pcihp acpi_set_pci_info() generic code currently uses
> acpi_get_i386_pci_host() to retrieve the pci host bridge.
> 
> To make it work also on ARM we get rid of that call and
> directly use AcpiPciHpState::root.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
Nice

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
> ---
> 
> v2 -> v3:
> - Use AcpiPciHpState::root
> 
> v1 -> v2
> - described the fact we changed the implementation of
>   acpi_get_pci_host() in the commit msg.
> ---
>  hw/acpi/pcihp.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 236e175b69..e79a24b821 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -99,10 +99,10 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
>      return info;
>  }
>  
> -static void acpi_set_pci_info(bool has_bridge_hotplug)
> +static void acpi_set_pci_info(AcpiPciHpState *s)
>  {
>      static bool bsel_is_set;
> -    Object *host = acpi_get_i386_pci_host();
> +    bool has_bridge_hotplug = s->use_acpi_hotplug_bridge;
>      PCIBus *bus;
>      BSELInfo info = { .bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT,
>                        .has_bridge_hotplug = has_bridge_hotplug };
> @@ -112,11 +112,8 @@ static void acpi_set_pci_info(bool has_bridge_hotplug)
>      }
>      bsel_is_set = true;
>  
> -    if (!host) {
> -        return;
> -    }
>  
> -    bus = PCI_HOST_BRIDGE(host)->bus;
> +    bus = s->root;
>      if (bus) {
>          /* Scan all PCI buses. Set property to enable acpi based hotplug. */
>          pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &info);
> @@ -266,7 +263,7 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
>  
>  void acpi_pcihp_reset(AcpiPciHpState *s)
>  {
> -    acpi_set_pci_info(s->use_acpi_hotplug_bridge);
> +    acpi_set_pci_info(s);
>      acpi_pcihp_update(s);
>  }
>  


