Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E929C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x287I-0000jA-Kb; Thu, 03 Sep 2026 10:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x287D-0000iZ-IM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x2879-0002qu-FG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788444503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=36VLk+7LXaXFLvWZZuqz7WQUgZdnyHyTKFuVEH378R8=;
 b=Kr7QA8WdgVmrvyP3Mklkp2PWkg1UjkjlaCx8+xKZu+j1Cuxp4nM2ijLW0X2X2AIJp7DIV+
 RMyuoR3ILN0ICHZr8/1eezx62n+RdnV/nR9gM8PuRhrcQLWgADKy+Jio0SfiM/kGwyEdCY
 RYI7QfWzxVIXSZm1ZIdi3iIJ0wAOuFs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-V_qGsNTHN4mVzSPcHc5mlw-1; Thu,
 03 Sep 2026 10:08:18 -0400
X-MC-Unique: V_qGsNTHN4mVzSPcHc5mlw-1
X-Mimecast-MFC-AGG-ID: V_qGsNTHN4mVzSPcHc5mlw_1788444497
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53F24191F588; Thu,  3 Sep 2026 14:08:17 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4B3918005B1; Thu,  3 Sep 2026 14:08:16 +0000 (UTC)
Date: Thu, 3 Sep 2026 10:08:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/9] block: BLOCK_IO_DELAY event
Message-ID: <20260903140815.GC825275@fedora>
References: <20260831135206.126184-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3Qh9akULXbZrVj+z"
Content-Disposition: inline
In-Reply-To: <20260831135206.126184-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--3Qh9akULXbZrVj+z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 03:51:56PM +0200, Hanna Czenczek wrote:
> Based-on: <20260724152315.234183-1-hreitz@redhat.com>
>           [PATCH 0/6] hw/[block]: Fix missing accounting
>           Fri, 24 Jul 2026 17:23:09 +0200
>=20
> Hi,
>=20
> I=E2=80=99m told there are installations where storage is very slow, and =
some
> would like the VM stack to report this proactively.  To do so, we should
> (via QAPI events) report on extremely slow I/O requests.
>=20
> We already have the latency histogram, but this is not deemed sufficient
> because it is not proactively reporting and would require repeated
> querying.  Therefore, this series introduces the event still.
>=20
> Now, from a user's perspective, it would be nice if this event could be
> raised exactly when an I/O request crosses the user-defined threshold,
> but this would require keeping all active requests in a list and
> checking it periodically.  Now, if we used latency cookies for this

Did you consider a per-request timer? The QEMUTimerList active_timers
sorted list does not support efficient insertion, but improving it would
benefit all timer API users.

> (which makes sense), then that would require that every cookie set up is
> also finalized when the request is done, because if we don't, results
> could well be catastrophic:
> - Either we use cookies as-is, which are often allocated on the stack or
>   in some other structure managed by the device; then this would result
>   in use-after-free,
> - Or we allocate something specifically for this checking, so lingering
>   requests would at most create spurious latency events and memory
>   leaks, but this would require an additional heap allocation per
>   request that we would probably want to avoid.
>=20
> So ideally we could use latency cookies and could statically verify that
> they are always finalized when the request is done, but doing this in C
> may well be impossible.

I think you are saying that the cookie API is unsafe because cookie
lifetime is not bounded by the request lifetime?

Maybe the block_acct_*() API can be integrated into the actual request
so there is no way to leak the cookie. In other words, directly
associate requests with a BlockAcctStats and stop requiring the user to
manually manage a separate BlockAcctCookie.

The API is already weird because devices use:

  block_acct_failed(blk_get_stats(s->blk), &req->acct);

i.e. why does the device have to reach into s->blk to access the stats?
If the stats belong to s->blk, then s->blk should do the accounting
during the request lifetime.

This would require a redesign of not just the cookie API, but also the
error policy API. There is also a wrinkle in that virtio-blk merges I/O
requests and accounts the merges.

