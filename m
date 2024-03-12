Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397D3C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk86Q-0008Mb-IR; Tue, 12 Mar 2024 15:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk86O-0008Ll-73
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk86L-00051j-PB
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710272873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRRcVmq3BiQnRT2ufsm2ETCupzqEfgEqahERApW/vBQ=;
 b=FXrSGlQusfjE5Nix1Us08uFQ4giuLFX7amSxt6p54l87/yDzY0nZPkgVFJDy5n7IuLn084
 BqWIy/+ZFQ+a9kmPHSQ8yMp2vxs/+sCxSynWlKgbRSVac4C/0kEgY3+FwtOR6tgP1RSzO0
 CPhkfvslyhNXdxYIi6s2Ag6QRr5Wgw4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-6yZk-BLwPhCXywD-XEmjhQ-1; Tue, 12 Mar 2024 15:47:50 -0400
X-MC-Unique: 6yZk-BLwPhCXywD-XEmjhQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-56864a010bbso1628774a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 12:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710272869; x=1710877669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRRcVmq3BiQnRT2ufsm2ETCupzqEfgEqahERApW/vBQ=;
 b=knDGmn5BlxxL6ocBZIwX/xWFv6gsbVOP64YvKNNf4PDrlxv4un6BmtmAnw6P0x53s1
 KgMGGloa7uE2PUZn7dr9TS9FaUsSG5/V4M9bX7u4N0/8uQF8V0UTkRr4Yp8gJeMFu4cs
 DC06b0ehoqfxM+kOxgIkv10sJ7Auc6NbtQpFLGt85cbGLZBJSUH6jqsdef2UtDHpIZNe
 wb6c4Zdb3Jwrsu2itX7CYa0ZrUI21C5ud3qECiXicRlZeQ9G1OR4DS7GJ7oxKrRJ7kVz
 x3mhRTNI7HmiA2SWv4df1q+W2hBadoauEnTBCG8ECszsiET0fHlrlb0s43a+SeMPcpn1
 y6Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXru7ZgzXaVpr3nfZ8fRRf3SE6b8U/+gesH7NflZB1lauXUK0u80vHLeWTPg397S48tu9xqsgEWA3EGpu72R6rTgCxevys=
X-Gm-Message-State: AOJu0YxmRmGJKyrgf/vJiKE+4Ii1/F90aXc9aqN7v2aNLGMfJM51rWJ5
 JQ4//9wPAFoDFTBZ1+UyBD8j6sz4SvxEYUqV8k89VPav+0Id82U83gEbSBt6rCmkDPgqHnfpXhO
 L9qlvG537Ph7bi7Vw2xZSP4sX/7JAl5XQiQVu6CbRj3ZZY0nY0gYT
X-Received: by 2002:a17:907:a0cc:b0:a46:134c:ae8d with SMTP id
 hw12-20020a170907a0cc00b00a46134cae8dmr5649656ejc.29.1710272869168; 
 Tue, 12 Mar 2024 12:47:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9VaSqIpolvqDT3cUA+i3Kiqac37+nrcXrv9SnVipcP1wvcUW6DgEL/6FTfn/a++8HgzUn/Q==
X-Received: by 2002:a17:907:a0cc:b0:a46:134c:ae8d with SMTP id
 hw12-20020a170907a0cc00b00a46134cae8dmr5649633ejc.29.1710272868603; 
 Tue, 12 Mar 2024 12:47:48 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 bk2-20020a170906b0c200b00a44ef54b6b6sm4119483ejb.58.2024.03.12.12.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 12:47:47 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:47:42 -0400
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
Subject: Re: [PATCH v6 08/15] pcie_sriov: Reuse SR-IOV VF device instances
Message-ID: <20240312153840-mutt-send-email-mst@kernel.org>
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
 <20240220-reuse-v6-8-2e42a28b0cf2@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-reuse-v6-8-2e42a28b0cf2@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Feb 20, 2024 at 09:24:43PM +0900, Akihiko Odaki wrote:
> Disable SR-IOV VF devices by reusing code to power down PCI devices
> instead of removing them when the guest requests to disable VFs. This
> allows to realize devices and report VF realization errors at PF
> realization time.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  docs/pcie_sriov.txt         |   8 ++--
>  include/hw/pci/pci.h        |   5 ---
>  include/hw/pci/pci_device.h |  15 +++++++
>  include/hw/pci/pcie_sriov.h |   6 +--
>  hw/net/igb.c                |  13 ++++--
>  hw/nvme/ctrl.c              |  24 +++++++----
>  hw/pci/pci.c                |   2 +-
>  hw/pci/pcie_sriov.c         | 102 +++++++++++++++++++-------------------------
>  8 files changed, 95 insertions(+), 80 deletions(-)
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
> index 6c92b2f70008..442017b4865d 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -644,9 +644,4 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
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
> index d57f9ce83884..ca151325085d 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -205,6 +205,21 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
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
> index b77eb7bf58ac..4b1133f79e15 100644
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
> index 9b37523d6df8..907259fd8b3b 100644
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


So, this breaks igb:

 ./build/qemu-system-ppc -S -machine mpc8544ds,accel=tcg -device igb
Unexpected error in set_pci_devfn() at ../hw/core/qdev-properties-system.c:795:
qemu-system-ppc: -device igb: Parameter 'addr' expects a value between -1 and 255
Aborted (core dumped)


Dropped for now.


> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index c1af4b87b34a..98c3e942077c 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8027,7 +8027,8 @@ static uint64_t nvme_bar_size(unsigned total_queues, unsigned total_irqs,
>      return bar_size;
>  }
>  
> -static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
> +static bool nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset,
> +                            Error **errp)
>  {
>      uint16_t vf_dev_id = n->params.use_intel_id ?
>                           PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
> @@ -8036,12 +8037,17 @@ static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
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
> @@ -8120,6 +8126,12 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
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
> @@ -8130,10 +8142,6 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
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
> index 8bde13f7cd1e..750c2ba696d1 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2822,7 +2822,7 @@ void pci_set_enabled(PCIDevice *d, bool state)
>      memory_region_set_enabled(&d->bus_master_enable_region,
>                                (pci_get_word(d->config + PCI_COMMAND)
>                                 & PCI_COMMAND_MASTER) && d->enabled);
> -    if (!d->enabled) {
> +    if (d->qdev.realized) {
>          pci_device_reset(d);
>      }
>  }
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index 8b1fd2a89ad7..d934cd7d0e64 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -19,15 +19,25 @@
>  #include "qemu/range.h"
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
> @@ -35,7 +45,6 @@ void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>                          offset, PCI_EXT_CAP_SRIOV_SIZEOF);
>      dev->exp.sriov_cap = offset;
>      dev->exp.sriov_pf.num_vfs = 0;
> -    dev->exp.sriov_pf.vfname = g_strdup(vfname);
>      dev->exp.sriov_pf.vf = NULL;
>  
>      pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
> @@ -68,13 +77,35 @@ void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
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
> +    unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
>  }
>  
>  void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
> @@ -140,38 +171,11 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
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
> @@ -179,18 +183,10 @@ static void register_vfs(PCIDevice *dev)
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
> @@ -203,12 +199,8 @@ static void unregister_vfs(PCIDevice *dev)
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
> @@ -230,14 +222,10 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
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
> 2.43.1


