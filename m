Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FACACD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZAyU-0000D1-T4; Mon, 15 Jun 2026 13:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wZAyA-0000AQ-9w; Mon, 15 Jun 2026 13:19:30 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wZAy6-0006Ej-JJ; Mon, 15 Jun 2026 13:19:29 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4FD3580B37;
 Mon, 15 Jun 2026 20:19:18 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:57b::1:29] (unknown
 [2a02:6bf:8080:57b::1:29])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id GJTvlI7aZW20-BfdT1Ldo; Mon, 15 Jun 2026 20:19:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1781543957;
 bh=ppdE/TXxjcpF5qtdikFHGEKQ7If5fVYKXsLzZbC1HNs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=U49rtscYGm2xZfcsgIvSSBSYHsPVWCgRMg4ams4NwOgY+5d8h4o1V/JD+5PxZTd6Q
 t87mg6X7jBX0FnVN8Pecp02rCur56aJjqU4udMruieTaxE/yJ9rIi7oHczcV+TjT3c
 ok9jGsEvCPARLF7HG3agWbq7pPpO5VO7WN4Bzuc0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b39173aa-5fdb-4984-84d2-0a466ca599be@yandex-team.ru>
Date: Mon, 15 Jun 2026 20:19:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user-blk: add seg-max-adjust flag
To: Raphael Norwitz <rnorwitz@nvidia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>
References: <20260401230548.136541-1-heifetz@yandex-team.com>
 <82d9d2d5-7102-4b34-ad7d-df0e8f77b509@nvidia.com>
Content-Language: ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <82d9d2d5-7102-4b34-ad7d-df0e8f77b509@nvidia.com>
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

15.04.26 18:24, Raphael Norwitz пишет:
> Looks in keeping with how virtio-blk does things with seg_max_adjust, so I’m happy in principle.
> 
> Just a nit and a question.
> 
> On 4/2/26 1:05 AM, Sergei Heifetz wrote:
>> [You don't often get email from heifetz@yandex-team.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> The virtio specification is not completely clear about seg_max and its
>> relationship with queue_size. Some drivers (for example, the modern
>> Linux kernel driver) rely on seg_max to set the maximum number of
>> segments used in a request. If seg_max is set larger than queue_size,
>> such a driver might overwhelm a virtqueue by trying to send more
>> segments than it can handle. As a result, it either hangs or faults.
>>
>> One might argue that it is the vhost-user server's responsibility to set
>> a valid seg_max value. However, due to the issue described in the
>> previous paragraph, this value should generally depend on queue_size.
>> That's why it may be necessary to control it on QEMU's side.
>>
>> This patch adds the seg-max-adjust flag. A flag with the same name
>> already exists for virtio-blk (and it exists to solve the same problem,
>> except that here we have a vhost-user server to consult).
>>
>> If seg-max-adjust is set, the final seg_max is the minimum of the value
>> provided by the vhost-user server and (queue_size - 2). It is not
>> enabled by default.
>>
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>> ---
>>   hw/block/vhost-user-blk.c          | 11 +++++++++++
>>   include/hw/virtio/vhost-user-blk.h |  1 +
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index c151e836770..23f910d9fe3 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -65,6 +65,11 @@ static void vhost_user_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>>       /* Our num_queues overrides the device backend */
>>       virtio_stw_p(vdev, &s->blkcfg.num_queues, s->num_queues);
>>
>> +    if (s->seg_max_adjust) {
> 
> NIT: declaration at the top of the function
> 
>> +        uint32_t seg_max = MIN(s->blkcfg.seg_max, s->queue_size - 2);
>> +        virtio_stl_p(vdev, &s->blkcfg.seg_max, seg_max);
>> +    }
>> +
>>       memcpy(config, &s->blkcfg, vdev->config_len);
>>   }
>>
>> @@ -474,6 +479,10 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>>           error_setg(errp, "queue size must be non-zero");
>>           return;
>>       }
> 
> Can you explain why queue size must be greater than 4 if seg_max_adjust is set? Sorry if I'm missing something obvious.


Because we want seg_max = MIN(s->blkcfg.seg_max, s->queue_size - 2),

and queue size must be power of two. So, for seg_max be > 0, we need queue_size at least 4.

> 
>> +    if (s->queue_size < 4 && s->seg_max_adjust) {
>> +        error_setg(errp, "queue size must be >= 4 when seg-max-adjust is set");
>> +        return;
>> +    }
>>       if (s->queue_size > VIRTQUEUE_MAX_SIZE) {
>>           error_setg(errp, "queue size must not exceed %d",
>>                      VIRTQUEUE_MAX_SIZE);
>> @@ -608,6 +617,8 @@ static const Property vhost_user_blk_properties[] = {
>>       DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
>>                          VHOST_USER_BLK_AUTO_NUM_QUEUES),
>>       DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
>> +    DEFINE_PROP_BOOL("seg-max-adjust", VHostUserBlk, seg_max_adjust,
>> +                      false),
>>       DEFINE_PROP_BIT64("config-wce", VHostUserBlk, parent_obj.host_features,
>>                         VIRTIO_BLK_F_CONFIG_WCE, true),
>>       DEFINE_PROP_BIT64("discard", VHostUserBlk, parent_obj.host_features,
>> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
>> index 1e41a2bcdf6..dee848cfd81 100644
>> --- a/include/hw/virtio/vhost-user-blk.h
>> +++ b/include/hw/virtio/vhost-user-blk.h
>> @@ -34,6 +34,7 @@ struct VHostUserBlk {
>>       struct virtio_blk_config blkcfg;
>>       uint16_t num_queues;
>>       uint32_t queue_size;
>> +    bool seg_max_adjust;
>>       struct vhost_dev dev;
>>       struct vhost_inflight *inflight;
>>       VhostUserState vhost_user;
>> -- 
>> 2.53.0
>>
> 
> 


-- 
Best regards,
Vladimir

