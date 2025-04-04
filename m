Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAE8C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 10:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0eGL-00042K-Ma; Fri, 04 Apr 2025 06:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u0eGF-00041s-5U
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 06:26:56 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u0eGC-0002Fm-Lv
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 06:26:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 44F3660C18;
 Fri,  4 Apr 2025 13:26:44 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:1220::1:20] (unknown
 [2a02:6b8:b081:1220::1:20])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gQWr210FaeA0-2nArFBjh; Fri, 04 Apr 2025 13:26:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1743762403;
 bh=oVZA6stVnbBXVNJ1+8k4f1j+5d/J0Yh6J5nPaX/oEU8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=lSSHZFpVSV+wL1ja4kuX4FDI1aPjhc1Zl/LTMwMlCgVimHsaXQ+TNYenE+351neA9
 zyLvTc02b2oKgx6Tt6h/fdGXrIf7VwA/e/TQqysYnIuHAxxTbCwGHIgY7ucvruAXT+
 eEYJnoae1x0BXFY1X4nHDJ5HvMT137mA/eGHidRI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <18763620-2bd9-47a6-a5d4-ff61663bae9a@yandex-team.ru>
Date: Fri, 4 Apr 2025 13:26:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] [for-10.1] virtio: add VIRTQUEUE_ERROR QAPI event
To: Markus Armbruster <armbru@redhat.com>
Cc: mst@redhat.com, sgarzare@redhat.com, dave@treblig.org, eblake@redhat.com, 
 pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, Denis Plotnikov <den-plotnikov@yandex-team.ru>
References: <20250401170731.121336-1-vsementsov@yandex-team.ru>
 <878qogqv8u.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <878qogqv8u.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04.04.25 09:46, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> For now we only log the vhost device error, when virtqueue is actually
