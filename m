Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142E9D31A11
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsKo-0007Ur-4x; Tue, 13 Jan 2026 23:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vfsKn-0007UQ-0B
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:18:17 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vfsKl-0000Uq-8Y
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:18:16 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-59b672f8e40so9404115e87.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768364292; x=1768969092; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rTZsGHMOYUjVARbLPuK9ODYxa8Kw9mlh4CNXfrwhWfs=;
 b=hjBrPHcNTI0z1APSPLPlfseF7fIzdL65rUhftgegvWhfX4gDOd4GhpnOY3hMMus/TV
 zsbZd65oHai6QD5DeQSC0/4rpHnLU2dX+04Ywff+O39HV5hBg+/zTlMMxgv5zlERJQpN
 D5XMC46EyUjj3SGqw2LwY/Wkrrarmt/Pcc9OGTkXOM4+wKjfPtjVC0/u+YdYW8WpL5SY
 Ph9LzoWh6gHQg4n7Qhw2MoDYC1F+GSuvoXNmwNnCYiPaUgt4xwl/krgdO7EEP/GxeFQY
 jU03wkJxfSRm+549KF5YEzHd+UCtAJ1JXVgkBJRQtptM16r1NqMYsRLWCIoyH6oK8S2h
 /Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768364292; x=1768969092;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTZsGHMOYUjVARbLPuK9ODYxa8Kw9mlh4CNXfrwhWfs=;
 b=Sj4hPadXEQX+ZXoqP41/5j1OT8/3S+cZSgKLxrnzaHO/v8pq3P4vAq8fiPqqQnP12a
 gRQmedr2Mp+OQ1gkkJnzy9Ht0cdewCJgbOqsLFCIIKqkCOGjqTFAlxljzLvUnypaiII/
 NofkiPKlTyEiPVvGNJHcP3D28dMkjl0MbK40u1fdvKf1RZbck3bKD8gUR1rzdSFQ+927
 esArwuWYocluY0e/G4NL6vBMsiAewLECFk50DZihm/VM+nlaBdktoQn+4medBcyBHf1z
 sDVJRsD0JEWYFJvBVUd/07lY2KYyIYXm2cVDoLCEQ+UvE2gQ2gEblnmAH4cvYuI0J9lD
 t7Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+hvOObCtl9DycCwRFmFaDMLkB89CjNSHWHj0GdDLJxYSGjJ4mLe/KmuMrZWZ9a/EeNumEacO5sCgZ@nongnu.org
X-Gm-Message-State: AOJu0YzMkVq05QefBYuOHJfHsQzcaIAfN2H00/12vTobsjhnHBj8oGMC
 NZXTbph869nsawBVdJIHeeKmNiJ1zvVcWabe5x+5KT05sD/qxAM9rXdIMyTvWrPpI6rw8Nz3bhs
 kp6Punoieh/wLIxGspXwykr6Wp+aXWqrsa41cKw0PEw==
X-Gm-Gg: AY/fxX7FthGnPEsCqd06i3GGaBR5m3asZkVPyNsonG9FR7yeVnBXHRMFVU4JZ5lohrm
 1ETEWTnSwIk0YZdz5riVo76dinKN5g461NP+R+QV9zhOebT9eAhXFx/aELgILSA+SyBuRxvclXO
 SXNW9nOiSXAD1cNB2qgIqpGPE/REf+gdGiAPKg/WeN1BsPb8mAldcgwA9mQh0V76UCZQQPcSIjs
 xHTbnJSteNBIlKAjBkcR1lRls8lXbV5aRL2W5GFHCz8cC8K2VXQvGBGfPKii3zL1RlA5yR9
X-Received: by 2002:a05:6512:12d1:b0:59b:6dbc:e507 with SMTP id
 2adb3069b0e04-59ba0f91bdamr405525e87.47.1768364292300; Tue, 13 Jan 2026
 20:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-34-skolothumtho@nvidia.com>
In-Reply-To: <20260111195508.106943-34-skolothumtho@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 14 Jan 2026 12:18:01 +0800
X-Gm-Features: AZwV_QiTdX_Xhs9kH2GSdzP87um7zNG4KhsdhXt28nSHyjcfV5i2cFsJYq0-ebk
Message-ID: <CABQgh9FwSTB8Cp8f1POSBti376ZH3B0e0mLu9FU==p1wVwquGg@mail.gmail.com>
Subject: Re: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com, 
 ddutile@redhat.com, berrange@redhat.com, clg@redhat.com, alex@shazbot.org, 
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com, 
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com, 
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi, Shameer

