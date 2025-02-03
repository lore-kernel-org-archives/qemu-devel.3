Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440A7C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1WM-0000Hw-Bo; Mon, 03 Feb 2025 13:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1W8-00009g-TD
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:49:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1W7-00059R-HJ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738608594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ij84B39uJp93AKrqYtusamGATWW6lauP++sAGcuRCKs=;
 b=dXGe/yML+1IRmrTSiIYKRlbLyY6omk6w0zjs7KCafLyqGx03atapH8J0RrdEFezzaee3pw
 mdG0VB5vxvMJYipxikAdQ6N5WM5mfLMojmMFpIjdQtQjD06BG5999q8seh1v9EQ5Wo7uww
 vH7VsnirvRqyTP5Fd/lDNzEaYrYItyA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-EnIyXS0GP_C5CCkL-RV3rg-1; Mon,
 03 Feb 2025 13:49:51 -0500
X-MC-Unique: EnIyXS0GP_C5CCkL-RV3rg-1
X-Mimecast-MFC-AGG-ID: EnIyXS0GP_C5CCkL-RV3rg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EA4C195608A; Mon,  3 Feb 2025 18:49:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1D7F19560AD; Mon,  3 Feb 2025 18:49:49 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:49:48 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 03/15] migration/block-active: Remove global active flag
Message-ID: <20250203184948.GE268514@fedora>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+AVar+9pDleK+I2g"
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-4-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--+AVar+9pDleK+I2g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 06:12:34PM +0100, Kevin Wolf wrote:
> Block devices have an individual active state, a single global flag
> can't cover this correctly. This becomes more important as we allow
> users to manually manage which nodes are active or inactive.
>=20
> Now that it's allowed to call bdrv_inactivate_all() even when some
> nodes are already inactive, we can remove the flag and just
> unconditionally call bdrv_inactivate_all() and, more importantly,
> bdrv_activate_all() before we make use of the nodes.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  migration/migration.h    |  3 ---
>  migration/block-active.c | 46 ----------------------------------------
>  migration/migration.c    |  8 -------
>  3 files changed, 57 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+AVar+9pDleK+I2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmehD8wACgkQnKSrs4Gr
c8gNKAf/ZNKjp9B4CbXuzjy6JLh7+F4/twPNDOJ47OJkYgetAOsPhUopg62trtJa
0lFBHHvXUexTocjyvIocGAAUgb6qHqjCJ/a7bXLUPmaabi6vfxQ6FIGK1Shqz3rR
cmwLnSbuN/coAqz3ziBU8RlCTNGdLBaMe6usPMdnH7aOLZYk+wwdK4O9qm54qrPE
BjqddZY7ukf8GBbzePjPRMN1u8ETBG/iZC0dqRjb5/trwEUBUiz5syp6LI5ZdZI2
AEYI6NmPBUKXhypF2hmmTn5GI61bPZYhl4CzZBpZ2p23hybF+QQ5jOyRmq+PuJfS
axNEQlCzL7FO+a07okwVyv7rAnWgTQ==
=CgSR
-----END PGP SIGNATURE-----

--+AVar+9pDleK+I2g--


