Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BDFC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 14:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqY7T-0003TV-Qo; Fri, 07 Mar 2025 08:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tqY7N-0003Hd-5e
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:52:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tqY7L-0001DU-EB
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741355516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2TU5GunQuBlTAPNvY7g2xEzf17JFRYlC5aa6Y+0KKdI=;
 b=GPLVIc2Z3St4tFTti9zBg605Fw4m5dj3azrosrn74ezqzPU9o1QOaAOTdUATy8pFyKDTlj
 PBmDmcv9PQNlcT6B4JAtCUUZJfRl6JgnyZFOc7KtkvdQ0PPZiC6eSvuG155J44u3Ur+icU
 wMAUcWHxQqKKfnZuItw0GB+Jjl/0Pi8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-l7hJ5df0OuCvSh3fFXqRtw-1; Fri,
 07 Mar 2025 08:51:53 -0500
X-MC-Unique: l7hJ5df0OuCvSh3fFXqRtw-1
X-Mimecast-MFC-AGG-ID: l7hJ5df0OuCvSh3fFXqRtw_1741355512
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C9921800258; Fri,  7 Mar 2025 13:51:52 +0000 (UTC)
Received: from localhost (unknown [10.44.34.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73E381801748; Fri,  7 Mar 2025 13:51:50 +0000 (UTC)
Date: Fri, 7 Mar 2025 14:51:48 +0100
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, 
 Andrea Bolognani <abologna@redhat.com>
Subject: Re: New git repository for Go bindings
Message-ID: <cwxf24xijypebuv44uqeiyxdspifcey3447t6iyz2kv5ljwger@fksnjsmro37o>
References: <xu3qsijvpbguwdnlj6ovomlkd2wggd76x2lvfusmczljhnmx4f@kgw6di2754ta>
 <Z8rrd8DoLUVh_Je1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zxb543gg6f3sjxpf"
Content-Disposition: inline
In-Reply-To: <Z8rrd8DoLUVh_Je1@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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


--zxb543gg6f3sjxpf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: New git repository for Go bindings
MIME-Version: 1.0

On Fri, Mar 07, 2025 at 12:49:59PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Mar 07, 2025 at 01:30:38PM +0100, Victor Toso wrote:
> > Hi,
> >=20
> > I've been working on and off in having Go bindings for QEMU's
> > QAPI specification. The last version [0] seems to be accepted so
> > far but we would like not to have that in qemu.git.
> >=20
> > In the past [1], Daniel suggested creating a repo per each
> > generated schema: go-qemu.git, go-qga.git, go-qsd.git
> >
> > While that works well from the point of view of Go applications
> > and is neat organized too, afaict they are all bounded to QEMU's
> > release schedule so it might be enough to create a single repo
> > such as:
> >=20
> > qapi-generators.git
> > =E2=94=94=E2=94=80=E2=94=80 golang
> >     =E2=94=9C=E2=94=80=E2=94=80 module.py # The go generator
> >     =E2=94=9C=E2=94=80=E2=94=80 qemu      # For qapi/qapi-schema.json
> >     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 doc.go
> >     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_iface_command=
=2Ego
> >     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_iface_event.go
> >     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_type_alternat=
e.go
> >     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_type_command.=
go
> >     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_type_enum.go
> >     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_type_event.go
> >     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_type_struct.go
> >     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gen_type_union.go
> >     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 go.mod
> >     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 protocol.go
> >     =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 utils.go
> >     =E2=94=9C=E2=94=80=E2=94=80 qga # qga/qapi-schema.json
> >     =E2=94=94=E2=94=80=E2=94=80 qsd # storage-daemon/qapi/qapi-schema.j=
son
> >=20
> > Or perhaps a per language repo?
>=20
> I'd suggest we keep the repo dedicated just for 'go' language,
> as mixed language repos are more trouble than they are worth
> when it comes to dealing with language specific build tools.

That's fine for me. Should we go with qapi-go or go-qapi or ?

Cheers,
Victor

--zxb543gg6f3sjxpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmfK+fQACgkQl9kSPeN6
SE8hcA//T4jw866HFplQ8eRb4Creie3t44+xLyQkz4TXiolXKYM/KiLz1Kapc8CZ
jvFC+Xeekso4Mx49E0UTvaGLGhctjxerrBvScoMYslqGdoOcS1leEcOdzgHv5yJf
4y9C3yIoya7G9zRPQKoYOLLNAsfvCSa/ovhYpILOTIZ9PVzdB5Cu4H+8yuJHD/5Y
PIYXIKe7cGADgoX5C7n2/B0TPNFmJQCXnK/z0P+EL54eIFd5e9+P1RXpvx5h2s6P
DcZtDbOx2EO2pffD+IiDg1rsiLF7K7vdVtojCh6j1GuM2GG3Titg8G1I65XoIUqv
GVVYflnk2Jfe58N6DPEea5bN0VEt9ze5FKCCF/vr+T5pBPFhq4NnzuZrq6Nd4y/F
9z71+LW7KAlvkUYzRnpnvYTGuLVKO2Ho/hEZkQBh+iaW5MqXQeOF5wyhJtfoypT+
pSXCCVAdMRh6/2VUwi73+U4ttkelS/vjaLyHZ+ZWkeZB9OJap1AdI7V6TCw3JqYn
c6kde/kGjsgNRvo8yOtKayBJxhsm9VJohajirv+wzTrKHoXpvTKPRCc13SPy8SGO
VWC56vdhncN0THC1sUd9DAAzniZZWmr4e5TkOwU2gwNeEyA4cIpDrbEUyKaDXfaC
rxyMMSCVObfMWEklVtY/jeqy8lOuN2nZKwRNXdKCRuHF3/XSdNQ=
=wtNs
-----END PGP SIGNATURE-----

--zxb543gg6f3sjxpf--


