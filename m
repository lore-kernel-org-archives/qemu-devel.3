Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748B1C54F30
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 02:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK6p6-00075W-4u; Tue, 27 May 2025 22:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6p5-00075C-Fh; Tue, 27 May 2025 22:47:19 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6p3-0004gY-JB; Tue, 27 May 2025 22:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748400438; x=1779936438;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=epegtVv1wXHVpEoir/mx7ccapCtlvZWMEdvhNfoo8WQ=;
 b=Js39Twt/EYjPDFFkLy4d64ymWhGQxyGgmBM2ppy68FO6wKnAQtW8XN+4
 PnUpj7DFROswKYIhHB6HaTTzVNm/3UxGVgNOTZdsU8x3qgO4furfjEdu0
 Zzk4VirpbGhAXrARIvwJdlILaYmcSg3+P4Tf3nh4Ms3vB637k/qym7MQD
 JsOgevqvn/z9lNw+Qpc4JTaj3gTa8jBo6/cT4THcifWX4Fw0vWe4jGIsb
 JnNDF7xm+uxHLHGrql+1C4xM0NIRm8eltdO/jR4TpWa1PDRoK3oe710uv
 Cta3c9e4Z53HaZNXcpiRVP88Hnpe0QQFpsqBSH6CHDpqMpUZ2NtU+8yWx A==;
X-CSE-ConnectionGUID: 4Xwk296tSBONc6h+nW/EEQ==
X-CSE-MsgGUID: keOHNqsNSUyRPIFYKh3Pag==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="72945094"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="72945094"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:47:16 -0700
X-CSE-ConnectionGUID: bRSyMk4QRT2N+pmsOkF3ow==
X-CSE-MsgGUID: jR5TfwcPRZ6T69mvPzp2ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="143422638"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:47:10 -0700
Message-ID: <30c8ba9a-4575-402d-80fe-15fcd9d24d0d@intel.com>
Date: Wed, 28 May 2025 10:47:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/19] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_OLD_PCI_CONFIGURATION definition
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
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-15-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
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
> PVSCSI_COMPAT_OLD_PCI_CONFIGURATION was only used by the
> hw_compat_2_5[] array, via the 'x-old-pci-configuration=on'
> property. We removed all machines using that array, lets remove
> all the code around PVSCSI_COMPAT_OLD_PCI_CONFIGURATION.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/scsi/vmw_pvscsi.c | 26 +++++++-------------------
>   1 file changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index d5825b67868..34de59a7cf6 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -69,17 +69,11 @@ OBJECT_DECLARE_TYPE(PVSCSIState, PVSCSIClass, PVSCSI)
>   
>   
>   /* Compatibility flags for migration */
> -#define PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT 0
> -#define PVSCSI_COMPAT_OLD_PCI_CONFIGURATION \
> -    (1 << PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT)
>   #define PVSCSI_COMPAT_DISABLE_PCIE_BIT 1
>   #define PVSCSI_COMPAT_DISABLE_PCIE \
>       (1 << PVSCSI_COMPAT_DISABLE_PCIE_BIT)
>   
> -#define PVSCSI_USE_OLD_PCI_CONFIGURATION(s) \
> -    ((s)->compat_flags & PVSCSI_COMPAT_OLD_PCI_CONFIGURATION)
> -#define PVSCSI_MSI_OFFSET(s) \
> -    (PVSCSI_USE_OLD_PCI_CONFIGURATION(s) ? 0x50 : 0x7c)
> +#define PVSCSI_MSI_OFFSET    (0x7c)
>   #define PVSCSI_EXP_EP_OFFSET (0x40)
>   
>   typedef struct PVSCSIRingInfo {
> @@ -1110,7 +1104,7 @@ pvscsi_init_msi(PVSCSIState *s)
>       int res;
>       PCIDevice *d = PCI_DEVICE(s);
>   
> -    res = msi_init(d, PVSCSI_MSI_OFFSET(s), PVSCSI_MSIX_NUM_VECTORS,
> +    res = msi_init(d, PVSCSI_MSI_OFFSET, PVSCSI_MSIX_NUM_VECTORS,
>                      PVSCSI_USE_64BIT, PVSCSI_PER_VECTOR_MASK, NULL);
>       if (res < 0) {
>           trace_pvscsi_init_msi_fail(res);
> @@ -1158,15 +1152,11 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
>       trace_pvscsi_state("init");
>   
>       /* PCI subsystem ID, subsystem vendor ID, revision */
> -    if (PVSCSI_USE_OLD_PCI_CONFIGURATION(s)) {
> -        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID, 0x1000);
> -    } else {
> -        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID,
> -                     PCI_VENDOR_ID_VMWARE);
> -        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID,
> -                     PCI_DEVICE_ID_VMWARE_PVSCSI);
> -        pci_config_set_revision(pci_dev->config, 0x2);
> -    }
> +    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID,
> +                 PCI_VENDOR_ID_VMWARE);
> +    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID,
> +                 PCI_DEVICE_ID_VMWARE_PVSCSI);
> +    pci_config_set_revision(pci_dev->config, 0x2);
>   
>       /* PCI latency timer = 255 */
>       pci_dev->config[PCI_LATENCY_TIMER] = 0xff;
> @@ -1298,8 +1288,6 @@ static const VMStateDescription vmstate_pvscsi = {
>   
>   static const Property pvscsi_properties[] = {
>       DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
> -    DEFINE_PROP_BIT("x-old-pci-configuration", PVSCSIState, compat_flags,
> -                    PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT, false),
>       DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
>                       PVSCSI_COMPAT_DISABLE_PCIE_BIT, false),
>   };


