Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D56E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 09:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXdTK-0003r6-SB; Tue, 14 Jan 2025 04:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tXdTI-0003qr-3g
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 04:44:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tXdTD-0005lH-BP
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 04:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736847860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8O0ZXw1TSpGLNc8NnVJovYRtELdPHjDgnkc3qUa0hGk=;
 b=C/VOPSe59JIvXmQme+mB/jLu9r2Z8Wn10OPTpAuP8ZezlFoNFIveftFqeasB/Vzkw+4YA9
 aqjUTc69wkGN1TTfDp5e5dNza9CQOhOlxtSX2MYPUX25QQJkD7LthxmFSceoE0S+w7yUIS
 065MOCZ5nL5iyFw/mkHnOaQbKYTK6HY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-e8oR0H08MPCk6KBcpVLbrw-1; Tue,
 14 Jan 2025 04:44:15 -0500
X-MC-Unique: e8oR0H08MPCk6KBcpVLbrw-1
X-Mimecast-MFC-AGG-ID: e8oR0H08MPCk6KBcpVLbrw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDC161955DDF
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 09:44:14 +0000 (UTC)
Received: from localhost (unknown [10.45.225.199])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61626195608E; Tue, 14 Jan 2025 09:44:13 +0000 (UTC)
Date: Tue, 14 Jan 2025 10:44:11 +0100
From: Victor Toso <victortoso@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v3 0/8] qapi-go: add generator for Golang interfaces
Message-ID: <2spcmyijkdjarfmfjisc4jpteh7ep5bj4ohkxksciaixu5gjpg@cjkxbx5utq7p>
References: <20250110104946.74960-1-victortoso@redhat.com>
 <874j22ooza.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="czhywynla3k3d4cu"
Content-Disposition: inline
In-Reply-To: <874j22ooza.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


--czhywynla3k3d4cu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/8] qapi-go: add generator for Golang interfaces
MIME-Version: 1.0

Hi,

On Mon, Jan 13, 2025 at 01:52:25PM +0100, Markus Armbruster wrote:
> Victor Toso <victortoso@redhat.com> writes:
>=20
> > This patch series intent is to introduce a generator that produces a Go
> > module for Go applications to interact over QMP with QEMU.
> >
> > The initial Goal is to have a Go module that works as intended and can
> > be improved upon. I'd consider initial releases to be alpha while we
> > work with utilities tools and libraries on top of this.
> >
> > The generated code should reside in a separated Git repository, similar
> > to python-qemu-qmp.
> >
> > Applications should be able to consume this under qemu.org
> > namespace (e.g: import "qemu.org/go/qemu"), see Daniel's suggestion:
> > https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg07024.html
> >
> > This is the third iteration:
> > v2: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg04785.html
> >
> > I've pushed this series in my gitlab fork:
> > https://gitlab.com/victortoso/qapi-go/
> >
> > The fork contains some tests, including tests that were generated from
> > QAPI's own examples from another generator created for testing, if you
> > are interested in it:
> > https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg04946.html
> >
> > I've generated the qapi-go module over each commit of this series, see:
> > https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v3-by-patch
> >
> > I've also generated the qapi-go module over QEMU tags: v9.1.0, v9.2.0:
> > https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v3-by-tags
> >
> > --
> >
> > Sorry that its been awhile between v2 and v3, I had to prioritize other
> > things. I hope to get this back on track in 2025.
> >
> > Cheers,
> > Victor
> >
> > * Changes:
> >
> > On generated go:
> >  - the output should be formatted as gofmt/goimports tools (Daniel)
> >
> >  - Included QAPI's documentation too (Daniel), see:
> >    https://lists.gnu.org/archive/html/qemu-devel/2024-11/msg01621.html
> >    =20
> >  - Commands and Events should Marshal directly (Andrea)
> >
> > On python script:
> >  - rebased: now uses QAPISchemaBranches, QAPISchemaAlternatives
> >
> >  - use textwrap as much as possible (Andrea)
> >
> >  - lots of changes to make the output like gofmt does
> >
> > Victor Toso (8):
> >   qapi: golang: Generate enum type
> >   qapi: golang: Generate alternate types
> >   qapi: golang: Generate struct types
> >   qapi: golang: structs: Address nullable members
> >   qapi: golang: Generate union type
> >   qapi: golang: Generate event type
> >   qapi: golang: Generate command type
> >   docs: add notes on Golang code generator
> >
> >  docs/devel/index-build.rst          |    1 +
> >  docs/devel/qapi-golang-code-gen.rst |  548 +++++++++
> >  scripts/qapi/golang.py              | 1645 +++++++++++++++++++++++++++
> >  scripts/qapi/main.py                |    3 +
> >  4 files changed, 2197 insertions(+)
> >  create mode 100644 docs/devel/qapi-golang-code-gen.rst
> >  create mode 100644 scripts/qapi/golang.py
>=20
> This is series adds a backend that slots in cleanly, i.e. without any
> changes to the core.  That makes it as low-risk to merge as it gets.
>=20
> I'd like an Acked-by for the generated Go from someone familiar the kind
> of software that could use it.
>=20
> The Go backend is a single golang.py, which generates:
>=20
> * Types:
>   alternates.go enums.go structs.go unions.go
>=20
> * Commands:
>   commands.go
>=20
> * Events:
>   events.go
>=20
> It doesn't generate visitors or introspection code.
>=20
> Correct?

