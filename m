Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848C606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linuxhacker.ru header.i=@linuxhacker.ru header.a=rsa-sha256 header.s=mail header.b=mNkq8gP1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPK6r-0003Mt-Nq; Fri, 06 Nov 2026 08:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green@linuxhacker.ru>)
 id 1xPFhj-00075V-ML; Fri, 06 Nov 2026 03:53:47 -0500
Received: from linuxhacker.ru ([159.69.87.85] helo=eagle.linuxhacker.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green@linuxhacker.ru>)
 id 1xPFhh-0001dV-DN; Fri, 06 Nov 2026 03:53:47 -0500
Received: from [10.137.0.31] (unknown [162.81.204.199])
 by eagle.linuxhacker.ru (Postfix) with ESMTPSA id 396B7BEE42;
 Fri,  6 Nov 2026 08:53:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 eagle.linuxhacker.ru 396B7BEE42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxhacker.ru;
 s=mail; t=1793955221;
 bh=DbZmSbe5eCHlOvifV0yV+NJhv1O4MctEiP47EHD96Xw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=mNkq8gP1i+3sfVN/aGouE7ha/Ij77WblM5QwDvtZrLZr2C+2fCGMhPmRAyk15sZdj
 TqWayQQQ61chPq+C3LOBM9VzaC4BoiKyUIPnlFaAXcqGrKh2REZkeYr48Hd26ZhaO6
 BvLgrkD/J18jLJguK3ym5pK+osNlgI9tXf/VJp2ZLtmPtgNaYYdBTgsT47ukPK8Pwi
 OanWQhFgcaKRt+3slYQs+/PBNLCCoMuy1DjScJ7Ki2gM0F+jztxPL7kRMJxKiZX5Ii
 o4mFT3qBS/kcY///CximBVMCE9b5/spNi0lKCpcOW5eboUyfWSz7I59Jnbt9Uab0Lt
 vr6unUI7NhvrA==
Message-ID: <4365e62de77171ab81ade60344453ee67d73c74c.camel@linuxhacker.ru>
Subject: Re: [PATCH v7 00/22] vhost refactoring and fixes
From: Oleg Drokin <green@linuxhacker.ru>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 mst@redhat.com, 	sgarzare@redhat.com, raphael@enfabrica.net,
 qemu-devel@nongnu.org, 	yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 QEMU Stable	 <qemu-stable@nongnu.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 03:53:38 -0500
In-Reply-To: <56f5cf1d-e221-465f-8993-866d744241ca@tls.msk.ru>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
 <56f5cf1d-e221-465f-8993-866d744241ca@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=159.69.87.85; envelope-from=green@linuxhacker.ru;
 helo=eagle.linuxhacker.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 06 Nov 2026 08:35:57 -0500
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Michael,

these master commits fix bugs that are also present in 10.0.x and are
not in staging-10.0 yet.
Group A cherry-picks cleanly onto staging-10.0 at 1607144131, in this
order, and builds. Group B does not apply as is.

## A. Clean cherry-picks

Guest-triggerable:

