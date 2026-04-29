Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BB7CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9XN-0002VO-Cq; Wed, 29 Apr 2026 14:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI9X3-0002Ql-Ee
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI9Wz-0003Tw-SN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777486864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLT/W6nBOBspKju0LC82NdfRBzt78wSEfuwGFqF/6qs=;
 b=eK+14fM9DiQ6Gq9Gig8eM1kkbobaltwoZ+y/VJbVLRhhL8xUVxBBJAH3uytK1RUJpN6z30
 ZN0sP0fiwAQQbjFN9utttMGa36LrqT318qUSlWsFdMJnPGBVk9fx9lSsEhtu7R+55BWTpJ
 F/aYuZeSNG0ujzBojWS3WSg/vtjCrGs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-1gAzoc_ZOdWyRNZXiqizvA-1; Wed,
 29 Apr 2026 14:21:01 -0400
X-MC-Unique: 1gAzoc_ZOdWyRNZXiqizvA-1
X-Mimecast-MFC-AGG-ID: 1gAzoc_ZOdWyRNZXiqizvA_1777486859
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FC5B19560B7; Wed, 29 Apr 2026 18:20:58 +0000 (UTC)
Received: from localhost (unknown [10.44.33.46])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A88E1300019F; Wed, 29 Apr 2026 18:20:56 +0000 (UTC)
Date: Wed, 29 Apr 2026 14:20:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org,
 sw@weilnetz.de, mjrosato@linux.ibm.com, farman@linux.ibm.com
Subject: Re: [PATCH v5 0/3] improve aio-polling efficiency
Message-ID: <20260429182054.GA7742@fedora>
References: <20260423195918.661299-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F7ilkUDNF5LB6TFj"
Content-Disposition: inline
In-Reply-To: <20260423195918.661299-1-jhkim@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--F7ilkUDNF5LB6TFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 02:59:15PM -0500, Jaehoon Kim wrote:
> Dear all,
>=20
> This is v5 of the patch series to refine aio_poll adaptive polling
> logic for better CPU efficiency.
>=20
> v1: https://lore.kernel.org/qemu-devel/20260113174824.464720-1-jhkim@linu=
x.ibm.com/
> v2: https://lore.kernel.org/qemu-devel/20260323135451.579655-1-jhkim@linu=
x.ibm.com/
> v3: https://lore.kernel.org/qemu-devel/20260405200735.3075407-1-jhkim@lin=
ux.ibm.com/
> v4: https://lore.kernel.org/qemu-devel/20260412215011.326196-1-jhkim@linu=
x.ibm.com/
>=20
> Changes in v5:
> - Patch 3/3: Fixed QAPI documentation based on review feedback:
>   * qapi/misc.json: Removed the sentence about returning poll-weight=3D0
>     since query-iothreads never returns 0 for this field.
>   * qemu-options.hx: Enhanced poll-weight parameter documentation to
>     match the detail level in qom.json, including information about
>     default value and typical value examples.
>=20
> Changes in v4:
> - Patch 2/3: Added detailed validation tables showing poll.ns statistics
>   across different poll_weight values (1-5) for SSD randread/randwrite
>   workloads to demonstrate algorithm behavior and justify poll_weight=3D3
>   as the optimal default.
>=20
> - Patch 3/3: Fixed commit message to correctly reference
>   adjust_polling_time() instead of the removed grow_polling_time()
>   and shrink_polling_time() functions from v2.
>=20
> Changes in v3:
> - Patch 1/3: Removed timeout check in aio_poll() as suggested by
>   Stefan Hajnoczi.
>=20
> - Patch 2/3: Major refactoring based on review feedback:
>   * Removed has_event and renamed poll_idle_timeout to
>     last_dispatch_timestamp from AioHandler structure to identify
>     active handlers.
>   * Merged grow_polling_time() and shrink_polling_time() into single
>     adjust_polling_time() function to simplify code review, with no
>     functional changes.
>   * Renamed adjust_block_ns() to update_handler_poll_times()
>   * Modified remove_idle_poll_handlers() to use last_dispatch_timestamp
>     directly instead of checking poll_idle_timeout
>   * Updated commit message
>=20
> - Patch 3/3: Enhanced parameter handling:
>   * Moved IOTHREAD_POLL_*_DEFAULT constants to iothread.h header
>   * Added validation for poll-weight range [0, 63] in iothread.c
>   * Added the divide-by-0 protection in aio_context_set_poll_params()
>   * Updated QAPI version from 10.2 to 11.1
>   * Enhanced qom.json documentation for poll-weight values
>=20
> This series reduces CPU usage in aio_poll adaptive polling by ~10%
> with minimal throughput impact (~2%). Tested on s390x with various
> workloads.
>=20
> Testing details:
>=20
> Initial testing (Fedora 42, 16 virtio-blk devices, FCP multipath):
>  - Throughput: -3% to -8% (1 iothread), -2% to -5% (2 iothreads)
>  - CPU usage: -10% to -25% (1 iothread), -7% to -12% (2 iothreads)
>=20
> Additional validation (RHEL 10.1 + QEMU 10.0.0, FCP/FICON, 1-8 iothreads):
>  - Throughput: -2.2% (weight=3D3), -2.4% (weight=3D2)
>  - CPU usage: -9.4% (weight=3D3), -10.9% (weight=3D2)
>=20
> Weight=3D3 selected for slightly better throughput while maintaining
> substantial CPU savings.
>=20
> Best regards,
> Jaehoon Kim
>=20
> Jaehoon Kim (3):
>   aio-poll: avoid unnecessary polling time computation
>   aio-poll: refine iothread polling using weighted handler intervals
>   qapi/iothread: introduce poll-weight parameter for aio-poll
>=20
>  include/qemu/aio.h                |   7 +-
>  include/system/iothread.h         |  18 ++++
>  iothread.c                        |  47 +++++++---
>  monitor/hmp-cmds.c                |   1 +
>  qapi/misc.json                    |   6 ++
>  qapi/qom.json                     |  10 +-
>  qemu-options.hx                   |   8 +-
>  tests/unit/test-nested-aio-poll.c |   2 +-
>  util/aio-posix.c                  | 148 ++++++++++++++++++------------
>  util/aio-posix.h                  |   2 +-
>  util/aio-win32.c                  |   3 +-
>  util/async.c                      |   2 +
>  12 files changed, 176 insertions(+), 78 deletions(-)
>=20
> --=20
> 2.50.1
>=20

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--F7ilkUDNF5LB6TFj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnyTAYACgkQnKSrs4Gr
c8gBYwf/RXFpKg0il+IlPuDMa2btd00fscTimFL+r1Ka7pLPQPAEeFZry1lGDFG1
h+cf6LN7tVrXEN8HCp37ooi7zbG+uK24H7AhorWTZNlKSF6pWiGtGlObEXiJ3fYB
3uS0DphQGTkCyr37qoHOm79GtK69CibOzka92+NlbIMbwLUp4coqZHeZBKInZu7b
OT9cd4I3QzXEph3Uq5JH58WlZvNOGKPPsYTn/uVQVh77xwyKjG9htD/7eM4fIKpZ
MgRBqdndb1YA7DBNReU3tVjZVUH7Y4hGc7m+nnlvJoMyWIpHFR2hlx/R+bcHC1Gg
IrGwKLeUZfcVsLplM7Ss+u87cl670w==
=VYoG
-----END PGP SIGNATURE-----

--F7ilkUDNF5LB6TFj--


