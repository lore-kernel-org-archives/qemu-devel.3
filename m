Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE951C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfK6o-00050H-9T; Tue, 04 Feb 2025 09:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tfK6m-0004yF-KJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:41:00 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tfK6k-0003Qc-Rv
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:41:00 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tfK6g-00000006qtE-2549; Tue, 04 Feb 2025 15:40:54 +0100
Message-ID: <c2e18a90-858f-45c6-b5e4-62b1f56f5f01@maciej.szmigiero.name>
Date: Tue, 4 Feb 2025 15:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/33] migration/multifd: Device state transfer support
 - receive side
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <654768fd717b0def70906bf7adfd6739cfd2ecf3.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6E03MMQqTDNFsnX@x1.local>
 <c80c298c-b838-4ea3-8b72-48ca8bf6cb44@maciej.szmigiero.name>
 <Z6FKOKrKZpSmzf68@x1.local>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <Z6FKOKrKZpSmzf68@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.07, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 3.02.2025 23:59, Peter Xu wrote:
> On Mon, Feb 03, 2025 at 11:18:11PM +0100, Maciej S. Szmigiero wrote:
>> On 3.02.2025 22:27, Peter Xu wrote:
>>> On Thu, Jan 30, 2025 at 11:08:34AM +0100, Maciej S. Szmigiero wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Add a basic support for receiving device state via multifd channels -
>>>> channels that are shared with RAM transfers.
>>>>
>>>> Depending whether MULTIFD_FLAG_DEVICE_STATE flag is present or not in the
>>>> packet header either device state (MultiFDPacketDeviceState_t) or RAM
>>>> data (existing MultiFDPacket_t) is read.
>>>>
>>>> The received device state data is provided to
>>>> qemu_loadvm_load_state_buffer() function for processing in the
>>>> device's load_state_buffer handler.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>
>>> I think I acked this one.  You could keep my R-b if...
>>>
>>> [...]
>>>
>>>> diff --git a/migration/multifd.h b/migration/multifd.h
>>>> index 9e4baa066312..abf3acdcee40 100644
>>>> --- a/migration/multifd.h
>>>> +++ b/migration/multifd.h
>>>> @@ -62,6 +62,12 @@ MultiFDRecvData *multifd_get_recv_data(void);
>>>>    #define MULTIFD_FLAG_UADK (8 << 1)
>>>>    #define MULTIFD_FLAG_QATZIP (16 << 1)
>>>> +/*
>>>> + * If set it means that this packet contains device state
>>>> + * (MultiFDPacketDeviceState_t), not RAM data (MultiFDPacket_t).
>>>> + */
>>>> +#define MULTIFD_FLAG_DEVICE_STATE (1 << 6)
>>>
>>> ... if this won't conflict with MULTIFD_FLAG_QATZIP.
>>
>> Hmm, isn't (16 << 1) = 32 while (1 << 6) = 64?
> 
> Oops. :)
> 
>>> I think we should stick with one way to write it, then when rebase you can
>>> see such conflicts - either your patch uses 32 << 1, or perhaps we should
>>> start to switch to BIT() for all above instead..
> 
> Still, do you mind switch to "32 << 1" (or use BIT())?

I will switch to 32 << 1 for consistency with the compression flags
above.
  > With either, feel free to take:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 

Thanks,
Maciej


