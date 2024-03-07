Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D9AC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAaq-0007Et-HB; Thu, 07 Mar 2024 05:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1riAao-0007ER-Rz; Thu, 07 Mar 2024 05:03:15 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1riAal-0001cr-KS; Thu, 07 Mar 2024 05:03:14 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:22a5:0:640:715a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 1973C60A2D;
 Thu,  7 Mar 2024 13:03:06 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7204::1:28] (unknown
 [2a02:6b8:b081:7204::1:28])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 43eP4g1i5Gk0-pRb91vo3; Thu, 07 Mar 2024 13:03:05 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709805785;
 bh=Ha9LKUG7jPn/fw73Kv0Ru6hPQQPn4OsClMX9fgoP7kk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=WYJ8B/pY5CPUqiP9xL/RKb5l8jluaGzrAUPQdcfNewbOOmGUygtYcTBJ68uS8UUdB
 p+KJPcAdkXbEWs/ItX2n0Iv1hgHy9HJ+akofOU5W3ycBKM++KK2qwmbipIu/Jnhew2
 BRmbvqnOb+Cc8ZB+6rBwIoHPNiqwkWrTVQxz8Nio=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <063ad24f-714d-48df-a092-75e9fc693082@yandex-team.ru>
Date: Thu, 7 Mar 2024 13:03:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] qdev-monitor: add option to report GenericError
 from find_device_state
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, raphael@enfabrica.net, mst@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org,
 eblake@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20240301171143.809835-1-vsementsov@yandex-team.ru>
 <20240301171143.809835-4-vsementsov@yandex-team.ru>
 <87sf12cr1z.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87sf12cr1z.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 07.03.24 12:46, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   system/qdev-monitor.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>> index 9febb743f1..cf7481e416 100644
>> --- a/system/qdev-monitor.c
>> +++ b/system/qdev-monitor.c
>> @@ -877,13 +877,20 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>>       object_unref(OBJECT(dev));
>>   }
>>   
>> -static DeviceState *find_device_state(const char *id, Error **errp)
>> +/*
>> + * Note that creating new APIs using error classes other than GenericError is
>> + * not recommended. Set use_generic_error=true for new interfaces.
>> + */
>> +static DeviceState *find_device_state(const char *id, bool use_generic_error,
>> +                                      Error **errp)
>>   {
>>       Object *obj = object_resolve_path_at(qdev_get_peripheral(), id);
>>       DeviceState *dev;
>>   
>>       if (!obj) {
>> -        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
>> +        error_set(errp,
>> +                  (use_generic_error ?
>> +                   ERROR_CLASS_GENERIC_ERROR : ERROR_CLASS_DEVICE_NOT_FOUND),
>>                     "Device '%s' not found", id);
>>           return NULL;
>>       }
>> @@ -947,7 +954,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>>   
>>   void qmp_device_del(const char *id, Error **errp)
>>   {
>> -    DeviceState *dev = find_device_state(id, errp);
>> +    DeviceState *dev = find_device_state(id, false, errp);
>>       if (dev != NULL) {
>>           if (dev->pending_deleted_event &&
>>               (dev->pending_deleted_expires_ms == 0 ||
>> @@ -1067,7 +1074,7 @@ BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
>>   
>>       GLOBAL_STATE_CODE();
>>   
>> -    dev = find_device_state(id, errp);
>> +    dev = find_device_state(id, false, errp);
>>       if (dev == NULL) {
>>           return NULL;
>>       }
> 
> I appreciate the attempt to curb the spread of DeviceNotFound errors.
> Two issues:
> 
> * Copy-pasting find_device_state() with a false argument is an easy
>    error to make.
> 
> * Most uses of find_device_state() are via blk_by_qdev_id() and
>    qmp_get_blk().  Any new uses of qemu_get_blk() will still produce
>    DeviceNotFound.
> 
> Hmm.

Hmm. Right. Wait a bit, I can make the change stricter.

Could you still explain (or give a link), why and when we decided to use only GenericError? I think, having different "error-codes" is a good thing, why we are trying to get rid of it?

-- 
Best regards,
Vladimir


