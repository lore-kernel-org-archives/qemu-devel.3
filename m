Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex-team.ru header.i=@yandex-team.ru header.a=rsa-sha256 header.s=default header.b=bDUz2J8L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJpT6-0000lp-S3; Thu, 22 Oct 2026 05:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xJpT4-0000lK-D2
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:52:14 -0400
Received: from forwardcorp2e.mail.yandex.net ([2a02:6b8:c32:0:1:45:d181:df02])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xJpT1-00030G-TD
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:52:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.yp-c.yandex.net)
 by forwardcorp2e.mail.yandex.net (postfix) with ESMTPS id 64BC1C0057;
 Thu, 22 Oct 2026 12:52:03 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b37::1:16]
 by mail-nwsmtp-smtp-corp-main-66 with ESMTPSA id 2qYTEv4ZVOs0-nd9gVR4f;
 Thu, 22 Oct 2026 12:52:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792662722;
 bh=kly2AhVW2SyzAuP1t8q/4LWHhRobjgmIw1eecBQOMcg=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=bDUz2J8Lg0lz8ZCzlMDTR6thg+56XXBp0J6gTY4WrFzI4WCw3+IS1FSbGxTb12Nka
 PtEBqpKWClwiP4s0DclkKmZwV0aXaaWDp555QLoJ0scEKSNKZKWSGYAH0+v8k6JHKC
 fEUvzQmFgxN1fAsAv6n3SF6TRdJBYzrogmchjC3k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <565d40e3-d3e1-46b6-9d70-eb121a2863d5@yandex-team.ru>
Date: Thu, 22 Oct 2026 12:52:02 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] virtio-net: live-TAP local migration follow-up
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, Jason Wang <jasowangio@gmail.com>
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, peterx@redhat.com,
 farosas@suse.de, qemu-devel@nongnu.org
References: <20260914175351.393680-1-vsementsov@yandex-team.ru>
 <603c0809-d21d-4a00-abdb-2d2f63e208e3@yandex-team.ru>
 <76177f9f-a67f-412e-a38d-d1110b95320d@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <76177f9f-a67f-412e-a38d-d1110b95320d@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c32:0:1:45:d181:df02;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp2e.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06.10.26 13:01, Vladimir Sementsov-Ogievskiy wrote:
> ping
> 
> On 16.09.26 09:15, Vladimir Sementsov-Ogievskiy wrote:
>> [add new Jason's address]
>>
>> On 14.09.26 20:53, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> Here is a test (with some fixes and changes, so r-b dropped),
>>> and several small fixes to recently merged live-TAP local migration
>>> series.
>>>
>>> Vladimir Sementsov-Ogievskiy (5):
>>>    tests/functional: add test_tap_migration
>>>    net/tap: tap_post_load(): poll only on success
>>>    hw/net: finish backend initialization earler for local migration
>>>    net/tap: move vmstate initialization to new_tap()
>>>    net/tap: net_init_tap_one(): fix failure path
>>>
>>>   hw/net/virtio-net.c                           |  40 +-
>>>   net/tap.c                                     |  11 +-
>>>   tests/functional/x86_64/meson.build           |   1 +
>>>   tests/functional/x86_64/test_tap_migration.py | 425 ++++++++++++++++++
>>>   4 files changed, 448 insertions(+), 29 deletions(-)
>>>   create mode 100755 tests/functional/x86_64/test_tap_migration.py
>>>
>>
>>
> 
> 
ping

-- 
Best regards,
Vladimir

