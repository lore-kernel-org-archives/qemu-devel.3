Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9389D13C3F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 16:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkP45-0004D8-OF; Mon, 26 Jan 2026 11:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vkP1O-0002io-KQ
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:01:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vkP15-0004Hc-Rz
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769443123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DqQqjLhAYOoKAlnO25/I8mSuw85u6+HP8kcpQCXE9iY=;
 b=T/Es1PCNbhcuH/hLxqrfT+HmUOplWsYNceW5RFsy3dVsNinHl/QHbu1Shv92UekEMG8B+8
 n5A0hjVfW9bqHPmnhj+62G7txMSyxk8iRChi3amwXa8imL4fJTj+tGz12aq/VWPLsIC54i
 KzQckcuqAN2uGioGLYDtWJ5cOGnYM48=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-IijrAfndNGW3WSSZBgWdGw-1; Mon,
 26 Jan 2026 10:58:39 -0500
X-MC-Unique: IijrAfndNGW3WSSZBgWdGw-1
X-Mimecast-MFC-AGG-ID: IijrAfndNGW3WSSZBgWdGw_1769443118
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F5ED19775A6; Mon, 26 Jan 2026 15:58:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.173])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2198A180049F; Mon, 26 Jan 2026 15:58:37 +0000 (UTC)
Date: Mon, 26 Jan 2026 10:58:36 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH 0/5] migration: Notifier fixes for 11.0
Message-ID: <20260126155836.GC7901@fedora>
References: <20260122230331.3543312-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6cb0bO2OrymOA7bc"
Content-Disposition: inline
In-Reply-To: <20260122230331.3543312-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--6cb0bO2OrymOA7bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 06:03:26PM -0500, Peter Xu wrote:
> CI: https://gitlab.com/peterx/qemu/-/pipelines/2280356561
>=20
> Two major goals for this small series:
>=20
> - Fix postcopy issue where DONE and FAILED notifiers will be invoked twice
>=20
> - Move FAILED notifier to be before vm_start() if the failure happens
>   during switchover (where we will stop the VM first)
>=20
> The 2nd goal will be needed by Stefan's ongoing work on block persistent
> reservations, where a fallback should be required on src to happen before
> vm_start().  Instead of introducing another FAILED_BEFORE_START, this
> patchset should make FAILED work instead.
>=20
> Patch 1 adds a tracepoint for me to verify this fix.
>=20
> Patch 2-3 are the real changes of above two.
>=20
> Patch 3-4 are some cleanups alone the context that we can do, hence
> attached at the end.
>=20
> More details in commit logs individually.  Comments welcomed, thanks.
>=20
> Peter Xu (5):
>   migration: Add a tracepoint for invoking migration notifiers
>   migration: Fix double notification of DONE/FAIL for postcopy
>   migration: Notify migration FAILED before starting VM
>   migration: Drop explicit block activation in postcopy fail path
>   migration: Rename MIG_EVENT_PRECOPY_* to MIG_EVENT_*
>=20
>  include/migration/misc.h | 15 ++++++++-------
>  hw/intc/arm_gicv3_kvm.c  |  2 +-
>  hw/net/virtio-net.c      |  4 ++--
>  hw/vfio/cpr-legacy.c     |  2 +-
>  hw/vfio/cpr.c            |  8 ++++----
>  hw/vfio/migration.c      |  4 ++--
>  migration/cpr-exec.c     |  6 +++---
>  migration/migration.c    | 30 +++++++++++++++++++++---------
>  net/vhost-vdpa.c         |  4 ++--
>  ui/spice-core.c          |  7 ++++---
>  migration/trace-events   |  1 +
>  11 files changed, 49 insertions(+), 34 deletions(-)
>=20
> --=20
> 2.50.1
>=20

Thank you!

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--6cb0bO2OrymOA7bc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAml3jywACgkQnKSrs4Gr
c8ghgAf/XJ+WruWKDDGI0qBhaNml3GRTypH6khyTpQIo+CwKHHkIo4R3mecLxyyp
UsHPkw31ppaOf6JOVwbzXrC0DUyTSfsZbJLQpFL/RGYnDju6v9Hm7OXNIGO4vb1Q
s8fr8NeY24Ex0qxVmZiUo0ZaTQTfam6M9TmjT8j/Mqtafbon0iZDZKRKlGAIRst2
fvsJmgrh75i4l7+/d3DXCQ7FOZ5WIQiCJ0TeUOpEpec2SOh7aYSEK2vE3nM1hw9e
2hh7uUOeqiGJhnA9wdbN7tc1Mxkrsi+krcfz38dhkFuLgJTnCl6qQB/DymvC16fP
im1xR4hA6+GUHjrbbD+ynYHjC26vjQ==
=sLR+
-----END PGP SIGNATURE-----

--6cb0bO2OrymOA7bc--


