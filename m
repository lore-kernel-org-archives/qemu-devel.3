Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3CECCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 19:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDpNW-00023a-7y; Tue, 28 Oct 2025 15:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vDpNU-00022Z-3W; Tue, 28 Oct 2025 15:29:08 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vDpNJ-0004jW-PD; Tue, 28 Oct 2025 15:29:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5717C5972E6;
 Tue, 28 Oct 2025 20:28:43 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id qSfD73BVld4K; Tue, 28 Oct 2025 20:28:41 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3B9B35972E3; Tue, 28 Oct 2025 20:28:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3972B5972E1;
 Tue, 28 Oct 2025 20:28:41 +0100 (CET)
Date: Tue, 28 Oct 2025 20:28:41 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 06/25] hw/pci-bridge: Use proper SysBus accessors
In-Reply-To: <20251028181300.41475-7-philmd@linaro.org>
Message-ID: <1e330577-64cb-14f5-88d0-20f1a23c4fb3@eik.bme.hu>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1308992722-1761679721=:26358"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1308992722-1761679721=:26358
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 28 Oct 2025, Philippe Mathieu-Daudé wrote:
> SysBusDevice::mmio[] is private data of SysBusDevice, use
> sysbus_mmio_get_region() to access it.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

I haven't reviewed this patch but the e500 one.

Regards,
BALATON Zoltan

> ---
> hw/pci-bridge/pci_expander_bridge.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 1bcceddbc4d..aa55749954a 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -157,9 +157,11 @@ static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
>     main_host = PCI_HOST_BRIDGE(pxb_dev_base->parent_bus->parent);
>     main_host_sbd = SYS_BUS_DEVICE(main_host);
>
> -    if (main_host_sbd->num_mmio > 0) {
> +    if (sysbus_has_mmio(main_host_sbd, 0)) {
> +        MemoryRegion *mr = sysbus_mmio_get_region(main_host_sbd, 0);
> +
>         return g_strdup_printf(HWADDR_FMT_plx ",%x",
> -                               main_host_sbd->mmio[0].addr, position + 1);
> +                               mr->addr, position + 1);
>     }
>     if (main_host_sbd->num_pio > 0) {
>         return g_strdup_printf("i%04x,%x",
>
--3866299591-1308992722-1761679721=:26358--

