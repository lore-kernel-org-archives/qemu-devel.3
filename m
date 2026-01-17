Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA16C98327
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 14:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh6s1-0002lc-QX; Sat, 17 Jan 2026 09:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6rT-0002W8-K7
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:01:23 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6rD-0007IZ-Ed
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768658439; x=1769263239; i=lukasstraub2@web.de;
 bh=9JQrJyYzxVrbAhlNyLcEKbLB9DGsw0YR0nRZUd/N9fY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=vQDzxm66kOZ3MCr0KdKvNumE+3TnvhxHkwE1+jN5hrcqeoWWRhRv/PzQfC32Yml+
 rWm29V65lZrKgPhqM5FybbhCvruGKsH8rp6u7UqTbHlYuVfsLMGh+34JiY5OWnf6m
 s2+AmWlwVQl4vU5VV2tMh2ZXnMOano2QRlKcuPXv78curajjT1e++axzOd3sn11Hx
 ljjGR8HJaXw1XhQZwoU8mlZTVUTPTcJowVx6HBf5LsuAJnRRXJghM/NH/Jc0LGnJr
 ltxUziV7dw7Bl3ice7Whvbtt28VmBzPxc6PdIp5Z6YihFH95w3LuMZ8bR2rxWG7tX
 J89xbLeLo4tDYl4Y/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.100.70]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BI2-1voEBd0TUs-014EA4; Sat, 17
 Jan 2026 15:00:39 +0100
Date: Sat, 17 Jan 2026 15:00:37 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>, "Dr . David Alan
 Gilbert" <dave@treblig.org>, Prasad Pandit <ppandit@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 00/13] migration: Threadify loadvm process
Message-ID: <20260117150037.605c9744@penguin>
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ErhH_ZfTw/sFNmFuxpCIxtl";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:e2IRQbWco3Qyfnx9y8lTv4KxLQl8cm1l/6QPr0fiqL2ELpLRI5v
 BDZK5UR7k+/6jP+clNhWD7RF+XO6YD2Gcf+CWfvbBM3zQ/7vHQChpDW7WrLz8oK7sb4oi3Q
 BS56y7SwlG5WqkWY47zRzFpgQY7RAVr7RjcqDXxCBEUHomm4seg9FGCJKOCPUMX1kOhwZ9x
 38E2+78q5qhlFZuF/QdtA==
UI-OutboundReport: notjunk:1;M01:P0:hMYfKQxBj0k=;U3fOzswlOgRsFZRzqBVyOB40y7o
 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
 uQ7EaPOQcW9kImYNuv0je2O/kk21b
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/ErhH_ZfTw/sFNmFuxpCIxtl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Oct 2025 15:25:59 -0400
Peter Xu <peterx@redhat.com> wrote:

> This is v1, however not 10.2 material.  The earliest I see fit would still
> be 11.0+ even if everything goes extremely smooth.
>=20
> Removal of RFC is only about that I'm more confident this should be able =
to
> land without breaking something too easily, as I smoked it slightly more
> cross-archs this time.  AFAIU the best (and possibly only..) way to prove
> it solid is to merge it.. likely in the early phase of a dev cycle.
>=20
> The plan is we'll try to get to more device setups too soon, before it
> could land.
>=20
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Nowadays, live migration heavily depends on threads. For example, most of
> the major features that will be used nowadays in live migration (multifd,
> postcopy, mapped-ram, vfio, etc.) all work with threads internally.
>=20
> But still, from time to time, we'll see some coroutines floating around t=
he
> migration context.  The major one is precopy's loadvm, which is internally
> a coroutine.  It is still a critical path that any live migration depends=
 on.
