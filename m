Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB54C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk4Mj-0005y1-1U; Mon, 17 Feb 2025 11:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tk4Mf-0005xg-NM
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:53:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tk4Mc-0000mr-U6
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739811174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QqYJAg/mJRaJLg4p5nuA665kYQdCy4oTadL+KqVuaAY=;
 b=DObUtvMXXWnafUNpQKRgGChVfn9+6bmS4BLE0WRXKWdxjGWMEc3uqtynhwimuh+89rNNV7
 AGRAK2yVdSaIajMj9PJuzg2NJD9vzf74+Ly0MHHMGcYfSF8xhYqrhFotAsWl3ud5qBF8k+
 pukYv0RHvQgU5hYO6xrRwL4+lIGl5QU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-F522y9hGO4GJi3Z-N5gv5w-1; Mon,
 17 Feb 2025 11:52:50 -0500
X-MC-Unique: F522y9hGO4GJi3Z-N5gv5w-1
X-Mimecast-MFC-AGG-ID: F522y9hGO4GJi3Z-N5gv5w_1739811169
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85D481800878
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 16:52:49 +0000 (UTC)
Received: from localhost (unknown [10.44.32.8])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F13751956048; Mon, 17 Feb 2025 16:52:48 +0000 (UTC)
Date: Mon, 17 Feb 2025 17:52:47 +0100
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v4 00/11]
Message-ID: <zymp5hndhvvb6qvomct4kytoyxwgjtienz5ahlb4fbbuyffqpm@6ttbn2mod64w>
References: <20250214202944.69897-1-victortoso@redhat.com>
 <Z7NOjiz20gzBQhX5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qmpev3a5l55afpte"
Content-Disposition: inline
In-Reply-To: <Z7NOjiz20gzBQhX5@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--qmpev3a5l55afpte
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/11]
MIME-Version: 1.0

Hi,

On Mon, Feb 17, 2025 at 02:58:22PM +0000, Daniel P. Berrang=E9 wrote:
> On Fri, Feb 14, 2025 at 09:29:33PM +0100, Victor Toso wrote:
> > Hi again,
> >=20
> > This patch series intent is to introduce a generator that produces a Go
> > module for Go applications to interact over QMP with QEMU.
> >=20
> > Previous version (10 Jan 2025)
> >     https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg01530.html
> >=20
> > The generated code was mostly tested using existing examples in the QAPI
> > documentation, 192 instances that might have multiple QMP messages each.
> >=20
> > You can find the the tests and the generated code in my personal repo,
> > main branch:
> >=20
> >     https://gitlab.com/victortoso/qapi-go
> >=20
> > If you want to see the generated code from QEMU's master but per patch:
> >=20
> >     https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v4-by-p=
atch
>=20
> In terms of generated code, my only real feedback is that the
> re-wrapping of docs comments is having undesirable effets
> on formatting
>=20
> ##
> # @add_client:
> #
> # Allow client connections for VNC, Spice and socket based character
> # devices to be passed in to QEMU via SCM_RIGHTS.
> #
> # If the FD associated with @fdname is not a socket, the command will
> # fail and the FD will be closed.
> #
> # @protocol: protocol name.  Valid names are "vnc", "spice",
> #     "@dbus-display" or the name of a character device (e.g. from
> #     -chardev id=3DXXXX)
> #
> # @fdname: file descriptor name previously passed via 'getfd' command
> #
> # @skipauth: whether to skip authentication.  Only applies to "vnc"
> #     and "spice" protocols
> #
> # @tls: whether to perform TLS.  Only applies to the "spice" protocol
> #
> # Since: 0.14
> #
> # .. qmp-example::
> #
> #     -> { "execute": "add_client", "arguments": { "protocol": "vnc",
> #                                                  "fdname": "myclient" }=
 }
