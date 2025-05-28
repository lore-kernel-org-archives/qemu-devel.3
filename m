Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D9AC54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 02:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK6qn-0001L8-5Z; Tue, 27 May 2025 22:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6ql-0001Kd-OB; Tue, 27 May 2025 22:49:03 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6qk-0004kR-0e; Tue, 27 May 2025 22:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748400542; x=1779936542;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vCRmBI1/OM9T4WZ0Tj3q0GOlruyPsJsgf25xqRCm8C8=;
 b=k9cpm8Q2EnHgjofAIIS7xR5MtdKUtlHrf8XATRCNOi94CT6XmH/K/Gic
 aiBaCQ7de/bjkiTkukiDSRgPEPt9bIA6Ro7UQGAgJw59c16nL+/+a4rE4
 pCtddptw+cQHx+wnhUSGSRaLZKxgKy8dlwseDa2G3nG71KUPQ7ircvhma
 b+hw7o/MRnSRcGj2vTZX8WIgpslBM0tR2YkJNhPqNYHUPBWoYFybWBKSg
 qN9A23j7ujARMtV7AYOSs/3w79uic5Z/50b+dHWRVWhicwSORUs3QWeDn
 0lq9b7g4EzrmkPMuaasR390vtbcdNMmbNLww9zZXRbY0dMZz30gCfkC5K g==;
X-CSE-ConnectionGUID: LclRdHpqRIW8IyDTERXTfg==
X-CSE-MsgGUID: ZM7iUQdqS76JgwKQ2I5DLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67823695"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="67823695"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:49:00 -0700
X-CSE-ConnectionGUID: GHJltKoiTvivghewkVU0xg==
X-CSE-MsgGUID: HCl9+y9GQ/idb1Y0++dOUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="148112530"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:48:55 -0700
Message-ID: <b73a044a-2333-40e5-93e5-4373dbf75786@intel.com>
Date: Wed, 28 May 2025 10:48:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/19] hw/net/vmxnet3: Merge DeviceRealize in
 InstanceInit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-20-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/12/2025 4:39 PM, Philippe Mathieu-Daudé wrote:
> Simplify merging vmxnet3_realize() within vmxnet3_instance_init(),
> removing the need for device_class_set_parent_realize().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/net/vmxnet3.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index d080fe9b38a..7c0ca56b7c0 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -2238,6 +2238,7 @@ static void vmxnet3_instance_init(Object *obj)
>       device_add_bootindex_property(obj, &s->conf.bootindex,
>                                     "bootindex", "/ethernet-phy@0",
>                                     DEVICE(obj));
> +    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
>   }
>   
>   static void vmxnet3_pci_uninit(PCIDevice *pci_dev)
> @@ -2463,22 +2464,10 @@ static const Property vmxnet3_properties[] = {
>       DEFINE_NIC_PROPERTIES(VMXNET3State, conf),
>   };
>   
> -static void vmxnet3_realize(DeviceState *qdev, Error **errp)
> -{
> -    VMXNET3Class *vc = VMXNET3_DEVICE_GET_CLASS(qdev);
> -    PCIDevice *pci_dev = PCI_DEVICE(qdev);
> -    VMXNET3State *s = VMXNET3(qdev);
> -
> -    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> -
> -    vc->parent_dc_realize(qdev, errp);
> -}
> -
>   static void vmxnet3_class_init(ObjectClass *class, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(class);
>       PCIDeviceClass *c = PCI_DEVICE_CLASS(class);
> -    VMXNET3Class *vc = VMXNET3_DEVICE_CLASS(class);
>   
>       c->realize = vmxnet3_pci_realize;
>       c->exit = vmxnet3_pci_uninit;
> @@ -2489,8 +2478,6 @@ static void vmxnet3_class_init(ObjectClass *class, const void *data)
>       c->class_id = PCI_CLASS_NETWORK_ETHERNET;
>       c->subsystem_vendor_id = PCI_VENDOR_ID_VMWARE;
>       c->subsystem_id = PCI_DEVICE_ID_VMWARE_VMXNET3;
> -    device_class_set_parent_realize(dc, vmxnet3_realize,
> -                                    &vc->parent_dc_realize);
>       dc->desc = "VMWare Paravirtualized Ethernet v3";
>       device_class_set_legacy_reset(dc, vmxnet3_qdev_reset);
>       dc->vmsd = &vmstate_vmxnet3;


