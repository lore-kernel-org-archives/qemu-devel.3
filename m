Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE20FCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKCwM-0004TV-G8; Tue, 05 May 2026 06:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wKCwK-0004Sy-6r
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:23:44 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wKCwI-0000f2-Cy
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:23:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c00c:0:640:e0de:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 097EE8087B;
 Tue, 05 May 2026 13:23:41 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:78a::1:25] (unknown
 [2a02:6bf:8080:78a::1:25])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id dNdw5C0L3iE0-CIMNhbw1; Tue, 05 May 2026 13:23:40 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1777976620;
 bh=ReVi7oCWBCDjNeQRW0hJ7KeMb85wciFmtPU1jawhwL8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=XK9mrAeCYaXsiTemq70z0F/UfhRNYix0GAdmOoAS8kvA+JGC16UudW75ruxCjSe2B
 3dHvia/ZKeV1EM3odtHVR+mj35v7+ab+JiZ32aDVnCaPIo70eBBiB3wOtBhyU2ksDa
 muggokCFQPHCHqmhJtcFPADype879YrCLTeu9UYs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6ff9cff7-277c-4726-baae-1c0afa2c93fd@yandex-team.ru>
Date: Tue, 5 May 2026 13:23:39 +0300
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

ping)

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

