Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3363C87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 08:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiUKA-0006DR-QY; Sun, 03 Aug 2025 04:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uiTIa-00082q-Rd
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 03:38:29 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uiTIW-000791-VN
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 03:38:28 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5737cJBv082033
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 3 Aug 2025 16:38:19 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=4oDxUTmXRj9gs8U3FTb45VwrA4HfBUwXWUclIMT3Hrw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754206699; v=1;
 b=n5nZhwAsb1zi3cePfPPKw75TXZNAhXvM67fsRcst949q0o41wSJ2wSOgpgOfZLzf
 Leir0o6nysbWkxDlvUmw4kJexxM93IsFaGsmL0uSU++Og+KfldY2nYoe7gE8J7Fb
 qTyuSgCcR2PnWISpo3ybjymg/EVToski1NMS3jcB0nUhbgEJqLnak5MWm0kOVLiy
 MCIjNWqTzvBxAsFpfmzPpD58EhgNXcu2q45x0GnK80M7IF6pRsedD96zkcvuw96t
 1XMCKWBpIGgqepSxzzEImu+d3R+hgdntURq2c+o7z4sK6PVkpXt8jhmg7L+awmnV
 5u6ODl+h4rRiTNFtk7sYTw==
Message-ID: <1904c947-151b-46bb-bc66-109d258c18df@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 3 Aug 2025 16:38:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio-net: make VirtIONet.vlans an array instead of
 a pointer
To: Michael Tokarev <mjt@tls.msk.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20250802142115.41638-1-mjt@tls.msk.ru>
 <4eff3371-542c-43bc-a4aa-e58ceb369d1e@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <4eff3371-542c-43bc-a4aa-e58ceb369d1e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/02 23:45, Michael Tokarev wrote:
> On 02.08.2025 17:21, Michael Tokarev wrote:
>> This field is a fixed-size buffer (number of elements is MAX_VLAN,
>> known at build time).  There's no need to allocate it dynamically,
>> it can be made an integral part of VirtIONet structure.
>>
>> This field is the only user of VMSTATE_BUFFER_POINTER_UNSAFE() macro.
>>
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
>>   hw/net/virtio-net.c            | 8 +++-----
>>   include/hw/virtio/virtio-net.h | 2 +-
>>   2 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> @@ -3524,7 +3524,7 @@ static const VMStateDescription 
>> vmstate_virtio_net_device = {
>>            * buffer; hold onto your endiannesses; it's actually used 
>> as a bitmap
>>            * but based on the uint.
>>            */
>> -        VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN 
>> >> 3),
>> +        VMSTATE_BUFFER(vlans, VirtIONet),
> 
> This doesn't compile.  And I can't figure out, so far, what's needed
> here :)

The type check is failing because VMSTATE_BUFFER() expects an array of 
uint8_t but it is an array of uint32_t.

Now I get why it used an "UNSAFE" macro. We should usually use 
VMSTATE_UINT32_ARRAY() instead, but we need "BUFFER" for compatibility, 
so it needed the "UNSAFE" variant to disable the type check.

Fortunately there is a variant that is "BUFFER" and "UNSAFE" but not 
"POINTER". So this should be:
VMSTATE_BUFFER_UNSAFE(vlans, VirtIONet, 0,
                       sizeof(typeof_field(VirtIONet, vlans)))

