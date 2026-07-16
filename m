Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04834C43458
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 05:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkEbB-0007ha-Io; Thu, 16 Jul 2026 01:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkEbA-0007hE-42
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 01:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkEb5-0003U1-UE
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 01:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784179519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fp4jZFS509qTnQegXqa8viOpEWkTEOB4RzKTfCUybWQ=;
 b=J1dodZQaXA9csOe63lCMwgqzsQ3VRVfgAXw+8Rv+O2Ce7bTerHRDQdc81ljk/za6d0sNIe
 Yb5wuNQWH8EfKZDBk5RD1nNNEYCbK22PPrO8giPrw0q1DIfZ+Tb2KYfcu78hZzprMjScgq
 me+IyXRS/I589m2lSeuG4+wxiUfoB2E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-jidVvaV5NAyhTIpbtv93Wg-1; Thu, 16 Jul 2026 01:25:17 -0400
X-MC-Unique: jidVvaV5NAyhTIpbtv93Wg-1
X-Mimecast-MFC-AGG-ID: jidVvaV5NAyhTIpbtv93Wg_1784179516
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4767036f8faso3848305f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 22:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784179516; x=1784784316; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fp4jZFS509qTnQegXqa8viOpEWkTEOB4RzKTfCUybWQ=;
 b=lmoDz+W+kh3K8VdKlZZSGHM+WhFpCTrN3OCwMj9UB8pwbjMET9CT5ANMQ3fTgMXhN2
 HEUBBb9gC+RlnJaj4CCpjL6nS6sUljI4X+tXF4nkND4nDwBp1wAVHZyRrXVki1sniAQ9
 EAG23butiIsE5To7rMFxwfypTiQrqpgtf+AQzw4jhOproRQvi/S3nJa22ylGqyupqmdh
 XDDt6uPiQQ+JawY17/AWkGWvXSYDFDdnZJ0cYuRJ4sL2v8cIF42EFrRfFnGsNisiOMBc
 kb1l3Za9BZ2TL7DNMoq1KOTiBDXk3aqN+PoDxYf252V3r9TAoWARUk8A+KPRKrzjfQAz
 fV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784179516; x=1784784316;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fp4jZFS509qTnQegXqa8viOpEWkTEOB4RzKTfCUybWQ=;
 b=s0ENKKoUnC0rdIrpetQHsym3BvynwaIwvR3CYyqqRa+wPevk7rPGVm9Y3akOoXYBzm
 WhNcXsSzufafT+asxDtn8pIfg5ZtPtZxZ0sGMTjUlO5WpWMlfz0P4MNPDoPz4WwLxBsH
 JRbAx/mnzsBr2+/J6ym2DQSCZiCrTDeCGG4B6RZ5YmHoW/IvdflaZvOBcNmOWjuamNyk
 eE7BkblRMi0Q24QRgg+4Vi41yYtxszQsO2iiIMg2eDrgrEOntzlCLg6a9ENpB4cYL92f
 ht0B32n8oHUJ4ry8CLO6D/kqNAGpwSM3qAc4t7eKsxHNzgJCbHupSKvWZwPFXpLhCe04
 X7jQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RobjZnGPopG+Ym0WxxlxBEd0jG2SmLMWsL09tgnrFwDBQ0udRftGgB1fX5SxhSGQf2V0xpPbqa1Mo+4@nongnu.org
X-Gm-Message-State: AOJu0Yy9HYtDVZLnrs/zXcFHqe3PeDpctxGNF0yVnTOICsltVWNArE1O
 ogO04KyFWiIVmG1tDc9r2PhPhRc0m4sOxFf5W5OCE/QKUEIzfWXUKLfHqbOi9/SHRD1OS2Pf9Yi
 Aqx5PfmSGQP+jESz/X682kt5+qMCp33bG7G25wJ+H6NDhgstObBqcQNng
X-Gm-Gg: AfdE7clZfKcG736GWH8UDphaur5y54KQf0fflK603gRarJmQV8wPN5rI47Dv0gHIo6K
 KurF9RSbsua2OmWTcNwL+YkT9sZVk8nOq/Zmul7KrjkVNB1/Zdf9g+XSobbqHTGhTQvy2v80PJh
 tuu0foj/tBzxHQ924u6dInXLz7j+nHzOalIF0hUWCz8tzul9T+CIMI3OWRc+mYSdhTq5B4g1IGk
 kU+AfSxNsC/XF8nfk7Tabntg3DhkfyJlrY4visJNOkrRCU/1H99MVZnyGAQFkeEBM3dJb8BzrFB
 0KaOCfv512QzhmcsDYBH7i7vi4rPGR8sJUw3bhc5+eRYm84dtri8H8A9JY9sBVEoaN+0VporxyT
 GuiwCSgyvYT7G0Xnncb2KIIkX
X-Received: by 2002:a05:6000:4201:b0:47f:2bc3:8cf3 with SMTP id
 ffacd0b85a97d-47f4fcb5e95mr6009439f8f.18.1784179516001; 
 Wed, 15 Jul 2026 22:25:16 -0700 (PDT)
