Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3788DC54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 02:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK6qL-0000WU-B8; Tue, 27 May 2025 22:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6qJ-0000Rb-Jr; Tue, 27 May 2025 22:48:35 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6qD-0004iq-Al; Tue, 27 May 2025 22:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748400509; x=1779936509;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/mB2ul1Gqto+Xf/FSjpg/QPfENR6Vzj21K682X09bY4=;
 b=FfaluwcmBRkTbkAwg+Vx46ht2dpr0lkno1jxurcZM8vBs68xWpSuSuLV
 2vDbDIYOs/CxS5iJJxDdihI6nDLYSH/dln6kpOH5Oqh8gtyCX5FCs96jB
 jz/qqBsF9DoK1i3lJN/PLa83UalgMj74XTZxUgiQLRAOAPjQt62kuZCY/
 Tku16TUzIlQGTEqtF/Zmywka3Wq3WgUfjy3vlHRpUmiRZyuT3MGHnBboc
 dY0e/hnWvE0ZrDmFErHPZbh32QNCzzewIrh6sL7TtcTza+CYT9n4LGSAQ
 QWVAxNM03rWB+VIt4C0R/FfapTc7rGW7sjb+j9V6FhvIeqNyduHqjS2Rs A==;
X-CSE-ConnectionGUID: vVpADY2tS1ecNxJYPpNUAw==
X-CSE-MsgGUID: WekY11pfQimZ4/Hdxf2Iwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50469659"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="50469659"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:48:26 -0700
X-CSE-ConnectionGUID: ut1N558oQsmXdFGS4xfi0A==
X-CSE-MsgGUID: SIpGLZqcScyZr62FBVASFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="143700158"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:48:18 -0700
Message-ID: <3ac98968-81ce-4adf-ad85-0ba5cad852f4@intel.com>
Date: Wed, 28 May 2025 10:48:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/19] hw/net/vmxnet3: Remove
 VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definition
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
 <20250512083948.39294-18-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
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
> VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS was only used by the
> hw_compat_2_5[] array, via the 'x-old-msi-offsets=on' property.
> We removed all machines using that array, lets remove all the
> code around VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/net/vmxnet3.c | 20 ++++++--------------
>   1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 83d942af179..3cf5d71f478 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -42,18 +42,13 @@
>   #define VMXNET3_MSIX_BAR_SIZE 0x2000
>   
>   /* Compatibility flags for migration */
> -#define VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS_BIT 0
> -#define VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS \
> -    (1 << VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS_BIT)
>   #define VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT 1
>   #define VMXNET3_COMPAT_FLAG_DISABLE_PCIE \
>       (1 << VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT)
>   
>   #define VMXNET3_EXP_EP_OFFSET (0x48)
> -#define VMXNET3_MSI_OFFSET(s) \
> -    ((s)->compat_flags & VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS ? 0x50 : 0x84)
> -#define VMXNET3_MSIX_OFFSET(s) \
> -    ((s)->compat_flags & VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS ? 0 : 0x9c)
> +#define VMXNET3_MSI_OFFSET    (0x84)
> +#define VMXNET3_MSIX_OFFSET   (0x9c)
>   #define VMXNET3_DSN_OFFSET     (0x100)
>   
>   #define VMXNET3_BAR0_IDX      (0)
> @@ -61,8 +56,7 @@
>   #define VMXNET3_MSIX_BAR_IDX  (2)
>   
>   #define VMXNET3_OFF_MSIX_TABLE (0x000)
> -#define VMXNET3_OFF_MSIX_PBA(s) \
> -    ((s)->compat_flags & VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS ? 0x800 : 0x1000)
> +#define VMXNET3_OFF_MSIX_PBA   (0x1000)
>   
>   /* Link speed in Mbps should be shifted by 16 */
>   #define VMXNET3_LINK_SPEED      (1000 << 16)
> @@ -2122,8 +2116,8 @@ vmxnet3_init_msix(VMXNET3State *s)
>                           &s->msix_bar,
>                           VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_TABLE,
>                           &s->msix_bar,
> -                        VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_PBA(s),
> -                        VMXNET3_MSIX_OFFSET(s), NULL);
> +                        VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_PBA,
> +                        VMXNET3_MSIX_OFFSET, NULL);
>   
>       if (0 > res) {
>           VMW_WRPRN("Failed to initialize MSI-X, error %d", res);
> @@ -2221,7 +2215,7 @@ static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
>       /* Interrupt pin A */
>       pci_dev->config[PCI_INTERRUPT_PIN] = 0x01;
>   
> -    ret = msi_init(pci_dev, VMXNET3_MSI_OFFSET(s), VMXNET3_MAX_NMSIX_INTRS,
> +    ret = msi_init(pci_dev, VMXNET3_MSI_OFFSET, VMXNET3_MAX_NMSIX_INTRS,
>                      VMXNET3_USE_64BIT, VMXNET3_PER_VECTOR_MASK, NULL);
>       /* Any error other than -ENOTSUP(board's MSI support is broken)
>        * is a programming error. Fall back to INTx silently on -ENOTSUP */
> @@ -2472,8 +2466,6 @@ static const VMStateDescription vmstate_vmxnet3 = {
>   
>   static const Property vmxnet3_properties[] = {
>       DEFINE_NIC_PROPERTIES(VMXNET3State, conf),
> -    DEFINE_PROP_BIT("x-old-msi-offsets", VMXNET3State, compat_flags,
> -                    VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS_BIT, false),
>       DEFINE_PROP_BIT("x-disable-pcie", VMXNET3State, compat_flags,
>                       VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT, false),
>   };


