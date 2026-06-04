Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17B2CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVE4A-0006gI-1K; Thu, 04 Jun 2026 15:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVE47-0006g9-OG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 15:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVE46-0008NY-Cm
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 15:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780602557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=koKFsvNkWeMd2Rbi/HTHlp/jSTvScidPO47wLj3DUXo=;
 b=avN5V3atYMTwP0FiysW/xWUzyVH+uRjVy7XGP4UEg0jTkCWovRr6tJID0rqef8iSq4Z+vP
 tEGoPJcpyAPNsOO00JHIJUPXUFLiC5T+V0QMhWkXJIkAqtP/UKnfavZ/s9wux0rRu3e0N6
 yGe3yIWF2FQxB12jYpL09bZNOYbVSfc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-C2tG8WwBOzmSq6BkTX0i0Q-1; Thu,
 04 Jun 2026 15:49:13 -0400
X-MC-Unique: C2tG8WwBOzmSq6BkTX0i0Q-1
X-Mimecast-MFC-AGG-ID: C2tG8WwBOzmSq6BkTX0i0Q_1780602553
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E981C18004A9; Thu,  4 Jun 2026 19:49:12 +0000 (UTC)
Received: from localhost (unknown [10.2.17.68])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1AE6C195608E; Thu,  4 Jun 2026 19:49:11 +0000 (UTC)
Date: Thu, 4 Jun 2026 15:49:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 hreitz@redhat.com, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 gmaglione@redhat.com, Jorge Moreira <jemoreira@google.com>
Subject: Re: [PATCH v2 1/3] vhost-user.rst: clarify when rings are started
Message-ID: <20260604194911.GB149856@fedora>
References: <20260519191548.335082-1-stefanha@redhat.com>
 <20260519191548.335082-2-stefanha@redhat.com>
 <ah_t8NHf4pYDPO9c@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HJn7FBKkIAv6ZLA8"
Content-Disposition: inline
In-Reply-To: <ah_t8NHf4pYDPO9c@sgarzare-redhat>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--HJn7FBKkIAv6ZLA8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 11:04:42AM +0200, Stefano Garzarella wrote:
> On Tue, May 19, 2026 at 03:15:46PM -0400, Stefan Hajnoczi wrote:
> > Jorge Moreira <jemoreira@google.com> pointed out that the ring state
> > machine is underspecified. In the discussion that followed, we
> > discovered that the spec says one thing and implementations do something
> > else. This patch updates the spec to reflect how things are actually
> > implemented across widely-used front-ends and back-ends including QEMU,
> > crosvm, rust-vmm, and DPDK. Do this while taking care not to make any
> > other existing implementations non-compliant by changing the sepc.
>=20
> s/sepc/spec

Will fix.

Stefan

--HJn7FBKkIAv6ZLA8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoh1rcACgkQnKSrs4Gr
c8jLfQf/VeZySglt42MO57zSovq/xGe5IBzFm2plcmDQSQZPDe7PGCB0lMgJQXd7
ATHSVkBbhoBXIdlhXSLf79Iv/oo1gsAVeaBUWRsLVz2na5U5Q6RG0NwyitwDe0iO
uNcHoq7bM67TiSvong5eWbP5TkahMKuU2xUZiEISXuyyEXOH++nXnXe8BlH5uEt7
kzodly6FmNANLkDf2hczQz/lYTapvFPe8md598dln1+pCYei2CrH4ikQ86c6YiZN
3BneoKfb62MJyWAA6Alq9Yf8/FvGmSeZTGdMdbKRejlmo8MHFB/Wt/ysYn3bHrPe
+uHtydLkzCFsPtvyTXwDfHs63WbhKw==
=EsOO
-----END PGP SIGNATURE-----

--HJn7FBKkIAv6ZLA8--


