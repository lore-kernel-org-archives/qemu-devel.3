Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7164AC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 06:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfB4p-0002AQ-Lf; Thu, 02 Jul 2026 02:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfB4k-00029e-ET
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 02:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfB4i-00010W-Uz
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 02:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782974344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o5IBCN9kYPjKqt7ZEANhTN+0EKrVq+VbfsEts8tnKTU=;
 b=PzQd/IzZbpKPjsrVlU0E9dFTLke5cXOtkc2gnj/N3kaIrug7EoUhrmf/17jRd8CNDcgQwt
 UOvMHIfZtRQoCasnluqqiIXVl+DAVfRCHAaYXJSSVyq9IpVIZZy8v3PR9XvWdJwxQrUa5y
 xQmoJCnKXDG19MG6h7T1Ar5igy5T4rI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-s2_gifAVPgidXt14CJb_3Q-1; Thu,
 02 Jul 2026 02:39:00 -0400
X-MC-Unique: s2_gifAVPgidXt14CJb_3Q-1
X-Mimecast-MFC-AGG-ID: s2_gifAVPgidXt14CJb_3Q_1782974339
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 923961833385; Thu,  2 Jul 2026 06:38:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A97571800592; Thu,  2 Jul 2026 06:38:58 +0000 (UTC)
Date: Wed, 1 Jul 2026 18:16:42 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH V9 08/17] monitor: switch to
 iothread_unsafe_get_aio_context()
Message-ID: <20260701161642.GB413397@fedora>
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-9-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kaG0X0eF3eDquPnP"
Content-Disposition: inline
In-Reply-To: <20260624070851.13342-9-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


--kaG0X0eF3eDquPnP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 03:08:42PM +0800, Zhang Chen wrote:
> Since previous patches introduced explicit monitor tracking and reference
> counting via IOThreadHolder during initialization, standard global calls
> to iothread_get_aio_context() are no longer appropriate for raw context
> fetches.
>=20
> Switch the remaining fallback sites in monitor_suspend(), monitor_resume(=
),
> and monitor_init_qmp() to use iothread_unsafe_get_aio_context(). This ali=
gns
> with the new safe ref/unref lifecycles introduced for monitor tracking.

Why is the unsafe API used here? monitor_data_init() now takes a
reference and gets the AioContext. Can you use that AioContext here
instead of fetching it with iothread_unsafe_get_aio_context()?

--kaG0X0eF3eDquPnP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpFPWoACgkQnKSrs4Gr
c8gnSgf/VQD6yrWIcHryDp4YhxNlQZJIT5+AglanggGfbXORjmpi21jk+ZJUu+4t
xTa+vBT7aa0GhRlVcrxAxIrAgKTnbsYkiCQBljw9p1EmOZJ3cabQpTr7LIyEOd73
uEEEFEgPXTmnOuKywSXSHKl4EVEBPf/1oVt3oKTUmQvAEsKqLEI3UcpWCVKfg6Gw
tS913T1KEFNLjbWDsSH0RYGsUJebomCT37zfdsxjhuQz3F6msguXM0NZWvYc+JjB
7uec1S4+dsaPCVSPPchzRJvrLt+IhX3y+/emzRz0JMT8Ruatheaym5LUA6lpcIj8
XcVRhEY8R3E4TJUfPTDNEUgq+p24DQ==
=8cZs
-----END PGP SIGNATURE-----

--kaG0X0eF3eDquPnP--


