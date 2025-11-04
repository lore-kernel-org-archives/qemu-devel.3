Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963C1CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 11:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGEuC-0000ck-I9; Tue, 04 Nov 2025 06:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGEuB-0000cX-0D; Tue, 04 Nov 2025 06:08:51 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGEu8-0003g2-7I; Tue, 04 Nov 2025 06:08:50 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1FECB804D1;
 Tue, 04 Nov 2025 14:08:43 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:95c::1:2] (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id g8iRxh1FJSw0-t9nJvVvm; Tue, 04 Nov 2025 14:08:42 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762254522;
 bh=8hQkxFRPC+qH8VpoT7LPe/UFZ6JH8mq2YownRBOQCUA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=CI9a8eFkolTpznj7CtatHgMLL2qmRvjk4XvBjcaJxOk2in3+0lfauw9+z9LxYquEW
 29vvP0x2nfUA4uH0nL+4VzGvIC8+aYH83X6NVOx2MjNknHChZs0sLYP0iXWvwBBZ5n
 hhvi9KVIwVuj7kOMqRRJu0rXrg2+Un0g8GmQvDTY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <aacd94b7-53c9-46e0-a519-7ac50a0e74e4@yandex-team.ru>
Date: Tue, 4 Nov 2025 14:08:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/23] vhost-user-blk: add some useful trace-points
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
 <20251015145808.1112843-23-vsementsov@yandex-team.ru>
 <20251103162710-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251103162710-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
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

On 04.11.25 00:28, Michael S. Tsirkin wrote:
> On Wed, Oct 15, 2025 at 05:58:06PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>> Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
>> ---
>>   hw/block/trace-events     | 10 ++++++++++
>>   hw/block/vhost-user-blk.c | 19 +++++++++++++++++++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/hw/block/trace-events b/hw/block/trace-events
>> index cc9a9f2460..dbaa5ca6cb 100644
>> --- a/hw/block/trace-events
>> +++ b/hw/block/trace-events
>> @@ -58,6 +58,16 @@ virtio_blk_handle_zone_mgmt(void *vdev, void *req, uint8_t op, int64_t sector, i
>>   virtio_blk_handle_zone_reset_all(void *vdev, void *req, int64_t sector, int64_t len) "vdev %p req %p sector 0x%" PRIx64 " cap 0x%" PRIx64 ""
>>   virtio_blk_handle_zone_append(void *vdev, void *req, int64_t sector) "vdev %p req %p, append sector 0x%" PRIx64 ""
>>   
>> +# vhost-user-blk.c
>> +vhost_user_blk_start_in(void *vdev) "vdev %p"
>> +vhost_user_blk_start_out(void *vdev) "vdev %p"
>> +vhost_user_blk_stop_in(void *vdev) "vdev %p"
>> +vhost_user_blk_stop_out(void *vdev) "vdev %p"
>> +vhost_user_blk_connect_in(void *vdev) "vdev %p"
>> +vhost_user_blk_connect_out(void *vdev) "vdev %p"
>> +vhost_user_blk_device_realize_in(void *vdev) "vdev %p"
>> +vhost_user_blk_device_realize_out(void *vdev) "vdev %p"
>> +
>>   # hd-geometry.c
>>   hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "blk %p LCHS %d %d %d"
>>   hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t secs, int trans) "blk %p CHS %u %u %u trans %d"
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index de7a810c93..a5daed4346 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -31,6 +31,7 @@
>>   #include "hw/virtio/virtio-access.h"
>>   #include "system/system.h"
>>   #include "system/runstate.h"
>> +#include "trace.h"
>>   
>>   static const int user_feature_bits[] = {
>>       VIRTIO_BLK_F_SIZE_MAX,
>> @@ -137,6 +138,8 @@ static int vhost_user_blk_start(VirtIODevice *vdev, Error **errp)
>>       VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>>       int i, ret;
>>   
>> +    trace_vhost_user_blk_start_in(vdev);
>> +
>>       if (!k->set_guest_notifiers) {
>>           error_setg(errp, "binding does not support guest notifiers");
>>           return -ENOSYS;
>> @@ -192,6 +195,8 @@ static int vhost_user_blk_start(VirtIODevice *vdev, Error **errp)
>>       }
>>       s->started_vu = true;
>>   
>> +    trace_vhost_user_blk_start_out(vdev);
>> +
>>       return ret;
>>   
>>   err_guest_notifiers:
>> @@ -212,6 +217,8 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>>       int ret;
>>       bool force_stop = false;
>>   
>> +    trace_vhost_user_blk_stop_in(vdev);
>> +
>>       if (!s->started_vu) {
>>           return 0;
>>       }
>> @@ -233,6 +240,9 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>>       }
>>   
>>       vhost_dev_disable_notifiers(&s->dev, vdev);
>> +
>> +    trace_vhost_user_blk_stop_out(vdev);
>> +
>>       return ret;
>>   }
>>   
>> @@ -340,6 +350,8 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
>>       VHostUserBlk *s = VHOST_USER_BLK(vdev);
>>       int ret = 0;
>>   
>> +    trace_vhost_user_blk_connect_in(vdev);
>> +
>>       if (s->connected) {
>>           return 0;
>>       }
>> @@ -365,6 +377,8 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
>>           ret = vhost_user_blk_start(vdev, errp);
>>       }
>>   
>> +    trace_vhost_user_blk_connect_out(vdev);
>> +
>>       return ret;
>>   }
>>   
>> @@ -455,6 +469,8 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>>       int retries;
>>       int i, ret;
>>   
>> +    trace_vhost_user_blk_device_realize_in(vdev);
>> +
>>       if (!s->chardev.chr) {
>>           error_setg(errp, "chardev is mandatory");
>>           return;
>> @@ -514,6 +530,9 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>>       qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
>>                                vhost_user_blk_event, NULL, (void *)dev,
>>                                NULL, true);
>> +
>> +    trace_vhost_user_blk_device_realize_out(vdev);
>> +
>>       return;
>>   
>>   virtio_err:
> 
> 
> Is it ok that on error there's an in trace but not an out trace?
> 

I thought about it.

In my opinion, switching to use common "out: " and gotos instead of simple returns,
is too much pay for proper out trace-points.

So, it's a compromise: we have at least trace-point on success-out, and don't make
the code more complicated just for good trace points.

Probably, we can invent some smart macro, which will inject out tracepoint using
g_auto...

-- 
Best regards,
Vladimir

