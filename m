Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C87C61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 19:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Okv-00027O-VS; Sat, 29 Aug 2026 15:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x0Okt-00025Z-LR
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:30:19 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x0Okp-00027D-84
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:30:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 6D68780762;
 Sat, 29 Aug 2026 22:30:05 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:86::1:4] (unknown [2a02:6bf:8080:86::1:4])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with
 ESMTPSA id 2UmkG04XGeA0-b3VqDur7; Sat, 29 Aug 2026 22:30:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788031804;
 bh=s6cbF49eSUsHxa1B2RHqFSptG7UFIj1MpFLzeW78FXA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=pBWtLMPkF+4aQ9VSMM5riovtQOiYY5S+ZcG+yO/itHaXcS4D/BN0om1+Q21p43Q2N
 VtIuoO9Heyq4wyCpgatmJ5iCq9X6qbY0vD3ANUZiuqHmRjByQb/DPRbm35cVlShbq/
 oiLA+/uddQ/6CF7fvjUybC390+z2o34CENR+D4r4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2f712ad2-b10c-4626-8ade-ba0b5780443d@yandex-team.ru>
Date: Sat, 29 Aug 2026 22:30:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/30] hw/display/virtio-gpu: move to new migration APIs
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
 <20260825213811.3725682-15-vsementsov@yandex-team.ru>
 <63a9cd49-8962-4480-b933-ed46515fce35@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <63a9cd49-8962-4480-b933-ed46515fce35@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 29.08.26 09:54, Akihiko Odaki wrote:
