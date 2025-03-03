Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA9BC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 22:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpE4V-0008Ll-86; Mon, 03 Mar 2025 17:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpE4R-0008Hp-Qj
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 17:15:31 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpE4P-0006KS-3Q
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 17:15:31 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpE4J-00000000IEO-1ldn; Mon, 03 Mar 2025 23:15:23 +0100
Message-ID: <1bd9b372-26fa-4023-9198-1052e566c615@maciej.szmigiero.name>
Date: Mon, 3 Mar 2025 23:15:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/36] migration/multifd: Device state transfer support
 - send side
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <b7ab14bee598eef62940a8833455126e62a91c0c.1739994627.git.maciej.szmigiero@oracle.com>
 <d446584d-b22b-43f0-99c6-dd6a2fb58670@nvidia.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <d446584d-b22b-43f0-99c6-dd6a2fb58670@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 2.03.2025 13:46, Avihai Horon wrote:
> 
> On 19/02/2025 22:33, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> A new function multifd_queue_device_state() is provided for device to queue
>> its state for transmission via a multifd channel.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   include/migration/misc.h         |   4 ++
>>   migration/meson.build            |   1 +
>>   migration/multifd-device-state.c | 115 +++++++++++++++++++++++++++++++
>>   migration/multifd-nocomp.c       |  14 +++-
>>   migration/multifd.c              |  42 +++++++++--
>>   migration/multifd.h              |  27 +++++---
>>   6 files changed, 187 insertions(+), 16 deletions(-)
>>   create mode 100644 migration/multifd-device-state.c
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 4c171f4e897e..bd3b725fa0b7 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -118,4 +118,8 @@ bool migrate_is_uri(const char *uri);
>>   bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>>                          Error **errp);
>>
>> +/* migration/multifd-device-state.c */
>> +bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
>> +                                char *data, size_t len);
>> +
>>   #endif
>> diff --git a/migration/meson.build b/migration/meson.build
>> index d3bfe84d6204..9aa48b290e2a 100644
>> --- a/migration/meson.build
>> +++ b/migration/meson.build
>> @@ -25,6 +25,7 @@ system_ss.add(files(
>>     'migration-hmp-cmds.c',
>>     'migration.c',
>>     'multifd.c',
>> +  'multifd-device-state.c',
>>     'multifd-nocomp.c',
>>     'multifd-zlib.c',
>>     'multifd-zero-page.c',
>> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
>> new file mode 100644
>> index 000000000000..ab83773e2d62
>> --- /dev/null
>> +++ b/migration/multifd-device-state.c
>> @@ -0,0 +1,115 @@
>> +/*
>> + * Multifd device state migration
>> + *
>> + * Copyright (C) 2024,2025 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/lockable.h"
>> +#include "migration/misc.h"
>> +#include "multifd.h"
>> +
>> +static struct {
>> +    QemuMutex queue_job_mutex;
>> +
>> +    MultiFDSendData *send_data;
>> +} *multifd_send_device_state;
>> +
>> +size_t multifd_device_state_payload_size(void)
>> +{
>> +    return sizeof(MultiFDDeviceState_t);
>> +}
>> +
>> +void multifd_device_state_send_setup(void)
>> +{
>> +    assert(!multifd_send_device_state);
>> +    multifd_send_device_state = g_malloc(sizeof(*multifd_send_device_state));
>> +
>> +    qemu_mutex_init(&multifd_send_device_state->queue_job_mutex);
>> +
>> +    multifd_send_device_state->send_data = multifd_send_data_alloc();
>> +}
>> +
>> +void multifd_device_state_send_cleanup(void)
>> +{
>> +    g_clear_pointer(&multifd_send_device_state->send_data,
>> +                    multifd_send_data_free);
>> +
>> +    qemu_mutex_destroy(&multifd_send_device_state->queue_job_mutex);
>> +
>> +    g_clear_pointer(&multifd_send_device_state, g_free);
>> +}
>> +
>> +void multifd_send_data_clear_device_state(MultiFDDeviceState_t *device_state)
>> +{
>> +    g_clear_pointer(&device_state->idstr, g_free);
>> +    g_clear_pointer(&device_state->buf, g_free);
>> +}
>> +
>> +static void multifd_device_state_fill_packet(MultiFDSendParams *p)
>> +{
>> +    MultiFDDeviceState_t *device_state = &p->data->u.device_state;
>> +    MultiFDPacketDeviceState_t *packet = p->packet_device_state;
>> +
>> +    packet->hdr.flags = cpu_to_be32(p->flags);
>> +    strncpy(packet->idstr, device_state->idstr, sizeof(packet->idstr));
> 
> (I think we talked about this in v2):
> Looking at idstr creation code, idstr is always NULL terminated. It's also treated everywhere as a NULL terminated string.
> For consistency and to avoid confusion, I'd treat it as a NULL terminated string here too (use strcpy, remove the QEMU_NONSTRING from its definition, etc.).

Changed to NULL-terminated since AFAIK RAM idstr was also changed to such
in the meantime.

> This will also avoid strncpy() unnecessary zeroing of the extra bytes.

Zeroing of remaining space is still necessary since it's a wire packet
data structure that's re-used between packets so it still can contain
remainder of previous longer idstr.
  
> Thanks.
> 

Thanks,
Maciej


