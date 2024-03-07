Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE21C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 14:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riFCc-0003j3-Id; Thu, 07 Mar 2024 09:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1riFCa-0003hv-JK; Thu, 07 Mar 2024 09:58:32 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1riFCW-0006an-Vq; Thu, 07 Mar 2024 09:58:32 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:22a5:0:640:715a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id B549560CC6;
 Thu,  7 Mar 2024 17:58:23 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7204::1:28] (unknown
 [2a02:6b8:b081:7204::1:28])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LwiDfj1i00U0-8mQ8XoyM; Thu, 07 Mar 2024 17:58:22 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709823502;
 bh=U/Duss55HhjsykEueNHvEN+zwjEjHIenxgIfRGkHuVY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=IrCBdpsvyk98y4Boj0Oyj9hu/2ntCC81kkekA4zQMNaqY6SyR4qJ2YI5J2JUD0uG1
 +6yOgJqYkeUnO9bAigTEFOi1oxWw3jxpE+k0DBHZe5AYlmOAG+R4JcSIVvKSDoesF5
 apYGteUjsnt9Ku7WY8FRu5yVBMZbEBcycR296c7A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <aabf719b-0717-4659-9b68-5ad93b14baa8@yandex-team.ru>
Date: Thu, 7 Mar 2024 17:58:21 +0300
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
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hm. But what to do?

- rename all three functions to FOO_base(), and add a boolean parameter
- add FOO() wrappers, passing true (use generic error)
- add FOO_deprecated() wrappers, passing false (use device not found error)
- change existing callers to use FOO_deprecated()

Still, new generic-error-based blk_by_qdev_id() and qmp_get_blk() will be unused..

That seem too ugly for me. And that doesn't give 100% sure that nobody will simply duplicate call to _deprecated() function...

Maybe better don't care for now (and continue use device-not-found for new APIs, that reuse find_device_state()), and just declare the deprecation for ERROR_CLASS_DEVICE_NOT_FOUND? And drop it usage everywhere after 3-releases deprecation cycle.

Or do we want deprecate everything except for generic-error, and deprecate error/class field in qmp return value altogether?

-- 
Best regards,
Vladimir