On Mon, 12 Jan 2026 at 03:58, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
> Add pcie_insert_capability(), a helper to insert a PCIe extended
> capability into an existing extended capability list at a
> caller-specified offset.
>
> Unlike pcie_add_capability(), which always appends a capability to the
> end of the list, this helper preserves the existing list ordering while
> allowing insertion at an arbitrary offset.
>
> The helper only validates that the insertion does not overwrite an
> existing PCIe extended capability header, since corrupting a header
> would break the extended capability linked list. Validation of overlaps
> with other configuration space registers or capability-specific
> register blocks is left to the caller.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

The guest kernel fails to boot with para "ssidsize=16" with v7 series.
Without ssidsize, guest kernel can boot no problem.

However, pasid feature requires ssidsize.
smmuv3_accel_get_viommu_flags
if (s->ssidsize) {
flags |= VIOMMU_FLAG_PASID_SUPPORTED;

v6 does not has such issue, and does not requires ssidsize param.

log:
ASSERT_EFI_ERROR (Status = Invalid Parameter)
ASSERT [PciBusDxe]
/home/linaro/work/edk2/MdeModulePkg/Bus/Pci/PciBusDxe/PciLib.c(626):
!(((INTN)(RETURN_STATUS)(Status)) < 0)


Thanks

> ---
>  hw/pci/pcie.c         | 58 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pcie.h |  2 ++
>  2 files changed, 60 insertions(+)
>
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index b302de6419..8568a062a5 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1050,6 +1050,64 @@ static void pcie_ext_cap_set_next(PCIDevice *dev, uint16_t pos, uint16_t next)
>      pci_set_long(dev->config + pos, header);
>  }
>
> +/*
> + * Insert a PCIe extended capability at a given offset.
> + *
> + * This helper only validates that the insertion does not overwrite an
> + * existing PCIe extended capability header, as corrupting a header would
> + * break the extended capability linked list.
> + *
> + * The caller must ensure that (offset, size) does not overlap with other
> + * registers or capability-specific register blocks. Overlaps with
> + * capability-specific registers are not checked and are considered a
> + * user-controlled override.
> + */
> +bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
> +                            uint16_t offset, uint16_t size)
> +{
> +    uint16_t prev = 0, next = 0;
> +    uint16_t cur = pci_get_word(dev->config + PCI_CONFIG_SPACE_SIZE);
> +
> +    /* Walk the ext cap list to find insertion point */
> +    while (cur) {
> +        uint32_t hdr = pci_get_long(dev->config + cur);
> +        next = PCI_EXT_CAP_NEXT(hdr);
> +
> +        /* Check we are not overwriting any existing CAP header area */
> +        if (offset >= cur && offset < cur + PCI_EXT_CAP_ALIGN) {
> +            return false;
> +        }
> +
> +        prev = cur;
> +        cur = next;
> +        if (next == 0 || next > offset) {
> +            break;
> +        }
> +    }
> +
> +   /* Make sure, next CAP header area is not over written either */
> +    if (next && (offset + size) >= next) {
> +        return false;
> +    }
> +
> +    /* Insert new cap */
> +    pci_set_long(dev->config + offset,
> +                 PCI_EXT_CAP(cap_id, cap_ver, cur));
> +    if (prev) {
> +        pcie_ext_cap_set_next(dev, prev, offset);
> +    } else {
> +        /* Insert at head (0x100) */
> +        pci_set_word(dev->config + PCI_CONFIG_SPACE_SIZE, offset);
> +    }
> +
> +    /* Make capability read-only by default */
> +    memset(dev->wmask + offset, 0, size);
> +    memset(dev->w1cmask + offset, 0, size);
> +    /* Check capability by default */
> +    memset(dev->cmask + offset, 0xFF, size);
> +    return true;
> +}
> +
>  /*
>   * Caller must supply valid (offset, size) such that the range wouldn't
>   * overlap with other capability or other registers.
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index c880ae1e04..d68bfa6257 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -133,6 +133,8 @@ uint16_t pcie_find_capability(PCIDevice *dev, uint16_t cap_id);
>  void pcie_add_capability(PCIDevice *dev,
>                           uint16_t cap_id, uint8_t cap_ver,
>                           uint16_t offset, uint16_t size);
> +bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
> +                            uint16_t offset, uint16_t size);
>  void pcie_sync_bridge_lnk(PCIDevice *dev);
>
>  void pcie_acs_init(PCIDevice *dev, uint16_t offset);
> --
> 2.43.0
>

