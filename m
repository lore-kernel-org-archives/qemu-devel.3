Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA052C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQxQ-0001TF-Mn; Wed, 10 Jul 2024 02:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sRQxO-0001Lh-Ql
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sRQxM-0002i2-Qk
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720593454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=me+H+3sKdqg7KyCoSb0g25ntktYChAt5Iq6L7H32KLs=;
 b=jIoE2VcVLdAh/KuXpFJXA5/u7FzKKPZHFr+WeXPBP2LR6BaywpkGNJerXiCRNb4o5dubGA
 O/sFSCYK1o9dNmm77Pho6VNRiWo4xGm/voBCfSWeCVXxdOmU7TTNoD1qIkwzggjHVEwxJZ
 d82RWr3b97ttpN0/UdLdDMkkpSXaD/w=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-kizu814WOGWJgJBR0MV_CQ-1; Wed, 10 Jul 2024 02:37:33 -0400
X-MC-Unique: kizu814WOGWJgJBR0MV_CQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-65a14a9241bso14673277b3.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720593452; x=1721198252;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=me+H+3sKdqg7KyCoSb0g25ntktYChAt5Iq6L7H32KLs=;
 b=NAmYbOD3bZjzS7MkC34I7A/9luaIWyCeDQYZ8SywTs6MTo7tq8Zx5MfchdvSku5VG+
 rdVWSZ2/xxhChBl8hiRMgl43SyazDB/2d9M1dDKqdk5CZl+d2Rr2WuHXAPTz8NEEJEsB
 glOz4ESeSvqUnS18pV5MjJQ7fokXzywpo/KbLNasLKdRD7xbELF68moeEiksw/6xNb35
 T/WWsTYxCaLyvxDsL5oiHCfMONL2qzDXp9xlwKwHKnRO6bwPBk6OXa6G270/0LvTnSZq
 ge9khCkgm4UAefyPjie+Jg66kg4ryOxWRkJTozY8pzh/78heVIJwlIEUl521xM9uw6Ie
 /5og==
X-Gm-Message-State: AOJu0Yx9val04XYgSB/Yq2E5ZDy2T1apir66enKxFgIAftT2tjfUi0wE
 FDJ5VU/VwZu3v24Lnu/Nsqhrv8Y96xWJEvO/DzHK64d4i6uqGUmBB0F2r6ZNhzKRu2c920xDyBT
 wsxyKxWC+Jkjvuqy4cgOJS6QlEg7WJoT9qwzKEbQr0aKthv1t1FB8
X-Received: by 2002:a81:92c1:0:b0:64a:8767:b069 with SMTP id
 00721157ae682-658ee790471mr51374227b3.3.1720593452198; 
 Tue, 09 Jul 2024 23:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqV7kPATxbILiSHlIrLHu2di0AudxWCBoRz5WZrLjiI4xTEnoV1uQr3fowQXpmJn2ye4vXlA==
X-Received: by 2002:a81:92c1:0:b0:64a:8767:b069 with SMTP id
 00721157ae682-658ee790471mr51374117b3.3.1720593451789; 
 Tue, 09 Jul 2024 23:37:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f18f1a32bsm170535985a.0.2024.07.09.23.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 23:37:31 -0700 (PDT)
Message-ID: <75cbc7d9-b48e-4235-85cf-49dacf3c7483@redhat.com>
Date: Wed, 10 Jul 2024 08:37:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/12] pcie_sriov: Reuse SR-IOV VF device instances
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
 <20240627-reuse-v10-6-7ca0b8ed3d9f@daynix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240627-reuse-v10-6-7ca0b8ed3d9f@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

This change introduced a regression on s390x. I could have spotted it
earlier. Sorry about that. Here is the scenario,

QEMU now creates automatically the PCI device objects representing the
VFs when the PF device is realized in pcie_sriov_pf_init(). This is
good to report errors early but it has an important drawback.

On s390x, PCI devices have a dual S390PCIBusDevice object. This device
model has 'uid' and 'fid' properties which can be either set by the VMM
or, if not, auto-generated by the S390PCIBusDevice realize handler. In
the VF case, these ids are auto-generated by QEMU and they can possibly
conflict with the uid number space of libvirt. The conflict is detected
when the machine is created and the start is aborted with a message :

   2024-07-08T12:51:42.876883Z qemu-system-s390x: -device {"driver":"zpci","uid":17,"fid":16,"target":"hostdev0","id":"zpci17"}: uid 17 already in use

This problem can occur today with a s390x VM using an IGB device.

It worked fine when the VFs were created at OS runtime because the initial
topology of the machine was in place. Adding VFs was more or less like
hotplug. AIUI, libvirt should have full control on the machine topology
and so, creating VFs in QEMU at init time in the back of libvirt seems
like a violation of this rule.

That said, the s390x case is specific and could perhaps be handled in a
special way.

Thanks,

C.