Correct. I've actually thought about following what we did with
libvirt-go-module which appends _generated to the files that are
generated, meaning that we would also have files that are without
_generated in the name, with custoam/manual code related to that
file.

Either way, that does not change the Go module (does not break
API/ABI) so we can customize it if needed at a later time.
=20
> The existing C backend generates code for
>=20
> * Types (types.py):
>   qapi-builtin-types.[ch]
>   qapi-types.[ch] qapi-types-*.[ch]
>=20
> * Visitors (visit.py):
>=20
>   qapi-builtin-visit.h
>   qapi-visit.[ch] qapi-visit-*.[ch]
>=20
> * Commands (commands.py):
>=20
>   qapi-init-commands.h
>   qapi-commands.[ch] qapi-commands-*.[ch]
>=20
> * Events (events.py):
>=20
>   qapi-emit-events.h
>   qapi-events.[ch] qapi-events-*.[ch]
>=20
> * Introspection (introspect.py):
>=20
>   qapi-introspect.h
>=20
> The -* files are all one pair of files per module (the things pulled in
> with include directives), if any.  We do this to avoid "touch the QAPI
> schema, recompile the world."
>=20
> The generated Go is monolithic.  No "recompile the world" problem with
> Go?

=46rom my experience, Go compiler only builds when the .go file
changes. If the QAPI changes and the generator outputs different
=2Ego files, it'll recompile at the project using it.
=20
> golang.py is somewhat big.  Whether splitting it up along the lines of
> the C backend would improve things I can't say.  No need to worry about
> that now.

Yes, I'm not super experienced with python. I'm all ears to any
suggestions on how to organize the source better. I'm happy to do
it as a follow-up.

Cheers,
Victor

--czhywynla3k3d4cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmeGMesACgkQl9kSPeN6
SE8igRAAohZbhjStF4XNyrfstB+WWDWJktanJ7jc9zhv6g3crf/lDIaL5rAtwYxt
BtKEEUSTXAU/LDG25n5vaLLFCNAMAKs1h6PZKSsPRP/H29LGDf5cdJQMNW0jEDy9
mhaOg8cAhI7nAwysGkBT2VbhCPHmiWotGhA4UuyJF+pZ9ufnW9OGhDB02fYzcSjW
4+BuFVwxkxuGfTgr4/+8MKma1hd962e8bJ9sWidebtKzTJu/jwgziEsR6vHn79vu
LVuLdu/3bWZFh6W3wF3/NH/7Zdg1Hu+YeCNUMY2gFIYF+7+99Y7DIFPwD0DhJ01/
Itqrzk8RRPiylcdVEZwBm5AcovyNghBHDEv80QVWSDaDTxabeSv3MfomRiVXLSu5
7e23FRFwOBcOD5snyOSh8K3f99rp0ImypYzYFIksCewUgvTMJIZzzOVp2EaOR8o4
mz+CSTpydrNHRWe8B+xITFzn3lpMSeuzqyuvUJ5/X9vpn6mzBkgN6HQ0b0kdn8/n
9r7RfbMCdK75aqqNTPP/pPQ+JRl8sj2ZmuHr8QC34ItU/3tDcagklyM0jC71zwsB
ZJBF3OQ4w8OwFEvpsrakCfb7hU17rzb+Mr0IABtF0hQ1e0N1saKrNEBB59NMNIAS
gZkQDp0f4Y60uF45N23VXJQHMboWwP5PNssr/AVu7oUlg2r/VZk=
=q/O5
-----END PGP SIGNATURE-----

--czhywynla3k3d4cu--


