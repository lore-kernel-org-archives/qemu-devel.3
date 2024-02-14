Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CFBC4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 07:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raA6V-00013i-8h; Wed, 14 Feb 2024 02:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raA6P-00013C-02
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:54:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raA6J-0001Zj-Hl
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707897278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g26i70Cw5l11KRZfWA9cqNcuwZP5U8uBLkA4dbsUtP4=;
 b=MnD3Yosz65j5+jwoXQGDdmlBzj1qxwboLn6Kx72PJxQkcWQZ9mqrcKJ2Hpy7jC6YROMfBX
 wZTmBxtNDk+35W4B7RzK4EjWCCgBvK1yXN1m8/qT/MiiubBMItqDay4G6FqbBCXjXfs8Gc
 8uj1T0i2BBeCZPHjfi7FfWpAorx33IM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-7LJReeN-NKmsat5wk5j7qA-1; Wed, 14 Feb 2024 02:54:37 -0500
X-MC-Unique: 7LJReeN-NKmsat5wk5j7qA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33cf207a087so15282f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 23:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707897256; x=1708502056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g26i70Cw5l11KRZfWA9cqNcuwZP5U8uBLkA4dbsUtP4=;
 b=sfLbfYoD+Ujz0VX47mGqhas89TLu4NK5c9u8R9NT8meACgENrFphch4Qx/F1LNk3CO
 q9VqN0mGjjZFePWUgkdXF5zMJqulxUZNBBy4zZ54XrRzfBBtop1tgKJ/szH6qg1zUMC8
 G8zB51091AIhPNhsp0kiYd9+o6pGEYxs6BOr0/imy/FXMFvMQKit0orDaaYsLJWt9ahp
 udbS3WOR64SvsKqBQcfabTyJoqf1DI08NbNmVLfPd8V4+d6sW7kYt4felzSwztPzJSj4
 Pe0aWAfGYTqdjGa1NlM76cXGmhmwbjd/8vNy9HknyiqmTSi1BBTCbKgA4lMbznh8wfs+
 uHHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbP9tg1di8TsikeWXdEZPPuzv7yXLPDaCK65foc06+s7O4E15Ma3isgiqvMq/daLBdjp+746G6nET7SYGgp4ZE1tJCxjI=
X-Gm-Message-State: AOJu0Yxt8ogY1zdxkigaYH1Xd/qrYj89YvbZTakVhD1GZGf/WQ7az2Wg
 HJqoMnQUjlOANJOTMH0IL8ytuRaqfrhTin1JfAV2dyO8ZBFYpHAHO/rDYkkGWzgQkagFsrO2mlL
 p8o9kvJ4x84domdgcSJuLXbSFER3SmDvZNiHbqQUYK417WevW5LR5
X-Received: by 2002:a5d:4fc1:0:b0:33b:376b:8127 with SMTP id
 h1-20020a5d4fc1000000b0033b376b8127mr1059245wrw.54.1707897256264; 
 Tue, 13 Feb 2024 23:54:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxy8EK9+nmP0HfrR2FPwS5w0w/mJLbnCLbk6OIJfVuE5IkonnOWU/YSUVbMgdWpfxG3/uS2Q==
X-Received: by 2002:a5d:4fc1:0:b0:33b:376b:8127 with SMTP id
 h1-20020a5d4fc1000000b0033b376b8127mr1059234wrw.54.1707897255845; 
 Tue, 13 Feb 2024 23:54:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWtou2doYFovdqK3DV1lXTMbxgiohW30O7Ys/ACX7POwicIveZzVpCuM4aPY6BltaVg+ahTSzyx7uk+iLcLTkto0Dxgb6ltlgXk17EsrqaH9an4EMh+apq2fl8Eoc3Lza+/5gezdoYalXnj8dcZv5yKezfCR4gB2ODKoe4o2RJv4dsyt8yoQrBc5bqlasCpQzS9UpBvPEcLkk3SQHNCRLQEOciZxSi2Fjq0uxqChdac3H7YyZEs3bFW5+OnyZWgqq+zUiyUUehWFgz4SVELz7fWoJlD4cE0yAxSMUUHiRviSEcd1lVRxSUVdsj6rsvAzHjNZ9IvS8w6Pc23MeBUOWUadt+a7wPui1UmVsl0PZKoqnkJM/U85/Bc1ii8/JC0cdq6KXbJQ81pfQW2zAWBEmjwlLLRwd/KxWZJtQ==
Received: from redhat.com ([2a02:14f:1f0:720f:e338:175b:c44e:aa92])
 by smtp.gmail.com with ESMTPSA id
 v5-20020a5d59c5000000b0033b74a3dcf9sm10554862wry.27.2024.02.13.23.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 23:54:15 -0800 (PST)
Date: Wed, 14 Feb 2024 02:54:10 -0500
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
Subject: Re: [PATCH v4 6/9] pcie_sriov: Reuse SR-IOV VF device instances
Message-ID: <20240214024239-mutt-send-email-mst@kernel.org>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-6-89ad093a07f4@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-reuse-v4-6-89ad093a07f4@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

On Wed, Feb 14, 2024 at 02:13:44PM +0900, Akihiko Odaki wrote:
> Disable SR-IOV VF devices by reusing code to power down PCI devices
> instead of removing them when the guest requests to disable VFs. This
> allows to realize devices and report VF realization errors at PF
> realization time.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

This patch does much more than what commit log says.
This really needs to be split up with each change you make
documented.

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
> index eaa3fc99d884..442017b4865d 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -642,6 +642,6 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
>  }
>  
>  MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
> -void pci_set_power(PCIDevice *pci_dev, bool state);
> +void pci_set_enabled(PCIDevice *pci_dev, bool state);

Not a good name. Does this set enabled state? Test whether
some kind of set is enabled?

>  
>  #endif
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index 54fa0676abf1..f5aba8ae2675 100644
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

Returning false to indicate an error is a bad idea -
most APIs we have return 0 on success, < 0 on error.
Or just use errp.


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

why this change?

> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 47f38375bb09..838c261c21f0 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1524,7 +1524,7 @@ static void pci_update_mappings(PCIDevice *d)
>              continue;
>  
>          new_addr = pci_bar_address(d, i, r->type, r->size);
> -        if (!d->has_power) {
> +        if (!d->is_enabled) {
>              new_addr = PCI_BAR_UNMAPPED;
>          }
>  
> @@ -1612,7 +1612,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
>          pci_update_irq_disabled(d, was_irq_disabled);
>          memory_region_set_enabled(&d->bus_master_enable_region,
>                                    (pci_get_word(d->config + PCI_COMMAND)
> -                                   & PCI_COMMAND_MASTER) && d->has_power);
> +                                   & PCI_COMMAND_MASTER) && d->is_enabled);
>      }
>  
>      msi_write_config(d, addr, val_in, l);
> @@ -2154,7 +2154,9 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>          return;
>      }
>  
> -    pci_set_power(pci_dev, true);
> +    if (!pci_is_vf(pci_dev)) {
> +        pci_set_enabled(pci_dev, true);
> +    }

why are you not enabling vfs specifically? seems confusing. you also
duplicate this logic in a couple more places. needs a
comment at least. Or better, add sane APIs that do this correctly.
E.g. keep pci_set_power around?

>  
>      pci_dev->msi_trigger = pci_msi_trigger;
>  }
> @@ -2810,18 +2812,18 @@ MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
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


