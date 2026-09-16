Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBF2C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6iw9-00037K-3o; Wed, 16 Sep 2026 02:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6iw6-00036b-PF
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 02:16:02 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6iw4-0002cj-AZ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 02:16:02 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1224:0:640:741a:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 24AFC807F3;
 Wed, 16 Sep 2026 09:15:54 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c22::1:38] (unknown
 [2a02:6bf:8080:c22::1:38])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id qFOprr1Xa0U0-csnyi0hI; Wed, 16 Sep 2026 09:15:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789539353;
 bh=DQLAqCpJc7GtDr2vMco3fpP9Bku45oCCZC6VSigiyn0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=B/8syF1izzZlL+KWnm49fd1ub9NyvLF/u8+jAcWslZ8VH0P4usAR65FhZhUeW+hmy
 FAEPYSdn3F5yO4bnVUnZmwcANVsVGLNFlqWXJkdP8P6YP5HNiKr10OxM9HfuhSKakO
 CMzs6xCV/LABjB4jUzEYDOXiic+AMFyaYSY/qEhI=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <603c0809-d21d-4a00-abdb-2d2f63e208e3@yandex-team.ru>
Date: Wed, 16 Sep 2026 09:15:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] virtio-net: live-TAP local migration follow-up
To: mst@redhat.com, Jason Wang <jasowangio@gmail.com>
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, peterx@redhat.com,
 farosas@suse.de, qemu-devel@nongnu.org
References: <20260914175351.393680-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260914175351.393680-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

[add new Jason's address]

On 14.09.26 20:53, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Here is a test (with some fixes and changes, so r-b dropped),
> and several small fixes to recently merged live-TAP local migration
> series.
> 
> Vladimir Sementsov-Ogievskiy (5):
>    tests/functional: add test_tap_migration
>    net/tap: tap_post_load(): poll only on success
>    hw/net: finish backend initialization earler for local migration
>    net/tap: move vmstate initialization to new_tap()
>    net/tap: net_init_tap_one(): fix failure path
> 
>   hw/net/virtio-net.c                           |  40 +-
>   net/tap.c                                     |  11 +-
>   tests/functional/x86_64/meson.build           |   1 +
>   tests/functional/x86_64/test_tap_migration.py | 425 ++++++++++++++++++
>   4 files changed, 448 insertions(+), 29 deletions(-)
>   create mode 100755 tests/functional/x86_64/test_tap_migration.py
> 


-- 
Best regards,
Vladimir

