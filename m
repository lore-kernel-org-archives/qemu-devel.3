Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD87D3C90B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKme-0005Wh-2V; Wed, 10 Dec 2025 09:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTKm1-0005Qu-Uu
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:02:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTKlz-0006sO-K3
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765375350;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8kMw6s0g7enS5iey+cogxYbNuww0Ag0WTuE50PrtPmM=;
 b=Zm4NTSOjV76CTZbOliBMGwVXdFdjh4iJ650Fxq6PE6os6/Q4pY6cBWvfP6n0APlIsXMEv1
 7MzPWGXw4tw5sWbYHCSIUL6wqCuvVxv5sfPKWsq/rfx7sEsPh6ANWCEqb6NsCnEZRbGmv5
 rN5GV6nngUQFkQ34iIWSRDBg/4zhrp4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-OmWXMzsWP0yD5zBJHH_QoQ-1; Wed, 10 Dec 2025 09:02:29 -0500
X-MC-Unique: OmWXMzsWP0yD5zBJHH_QoQ-1
X-Mimecast-MFC-AGG-ID: OmWXMzsWP0yD5zBJHH_QoQ_1765375348
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7c7957d978aso7752534b3a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 06:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375348; x=1765980148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kMw6s0g7enS5iey+cogxYbNuww0Ag0WTuE50PrtPmM=;
 b=oQaoeFxd95Z+pWsYOl07vbCGYLL0Xv3srD+bm09o0nsK8EGdXQQQs5n2E3kMA7sqA/
 NjJCuml7ZhhEjxYiljEtTHv9nYZZOcQdZHF5FI1y/EO0VzTG18DtXJ5RyDPkp1BK8+kL
 h4Nt/7cJT/KEhoKFRpGk7IB57eYKp7WcDZhKOiQo6JeLoN3AmCerOFhtjISyVLIHDwIP
 wWvN+LXVajqbXQ3JFuLvAz8hxPUN/JptGRUp+7wYBm76nMWbR+Sew7Y5Oq5YlhVdn+q1
 6dyh0b7WBbwHUCYKOpGezewq/SGhiVjghhDcowgX7sWn6tgcHRFIdEMPGWRVqIfFFVeU
 7uFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnbr8HS7449mljWESIvF+KRA9pKjyjnXyWsfnOI5vWibGCDbp8vMdDqunThlXDfIiNJOkk6H/fLMLK@nongnu.org
X-Gm-Message-State: AOJu0YyGYSQUhEPq1YDO2QIY0yyiLOT7l2gngcEaUGWhuJq+wf5f18vi
 HR9sT5pb1JOFIRbqAFvnzjBPL5414PU55Gpx01nHj+wYwvCvpt3BzS1McX0IUOzDEdJsZMTfh3c
 pepFlIKjrXU3JE2rwRxQAOzqWp9G4A95MPj7hooGe2FUK1yBQfKmV83i+
X-Gm-Gg: AY/fxX64bhjdPF39q/uZUxDfcJYNXrs5Um2CvjV/tthGQZ4elGGNN1O3nPiyD+ufJ5E
 Hqf/rkw81gVD4zaojfN46UCeguLLQNpAp9rmHf/xibRURutFn/yqsxsU6RQiF6kRWhaM2f+RF25
 OEo56Y8noqEAh4qTb+b4PRWGclAV9hBZJ12slRgsx4d2UiTQqcU38FX6NAFU7SZK/wLqhYQuNC3
 6cQHlwZJASVivSSQe//qT4tPtQhX+4cSyIdfDw3nXjDFhk3VGJcL1zfVR7onJa0LWbgZzSKtjfd
 z9YKipn9DP30ntcsW6DH9OCRXY6wahxRErdL5VHIah3mu59cCxMKUzzAvbq/2v/riMgAAlyWlpp
 Fl+Uo2iHenRG7r0rUrcILFhPjreq0UgCUChqhPcTbUimVbAIo5De4WIMZEA==
X-Received: by 2002:a05:6a00:3c85:b0:7e8:4471:8e2 with SMTP id
 d2e1a72fcca58-7f22f9047b3mr2316848b3a.67.1765375347405; 
 Wed, 10 Dec 2025 06:02:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXpej2FgXVTis88uC9E0mZQ5vAMwWELTqS+Fec50hYb2ONw/5cWgz0DnED8syf4fgUoBDQuw==
X-Received: by 2002:a05:6a00:3c85:b0:7e8:4471:8e2 with SMTP id
 d2e1a72fcca58-7f22f9047b3mr2316697b3a.67.1765375345333; 
 Wed, 10 Dec 2025 06:02:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7e2adc5bf17sm19114411b3a.38.2025.12.10.06.02.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 06:02:24 -0800 (PST)
