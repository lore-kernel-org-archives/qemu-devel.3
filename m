Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D2AE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 21:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJfd5-0001Vs-7S; Fri, 06 Dec 2024 16:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tJfcy-0001Fh-6b
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 16:12:46 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tJfcq-0000WX-Mp
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 16:12:39 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tJfcn-00000003Mwd-0DYE; Fri, 06 Dec 2024 22:12:33 +0100
Message-ID: <454ab654-634c-4286-87f8-6379aa6fa27c@maciej.szmigiero.name>
Date: Fri, 6 Dec 2024 22:12:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/24] migration/multifd: Device state transfer support
 - receive side
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <8679a04fda669b0e8f0e3b8c598aa4a58a67de40.1731773021.git.maciej.szmigiero@oracle.com>
 <Z1HPf850jFdBD9IS@x1n>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <Z1HPf850jFdBD9IS@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 5.12.2024 17:06, Peter Xu wrote:
> On Sun, Nov 17, 2024 at 08:20:05PM +0100, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Add a basic support for receiving device state via multifd channels -
>> channels that are shared with RAM transfers.
>>
>> Depending whether MULTIFD_FLAG_DEVICE_STATE flag is present or not in the
>> packet header either device state (MultiFDPacketDeviceState_t) or RAM
>> data (existing MultiFDPacket_t) is read.
>>
>> The received device state data is provided to
>> qemu_loadvm_load_state_buffer() function for processing in the
>> device's load_state_buffer handler.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Only a few nitpicks:
> 
>> ---
>>   migration/multifd.c | 87 +++++++++++++++++++++++++++++++++++++++++----
>>   migration/multifd.h | 26 +++++++++++++-
>>   2 files changed, 105 insertions(+), 8 deletions(-)
>>
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index 999b88b7ebcb..9578a985449b 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -21,6 +21,7 @@
>>   #include "file.h"
>>   #include "migration.h"
>>   #include "migration-stats.h"
>> +#include "savevm.h"
>>   #include "socket.h"
>>   #include "tls.h"
>>   #include "qemu-file.h"
>> @@ -252,14 +253,24 @@ static int multifd_recv_unfill_packet_header(MultiFDRecvParams *p,
>>       return 0;
>>   }
>>   
>> -static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>> +static int multifd_recv_unfill_packet_device_state(MultiFDRecvParams *p,
>> +                                                   Error **errp)
>> +{
>> +    MultiFDPacketDeviceState_t *packet = p->packet_dev_state;
>> +
>> +    packet->instance_id = be32_to_cpu(packet->instance_id);
>> +    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
>> +
>> +    return 0;
>> +}
>> +
>> +static int multifd_recv_unfill_packet_ram(MultiFDRecvParams *p, Error **errp)
>>   {
>>       const MultiFDPacket_t *packet = p->packet;
>>       int ret = 0;
>>   
>>       p->next_packet_size = be32_to_cpu(packet->next_packet_size);
>>       p->packet_num = be64_to_cpu(packet->packet_num);
>> -    p->packets_recved++;
>>   
>>       if (!(p->flags & MULTIFD_FLAG_SYNC)) {
>>           ret = multifd_ram_unfill_packet(p, errp);
>> @@ -271,6 +282,17 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>       return ret;
>>   }
>>   
>> +static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>> +{
>> +    p->packets_recved++;
>> +
>> +    if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
>> +        return multifd_recv_unfill_packet_device_state(p, errp);
>> +    }
>> +
>> +    return multifd_recv_unfill_packet_ram(p, errp);
>> +}
>> +
>>   static bool multifd_send_should_exit(void)
>>   {
>>       return qatomic_read(&multifd_send_state->exiting);
>> @@ -1023,6 +1045,7 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
>>       p->packet_len = 0;
>>       g_free(p->packet);
>>       p->packet = NULL;
>> +    g_clear_pointer(&p->packet_dev_state, g_free);
>>       g_free(p->normal);
>>       p->normal = NULL;
>>       g_free(p->zero);
>> @@ -1124,6 +1147,28 @@ void multifd_recv_sync_main(void)
>>       trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
>>   }
>>   
>> +static int multifd_device_state_recv(MultiFDRecvParams *p, Error **errp)
>> +{
>> +    g_autofree char *idstr = NULL;
>> +    g_autofree char *dev_state_buf = NULL;
>> +    int ret;
>> +
>> +    dev_state_buf = g_malloc(p->next_packet_size);
>> +
>> +    ret = qio_channel_read_all(p->c, dev_state_buf, p->next_packet_size, errp);
>> +    if (ret != 0) {
>> +        return ret;
>> +    }
>> +
>> +    idstr = g_strndup(p->packet_dev_state->idstr,
>> +                      sizeof(p->packet_dev_state->idstr));
>> +
>> +    return qemu_loadvm_load_state_buffer(idstr,
>> +                                         p->packet_dev_state->instance_id,
>> +                                         dev_state_buf, p->next_packet_size,
>> +                                         errp);
>> +}
>> +
>>   static void *multifd_recv_thread(void *opaque)
>>   {
>>       MultiFDRecvParams *p = opaque;
>> @@ -1137,6 +1182,7 @@ static void *multifd_recv_thread(void *opaque)
>>       while (true) {
>>           MultiFDPacketHdr_t hdr;
>>           uint32_t flags = 0;
>> +        bool is_device_state = false;
>>           bool has_data = false;
>>           uint8_t *pkt_buf;
>>           size_t pkt_len;
>> @@ -1159,8 +1205,14 @@ static void *multifd_recv_thread(void *opaque)
>>                   break;
>>               }
>>   
>> -            pkt_buf = (uint8_t *)p->packet + sizeof(hdr);
>> -            pkt_len = p->packet_len - sizeof(hdr);
>> +            is_device_state = p->flags & MULTIFD_FLAG_DEVICE_STATE;
>> +            if (is_device_state) {
>> +                pkt_buf = (uint8_t *)p->packet_dev_state + sizeof(hdr);
>> +                pkt_len = sizeof(*p->packet_dev_state) - sizeof(hdr);
>> +            } else {
>> +                pkt_buf = (uint8_t *)p->packet + sizeof(hdr);
>> +                pkt_len = p->packet_len - sizeof(hdr);
>> +            }
>>   
>>               ret = qio_channel_read_all_eof(p->c, (char *)pkt_buf, pkt_len,
>>                                              &local_err);
>> @@ -1178,9 +1230,14 @@ static void *multifd_recv_thread(void *opaque)
>>               flags = p->flags;
>>               /* recv methods don't know how to handle the SYNC flag */
>>               p->flags &= ~MULTIFD_FLAG_SYNC;
>> -            if (!(flags & MULTIFD_FLAG_SYNC)) {
>> -                has_data = p->normal_num || p->zero_num;
>> +
>> +            if (is_device_state) {
>> +                has_data = p->next_packet_size > 0;
>> +            } else {
>> +                has_data = !(flags & MULTIFD_FLAG_SYNC) &&
>> +                    (p->normal_num || p->zero_num);
>>               }
>> +
>>               qemu_mutex_unlock(&p->mutex);
>>           } else {
>>               /*
>> @@ -1209,14 +1266,29 @@ static void *multifd_recv_thread(void *opaque)
>>           }
>>   
>>           if (has_data) {
>> -            ret = multifd_recv_state->ops->recv(p, &local_err);
>> +            if (is_device_state) {
>> +                assert(use_packets);
>> +                ret = multifd_device_state_recv(p, &local_err);
>> +            } else {
>> +                ret = multifd_recv_state->ops->recv(p, &local_err);
>> +            }
>>               if (ret != 0) {
>>                   break;
>>               }
>> +        } else if (is_device_state) {
>> +            error_setg(&local_err,
>> +                       "multifd: received empty device state packet");
>> +            break;
> 
> You used assert anyway elsewhere, and this also smells like programming
> error.  We could stick with assert above and reduce "if / elif ...":
> 
>      if (is_device_state) {
>          assert(p->next_packet_size > 0);
>          has_data = true;
>      }
> 
> Then drop else if.

It's not necessarily a programming error, but rather a problem with the
received bit stream or its incompatibility with the receiving QEMU version.

So I think returning an error is more appropriate than triggering
an assert() failure for that.

>>           }
>>   
>>           if (use_packets) {
>>               if (flags & MULTIFD_FLAG_SYNC) {
>> +                if (is_device_state) {
>> +                    error_setg(&local_err,
>> +                               "multifd: received SYNC device state packet");
>> +                    break;
>> +                }
> 
> Same here. I'd use assert().
> 

Same here :) - the sender sent us possibly wrong packet or packet of
incompatible version, we should handle this gracefully rather than
assert()/abort() QEMU.

Thanks,
Maciej


