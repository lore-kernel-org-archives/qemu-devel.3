Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C502BCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mm0-000816-FD; Thu, 16 Oct 2025 08:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9Mly-00080e-Ah
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:07:58 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9Mlt-0006rj-EO
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:07:58 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 096C3808DA;
 Thu, 16 Oct 2025 15:07:47 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8c::1:19] (unknown
 [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id i7QfPI1Nq0U0-xHLTG6Km; Thu, 16 Oct 2025 15:07:45 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760616465;
 bh=nzwJGRHYuQ0u9+4ObTu7drmnDGB7bzVmF459jCUdXDo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=NssFXLHqpmdYOFw+ZppctafIPh25hNbOEnphG3ioX/YVU3W/R99FUBpzMrULZKJIT
 PpBzcSgbVLQTbZWJS8hhXCmK6XM4yih/KacKVSwyyOZ2uprnYcQ7/z0rnswQM4LuCd
 s+m7jcVSEerma9msupUTozMDNm2V3TKptywuKPbI=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c5874064-9621-41c9-96b5-b72963ed1958@yandex-team.ru>
Date: Thu, 16 Oct 2025 15:07:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
To: Markus Armbruster <armbru@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, farosas@suse.de,
 sw@weilnetz.de, eblake@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, raphael.s.norwitz@gmail.com
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
 <20251015132136.1083972-17-vsementsov@yandex-team.ru>
 <87a51rgln5.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87a51rgln5.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16.10.25 13:56, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> This parameter enables backend-transfer feature: all devices
>> which support it will migrate their backends (for example a TAP
>> device, by passing open file descriptor to migration channel).
>>
>> Currently no such devices, so the new parameter is a noop.
>>
>> Next commit will add support for virtio-net, to migrate its
>> TAP backend.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index be0f3fcc12..35601a1f87 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -951,9 +951,16 @@
>>   #     is @cpr-exec.  The first list element is the program's filename,
>>   #     the remainder its arguments.  (Since 10.2)
>>   #
>> +# @backend-transfer: Enable backend-transfer feature for devices that
> 
> Either "Enable the backend transfer feature" or "Enable backend transfer"

then, "Enable the backend-transfer feature"

> 
>> +#     supports it. In general that means that backend state and its
> 
> support
> 
>> +#     file descriptors are passed to the destination in the migraton
>> +#     channel (which must be a UNIX socket). Individual devices
>> +#     declare the support for backend-transfer by per-device
>> +#     backend-transfer option. (Since 10.2)
>> +#
> 
> I'm not sure I understand this.
> 
> What is a "per-device backend-transfer option"?  Is it a device
> property?
> 
> If yes, I guess the device declares its capability to do this by having
> this property.  Correct?

No, user may set/unset this property to say, should device participate
in backend-transfer or not.

Still, as you can see in parallel thread, Daniel have strong arguments
against such API, so seems it will change again in v9.

https://lore.kernel.org/qemu-devel/aPCtkB-GvFNuqlHn@redhat.com/

> 
> Does the property's value matter?  How?
> 
>>   # Features:
>>   #
>> -# @unstable: Members @x-checkpoint-delay and
>> +# @unstable: Members @backend-transfer, @x-checkpoint-delay and
>>   #     @x-vcpu-dirty-limit-period are experimental.
>>   #
>>   # Since: 2.4
>> @@ -978,7 +985,8 @@
>>              'mode',
>>              'zero-page-detection',
>>              'direct-io',
>> -           'cpr-exec-command'] }
>> +           'cpr-exec-command',
>> +           { 'name': 'backend-transfer', 'features': ['unstable'] } ] }
>>   
>>   ##
>>   # @MigrateSetParameters:
> 
> [...]
> 


-- 
Best regards,
Vladimir

