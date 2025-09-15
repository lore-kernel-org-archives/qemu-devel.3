Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35744CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 14:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyADA-00069P-N5; Mon, 15 Sep 2025 10:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uyAD1-00062I-DM
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uyACj-0000hU-RT
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757946553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fkNO4jGwChegh76twsuNkCoBzxs6Ya8SUNtkNdLv+LU=;
 b=e0R+bKpvauHk573LjzcW4ioDAO8Cd+5EUBswpJ37mbucsATYlRBM/8vVWUgB9v+ihr6sUv
 akNNYGpXtzciEpW0CuT8GCGqeF1uEkfLs9ntgQR6sQvcinR5F6huIajgF9SbdtNh1uSBtk
 Utn25QDTul4pVIEu5XF+nxIznJRZUVk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-Da2rmTPQOKmm0aU5orzMaw-1; Mon,
 15 Sep 2025 10:29:09 -0400
X-MC-Unique: Da2rmTPQOKmm0aU5orzMaw-1
X-Mimecast-MFC-AGG-ID: Da2rmTPQOKmm0aU5orzMaw_1757946547
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FEED180028D; Mon, 15 Sep 2025 14:29:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.109])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7620E18004A3; Mon, 15 Sep 2025 14:29:06 +0000 (UTC)
Date: Mon, 15 Sep 2025 10:29:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>
Subject: Re: The different ways QEMU logs stuff
Message-ID: <20250915142905.GB69944@fedora>
References: <87bjnhgpg8.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4u/h+++1dQIE6sWX"
Content-Disposition: inline
In-Reply-To: <87bjnhgpg8.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--4u/h+++1dQIE6sWX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 02:10:15PM +0200, Markus Armbruster wrote:
> * Tracing vs. "log items"
>=20
>   Tracing and "log items" both provide opt-in logging.
>=20
>   Why do we have two?  Feels like an accident to me.
>=20
>   When to use which?  I guess people pick whatever they're familiar
>   with.
>=20
>   Would we be better off with just one?  I wish...
>=20
>   Which one?  Clearly tracing, because tracing backends provide plenty
>   of useful functionality "log items" lack.
>=20
>   "Log items" support per-thread log files.  With tracing, you could
>   instead split by thread names once Daniel's series is in.
>=20
>   Address range filtering is only used with "log items".  It could just
>   as easily be used with tracing.

Paolo mentioned that tracing is structured (each event has typed
parameters) whereas logging consists of an arbitrary string. The reason
for this is that tracers are usually designed for low overhead and for
processing trace events. Tracing is used to instrument QEMU for detailed
analysis of control flow or performance investigation. It's a different
use case from logging although there is some overlap.

People like to use tools like perf(1), SystemTap, etc and tracing allows
QEMU to support them. It's not a use case where regular log files are
used.

Stefan

--4u/h+++1dQIE6sWX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjIIrEACgkQnKSrs4Gr
c8ijXwf+PHExVp5pTmOkH88XHdih7+knMgbU8njFecxaWwGGVDBy9DdyeuLV1sdC
obuuVZmLTwcaQFuq7QLGVgz9n699xX5ltvZwvvdPCBxoaoSEv/Mtqsfb+IZLlq4s
FeKIcGGPsS8nb4Z018UiAS0Repl1qCRCsyXNqkKjRff38F/hfuQvg09dsJam1U/S
2a557g6igAXCX4uOIOs+KfX42G3Bb4X4dGmB9L8jfoSwXYtwq/PC1XfyO4t3MAWR
wS6q3p0SAzjq44MKRwW+ZKsbTlSPzvB6P4NPBpfI78wgZupRM2U2sOipwcSLyfdG
4EL7ys1dbopDvFPfe78Ubzzqe8p6cg==
=7mv9
-----END PGP SIGNATURE-----

--4u/h+++1dQIE6sWX--