> #     <- { "return": {} }
> ##
>=20
>=20
> is getting turned into
>=20
>=20
> // Allow client connections for VNC, Spice and socket based character
> // devices to be passed in to QEMU via SCM_RIGHTS.  If the FD
> // associated with @fdname is not a socket, the command will fail and
> // the FD will be closed.
> //
> // Since: 0.14
> //
> // .. qmp-example::    -> { "execute": "add_client", "arguments": {
> // "protocol": "vnc",                          "fdname": "myclient" }
> // }   <- { "return": {} }
>=20
>=20
> the '.. qmp-example' bit is what's particularly badly affected.
>=20
> If we assume that the input QAPI schemas are nicely lined wrapped,
> we could probably just preserve the docs lines as-is with no change
> in wrapping.
>=20
> That said I'm not sure if we'll need some docs syntax changes to
> make it render nicely - hard to say until the code appears up on
> pkg.go.dev, so can probably worry about that aspect later.

My preference is that the Go code has nicely formatted sections,
like the qmp-example one. The decision to not work on this now
was made together with Markus as he pointed out this formatting
on documentation part is still a work in progress, besides the
fact that it can be done as a follow-up.

Having examples is a nice thing even if the format is not great.
=20
> > ################
> > # Expectations #
> > ################
> >=20
> > As is, this still is a PoC that works. I'd like to have the generated
> > code included in QEMU's gitlab [0] in order to write library and tools
> > on top. Initial version should be considered alpha. Moving to
> > beta/stable would require functional libraries and tools, but this work
> > needs to be merged before one commit to that.
>=20
> We don't need to overthink this. I don't think we're best served by
> continuing to post many more rounds of this series. Better to just
> get it into a dedicated git repo and iterate via pull requests IMHO.

Well, I'm happy to hear it. How the repo get created so we can
move the discussion and patches there?
=20
> Golang uses semver, so we could start publishing the generated code in
> a Go module as it is today, as long as we pick a v0.XXX.0 version number.
> 'XXX' would be a packing of QEMU's 3 digit version into the semver 2nd
> digit. This lets us indicate this is not considered a stable API, letting
> us iterate on further imlp details, while also getting us in the habit of
> publishing releases to track schema updates for each new QEMU.

Sure.

> We just need the patch for qapi-gen.py to support plugins for
> code generation to make this happen, so we can decouple ongoing
> development from QEMU's main git repo & release cycle.

Looking forward to it.

Cheers,
Victor

--qmpev3a5l55afpte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmezaV8ACgkQl9kSPeN6
SE9NdQ//fmpq3pPy4E3VraP3F9rlyl950h3vL9XxT4BqIzSXkGprnaWQUKwXCnNK
t8HTScM1BTZjb8sG7xnFXXfVBfD5L7C4zwnSo/GusU7HqFynaB2O1G7l25ywqsEz
Yz23FtQ7mnqppRCy/xwJuyUCFsouEcE3N4WziFQNDaoRYH/BPdiPLtBFIIDfEShF
j5jMp2F5O/nZamYC+A3b0Bw4dGOlxhW9ruazW25pb2LyGaUZmSxFevDayRPNpfiH
qe5XaGxrGl3MdxCXIKvDB/yQ8TjIDMTclQUFHyElqZoyEpqJA2k16QnmfqlW+kjG
Hx1edVW3H5e2ScrmqvoC9v7gwzy3f9YNNYQtSr9PXqgB0ao6kuxlBAM2oB70Wyk9
x1YVYEt2WXrcBO91E2qx1NfeBpEKiJugFU0jD8fP1iFWj8XtnhWvSW1tJnuMoxHb
31dLuifZn1Ej5PTWEuskM5ZfcBNxxMUZ9E47nY1WlCTVxeqGKlmcuOz+wyG/qAo1
2V0DDIPDgJX2Wud3FP2GJsM+G403xS/Fq8UxY0xJMR2z5DvgRl+ZeXXzQcnQxvEE
Bl/m5lXYW9jAOo9HCpCcA71Gs+PymdY+UA4vJRH5g96MQCorMjRbfMEbX8AWtrmt
AV3Rr2wDkSDLPQIjlnAiJTS7HUwI65zrWN/c8XKwTlZdBSYoN+Q=
=6Bqs
-----END PGP SIGNATURE-----

--qmpev3a5l55afpte--


