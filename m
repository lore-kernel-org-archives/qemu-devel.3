Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06980C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 22:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk8Io-0000rl-UV; Wed, 15 Jul 2026 18:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wk8Im-0000rd-Vl
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 18:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wk8Ik-0003fT-Rs
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 18:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784155321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rDPAa99TYlpeYZKPoUdGra4OjdoiR/ZMYPtSaBHroFU=;
 b=G8xTM5zZnaUXvVPCqU73TBCMVC0jnUYnsd8jjorfa3ypOvHixu2abskJHKipLuDl4iqU9/
 rh6iIJ9j28f6fViwY8oLVP3jBMUFZYslfy4BMrLJo8TN4T5vIgPD0Ex1Xo5hHUxHOJp0Et
 AxeeODLxbDMm24jexrhiR7A7+XzIdvY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-2S6BCYRuOlKpnOuzkNO65w-1; Wed, 15 Jul 2026 18:42:00 -0400
X-MC-Unique: 2S6BCYRuOlKpnOuzkNO65w-1
X-Mimecast-MFC-AGG-ID: 2S6BCYRuOlKpnOuzkNO65w_1784155319
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f4bff865cso1186859f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784155319; x=1784760119; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rDPAa99TYlpeYZKPoUdGra4OjdoiR/ZMYPtSaBHroFU=;
 b=EhkWTSw5OOwmmk/NwBu+90k7fSpAHMV4aZMApRPWLxCZ07DklzTTCvTXxHTin1REpO
 HmhADAeuF6LvzOrnu/Jzu8XZ2V/CsPicfg8r8ozziQ0qhdKhhGkFIR9VX+vOFLhpl3N1
 wvyosUcqVYxuKUxelDdhGUHGsygF+tGB5Io9TaaAN68nvsRSLbMzbcA/iBFT/qCJoLHI
 cxoX7rIuzaUF4mqbLlkp8NmTAy/dtzpBt7Rd2YGW2u+7g/EXj193Hz8ooHVPxFXXmxZa
 hbcsnp6W+FihUiTV7awYUrkVtD+tiNawUVd/gw+wswJlGsQTjY6S8+UENuHsW06XegkO
 okSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784155319; x=1784760119;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rDPAa99TYlpeYZKPoUdGra4OjdoiR/ZMYPtSaBHroFU=;
 b=MVD0eXiAUMXC9XSEoveEsyPMGeWfJYq1Ln2x6yo+4VRehR7PfLeEddffZiz9Jus+3m
 AlM/oRz4I2N/IttcD3INkKXjxwbR3eyjCyI6lpz0xkgWth7VFJprmitNRQrkSZ+K68mR
 RFrD5nZSItuaIY5e5wXvN3XBrSSK0ibazK5NTk297XeJgtFce7Dpen9AMM9UdXzle0nN
 Whif8ez7I/G3cFXebWbpTbk616AIiZNqqXtZSJrdCvKnaydTBf9RS+igBJndGBiEpAuw
 WAHE2IBr/Lucft4+sbImMBLEbK8PfhOlm2bh6Uug4Hp+FIJftZAUiShfW7z0x5UgfRvi
 /DBg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0QrvpKGziHqp/y20G6isY7NXP+/0B3lfK4ocBqfPwhg2dscmRZPyFjC9haYJ+MMNhpsQpsC/qXzJP@nongnu.org
X-Gm-Message-State: AOJu0YwWb/pmpOop1uLLS8mFglm6f59+T8Su/mNDqtHgVJ4hteT/fHwK
 RQ7k5fIv+ig2ZJvI6hOQn/iOnXZe6nKbHF9WI74K6N+wLJzC7Xgxn76lzVVxav5d2fqWpp8uHTh
 VaOMlpIZG3OWbw85C2nBOqWMLZKO1W6/tu3FKX70oi0YPA2WOYO0XXLcP
X-Gm-Gg: AfdE7ckQ5yhbrDVbynQnxRowOtsPblYsrsiSG6vvt18pjKuMsjMIn+CdN91V73Bh6my
 4GuDDUTzCtBzLj01kssHWu4Dg6OXyrKJIqglcpV4TB2MH/vLMjhqjR9Sj8EzcQB0Jey0j/OjSam
 cq5VETkvVjmSSFq4AMZEhQBt/Q7v1b1dAGsdxe2uH0b0wqXcsSeKZ7U3ZVe8/WHVi2FU5QdesyE
 ypEHPkOmZqNwWVJNTxfuS/KSo8W8LPBIgerCG4yjVNwoJ20GWHqEF1BdhhVQeISmeYjwc5dadlm
 +sYHd7vz0/bYC5F69cYbvAz4CS8u0pLpdOkwLWspCvOFdG9Hg+x9whz1MOi0kS/Y2PZ1bv6t0AX
 rKCw/vo4W/ZVg2baSvDQYgaoK
