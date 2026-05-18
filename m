Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA33ACD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwEq-0007yK-Hp; Mon, 18 May 2026 07:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wOwEn-0007y3-Tz
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:34:22 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wOwEj-0005dP-Kk
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:34:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 58782C01E9;
 Mon, 18 May 2026 14:34:09 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b95::1:20] (unknown
 [2a02:6bf:8080:b95::1:20])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 8YOHfV3KkW20-OKE6n4QD; Mon, 18 May 2026 14:34:08 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779104048;
 bh=nSClXN3eXG42yD3LkmTJnlXbZjK5kftqnjRWlDJK4cY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0AY3m71RuCMHYhgbEPYuLwzSBfMt64KhMAjZJifjykcgbGxUkwlnLdnc5DgdYudo6
 A28ldE2fQR5BhIS2kSTDVm7EPjbOBEaLQDRV28kVJwu8Sl8rvAWPeUP/ztiRGrlylg
 mRTWTdkFiQpmuIQLZjR8ZfP2/IEzw/mjTZyGhkJQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3c2974e6-05a7-4693-8b3d-727ffa7d121f@yandex-team.ru>
Date: Mon, 18 May 2026 14:34:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/22] vhost refactoring and fixes
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20260420200339.708640-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260420200339.708640-1-vsementsov@yandex-team.ru>
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

On 20.04.26 23:03, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. That's a preparation for vhost-user-blk backend-transfer
> feature.
> 
> v6:
> 04: add vhost-user-stub.c to fix build without vhost-user
> 
> Vladimir Sementsov-Ogievskiy (22):
>    vhost-user: rework enabling vrings
>    vhost: drop backend_features field
>    vhost-user: introduce vhost_user_has_protocol_feature() helper
>    vhost: move protocol_features to vhost_user
>    vhost-user-gpu: drop code duplication
>    vhost: make vhost_dev.features private
>    virtio: move common part of _set_guest_notifier to generic code
>    virtio: drop *_set_guest_notifier_fd_handler() helpers
>    vhost-user: keep QIOChannelSocket for backend channel
>    vhost: vhost_virtqueue_start(): fix failure path
>    vhost: make vhost_memory_unmap() null-safe
>    vhost: simplify calls to vhost_memory_unmap()
>    vhost: move vrings mapping to the top of vhost_virtqueue_start()
>    vhost: vhost_virtqueue_start(): drop extra local variables
>    vhost: final refactoring of vhost vrings map/unmap
>    vhost: simplify vhost_dev_init() error-path
>    vhost: move busyloop timeout initialization to vhost_virtqueue_init()
>    vhost: vhost_dev_init(): simplify features initialization
>    hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
>    vhost-user: make trace events more readable
>    vhost-user-blk: add some useful trace-points
>    vhost: add some useful trace-points
> 
>   backends/cryptodev-vhost.c     |   9 +-
>   hw/block/trace-events          |  10 ++
>   hw/block/vhost-user-blk.c      |  26 +++-
>   hw/display/vhost-user-gpu.c    |  11 +-
>   hw/net/vhost_net.c             |  35 ++---
>   hw/s390x/virtio-ccw.c          |  35 +++--
>   hw/scsi/vhost-scsi.c           |   1 -
>   hw/scsi/vhost-user-scsi.c      |   1 -
>   hw/virtio/meson.build          |   3 +
>   hw/virtio/trace-events         |  16 +-
>   hw/virtio/vdpa-dev.c           |   3 +-
>   hw/virtio/vhost-user-base.c    |   8 +-
>   hw/virtio/vhost-user-stub.c    |   6 +
>   hw/virtio/vhost-user.c         | 260 ++++++++++++++++++++++-----------
>   hw/virtio/vhost.c              | 243 +++++++++++++++---------------
>   hw/virtio/virtio-bus.c         |  18 +--
>   hw/virtio/virtio-hmp-cmds.c    |   2 -
>   hw/virtio/virtio-mmio.c        |  41 +-----
>   hw/virtio/virtio-pci.c         |  34 +----
>   hw/virtio/virtio-qmp.c         |  12 +-
>   hw/virtio/virtio.c             |  48 +++---
>   include/hw/virtio/vhost-user.h |   4 +
>   include/hw/virtio/vhost.h      |  63 +++++---
>   include/hw/virtio/virtio-pci.h |   3 -
>   include/hw/virtio/virtio.h     |  15 +-
>   net/vhost-vdpa.c               |   7 +-
>   qapi/virtio.json               |   3 -
>   27 files changed, 502 insertions(+), 415 deletions(-)
>   create mode 100644 hw/virtio/vhost-user-stub.c
> 


-- 
Best regards,
Vladimir

