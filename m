Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A70CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 10:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssgaT-0006Ci-85; Mon, 23 Sep 2024 06:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ssgaP-0006AK-CH; Mon, 23 Sep 2024 06:46:34 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ssgaN-0007Ha-VG; Mon, 23 Sep 2024 06:46:33 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BA6364E6027;
 Mon, 23 Sep 2024 12:46:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id VYw76h4hGhwg; Mon, 23 Sep 2024 12:46:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C07BD4E600E; Mon, 23 Sep 2024 12:46:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BE494757B1C;
 Mon, 23 Sep 2024 12:46:27 +0200 (CEST)
Date: Mon, 23 Sep 2024 12:46:27 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Corey Minyard <cminyard@mvista.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 12/23] hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE
 define
In-Reply-To: <20240923093016.66437-13-shentey@gmail.com>
Message-ID: <4962d86d-8eb3-cd11-cfa9-3392cf3955e5@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-13-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Mon, 23 Sep 2024, Bernhard Beschow wrote:
> Prefer a macro rather than a string literal when instantiaging device models.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/pci-host/ppce500.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index 97e5d47cec..d7ff2ba778 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -475,7 +475,7 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
>     address_space_init(&s->bm_as, &s->bm, "pci-bm");
>     pci_setup_iommu(b, &ppce500_iommu_ops, s);
>
> -    pci_create_simple(b, 0, "e500-host-bridge");
> +    pci_create_simple(b, 0, TYPE_PPC_E500_PCI_BRIDGE);
>
>     memory_region_init(&s->container, OBJECT(h), "pci-container", PCIE500_ALL_SIZE);
>     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_be_ops, h,
>

