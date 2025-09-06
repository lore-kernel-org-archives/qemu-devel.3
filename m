Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C243ACA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 04:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uukNd-0004LB-Qh; Sat, 06 Sep 2025 00:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uukNa-0004K4-Fn
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 00:18:22 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uukNS-0000zJ-16
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 00:18:22 -0400
Received: from [10.40.4.92] (93-51-222-138.ip268.fastwebnet.it [93.51.222.138])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5864Hsjh090390
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 6 Sep 2025 13:17:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=XKCX0j1iFkQYjBwV+ZR4BOVq49wzZt3e0xKi4q1UhfI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1757132278; v=1;
 b=eIQAnWdwhB6ietaHlgprgKBlpt6NUlyZIFyzQr4Pt0JvD/L+5lRCBx2ERUXcmE93
 8yDNlKoMndBGPEXiEeLVuoPxZBZLPT+H3q9A3clzmMGVQPwySYy2sKoQbd0EzINS
 5pXCEKIVcE2Gsiizs0XgI9ej32PZuCyXFmcn599ecQOClLN+tkulJxstTKSZ+QFN
 vbJOJ7g75QNQkAKtlnS8lramBV3ya7SpnkDN9VrS052dd5qldCzyG3IX3y2LdhAU
 Q7dqhkcsr9bZXOprywxIhBGEjHelMtSuRVBVDIdgioSTxPuveaWmMrOyslf1tzqG
 bUWbsq16Pv6Rz9zniARbYQ==
Message-ID: <48689d16-1f88-4a56-8b48-b20923f92f2c@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 6 Sep 2025 06:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 6/6] virtio-gpu: Find the host addr given gpa associated
 with a ram device
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
 <20250903054438.1179384-7-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250903054438.1179384-7-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/09/03 7:42, Vivek Kasireddy wrote:
> If the Guest provides a gpa (guest physical address) associated with
> a PCI region, then we can obtain the hva (host virtual address) via
> gpa2hva() API instead of dma_memory_map(). Note that we would still
> call dma_memory_unmap() (to unref mr) regardless of how we obtained
> the hva.

I think address_space_translate() should be used instead. The guest 
passes addresses that are valid in the DMA address space, which may not 
be a GPA if an IOMMU is in effect. address_space_translate() allows you 
specifying the DMA address space.

The motivation for this change should also be described in the patch 
message; otherwise a reader may wonder why dma_memory_map() does not 
suffice.

While I added comments for each patch, the overall implementation 
direction of this series looks good to me.

Regards,
Akihiko Odaki

> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/virtio-gpu.c | 35 ++++++++++++++++++++++++++++++++---
>   1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 1654a417b8..4af8390bb5 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -32,6 +32,7 @@
>   #include "qemu/module.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> +#include "monitor/monitor.h"
>   
>   #define VIRTIO_GPU_VM_VERSION 1
>   
> @@ -799,6 +800,36 @@ static void virtio_gpu_set_scanout_blob(VirtIOGPU *g,
>                                 &fb, res, &ss.r, &cmd->error);
>   }
>   
> +static void *map_gpa2hva(VirtIOGPU *g,
> +                         struct virtio_gpu_ctrl_command *cmd,
> +                         uint64_t gpa, hwaddr *len)
> +{
> +    MemoryRegion *mr = NULL;
> +    Error *errp = NULL;
> +    void *map;
> +
> +    if (cmd->cmd_hdr.type != VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB) {
> +        return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, gpa, len,
> +                              DMA_DIRECTION_TO_DEVICE,
> +                              MEMTXATTRS_UNSPECIFIED);
> +    }
> +
> +    map = gpa2hva(&mr, gpa, 1, &errp);
> +    if (errp) {
> +        error_report_err(errp);
> +        return NULL;
> +    }
> +
> +    if (!memory_region_is_ram_device(mr)) {
> +        memory_region_unref(mr);
> +        map = dma_memory_map(VIRTIO_DEVICE(g)->dma_as, gpa, len,
> +                             DMA_DIRECTION_TO_DEVICE,
> +                             MEMTXATTRS_UNSPECIFIED);
> +    }
> +
> +    return map;
> +}
> +
>   int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>                                     uint32_t nr_entries, uint32_t offset,
>                                     struct virtio_gpu_ctrl_command *cmd,
> @@ -840,9 +871,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>   
>           do {
>               len = l;
> -            map = dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, &len,
> -                                 DMA_DIRECTION_TO_DEVICE,
> -                                 MEMTXATTRS_UNSPECIFIED);
> +            map = map_gpa2hva(g, cmd, a, &len);
>               if (!map) {
>                   qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
>                                 " element %d\n", __func__, e);


