Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F9EC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 09:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR71R-0000rJ-EL; Tue, 09 Jul 2024 05:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sR71Q-0000qN-Ih
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sR71N-0002JQ-PL
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720516822;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SKXAddY1zFdk25Bwax5d0DzWqhh4H+kxz4lMg+F01LQ=;
 b=bsnWkgX3wAos8Jb4VJJ/OXO4cykfWJ3ch2f6d1UNUMwOY60MZ/h5jGC/9nnvICxIuCJKGq
 EpydJozdI4pMfeX9wewtpT61WYt7pXLXNOLtpfZ4RahOX8oVI10mEn37Ec528wjuYOmTkF
 zwtN98BFlhh04jZbdqGA6qnfuNjqnW4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-ziLNdZdpP6mYDQYG0DewYg-1; Tue, 09 Jul 2024 05:20:21 -0400
X-MC-Unique: ziLNdZdpP6mYDQYG0DewYg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-447f7dfa343so16035161cf.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 02:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720516821; x=1721121621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SKXAddY1zFdk25Bwax5d0DzWqhh4H+kxz4lMg+F01LQ=;
 b=fqkFG4EbLr22IBke9RCWcwD0/EAqPJx5v4CzBQd6i5L9G+MQ9sHQUJEm3zzWLbX/ol
 tvjGDJrSWRnzhU6iDGcWD1d4ypJ6QEbMPk7R05Vv5J6PeBZeiSExMhTGKZySUoV1L6X4
 urmmFJO6L5igPOInK/+POqqq1dXjbuW9XXgmKYQ+ZOAhIL/xPu2X/639xMQ6FKHLRDn+
 DjeVGtYeH+O/wVl3nCV+ns67COG/TJ+fflLVQ5slDG5gE5PIqoAsknaSyYLmND0obrZe
 M/rovImJsHHkLxS/2vHAsar164yiQ/zkEEO+RaZQ8Da92TIufaTkJZxCXWu3htmWTHGa
 prdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxHldl+M/6M8BhLyjLjLpS0guIlZXtXjJ2BC1QzxQmxLGZ+k6TN9+VYNuOpFUG3uIUJ851UvXad9NeFd5B3Uo1T26VPxE=
X-Gm-Message-State: AOJu0Yzf93PgeTcPi+vN8jsL+3onSxrOciBAiQvu81B61GgsVRUpfOc/
 wpoPwtUzM5Nxxw8rQ7AsCceDqw8no1zH382s4U6C73uQWltoBSeK4HsHPIX4eomDblnOkB3gpot
 72XKdjze3OBKYPQtbqQEyiaGhoijsBxmYqHKzKUSbxylmywxGQ9zm
X-Received: by 2002:ac8:7c53:0:b0:447:d87e:7873 with SMTP id
 d75a77b69052e-447faa7bab3mr17429161cf.64.1720516821162; 
 Tue, 09 Jul 2024 02:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETXmMHiYbMEQxwYW3YS81zT24ODTS1AubCdM72qn5t+gq458ot6gxo0UsoPktNVYkFBu2T1Q==
X-Received: by 2002:ac8:7c53:0:b0:447:d87e:7873 with SMTP id
 d75a77b69052e-447faa7bab3mr17429001cf.64.1720516820844; 
 Tue, 09 Jul 2024 02:20:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-447f9b52a4dsm8476761cf.50.2024.07.09.02.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 02:20:20 -0700 (PDT)
Message-ID: <3d151591-4cc6-4de4-8055-27d6fb7200df@redhat.com>
Date: Tue, 9 Jul 2024 11:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1 03/10] hw/arm/virt: Get the number of host-level
 SMMUv3 instances
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, peterx@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jgg@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, jasowang@redhat.com
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <886883c4cb43117ef26e6c9434247b75cd827f31.1719361174.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <886883c4cb43117ef26e6c9434247b75cd827f31.1719361174.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nicolin,

