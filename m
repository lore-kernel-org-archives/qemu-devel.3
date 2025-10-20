Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD48CCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 18:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAv0y-00052u-4k; Mon, 20 Oct 2025 14:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vAv0v-00052V-OG
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 14:53:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vAv0r-0001n6-VQ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 14:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760986421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=18Zh+lr0m3wfH+K8eYEPWzw2d+QR0EMIe9iuWhiTmWw=;
 b=YJeZlr9/NIC67NJa5/INh0yYBrWnhW6EMsDAQfk1mAgKKPl8nj6cgvIGjx5yAr7fxnsXbP
 ssnA8HaexW6VZCc1xy2imqEwm0MVOffcpeC+UXdauq1jcJ+/lIsiz5wC6hcDQGW2x0Xl+w
 Gv8YZXOfr/7zgVTX+EPKnbiKNiUrNtY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-8kK-mQjLPAyUkBP3v0bm2Q-1; Mon,
 20 Oct 2025 14:53:39 -0400
X-MC-Unique: 8kK-mQjLPAyUkBP3v0bm2Q-1
X-Mimecast-MFC-AGG-ID: 8kK-mQjLPAyUkBP3v0bm2Q_1760986418
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AD6D1800657; Mon, 20 Oct 2025 18:53:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.188])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 570DA1955F22; Mon, 20 Oct 2025 18:53:37 +0000 (UTC)
Date: Mon, 20 Oct 2025 14:53:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 03/12] tests/unit: skip test-nested-aio-poll with
 io_uring
Message-ID: <20251020185336.GA119797@fedora>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-4-stefanha@redhat.com>
 <aOfEwOXrPMDI3lQN@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZSk2lSSllTwQ4R8N"
Content-Disposition: inline
In-Reply-To: <aOfEwOXrPMDI3lQN@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--ZSk2lSSllTwQ4R8N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 04:20:48PM +0200, Kevin Wolf wrote:
> Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> > test-nested-aio-poll relies on internal details of how fdmon-poll.c
> > handles AioContext polling. Skip it when other fdmon implementations are
> > in use.
> >=20
> > Note that this test is only built on POSIX systems so it is safe to
> > include "util/aio-posix.h".
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Maybe give a specific example of what fails with other fdmon
> implementations?

Yes, I'll update the commit description.

> Could we change the test to downgrade to fdmon-poll instead of skipping
> the test entirely?

I don't think so because io_uring is permanently enabled and there is no
way to switch back to ppoll at runtime.

Stefan

--ZSk2lSSllTwQ4R8N
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmj2hTAACgkQnKSrs4Gr
c8ig3Qf+JXh0dH8dtesvbRZAFHbOEmhlqVYjrUlHEggurG6RnXQyJtSbu+caBI/f
PH8AL8olJnf40VpUH9ISKoCD6U2OlTu/WHLR/o72WnWS38sddZ7+C9Ib6hi0RJeq
yS4gL4ydHHJGBQ1/Bg9HXLj98dVnFbF1xfAKb7C3CXPkySFiezXqCx2NFw+f9Mxc
bYTb//psVdQWBFT9yFLBlkKpyophtSrCzsQlsaJ7xAtKp0Fouqu1AIlH6z3omnbZ
aD44Ln6waZUTRRGsnalwcVn8szCVcNWfc2mBtO0UMdLsI3m7PHiZChiValCilOE9
xGasgTTydU/7B2Hgt19PmrfAHXPDaA==
=6/JS
-----END PGP SIGNATURE-----

--ZSk2lSSllTwQ4R8N--


