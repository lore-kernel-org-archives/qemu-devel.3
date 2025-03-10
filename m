Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DD2C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZME-0008E6-Dr; Mon, 10 Mar 2025 05:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trZMC-0008Di-M8
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trZMA-0006fs-1F
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741598607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AogpCDMQ7A3lIkVkEVis+jq9WdUavFV8hMgOlCHcZ0o=;
 b=bLZ8cqszD9NM9ANnXebXouPBvSfJpE0S9c/iOgziyuCiWZADG7Z3lcsP0YkbcE2vlmu/n5
 fJ+6aa95eZOfK/vx3OdTJQ04cIYiOLV5B4NQxEOFtx2kxn8Hd7K/9kNompxqCNYLHQUv25
 KvnkTOwlrL+Sj/AWt9VJ5FxoLIbVo0o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-PbjBngKhPgCNRxKhZ9CDzQ-1; Mon, 10 Mar 2025 05:23:25 -0400
X-MC-Unique: PbjBngKhPgCNRxKhZ9CDzQ-1
X-Mimecast-MFC-AGG-ID: PbjBngKhPgCNRxKhZ9CDzQ_1741598604
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912e4e2033so1870770f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 02:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741598604; x=1742203404;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AogpCDMQ7A3lIkVkEVis+jq9WdUavFV8hMgOlCHcZ0o=;
 b=Dar0kQcjJ6NSpmcafYDrwydZL4bW+59qgU4yRq9vUz7z/uD/YHBKOXMNvmOQtL+qhY
 5TsE9dKrA5RiBjikELE0GB+70KeUkSQ3TtuaPzyeiwFufahu+WhXw6wG2i4Hlskh6VmR
 grxo6ogdWXAvttvHtAK8yx+phO16QuD3dP6Cbx0Vc4eTWOuSTFJ86sIY9MqbmISrif7T
 iN/qKhFREzoSyTKPkzvifnjHCsVU9xVX8Ed/TKlq2xXEoM/CTqAWDZ4iUKG9UdTd95W0
 QW24/ToHJ8XwDQgtxAlFdPi16Il/7rlHD2cahJ53X/AYCQVstD4CsAr+7WqgLWu9ROMf
 Qtmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLcp0MCXQoRA6yBm+PfNQVNfummQDOlirnbkq0rtNkS/sPmwbQLBEniFGzK8weP+cwA0NIDM0qbLTA@nongnu.org
X-Gm-Message-State: AOJu0Yx1JY8/vF97nL6g+YaSSEsf+ZOv1OIGLR+LUGhE+cFtE7DZkPvF
 vVu9u4KCJVIxbqOw1aX735twZGOzN3XIwTvcRCjoNA9ni8w3QGdhNjNN3DjHSiaJXEdgRTpR+cM
 zezXRG+PwjqtGq+nm/fYL93/ta6SQQy7CIEydDYwksRF7EI2KaUDd
X-Gm-Gg: ASbGnctDoh9xwn1aBbg168h6/DeJObGeE4DVQJeQprMJdkXNKTq7LBmloFnure+jAE6
 3mICrbJuY5tm41ghhhxQxft2rgl5647wH043L3wNDt1biyPKhNLMSPogtlEiS1eOqHwDA4KL6fp
 QovflpWQz/gqXc0GLgFaCQIyEp5+/piZBW6lhK+CJQCaCCZH7ZloZps622hxwSWEC/1JZyJoGdK
 SaN9L9ohEm6toJ50DQ6aV7qO7VbHppj2xbpkMOP1mAllDp4gFnVg5NabjCTqwqRpuJg1YOGQJ5U
 Bsd2vaNu4wcroeOF51kwqBL+qr257vPMmK+BPNr3QCqN4CT/J4XvAw==
X-Received: by 2002:a05:6000:410a:b0:391:4559:8761 with SMTP id
 ffacd0b85a97d-39145598929mr1779925f8f.36.1741598603947; 
 Mon, 10 Mar 2025 02:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeTeFYHytTkezL55d2kEKWSsivoj9aUq8vxm2+ACqn+BXOHyr9NVF9pO0o/ql48kCVJVOGJg==
