Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70D6C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riC8x-0000vy-3n; Thu, 07 Mar 2024 06:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1riC8u-0000vG-H1; Thu, 07 Mar 2024 06:42:33 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1riC8r-00058E-6t; Thu, 07 Mar 2024 06:42:30 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:22a5:0:640:715a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id A4ED860BDA;
 Thu,  7 Mar 2024 14:42:27 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7204::1:28] (unknown
 [2a02:6b8:b081:7204::1:28])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OffHQh1i0Ko0-igSL5tll; Thu, 07 Mar 2024 14:42:26 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709811746;
 bh=c9qvviqsEaZxNQlhmJFfgbKA9HVsZeLCKysCxs8Ifn0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MujG9xxqQMsJaaxw9OvJpAmcjsZaQKDDLndFL9XqdZfkSq77HyWPdyjLteAm6cnt8
 xn82nibxV2KltleUEcu3i8uTkWQZBK/E6Qk/t5VOsZ0t3M+9eKTDU5C8L3jJpr63ks
 e+XLZFr79+Gii7Y0l1QVCcItUz1hge9y551xcTFo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <206e9691-7534-4447-86cc-56cd307f1862@yandex-team.ru>
Date: Thu, 7 Mar 2024 14:42:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] qapi: introduce CONFIG_READ event
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, raphael@enfabrica.net, mst@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org,
 eblake@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20240301171143.809835-1-vsementsov@yandex-team.ru>
 <20240301171143.809835-7-vsementsov@yandex-team.ru>
 <87cys6cqe7.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87cys6cqe7.fsf@pond.sub.org>
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

On 07.03.24 13:01, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Send a new event when guest reads virtio-pci config after
>> virtio_notify_config() call.
>>
>> That's useful to check that guest fetched modified config, for example
>> after resizing disk backend.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 
>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>> index 6ece164172..ffc5e3be18 100644
>> --- a/qapi/qdev.json
>> +++ b/qapi/qdev.json
>> @@ -179,3 +179,29 @@
>>   { 'command': 'device-sync-config',
>>     'features': [ 'unstable' ],
>>     'data': {'id': 'str'} }
>> +
>> +##
>> +# @VIRTIO_CONFIG_READ:
>> +#
>> +# Emitted whenever guest reads virtio device config after config change.
> 
> Let's not abbreviate "configuration" to "config".

Oops, me again.

> 
>> +#
>> +# @device: device name
>> +#
>> +# @path: device path
>> +#
>> +# Features:
>> +#
>> +# @unstable: The event is experimental.
>> +#
>> +# Since: 9.0
>> +#
>> +# Example:
>> +#
>> +#     <- { "event": "VIRTIO_CONFIG_READ",
>> +#          "data": { "device": "virtio-net-pci-0",
>> +#                    "path": "/machine/peripheral/virtio-net-pci-0" },
>> +#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
>> +##
> 
> As for PATCH 4, I'd like to see some guidance on intended use.

Will do

> 
>> +{ 'event': 'VIRTIO_CONFIG_READ',
>> +  'features': [ 'unstable' ],
>> +  'data': { '*device': 'str', 'path': 'str' } }
> 
> [...]
> 

Thanks for reviewing my patches!

-- 
Best regards,
Vladimir


