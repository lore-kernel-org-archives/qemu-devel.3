Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC35C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 14:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2W2K-0003qt-0Y; Wed, 09 Apr 2025 10:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u2W2F-0003qa-Lu
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:04:12 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u2W2D-0007Ym-5p
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:04:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:ca1:0:640:740c:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0625860A5E;
 Wed,  9 Apr 2025 17:04:04 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7304::1:2d] (unknown
 [2a02:6b8:b081:7304::1:2d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 14fhIR0Fb0U0-4LJitn5F; Wed, 09 Apr 2025 17:04:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744207442;
 bh=0Y5kEG/rveil4XjmqXiZLhRE+HQN3fBqkd2aTYD8+8I=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=FHJOBEmcNRnFoQ8/LU660SoTuLid2vOePQzs2NUQcUA7lN/ly2c+uolA2QzwxiEUn
 W0i3AmW0sBVlU+olDgwDMhENl7yD4+b4sIczriJ1WoMrgYtt0iwjEVnM8Zz5XFy0Eu
 YYm4X5g1iBoPCM071YZ+6jaxDbFOYHW6oWAYkUIo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <556a58ac-7a71-47ef-8f00-312b027955bf@yandex-team.ru>
Date: Wed, 9 Apr 2025 17:04:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] [for-10.1] virtio: add VIRTQUEUE_ERROR QAPI event
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, berrange@redhat.com, pbonzini@redhat.com,
 dave@treblig.org, sgarzare@redhat.com, den-plotnikov@yandex-team.ru
References: <20250409094758.58232-1-vsementsov@yandex-team.ru>
 <87plhlbofl.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87plhlbofl.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 09.04.25 13:48, Markus Armbruster wrote:
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
> 
> Likely should be tracepoints.  Not this patch's problem, though.
> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>
>> v6: rename path to qom-path, and improve throttling of the event
>>      improve wording
>>

[..]

>> @@ -527,6 +534,13 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
>>                          qdict_get_str(evb->data, "qom-path"));
>>       }
>>   
>> +    if (eva->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
>> +        return !strcmp(qdict_get_str(eva->data, "qom-path"),
>> +                       qdict_get_str(evb->data, "qom-path")) &&
>> +            (qdict_get_int(eva->data, "virtqueue") ==
>> +             qdict_get_int(evb->data, "virtqueue"));
>> +    }
>> +
>>       return TRUE;
>>   }
>>   
> 
> Rate-limiting is now per virt queue.  It was per device in previous
> revisions.  Worth it?
> 

Hmm. Probably not. If we have 2 virtqueue, seems good to see both event
(or only one, if only one virtqueue failed).
If we have 256 virtqueues, 256 immediate events seems too much.
So, better is to drop virtqueue here and consider only qom-path for throttling.

>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>> index 25cbcf977b..ddfae18761 100644
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
>> +# @vhost-vring-error: the vhost device has communicated failure via
>> +#     the vring error file descriptor
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'enum': 'VirtqueueError',
>> +  'data': [ 'vhost-vring-error' ] }
>> +
>> +##
>> +# @VIRTQUEUE_ERROR:
>> +#
>> +# Emitted when a device virtqueue fails at runtime.
>> +#
>> +# @device: the device's ID if it has one
>> +#
>> +# @qom-path: the device's QOM path
>> +#
>> +# @virtqueue: the index of the virtqueue that failed
>> +#
>> +# @error: error identifier
>> +#
>> +# @description: human readable description
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'event': 'VIRTQUEUE_ERROR',
>> + 'data': { '*device': 'str', 'qom-path': 'str', 'virtqueue': 'int',
>> +            'error': 'VirtqueueError', 'description': 'str'} }
> 
> Standard question for events: can a management application poll for the
> information as well?

Oh. that's a good shot.

I'm afraid it can't. And this makes me to dig into history of this patch
- no, we didn't discussed it before.

And before trying to implement something new here (a way to get a kind of
virtqueues status by a new QMP command), I check that:
- our mgmt tool still doesn't use VIRTQUEUE_ERROR event (which we've
merged to downstream QEMU long ago, of course)
- the original problem that led us to introducing such event doesn't
bother us for a long time

It seems wiser to stop here for now. I should have considered these aspects
before beginning the process of reviving this series. Sorry for your time.

Still, if we (or someone other) need such event in future - good, we have
a modern patch in mailing list to start from.

> 
> I might have asked this before, I don't remember.  If you already
> answered it, feel free to point me to your answer.
> 
> Why is this a standard question for events?  Say, a management
> application wants to track the state of X.  Two ways: poll the state
> with a query command that returns it, listen for events that report a
> change of X.
> 
> Listening for an event is more efficient.
> 
> However, if the management application connects to a QEMU instance, X
> could be anything, so it needs to poll once.
> 
> Special case: the management application restarts for some reason.
> 

-- 
Best regards,
Vladimir


