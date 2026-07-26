Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C6AC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 15:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo19k-0005Fv-3C; Sun, 26 Jul 2026 11:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wo19c-0005FO-Fh; Sun, 26 Jul 2026 11:52:41 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wo19Z-00068S-Uz; Sun, 26 Jul 2026 11:52:40 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwDn7ho7LWZqVfrfAQ--.17943S2; 
 Sun, 26 Jul 2026 23:52:27 +0800 (CST)
Received: from [198.18.0.1] (unknown [113.246.117.150])
 by mail (Coremail) with SMTP id AQAAf8DwwXM6LWZqGCccAA--.45248S2;
 Sun, 26 Jul 2026 23:52:27 +0800 (CST)
Message-ID: <fbc0bd8c-1aaa-4193-8e56-89388eb83a55@phytium.com.cn>
Date: Sun, 26 Jul 2026 23:52:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/misc/iommu-testdev: support PCI MSI test writes
To: flavien.solt97@gmail.com, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>
References: <CANVUYGtOgMnNRkfU=zs=jvtg7yKOHXZVb8k5oVnp+D2=U4xeWA@mail.gmail.com>
 <CANVUYGtm19xCpqACSv2FYb7=BP05Av9oOxU5q-WiP4D-T6fA0w@mail.gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <CANVUYGtm19xCpqACSv2FYb7=BP05Av9oOxU5q-WiP4D-T6fA0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwwXM6LWZqGCccAA--.45248S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWpiankYLgAEsr
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJw4fXFy3Gry8tF43WF1UAwb_yoWrtr1fp3
 4DGF1YyF4FyrsxJr4Ska1IkF1UXrZ5JFya9w18Ar4rZ3yayayDJFy7KFy2yryUJ397ZF1x
 Zw4j9ry5WanavFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Flavien,

On 7/26/2026 8:21 PM, flavien.solt97@gmail.com wrote:
> iommu-testdev writes ITD_DMA_WRITE_VAL with unspecified requester
> attributes. RISC-V MSI remapping tests need to select an interrupt
> identity in the payload. The MSI trap also identifies the device through
> MemTxAttrs.requester_id.
>
> Add a write-value register with the existing constant as its reset
> default. Populate the requester ID from the PCI function. Existing
> translation tests retain their payload while interrupt-remapping tests
> can issue a valid MSI for the test device.
>
> Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
> ---
>   hw/misc/iommu-testdev.c         | 14 ++++++++++++--
>   include/hw/misc/iommu-testdev.h |  1 +
>   2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/hw/misc/iommu-testdev.c b/hw/misc/iommu-testdev.c
> index 15eb6de..6428a57 100644
> --- a/hw/misc/iommu-testdev.c
> +++ b/hw/misc/iommu-testdev.c
> @@ -28,6 +28,7 @@ struct IOMMUTestDevState {
>       uint64_t dma_paddr;
>       uint32_t dma_len;
>       uint32_t dma_result;
> +    uint32_t dma_write_val;
>       bool dma_armed; /* armed until a trigger consumes the request */
>
>       AddressSpace *dma_as;   /* IOMMU-mediated DMA AS for this device */
> @@ -80,6 +81,7 @@ static void iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
>
>       /* Initialize MemTxAttrs from generic register. */
>       attrs.secure = ITD_ATTRS_GET_SECURE(s->dma_attrs_cfg);
> +    attrs.requester_id = pci_requester_id(&s->parent_obj);
>
>       space_valid = ITD_ATTRS_GET_SPACE_VALID(s->dma_attrs_cfg);
>       if (space_valid) {
> @@ -97,12 +99,12 @@ static void
> iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)


hard-wrapped # 1


>
>       as = s->dma_as;
>
> -    /* Step 1: Write ITD_DMA_WRITE_VAL to DMA address */
> +    /* Step 1: Write the configured test value to DMA address */
>       trace_iommu_testdev_dma_write(s->dma_vaddr, s->dma_len);
>
>       for (int i = 0; i < s->dma_len; i++) {
>           /* Data is written in little-endian order */
> -        write_buf[i] = (ITD_DMA_WRITE_VAL >> ((i % 4) * 8)) & 0xff;
> +        write_buf[i] = (s->dma_write_val >> ((i % 4) * 8)) & 0xff;
>       }
>       write_res = dma_memory_write(as, s->dma_vaddr, write_buf,
>                                    s->dma_len, attrs);
> @@ -186,6 +188,9 @@ static uint64_t iommu_testdev_mmio_read(void
> *opaque, hwaddr addr,


hard-wrapped # 2


>       case ITD_REG_DMA_ATTRS:
>           value = s->dma_attrs_cfg;
>           break;
> +    case ITD_REG_DMA_WRITE_VAL:
> +        value = s->dma_write_val;
> +        break;
>       default:
>           value = 0;
>           break;
> @@ -240,6 +245,9 @@ static void iommu_testdev_mmio_write(void *opaque,
> hwaddr addr, uint64_t val,


hard-wrapped # 3


>       case ITD_REG_DMA_ATTRS:
>           s->dma_attrs_cfg = data;
>           break;
> +    case ITD_REG_DMA_WRITE_VAL:
> +        s->dma_write_val = data;
> +        break;
>       default:
>           break;
>       }
> @@ -263,6 +271,7 @@ static void iommu_testdev_realize(PCIDevice *pdev,
> Error **errp)


hard-wrapped # 4


I found four hard-wrapped hunk headers. As a result, git cannot parse 
the diff:

```

git am 0001-hw-misc-iommu-testdev-support-pci-msi-test-writes.patch
Applying: hw/misc/iommu-testdev: support PCI MSI test writes
error: corrupt patch at line 27
Patch failed at 0001 hw/misc/iommu-testdev: support PCI MSI test writes
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

```


Could you please help check this?


Otherwise, looks good.

Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>


>       s->dma_paddr = 0;
>       s->dma_len = 0;
>       s->dma_result = ITD_DMA_RESULT_IDLE;
> +    s->dma_write_val = ITD_DMA_WRITE_VAL;
>       s->dma_armed = false;
>       s->dma_attrs_cfg = ITD_ATTRS_SET_SPACE(0, ITD_ATTRS_SPACE_NONSECURE);
>       s->dma_as = pci_device_iommu_address_space(pdev);
> @@ -280,6 +289,7 @@ static void iommu_testdev_reset(DeviceState *dev)
>       s->dma_paddr = 0;
>       s->dma_len = 0;
>       s->dma_result = ITD_DMA_RESULT_IDLE;
> +    s->dma_write_val = ITD_DMA_WRITE_VAL;
>       s->dma_armed = false;
>       s->dma_attrs_cfg = ITD_ATTRS_SET_SPACE(0, ITD_ATTRS_SPACE_NONSECURE);
>   }
> diff --git a/include/hw/misc/iommu-testdev.h b/include/hw/misc/iommu-testdev.h
> index 3383659..2f4e931 100644
> --- a/include/hw/misc/iommu-testdev.h
> +++ b/include/hw/misc/iommu-testdev.h
> @@ -81,6 +81,7 @@ enum {
>       ITD_REG_DMA_ATTRS       = 0x18,
>       ITD_REG_DMA_GPA_LO      = 0x1c,
>       ITD_REG_DMA_GPA_HI      = 0x20,
> +    ITD_REG_DMA_WRITE_VAL   = 0x24,
>       BAR0_SIZE               = 0x1000,
>   };
>