> On 2026/08/26 6:37, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   hw/display/virtio-gpu.c | 99 ++++++++++++++++++++++-------------------
>>   1 file changed, 52 insertions(+), 47 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index fbb6fec7a0a..1af640accdc 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -1308,13 +1308,13 @@ static const VMStateDescription vmstate_virtio_gpu_scanouts = {
>>       },
>>   };
>> -static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
>> -                           const VMStateField *field, JSONWriter *vmdesc)
>> +static bool virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
>> +                            const VMStateField *field, JSONWriter *vmdesc,
>> +                            Error **errp)
>>   {
>>       VirtIOGPU *g = opaque;
>>       struct virtio_gpu_simple_resource *res;
>> -    Error *err = NULL;
>> -    int i, ret;
>> +    int i;
>>       /* in 2d mode we should never find unprocessed commands here */
>>       assert(QTAILQ_EMPTY(&g->cmdq));
>> @@ -1337,12 +1337,7 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
>>       }
>>       qemu_put_be32(f, 0); /* end of list */
>> -    ret = vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
>> -                             &err);
>> -    if (ret < 0) {
>> -        error_report_err(err);
>> -    }
>> -    return ret;
>> +    return vmstate_save_vmsd(f, &vmstate_virtio_gpu_scanouts, g, NULL, errp);
>>   }
>>   static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
>> @@ -1374,14 +1369,13 @@ static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
>>       return true;
>>   }
>> -static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>> -                           const VMStateField *field)
>> +static bool virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>> +                            const VMStateField *field, Error **errp)
>>   {
>>       VirtIOGPU *g = opaque;
>> -    Error *err = NULL;
>>       struct virtio_gpu_simple_resource *res;
>>       uint32_t resource_id, pformat, hostmem, rowstride_bytes;
>> -    int i, ret;
>> +    int i;
>>       g->hostmem = 0;
>> @@ -1389,7 +1383,8 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>>       while (resource_id != 0) {
>>           res = virtio_gpu_find_resource(g, resource_id);
>>           if (res) {
>> -            return -EINVAL;
>> +            error_setg(errp, "Failed to find resource %" PRIu32, resource_id);
>> +            return false;
>>           }
>>           res = g_new0(struct virtio_gpu_simple_resource, 1);
>> @@ -1402,14 +1397,16 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>>           /* allocate */
>>           pformat = virtio_gpu_get_pixman_format(res->format);
>>           if (!pformat) {
>> +            error_setg(errp, "Unknown pixman format %" PRIu32, res->format);
>>               g_free(res);
>> -            return -EINVAL;
>> +            return false;
>>           }
>>           if (!calc_image_hostmem(pformat, res->width, res->height,
>>                                   &hostmem, &rowstride_bytes)) {
>>               g_free(res);
>> -            return -EINVAL;
>> +            error_setg(errp, "Failed to calculate image hostmem");
>> +            return false;
>>           }
>>           res->hostmem = hostmem;
>>           if (!qemu_pixman_image_new_shareable(&res->image,
>> @@ -1419,10 +1416,9 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>>                                                res->width,
>>                                                res->height,
>>                                                rowstride_bytes,
>> -                                             &err)) {
>> -            warn_report_err(err);
>> +                                             errp)) {
>>               g_free(res);
>> -            return -EINVAL;
>> +            return false;
>>           }
>>           res->addrs = g_try_new(uint64_t, res->iov_cnt);
>> @@ -1432,7 +1428,8 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>>               g_free(res->addrs);
>>               g_free(res->iov);
>>               g_free(res);
>> -            return -EINVAL;
>> +            error_setg(errp, "Failed to allocate iov arrays");
>> +            return false;
>>           }
>>           /* read data */
>> @@ -1446,22 +1443,20 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>>           if (!virtio_gpu_load_restore_mapping(g, res)) {
>>               pixman_image_unref(res->image);
>>               g_free(res);
>> -            return -EINVAL;
>> +            error_setg(errp, "Failed to load restore mapping");
>> +            return false;
>>           }
>>           resource_id = qemu_get_be32(f);
>>       }
>>       /* load & apply scanout state */
>> -    ret = vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &err);
>> -    if (ret < 0) {
>> -        error_report_err(err);
>> -    }
>> -    return ret;
>> +    return vmstate_load_vmsd(f, &vmstate_virtio_gpu_scanouts, g, 1, errp);
>>   }
>> -static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
>> -                                const VMStateField *field, JSONWriter *vmdesc)
>> +static bool virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
>> +                                 const VMStateField *field, JSONWriter *vmdesc,
>> +                                 Error **errp)
>>   {
>>       VirtIOGPU *g = opaque;
>>       struct virtio_gpu_simple_resource *res;
>> @@ -1485,11 +1480,11 @@ static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
>>       }
>>       qemu_put_be32(f, 0); /* end of list */
>> -    return 0;
>> +    return true;
>>   }
>> -static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
>> -                                const VMStateField *field)
>> +static bool virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
>> +                                 const VMStateField *field, Error **errp)
>>   {
>>       VirtIOGPU *g = opaque;
>>       struct virtio_gpu_simple_resource *res;
>> @@ -1500,7 +1495,8 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
>>       while (resource_id != 0) {
>>           res = virtio_gpu_find_resource(g, resource_id);
>>           if (res) {
>> -            return -EINVAL;
>> +            error_setg(errp, "Failed to find resource %" PRIu32, resource_id);
>> +            return false;
>>           }
>>           res = g_new0(struct virtio_gpu_simple_resource, 1);
>> @@ -1514,7 +1510,8 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
>>               g_free(res->addrs);
>>               g_free(res->iov);
>>               g_free(res);
>> -            return -EINVAL;
>> +            error_setg(errp, "Failed to allocate iov arrays");
>> +            return false;
>>           }
>>           /* read data */
>> @@ -1525,15 +1522,19 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
>>           if (res->iov_cnt > 0 &&
>>               iov_size(res->iov, res->iov_cnt) < res->blob_size) {
>> +            error_setg(errp, "iov size %" PRIu64 " < blob_size %" PRIu64,
>> +                       (uint64_t)iov_size(res->iov, res->iov_cnt),
> 
> nitpick: I somewhat prefer:
> 
>              error_setg(errp, "iov size %zu < blob_size %" PRIu64,
>                         iov_size(res->iov, res->iov_cnt),
> 
> because:
> 
> - it does not require thinking about the cast. The conditional above
>    does perform implicit cast, but it automatically picks the wider type.
>    The explicit cast here doesn't so requires a little more thought.
> 
> - it requries less typing.
> 
> And this hunk cannot be applied due to recent virtio-gpu fixes. Please rebase it.
> 
>> +                       res->blob_size);
>>               g_free(res->addrs);
>>               g_free(res->iov);
>>               g_free(res);
>> -            return -EINVAL;
>> +            return false;
>>           }
>>           if (!virtio_gpu_load_restore_mapping(g, res)) {
>>               g_free(res);
>> -            return -EINVAL;
>> +            error_setg(errp, "Failed to load restore mapping");
> 
> Let's say: "Failed to restore loaded mapping"
> 
>> +            return false;
>>           }
>>           virtio_gpu_init_udmabuf(res);
>> @@ -1541,10 +1542,10 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
>>           resource_id = qemu_get_be32(f);
>>       }
>> -    return 0;
>> +    return true;
>>   }
>> -static int virtio_gpu_post_load(void *opaque, int version_id)
>> +static bool virtio_gpu_post_load(void *opaque, int version_id, Error **errp)
>>   {
>>       VirtIOGPU *g = opaque;
>>       struct virtio_gpu_scanout *scanout;
>> @@ -1559,7 +1560,9 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
>>           res = virtio_gpu_find_resource(g, scanout->resource_id);
>>           if (!res) {
>> -            return -EINVAL;
>> +            error_setg(errp, "Failed to find resource %" PRIu32,
>> +                       scanout->resource_id);
>> +            return false;
>>           }
>>           if (scanout->fb.format != 0) {
>> @@ -1572,12 +1575,14 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
>>               };
>>               if (!virtio_gpu_do_set_scanout(g, i, &scanout->fb, res, &r, &error)) {
>> -                return -EINVAL;
>> +                error_setg(errp, "Failed to set scanout");
>> +                return false;
>>               }
>>           } else {
>>               /* legacy v1 migration support */
>>               if (!res->image) {
>> -                return -EINVAL;
>> +                error_setg(errp, "No image");
> 
> Let's say: "A blob scanout lacks metadata".
> 
> Regards,
> Akihiko Odaki

Thanks for reviewing! Will apply all suggestions in v2.


-- 
Best regards,
Vladimir

