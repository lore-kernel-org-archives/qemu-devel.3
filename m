Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505B4606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D8xydaRJ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VoqE7MW3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPGC5-0005km-QT; Fri, 06 Nov 2026 04:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xPGC2-0005kL-T1
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 04:25:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xPGC1-0005A2-1I
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 04:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793957104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VO+hB2Gwy/ScIW9PIB288I9VI3obGkX40NApyjEQbAw=;
 b=D8xydaRJ3dShDupOJxy+5+yr2Ti3b9FLLYXUw//IYLTn0rJ4AY09weSJ2eK+f4JSp0mJ8W
 SfSRqKX1r2pOtqQWWLSk8KLnHm64nw3MXUgZnEwW8ROBHTp1eghb4xZNc87EktuAvbpeRn
 keY11CxOTOf4AyUYTR1kuc03QB6qk3s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-3ub2bb8BMrSz8hnoHqk56Q-1; Fri, 06 Nov 2026 04:25:01 -0500
X-MC-Unique: 3ub2bb8BMrSz8hnoHqk56Q-1
X-Mimecast-MFC-AGG-ID: 3ub2bb8BMrSz8hnoHqk56Q_1793957100
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e0af48c18so405400f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 01:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793957100; x=1794561900; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VO+hB2Gwy/ScIW9PIB288I9VI3obGkX40NApyjEQbAw=;
 b=VoqE7MW3qrR3eMI64lugGJRxUKajrJDmi/MFPXPXqNWDo8XeEohHc0sJMUqtPtuoZv
 46wY8lgX/MAAtby5pR5lkFsp35bSMT6FMeMxAGywozOC9m4Bl3A9QxNwOycxkKyfYD8w
 laLTefSI+7QPGx29071VhWOSW9HFBaejmu8LvJwbbyZz9hjsROcOwTe3+XBPEaBdsicS
 S67pvpS9r+8zK5ZTvyPgA9E69DxqVedo9Mbs4AuxpgilehtM6cqPfTSlaxp5PFp61Uqn
 h+OPTWlbxyX1d4T1/w6MX8g+89HbNKuysdtYGwraDCqvxRMh/iRXXW+pZ7hxDQtBYBle
 i7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793957100; x=1794561900;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VO+hB2Gwy/ScIW9PIB288I9VI3obGkX40NApyjEQbAw=;
 b=gO76V3AKUOFUx+whxiUmsA4tJDtFpbMIsdtEvlCb7vZKwVPppkZRApcg/GKOflkbmm
 m7arN9Fj9XiyO+VuFME/MLsFrZbayKsK0r5RrL8qIT4WexYCpoL6EW11ZnjYwoy9oH+r
 0ErsUa4MrHI4otg+z1XbwVQ2v7BoLj1aJKI8ILsJL4kfT1XbNRZurFUPxWwoglecEHDF
 E+10u0aF1MbeLjvRvCwpyZwfKW7h/5+X1eoaDQs4o0kWh8dTdKPZVhsFvJVc34aNX/Pc
 DGX0BY0LGzEWumYJulOUZIepC/48t0hBFxWR8V8+Q7RWkN0leW8T4mhHi2SIHjh0C5CN
 /2iA==
X-Forwarded-Encrypted: i=1;
 AL+hErG9Au7Nanx72mLRnmS7byTVvRugriNd4Ui6WcBvr3SAvZK8lp8Z16V8Hx+w8OY7yLyp08jlza7PPTPr@nongnu.org
X-Gm-Message-State: APuU4Z/NGWsztVVE92zsGpB7CcfNbS5etj8hHEmfnpVR36yG9fpTYF79
 UCHd2Jfj+QycDFblevdhiimifFDavFhXQ3/AiBLT0GR61LkRu1tHa+FQdRbbWxdSSDik4d91XQa
 FAL2TkarnaYM+4wMvD6MgoGhvy4VXkjJZB15ctTI3+GZfQAouIeNCwWu9