X-Received: by 2002:a05:6000:410a:b0:391:4559:8761 with SMTP id
 ffacd0b85a97d-39145598929mr1779912f8f.36.1741598603510; 
 Mon, 10 Mar 2025 02:23:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ceed32e64sm56880095e9.5.2025.03.10.02.23.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 02:23:22 -0700 (PDT)
Message-ID: <51f2cf5d-4396-40aa-9801-00dd2b135391@redhat.com>
Date: Mon, 10 Mar 2025 10:23:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vfio/migration: Use BE byte order for device state
 wire packets
To: Avihai Horon <avihaih@nvidia.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <f0bf02377f18f3cf6b8942528b3b5bce97fb6ab7.1741344976.git.maciej.szmigiero@oracle.com>
 <aaad9f89-56c8-4df7-bb36-fb212b39ade4@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aaad9f89-56c8-4df7-bb36-fb212b39ade4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/10/25 09:17, Avihai Horon wrote:
> 
> On 07/03/2025 12:57, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Wire data commonly use BE byte order (including in the existing migration
>> protocol), use it also for for VFIO device state packets.
> 
> Nit: should we add a sentence about the motivation? Something like:
> 
> This will allow VFIO multifd device state transfer between hosts with different endianness.
> Although currently there is no such use case, it's good to have it now for completeness.

Maciej,

Could you please send a v2 with this change ?  and
  
>>
>> Fixes: 3228d311ab18 ("vfio/migration: Multifd device state transfer support - received buffers queuing")
>> Fixes: 6d644baef203 ("vfio/migration: Multifd device state transfer support - send side")

we don't need these Fixes trailers because the feature is not part of
a released QEMU version yet.

>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> 
> Thanks.

Thanks Avihai,

C.

>> ---
>>   hw/vfio/migration-multifd.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>> index a9d41b9f1cb1..e816461e1652 100644
>> --- a/hw/vfio/migration-multifd.c
>> +++ b/hw/vfio/migration-multifd.c
>> @@ -13,6 +13,7 @@
>>   #include "hw/vfio/vfio-common.h"
>>   #include "migration/misc.h"
>>   #include "qapi/error.h"
>> +#include "qemu/bswap.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/lockable.h"
>>   #include "qemu/main-loop.h"
>> @@ -208,12 +209,16 @@ bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
>>           return false;
>>       }
>>
>> +    packet->version = be32_to_cpu(packet->version);
>>       if (packet->version != VFIO_DEVICE_STATE_PACKET_VER_CURRENT) {
>>           error_setg(errp, "%s: packet has unknown version %" PRIu32,
>>                      vbasedev->name, packet->version);
>>           return false;
>>       }
>>
>> +    packet->idx = be32_to_cpu(packet->idx);
>> +    packet->flags = be32_to_cpu(packet->flags);
>> +
>>       if (packet->idx == UINT32_MAX) {
>>           error_setg(errp, "%s: packet index is invalid", vbasedev->name);
>>           return false;
>> @@ -682,9 +687,9 @@ vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
>>
>>       packet_len = sizeof(*packet) + bioc->usage;
>>       packet = g_malloc0(packet_len);
>> -    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
>> -    packet->idx = idx;
>> -    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>> +    packet->version = cpu_to_be32(VFIO_DEVICE_STATE_PACKET_VER_CURRENT);
>> +    packet->idx = cpu_to_be32(idx);
>> +    packet->flags = cpu_to_be32(VFIO_DEVICE_STATE_CONFIG_STATE);
>>       memcpy(&packet->data, bioc->data, bioc->usage);
>>
>>       if (!multifd_queue_device_state(idstr, instance_id,
>> @@ -734,7 +739,7 @@ vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
>>       }
>>
>>       packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
>> -    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
>> +    packet->version = cpu_to_be32(VFIO_DEVICE_STATE_PACKET_VER_CURRENT);
>>
>>       for (idx = 0; ; idx++) {
>>           ssize_t data_size;
>> @@ -755,7 +760,7 @@ vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
>>               break;
>>           }
>>
>> -        packet->idx = idx;
>> +        packet->idx = cpu_to_be32(idx);
>>           packet_size = sizeof(*packet) + data_size;
>>
>>           if (!multifd_queue_device_state(d->idstr, d->instance_id,
> 