>> stopped. Let's add a QAPI event, which makes possible:
>>
>>   - collect statistics of such errors
>>   - make immediate actions: take core dumps or do some other debugging
>>   - inform the user through a management API or UI, so that (s)he can
>>    react somehow, e.g. reset the device driver in the guest or even
>>    build up some automation to do so
>>
>> Note that basically every inconsistency discovered during virtqueue
>> processing results in a silent virtqueue stop.  The guest then just
>> sees the requests getting stuck somewhere in the device for no visible
>> reason.  This event provides a means to inform the management layer of
>> this situation in a timely fashion.
>>
>> The event could be reused for some other virtqueue problems (not only
>> for vhost devices) in future. For this it gets a generic name and
>> structure.
>>
>> We keep original VHOST_OPS_DEBUG(), to keep original debug output as is
>> here, it's not the only call to VHOST_OPS_DEBUG in the file.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
>> ---
>>
>> v5: resend, update version in QAPI to 10.1
>>      drop a-b by Markus (too much time passed, the context could
>>      changed. Markus, is the patch still OK?)
> 
> Happy to take another look :)
> 
>>   hw/virtio/vhost.c | 12 +++++++++---
>>   monitor/monitor.c | 10 ++++++++++
>>   qapi/qdev.json    | 32 ++++++++++++++++++++++++++++++++
>>   3 files changed, 51 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 6aa72fd434..0b205cef73 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -15,6 +15,7 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>> +#include "qapi/qapi-events-qdev.h"
>>   #include "hw/virtio/vhost.h"
>>   #include "qemu/atomic.h"
>>   #include "qemu/range.h"
>> @@ -1442,11 +1443,16 @@ static void vhost_virtqueue_error_notifier(EventNotifier *n)
>>       struct vhost_virtqueue *vq = container_of(n, struct vhost_virtqueue,
>>                                                 error_notifier);
>>       struct vhost_dev *dev = vq->dev;
>> -    int index = vq - dev->vqs;
>>   
>>       if (event_notifier_test_and_clear(n) && dev->vdev) {
>> -        VHOST_OPS_DEBUG(-EINVAL,  "vhost vring error in virtqueue %d",
>> -                        dev->vq_index + index);
>> +        int ind = vq - dev->vqs + dev->vq_index;
>> +        DeviceState *ds = &dev->vdev->parent_obj;
>> +
>> +        VHOST_OPS_DEBUG(-EINVAL,  "vhost vring error in virtqueue %d", ind);
>> +        qapi_event_send_virtqueue_error(ds->id, ds->canonical_path, ind,
>> +                                        VIRTQUEUE_ERROR_VHOST_VRING_ERROR,
>> +                                        "vhost reported failure through vring "
>> +                                        "error fd");
>>       }
>>   }
>>   
>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>> index c5a5d30877..1296a9207e 100644
>> --- a/monitor/monitor.c
>> +++ b/monitor/monitor.c
>> @@ -313,6 +313,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>>       [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
>>       [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
>>       [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
>> +    [QAPI_EVENT_VIRTQUEUE_ERROR]   = { 1000 * SCALE_MS },
>>       [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
>>       [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
>>       [QAPI_EVENT_HV_BALLOON_STATUS_REPORT] = { 1000 * SCALE_MS },
>> @@ -499,6 +500,10 @@ static unsigned int qapi_event_throttle_hash(const void *key)
>>           hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
>>       }
>>   
>> +    if (evstate->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
>> +        hash += g_str_hash(qdict_get_str(evstate->data, "device"));
> 
> Isn't @device optional?  Should you use @qom-path instead?

Yes, I'm thinking about it too. Maybe, drop the "device" field from the event at all, and keep only qom-path? Years passed since movement to use qom paths..

> 
>> +    }
>> +
>>       return hash;
>>   }
>>   
>> @@ -527,6 +532,11 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
>>                          qdict_get_str(evb->data, "qom-path"));
>>       }
>>   
>> +    if (eva->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
>> +        return !strcmp(qdict_get_str(eva->data, "device"),
>> +                       qdict_get_str(evb->data, "device"));
> 
> Likewise.
> 
>> +    }
>> +
>>       return TRUE;
>>   }
>>   
>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>> index 25cbcf977b..2d20f4777e 100644
>> --- a/qapi/qdev.json
>> +++ b/qapi/qdev.json
>> @@ -187,3 +187,35 @@
>>   { 'command': 'device-sync-config',
>>     'features': [ 'unstable' ],
>>     'data': {'id': 'str'} }
>> +
>> +##
>> +# @VirtqueueError:
>> +#
>> +# @vhost-vring-error: Vhost device reported failure through
>> +#     through vring error fd.
> 
> One "through" too many.
> 
> I'm not quite sure I understand what you're trying to express.  Is it
> "the vhost device has communicated failure via the vring error file
> descriptor"?

Yes. Will use your wording.

> 
> I know next to nothing about vhost devices...
> 
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'enum': 'VirtqueueError',
>> +  'data': [ 'vhost-vring-error' ] }
>> +
>> +##
>> +# @VIRTQUEUE_ERROR:
>> +#
>> +# Emitted when a device virtqueue fails in runtime.
> 
> I think it's "at runtime".
> 
> Can a device have more than one virtqueue?

Yes. And event has "virtqueue": "int" for it.

> 
>> +#
>> +# @device: the device's ID if it has one
>> +#
>> +# @path: the device's QOM path
> 
> I agree with your follow-up: name it @qom-path.
> 
>> +#
>> +# @virtqueue: virtqueue index
> 
> Bear with me...  What's a virtqueue index?

sequence number of virtqueue of the vhost device


> 
>> +#
>> +# @error: error identifier
>> +#
>> +# @description: human readable description
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'event': 'VIRTQUEUE_ERROR',
>> + 'data': { '*device': 'str', 'path': 'str', 'virtqueue': 'int',
>> +            'error': 'VirtqueueError', 'description': 'str'} }
> 

-- 
Best regards,
Vladimir