Message-ID: <4a1d4bb2-2ee7-4405-a192-53af38e5e3fd@redhat.com>
Date: Wed, 10 Dec 2025 15:02:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/23] intel_iommu_accel: Stick to system MR for
 IOMMUFD backed host device when x-flts=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-12-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251117093729.1121324-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/17/25 10:37 AM, Zhenzhong Duan wrote:
> When guest enables scalable mode and setup first stage page table, we don't
> want to use IOMMU MR but rather continue using the system MR for IOMMUFD
> backed host device.
>
> Then default HWPT in VFIO contains GPA->HPA mappings which could be reused
> as nesting parent HWPT to construct nested HWPT in vIOMMU.
>
> Move vtd_as_key into intel_iommu_internal.h as it's also used by accel code.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

same here

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/i386/intel_iommu_accel.h    |  6 ++++++
>  hw/i386/intel_iommu_internal.h | 11 +++++++++++
>  hw/i386/intel_iommu.c          | 28 +++++++++++++++-------------
>  hw/i386/intel_iommu_accel.c    | 18 ++++++++++++++++++
>  4 files changed, 50 insertions(+), 13 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index 7ebf137a1a..dbe6ee6982 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -15,6 +15,7 @@
>  #ifdef CONFIG_VTD_ACCEL
>  bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                            Error **errp);
> +VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
>  #else
>  static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
>                                          VTDHostIOMMUDevice *vtd_hiod,
> @@ -24,5 +25,10 @@ static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
>                 "host IOMMU is incompatible with guest first stage translation");
>      return false;
>  }
> +
> +static inline VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
> +{
> +    return NULL;
> +}
>  #endif
>  #endif
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 02522f64e0..d8dad18304 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -685,4 +685,15 @@ typedef struct VTDHostIOMMUDevice {
>      uint8_t devfn;
>      HostIOMMUDevice *hiod;
>  } VTDHostIOMMUDevice;
> +
> +/*
> + * PCI bus number (or SID) is not reliable since the device is usaully
> + * initialized before guest can configure the PCI bridge
> + * (SECONDARY_BUS_NUMBER).
> + */
> +struct vtd_as_key {
> +    PCIBus *bus;
> +    uint8_t devfn;
> +    uint32_t pasid;
> +};
>  #endif
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 4ebf56a74f..29e0281af8 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -56,17 +56,6 @@
>  #define VTD_PE_GET_SS_LEVEL(pe) \
>      (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
>  
> -/*
> - * PCI bus number (or SID) is not reliable since the device is usaully
> - * initialized before guest can configure the PCI bridge
> - * (SECONDARY_BUS_NUMBER).
> - */
> -struct vtd_as_key {
> -    PCIBus *bus;
> -    uint8_t devfn;
> -    uint32_t pasid;
> -};
> -
>  /* bus/devfn is PCI device's real BDF not the aliased one */
>  struct vtd_hiod_key {
>      PCIBus *bus;
> @@ -1731,12 +1720,25 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>  /* Return whether the device is using IOMMU translation. */
>  static bool vtd_switch_address_space(VTDAddressSpace *as)
>  {
> +    IntelIOMMUState *s;
>      bool use_iommu, pt;
>  
>      assert(as);
>  
> -    use_iommu = as->iommu_state->dmar_enabled && !vtd_as_pt_enabled(as);
> -    pt = as->iommu_state->dmar_enabled && vtd_as_pt_enabled(as);
> +    s = as->iommu_state;
> +    use_iommu = s->dmar_enabled && !vtd_as_pt_enabled(as);
> +    pt = s->dmar_enabled && vtd_as_pt_enabled(as);
> +
> +    /*
> +     * When guest enables scalable mode and sets up first stage page table,
> +     * we stick to system MR for IOMMUFD backed host device. Then its
> +     * default hwpt contains GPA->HPA mappings which is used directly if
> +     * PGTT=PT and used as nesting parent if PGTT=FST. Otherwise fall back
> +     * to original processing.
> +     */
> +    if (s->root_scalable && s->fsts && vtd_find_hiod_iommufd(as)) {
> +        use_iommu = false;
> +    }
>  
>      trace_vtd_switch_address_space(pci_bus_num(as->bus),
>                                     VTD_PCI_SLOT(as->devfn),
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index ead6c42879..ebfc503d64 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -50,3 +50,21 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                 "host IOMMU is incompatible with guest first stage translation");
>      return false;
>  }
> +
> +VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
> +{
> +    IntelIOMMUState *s = as->iommu_state;
> +    struct vtd_as_key key = {
> +        .bus = as->bus,
> +        .devfn = as->devfn,
> +    };
> +    VTDHostIOMMUDevice *vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev,
> +                                                       &key);
> +
> +    if (vtd_hiod && vtd_hiod->hiod &&
> +        object_dynamic_cast(OBJECT(vtd_hiod->hiod),
> +                            TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +        return vtd_hiod;
> +    }
> +    return NULL;
> +}


