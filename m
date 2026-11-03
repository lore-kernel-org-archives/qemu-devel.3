Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E4606A329
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=YFfZ8dBp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOF9n-0002ii-Jr; Tue, 03 Nov 2026 09:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xOF9j-0002iE-Rx; Tue, 03 Nov 2026 09:06:32 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xOF9g-0001VU-Cq; Tue, 03 Nov 2026 09:06:31 -0500
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A3E62nE028835
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Nov 2026 23:06:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=6ZnZpdLjzWID/hFhex7/R/W7RCK7CFbxnr8S7OuxWGU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1793714763; v=1;
 b=YFfZ8dBpkQnkUQFcRWz5li6aVoHj2DAiD5m0dDWokdxP17P4pAgQQ2BDEIZ2qQDR
 agH068p5x4yQVW+pelVT2H6Nc+uSjQdLQcWGtiB756bSDX6qBR14ByX/573w6bLB
 eNPFIcf1O0oEczo6RsSVi+UqmKLB8Oud2GljJzH0q1EIOVtePKvI6EsB1cDgVVYI
 o05Ss6tzYiBjXGcDQX0owDZ0TupuvI/fONU1SsKhOspOyiF471NQYkGFa5WeWc1S
 bBQExqfUbL30TBYpAgVeugm+pZngP9sedjzGzzFWJzzFnSXXw3UeY7Rtmd6kq4M3
 +jqM/u5WPK4vXLb7ihm+jQ==
Message-ID: <09566fd1-7eb6-4dc1-a721-f15e4948e143@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 3 Nov 2026 23:06:02 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/10] qtest/libqos/pci: Enforce balanced iomap/unmap
To: uverma@linux.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, jishnuvw@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com,
 aleksandr.mikhalitsyn@futurfusion.io,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20261102035306.2291147-1-uverma@linux.ibm.com>
 <20261102035306.2291147-9-uverma@linux.ibm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261102035306.2291147-9-uverma@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/02 12:53, uverma@linux.ibm.com wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Add assertions to ensure a BAR is not mapped twice, and that only
