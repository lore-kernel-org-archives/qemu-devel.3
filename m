Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D541C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGdO-0000Oh-KK; Tue, 21 Jan 2025 10:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taGdK-00005V-Um
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:57:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taGdI-0002Ey-Ua
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:57:42 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YcsKc1NJ5z6HJgC;
 Tue, 21 Jan 2025 23:57:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 8A7A4140D1D;
 Tue, 21 Jan 2025 23:57:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 Jan
 2025 16:57:36 +0100
Date: Tue, 21 Jan 2025 15:57:35 +0000
To: Zhi Wang <zhiw@nvidia.com>
CC: <qemu-devel@nongnu.org>, <dan.j.williams@intel.com>,
 <dave.jiang@intel.com>, <ira.weiny@intel.com>, <fan.ni@samsung.com>,
 <alex.williamson@redhat.com>, <alucerop@amd.com>, <clg@redhat.com>,
 <acurrid@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH 2/3] hw/cxl: introduce cxl_component_update_dvsec()
Message-ID: <20250121155735.00001776@huawei.com>
In-Reply-To: <20241212130422.69380-3-zhiw@nvidia.com>
References: <20241212130422.69380-1-zhiw@nvidia.com>
 <20241212130422.69380-3-zhiw@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.086, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 12 Dec 2024 05:04:21 -0800
Zhi Wang <zhiw@nvidia.com> wrote:

> There are many DVSEC registers in the PCI configuration space that are
> configurable. E.g. DVS control. They are configured and initalized in
> cxl_component_create_dvsec(). When the virtual machine reboots, the
> reset callback in the emulation of the emulated CXL device resets the
> device states back to default states.
> 
> So far, there is no decent approach to reset the values of CXL DVSEC
> registers in the PCI configuation space one for all. Without reseting
> the values of CXL DVSEC registers, the CXL type-2 driver failing to
> claim the endpoint:
> 
> - DVS_CONTROL.MEM_ENABLE is left to be 1 across the system reboot.
> - Type-2 driver loads.
> - In the endpoint probe, the kernel CXL core sees the
>   DVS_CONTROL.MEM_ENABLE is set.
> - The kernel CXL core wrongly thinks the HDM decoder is pre-configured
>   by BIOS/UEFI.
> - The kernel CXL core uses the garbage in the HDM decoder registers and
>   fails:
> 
> [   74.586911] cxl_accel_vfio_pci 0000:0d:00.0: Range register decodes
> outside platform defined CXL ranges.
> [   74.588585] cxl_mem mem0: endpoint2 failed probe
> [   74.589478] cxl_accel_vfio_pci 0000:0d:00.0: Fail to acquire CXL
> endpoint
> [   74.591944] pcieport 0000:0c:00.0: unlocked secondary bus reset via:
> pciehp_reset_slot+0xa8/0x150
> 
> Introduce cxl_component_update_dvsec() for the emulation of CXL devices
> to reset the CXL DVSEC registers in the PCI configuration space.

We know there are issues with this reset path for the type 3 devices.
I'd be keen to see that fixed up using a mechanism like this then we can
build on top of it for type2 support.  I'm not convinced that a generic
solution like this makes sense rather than a specific reset of registers
as appropriate which allows us to carefully preserve the sticky bits.
Reset for the type 3 has proved a little tricky to fix in the past and
wasn't really a priority.  Given we have to do it for type 2 I'd like
to fix it up for both.

Jonathan

> 
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  hw/cxl/cxl-component-utils.c   | 36 ++++++++++++++++++++++++++++------
>  include/hw/cxl/cxl_component.h |  3 +++
>  2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index aa5fb20d25..355103d165 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -365,9 +365,13 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>   * Helper to creates a DVSEC header for a CXL entity. The caller is responsible
>   * for tracking the valid offset.
>   *
> - * This function will build the DVSEC header on behalf of the caller and then
> - * copy in the remaining data for the vendor specific bits.
> - * It will also set up appropriate write masks.
> + * This function will build the DVSEC header on behalf of the caller. It will
> + * also set up appropriate write masks.
> + *
> + * If required, it will copy in the remaining data for the vendor specific bits.
> + * Or the caller can also fill the remaining data later after the DVSEC header
> + * is built via cxl_component_update_dvsec().
> + *

Pet hate.  This blank line adds nothing so drop it.

>   */
>  void cxl_component_create_dvsec(CXLComponentState *cxl,
>                                  enum reg_type cxl_dev_type, uint16_t length,
> @@ -387,9 +391,12 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
>      pci_set_long(pdev->config + offset + PCIE_DVSEC_HEADER1_OFFSET,
>                   (length << 20) | (rev << 16) | CXL_VENDOR_ID);
>      pci_set_word(pdev->config + offset + PCIE_DVSEC_ID_OFFSET, type);
> -    memcpy(pdev->config + offset + sizeof(DVSECHeader),
> -           body + sizeof(DVSECHeader),
> -           length - sizeof(DVSECHeader));
> +
> +    if (body) {
> +        memcpy(pdev->config + offset + sizeof(DVSECHeader),
> +                body + sizeof(DVSECHeader),
> +                length - sizeof(DVSECHeader));
> +    }
>  
>      /* Configure write masks */
>      switch (type) {
> @@ -481,6 +488,23 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
>      cxl->dvsec_offset += length;
>  }
>  
> +void cxl_component_update_dvsec(CXLComponentState *cxl, uint16_t length,
> +                                uint16_t type, uint8_t *body)
> +{
> +    PCIDevice *pdev = cxl->pdev;
> +    struct Range *r;
> +
> +    assert(type < CXL20_MAX_DVSEC);
> +
> +    r = &cxl->dvsecs[type];
> +
> +    assert(range_size(r) == length);
> +
> +    memcpy(pdev->config + r->lob + sizeof(DVSECHeader),
> +           body + sizeof(DVSECHeader),
> +           length - sizeof(DVSECHeader));
> +}
> +
>  /* CXL r3.1 Section 8.2.4.20.7 CXL HDM Decoder n Control Register */
>  uint8_t cxl_interleave_ways_enc(int iw, Error **errp)
>  {
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index abb2e874b2..30fe4bfa24 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -261,6 +261,9 @@ void cxl_component_create_dvsec(CXLComponentState *cxl_cstate,
>                                  enum reg_type cxl_dev_type, uint16_t length,
>                                  uint16_t type, uint8_t rev, uint8_t *body);
>  
> +void cxl_component_update_dvsec(CXLComponentState *cxl, uint16_t length,
> +                                uint16_t type, uint8_t *body);
> +
>  int cxl_decoder_count_enc(int count);
>  int cxl_decoder_count_dec(int enc_cnt);
>  