>=20
>=20
> So, because it is basically impossible (or at least it would be very
> hard, and presumably require a large refactoring) to guarantee, without
> additional heap allocations, that a list of active requests won=E2=80=99t=
 run
> into catastrophic use-after-frees, this series does the much simpler
> version first, which is to just raise an event when a request *finishes*
> and took more than a user-defined latency threshold.

Does this achieve the goal of warning when requests exceed a threshold?
When an I/O request hangs for a long time, the management tool will be
unable to detect that the threshold has been exceeded in a timely
manner.

>=20
>=20
> (PS: The nice thing about throwing an alert while the request is still
> going on would be that it could allow us to also stop the VM in case of
> excessive latency, before the request completes, so the guest would be
> shielded from such excessive latency.  This might be useful for Windows
> guests that just have a maximum request lantency before throwing a
> BSOD.)
>=20
>=20
> Hanna Czenczek (9):
>   block/accounting: Add offset to BlockAcctCookie
>   qapi/block: Add IoAccountingOperation enum
>   qapi/block: Add BLOCK_IO_DELAY event
>   block-backend: Public blk_get_attached_dev_path()
>   block/accounting: Add BB field to latency checker
>   block/accounting: Emit BLOCK_IO_DELAY event
>   block: Add delay-alert-ms property
>   block/accounting: Move latency_ns override down
>   iotests: Add delay-alert test
>=20
>  qapi/block.json                          |  52 +++++++++
>  include/block/accounting.h               |  20 +++-
>  include/hw/block/block.h                 |   5 +-
>  include/system/block-backend-io.h        |   9 ++
>  include/system/dma.h                     |   2 +-
>  block/accounting.c                       |  60 ++++++++--
>  block/block-backend.c                    |   8 +-
>  blockdev.c                               |  16 ++-
>  hw/block/block.c                         |   4 +-
>  hw/block/dataplane/xen-block.c           |   4 +-
>  hw/block/virtio-blk.c                    |  15 +--
>  hw/ide/ahci.c                            |   6 +-
>  hw/ide/atapi.c                           |   9 +-
>  hw/ide/core.c                            |   9 +-
>  hw/ide/macio.c                           |  15 ++-
>  hw/nvme/ctrl.c                           |  43 ++++---
>  hw/nvme/dif.c                            |   8 +-
>  hw/scsi/scsi-disk.c                      |  28 +++--
>  qemu-io-cmds.c                           |  14 +--
>  system/dma-helpers.c                     |   4 +-
>  tests/unit/test-block-accounting.c       |   2 +-
>  tests/qemu-iotests/172.out               |  38 +++++++
>  tests/qemu-iotests/tests/delay-alert     | 136 +++++++++++++++++++++++
>  tests/qemu-iotests/tests/delay-alert.out |  46 ++++++++
>  24 files changed, 472 insertions(+), 81 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/delay-alert
>  create mode 100644 tests/qemu-iotests/tests/delay-alert.out
>=20
> --=20
> 2.55.0
>=20

--3Qh9akULXbZrVj+z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqZf08ACgkQnKSrs4Gr
c8hraAf9EcCkxFsx8DtPU89EkcJud7DyGTNq6t+O8sJ/Mfa8xwSFU9eUKzz555Cv
G4W735wF9ULtUGKnpnu2MfPJZxC6MfdeSStZCjVt62rKUlAAMG7bi7MVnVlArGr0
vPwWpo9j/WPOq69tqPpd5BjAYrI5YisqrXv6VQaRh+1uLwaQKKMcGshMrjA8cfUa
rwj6JpMkdhnZgpSRPCVwHcNcV7GSCmiMuCQaDqeiVHc5Z7vcgGyum5BER0+9JYoZ
D9ibH42vCtLOvfSBEVARYNSEvZ//sG6yc53U1uUeb4bFhiu3tEjOg6VFO42/TxH8
YO5fnN0m3L1BYTnJ5ZKvFv2R+Di7Aw==
=Wtw4
-----END PGP SIGNATURE-----

--3Qh9akULXbZrVj+z--