> previously mapped BARs are unmapped. This can help catch bugs and
> fragile coding.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
> ---
>   tests/qtest/libqos/ahci.c |  3 ++-
>   tests/qtest/libqos/pci.c  | 57 +++++++++++++++++++++++++++++++++++----
>   tests/qtest/libqos/pci.h  | 10 +++++++
>   3 files changed, 64 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
> index a709558aac..53a98bd6cb 100644
> --- a/tests/qtest/libqos/ahci.c
> +++ b/tests/qtest/libqos/ahci.c
> @@ -225,7 +225,7 @@ void start_ahci_device(AHCIQState *ahci)
>   
>   void stop_ahci_device(AHCIQState *ahci)
>   {
> -    /* Unmap AHCI's ABAR */
> +    /* Unmap AHCI's ABAR (no-op if not mapped) */
>       qpci_iounmap(ahci->dev, ahci->hba_bar);
>   }
>   
> @@ -250,6 +250,7 @@ void ahci_hba_enable(AHCIQState *ahci)
>       uint8_t num_cmd_slots;
>   
>       g_assert(ahci != NULL);
> +    g_assert(ahci->hba_bar.mapped);
>   
>       /* Set GHC.AE to 1 */
>       ahci_set(ahci, AHCI_GHC, AHCI_GHC_AE);
> diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
> index e78dd4d4c7..365fde1fb9 100644
> --- a/tests/qtest/libqos/pci.c
> +++ b/tests/qtest/libqos/pci.c
> @@ -79,12 +79,17 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
>   void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr)
>   {
>       uint16_t vendor_id, device_id;
> +    int i;
>   
>       qpci_device_set(dev, bus, addr->devfn);
>       vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);
>       device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
>       g_assert(!addr->vendor_id || vendor_id == addr->vendor_id);
>       g_assert(!addr->device_id || device_id == addr->device_id);
> +
> +    for (i = 0; i < QPCI_NUM_REGIONS; i++) {
> +        g_assert(!dev->bars_mapped[i]);
> +    }
>   }
>   
>   static uint8_t qpci_find_resource_reserve_capability(QPCIDevice *dev)
> @@ -554,21 +559,31 @@ void qpci_memwrite(QPCIDevice *dev, QPCIBar token, uint64_t off,
>       dev->bus->memwrite(dev->bus, token.addr + off, buf, len);
>   }
>   
> -QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
> +static uint8_t qpci_bar_reg(int barno)
>   {
> -    QPCIBus *bus = dev->bus;
>       static const int bar_reg_map[] = {
>           PCI_BASE_ADDRESS_0, PCI_BASE_ADDRESS_1, PCI_BASE_ADDRESS_2,
>           PCI_BASE_ADDRESS_3, PCI_BASE_ADDRESS_4, PCI_BASE_ADDRESS_5,
>       };
> +
> +    g_assert(barno >= 0 && barno < QPCI_NUM_REGIONS);
> +
> +    return bar_reg_map[barno];
> +}
> +
> +QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
> +{
> +    QPCIBus *bus = dev->bus;
>       QPCIBar bar;
>       int bar_reg;
>       uint32_t addr, size;
>       uint32_t io_type;
>       uint64_t loc;
>   
> -    g_assert(barno >= 0 && barno <= 5);
> -    bar_reg = bar_reg_map[barno];
> +    g_assert(barno >= 0 && barno < QPCI_NUM_REGIONS);
> +    g_assert(!dev->bars_mapped[barno]);
> +
> +    bar_reg = qpci_bar_reg(barno);
>   
>       qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
>       addr = qpci_config_readl(dev, bar_reg);
> @@ -611,12 +626,40 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
>       }
>   
>       bar.addr = loc;
> +    bar.mapped = true;
> +
> +    dev->bars_mapped[barno] = true;
> +    dev->bars[barno] = bar;
> +
>       return bar;
>   }
>   
>   void qpci_iounmap(QPCIDevice *dev, QPCIBar bar)
>   {
> -    /* FIXME */
> +    int bar_reg;
> +    int i;
> +
> +    if (!bar.mapped) {
> +        return; /* bar was never mapped; no-op */
> +    }
> +
> +    for (i = 0; i < QPCI_NUM_REGIONS; i++) {
> +        if (!dev->bars_mapped[i]) {
> +            continue;
> +        }
> +        if (dev->bars[i].addr == bar.addr) {
> +            dev->bars_mapped[i] = false;
> +            dev->bars[i].mapped = false;
> +            bar_reg = qpci_bar_reg(i);
> +            qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);

I found that this is actually dangerous: the BAR may be 64-bit, and in 
that case, this won't unmap it. On x86, the BIOS is mapped around that 
area, and the mapped BAR will shadow it.

Regards,
Akihiko Odaki

> +            /* FIXME: the address space is leaked */> +            return;
> +        }
> +    }
> +    /*
> +     * bar was not iomap()ed; treat as no-op for callers that may
> +     * call iounmap unconditionally during cleanup paths.
> +     */
>   }
>   
>   QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
> @@ -627,6 +670,10 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
>   
>   void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from)
>   {
> +    memcpy(to->bars_mapped, from->bars_mapped, sizeof(from->bars_mapped));
> +    memset(from->bars_mapped, 0, sizeof(from->bars_mapped));
> +    memcpy(to->bars, from->bars, sizeof(from->bars));
> +    memset(from->bars, 0, sizeof(from->bars));
>   }
>   
>   void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr)
> diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
> index cfb7c17dd3..2f9555ae4e 100644
> --- a/tests/qtest/libqos/pci.h
> +++ b/tests/qtest/libqos/pci.h
> @@ -58,12 +58,22 @@ struct QPCIBus {
>   struct QPCIBar {
>       uint64_t addr;
>       bool is_io;
> +    bool mapped;
>   };
>   
> +/*
> + * hw/pci permits 7 (PCI_NUM_REGIONS) regions, the last for PCI_ROM_SLOT.
> + * libqos does not implement PCI_ROM_SLOT at the moment, and as such it
> + * permits 6.
> + */
> +#define QPCI_NUM_REGIONS 6
> +
>   struct QPCIDevice
>   {
>       QPCIBus *bus;
>       int devfn;
> +    bool bars_mapped[QPCI_NUM_REGIONS];
> +    QPCIBar bars[QPCI_NUM_REGIONS];
>       bool msix_enabled;
>       QPCIBar msix_table_bar, msix_pba_bar;
>       uint64_t msix_table_off, msix_pba_off;


