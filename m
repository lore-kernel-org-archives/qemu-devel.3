Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94249C02198
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 19:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1ww-0002gb-Sz; Mon, 03 Feb 2025 14:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1wt-0002ft-MP
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:17:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1wq-000859-Jh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738610251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RY+ZOiDLlRpy5SOmsuYtKe9HtWov+ng+VFZJcjrGh+s=;
 b=dt5xO+efC4coaVxwX4+jwKgOxQZvcQfBrU9Rx/gCrRKxXg18n1lx11kIGnCIKwphSgFCtr
 WAq55YJnS0A+PeGSyhrVrYxoyO90QKt4in8UAMVKr2ptcdc88FsbjOIq4qV+XSDcKL87cz
 TJqoel8ohefKn99rtj8sndBxny4Y0Fo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-8GvUBZhYP7GeM70Vj1X8mw-1; Mon,
 03 Feb 2025 14:17:26 -0500
X-MC-Unique: 8GvUBZhYP7GeM70Vj1X8mw-1
X-Mimecast-MFC-AGG-ID: 8GvUBZhYP7GeM70Vj1X8mw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA7D71956083; Mon,  3 Feb 2025 19:17:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 367111800358; Mon,  3 Feb 2025 19:17:21 +0000 (UTC)
Date: Mon, 3 Feb 2025 14:17:20 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 11/15] block/export: Add option to allow export of
 inactive nodes
Message-ID: <20250203191720.GM268514@fedora>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250131095051.49708-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tV1JUUZYSWlArKnX"
Content-Disposition: inline
In-Reply-To: <20250131095051.49708-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--tV1JUUZYSWlArKnX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 10:50:47AM +0100, Kevin Wolf wrote:
> Add an option in BlockExportOptions to allow creating an export on an
> inactive node without activating the node. This mode needs to be
> explicitly supported by the export type (so that it doesn't perform any
> operations that are forbidden for inactive nodes), so this patch alone
> doesn't allow this option to be successfully used yet.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-export.json             | 10 +++++++++-
>  include/block/block-global-state.h |  3 +++
>  include/block/export.h             |  3 +++
>  block.c                            |  4 ++++
>  block/export/export.c              | 31 ++++++++++++++++++++----------
>  5 files changed, 40 insertions(+), 11 deletions(-)
>=20
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index ce33fe378d..117b05d13c 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -372,6 +372,13 @@
>  #     cannot be moved to the iothread.  The default is false.
>  #     (since: 5.2)
>  #
> +# @allow-inactive: If true, the export allows the exported node to be in=
active.
> +#     If it is created for an inactive block node, the node remains inac=
tive. If
> +#     the export type doesn't support running on an inactive node, an er=
ror is
> +#     returned. If false, inactive block nodes are automatically activat=
ed before
> +#     creating the export and trying to inactivate them later fails.
> +#     (since: 10.0; default: false)

Exposing activation in the API is ugly but I don't see a cleaner option
given that we cannot change block-export-add's existing behavior of
activating the node by default. :(

Ideally block-export-add would not modify active/inactive and leave it
up to user to provide a node in the desired state.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tV1JUUZYSWlArKnX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmehFkAACgkQnKSrs4Gr
c8hSgggAgLG2dqN913Bv0Y5aQeVBoBONSb5MSwi9vspMUZcYQLsGOmb1qCsUmxJh
jjDA4Iqb+jnkGQ/RLWbGYOSvotCbQdymGoyV9hX6ZNN+LqTHGTfSWcm8ELGTPjx2
LLaSvXDVcZlB9NAF8h08wCHBFatlzyc5pxznJHH4AyDpSZMW/VPG5Q1/CQDgCLtw
Lxnm1PPKGa7PinkgZ7ovq0DNESu/YNK62EAriOLEoWR3S/zUyXWcSADgo8H9/7fI
MkF8xGM4EarWIKJvkiOpoXJDrKvtEAVkzAu8QUfgEckCvSxXW4Qd3FnCp7H7a3UY
wrEGaiXpbH5p2tz6VwXv8QSHAf7eaA==
=qQBO
-----END PGP SIGNATURE-----

--tV1JUUZYSWlArKnX--


