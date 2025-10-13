Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B6ECCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 08:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Dyt-0007mk-Mb; Mon, 13 Oct 2025 04:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8Dyn-0007lY-HA; Mon, 13 Oct 2025 04:32:30 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8Dyi-0006gi-IW; Mon, 13 Oct 2025 04:32:28 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 39B11807E3;
 Mon, 13 Oct 2025 11:32:15 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a50::1:2a] (unknown
 [2a02:6bf:8080:a50::1:2a])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id DWJVg31Fu4Y0-ySwMJbrA; Mon, 13 Oct 2025 11:32:14 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760344334;
 bh=IQ6FgEAnSnVI9Y9M/JGc8a09VhBGeDwYFGSAr8BL37E=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=mGuUw7k5fsf6zcp/5YzfdL3KTR1arNveeje+mlrYNhYhY4UzM5f2y1hMIgfXj1vni
 WjFBZrWgdfgkX41hKzRb+4Ulyuspf0Da/Heyy8PyajPKW/KXdchaoI/iZUr4yhM9yu
 02H2/t725dBtJUtgiestp5wzN8GmUCx1dmo623e4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1a09b423-41f5-4586-b9ce-f0e7d74e345a@yandex-team.ru>
Date: Mon, 13 Oct 2025 11:32:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/23] vhost: drop backend_features field
To: Markus Armbruster <armbru@redhat.com>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net,
 qemu-devel@nongnu.org, raphael.s.norwitz@gmail.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Blake <eblake@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-3-vsementsov@yandex-team.ru>
 <87plar9zvh.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87plar9zvh.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 13.10.25 07:42, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> This field is mostly unused and sometimes confusing (we even have
>> a TODO-like comment to drop it). Let's finally do.
>>
>> The field is used to held VHOST_USER_F_PROTOCOL_FEATURES for vhost-user
>> and/or VHOST_NET_F_VIRTIO_NET_HDR for vhost-net (which may be
>> vhost-user-net). But we can simply recalculate these two flags in place
>> from hdev->features, and from net-client for VHOST_NET_F_VIRTIO_NET_HDR.
>>
>> Note: removing field from x-query-virtio-status result is incompatible
>> change. We can do it because the command is unstable.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> You improved the commit message like I suggested, but lost my

I decided that commit is changed enough, so that it's not safe to save any r-b/a-b marks.

> Acked-by: Markus Armbruster <armbru@redhat.com>
> :)

Thanks!

> 
> [...]
> 
>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>> index 1ee639dd7e..3e69e47833 100644
>> --- a/include/hw/virtio/vhost.h
>> +++ b/include/hw/virtio/vhost.h
>> @@ -100,16 +100,9 @@ struct vhost_dev {
>>        *
>>        * @features: available features provided by the backend
>>        * @acked_features: final negotiated features with front-end driver
>> -     *
>> -     * @backend_features: this is used in a couple of places to either
>> -     * store VHOST_USER_F_PROTOCOL_FEATURES to apply to
>> -     * VHOST_USER_SET_FEATURES or VHOST_NET_F_VIRTIO_NET_HDR. Its
>> -     * future use should be discouraged and the variable retired as
>> -     * its easy to confuse with the VirtIO backend_features.
>>        */
> 
> I guess this is the TODO-like comment mentioned in the commit message.

yes)

> 
>>       VIRTIO_DECLARE_FEATURES(features);
>>       VIRTIO_DECLARE_FEATURES(acked_features);
>> -    VIRTIO_DECLARE_FEATURES(backend_features);
>>   
>>       /**
>>        * @protocol_features: is the vhost-user only feature set by
>> diff --git a/qapi/virtio.json b/qapi/virtio.json
>> index 05295ab665..b995a5bb6d 100644
>> --- a/qapi/virtio.json
>> +++ b/qapi/virtio.json
>> @@ -85,8 +85,6 @@
>>   #
>>   # @acked-features: vhost_dev acked_features
>>   #
>> -# @backend-features: vhost_dev backend_features
>> -#
>>   # @protocol-features: vhost_dev protocol_features
>>   #
>>   # @max-queues: vhost_dev max_queues
>> @@ -106,7 +104,6 @@
>>               'vq-index': 'int',
>>               'features': 'VirtioDeviceFeatures',
>>               'acked-features': 'VirtioDeviceFeatures',
>> -            'backend-features': 'VirtioDeviceFeatures',
>>               'protocol-features': 'VhostDeviceProtocols',
>>               'max-queues': 'uint64',
>>               'backend-cap': 'uint64',
> 


-- 
Best regards,
Vladimir

