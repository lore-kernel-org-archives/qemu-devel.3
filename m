Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9414CC83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 14:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZW5s-0000nF-8x; Wed, 09 Jul 2025 10:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uZW1F-0006w2-Uw
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 10:43:37 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uZW15-0004hT-Ru
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 10:43:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:3c8c:0:640:20c:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id BF68A60A61;
 Wed,  9 Jul 2025 17:43:18 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:868::1:7] (unknown [2a02:6bf:8080:868::1:7])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IhjlaR0GsGk0-8ql8cUaJ; Wed, 09 Jul 2025 17:43:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1752072198;
 bh=jYbrr8P4UjTiVkrgiAGAmOKp7+ZRhttcoka31KkLbx8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BlLOaY8ZpLXTYCsG2aifDWpAG62+q4QnywH4y2XjjVRsMiyoa+KZU0CvZPR7lHPKG
 4giepSnwDRE6i2GboWAq+CfGx2kgyBs8anVRM1yaXjabjXbnGEK9Q0zPokPnXYTr2y
 WTfjMZyFZ/5no8HMmmZCokQeykZZ/kk2hbtydIi0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <40114688-ffc6-4f33-9928-a383d69c9320@yandex-team.ru>
Date: Wed, 9 Jul 2025 17:43:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tap: drop too small packets
To: Jason Wang <jasowang@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: qemu-devel@nongnu.org
References: <20250703105508.2380494-1-vsementsov@yandex-team.ru>
 <d7a66374-12d3-4b4b-975f-90202d83cbdf@yandex-team.ru>
 <CACGkMEv8rvoDS3PHKjBQeA4qi35BVZF0__FP04EwEeM3frPUnw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEv8rvoDS3PHKjBQeA4qi35BVZF0__FP04EwEeM3frPUnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 07.07.25 06:49, Jason Wang wrote:
> On Thu, Jul 3, 2025 at 10:59 PM Daniil Tatianin
> <d-tatianin@yandex-team.ru> wrote:
>>
>> On 7/3/25 1:55 PM, Vladimir Sementsov-Ogievskiy wrote:
>>
>>> Theoretically tap_read_packet() may return size less than
>>> s->host_vnet_hdr_len, and next, we'll work with negative size
>>> (in case of !s->using_vnet_hdr). Let's avoid it.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>    net/tap.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/net/tap.c b/net/tap.c
>>> index ae1c7e39832..20d0dc2eb35 100644
>>> --- a/net/tap.c
>>> +++ b/net/tap.c
>>> @@ -172,6 +172,11 @@ static void tap_send(void *opaque)
>>>                break;
>>>            }
>>>
>>> +        if (s->host_vnet_hdr_len && size < s->host_vnet_hdr_len) {

Should it be better to s/</<=/ here? To skip size == s->host_vnet_hdr_len as well?

>>> +            /* Invalid packet */
>>> +            break;
>>> +        }
>>> +
>>>            if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
>>>                buf  += s->host_vnet_hdr_len;
>>>                size -= s->host_vnet_hdr_len;
>>
>> Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> 
> Queued.
> 
> Thanks
> 
>>
>>
> 

-- 
Best regards,
Vladimir


