Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B553C54F30
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 02:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK6qV-0000mp-7E; Tue, 27 May 2025 22:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6qT-0000jT-0l; Tue, 27 May 2025 22:48:45 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6qR-0004jQ-DC; Tue, 27 May 2025 22:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748400524; x=1779936524;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=T1egsXdwQ6eEc6+AHhmbvzrCF13DU/0nFK70B7lPMCg=;
 b=llVkv+uQ0X12udRcP6Kkg6W9HCF96Ntj23acrKgCGsksV4ctWqbr8JGb
 C1uETU6eu+BOLnYSEZliZEpF1U0Hv+0zS1YBc3Vs+Mz8acRhgehqSVz6p
 la4IC2UJ+Kz8RbtBip+Nv0fDuTPe4wsqXKgieho12Em/Vovr4KKjXuyDD
 1N3eQx5+/+2PzmJn8ubv8mA0ZMLGq3a1VyHZSUUSb8xSgDEWIluP8ACr6
 H2ZFDVsHU5RKxBCkqT9QNqRi1OJRvCEs150j9AgvylDzgvxuMZcdwkuqb
 ha6rtzc8FmhHQ2wrnb0Un2TzQamSrhL3EEk9og3q+ETvBkQAU74bDIZrL g==;
X-CSE-ConnectionGUID: 6I+CI1YARrmUrE3pwKYbtA==
X-CSE-MsgGUID: ar6n2Z9lSjCFyqWFzI07UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67823651"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="67823651"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:48:42 -0700
X-CSE-ConnectionGUID: ixTncbOUSFKTd8zN7h2DBw==
X-CSE-MsgGUID: sWyW7EIlR2iM1gCrTrGrYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="148112486"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:48:37 -0700
Message-ID: <d9cce88e-b293-43b0-b3f7-1760d845275b@intel.com>
Date: Wed, 28 May 2025 10:48:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/19] hw/net/vmxnet3: Remove
 VMXNET3_COMPAT_FLAG_DISABLE_PCIE definition
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
 <20250512083948.39294-19-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-19-philmd@linaro.org>
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
> VMXNET3_COMPAT_FLAG_DISABLE_PCIE was only used by the
> hw_compat_2_5[] array, via the 'x-disable-pcie=on' property.
> We removed all machines using that array, lets remove all the
> code around VMXNET3_COMPAT_FLAG_DISABLE_PCIE.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/net/vmxnet3.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 3cf5d71f478..d080fe9b38a 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -41,11 +41,6 @@
>   #define PCI_DEVICE_ID_VMWARE_VMXNET3_REVISION 0x1
>   #define VMXNET3_MSIX_BAR_SIZE 0x2000
>   
> -/* Compatibility flags for migration */
> -#define VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT 1
> -#define VMXNET3_COMPAT_FLAG_DISABLE_PCIE \
> -    (1 << VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT)
> -
>   #define VMXNET3_EXP_EP_OFFSET (0x48)
>   #define VMXNET3_MSI_OFFSET    (0x84)
>   #define VMXNET3_MSIX_OFFSET   (0x9c)
> @@ -2466,8 +2461,6 @@ static const VMStateDescription vmstate_vmxnet3 = {
>   
>   static const Property vmxnet3_properties[] = {
>       DEFINE_NIC_PROPERTIES(VMXNET3State, conf),
> -    DEFINE_PROP_BIT("x-disable-pcie", VMXNET3State, compat_flags,
> -                    VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT, false),
>   };
>   
>   static void vmxnet3_realize(DeviceState *qdev, Error **errp)
> @@ -2476,9 +2469,7 @@ static void vmxnet3_realize(DeviceState *qdev, Error **errp)
>       PCIDevice *pci_dev = PCI_DEVICE(qdev);
>       VMXNET3State *s = VMXNET3(qdev);
>   
> -    if (!(s->compat_flags & VMXNET3_COMPAT_FLAG_DISABLE_PCIE)) {
> -        pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> -    }
> +    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
>   
>       vc->parent_dc_realize(qdev, errp);
>   }