X-Received: by 2002:a05:6000:200d:b0:47f:5990:45be with SMTP id
 ffacd0b85a97d-47f5990476bmr388280f8f.19.1784155318881; 
 Wed, 15 Jul 2026 15:41:58 -0700 (PDT)
X-Received: by 2002:a05:6000:200d:b0:47f:5990:45be with SMTP id
 ffacd0b85a97d-47f5990476bmr388261f8f.19.1784155318411; 
 Wed, 15 Jul 2026 15:41:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635ac2esm20118312f8f.13.2026.07.15.15.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 15:41:57 -0700 (PDT)
Date: Wed, 15 Jul 2026 18:41:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: Re: [PATCH v7 00/22] vhost refactoring and fixes
Message-ID: <20260715184145-mutt-send-email-mst@kernel.org>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527061625.11167-1-vsementsov@yandex-team.ru>
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, May 27, 2026 at 09:16:01AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. That's a preparation for vhost-user-blk backend-transfer
> feature.
> 
> 07: rebase on master,
> 04: drop extra occurence of system_virtio_ss.add(files('vhost-user-stub.c'))

so patch 10 is the fix?

> Vladimir Sementsov-Ogievskiy (22):
>   vhost-user: rework enabling vrings
>   vhost: drop backend_features field
>   vhost-user: introduce vhost_user_has_protocol_feature() helper
>   vhost: move protocol_features to vhost_user
>   vhost-user-gpu: drop code duplication
>   vhost: make vhost_dev.features private
>   virtio: move common part of _set_guest_notifier to generic code
>   virtio: drop *_set_guest_notifier_fd_handler() helpers
>   vhost-user: keep QIOChannelSocket for backend channel
>   vhost: vhost_virtqueue_start(): fix failure path
>   vhost: make vhost_memory_unmap() null-safe
>   vhost: simplify calls to vhost_memory_unmap()
>   vhost: move vrings mapping to the top of vhost_virtqueue_start()
>   vhost: vhost_virtqueue_start(): drop extra local variables
>   vhost: final refactoring of vhost vrings map/unmap
>   vhost: simplify vhost_dev_init() error-path
>   vhost: move busyloop timeout initialization to vhost_virtqueue_init()
>   vhost: vhost_dev_init(): simplify features initialization
>   hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
>   vhost-user: make trace events more readable
>   vhost-user-blk: add some useful trace-points
>   vhost: add some useful trace-points
> 
>  backends/cryptodev-vhost.c     |   9 +-
>  hw/block/trace-events          |  10 ++
>  hw/block/vhost-user-blk.c      |  26 +++-
>  hw/display/vhost-user-gpu.c    |  11 +-
>  hw/net/vhost_net.c             |  35 ++---
>  hw/s390x/virtio-ccw.c          |  35 +++--
>  hw/scsi/vhost-scsi.c           |   1 -
>  hw/scsi/vhost-user-scsi.c      |   1 -
>  hw/virtio/meson.build          |   1 +
>  hw/virtio/trace-events         |  16 +-
>  hw/virtio/vdpa-dev.c           |   3 +-
>  hw/virtio/vhost-user-base.c    |   8 +-
>  hw/virtio/vhost-user-stub.c    |   6 +
>  hw/virtio/vhost-user.c         | 260 ++++++++++++++++++++++-----------
>  hw/virtio/vhost.c              | 243 +++++++++++++++---------------
>  hw/virtio/virtio-bus.c         |  18 +--
>  hw/virtio/virtio-hmp-cmds.c    |   2 -
>  hw/virtio/virtio-mmio.c        |  41 +-----
>  hw/virtio/virtio-pci.c         |  34 +----
>  hw/virtio/virtio-qmp.c         |  12 +-
>  hw/virtio/virtio.c             |  48 +++---
>  include/hw/virtio/vhost-user.h |   4 +
>  include/hw/virtio/vhost.h      |  63 +++++---
>  include/hw/virtio/virtio-pci.h |   3 -
>  include/hw/virtio/virtio.h     |  15 +-
>  net/vhost-vdpa.c               |   7 +-
>  qapi/virtio.json               |   3 -
>  27 files changed, 500 insertions(+), 415 deletions(-)
>  create mode 100644 hw/virtio/vhost-user-stub.c
> 
> -- 
> 2.52.0


