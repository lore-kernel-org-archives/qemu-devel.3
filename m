Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C30BCF3962
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 20:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srNJ8-0005si-Tl; Thu, 19 Sep 2024 15:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1srNJ6-0005ko-Uc
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 15:59:16 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1srNJ4-0008Or-Pr
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 15:59:16 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1srNIx-0000hA-3f; Thu, 19 Sep 2024 21:59:07 +0200
Message-ID: <56beb3a5-7f14-4d80-b1dc-a53db5640c33@maciej.szmigiero.name>
Date: Thu, 19 Sep 2024 21:59:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/17] migration/multifd: Device state transfer support
 - receive side
To: Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <84141182083a8417c25b4d82a9c4b6228b22ac67.1724701542.git.maciej.szmigiero@oracle.com>
 <2a9d1c5d-6453-4b33-99cd-824f0002e305@nvidia.com>
 <c042036e-ff01-4adf-b9a6-090660887a2e@maciej.szmigiero.name>
 <31954a8f-5182-49b4-9514-2839aaef77a3@nvidia.com> <87ttelvv1y.fsf@suse.de>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <87ttelvv1y.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On 12.09.2024 15:52, Fabiano Rosas wrote:
> Avihai Horon <avihaih@nvidia.com> writes:
> 
>> On 09/09/2024 21:05, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 5.09.2024 18:47, Avihai Horon wrote:
>>>>
>>>> On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>
>>>>> Add a basic support for receiving device state via multifd channels -
>>>>> channels that are shared with RAM transfers.
>>>>>
>>>>> To differentiate between a device state and a RAM packet the packet
>>>>> header is read first.
>>>>>
>>>>> Depending whether MULTIFD_FLAG_DEVICE_STATE flag is present or not
>>>>> in the
>>>>> packet header either device state (MultiFDPacketDeviceState_t) or RAM
>>>>> data (existing MultiFDPacket_t) is then read.
>>>>>
>>>>> The received device state data is provided to
>>>>> qemu_loadvm_load_state_buffer() function for processing in the
>>>>> device's load_state_buffer handler.
>>>>>
>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>> ---
>>>>>    migration/multifd.c | 127
>>>>> +++++++++++++++++++++++++++++++++++++-------
>>>>>    migration/multifd.h |  31 ++++++++++-
>>>>>    2 files changed, 138 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/migration/multifd.c b/migration/multifd.c
>>>>> index b06a9fab500e..d5a8e5a9c9b5 100644
>>>>> --- a/migration/multifd.c
>>>>> +++ b/migration/multifd.c
>>>>> @@ -21,6 +21,7 @@
>>>>>    #include "file.h"
>>>>>    #include "migration.h"
>>>>>    #include "migration-stats.h"
>>>>> +#include "savevm.h"
>>>>>    #include "socket.h"
>>>>>    #include "tls.h"
>>>>>    #include "qemu-file.h"
>>>>> @@ -209,10 +210,10 @@ void
>>>>> multifd_send_fill_packet(MultiFDSendParams *p)
>>>>>
>>>>>        memset(packet, 0, p->packet_len);
>>>>>
>>>>> -    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
>>>>> -    packet->version = cpu_to_be32(MULTIFD_VERSION);
>>>>> +    packet->hdr.magic = cpu_to_be32(MULTIFD_MAGIC);
>>>>> +    packet->hdr.version = cpu_to_be32(MULTIFD_VERSION);
>>>>>
>>>>> -    packet->flags = cpu_to_be32(p->flags);
>>>>> +    packet->hdr.flags = cpu_to_be32(p->flags);
>>>>>        packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>>>>>
>>>>>        packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
>>>>> @@ -228,31 +229,49 @@ void
>>>>> multifd_send_fill_packet(MultiFDSendParams *p)
>>>>>                                p->flags, p->next_packet_size);
>>>>>    }
>>>>>
>>>>> -static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error
>>>>> **errp)
>>>>> +static int multifd_recv_unfill_packet_header(MultiFDRecvParams *p,
>>>>> + MultiFDPacketHdr_t *hdr,
>>>>> +                                             Error **errp)
>>>>>    {
>>>>> -    MultiFDPacket_t *packet = p->packet;
>>>>> -    int ret = 0;
>>>>> -
>>>>> -    packet->magic = be32_to_cpu(packet->magic);
>>>>> -    if (packet->magic != MULTIFD_MAGIC) {
>>>>> +    hdr->magic = be32_to_cpu(hdr->magic);
>>>>> +    if (hdr->magic != MULTIFD_MAGIC) {
>>>>>            error_setg(errp, "multifd: received packet "
>>>>>                       "magic %x and expected magic %x",
>>>>> -                   packet->magic, MULTIFD_MAGIC);
>>>>> +                   hdr->magic, MULTIFD_MAGIC);
>>>>>            return -1;
>>>>>        }
>>>>>
>>>>> -    packet->version = be32_to_cpu(packet->version);
>>>>> -    if (packet->version != MULTIFD_VERSION) {
>>>>> +    hdr->version = be32_to_cpu(hdr->version);
>>>>> +    if (hdr->version != MULTIFD_VERSION) {
>>>>>            error_setg(errp, "multifd: received packet "
>>>>>                       "version %u and expected version %u",
>>>>> -                   packet->version, MULTIFD_VERSION);
>>>>> +                   hdr->version, MULTIFD_VERSION);
>>>>>            return -1;
>>>>>        }
>>>>>
>>>>> -    p->flags = be32_to_cpu(packet->flags);
>>>>> +    p->flags = be32_to_cpu(hdr->flags);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int
>>>>> multifd_recv_unfill_packet_device_state(MultiFDRecvParams *p,
>>>>> +                                                   Error **errp)
>>>>> +{
>>>>> +    MultiFDPacketDeviceState_t *packet = p->packet_dev_state;
>>>>> +
>>>>> +    packet->instance_id = be32_to_cpu(packet->instance_id);
>>>>> +    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int multifd_recv_unfill_packet_ram(MultiFDRecvParams *p,
>>>>> Error **errp)
>>>>> +{
>>>>> +    MultiFDPacket_t *packet = p->packet;
>>>>> +    int ret = 0;
>>>>> +
>>>>>        p->next_packet_size = be32_to_cpu(packet->next_packet_size);
>>>>>        p->packet_num = be64_to_cpu(packet->packet_num);
>>>>> -    p->packets_recved++;
>>>>>
>>>>>        if (!(p->flags & MULTIFD_FLAG_SYNC)) {
>>>>>            ret = multifd_ram_unfill_packet(p, errp);
>>>>> @@ -264,6 +283,19 @@ static int
>>>>> multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>>>>        return ret;
>>>>>    }
>>>>>
>>>>> +static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error
>>>>> **errp)
>>>>> +{
>>>>> +    p->packets_recved++;
>>>>> +
>>>>> +    if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
>>>>> +        return multifd_recv_unfill_packet_device_state(p, errp);
>>>>> +    } else {
>>>>> +        return multifd_recv_unfill_packet_ram(p, errp);
>>>>> +    }
>>>>> +
>>>>> +    g_assert_not_reached();
>>>>
>>>> We can drop the assert and the "else":
>>>> if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
>>>>       return multifd_recv_unfill_packet_device_state(p, errp);
>>>> }
>>>>
>>>> return multifd_recv_unfill_packet_ram(p, errp);
>>>
>>> Ack.
>>>
>>>>> +}
>>>>> +
>>>>>    static bool multifd_send_should_exit(void)
>>>>>    {
>>>>>        return qatomic_read(&multifd_send_state->exiting);
>>>>> diff --git a/migration/multifd.h b/migration/multifd.h
>>>>> index a3e35196d179..a8f3e4838c01 100644
>>>>> --- a/migration/multifd.h
>>>>> +++ b/migration/multifd.h
>>>>> @@ -45,6 +45,12 @@ MultiFDRecvData *multifd_get_recv_data(void);
>>>>>    #define MULTIFD_FLAG_QPL (4 << 1)
>>>>>    #define MULTIFD_FLAG_UADK (8 << 1)
>>>>>
>>>>> +/*
>>>>> + * If set it means that this packet contains device state
>>>>> + * (MultiFDPacketDeviceState_t), not RAM data (MultiFDPacket_t).
>>>>> + */
>>>>> +#define MULTIFD_FLAG_DEVICE_STATE (1 << 4)
>>>>> +
>>>>>    /* This value needs to be a multiple of qemu_target_page_size() */
>>>>>    #define MULTIFD_PACKET_SIZE (512 * 1024)
>>>>>
>>>>> @@ -52,6 +58,11 @@ typedef struct {
>>>>>        uint32_t magic;
>>>>>        uint32_t version;
>>>>>        uint32_t flags;
>>>>> +} __attribute__((packed)) MultiFDPacketHdr_t;
>>>>
>>>> Maybe split this patch into two: one that adds the packet header
>>>> concept and another that adds the new device packet?
>>>
>>> Can do.
>>>
>>>>> +
>>>>> +typedef struct {
>>>>> +    MultiFDPacketHdr_t hdr;
>>>>> +
>>>>>        /* maximum number of allocated pages */
>>>>>        uint32_t pages_alloc;
>>>>>        /* non zero pages */
>>>>> @@ -72,6 +83,16 @@ typedef struct {
>>>>>        uint64_t offset[];
>>>>>    } __attribute__((packed)) MultiFDPacket_t;
>>>>>
>>>>> +typedef struct {
>>>>> +    MultiFDPacketHdr_t hdr;
>>>>> +
>>>>> +    char idstr[256] QEMU_NONSTRING;
>>>>
>>>> idstr should be null terminated, or am I missing something?
>>>
>>> There's no need to always NULL-terminate a constant-size field,
>>> since the strncpy() already stops at the field size, so we can
>>> gain another byte for actual string use this way.
>>>
>>> RAM block idstr also uses the same "trick":
>>>> void multifd_ram_fill_packet(MultiFDSendParams *p):
>>>> strncpy(packet->ramblock, pages->block->idstr, 256);
>>>
>> But can idstr actually be 256 bytes long without null byte?
>> There are a lot of places where idstr is a parameter for functions that
>> expect null terminated string and it is also printed as such.
> 
> Yeah, and I actually don't see the "trick" being used in
> RAMBlock. Anyway, it's best to null terminate to be more predictable. We
> also had Coverity reports about similar things:
> 
> https://lore.kernel.org/r/CAFEAcA_F2qrSAacY=V5Hez1qFGuNW0-XqL2LQ=Y_UKYuHEJWhw@mail.gmail.com

That's because MultiFDPacket_t::ramblock is missing QEMU_NONSTRING
annotation (like the proposed MultiFDPacketDeviceState_t::idstr has)
so Coverity assumes it was meant to be a NULL-terminated C-string.

> I haven't got the time to send that patch yet.

Thanks,
Maciej


