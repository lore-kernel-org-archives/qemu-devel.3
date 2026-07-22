Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1700AC4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmbCw-0003dY-7e; Wed, 22 Jul 2026 13:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmbCu-0003cy-Ep
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmbCs-00012C-5u
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784743089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UXDSzA0sBd0RYnSJ+LDAp00U41JskEysQBzu/Cmd13g=;
 b=SZbr0hj/q72SPLwu4bTp9hwXWIb9oQLjLq0RY9bzz9jVL+NjwzVIU4IeGqVczpIJl7blXA
 tcrgeZdWfhoC2wjUyZ/71OdWx+bbtzgA9gTt/S4drx+kR1SuohrJmNxSGHALStgj7doKpN
 G2zE0eTDsWIiP4EV2hMbEQCp7N4LwgQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-si5YQyH0MIiA9MfQPCHdww-1; Wed,
 22 Jul 2026 13:58:06 -0400
X-MC-Unique: si5YQyH0MIiA9MfQPCHdww-1
X-Mimecast-MFC-AGG-ID: si5YQyH0MIiA9MfQPCHdww_1784743086
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CBD61926B71
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 17:58:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.130])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EA391955D89; Wed, 22 Jul 2026 17:58:05 +0000 (UTC)
Date: Wed, 22 Jul 2026 13:58:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/13] vfio queue
Message-ID: <20260722175804.GA317046@fedora>
References: <20260721170518.4160785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gfZl+5ZA1EuF7ZVb"
Content-Disposition: inline
In-Reply-To: <20260721170518.4160785-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

--gfZl+5ZA1EuF7ZVb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--gfZl+5ZA1EuF7ZVb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmphBKwACgkQnKSrs4Gr
c8jsYAf3SMzN384jfT5NX0qBshmNocCge7mh+8gC9sq4KqpyEuDEx7AFjxuwjWAG
yTM2ltr9Tqt1JlnXFmmLzqysUM/Uxd1jQs1pFvE2YGYA7Ds06KxBbAjfhnDjTCFs
u72VoPlh93WFAu62wuLE9qD56F5ItOlhWAlc0/z+AmhLTsFVy3uNVkuZIjEIIbV0
iJcuXE+DtBhvcDUgfgn+PMgSrjd1lZPGSKwM+D5lQGvt8Rzf3ZJ8UXSx5RLpbNoP
NR/LcVocj4l/jLwoPT9a6Zd1JMgoNRA+0cKk0jUuYTC0CTT0ZhOI2KG75EAShjno
MMBKiHGY8fHUwVEUbfstIbPVZNFQ
=I5/o
-----END PGP SIGNATURE-----

--gfZl+5ZA1EuF7ZVb--