X-Gm-Gg: AYBFou1rm8AxUZatx7QjTOfdnU8Is7ePSBWeNwQeByN6Qk9bRV1ofA9lCix43AjOVaI
 sK1TKxYIzGODMC2x1WdowfTVfa52r5kWGhJC4a2NQErH12OdSo7bqj+m3RTI9q1KVuMPwP4ESuA
 ry/PLmOnSa5Lma0P3JMq2Jch/B/t3D5Bpy3Sn/Q5bRdPic35yrjG+JNqk1dH/VtiF+m2b3Z9iqH
 iqQYI69/ulHPmArFoMHVLhDtc+W5MEA+amd28pGT+r1pxs8GNHZy1klcbr2X0qrKD/wL17Ck+Sy
 erPlrXLw+jjSpaCU2EB0h4McAsDqM9YUMS5JN/HzxPWuzNT2YzhVpp5/hETgrIVpUhAPi/jEfYe
 IZtq8q0kVjTPP68PCu+CrXhLLuFMG7azwwe+HKwir0A==
X-Received: by 2002:a5d:588e:0:b0:492:a2cc:f2f4 with SMTP id
 ffacd0b85a97d-492a2ccf47emr3149436f8f.53.1793957100354; 
 Fri, 06 Nov 2026 01:25:00 -0800 (PST)
X-Received: by 2002:a5d:588e:0:b0:492:a2cc:f2f4 with SMTP id
 ffacd0b85a97d-492a2ccf47emr3149381f8f.53.1793957099842; 
 Fri, 06 Nov 2026 01:24:59 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1401:db00:7367:7b9e:e66f:2b7d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6162sm2505447f8f.47.2026.11.06.01.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:24:58 -0800 (PST)
Date: Fri, 6 Nov 2026 04:24:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 QEMU Stable <qemu-stable@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v7 00/22] vhost refactoring and fixes
Message-ID: <20261106041855-mutt-send-email-mst@kernel.org>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
 <56f5cf1d-e221-465f-8993-866d744241ca@tls.msk.ru>
 <4365e62de77171ab81ade60344453ee67d73c74c.camel@linuxhacker.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4365e62de77171ab81ade60344453ee67d73c74c.camel@linuxhacker.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 03:53:38AM -0500, Oleg Drokin wrote:
> Hi Michael,
> 
> these master commits fix bugs that are also present in 10.0.x and are
> not in staging-10.0 yet.
> Group A cherry-picks cleanly onto staging-10.0 at 1607144131, in this
> order, and builds. Group B does not apply as is.
> 
> ## A. Clean cherry-picks
> 
> Guest-triggerable:
> 
> - 62976e8a2e virtio-pci: reject Q_ENABLE write on already-enabled queue
>   (re-enabling a live queue keeps stale progress indices; virtio-iommu
> can be driven to OOM)

this one is more of a work around. the real fixes for this are in
virtio-iommu.