On 6/26/24 02:28, Nicolin Chen wrote:
> Nested SMMUv3 feature requires the support/presence of host-level SMMUv3
> instance(s). Add a helper to read the sysfs for the number of instances.
> Log them in a vms list using a new struct VirtNestedSmmu.
>
> This will be used by a following patch to assign a passthrough device to
> corresponding nested SMMUv3 instance.
Laterly the HostIOMMUDevice has been introduced to allow, among other
things, to pass information related to the physical IOMMU to the virtual
IOMMU.
I guess it would be well fitted to associate the viommu with its
underlying piommu.

I don't think we have such kind of host introspection in machine type.
Generally in can happen in the very device or in libvirt.

Thanks

Eric
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  hw/arm/virt.c         | 35 +++++++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h |  8 ++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 71093d7c60..be3d8b0ce6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2668,6 +2668,37 @@ static char *virt_get_iommu(Object *obj, Error **errp)
>      }
>  }
>  
> +static int virt_get_num_nested_smmus(VirtMachineState *vms, Error **errp)
> +{
> +    VirtNestedSmmu *nested_smmu;
> +    struct dirent *dent;
> +    DIR *dir = NULL;
> +    int num = 0;
> +
> +    dir = opendir("/sys/class/iommu");
> +    if (!dir) {
> +        error_setg_errno(errp, errno, "couldn't open /sys/class/iommu");
> +        return 0;
> +    }
> +
> +    while ((dent = readdir(dir))) {
> +        if (!strncmp(dent->d_name, "smmu3.0x", 7)) {
> +            nested_smmu = g_new0(VirtNestedSmmu, 1);
> +            nested_smmu->index = num;
> +            nested_smmu->smmu_node = g_strdup(dent->d_name);
> +            QLIST_INSERT_HEAD(&vms->nested_smmu_list, nested_smmu, next);
> +            num++;
> +        }
> +    }
> +
> +    if (num == 0) {
> +        error_setg_errno(errp, errno,
> +                         "couldn't find any SMMUv3 HW to setup nesting");
> +    }
> +
> +    return num;
> +}
> +
>  static void virt_set_iommu(Object *obj, const char *value, Error **errp)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(obj);
> @@ -2676,6 +2707,7 @@ static void virt_set_iommu(Object *obj, const char *value, Error **errp)
>          vms->iommu = VIRT_IOMMU_SMMUV3;
>      } else if (!strcmp(value, "nested-smmuv3")) {
>          vms->iommu = VIRT_IOMMU_NESTED_SMMUV3;
> +        vms->num_nested_smmus = virt_get_num_nested_smmus(vms, errp);
>      } else if (!strcmp(value, "none")) {
>          vms->iommu = VIRT_IOMMU_NONE;
>      } else {
> @@ -3232,6 +3264,9 @@ static void virt_instance_init(Object *obj)
>      /* The default root bus is attached to iommu by default */
>      vms->default_bus_bypass_iommu = false;
>  
> +    /* Default disallows nested SMMU instantiation */
> +    vms->num_nested_smmus = 0;
> +
>      /* Default disallows RAS instantiation */
>      vms->ras = false;
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index d5cbce1a30..e0c07527c4 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -135,6 +135,12 @@ struct VirtMachineClass {
>      bool no_ns_el2_virt_timer_irq;
>  };
>  
> +typedef struct VirtNestedSmmu {
> +    int index;
> +    char *smmu_node;
> +    QLIST_ENTRY(VirtNestedSmmu) next;
> +} VirtNestedSmmu;
> +
>  struct VirtMachineState {
>      MachineState parent;
>      Notifier machine_done;
> @@ -153,6 +159,7 @@ struct VirtMachineState {
>      bool ras;
>      bool mte;
>      bool dtb_randomness;
> +    int num_nested_smmus;
>      OnOffAuto acpi;
>      VirtGICType gic_version;
>      IOMMUFDBackend *iommufd;
> @@ -178,6 +185,7 @@ struct VirtMachineState {
>      char *oem_id;
>      char *oem_table_id;
>      bool ns_el2_virt_timer_irq;
> +    QLIST_HEAD(, VirtNestedSmmu) nested_smmu_list;
>  };
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)


