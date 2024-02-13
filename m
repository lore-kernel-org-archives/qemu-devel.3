Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F898C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 11:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqYM-0004wN-FP; Tue, 13 Feb 2024 06:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqYJ-0004vm-SN
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:02:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqYH-0006eb-EU
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707822132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fvg1USU9D6+Vh1zMKaghAYWj9Vg+p8rwsAALTyVkhCA=;
 b=Hn95xT5Yp82JRb/t812Feogbq5a5hmXwr3cEGH1zvxJHL8KlAn02tg0pQv/sQzPxieru4/
 xa2An6QBknDa1g6wO5yGgEB+D1MJXM7Y9q9IIOOBQnJlxSlvvGNv0dgJegeMiKTAGuRlkf
 6UEar2KGgKpMzmRdvYe91GUjUUWz6Ys=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-rlxrS5u_Moqd6aAg038uaw-1; Tue, 13 Feb 2024 06:02:11 -0500
X-MC-Unique: rlxrS5u_Moqd6aAg038uaw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a3ccb68f284so90350266b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 03:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707822130; x=1708426930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvg1USU9D6+Vh1zMKaghAYWj9Vg+p8rwsAALTyVkhCA=;
 b=RL04flemBadXW/DvD3Z85s7zckQfK2BaOUeCv1FWhZfTIqihHRDtNuPB+nCS9RAAeb
 TMp8iv+G6bxALG6YhRvQEXRCWfSpCyRXVL5yTMw7OpsEplan+kGxKikZAdSuXU4Id07F
 dnYB0m8MjVbjQo33eQcm9ezeWb/255VR/Fan7aQsmcLCNa9s8+PyX2c4edHDEcl9bX4U
 rq/jbEZy8kjX/E3DgYzRB90pjBOKuSFOTHrYsEYyOM38h2xuSg15sgLh98yodOjruyED
 QcXFWl3q4XcfCgRw9bNfRrLbJr3RuQM8zJGg0JdF6ZLfrMyq00JY1Mau5/EjmKIhidch
 hk1w==
X-Gm-Message-State: AOJu0YyOMSzicwvhYpO1CHS5JMPKsObUxbFB2FyFZPvX5zC4qW0LLiw1
 8+HltSKYSNg3e6VxnpIQBJP3vb7Y1VKFTMmlJuh/vIKe4/Kgh4gXWX5NMi0ozjPn+0i4ygYN21w
 rtbH4uewKIH/R89oqvjO2xGUiJG5OOnihxEeckM1f0VT9evp8YURI
X-Received: by 2002:a17:906:fa99:b0:a3c:369b:a6d5 with SMTP id
 lt25-20020a170906fa9900b00a3c369ba6d5mr6853354ejb.14.1707822129563; 
 Tue, 13 Feb 2024 03:02:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMJF9Jk6nuBUegrBQYD2jnVsZ3sbHqHr6OM3nUEMFuWvHE0WCZ65MnwaXnh3SDFfPhJe6T+g==
X-Received: by 2002:a17:906:fa99:b0:a3c:369b:a6d5 with SMTP id
 lt25-20020a170906fa9900b00a3c369ba6d5mr6853319ejb.14.1707822128920; 
 Tue, 13 Feb 2024 03:02:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVqAuUeiveGiUPJNVmOzi+o+7GIwsMn08H1KinSiz4XaM8VyGkZJCBYFthqNLCAqmlE0YtEWcfhOh97MqNXaKccrE1JsyQQIfnSkKw3ZVK6eoxdP+gcDd3SnmVNG5TjRQr9yPBo4pBgN+FbYuVg/gbOt3vWlCU12s0Mq0sDcH7rlx/g8evwugOQFBy/pTMpu1W0xlCnVeb2+iTyoAsgv5XNEHQ8D9nGzKG7C0MYDh20coAX96Xr8S1C4noQlXK0E697JdwoNJw1XvCun+1C07GbQpaUctXRDOOc8JKbk/GtxxP6+Kk6EA3KbMG2hgq07zj0b3h+9C50Uh1T9araKbudGhJC/ZMsSXrUCT0uFMesVltmZrzY0P63g+epc1tzGhM9aCtW3PBe8nXVaiwxT5HGk56XlvinXssz+Q==
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 a21-20020a170906191500b00a372132718esm1181762eje.90.2024.02.13.03.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 03:02:08 -0800 (PST)
Date: Tue, 13 Feb 2024 06:01:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 6/7] pcie_sriov: Reuse SR-IOV VF device instances
Message-ID: <20240213060116-mutt-send-email-mst@kernel.org>
References: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
 <20240212-reuse-v3-6-8017b689ce7f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-reuse-v3-6-8017b689ce7f@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 12, 2024 at 07:20:34PM +0900, Akihiko Odaki wrote:
