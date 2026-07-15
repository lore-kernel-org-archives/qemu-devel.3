Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4830C44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 23:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk90e-0004x6-NU; Wed, 15 Jul 2026 19:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wk90c-0004wx-0e
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 19:27:22 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wk90X-0000XK-Pc
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 19:27:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 1593C80765;
 Thu, 16 Jul 2026 02:27:12 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d6a::1:11] (unknown
 [2a02:6bf:8080:d6a::1:11])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id BRa0ms0a70U0-DBeJKViH; Thu, 16 Jul 2026 02:27:11 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784158031;
 bh=PVR60qt5tlLl1X/m5hHW2lekuH7zGKOPcq5gkERxWCY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0EmJZwqdhahvLAt/gk8iyymBfComjditw7PMwOFSkEvyDGDm6Qfa50hpjbkAED1CJ
 UBnhqs/XJ2xeB5ExzauXTF3u3VVOCHfvU9z9Y92jidks5K4BFW1RhHOnnyjb9IVTUZ
 Xw1REQjco1HD204XRg69kmCIejcaL+hegNjaDRIA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <89ef906d-56d3-40cd-bce4-5636dd963eee@yandex-team.ru>
Date: Thu, 16 Jul 2026 02:27:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/22] vhost refactoring and fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
 <20260715184145-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260715184145-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 16.07.26 01:41, Michael S. Tsirkin wrote:
> On Wed, May 27, 2026 at 09:16:01AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all. That's a preparation for vhost-user-blk backend-transfer
>> feature.
>>
>> 07: rebase on master,
>> 04: drop extra occurence of system_virtio_ss.add(files('vhost-user-stub.c'))
> 
> so patch 10 is the fix?

Probably it's too late :/ I don't understand, what do you mean). Patch 10 is a
fix yes. But seems it has no relation to vhost-user-stub.c ?

> 
>> Vladimir Sementsov-Ogievskiy (22):
>>    vhost-user: rework enabling vrings
>>    vhost: drop backend_features field
>>    vhost-user: introduce vhost_user_has_protocol_feature() helper
>>    vhost: move protocol_features to vhost_user
>>    vhost-user-gpu: drop code duplication
>>    vhost: make vhost_dev.features private
>>    virtio: move common part of _set_guest_notifier to generic code
>>    virtio: drop *_set_guest_notifier_fd_handler() helpers
>>    vhost-user: keep QIOChannelSocket for backend channel
>>    vhost: vhost_virtqueue_start(): fix failure path
>>    vhost: make vhost_memory_unmap() null-safe
>>    vhost: simplify calls to vhost_memory_unmap()
>>    vhost: move vrings mapping to the top of vhost_virtqueue_start()
>>    vhost: vhost_virtqueue_start(): drop extra local variables
>>    vhost: final refactoring of vhost vrings map/unmap
>>    vhost: simplify vhost_dev_init() error-path
>>    vhost: move busyloop timeout initialization to vhost_virtqueue_init()
>>    vhost: vhost_dev_init(): simplify features initialization
>>    hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
>>    vhost-user: make trace events more readable
>>    vhost-user-blk: add some useful trace-points
>>    vhost: add some useful trace-points
>>
>>   backends/cryptodev-vhost.c     |   9 +-
>>   hw/block/trace-events          |  10 ++
>>   hw/block/vhost-user-blk.c      |  26 +++-
>>   hw/display/vhost-user-gpu.c    |  11 +-
>>   hw/net/vhost_net.c             |  35 ++---
>>   hw/s390x/virtio-ccw.c          |  35 +++--
>>   hw/scsi/vhost-scsi.c           |   1 -
>>   hw/scsi/vhost-user-scsi.c      |   1 -
>>   hw/virtio/meson.build          |   1 +
>>   hw/virtio/trace-events         |  16 +-
>>   hw/virtio/vdpa-dev.c           |   3 +-
>>   hw/virtio/vhost-user-base.c    |   8 +-
>>   hw/virtio/vhost-user-stub.c    |   6 +
>>   hw/virtio/vhost-user.c         | 260 ++++++++++++++++++++++-----------
>>   hw/virtio/vhost.c              | 243 +++++++++++++++---------------
>>   hw/virtio/virtio-bus.c         |  18 +--
>>   hw/virtio/virtio-hmp-cmds.c    |   2 -
>>   hw/virtio/virtio-mmio.c        |  41 +-----
>>   hw/virtio/virtio-pci.c         |  34 +----
>>   hw/virtio/virtio-qmp.c         |  12 +-
>>   hw/virtio/virtio.c             |  48 +++---
>>   include/hw/virtio/vhost-user.h |   4 +
>>   include/hw/virtio/vhost.h      |  63 +++++---
>>   include/hw/virtio/virtio-pci.h |   3 -
>>   include/hw/virtio/virtio.h     |  15 +-
>>   net/vhost-vdpa.c               |   7 +-
>>   qapi/virtio.json               |   3 -
>>   27 files changed, 500 insertions(+), 415 deletions(-)
>>   create mode 100644 hw/virtio/vhost-user-stub.c
>>
>> -- 
>> 2.52.0
> 


-- 
Best regards,
Vladimir

