Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B949607634C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9wAkKFZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgff-0006sn-6i; Wed, 04 Nov 2026 14:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1xOgfd-0006rm-Du
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:29:17 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1xOgfa-0000rO-LI
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:29:16 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5CFD4400EC;
 Wed,  4 Nov 2026 19:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7561F000C1;
 Wed,  4 Nov 2026 19:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793820553;
 bh=6qy33JqzdRF5WpNCm7i2JsdmuJAfH9P2g5SeD/oWbAo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=D9wAkKFZD4wPkiNCSk0W7vwMqy+R1/GHHZY9Nn+t8P5YMiSYb1qYPTs4nSKfgy63m
 HbOV2RFMN7gH0DNhxHFQkItL1VZ87b82+7OQKfG6Cy6KQcNHrjSra6ywxvxTSG1tM+
 mgItRpSObOIIj5Ood1sm0jxGB9NcRLk7PsLgv/2a0pbVN7lAG3pu52cOw4JthMRnI7
 P5QbNHzvaFsQe3yb/fDhvj0Q6gpR1b34L+AZ6hwRbc3QHrglZ6aMJKx9SEpw6S7vUa
 T1wXttRiczyHVyiQoUgypqH1wd/2BMTdT7E+yQC30gR2chNYBUEwIbw5rZshFSS/IE
 1Qn1NSfnNoAMQ==
Date: Wed, 4 Nov 2026 19:29:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 3/4] hw/pci: add DVSEC RMEDA capability to PCIe root port
Message-ID: <20261104192907.4716131f@jic23-hlaptop>
In-Reply-To: <20261029-jmac-pcie-rme-extensions-v1-3-212d2409563e@linaro.org>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
 <20261029-jmac-pcie-rme-extensions-v1-3-212d2409563e@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 15:05:12 +0000
Jim MacArthur <jim.macarthur@linaro.org> wrote:

> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Again, gated by the rme-cap=on flag for pcie-root-port.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  hw/pci-bridge/gen_pcie_root_port.c | 35 +++++++++++++++++++++++++++++++++++
>  include/hw/pci/pcie_regs.h         |  4 ++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index ab8087da87..fb8dbb7959 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -28,6 +28,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(GenPCIERootPort, GEN_PCIE_ROOT_PORT)
>          (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
>  #define GEN_PCIE_ROOT_PORT_ACS_END \
>          (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)
> +

Stray change.


>  #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
>  #define GEN_PCIE_ROOT_DEFAULT_IO_RANGE          4096
>  
> @@ -67,6 +68,39 @@ static void gen_rp_interrupts_uninit(PCIDevice *d)
>      msix_uninit_exclusive_bar(d);
>  }
>  
> +static uint32_t add_rme_dvsec_capability(PCIDevice *device, uint32_t offset)
> +{
> +    /*
> +     * dvsec rme-da
> +     * https://developer.arm.com/documentation/den0129/latest/
> +     * Arm RME System Architecture
> +     * 0x0000 RMEDA_ECH See B3.2.6.2.1 RME-DA Extended Capability Header
> +     * 0x0004 RMEDA_HEAD1 See B3.2.6.2.2 RME-DA DVSEC Header 1
> +     * 0x0008 RMEDA_HEAD2 See B3.2.6.2.3 RME-DA DVSEC Header 2
> +     * 0x000C RMEDA_CTL1 See B3.2.6.2.4 RME-DA Control register 1
> +     * 0x0010 RMEDA_CTL2 See B3.2.6.2.5 RME-DA Control register 2
> +     */
> +    const uint32_t ARM_PCI_VID = 0x13b5;
> +    const uint32_t RME_DA_DVSEC_ID = 0;
> +    pcie_add_dvsec_capability(device, PCI_EXT_CAP_ID_DVSEC, 1, offset,
> +                              PCI_RME_DVSEC_SIZE, ARM_PCI_VID,
> +                              PCI_RME_DVSEC_VER, RME_DA_DVSEC_ID);
> +    const uint32_t ctl1 = 0x1; /* support tdisp */
> +    const uint32_t ctl2 = 0x0; /* unlocked */

Why not just pass these values in?  The local doesn't seem to add anything to me.

> +    pci_set_long(device->config + offset + 0xC, ctl1);
> +    pci_set_long(device->config + offset + 0x10, ctl2);
> +    device->wmask[offset + 0xC] = 0xff;
> +    device->wmask[offset + 0xC + 1] = 0xff;
> +    device->wmask[offset + 0xC + 2] = 0xff;
> +    device->wmask[offset + 0xC + 3] = 0xff;
> +    device->wmask[offset + 0x10] = 0xff;
> +    device->wmask[offset + 0x10 + 1] = 0xff;
> +    device->wmask[offset + 0x10 + 2] = 0xff;
> +    device->wmask[offset + 0x10 + 3] = 0xff;
> +    offset += PCI_RME_DVSEC_SIZE;
> +    return offset;

Given only updated just above.
    return offset + PCI_RME_DVSEC_SIZE;
would I think be slightly more readable.

> +}
> +


