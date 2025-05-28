Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72B4C54F30
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 02:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK6pT-00080P-9J; Tue, 27 May 2025 22:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6pQ-0007yk-FG; Tue, 27 May 2025 22:47:40 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6pO-0004hC-ND; Tue, 27 May 2025 22:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748400459; x=1779936459;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bQBbm1xvTKP1sB0RAGArzmT+6/4UWfJArFTaUv1UOkE=;
 b=Ip6GMkr00/ywQRcUaSbPISshfjDBVe6wp5WPJpLBou2i4X0aijTxVqdX
 MH4UIv73rFTOxd/ZuQQzCoTktP2Oea1a/PKKw2MGtMZynNTHnaMsPzcyG
 TZu7Z+U63RFgG4E26NpU7M0wv3Dc89aZUrO/nRS4adGVS2djW/vh4eWio
 Ksueu02Kt0KV4i3NzASOUMaTpVT9zQHnR13RPofvs2YpfllaQUXWXHBsF
 lFrc6Eu30dPZxNFtswJvrf+TFaays5EaLg3CAOmj50N8ERmQUsLlvCGkK
 4dhwVMXfLnu6/5C+UBbCP0Ofz0opDT5AUILuN9C+sWW6AeuA9dlLPJvtE A==;
X-CSE-ConnectionGUID: xIz6V0ebSuu9b4gtNExqzg==
X-CSE-MsgGUID: y9c+mn4PSrmhBepsXymjcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="54218597"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="54218597"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:47:37 -0700
X-CSE-ConnectionGUID: lhZAjDejT9KW/H/itvGP2A==
X-CSE-MsgGUID: ypBtRh4GRmuHHvdVAcH+1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="147943581"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:47:30 -0700
Message-ID: <0ac27033-abfe-422c-b0cb-0fae16950795@intel.com>
Date: Wed, 28 May 2025 10:47:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/19] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
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
 <20250512083948.39294-16-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
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
> PVSCSI_COMPAT_DISABLE_PCIE_BIT was only used by the
> hw_compat_2_5[] array, via the 'x-disable-pcie=on' property.
> We removed all machines using that array, lets remove all the
> code around PVSCSI_COMPAT_DISABLE_PCIE_BIT, including the now
> unused PVSCSIState::compat_flags field.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/scsi/vmw_pvscsi.c | 30 +-----------------------------
>   1 file changed, 1 insertion(+), 29 deletions(-)
> 
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 34de59a7cf6..e163023d14c 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -68,11 +68,6 @@ struct PVSCSIClass {
>   OBJECT_DECLARE_TYPE(PVSCSIState, PVSCSIClass, PVSCSI)
>   
>   
> -/* Compatibility flags for migration */
> -#define PVSCSI_COMPAT_DISABLE_PCIE_BIT 1
> -#define PVSCSI_COMPAT_DISABLE_PCIE \
> -    (1 << PVSCSI_COMPAT_DISABLE_PCIE_BIT)
> -
>   #define PVSCSI_MSI_OFFSET    (0x7c)
>   #define PVSCSI_EXP_EP_OFFSET (0x40)
>   
> @@ -123,8 +118,6 @@ struct PVSCSIState {
>       uint8_t msi_used;                    /* For migration compatibility      */
>       PVSCSIRingInfo rings;                /* Data transfer rings manager      */
>       uint32_t resetting;                  /* Reset in progress                */
> -
> -    uint32_t compat_flags;
>   };
>   
>   typedef struct PVSCSIRequest {
> @@ -1224,21 +1217,8 @@ pvscsi_post_load(void *opaque, int version_id)
>       return 0;
>   }
>   
> -static bool pvscsi_vmstate_need_pcie_device(void *opaque)
> -{
> -    PVSCSIState *s = PVSCSI(opaque);
> -
> -    return !(s->compat_flags & PVSCSI_COMPAT_DISABLE_PCIE);
> -}
> -
> -static bool pvscsi_vmstate_test_pci_device(void *opaque, int version_id)
> -{
> -    return !pvscsi_vmstate_need_pcie_device(opaque);
> -}
> -
>   static const VMStateDescription vmstate_pvscsi_pcie_device = {
>       .name = "pvscsi/pcie",
> -    .needed = pvscsi_vmstate_need_pcie_device,
>       .fields = (const VMStateField[]) {
>           VMSTATE_PCI_DEVICE(parent_obj, PVSCSIState),
>           VMSTATE_END_OF_LIST()
> @@ -1252,9 +1232,6 @@ static const VMStateDescription vmstate_pvscsi = {
>       .pre_save = pvscsi_pre_save,
>       .post_load = pvscsi_post_load,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_STRUCT_TEST(parent_obj, PVSCSIState,
> -                            pvscsi_vmstate_test_pci_device, 0,
> -                            vmstate_pci_device, PCIDevice),
>           VMSTATE_UINT8(msi_used, PVSCSIState),
>           VMSTATE_UINT32(resetting, PVSCSIState),
>           VMSTATE_UINT64(reg_interrupt_status, PVSCSIState),
> @@ -1288,19 +1265,14 @@ static const VMStateDescription vmstate_pvscsi = {
>   
>   static const Property pvscsi_properties[] = {
>       DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
> -    DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
> -                    PVSCSI_COMPAT_DISABLE_PCIE_BIT, false),
>   };
>   
>   static void pvscsi_realize(DeviceState *qdev, Error **errp)
>   {
>       PVSCSIClass *pvs_c = PVSCSI_GET_CLASS(qdev);
>       PCIDevice *pci_dev = PCI_DEVICE(qdev);
> -    PVSCSIState *s = PVSCSI(qdev);
>   
> -    if (!(s->compat_flags & PVSCSI_COMPAT_DISABLE_PCIE)) {
> -        pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> -    }
> +    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
>   
>       pvs_c->parent_dc_realize(qdev, errp);
>   }


