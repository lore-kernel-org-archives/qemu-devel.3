Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF47CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 19:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urLcn-0005rf-JN; Wed, 27 Aug 2025 15:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1urLcj-0005pY-2n
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 15:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1urLce-0005q3-95
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 15:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756322147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zT8TTM2XmgLq4uTNmcJ1B/5mzDEL6oV7EJD/OoiD1PI=;
 b=fDTy9qMsyoRAISQHeDRThVODmfbGMJVeHtlR+5kn6OGAKB9Sd85ljzANKD2FuX/2XcFBjN
 u7mtv8solyP9YvhNpuNVK6gSaDRO8ioGEf1/QTVE6cpXsVPrS3aFP1PXbfjlSlp1Kh2fcS
 bdGUhQWCT28KnXK2dBUt/CSeEvWyj5I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-zhylKspWPvS3t8LRirws2Q-1; Wed,
 27 Aug 2025 15:15:45 -0400
X-MC-Unique: zhylKspWPvS3t8LRirws2Q-1
X-Mimecast-MFC-AGG-ID: zhylKspWPvS3t8LRirws2Q_1756322144
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3272019560B2; Wed, 27 Aug 2025 19:15:44 +0000 (UTC)
Received: from localhost (unknown [10.2.17.57])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A43D71800292; Wed, 27 Aug 2025 19:15:43 +0000 (UTC)
Date: Wed, 27 Aug 2025 15:15:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: Re: [PATCH 05/14] tracetool/backend: remove redundant trace event
 checks
Message-ID: <20250827191542.GD228377@fedora>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q8lPiJkxOUo1pYv2"
Content-Disposition: inline
In-Reply-To: <20250822122655.1353197-6-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Q8lPiJkxOUo1pYv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 02:26:46PM +0200, Paolo Bonzini wrote:
> From: Tanish Desai <tanishdesai37@gmail.com>
>=20
> Use CHECK_TRACE_EVENT_GET_STATE in log, syslog, dtrace and simple
> backend, so that the "if (trace_event_get_state)" is created from common
> code and unified when multiple backends are active.
>=20
> When a single backend is active there is no code change (except
> for the log backend, as shown in tests/tracetool/log.h), but the
> code in the backends is simpler.
>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/tracetool/log.h               | 16 ++++++++++------
>  scripts/tracetool/backend/ftrace.py |  6 ++----
>  scripts/tracetool/backend/log.py    | 10 ++++------
>  scripts/tracetool/backend/simple.py |  8 ++------
>  scripts/tracetool/backend/syslog.py |  8 ++------
>  5 files changed, 20 insertions(+), 28 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Q8lPiJkxOUo1pYv2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmivWV4ACgkQnKSrs4Gr
c8jPiwf9HR7ksojyvhE39Xd/Z+QWzA871FMnDn2884ibQw3Gr4iiQoWJkjRFsfrl
Xsw1LfekK25mN+MCNpvTwQn3xPku1mi6x2HVY8XOs0xhmI15tDEid0JVmlsAUZ17
nFlSqilwJ6AV0KSdjiCA1U/d0ulEUYHlv7ThF2IXo3tGJ/glrW4YMSRNDEfIvHD5
/75Wl6BR0/bpVUtuyuhngKlbn5AodWKFWT3Memf4HqePStRGKhHu0uvBmIwegrj7
xPRu20wyL6FhjuFF3sMmH9rtagG2h/PtSb1zOrwAC6WgjCENvPUpw52ucCc5ZDYX
Xi7TwcKLEravuIqQLBCB56L9A/7K3w==
=dzKu
-----END PGP SIGNATURE-----

--Q8lPiJkxOUo1pYv2--


