Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44470C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 12:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXh7b-0003Yf-2V; Wed, 07 Feb 2024 07:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rXh7Q-0003Wt-O6; Wed, 07 Feb 2024 07:33:38 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rXh7N-0001Sf-KF; Wed, 07 Feb 2024 07:33:35 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 211564E601E;
 Wed,  7 Feb 2024 13:33:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id fysRY8GpBwGh; Wed,  7 Feb 2024 13:33:27 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 250BB4E6006; Wed,  7 Feb 2024 13:33:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2334E7456B4;
 Wed,  7 Feb 2024 13:33:27 +0100 (CET)
Date: Wed, 7 Feb 2024 13:33:27 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 4/4] hw/ppc/ppc440_pcix: Move ppc440_pcix.c to
 hw/pci-host/
In-Reply-To: <20240207091254.1478-5-philmd@linaro.org>
Message-ID: <c37e9f04-56b9-1e64-735f-8b9f3916ca59@eik.bme.hu>
References: <20240207091254.1478-1-philmd@linaro.org>
 <20240207091254.1478-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-20164758-1707309207=:38665"
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

--3866299591-20164758-1707309207=:38665
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 7 Feb 2024, Philippe Mathieu-Daudé wrote:
> ppc440_pcix.c is moved from the target specific ppc_ss[] meson
> source set to pci_ss[] which is common to all targets: the
> object is built once.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> MAINTAINERS                        | 2 +-
> hw/{ppc => pci-host}/ppc440_pcix.c | 0
> hw/pci-host/Kconfig                | 4 ++++
> hw/pci-host/meson.build            | 1 +
> hw/pci-host/trace-events           | 8 ++++++++
> hw/ppc/Kconfig                     | 1 +
> hw/ppc/meson.build                 | 2 +-
> hw/ppc/trace-events                | 8 --------
> 8 files changed, 16 insertions(+), 10 deletions(-)
> rename hw/{ppc => pci-host}/ppc440_pcix.c (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1927530c2d..42e63ed696 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1554,7 +1554,7 @@ L: qemu-ppc@nongnu.org
> S: Maintained
> F: hw/ppc/sam460ex.c
> F: hw/ppc/ppc440_uc.c
> -F: hw/ppc/ppc440_pcix.c
> +F: hw/pci-host/ppc440_pcix.c
> F: hw/display/sm501*
> F: hw/ide/sii3112.c
> F: hw/rtc/m41t80.c
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/pci-host/ppc440_pcix.c
> similarity index 100%
> rename from hw/ppc/ppc440_pcix.c
> rename to hw/pci-host/ppc440_pcix.c
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index 0a221e719e..b348cacadb 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -10,6 +10,10 @@ config PPC4XX_PCI
>     bool
>     select PCI
>
> +config PPC440_PCI

Maybe PPC440_PCIX to be consistent with the file name? There are different 
versions of these PCI hosts in different SoCs so I'm not sure there isn't 
another earlier one with is called just pci so better call this one pcix 
as it's referred to in the device tree so we don't need to rename it if 
another SoC with just PCI host is added later.

Regards,
BALATON Zoltan

> +    bool
> +    select PCI
> +
> config RAVEN_PCI
>     bool
>     select PCI
> diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
> index eb6dc71c88..83cf3a1783 100644
> --- a/hw/pci-host/meson.build
> +++ b/hw/pci-host/meson.build
> @@ -15,6 +15,7 @@ pci_ss.add(when: 'CONFIG_SH_PCI', if_true: files('sh_pci.c'))
>
> # PPC devices
> pci_ss.add(when: 'CONFIG_PPC4XX_PCI', if_true: files('ppc4xx_pci.c'))
> +pci_ss.add(when: 'CONFIG_PPC440_PCI', if_true: files('ppc440_pcix.c'))
> pci_ss.add(when: 'CONFIG_RAVEN_PCI', if_true: files('raven.c'))
> pci_ss.add(when: 'CONFIG_GRACKLE_PCI', if_true: files('grackle.c'))
> # NewWorld PowerMac
> diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
> index 90a37ebff0..0a816b9aa1 100644
> --- a/hw/pci-host/trace-events
> +++ b/hw/pci-host/trace-events
> @@ -41,6 +41,14 @@ unin_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
> ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
> ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
>
> +# ppc440_pcix.c
> +ppc440_pcix_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
> +ppc440_pcix_set_irq(int irq_num) "PCI irq %d"
> +ppc440_pcix_update_pim(int idx, uint64_t size, uint64_t la) "Added window %d of size=0x%" PRIx64 " to CPU=0x%" PRIx64
> +ppc440_pcix_update_pom(int idx, uint32_t size, uint64_t la, uint64_t pcia) "Added window %d of size=0x%x from CPU=0x%" PRIx64 " to PCI=0x%" PRIx64
> +ppc440_pcix_reg_read(uint64_t addr, uint32_t val) "addr 0x%" PRIx64 " = 0x%" PRIx32
> +ppc440_pcix_reg_write(uint64_t addr, uint32_t val, uint32_t size) "addr 0x%" PRIx64 " = 0x%" PRIx32 " size 0x%" PRIx32
> +
> # pnv_phb4.c
> pnv_phb4_xive_notify(uint64_t notif_port, uint64_t data) "notif=@0x%"PRIx64" data=0x%"PRIx64
> pnv_phb4_xive_notify_ic(uint64_t addr, uint64_t data) "addr=@0x%"PRIx64" data=0x%"PRIx64
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 82e847d22c..2da6c16186 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -46,6 +46,7 @@ config PPC440
>     imply TEST_DEVICES
>     imply E1000_PCI
>     select PCI_EXPRESS
> +    select PPC440_PCI
>     select PPC4XX
>     select SERIAL
>     select FDT_PPC
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index d0efc0aba5..da14fccce5 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -60,7 +60,7 @@ ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
>   'ppc405_uc.c'))
> ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
>   'ppc440_bamboo.c',
> -  'ppc440_pcix.c', 'ppc440_uc.c'))
> +  'ppc440_uc.c'))
> ppc_ss.add(when: 'CONFIG_PPC4XX', if_true: files(
>   'ppc4xx_devs.c',
>   'ppc4xx_sdram.c'))
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index b59fbf340f..157ea756e9 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -146,14 +146,6 @@ rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
> rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
> rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
>
> -# ppc440_pcix.c
> -ppc440_pcix_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
> -ppc440_pcix_set_irq(int irq_num) "PCI irq %d"
> -ppc440_pcix_update_pim(int idx, uint64_t size, uint64_t la) "Added window %d of size=0x%" PRIx64 " to CPU=0x%" PRIx64
> -ppc440_pcix_update_pom(int idx, uint32_t size, uint64_t la, uint64_t pcia) "Added window %d of size=0x%x from CPU=0x%" PRIx64 " to PCI=0x%" PRIx64
> -ppc440_pcix_reg_read(uint64_t addr, uint32_t val) "addr 0x%" PRIx64 " = 0x%" PRIx32
> -ppc440_pcix_reg_write(uint64_t addr, uint32_t val, uint32_t size) "addr 0x%" PRIx64 " = 0x%" PRIx32 " size 0x%" PRIx32
> -
> # ppc405_boards.c
> opba_readb(uint64_t addr, uint32_t val) "addr 0x%" PRIx64 " = 0x%" PRIx32
> opba_writeb(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " = 0x%" PRIx64
>
--3866299591-20164758-1707309207=:38665--