> - fa9e186ab6 virtio-net: validate IHL in virtio_net_rsc_extract_unit4
> before use (OOB read, work item #4166; needs guest_rsc_ext)

ok

> - a2fbf1785b hw/ide/ahci: clear cur_cmd when the command list is
> unmapped
> - d7f16bad8f hw/ide/ahci: refuse a PIO transfer with no command header
> - 2713717148 hw/ide/ahci: treat a failed PRDT walk as a PIO transfer
> failure
> - 795af987ce hw/ide/ahci: reject a command header with an invalid FIS
> length
> - 402fd5a756 vfio/pci: Fix information leak in vfio_rom_read()
> - aca4967567 hw/usb/hcd-xhci: Unmap canceled packet (DMA mapping leak
> on Stop Endpoint with async packets)
> Host-side robustness:
> 
> - c31a445749 aio-posix: fix fdmon-io_uring.c timeout stack variable
> lifetime
> - dbf70f0a03 aio-posix: fix race between io_uring CQE and AioHandler
> deletion (10.0 uses fdmon-io_uring for every AioContext when built with
> liburing; random hangs and a use-after-free)
> - 1423c170b9 chardev: Fix QIOChannel refcount (use-after-free)
> - 3f0170505e chardev: Don't attempt to unregister yank function more
> than once (abort)
> - a1708203b5 net/tap-linux.c: avoid abort when setting invalid fd (the
> abort became reachable on reset through "virtio: Call set_features
> during reset", which 10.0.x carries)
> - 4733cb0833 block/io: skip head/tail requests on EINVAL (misaligned
> guest discard pauses a werror=stop guest)
> - 1fec1f337a ahci: Fix leak of IRQState (minor)
> 
> ## B. Need a context backport
> 
> - 9daa7347ff vfio/pci: Reject invalid MSI-X Table and PBA BIR values
>   (conflicts only with the vfio_device_get_irq_info() conversion)
> - 5bdc12fed5 hw/ide/ahci: drain the ports on teardown (use-after-free
> on surprise removal of a hot-plugged AHCI controller)
> - a35c5755d9 intel_iommu: fix guest-triggerable abort on oversized MMIO
> access

hmm. maybe

> - 24b9ebd5f1 hpet: fix bounds check for s->timer[] (no security impact
> per the commit message; included for completeness)
> 
> On Fri, 2026-11-06 at 05:35 +0300, Michael Tokarev wrote:
> > On 5/27/26 09:16, Vladimir Sementsov-Ogievskiy wrote:
> > > Hi all. That's a preparation for vhost-user-blk backend-transfer
> > > feature.
> > > 
> > > 07: rebase on master,
> > > 04: drop extra occurence of system_virtio_ss.add(files('vhost-user-
> > > stub.c'))
> > > 
> > > Vladimir Sementsov-Ogievskiy (22):
> > >    vhost-user: rework enabling vrings
> > >    vhost: drop backend_features field
> > >    vhost-user: introduce vhost_user_has_protocol_feature() helper
> > >    vhost: move protocol_features to vhost_user
> > >    vhost-user-gpu: drop code duplication
> > >    vhost: make vhost_dev.features private
> > >    virtio: move common part of _set_guest_notifier to generic code
> > >    virtio: drop *_set_guest_notifier_fd_handler() helpers
> > >    vhost-user: keep QIOChannelSocket for backend channel
> > >    vhost: vhost_virtqueue_start(): fix failure path
> > >    vhost: make vhost_memory_unmap() null-safe
> > >    vhost: simplify calls to vhost_memory_unmap()
> > >    vhost: move vrings mapping to the top of vhost_virtqueue_start()
> > >    vhost: vhost_virtqueue_start(): drop extra local variables
> > >    vhost: final refactoring of vhost vrings map/unmap
> > >    vhost: simplify vhost_dev_init() error-path
> > >    vhost: move busyloop timeout initialization to
> > > vhost_virtqueue_init()
> > >    vhost: vhost_dev_init(): simplify features initialization
> > >    hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
> > >    vhost-user: make trace events more readable
> > >    vhost-user-blk: add some useful trace-points
> > >    vhost: add some useful trace-points
> >  From this pullreq, I'm picking the following changes for 10.0.x
> > stable series
> > (with small adjustments to apply to 10.0.x):
> > 
> >   4e61c89262a vhost: final refactoring of vhost vrings map/unmap
> >   4801e50cf1a vhost: vhost_virtqueue_start(): drop extra local
> > variables
> >   60abdf60d50 vhost: move vrings mapping to the top of
> > vhost_virtqueue_start()
> >   060ef8cac11 vhost: simplify calls to vhost_memory_unmap()
> >   558084367e9 vhost: make vhost_memory_unmap() null-safe
> >   c85f42703df vhost: vhost_virtqueue_start(): fix failure path
> > 
> > Additionally, I'm picking
> > 
> >   41d5e37e0e2 hw/virtio/vhost: Replace legacy
> > cpu_physical_memory_*map() calls
> > 
> > to 10.0.x too - this is basically a no-op change, but it makes
> > subsequent changes to apply cleanly and makes older code closer
> > to current, simplifying back-porting and making this back-
> > porting easily verifiable.
> > 
> > Please take a look at the 6 top commits starting
> > 
> >  
> > https://gitlab.com/mjt0k/qemu/-/commits/16071441316f92915dccf08dabdddc722674e38c
> > 
> > -- it should be very similar to the changes in this pull request, but
> > a quick look is appreciated anyway.
> > 
> > Is there anything else in this area which should be picked up too? 
> > Maybe
> > some subsequent fixes?
> > 
> > Thanks,
> > 
> > /mjt