> Disable SR-IOV VF devices by reusing code to power down PCI devices
> instead of removing them when the guest requests to disable VFs. This
> allows to realize devices and report VF realization errors at PF
> realization time.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

It is simpler for sure, but I am worried that all of these
unused VFs will consume lots of resources even if never
enabled. Thoughts?


> ---
>  docs/pcie_sriov.txt         |   8 ++--
>  include/hw/pci/pci.h        |   2 +-
>  include/hw/pci/pci_device.h |   2 +-
>  include/hw/pci/pcie_sriov.h |   6 +--
>  hw/net/igb.c                |  13 ++++--
>  hw/nvme/ctrl.c              |  24 +++++++----
>  hw/pci/pci.c                |  18 ++++----
>  hw/pci/pci_host.c           |   4 +-
>  hw/pci/pcie.c               |   4 +-
>  hw/pci/pcie_sriov.c         | 100 ++++++++++++++++++++------------------------
>  10 files changed, 97 insertions(+), 84 deletions(-)
> 
> diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
> index a47aad0bfab0..ab2142807f79 100644
> --- a/docs/pcie_sriov.txt
> +++ b/docs/pcie_sriov.txt
> @@ -52,9 +52,11 @@ setting up a BAR for a VF.
>        ...
>  
>        /* Add and initialize the SR/IOV capability */
> -      pcie_sriov_pf_init(d, 0x200, "your_virtual_dev",
> -                       vf_devid, initial_vfs, total_vfs,
> -                       fun_offset, stride);
> +      if (!pcie_sriov_pf_init(d, 0x200, "your_virtual_dev",
> +                              vf_devid, initial_vfs, total_vfs,
> +                              fun_offset, stride, errp)) {
> +         return;
> +      }
>  
>        /* Set up individual VF BARs (parameters as for normal BARs) */
>        pcie_sriov_pf_init_vf_bar( ... )
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index fa6313aabc43..fae83b9b723c 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -643,6 +643,6 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
>  }
>  
>  MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
> -void pci_set_power(PCIDevice *pci_dev, bool state);
> +void pci_set_enabled(PCIDevice *pci_dev, bool state);
>  
>  #endif
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index 7564e9536dbd..153e13eaef99 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -56,7 +56,7 @@ typedef struct PCIReqIDCache PCIReqIDCache;
>  struct PCIDevice {
>      DeviceState qdev;
>      bool partially_hotplugged;
> -    bool has_power;
> +    bool is_enabled;
>  
>      /* PCI config space */
>      uint8_t *config;
> diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
> index 095fb0c9edf9..d9a39daccac4 100644
> --- a/include/hw/pci/pcie_sriov.h
> +++ b/include/hw/pci/pcie_sriov.h
> @@ -18,7 +18,6 @@
>  struct PCIESriovPF {
>      uint16_t num_vfs;   /* Number of virtual functions created */
>      uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
> -    const char *vfname; /* Reference to the device type used for the VFs */
>      PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
>  };
>  
> @@ -27,10 +26,11 @@ struct PCIESriovVF {
>      uint16_t vf_number; /* Logical VF number of this function */
>  };
>  
> -void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
> +bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>                          const char *vfname, uint16_t vf_dev_id,
>                          uint16_t init_vfs, uint16_t total_vfs,
> -                        uint16_t vf_offset, uint16_t vf_stride);
> +                        uint16_t vf_offset, uint16_t vf_stride,
> +                        Error **errp);
>  void pcie_sriov_pf_exit(PCIDevice *dev);
>  
>  /* Set up a VF bar in the SR/IOV bar area */
> diff --git a/hw/net/igb.c b/hw/net/igb.c
> index 0b5c31a58bba..1079a33d4000 100644
> --- a/hw/net/igb.c
> +++ b/hw/net/igb.c
> @@ -447,9 +447,16 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
>  
>      pcie_ari_init(pci_dev, 0x150);
>  
> -    pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
> -        IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
> -        IGB_VF_OFFSET, IGB_VF_STRIDE);
> +    if (!pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET,
> +                            TYPE_IGBVF, IGB_82576_VF_DEV_ID,
> +                            IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
> +                            IGB_VF_OFFSET, IGB_VF_STRIDE,
> +                            errp)) {
> +        pcie_cap_exit(pci_dev);
> +        igb_cleanup_msix(s);
> +        msi_uninit(pci_dev);
> +        return;
> +    }
>  
>      pcie_sriov_pf_init_vf_bar(pci_dev, IGBVF_MMIO_BAR_IDX,
>          PCI_BASE_ADDRESS_MEM_TYPE_64 | PCI_BASE_ADDRESS_MEM_PREFETCH,
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f026245d1e9e..f8df622fe590 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8031,7 +8031,8 @@ static uint64_t nvme_bar_size(unsigned total_queues, unsigned total_irqs,
>      return bar_size;
>  }
>  
> -static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
> +static bool nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset,
> +                            Error **errp)
>  {
>      uint16_t vf_dev_id = n->params.use_intel_id ?
>                           PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
> @@ -8040,12 +8041,17 @@ static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
>                                        le16_to_cpu(cap->vifrsm),
>                                        NULL, NULL);
>  
> -    pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
> -                       n->params.sriov_max_vfs, n->params.sriov_max_vfs,
> -                       NVME_VF_OFFSET, NVME_VF_STRIDE);
> +    if (!pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
> +                            n->params.sriov_max_vfs, n->params.sriov_max_vfs,
> +                            NVME_VF_OFFSET, NVME_VF_STRIDE,
> +                            errp)) {
> +        return false;
> +    }
>  
>      pcie_sriov_pf_init_vf_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>                                PCI_BASE_ADDRESS_MEM_TYPE_64, bar_size);
> +
> +    return true;
>  }
>  
>  static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
> @@ -8124,6 +8130,12 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
>          return false;
>      }
>  
> +    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs &&
> +        !nvme_init_sriov(n, pci_dev, 0x120, errp)) {
> +        msix_uninit(pci_dev, &n->bar0, &n->bar0);
> +        return false;
> +    }
> +
>      nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
>  
>      if (n->params.cmb_size_mb) {
> @@ -8134,10 +8146,6 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
>          nvme_init_pmr(n, pci_dev);
>      }
>  
> -    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
> -        nvme_init_sriov(n, pci_dev, 0x120);
> -    }
> -
>      return true;
>  }
>  
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index d08548d8ffe9..727d812f419f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1522,7 +1522,7 @@ static void pci_update_mappings(PCIDevice *d)
>              continue;
>  
>          new_addr = pci_bar_address(d, i, r->type, r->size);
> -        if (!d->has_power) {
> +        if (!d->is_enabled) {
>              new_addr = PCI_BAR_UNMAPPED;
>          }
>  
> @@ -1610,7 +1610,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
>          pci_update_irq_disabled(d, was_irq_disabled);
>          memory_region_set_enabled(&d->bus_master_enable_region,
>                                    (pci_get_word(d->config + PCI_COMMAND)
> -                                   & PCI_COMMAND_MASTER) && d->has_power);
> +                                   & PCI_COMMAND_MASTER) && d->is_enabled);
>      }
>  
>      msi_write_config(d, addr, val_in, l);
> @@ -2179,7 +2179,9 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>          return;
>      }
>  
> -    pci_set_power(pci_dev, true);
> +    if (!pci_is_vf(pci_dev)) {
> +        pci_set_enabled(pci_dev, true);
> +    }
>  
>      pci_dev->msi_trigger = pci_msi_trigger;
>  }
> @@ -2835,18 +2837,18 @@ MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
>      return msg;
>  }
>  
> -void pci_set_power(PCIDevice *d, bool state)
> +void pci_set_enabled(PCIDevice *d, bool state)
>  {
> -    if (d->has_power == state) {
> +    if (d->is_enabled == state) {
>          return;
>      }
>  
> -    d->has_power = state;
> +    d->is_enabled = state;
>      pci_update_mappings(d);
>      memory_region_set_enabled(&d->bus_master_enable_region,
>                                (pci_get_word(d->config + PCI_COMMAND)
> -                               & PCI_COMMAND_MASTER) && d->has_power);
> -    if (!d->has_power) {
> +                               & PCI_COMMAND_MASTER) && d->is_enabled);
> +    if (d->qdev.realized) {
>          pci_device_reset(d);
>      }
>  }
> diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> index dfe6fe618401..d7e13d72ce07 100644
> --- a/hw/pci/pci_host.c
> +++ b/hw/pci/pci_host.c
> @@ -86,7 +86,7 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
>       * allowing direct removal of unexposed functions.
>       */
>      if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
> -        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
> +        !pci_dev->is_enabled || is_pci_dev_ejected(pci_dev)) {
>          return;
>      }
>  
> @@ -111,7 +111,7 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
>       * allowing direct removal of unexposed functions.
>       */
>      if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
> -        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
> +        !pci_dev->is_enabled || is_pci_dev_ejected(pci_dev)) {
>          return ~0x0;
>      }
>  
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 6db0cf69cd8a..f34c157e1fd3 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -394,7 +394,9 @@ static void pcie_set_power_device(PCIBus *bus, PCIDevice *dev, void *opaque)
>  {
>      bool *power = opaque;
>  
> -    pci_set_power(dev, *power);
> +    if (!pci_is_vf(dev)) {
> +        pci_set_enabled(dev, *power);
> +    }
>  }
>  
>  static void pcie_cap_update_power(PCIDevice *hotplug_dev)
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index da209b7f47fd..9ba34cf8f8ed 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -20,15 +20,29 @@
>  #include "qapi/error.h"
>  #include "trace.h"
>  
> -static PCIDevice *register_vf(PCIDevice *pf, int devfn,
> -                              const char *name, uint16_t vf_num);
> -static void unregister_vfs(PCIDevice *dev);
> +static void unrealize_vfs(PCIDevice *dev, uint16_t total_vfs)
> +{
> +    for (uint16_t i = 0; i < total_vfs; i++) {
> +        Error *err = NULL;
> +        PCIDevice *vf = dev->exp.sriov_pf.vf[i];
> +        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
> +            error_reportf_err(err, "Failed to unplug: ");
> +        }
> +        object_unparent(OBJECT(vf));
> +        object_unref(OBJECT(vf));
> +    }
> +    g_free(dev->exp.sriov_pf.vf);
> +    dev->exp.sriov_pf.vf = NULL;
> +}
>  
> -void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
> +bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>                          const char *vfname, uint16_t vf_dev_id,
>                          uint16_t init_vfs, uint16_t total_vfs,
> -                        uint16_t vf_offset, uint16_t vf_stride)
> +                        uint16_t vf_offset, uint16_t vf_stride,
> +                        Error **errp)
>  {
> +    BusState *bus = qdev_get_parent_bus(&dev->qdev);
> +    int32_t devfn = dev->devfn + vf_offset;
>      uint8_t *cfg = dev->config + offset;
>      uint8_t *wmask;
>  
> @@ -36,7 +50,6 @@ void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>                          offset, PCI_EXT_CAP_SRIOV_SIZEOF);
>      dev->exp.sriov_cap = offset;
>      dev->exp.sriov_pf.num_vfs = 0;
> -    dev->exp.sriov_pf.vfname = g_strdup(vfname);
>      dev->exp.sriov_pf.vf = NULL;
>  
>      pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
> @@ -69,13 +82,35 @@ void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>      pci_set_word(wmask + PCI_SRIOV_SYS_PGSIZE, 0x553);
>  
>      qdev_prop_set_bit(&dev->qdev, "multifunction", true);
> +
> +    dev->exp.sriov_pf.vf = g_new(PCIDevice *, total_vfs);
> +
> +    for (uint16_t i = 0; i < total_vfs; i++) {
> +        PCIDevice *vf = pci_new(devfn, vfname);
> +        vf->exp.sriov_vf.pf = dev;
> +        vf->exp.sriov_vf.vf_number = i;
> +
> +        if (!qdev_realize(&vf->qdev, bus, errp)) {
> +            unrealize_vfs(dev, i);
> +            return false;
> +        }
> +
> +        /* set vid/did according to sr/iov spec - they are not used */
> +        pci_config_set_vendor_id(vf->config, 0xffff);
> +        pci_config_set_device_id(vf->config, 0xffff);
> +
> +        dev->exp.sriov_pf.vf[i] = vf;
> +        devfn += vf_stride;
> +    }
> +
> +    return true;
>  }
>  
>  void pcie_sriov_pf_exit(PCIDevice *dev)
>  {
> -    unregister_vfs(dev);
> -    g_free((char *)dev->exp.sriov_pf.vfname);
> -    dev->exp.sriov_pf.vfname = NULL;
> +    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
> +
> +    unrealize_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
>  }
>  
>  void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
> @@ -141,38 +176,11 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
>      }
>  }
>  
> -static PCIDevice *register_vf(PCIDevice *pf, int devfn, const char *name,
> -                              uint16_t vf_num)
> -{
> -    PCIDevice *dev = pci_new(devfn, name);
> -    dev->exp.sriov_vf.pf = pf;
> -    dev->exp.sriov_vf.vf_number = vf_num;
> -    PCIBus *bus = pci_get_bus(pf);
> -    Error *local_err = NULL;
> -
> -    qdev_realize(&dev->qdev, &bus->qbus, &local_err);
> -    if (local_err) {
> -        error_report_err(local_err);
> -        return NULL;
> -    }
> -
> -    /* set vid/did according to sr/iov spec - they are not used */
> -    pci_config_set_vendor_id(dev->config, 0xffff);
> -    pci_config_set_device_id(dev->config, 0xffff);
> -
> -    return dev;
> -}
> -
>  static void register_vfs(PCIDevice *dev)
>  {
>      uint16_t num_vfs;
>      uint16_t i;
>      uint16_t sriov_cap = dev->exp.sriov_cap;
> -    uint16_t vf_offset =
> -        pci_get_word(dev->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
> -    uint16_t vf_stride =
> -        pci_get_word(dev->config + sriov_cap + PCI_SRIOV_VF_STRIDE);
> -    int32_t devfn = dev->devfn + vf_offset;
>  
>      assert(sriov_cap > 0);
>      num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
> @@ -180,18 +188,10 @@ static void register_vfs(PCIDevice *dev)
>          return;
>      }
>  
> -    dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
> -
>      trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
>                               PCI_FUNC(dev->devfn), num_vfs);
>      for (i = 0; i < num_vfs; i++) {
> -        dev->exp.sriov_pf.vf[i] = register_vf(dev, devfn,
> -                                              dev->exp.sriov_pf.vfname, i);
> -        if (!dev->exp.sriov_pf.vf[i]) {
> -            num_vfs = i;
> -            break;
> -        }
> -        devfn += vf_stride;
> +        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
>      }
>      dev->exp.sriov_pf.num_vfs = num_vfs;
>  }
> @@ -204,16 +204,8 @@ static void unregister_vfs(PCIDevice *dev)
>      trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
>                                 PCI_FUNC(dev->devfn), num_vfs);
>      for (i = 0; i < num_vfs; i++) {
> -        Error *err = NULL;
> -        PCIDevice *vf = dev->exp.sriov_pf.vf[i];
> -        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
> -            error_reportf_err(err, "Failed to unplug: ");
> -        }
> -        object_unparent(OBJECT(vf));
> -        object_unref(OBJECT(vf));
> +        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
>      }
> -    g_free(dev->exp.sriov_pf.vf);
> -    dev->exp.sriov_pf.vf = NULL;
>      dev->exp.sriov_pf.num_vfs = 0;
>      pci_set_word(dev->config + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0);
>  }
> 
> -- 
> 2.43.0


