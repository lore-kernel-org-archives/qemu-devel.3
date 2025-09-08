Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FEDCAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzH7-0006DB-9Q; Tue, 09 Sep 2025 10:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvzH5-0006Cu-1W
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:24:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvzH2-0001ST-BJ
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757427877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2zV4qrnHnmm9tRZunQhsh8AyQqMkyCryXkmqhKALE0I=;
 b=g2gLvX6HK+FbT0g2QOwA9VaiiORyuIn5hppwlJaErueU5u2FxJwKrlY68vJ7vP8eOoUdjS
 X8TiEnXkMdmiregyAje1Cj/OhAXFoan+BykLHi1DgYmk6GtltruqaJlMRzvJx9fVQHRWNw
 f+Z+dYhDML9Nw+liBhelgxN8z6bGLJs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-qwfVW8ygPciyvtO7yhxZ0A-1; Tue,
 09 Sep 2025 10:24:33 -0400
X-MC-Unique: qwfVW8ygPciyvtO7yhxZ0A-1
X-Mimecast-MFC-AGG-ID: qwfVW8ygPciyvtO7yhxZ0A_1757427872
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28C0B193E894; Tue,  9 Sep 2025 14:24:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 325361800576; Tue,  9 Sep 2025 14:24:29 +0000 (UTC)
Date: Mon, 8 Sep 2025 14:24:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] bql: Fix bql_locked status with condvar APIs
Message-ID: <20250908182453.GD167158@fedora>
References: <20250904223158.1276992-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fcKCU61QGnf0kVjB"
Content-Disposition: inline
In-Reply-To: <20250904223158.1276992-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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


--fcKCU61QGnf0kVjB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2025 at 06:31:58PM -0400, Peter Xu wrote:
> QEMU has a per-thread "bql_locked" variable stored in TLS section, showing
> whether the current thread is holding the BQL lock.
>=20
> It's a pretty handy variable.  Function-wise, QEMU have codes trying to
> conditionally take bql, relying on the var reflecting the locking status
> (e.g. BQL_LOCK_GUARD), or in a GDB debugging session, we could also look =
at
> the variable (in reality, co_tls_bql_locked), to see which thread is
> currently holding the bql.
>=20
> When using that as a debugging facility, sometimes we can observe multiple
> threads holding bql at the same time. It's because QEMU's condvar APIs
> bypassed the bql_*() API, hence they do not update bql_locked even if they
> have released the mutex while waiting.
>=20
> It can cause confusion if one does "thread apply all p co_tls_bql_locked"
> and see multiple threads reporting true.
>=20
> Fix this by moving the bql status updates into the mutex debug hooks.  Now
> the variable should always reflect the reality.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> rfc->v1
> - Fix comment [Stefan]
> ---
>  include/qemu/main-loop.h  | 18 ++++++++++++++++++
>  util/qemu-thread-common.h |  7 +++++++
>  stubs/iothread-lock.c     |  9 +++++++++
>  system/cpus.c             | 14 ++++++++++++--
>  4 files changed, 46 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fcKCU61QGnf0kVjB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmi/H3UACgkQnKSrs4Gr
c8i9cQf8DeOB8KrzlyGYUJw9TcqMxNXfqQtb3bES4f46T/zXsx5iMUj2g3c08AQt
1J7Zh5elymdlP5L9l33QtVAos8EfDGmHIRIm4lq0fuaCKWBt0zLJ88uOgDUIRm3k
9pOO5/18rkcJ+nAh4Vq9czMj9FqlA4eQ8s3UpzyJRIQ3bjJezOq0a5rUSGuyrclH
xid782z1Gr1WoHsVob6Ym0nx2EhOmNRgSQIHoOyyaYgMMh0QVx89LR6Z9uvtXBCs
GGAHdt/j+jpwkwloRpqu0VWfPHGVLS5pJ4exLSs7s+XI7DNdOYn+XJZT0j+BIvb4
JQSG59UFLozPTFZYy48zMK7KpMbdiQ==
=27Y+
-----END PGP SIGNATURE-----

--fcKCU61QGnf0kVjB--