X-Received: by 2002:a05:6000:4201:b0:47f:2bc3:8cf3 with SMTP id
 ffacd0b85a97d-47f4fcb5e95mr6009407f8f.18.1784179515470; 
 Wed, 15 Jul 2026 22:25:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634debesm21840845f8f.8.2026.07.15.22.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 22:25:14 -0700 (PDT)
Date: Thu, 16 Jul 2026 01:25:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: Re: [PATCH v7 00/22] vhost refactoring and fixes
Message-ID: <20260716012417-mutt-send-email-mst@kernel.org>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
 <20260715184145-mutt-send-email-mst@kernel.org>
 <89ef906d-56d3-40cd-bce4-5636dd963eee@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89ef906d-56d3-40cd-bce4-5636dd963eee@yandex-team.ru>
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

On Thu, Jul 16, 2026 at 02:27:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 16.07.26 01:41, Michael S. Tsirkin wrote:
> > On Wed, May 27, 2026 at 09:16:01AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Hi all. That's a preparation for vhost-user-blk backend-transfer
> > > feature.
> > > 
> > > 07: rebase on master,
> > > 04: drop extra occurence of system_virtio_ss.add(files('vhost-user-stub.c'))
> > 
> > so patch 10 is the fix?
> 
> Probably it's too late :/ I don't understand, what do you mean). Patch 10 is a
> fix yes. But seems it has no relation to vhost-user-stub.c ?

the patchset is big. I am debating with myself when to merge it.
Is it possible to just apply fixes an cleanups later?

> > 
> > > Vladimir Sementsov-Ogievskiy (22):
> > >    vhost-user: rework enabling vrings
> > >    vhost: drop backend_features field
> > >    vhost-user: introduce vhost_user_has_protocol_feature() helper
> > >    vhost: move protocol_features to vhost_user
> > >    vhost-user-gpu: drop code duplication
> > >    vhost: make vhost_dev.features private
> > >    virtio: move common part of _set_guest_notifier to generic code
> > >    virtio: drop *_set_guest_notifier_fd_handler() helpers
> > >    vhost-user: keep QIOChannelSocket for backend channel
> > >    vhost: vhost_virtqueue_start(): fix failure path
> > >    vhost: make vhost_memory_unmap() null-safe
> > >    vhost: simplify calls to vhost_memory_unmap()
> > >    vhost: move vrings mapping to the top of vhost_virtqueue_start()
> > >    vhost: vhost_virtqueue_start(): drop extra local variables
> > >    vhost: final refactoring of vhost vrings map/unmap
> > >    vhost: simplify vhost_dev_init() error-path
> > >    vhost: move busyloop timeout initialization to vhost_virtqueue_init()
> > >    vhost: vhost_dev_init(): simplify features initialization
> > >    hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
> > >    vhost-user: make trace events more readable
> > >    vhost-user-blk: add some useful trace-points
> > >    vhost: add some useful trace-points
> > > 
> > >   backends/cryptodev-vhost.c     |   9 +-
> > >   hw/block/trace-events          |  10 ++
> > >   hw/block/vhost-user-blk.c      |  26 +++-
> > >   hw/display/vhost-user-gpu.c    |  11 +-
> > >   hw/net/vhost_net.c             |  35 ++---
> > >   hw/s390x/virtio-ccw.c          |  35 +++--
> > >   hw/scsi/vhost-scsi.c           |   1 -
> > >   hw/scsi/vhost-user-scsi.c      |   1 -
> > >   hw/virtio/meson.build          |   1 +
> > >   hw/virtio/trace-events         |  16 +-
> > >   hw/virtio/vdpa-dev.c           |   3 +-
> > >   hw/virtio/vhost-user-base.c    |   8 +-
> > >   hw/virtio/vhost-user-stub.c    |   6 +
> > >   hw/virtio/vhost-user.c         | 260 ++++++++++++++++++++++-----------
> > >   hw/virtio/vhost.c              | 243 +++++++++++++++---------------
> > >   hw/virtio/virtio-bus.c         |  18 +--
> > >   hw/virtio/virtio-hmp-cmds.c    |   2 -
> > >   hw/virtio/virtio-mmio.c        |  41 +-----
> > >   hw/virtio/virtio-pci.c         |  34 +----
> > >   hw/virtio/virtio-qmp.c         |  12 +-
> > >   hw/virtio/virtio.c             |  48 +++---
> > >   include/hw/virtio/vhost-user.h |   4 +
> > >   include/hw/virtio/vhost.h      |  63 +++++---
> > >   include/hw/virtio/virtio-pci.h |   3 -
> > >   include/hw/virtio/virtio.h     |  15 +-
> > >   net/vhost-vdpa.c               |   7 +-
> > >   qapi/virtio.json               |   3 -
> > >   27 files changed, 500 insertions(+), 415 deletions(-)
> > >   create mode 100644 hw/virtio/vhost-user-stub.c
> > > 
> > > -- 
> > > 2.52.0
> > 
> 
> 
> -- 
> Best regards,
> Vladimir