- 62976e8a2e virtio-pci: reject Q_ENABLE write on already-enabled queue
  (re-enabling a live queue keeps stale progress indices; virtio-iommu
can be driven to OOM)
- fa9e186ab6 virtio-net: validate IHL in virtio_net_rsc_extract_unit4
before use (OOB read, work item #4166; needs guest_rsc_ext)
- a2fbf1785b hw/ide/ahci: clear cur_cmd when the command list is
unmapped
- d7f16bad8f hw/ide/ahci: refuse a PIO transfer with no command header
- 2713717148 hw/ide/ahci: treat a failed PRDT walk as a PIO transfer
failure
- 795af987ce hw/ide/ahci: reject a command header with an invalid FIS
length
- 402fd5a756 vfio/pci: Fix information leak in vfio_rom_read()
- aca4967567 hw/usb/hcd-xhci: Unmap canceled packet (DMA mapping leak
on Stop Endpoint with async packets)

Host-side robustness:

- c31a445749 aio-posix: fix fdmon-io_uring.c timeout stack variable
lifetime
- dbf70f0a03 aio-posix: fix race between io_uring CQE and AioHandler
deletion (10.0 uses fdmon-io_uring for every AioContext when built with
liburing; random hangs and a use-after-free)
- 1423c170b9 chardev: Fix QIOChannel refcount (use-after-free)
- 3f0170505e chardev: Don't attempt to unregister yank function more
than once (abort)
- a1708203b5 net/tap-linux.c: avoid abort when setting invalid fd (the
abort became reachable on reset through "virtio: Call set_features
during reset", which 10.0.x carries)
- 4733cb0833 block/io: skip head/tail requests on EINVAL (misaligned
guest discard pauses a werror=3Dstop guest)
- 1fec1f337a ahci: Fix leak of IRQState (minor)

## B. Need a context backport

- 9daa7347ff vfio/pci: Reject invalid MSI-X Table and PBA BIR values
  (conflicts only with the vfio_device_get_irq_info() conversion)
- 5bdc12fed5 hw/ide/ahci: drain the ports on teardown (use-after-free
on surprise removal of a hot-plugged AHCI controller)
- a35c5755d9 intel_iommu: fix guest-triggerable abort on oversized MMIO
access
- 24b9ebd5f1 hpet: fix bounds check for s->timer[] (no security impact
per the commit message; included for completeness)

On Fri, 2026-11-06 at 05:35 +0300, Michael Tokarev wrote:
> On 5/27/26 09:16, Vladimir Sementsov-Ogievskiy wrote:
> > Hi all. That's a preparation for vhost-user-blk backend-transfer
> > feature.
> >=20
> > 07: rebase on master,
> > 04: drop extra occurence of system_virtio_ss.add(files('vhost-user-
> > stub.c'))
> >=20
> > Vladimir Sementsov-Ogievskiy (22):
> > =C2=A0=C2=A0 vhost-user: rework enabling vrings
> > =C2=A0=C2=A0 vhost: drop backend_features field
> > =C2=A0=C2=A0 vhost-user: introduce vhost_user_has_protocol_feature() he=
lper
> > =C2=A0=C2=A0 vhost: move protocol_features to vhost_user
> > =C2=A0=C2=A0 vhost-user-gpu: drop code duplication
> > =C2=A0=C2=A0 vhost: make vhost_dev.features private
> > =C2=A0=C2=A0 virtio: move common part of _set_guest_notifier to generic=
 code
> > =C2=A0=C2=A0 virtio: drop *_set_guest_notifier_fd_handler() helpers
> > =C2=A0=C2=A0 vhost-user: keep QIOChannelSocket for backend channel
> > =C2=A0=C2=A0 vhost: vhost_virtqueue_start(): fix failure path
> > =C2=A0=C2=A0 vhost: make vhost_memory_unmap() null-safe
> > =C2=A0=C2=A0 vhost: simplify calls to vhost_memory_unmap()
> > =C2=A0=C2=A0 vhost: move vrings mapping to the top of vhost_virtqueue_s=
tart()
> > =C2=A0=C2=A0 vhost: vhost_virtqueue_start(): drop extra local variables
> > =C2=A0=C2=A0 vhost: final refactoring of vhost vrings map/unmap
> > =C2=A0=C2=A0 vhost: simplify vhost_dev_init() error-path
> > =C2=A0=C2=A0 vhost: move busyloop timeout initialization to
> > vhost_virtqueue_init()
> > =C2=A0=C2=A0 vhost: vhost_dev_init(): simplify features initialization
> > =C2=A0=C2=A0 hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifie=
r()
> > =C2=A0=C2=A0 vhost-user: make trace events more readable
> > =C2=A0=C2=A0 vhost-user-blk: add some useful trace-points
> > =C2=A0=C2=A0 vhost: add some useful trace-points
> =C2=A0From this pullreq, I'm picking the following changes for 10.0.x
> stable series
> (with small adjustments to apply to 10.0.x):
>=20
> =C2=A0 4e61c89262a vhost: final refactoring of vhost vrings map/unmap
> =C2=A0 4801e50cf1a vhost: vhost_virtqueue_start(): drop extra local
> variables
> =C2=A0 60abdf60d50 vhost: move vrings mapping to the top of
> vhost_virtqueue_start()
> =C2=A0 060ef8cac11 vhost: simplify calls to vhost_memory_unmap()
> =C2=A0 558084367e9 vhost: make vhost_memory_unmap() null-safe
> =C2=A0 c85f42703df vhost: vhost_virtqueue_start(): fix failure path
>=20
> Additionally, I'm picking
>=20
> =C2=A0 41d5e37e0e2 hw/virtio/vhost: Replace legacy
> cpu_physical_memory_*map() calls
>=20
> to 10.0.x too - this is basically a no-op change, but it makes
> subsequent changes to apply cleanly and makes older code closer
> to current, simplifying back-porting and making this back-
> porting easily verifiable.
>=20
> Please take a look at the 6 top commits starting
>=20
> =C2=A0
> https://gitlab.com/mjt0k/qemu/-/commits/16071441316f92915dccf08dabdddc722=
674e38c
>=20
> -- it should be very similar to the changes in this pull request, but
> a quick look is appreciated anyway.
>=20
> Is there anything else in this area which should be picked up too?=C2=A0
> Maybe
> some subsequent fixes?
>=20
> Thanks,
>=20
> /mjt

