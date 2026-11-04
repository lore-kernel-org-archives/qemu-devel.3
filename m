Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619B6070321
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KyU2Drqw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgdp-0006RW-9R; Wed, 04 Nov 2026 14:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1xOgdh-0006R4-C3
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:27:18 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1xOgdf-0000hv-Mq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:27:17 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6730E60A8D;
 Wed,  4 Nov 2026 19:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752691F000C1;
 Wed,  4 Nov 2026 19:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793820434;
 bh=i26IQQ7a/7/vjk+32gQymBJ9yzh97I38zZWocEDhj18=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=KyU2DrqwYgKlKKZlnVMSI+zmC98rD0x8jT7k17vjGsK40r5tZKDoW/Jyih+utRsnz
 gGdREHamuEaZLJ6CJINt3/gVdQm8cFlq+A1/hLbr1F96mHWntJ4YNb5VYhCMy5cm6a
 s+p3gV+gDoAWfPwiOVdT3XeQCkUc6cZSfuryNozq9p7rWKJ5Nn3Lm4Vlmc6iLyjFhQ
 MB9L3mVi+Py54ZRizzaThXjnQ9OwPYLjogPgL05pOMDX6Q8OYMz/+cFs9uHd7+9rIo
 FqqE2kqu1P0rkErEzhW2DkiWBYH2F6+QZL9eqWiMceD/Oz2iKXQm9GHWJANGlcP65/
 WsnW+fL2IawmA==
Date: Wed, 4 Nov 2026 19:27:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jim
 MacArthur <"Jim MacArthur"@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 2/4] hw/pci: add IDE + TEE capability to PCIe root port
Message-ID: <20261104192709.3b260e06@jic23-hlaptop>
In-Reply-To: <20261029-jmac-pcie-rme-extensions-v1-2-212d2409563e@linaro.org>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
 <20261029-jmac-pcie-rme-extensions-v1-2-212d2409563e@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=tor.source.kernel.org
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

On Thu, 29 Oct 2026 15:05:11 +0000
Jim MacArthur <jim.macarthur@linaro.org> wrote:

> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Adds the TEE flag in the legacy config space, and the IDE
> (Integrity & Data Encryption) extended capability. These
> will be present when rme-cap=on is specified for the
> pcie-root-port device.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Jim MacArthur <Jim MacArthur@linaro.org>
> ---
>  hw/pci-bridge/gen_pcie_root_port.c | 21 ++++++++++++++++++++-
>  hw/pci/pcie.c                      | 19 +++++++++++++++++++
>  include/hw/pci/pcie.h              |  3 +++
>  include/hw/pci/pcie_regs.h         |  4 ++++
>  4 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index 5434d693d9..ab8087da87 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -26,13 +26,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(GenPCIERootPort, GEN_PCIE_ROOT_PORT)
>  #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
>  #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
>          (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
> -
> +#define GEN_PCIE_ROOT_PORT_ACS_END \
> +        (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)

Can't you figure this out from root port class acs offset?

Or if you want it in a fixed place follow that pattern and stash it
in the root class during dev_rp_dev_class_init.

>  #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
>  #define GEN_PCIE_ROOT_DEFAULT_IO_RANGE          4096
>  
>  struct GenPCIERootPort {
>      /*< private >*/
>      PCIESlot parent_obj;
> +    bool     rme_caps;
> +
>      /*< public >*/
>  
>      /* additional resources to reserve */
> @@ -71,6 +74,7 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
>      GenPCIERootPort *grp = GEN_PCIE_ROOT_PORT(d);
>      PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
>      Error *local_err = NULL;
> +    uint32_t next_cap_offset = GEN_PCIE_ROOT_PORT_ACS_END;
>  
>      rpc->parent_realize(dev, &local_err);
>      if (local_err) {
> @@ -100,6 +104,19 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
>          d->wmask[PCI_IO_BASE] = 0;
>          d->wmask[PCI_IO_LIMIT] = 0;
>      }
> +
> +    if (grp->rme_caps) {
Not arm specific. Can't see any harm in using a generic config name
for this.  Actually I'm not seeing a reason not to always include
the ide cap. Maybe less so for setting up tee.  Haven't really thought about
that.


> +        pcie_ide_init(d, next_cap_offset);
> +
> +        /* Unused value, but may be useful for the next capability */
> +        next_cap_offset += PCI_IDE_SIZEOF;
> +
> +        /*
> +         * Set up TEE (in the legacy config space, not an extended
> +         * capability)
> +         */
> +        pcie_cap_tee_init(d);
> +    }
>  }
>  
>  static const VMStateDescription vmstate_rp_dev = {
> @@ -133,6 +150,8 @@ static const Property gen_rp_props[] = {
>                                  speed, PCIE_LINK_SPEED_16),
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
>                                  width, PCIE_LINK_WIDTH_32),
> +    DEFINE_PROP_BOOL("rme-caps", GenPCIERootPort,
> +                     rme_caps, false),
>  };
>  
>  static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 42c4997b42..bf2c184cfc 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c