On 6/27/24 8:07 AM, Akihiko Odaki wrote:
> Disable SR-IOV VF devices by reusing code to power down PCI devices
> instead of removing them when the guest requests to disable VFs. This
> allows to realize devices and report VF realization errors at PF
> realization time.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/hw/pci/pci.h        |  5 ---
>   include/hw/pci/pci_device.h | 15 +++++++
>   include/hw/pci/pcie_sriov.h |  1 -
>   hw/pci/pci.c                |  2 +-
>   hw/pci/pcie_sriov.c         | 95 +++++++++++++++++++--------------------------
>   5 files changed, 56 insertions(+), 62 deletions(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 6c92b2f70008..442017b4865d 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -644,9 +644,4 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
>   MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
>   void pci_set_enabled(PCIDevice *pci_dev, bool state);
>   
> -static inline void pci_set_power(PCIDevice *pci_dev, bool state)
> -{
> -    pci_set_enabled(pci_dev, state);
> -}
> -
>   #endif
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index d57f9ce83884..ca151325085d 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -205,6 +205,21 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
>       return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
>   }
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
>   uint16_t pci_requester_id(PCIDevice *dev);
>   
>   /* DMA access functions */
> diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
> index aa704e8f9d9f..70649236c18a 100644
> --- a/include/hw/pci/pcie_sriov.h
> +++ b/include/hw/pci/pcie_sriov.h
> @@ -18,7 +18,6 @@
>   typedef struct PCIESriovPF {
>       uint16_t num_vfs;   /* Number of virtual functions created */
>       uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
> -    const char *vfname; /* Reference to the device type used for the VFs */
>       PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
>   } PCIESriovPF;
>   
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 295a32714a4a..c682c3dcb68e 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2822,7 +2822,7 @@ void pci_set_enabled(PCIDevice *d, bool state)
>       memory_region_set_enabled(&d->bus_master_enable_region,
>                                 (pci_get_word(d->config + PCI_COMMAND)
>                                  & PCI_COMMAND_MASTER) && d->enabled);
> -    if (!d->enabled) {
> +    if (d->qdev.realized) {
>           pci_device_reset(d);
>       }
>   }
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index f0bde0d3fc79..faadb0d2ea85 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -20,9 +20,16 @@
>   #include "qapi/error.h"
>   #include "trace.h"
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
>   bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>                           const char *vfname, uint16_t vf_dev_id,
> @@ -30,6 +37,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>                           uint16_t vf_offset, uint16_t vf_stride,
>                           Error **errp)
>   {
> +    BusState *bus = qdev_get_parent_bus(&dev->qdev);
> +    int32_t devfn = dev->devfn + vf_offset;
>       uint8_t *cfg = dev->config + offset;
>       uint8_t *wmask;
>   
> @@ -49,7 +58,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>                           offset, PCI_EXT_CAP_SRIOV_SIZEOF);
>       dev->exp.sriov_cap = offset;
>       dev->exp.sriov_pf.num_vfs = 0;
> -    dev->exp.sriov_pf.vfname = g_strdup(vfname);
>       dev->exp.sriov_pf.vf = NULL;
>   
>       pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
> @@ -83,14 +91,34 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>   
>       qdev_prop_set_bit(&dev->qdev, "multifunction", true);
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
>       return true;
>   }
>   
>   void pcie_sriov_pf_exit(PCIDevice *dev)
>   {
> -    unregister_vfs(dev);
> -    g_free((char *)dev->exp.sriov_pf.vfname);
> -    dev->exp.sriov_pf.vfname = NULL;
> +    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
> +
> +    unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
>   }
>   
>   void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
> @@ -156,38 +184,11 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
>       }
>   }
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
>   static void register_vfs(PCIDevice *dev)
>   {
>       uint16_t num_vfs;
>       uint16_t i;
>       uint16_t sriov_cap = dev->exp.sriov_cap;
> -    uint16_t vf_offset =
> -        pci_get_word(dev->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
> -    uint16_t vf_stride =
> -        pci_get_word(dev->config + sriov_cap + PCI_SRIOV_VF_STRIDE);
> -    int32_t devfn = dev->devfn + vf_offset;
>   
>       assert(sriov_cap > 0);
>       num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
> @@ -195,18 +196,10 @@ static void register_vfs(PCIDevice *dev)
>           return;
>       }
>   
> -    dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
> -
>       trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
>                                PCI_FUNC(dev->devfn), num_vfs);
>       for (i = 0; i < num_vfs; i++) {
> -        dev->exp.sriov_pf.vf[i] = register_vf(dev, devfn,
> -                                              dev->exp.sriov_pf.vfname, i);
> -        if (!dev->exp.sriov_pf.vf[i]) {
> -            num_vfs = i;
> -            break;
> -        }
> -        devfn += vf_stride;
> +        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
>       }
>       dev->exp.sriov_pf.num_vfs = num_vfs;
>   }
> @@ -219,12 +212,8 @@ static void unregister_vfs(PCIDevice *dev)
>       trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
>                                  PCI_FUNC(dev->devfn), num_vfs);
>       for (i = 0; i < num_vfs; i++) {
> -        PCIDevice *vf = dev->exp.sriov_pf.vf[i];
> -        object_unparent(OBJECT(vf));
> -        object_unref(OBJECT(vf));
> +        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
>       }
> -    g_free(dev->exp.sriov_pf.vf);
> -    dev->exp.sriov_pf.vf = NULL;
>       dev->exp.sriov_pf.num_vfs = 0;
>   }
>   
> @@ -246,14 +235,10 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
>                                PCI_FUNC(dev->devfn), off, val, len);
>   
>       if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
> -        if (dev->exp.sriov_pf.num_vfs) {
> -            if (!(val & PCI_SRIOV_CTRL_VFE)) {
> -                unregister_vfs(dev);
> -            }
> +        if (val & PCI_SRIOV_CTRL_VFE) {
> +            register_vfs(dev);
>           } else {
> -            if (val & PCI_SRIOV_CTRL_VFE) {
> -                register_vfs(dev);
> -            }
> +            unregister_vfs(dev);
>           }
>       }
>   }
> 


