Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EB6CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwGS-00022A-KY; Mon, 18 May 2026 07:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wOwGR-00021U-CS
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:36:03 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wOwGP-00073M-Hp
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:36:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 62B2CC01D4;
 Mon, 18 May 2026 14:35:59 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b95::1:20] (unknown
 [2a02:6bf:8080:b95::1:20])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id wZOhgV3KleA0-letYSqat; Mon, 18 May 2026 14:35:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779104158;
 bh=0abCbUwwzLjFU6gNdhBuoDgphm3rxmERneLmEoxD65g=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VrnoDZE7qIw8AYHqCcP6NCplLekL/1PiHe5zI1kTy7VseQbeVO/QZDM24s7WuUy7H
 lkGul0Wmvo1nAgMaX4VGDXH+3D4nZDvKWOM/TjT7xq6S+42jJd5wkdedlsgly9Ah9t
 soR3nzDbXrvrDs6tl5f547+sZsJdu/dyYhLPhsdE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d60b5b69-7c0b-4a49-98ac-7d826b6fce54@yandex-team.ru>
Date: Mon, 18 May 2026 14:35:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/8] virtio-net: live-TAP local migration
To: jasowang@redhat.com, mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru
References: <20260420193846.675844-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260420193846.675844-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

ping

On 20.04.26 22:38, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Here is a new migration parameter "local", which allows to
> enable local migration of TAP virtio-net backend (and maybe other
> devices and backends in future), including its properties and open
> fds.
> 
> With this new option, management software doesn't need to initialize
> new TAP and do a switch to it. Nothing should be done around
> virtio-net in local migration: it just migrates and continues to use
> same TAP device. So we avoid extra logic in management software, extra
> allocations in kernel (for new TAP), and corresponding extra delay in
> migration downtime.
> 
> v15:
> 03: add a-b by Peter
> 05: rebase on master, fix compat property to be part of 11.0
> 
> v15 pushed as branch up-tap-fd-migration-with-bk-opt
>      at https://gitlab.com/vsementsov/qemu.git
> 
> Based-on: <20260318113144.15697-1-vsementsov@yandex-team.ru>
>     "[PATCH v4 00/13] net: refactoring and fixes"
> 
> Vladimir Sementsov-Ogievskiy (8):
>    net/tap: move vhost-net open() calls to tap_parse_vhost_fds()
>    net/tap: move vhost initialization to tap_setup_vhost()
>    qapi: add local migration parameter
>    net: introduce vmstate_net_peer_backend
>    virtio-net: support local migration of backend
>    net/tap: support local migration with virtio-net
>    tests/functional: add skipWithoutSudo() decorator
>    tests/functional: add test_tap_migration
> 
>   hw/core/machine.c                             |   5 +
>   hw/i386/pc_q35.c                              |   1 +
>   hw/net/virtio-net.c                           | 137 +++++-
>   include/hw/core/boards.h                      |   3 +
>   include/hw/virtio/virtio-net.h                |   2 +
>   include/migration/misc.h                      |   2 +
>   include/net/net.h                             |   6 +
>   migration/options.c                           |  18 +-
>   net/net.c                                     |  47 ++
>   net/tap.c                                     | 246 ++++++++--
>   qapi/migration.json                           |  12 +-
>   qapi/net.json                                 |  10 +-
>   tests/functional/qemu_test/decorators.py      |  16 +
>   tests/functional/x86_64/meson.build           |   1 +
>   tests/functional/x86_64/test_tap_migration.py | 456 ++++++++++++++++++
>   15 files changed, 911 insertions(+), 51 deletions(-)
>   create mode 100755 tests/functional/x86_64/test_tap_migration.py
> 


-- 
Best regards,
Vladimir