>=20
> A mixture of using both coroutines and threads is prone to issues.  Some
> examples can refer to commit e65cec5e5d ("migration/ram: Yield periodical=
ly
> to the main loop") or commit 7afbdada7e ("migration/postcopy: ensure
> preempt channel is ready before loading states").
>=20
> It was a coroutine since this work (thanks to Fabiano, the archeologist,
> digging the link):
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2012-08/msg01136.html
>=20
> [...]
>
> Tests
> =3D=3D=3D=3D=3D
>=20
> Default CI passes.
>=20
> RDMA unit tests pass as usual. I also tried out cancellation / failure
> tests over RDMA channels, making sure nothing is stuck.
>=20
> I also roughly measured how long it takes to run the whole 80+ migration
> qtest suite, and see no measurable difference before / after this series.
>=20
> I didn't test COLO, I wanted to but the doc example didn't work.
>=20
> Risks
> =3D=3D=3D=3D=3D
>=20
> This series has the risk of breaking things.  I would be surprised if it
> didn't..
>=20
> The current way of taking BQL during FULL section load may cause issues, =
it
> means when the IOs are unstable we could be waiting for IO (in the new
> migration incoming thread) with BQL held.  This is low possibility, thoug=
h,
> only happens when the network halts during flushing the device states.
> However still possible.  One solution is to further breakdown the BQL
> critical sections to smaller sections, as mentioned in TODO.
>=20
> Anything more than welcomed: suggestions, questions, objections, tests..
>=20
> TODO
> =3D=3D=3D=3D
>=20
> - Finer grained BQL breakdown
>=20
> Peter Xu (13):
>   io: Add qio_channel_wait_cond() helper
>   migration: Properly wait on G_IO_IN when peeking messages
>   migration/rdma: Fix wrong context in qio_channel_rdma_shutdown()
>   migration/rdma: Allow qemu_rdma_wait_comp_channel work with thread
>   migration/rdma: Change io_create_watch() to return immediately
>   migration: Introduce WITH_BQL_HELD() / WITH_BQL_RELEASED()
>   migration: Pass in bql_held information from qemu_loadvm_state()
>   migration: Thread-ify precopy vmstate load process
>   migration/rdma: Remove coroutine path in qemu_rdma_wait_comp_channel
>   migration/postcopy: Remove workaround on wait preempt channel
>   migration/ram: Remove workaround on ram yield during load
>   migration: Allow blocking mode for incoming live migration
>   migration/vfio: Drop BQL dependency for loadvm SWITCHOVER_START
>=20
>  include/io/channel.h        |  15 +++
>  include/migration/colo.h    |   6 +-
>  migration/migration.h       | 109 +++++++++++++++++--
>  migration/savevm.h          |   4 +-
>  hw/vfio/migration-multifd.c |   3 -
>  io/channel.c                |  21 ++--
>  migration/channel.c         |   7 +-
>  migration/colo-stubs.c      |   2 +-
>  migration/colo.c            |  26 ++---
>  migration/migration.c       |  81 ++++++++------
>  migration/qemu-file.c       |   6 +-
>  migration/ram.c             |  13 +--
>  migration/rdma.c            | 204 ++++++++----------------------------
>  migration/savevm.c          |  98 +++++++++--------
>  migration/trace-events      |   4 +-
>  15 files changed, 291 insertions(+), 308 deletions(-)
>=20

Works well in my COLO testing. Fro the whole series:

Tested-by: Lukas Straub <lukasstraub2@web.de>

--Sig_/ErhH_ZfTw/sFNmFuxpCIxtl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmlrlgUACgkQNasLKJxd
sljp4w/444IFCCEXM4dSAfRR652I4kPOD1JjbeLgP9DyDK/1iL5ZhaGxcDuDxQDT
TwmKShAHiIIROnEzBRGn8rcmqzfr/JFHgDPCFkFWdwDvJXAFu6jCn1gnYO2RcL7N
uOJ3IxoOEp4Is7UbkO0yWc0Du3FD4DN142r6r9j7j9r1fa1r/Y2owuCfqp9LRNSo
Ro7pVWjaE2bj2izAPE9kojG1uV9eUHVBoUUfZ/vX5HEnaG50Dv2ZFMGyMWsotqPP
Z2bKUAuPVO9dg4vzMhhm9qI8qFxsiFB9FG3ZnXnUNYWXpS1/JBWntVGJIV4De7pV
1nwVO68BDNvr9/DifKjC5XtMJpRAKynKJ3NsoE05MUf8qDe3iNm9VaIiE0VYkiAG
fC/sGGI//FpiV42ozTPOu15QYPB0DkciJGRjgaMtpQSef6ULeaeMn9tgZ424my0B
2H/M7xfGfihfXFKfvN04Ef2xOJphzBq6qGVlLzg9tY8OW5p3oSJS3yGC4Qwl4r1j
m9YCC+Dq4WKCePpCL8VXSYh2nT3Kypbfnfqt9/VF6Iq70sU8l9cR9PqGr8zM0H0O
FS8ij+7gNegBIPC7lqqzTZG6f39unhVQI2Ky8Y1EBZef7f0S9NB0q0Jh64RT5y9O
lfSVtW3aoLxTmAfU9s9XGMjZ1gCPieulz7+aFifVmEuzvLMZWQ==
=f+EJ
-----END PGP SIGNATURE-----

--Sig_/ErhH_ZfTw/sFNmFuxpCIxtl--

