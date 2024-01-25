Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F91C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 18:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT4JJ-0007QG-VJ; Thu, 25 Jan 2024 13:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rT4JB-0007Pf-Qk
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 13:18:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rT4J9-0007DO-Um
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 13:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706206714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nwslm7PwswkGl69MKjOy6O6tlJ63Qymtvww12bPQ2PA=;
 b=PTD/+p7qXo+6DJ+OJ5EjeqVckbWrUNdWmB44QBlQ5xIF79F024lt681I/U4vHGmCMmRqxB
 KqABJ06RvMLl9tcUNgOH98fy6aUt6pmeiMNKwh+Hbj0FzScrwFNuvsvkqQW+8Tz73M9Ez+
 oZn+RjbZlPBAeWXQR7fZ53bnpsc3dgE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-r03SDH2INHSyyIIbAAkg5g-1; Thu, 25 Jan 2024 13:18:33 -0500
X-MC-Unique: r03SDH2INHSyyIIbAAkg5g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-337cef39f65so3445177f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 10:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706206711; x=1706811511;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nwslm7PwswkGl69MKjOy6O6tlJ63Qymtvww12bPQ2PA=;
 b=dE3T9Ti9LahMYsWoL5zWXHozwNeOhHSbPEHCuUPxGABQcJz4ZSqTWHugkZozXncNyJ
 gwJzRLlyzp4ReZ7Hnn8P+8haadjGZkWdl5pV+0XbEMarItxlC1bHcEv2t4VdH+U8Osmm
 TvQ0OQL+ZQI1E3BsEhhi780U/I3M6W8TXV/i5eQzYVKCqnPsojy7IVlcD1aqN+eC0o+c
 9fhJJnCPQEXsA6yuPlX/ELWAxQcEpNurwdjJDmkjxRDvFJdY8lP76GP0sOOFtd6WhbjF
 CJm21XnKyztcYFE/EcB+BOKYm3DszAwZ+49hrLJMqa54O/E5bcdDJeLhvCRhzKwPKgWn
 XwWQ==
X-Gm-Message-State: AOJu0YwGHBqlyZ6s+4V9iFCdxqWO/zg+uyd0RVkK+vs9zSvW4vgrsUxd
 Z19M7mPsNTxCIG935dJHSVxnfBQ9AFk0APoZxBo4GXhB2H6JZQW+0gfT1509mdW10Ghd7nMebyZ
 2W8fjDzvgeQ+9XJCdpy7OqtniKdz/49NDf3aeiLr9i/iPxwNYbfxB
X-Received: by 2002:a5d:60cb:0:b0:337:bc40:35f5 with SMTP id
 x11-20020a5d60cb000000b00337bc4035f5mr112632wrt.73.1706206711172; 
 Thu, 25 Jan 2024 10:18:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcGXhCoARj8D/WwMAcS8ZEKUVJlvYzpPA3l0nq6CDUQo6JHhDuSeZ+x7AAqC93mclT+8vPsw==
X-Received: by 2002:a5d:60cb:0:b0:337:bc40:35f5 with SMTP id
 x11-20020a5d60cb000000b00337bc4035f5mr112627wrt.73.1706206710822; 
 Thu, 25 Jan 2024 10:18:30 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV/UoXpokc2GctOwQSih/kaHH0vnZzl9Zj9UT840mRaCCCNlHEoscJTfpl1/kDZvyP1rYkqnD4kGT84AxGKZAtjH44VSNzvvCYja4NCDZRUI+H0IWTjsyTA4iSAv4L15G6TuJNjV+wv22TRACnQVTJ0kmQhTmBl09mx8/iHGOVGa8XMkKriYuL5SF2CyxdwitDO3ZVU1lPk++3GhqgNmhqd/w==
Received: from ?IPV6:2003:cf:d73b:4169:9eef:dd9f:57fb:1235?
 (p200300cfd73b41699eefdd9f57fb1235.dip0.t-ipconnect.de.
 [2003:cf:d73b:4169:9eef:dd9f:57fb:1235])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a5d6307000000b00337d71bb3c0sm17469415wru.46.2024.01.25.10.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 10:18:30 -0800 (PST)
Message-ID: <cd6bccd0-abca-40ec-9df0-fe5285d18d97@redhat.com>
Date: Thu, 25 Jan 2024 19:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio: Keep notifications disabled during drain
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20240124173834.66320-1-hreitz@redhat.com>
 <20240124173834.66320-3-hreitz@redhat.com> <20240125180326.GA36016@fedora>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240125180326.GA36016@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 25.01.24 19:03, Stefan Hajnoczi wrote:
> On Wed, Jan 24, 2024 at 06:38:30PM +0100, Hanna Czenczek wrote:
>> During drain, we do not care about virtqueue notifications, which is why
>> we remove the handlers on it.  When removing those handlers, whether vq
>> notifications are enabled or not depends on whether we were in polling
>> mode or not; if not, they are enabled (by default); if so, they have
>> been disabled by the io_poll_start callback.
>>
>> Because we do not care about those notifications after removing the
>> handlers, this is fine.  However, we have to explicitly ensure they are
>> enabled when re-attaching the handlers, so we will resume receiving
>> notifications.  We do this in virtio_queue_aio_attach_host_notifier*().
>> If such a function is called while we are in a polling section,
>> attaching the notifiers will then invoke the io_poll_start callback,
>> re-disabling notifications.
>>
>> Because we will always miss virtqueue updates in the drained section, we
>> also need to poll the virtqueue once after attaching the notifiers.
>>
>> Buglink: https://issues.redhat.com/browse/RHEL-3934
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   include/block/aio.h |  7 ++++++-
>>   hw/virtio/virtio.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/block/aio.h b/include/block/aio.h
>> index 5d0a114988..8378553eb9 100644
>> --- a/include/block/aio.h
>> +++ b/include/block/aio.h
>> @@ -480,9 +480,14 @@ void aio_set_event_notifier(AioContext *ctx,
>>                               AioPollFn *io_poll,
>>                               EventNotifierHandler *io_poll_ready);
>>   
>> -/* Set polling begin/end callbacks for an event notifier that has already been
>> +/*
>> + * Set polling begin/end callbacks for an event notifier that has already been
>>    * registered with aio_set_event_notifier.  Do nothing if the event notifier is
>>    * not registered.
>> + *
>> + * Note that if the io_poll_end() callback (or the entire notifier) is removed
>> + * during polling, it will not be called, so an io_poll_begin() is not
>> + * necessarily always followed by an io_poll_end().
>>    */
>>   void aio_set_event_notifier_poll(AioContext *ctx,
>>                                    EventNotifier *notifier,
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 7549094154..4166da9e97 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -3556,6 +3556,17 @@ static void virtio_queue_host_notifier_aio_poll_end(EventNotifier *n)
>>   
>>   void virtio_queue_aio_attach_host_notifier(VirtQueue *vq, AioContext *ctx)
>>   {
>> +    /*
>> +     * virtio_queue_aio_detach_host_notifier() can leave notifications disabled.
>> +     * Re-enable them.  (And if detach has not been used before, notifications
>> +     * being enabled is still the default state while a notifier is attached;
>> +     * see virtio_queue_host_notifier_aio_poll_end(), which will always leave
>> +     * notifications enabled once the polling section is left.)
>> +     */
>> +    if (!virtio_queue_get_notification(vq)) {
>> +        virtio_queue_set_notification(vq, 1);
>> +    }
>> +
>>       aio_set_event_notifier(ctx, &vq->host_notifier,
>>                              virtio_queue_host_notifier_read,
>>                              virtio_queue_host_notifier_aio_poll,
>> @@ -3563,6 +3574,13 @@ void virtio_queue_aio_attach_host_notifier(VirtQueue *vq, AioContext *ctx)
>>       aio_set_event_notifier_poll(ctx, &vq->host_notifier,
>>                                   virtio_queue_host_notifier_aio_poll_begin,
>>                                   virtio_queue_host_notifier_aio_poll_end);
>> +
>> +    /*
>> +     * We will have ignored notifications about new requests from the guest
>> +     * during the drain, so "kick" the virt queue to process those requests
>> +     * now.
>> +     */
>> +    virtio_queue_notify(vq->vdev, vq->queue_index);
> event_notifier_set(&vq->host_notifier) is easier to understand because
> it doesn't contain a non-host_notifier code path that we must not take.
>
> Is there a reason why you used virtio_queue_notify() instead?

Not a good one anyway!

virtio_queue_notify() is just what seemed obvious to me (i.e. to notify 
the virtqueue).  Before removal of the AioContext lock, calling 
handle_output seemed safe.  But, yes, there was the discussion on the 
RFC that it really isn’t.  I didn’t consider that means we must rely on 
virtio_queue_notify() calling event_notifier_set(), so we may as well 
call it explicitly here.

I’ll fix it, thanks for pointing it out!

> Otherwise:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks!

Hanna


