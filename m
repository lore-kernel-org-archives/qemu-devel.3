Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D8BCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 14:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8JAI-0002rZ-Ca; Mon, 13 Oct 2025 10:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1v8JAB-0002r3-Sj
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 10:04:36 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1v8JA7-0001rO-Ip
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 10:04:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8982:0:640:5cf4:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1C7A180861;
 Mon, 13 Oct 2025 17:04:24 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:176::1:23] (unknown
 [2a02:6bf:8080:176::1:23])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id M4PQjU2FIW20-E4Z3w7Uy; Mon, 13 Oct 2025 17:04:23 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760364263;
 bh=qF0UqIonXENzbd89mL9luKVbj2kMjCogsKX/4d2ImsM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=uMqGS105nssLR2JUKZFQ5RCJUcbbYykaN87Oq5kkZGoMmFtfzI4WTBOqYw/9UajZe
 TaKHTtEW2dq+F7Kq7Of+w9SWHH3cT0Z6qEf3JzHRHK5XYSZTYHDRYy2ilHW9bNm9fB
 BRc7lHf2NOxwhQ3y639xsL/BUE5MSOKFQDROl3Mc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1d59a840-2f02-43d9-a659-a94309014873@yandex-team.ru>
Date: Mon, 13 Oct 2025 17:04:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/23] vhost refactoring and fixes
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 raphael.s.norwitz@gmail.com, yc-core@yandex-team.ru
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20251011232404.561024-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi!

For all patches:
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

Thanks,
Daniil

On 10/12/25 2:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. That's rebased and updated first part of
>    [PATCH 00/33] vhost-user-blk: live-backend local migration
>
> v2:
> 01: rework
> 02: - rebaose on _ex features, more accurate
>      - change in vhost_net_ack_features_ex()
>      - add note to commit message
> 03: rename to vhost_user_has_protocol_feature,
>      to follow existing vhost_user_set_protocol_features
> 04: rework to vhost-user only helper
> 05: add r-b by Philippe and Raphael
> 06: rebase on _ex features, make new helpers static inliners
> 07: add docstring
> 09: a-b by Raphael
> 10: rebase on address_space_map
> 11: fix double-free
> 13,14: r-b by Raphael
> 16: a-b by Raphael
> 17,18: r-b by Raphael
> 19: reworked
> 20: add r-b by Philippe and Raphael
> 21: - add r-b by Philippe and Raphael
>      - fix indent
> 22: rename to _in/_out, add vdev ptr
> 23: rename to _in/_out, add dev ptr
>
> Vladimir Sementsov-Ogievskiy (23):
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
>    vhost: introduce check_memslots() helper
>    vhost: vhost_dev_init(): simplify features initialization
>    hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
>    vhost-user: make trace events more readable
>    vhost-user-blk: add some useful trace-points
>    vhost: add some useful trace-points
>
>   backends/cryptodev-vhost.c     |   9 +-
>   hw/block/trace-events          |  10 ++
>   hw/block/vhost-user-blk.c      |  20 ++-
>   hw/display/vhost-user-gpu.c    |  11 +-
>   hw/net/vhost_net.c             |  35 ++--
>   hw/scsi/vhost-scsi.c           |   1 -
>   hw/scsi/vhost-user-scsi.c      |   1 -
>   hw/virtio/trace-events         |  16 +-
>   hw/virtio/vdpa-dev.c           |   3 +-
>   hw/virtio/vhost-user-base.c    |   8 +-
>   hw/virtio/vhost-user.c         | 285 ++++++++++++++++++++++---------
>   hw/virtio/vhost.c              | 300 +++++++++++++++++----------------
>   hw/virtio/virtio-bus.c         |  18 +-
>   hw/virtio/virtio-hmp-cmds.c    |   2 -
>   hw/virtio/virtio-mmio.c        |  41 +----
>   hw/virtio/virtio-pci.c         |  34 +---
>   hw/virtio/virtio-qmp.c         |  12 +-
>   hw/virtio/virtio.c             |  48 +++---
>   include/hw/virtio/vhost-user.h |   3 +
>   include/hw/virtio/vhost.h      |  51 ++++--
>   include/hw/virtio/virtio-pci.h |   3 -
>   include/hw/virtio/virtio.h     |  16 +-
>   net/vhost-vdpa.c               |   7 +-
>   qapi/virtio.json               |   3 -
>   24 files changed, 525 insertions(+), 412 deletions(-)
>

