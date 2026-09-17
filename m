Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00553C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7IsY-0008Db-P4; Thu, 17 Sep 2026 16:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x7Iry-00086G-0G; Thu, 17 Sep 2026 16:38:14 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x7Irw-0004fl-1P; Thu, 17 Sep 2026 16:38:09 -0400
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68HKbn3t080372
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 18 Sep 2026 05:37:49 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Taqz4flZp0Peh2SX8Gzch1nIADiuVBBscexoGCqN/24=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1789677469; v=1;
 b=mVXLjd+qJDEYjVHQ55yWY0GeCn0OHe5XVLn3Y/0nFaTLxvv4W/oHKWsXuTp5kfsa
 cv9Xsq/PQKi0Tly5NoUBE4b94WC5HHJB07ZTYuWAsB3CJMpmEdrEluUC3A8rGYFX
 V2LcIQltIpjLIZUgY6iK6Av6kVHhFWVGSl0Z3DT2uXV3kfQe+SEX5CQRnD6yzRRg
 4UoH4bgyL/xJfXaIkiFdlwWjzE6dZrtIQnwLGBScCzpjJMI6VQBlUhX1+gSxYMHh
 fRa/Yfcix7L0O9bt6XQkTPDFnTk9k9PAmyDHhfhSjqPgVMj1Tj+CYughQb+3RQl9
 eoG/6CkWWRxkSRtpUSJQyw==
Message-ID: <ac3c2746-cc1f-4429-8d1e-1aa9809954c4@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 18 Sep 2026 05:37:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 10/10] hw/vmapple: virtio-blk: allow FileVault off
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
 <20260916100021.73825-11-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260916100021.73825-11-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/09/16 19:00, Mohamed Mediouni wrote:
> Otherwise, a newer macOS version with FileVault
> disabled in the guest does not boot.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/vmapple/virtio-blk.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
> index 9de9aaae0b..906c2b2ec8 100644
> --- a/hw/vmapple/virtio-blk.c
> +++ b/hw/vmapple/virtio-blk.c
> @@ -119,12 +119,17 @@ static const Property vmapple_virtio_blk_pci_properties[] = {
>                                              VM_APPLE_VIRTIO_BLK_VARIANT_UNSPECIFIED),
>   };
>   
> +#define VMAPPLE_PCI_VNDR_SIZE 14
> +/* Disable requirement for FileVault to be enabled on the guest */
> +#define VMAPPLE_PCI_VNDR_LEGACY_FEATURES_DISABLE_ENCRYPTION (1 << 0)
> +
>   static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>   {
>       ERRP_GUARD();
>       VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(vpci_dev);
>       DeviceState *vdev = DEVICE(&dev->vdev);
>       VirtIOBlkConf *conf = &dev->vdev.parent_obj.conf;
> +    int offset;
>   
>       if (dev->variant == VM_APPLE_VIRTIO_BLK_VARIANT_UNSPECIFIED) {
>           error_setg(errp, "vmapple virtio block device variant unspecified");
> @@ -162,6 +167,19 @@ static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err
>       pci_config_set_vendor_id(vpci_dev->pci_dev.config, PCI_VENDOR_ID_APPLE);
>       pci_config_set_device_id(vpci_dev->pci_dev.config,
>                                PCI_DEVICE_ID_APPLE_VIRTIO_BLK);
> +
> +    offset = pci_add_capability(&vpci_dev->pci_dev, PCI_CAP_ID_VNDR, 0,
> +                                    VMAPPLE_PCI_VNDR_SIZE, errp);

This exhausts conventional PCI capability space behind a PCIe root port 
with modern-pio-notify=on and MSI-X enabled. Existing capabilities 
consume 188 of 192 bytes; adding 14 calls pci_find_space(), which 
returns zero and triggers assert(offset). The negative-result check 
cannot handle this. Default root-bus placement fits.

Regards,
Akihiko Odaki

> +    if (offset < 0) {
> +        return;
> +    }
> +
> +    pci_set_byte(vpci_dev->pci_dev.config + offset + 2,
> +        VMAPPLE_PCI_VNDR_SIZE);
> +    pci_set_byte(vpci_dev->pci_dev.config + offset + 3, 9);
> +    pci_set_word(vpci_dev->pci_dev.config + offset + 4, PCI_VENDOR_ID_APPLE);
> +    pci_set_byte(vpci_dev->pci_dev.config + offset + 6,
> +        VMAPPLE_PCI_VNDR_LEGACY_FEATURES_DISABLE_ENCRYPTION);
>   }
>   
>   static void vmapple_virtio_blk_pci_class_init(ObjectClass *klass,


