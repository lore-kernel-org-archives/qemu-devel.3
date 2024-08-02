Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA93C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 16:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZvY2-0005VJ-OJ; Fri, 02 Aug 2024 12:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZvY1-0005Os-0j
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZvXz-0003j9-0j
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722617669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLpi6dfgzaqIYB0hqMXClwe2YLGyGoUfc5pxZdm4LbM=;
 b=ZaqgWpIW1Yei6Q7lLQwX2t8pubx+M1g7KKmam9gnYBava4QD0ixUAxJhsHZw931i+61uGe
 nNqI/cyRVtz7zqxVVWB2EH7+wtpmyZ99tbYgPRLNXBNQQ9NaUu3IzLyz9QZQOe3re2TKRU
 20clSuENLsXNGONqyhzWjWJ28VL2eHk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-sdBvh3-cNfuI3BRAubyP5A-1; Fri, 02 Aug 2024 12:54:28 -0400
X-MC-Unique: sdBvh3-cNfuI3BRAubyP5A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4281b7196bbso47330555e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 09:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722617667; x=1723222467;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLpi6dfgzaqIYB0hqMXClwe2YLGyGoUfc5pxZdm4LbM=;
 b=qz3zn1C9z7LciQxocQnH4w9FscC/0gsKvvi55kOi6R7YEQqZv/NnlgBd9habm2hgAO
 8uAutBPj/caoAzpjshOQxy8YF/tUwKrRt/u4Oy4tvgCdGbkRurTBh9sa63KsSXl5RMSr
 P6Z1kU0BzDtq+KQjFZG4oD/w5HLg6lHwXOnGIovRheJCfdwdfa4491rCHWKtAJvkdGK6
 WRD30JvHNY5hnABC2o1uxRaFXYf8hEnd5gXqFUjwhhUEJAU1kXEGtV/XksKJetdPzpRZ
 +7sALqk2TO8S+KkzLZ8njZuDt8iMbjvQvqOnn/4tUU5uNR2e7KXs8IduIPnO383Ytr2V
 yFpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHmbBLu9OxKWpM9O53jFYmDsXSDRxCm8IUksJA8oheHD3Chep7i6ynWlmmjHeLAWxvxpfjUvV6Q+sj4VpwppL/UfYNMdY=
X-Gm-Message-State: AOJu0YxvlKPcf2dWVpDRsTOo7zC59u7zM3FLJdA2ww52AMIkt+hv/uaY
 5VyGuNKoKISDe2Qswq9mGqCIH/oyOuxKowbddUWiUqB6LJ6nFcZPxTgS/pPfx8iIiBJdnqzxf/c
 QYH/U6fFb4QA8juwu9VltBGZDMrQ/OlwiEs2sCdC0zr8cCSpsKB6j
X-Received: by 2002:a05:600c:3b94:b0:427:faa6:5648 with SMTP id
 5b1f17b1804b1-428e6af2e25mr26168905e9.3.1722617666697; 
 Fri, 02 Aug 2024 09:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF106OCQKz2gKdKVpNM3Hl2+tqyqFAfVBM/PEUxl8QkPiVgEitGNPRcnjzHPNUo30Iyjp0xOw==
X-Received: by 2002:a05:600c:3b94:b0:427:faa6:5648 with SMTP id
 5b1f17b1804b1-428e6af2e25mr26168545e9.3.1722617665877; 
 Fri, 02 Aug 2024 09:54:25 -0700 (PDT)
Received: from redhat.com ([31.187.78.99]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89a862sm100867105e9.4.2024.08.02.09.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:54:25 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:54:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH for-9.2 v11 06/11] pcie_sriov: Reuse SR-IOV VF device
 instances
Message-ID: <20240802125342-mutt-send-email-mst@kernel.org>
References: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
 <20240802-reuse-v11-6-fb83bb8c19fb@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-reuse-v11-6-fb83bb8c19fb@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 02, 2024 at 02:17:56PM +0900, Akihiko Odaki wrote:
> Disable SR-IOV VF devices by reusing code to power down PCI devices
> instead of removing them when the guest requests to disable VFs. This
> allows to realize devices and report VF realization errors at PF
> realization time.

What kind of errors do you have in mind?


> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/hw/pci/pci.h        |  5 ---
>  include/hw/pci/pci_device.h | 15 +++++++
>  include/hw/pci/pcie_sriov.h |  1 -
>  hw/pci/pci.c                |  2 +-
>  hw/pci/pcie_sriov.c         | 95 +++++++++++++++++++--------------------------
>  5 files changed, 56 insertions(+), 62 deletions(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index fe04b4fafd04..14a869eeaa71 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -680,9 +680,4 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
>  MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
>  void pci_set_enabled(PCIDevice *pci_dev, bool state);
>  
> -static inline void pci_set_power(PCIDevice *pci_dev, bool state)
> -{
> -    pci_set_enabled(pci_dev, state);
> -}
> -
>  #endif
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index f38fb3111954..1ff3ce94e25b 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -212,6 +212,21 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
>      return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
>  }
>  
> +static inline void pci_set_power(PCIDevice *pci_dev, bool state)
> +{
> +    /*
> +     * Don't change the enabled state of VFs when powering on/off the device.
> +     *
> +     * When powering on, VFs must not be enabled immediately but they must
> +     * wait until the guest configures SR-IOV.
> +     * When powering off, their corresponding PFs will be reset and disable
> +     * VFs.
> +     */
> +    if (!pci_is_vf(pci_dev)) {
> +        pci_set_enabled(pci_dev, state);
> +    }
> +}
> +
>  uint16_t pci_requester_id(PCIDevice *dev);
>  
>  /* DMA access functions */
> diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
> index aa704e8f9d9f..70649236c18a 100644
> --- a/include/hw/pci/pcie_sriov.h
> +++ b/include/hw/pci/pcie_sriov.h
> @@ -18,7 +18,6 @@
>  typedef struct PCIESriovPF {
>      uint16_t num_vfs;   /* Number of virtual functions created */
>      uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
> -    const char *vfname; /* Reference to the device type used for the VFs */
>      PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
>  } PCIESriovPF;
>  
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b532888e8f6c..5c0050e1786a 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2895,7 +2895,7 @@ void pci_set_enabled(PCIDevice *d, bool state)
>      memory_region_set_enabled(&d->bus_master_enable_region,
>                                (pci_get_word(d->config + PCI_COMMAND)
>                                 & PCI_COMMAND_MASTER) && d->enabled);
> -    if (!d->enabled) {
> +    if (d->qdev.realized) {
>          pci_device_reset(d);
>      }
>  }
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index f0bde0d3fc79..faadb0d2ea85 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -20,9 +20,16 @@
>  #include "qapi/error.h"
>  #include "trace.h"
>  
> -static PCIDevice *register_vf(PCIDevice *pf, int devfn,
> -                              const char *name, uint16_t vf_num);
> -static void unregister_vfs(PCIDevice *dev);
> +static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
> +{
> +    for (uint16_t i = 0; i < total_vfs; i++) {
> +        PCIDevice *vf = dev->exp.sriov_pf.vf[i];
> +        object_unparent(OBJECT(vf));
> +        object_unref(OBJECT(vf));
> +    }
> +    g_free(dev->exp.sriov_pf.vf);
> +    dev->exp.sriov_pf.vf = NULL;
> +}
>  
>  bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>                          const char *vfname, uint16_t vf_dev_id,
> @@ -30,6 +37,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>                          uint16_t vf_offset, uint16_t vf_stride,
>                          Error **errp)
>  {
> +    BusState *bus = qdev_get_parent_bus(&dev->qdev);
> +    int32_t devfn = dev->devfn + vf_offset;
>      uint8_t *cfg = dev->config + offset;
>      uint8_t *wmask;
>  
> @@ -49,7 +58,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>                          offset, PCI_EXT_CAP_SRIOV_SIZEOF);
>      dev->exp.sriov_cap = offset;
>      dev->exp.sriov_pf.num_vfs = 0;
> -    dev->exp.sriov_pf.vfname = g_strdup(vfname);
>      dev->exp.sriov_pf.vf = NULL;
>  
>      pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
> @@ -83,14 +91,34 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>  
>      qdev_prop_set_bit(&dev->qdev, "multifunction", true);
>  
> +    dev->exp.sriov_pf.vf = g_new(PCIDevice *, total_vfs);
> +
> +    for (uint16_t i = 0; i < total_vfs; i++) {
> +        PCIDevice *vf = pci_new(devfn, vfname);
> +        vf->exp.sriov_vf.pf = dev;
> +        vf->exp.sriov_vf.vf_number = i;
> +
> +        if (!qdev_realize(&vf->qdev, bus, errp)) {
> +            unparent_vfs(dev, i);
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
>      return true;
>  }
>  
>  void pcie_sriov_pf_exit(PCIDevice *dev)
>  {
> -    unregister_vfs(dev);
> -    g_free((char *)dev->exp.sriov_pf.vfname);
> -    dev->exp.sriov_pf.vfname = NULL;
> +    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
> +
> +    unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
>  }
>  
>  void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
> @@ -156,38 +184,11 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
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
> @@ -195,18 +196,10 @@ static void register_vfs(PCIDevice *dev)
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
> @@ -219,12 +212,8 @@ static void unregister_vfs(PCIDevice *dev)
>      trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
>                                 PCI_FUNC(dev->devfn), num_vfs);
>      for (i = 0; i < num_vfs; i++) {
> -        PCIDevice *vf = dev->exp.sriov_pf.vf[i];
> -        object_unparent(OBJECT(vf));
> -        object_unref(OBJECT(vf));
> +        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
>      }
> -    g_free(dev->exp.sriov_pf.vf);
> -    dev->exp.sriov_pf.vf = NULL;
>      dev->exp.sriov_pf.num_vfs = 0;
>  }
>  
> @@ -246,14 +235,10 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
>                               PCI_FUNC(dev->devfn), off, val, len);
>  
>      if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
> -        if (dev->exp.sriov_pf.num_vfs) {
> -            if (!(val & PCI_SRIOV_CTRL_VFE)) {
> -                unregister_vfs(dev);
> -            }
> +        if (val & PCI_SRIOV_CTRL_VFE) {
> +            register_vfs(dev);
>          } else {
> -            if (val & PCI_SRIOV_CTRL_VFE) {
> -                register_vfs(dev);
> -            }
> +            unregister_vfs(dev);
>          }
>      }
>  }
> 
> -- 
> 2.45.2


