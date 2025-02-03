Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E87C02197
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1ZU-0003wg-2O; Mon, 03 Feb 2025 13:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1ZT-0003w9-AD
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:53:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1ZR-0005hB-UB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738608800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+aIyUtfyEnpRP2Kl4GUKwBE+x6XUwAW4mOj1yqPSqW8=;
 b=PPucoA6x4cC3gdPjyh5td7stMddISahyan/cA/kVBNX5DrqfQu5IDmwFW5ZrIgDuaglsQe
 BhorSXVSCgWShoYzLZwMcWxxKUE7vJdwaeSj3YNtt0vgRS4kyBTUPBh0K5FM5DdTxVPuO9
 7lRrus6YjvGke6dK0LUASyA7UvOXbaM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-HW0iJn5KNW63Vw8VM-hKgw-1; Mon,
 03 Feb 2025 13:53:16 -0500
X-MC-Unique: HW0iJn5KNW63Vw8VM-hKgw-1
X-Mimecast-MFC-AGG-ID: HW0iJn5KNW63Vw8VM-hKgw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8EAA18009C5; Mon,  3 Feb 2025 18:53:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D9B11956095; Mon,  3 Feb 2025 18:53:14 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:53:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 07/15] block: Add option to create inactive nodes
Message-ID: <20250203185314.GI268514@fedora>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-8-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Et9LXKLqoIlLNwpG"
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-8-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Et9LXKLqoIlLNwpG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 06:12:38PM +0100, Kevin Wolf wrote:
> In QEMU, nodes are automatically created inactive while expecting an
> incoming migration (i.e. RUN_STATE_INMIGRATE). In qemu-storage-daemon,
> the notion of runstates doesn't exist. It also wouldn't necessarily make
> sense to introduce it because a single daemon can serve multiple VMs
> that can be in different states.
>=20
> Therefore, allow the user to explicitly open images as inactive with a
> new option. The default is as before: Nodes are usually active, except
> when created during RUN_STATE_INMIGRATE.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json         | 6 ++++++
>  include/block/block-common.h | 1 +
>  block.c                      | 9 +++++++++
>  3 files changed, 16 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Et9LXKLqoIlLNwpG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmehEJkACgkQnKSrs4Gr
c8jB3wf+NC+QPsfmI+51aOwBgJQ95EEGuEDSSC01TMlJrRaIBHP5LpFNw+O1lBnW
Nji/FHo1B+T8iPFeNBJ8JtztRx7zFsK9wU+fTWDaiswylfUoARgIQGeZFdFo7YOV
rhdk9rC7m0PrmAY+lNDMwaOy4ZVOvJ+8gkl4Yyf3nDTxBIWjhtTF3mMt5paF/W6M
ceNX31Mm9lAJAnj3H6E8mInmJhhUqdFKpNHoo7t/7vSX1uZqLWzBuRzmqsHeJ5h9
k8IsGoRusS2UcYaJzIXgtLJsrhX4eWvbo7DoXoWLfuMdmCvsMZ9mNRzHae+emsu9
+BPJx926imCalCQcPhbpVpauOghPng==
=Ncg8
-----END PGP SIGNATURE-----

--Et9LXKLqoIlLNwpG--


