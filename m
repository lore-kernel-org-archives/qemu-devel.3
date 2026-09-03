Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1968C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27cy-0000x1-1V; Thu, 03 Sep 2026 09:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x27cw-0000ws-Ex
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x27cu-0004Hz-Ty
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788442632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WumqCSDChyQmqDeur0vStfhIudXGg6R/C1TJURXM+bg=;
 b=i65wHCuoNnMBqfbnmtMAHZEtupL8z7OmV0OIz6PE7zUKkTClqBCzCYoxVDg2DIShyAAThN
 WuzBLQ4WodOgDOaWqoIysGQKRvOEY1Mkq6zKH9xqCksuUd2vGKJssHEQzB45nbXGN7bgqP
 J0WRW/f75ZjIo1+RI1VJ+4lS83WKqf4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-EXLONfYRNXmBhu41tM2urQ-1; Thu,
 03 Sep 2026 09:37:09 -0400
X-MC-Unique: EXLONfYRNXmBhu41tM2urQ-1
X-Mimecast-MFC-AGG-ID: EXLONfYRNXmBhu41tM2urQ_1788442628
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DED56185FBBB; Thu,  3 Sep 2026 13:37:07 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B37E3000239; Thu,  3 Sep 2026 13:37:07 +0000 (UTC)
Date: Thu, 3 Sep 2026 09:37:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Huiba Li <lihuiba@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [RFC] block: add an overlaybd image format driver
Message-ID: <20260903133706.GA825275@fedora>
References: <CA+AFTT-iZ8wbUOkEaU_SCM0rnqRJsefkOr=CTgC6T22nz_ZFoA@mail.gmail.com>
 <CA+AFTT-8odiRzg8mcnZiEQTyTiMeK5rHUFB6an+6wFgYLtyh1g@mail.gmail.com>
 <20260902115439.GA754231@fedora>
 <CA+AFTT8+vvXd5+UV9X1aS-4tDnMRynzDOcmLYE_HJUgSAvf6kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JitZOx6Kl4oioAUg"
Content-Disposition: inline
In-Reply-To: <CA+AFTT8+vvXd5+UV9X1aS-4tDnMRynzDOcmLYE_HJUgSAvf6kQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--JitZOx6Kl4oioAUg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2026 at 05:27:28PM +0800, Huiba Li wrote:
> > One thing I noticed is that the append-only format used for the upper
> > write layer is not documented.
>=20
> I have added the spec for writable layers:
> https://github.com/containerd/overlaybd/pull/451/changes

Thanks, that clarifies things.

Stefan

--JitZOx6Kl4oioAUg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqZeAIACgkQnKSrs4Gr
c8gcSAf/fKdG2ATPV98p33049unic/uQpKpo+ECVzNIyHxAQ8SGtmOAwsqfxlAHm
dX/QeFNPZdSoMdanLYMtdPilbdHwa0ZggjaBfK8AQG0NbCqAdBeSw5mATYGqCYfc
WRbvELGq5cvTbYEgCHVkk6d4iLSiY8TgoGbqEVExCoustog8wZx0kao5Kkp6RcJ5
f8u3qd5gSgu9OxO+PcJjIAg4IX+F+ncJMlc4xUa26fhGy4VEsP64scpwytV9ICFo
U1F+M2DHSiR1qWGl0qKhY9hUKMWDGepDVZmSs1nV7Ur/+1WDwBIdz6cSqNdyLSQo
3Asayf/94+wYiAzxOvbWxb/xltXjvA==
=S8+0
-----END PGP SIGNATURE-----

--JitZOx6Kl4oioAUg--


