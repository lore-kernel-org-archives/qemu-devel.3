Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDE5C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkFej-0005gu-3F; Thu, 16 Jul 2026 02:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkFeb-0005gE-Ve
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 02:33:07 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkFeY-0001zs-0p
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 02:33:04 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66G6Wp2k093393
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 16 Jul 2026 15:32:51 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TITt3lOgk8rgieO6d8DBsd61j20j0o/5dC/yC2b55+8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784183571; v=1;
 b=kmsLjF5RDHsGfRcxnAZd1aza58iqmtlX8nzgWt3QKoNyHpK8gWv3HpNiv/0oIWen
 d1As0OCYgy1leS2Y7TyG6++YakJxZhqW6XE0NNkNEqTNtxW++fwylpQiEE9DAIiQ
 M39v2VYJfHiv+kBUHC+YagLbs9PyutP3ezufSOTcSQBg/21uCxvA/97JWT+uDxry
 gAC2TQlYh4a2V97Fzcl27/0EraYesYWMl+jC4Z0etD7T7iYi2sVui3305n6HPBsm
 dTHVdyJPQL3igNvdFgJ6pwJeAHbVOvaLtiUaCXx6kKo2mTH/MQTrNAmjickEUZWL
 V5buW0fa7zcQiq6ZXfYDcQ==
Message-ID: <719ec837-fca9-4f77-8b7a-dcf4e1f06c42@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 16 Jul 2026 15:32:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: validate iov_cnt in migration load
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260713125521.109320-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260713125521.109320-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/07/13 21:55, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Cap iov_cnt at 16384 in virtio_gpu_load() and virtio_gpu_blob_load()
> to match the existing limit enforced in virtio_gpu_create_mapping_iov().

These limits apply to different quantities. 
virtio_gpu_create_mapping_iov() limits the guest-supplied nr_entries,
whereas iov_cnt is the number of mappings produced by dma_memory_map().
Since dma_memory_map() may split one guest entry into multiple mappings,
iov_cnt may exceed nr_entries and therefore 16384.

Both save paths serialize this expanded count, so migration can fail 
even for mappings accepted by virtio_gpu_create_mapping_iov(), including 
between QEMU instances containing this patch.

> 
> An unbounded iov_cnt from the migration stream drives two g_new()
> allocations whose combined size can exceed available memory, causing
> GLib to abort the process.

Since there is no corresponding 16384 limit on the expanded iovec
count, I think these allocations should use g_try_new() and propagate
allocation failure as a migration error instead.

Regards,
Akihiko Odaki

> 
> Fixes: 0c244e50ee12 ("virtio-gpu: add live migration support")
> Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3753
> Reported-by: Feifan Qian <bea1e@proton.me>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 88526051a99..6289bff9f3b 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -34,6 +34,7 @@
>   #include "qemu/error-report.h"
>   
>   #define VIRTIO_GPU_VM_VERSION 1
> +#define VIRTIO_GPU_MAX_IOVEC 16384
>   
>   static struct virtio_gpu_simple_resource *
>   virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
> @@ -820,10 +821,10 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>       size_t esize, s;
>       int e, v;
>   
> -    if (nr_entries > 16384) {
> +    if (nr_entries > VIRTIO_GPU_MAX_IOVEC) {
>           qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: nr_entries is too big (%d > 16384)\n",
> -                      __func__, nr_entries);
> +                      "%s: nr_entries is too big (%d > %d)\n",
> +                      __func__, nr_entries, VIRTIO_GPU_MAX_IOVEC);
>           return -1;
>       }
>   
> @@ -1323,6 +1324,11 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>           res->format = qemu_get_be32(f);
>           res->iov_cnt = qemu_get_be32(f);
>   
> +        if (res->iov_cnt > VIRTIO_GPU_MAX_IOVEC) {
> +            g_free(res);
> +            return -EINVAL;
> +        }
> +
>           /* allocate */
>           pformat = virtio_gpu_get_pixman_format(res->format);
>           if (!pformat) {
> @@ -1424,6 +1430,12 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
>           res->resource_id = resource_id;
>           res->blob_size = qemu_get_be32(f);
>           res->iov_cnt = qemu_get_be32(f);
> +
> +        if (res->iov_cnt > VIRTIO_GPU_MAX_IOVEC) {
> +            g_free(res);
> +            return -EINVAL;
> +        }
> +
>           res->addrs = g_new(uint64_t, res->iov_cnt);
>           res->iov = g_new(struct iovec, res->iov_cnt);
>   


