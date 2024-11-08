Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF632D5E14A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 09:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9LXT-0001kj-OS; Fri, 08 Nov 2024 04:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1t9LXS-0001kS-56
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 04:44:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1t9LXP-0007Sb-Kk
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 04:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731059058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FxBvrZuXPh42wT+Bzr9dJgM32BZF/rojvOxtHzF5qkk=;
 b=aP/BlPXpFKXSD4AYp5NF0ceVcQ+POdc1ghXjj0Y21IpLpooMsfuLE2oH7XpbQjvWJBeGaS
 WzzH2iVD3ozhja7D+YxS+7vz6NWebSGlvtLHeibrLgJsXSBLexkVhj4Lh4asZr2JM57VLt
 eRO/yJHgojZwWvLaWRxXq+UuDOVjzjU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-OExn3HjxNFuE_oy21dUZBg-1; Fri,
 08 Nov 2024 04:43:04 -0500
X-MC-Unique: OExn3HjxNFuE_oy21dUZBg-1
X-Mimecast-MFC-AGG-ID: OExn3HjxNFuE_oy21dUZBg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75B7A1955E94
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2024 09:43:03 +0000 (UTC)
Received: from localhost (unknown [10.45.225.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE8A91956054; Fri,  8 Nov 2024 09:43:01 +0000 (UTC)
Date: Fri, 8 Nov 2024 10:43:00 +0100
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, 
 Andrea Bolognani <abologna@redhat.com>
Subject: Re: [RFC PATCH v2 0/8] qapi: add generator for Golang interface
Message-ID: <yafcgwgvz7sugv7syjp5jp5nqnxhkr4xgdedtkxrz4hm5jegfu@uzlegmkc7cjs>
References: <20220617121932.249381-1-victortoso@redhat.com>
 <ZyyZugciNAYmVjeP@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mvtersjbptrnwigl"
Content-Disposition: inline
In-Reply-To: <ZyyZugciNAYmVjeP@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--mvtersjbptrnwigl
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 0/8] qapi: add generator for Golang interface
MIME-Version: 1.0

Hi,

On Thu, Nov 07, 2024 at 10:43:06AM +0000, Daniel P. Berrang=E9 wrote:
> Bringing this thread back from the dead, since I had an
> in-person discussion on a key question below at KVM Forum this
> year and want to record it here.

Thanks for that.
=20
> On Fri, Jun 17, 2022 at 02:19:24PM +0200, Victor Toso wrote:
> > Hi,
> >=20
> > This is the second iteration of RFC v1:
> >   https://lists.gnu.org/archive/html/qemu-devel/2022-04/msg00226.html
> >=20
> >=20
> > # What this is about?
> >=20
> > To generate a simple Golang interface that could communicate with QEMU
> > over QMP. The Go code that is generated is meant to be used as the bare
> > bones to exchange QMP messages.
> >=20
> > The goal is to have this as a Go module in QEMU gitlab namespace,
> > similar to what have been done to pyhon-qemu-qmp
> >   https://gitlab.com/qemu-project/python-qemu-qmp
> >=20
> >=20
> > # Issues raised in RFC v1
> >=20
> >   The leading '*' for issues I addressed in this iteration
> >=20
> > * 1) Documentation was removed to avoid License issues, by Daniel
> >      Thread: https://lists.nongnu.org/archive/html/qemu-devel/2022-05/m=
sg01889.html
> >=20
> >      It is important for the generated Go module to be compatible with
> >      Licenses used by projects that would be using this. Copying the
> >      documentation of the QAPI spec might conflict with GPLv2+.
> >=20
> >      I have not proposed another license in this iteration, but I'm
> >      planning to go with MIT No Attribution, aka MIT-0 [0]. Does it make
> >      sense to bind the generated code's license to MIT-0 already at
> >      generator level?
> >=20
> >      [0] https://github.com/aws/mit-0/blob/master/MIT-0
>=20
> To recap the situation
>=20
>  * The license of the code generator itself does not determine the
>    license of the output generated code
>=20
>  * The license of the inputs to the code generator, may or may
>    not, determine the license of the output generated code depending
>    on use context
>=20
> The primary input to the code generator is the QAPI schema, which is part
> of QEMU and thus licensed GPL-2.0-or-later.
>=20
> The QAPI schema includes both the API definitions AND the API documentati=
on
> text.
>=20
> We can make the case that as the QEMU public interface, consuming the
> API definitions in the QAPI schema for the purpose of generating code
> is "fair use", and thus the output generated code does NOT need to
> match the GPL-2.0-or-later license of the QAPI schema. We can choose
> the code license, and a maximally permissive license looks appropriate.
>=20
> We want to have API documentation for the Golang bindings and the obvious
> way to achieve this is to copy the API docs from the QAPI schema into the
> Golang code. It is NOT reasonable to class such *direct copying* of docs
> "fair use".  IOW, copied docs will be under GPL-2.0-or-later.
>=20
> Thus if we pick MIT-0 for the Golang code, and copy across the QAPI docs,
> the resulting  Golang QAPI project code would be under a compound license
> term "MIT-0 AND GPL-2.0-or-later".
>=20
> The concern was that this will limit the ability of downstream
> applications to consume the Golang bindings, if they don't want their
> combined work to contain GPL-2.0-or-later.
>=20
> Ignoring whether this fear of GPL-2.0-or-later is sane or not,
> in retrospect I believe that this concern in fact has no legal
> basis.
>=20
> The license of a compiled application binary is the union of all
> the object files linked into it.
>=20
> Notice I said "Object file" there, **NOT** "Source file".
>=20
> This is the crucial distinction that makes the presense of
> GPL-2.0-or-later docs a non-issue from a licensing POV.
>=20
>=20
> When the compiler takes the "MIT-0 and GPL-2.0-or-later" license
> .go source file, and builds an object file, it will be discarding
> all the API documentation comments. IOW, all the parts that were
> under GPL-2.0-or-later are discarded. The only parts of the source
> file that get "compiled" are the Go language constructs which were
> MIT-0 licensed [1].
>=20
> IOW, we have a "MIT-0 and GPL-2.0-or-later" .go source file,
> and an "MIT-0" object file.
>=20
> Thus while there may be a human perception problem with the Golang
> bindings being "MIT-0 and GPL-2.0-or-later", there are no legal
> licensing limitations, as the combined work for a library or
> application linking the bindings will only contain the MIT-0 part.
>=20
> The GPL-2.0-or-later docs won't influence the license of the
> combined work.
>=20
> Note, this interpretation applies only to languages which are
> compiled, not interpreted.
>=20
> If we are generating python code for example, the there is
> no "source file" vs "object file" distinction for licensing.
> The combined work in a python app is under the union of all
> the source file licenses.
>=20
>=20
> TL;DR: I think you can re-add the documentation comments to
> the Golang code generator, declare the resulting code as being
> "MIT-0 AND GPL-2.0-or-later".

Yes. I think so too. I plan to add it back and address Andrea's
last review and submit it in the next week or so.

> In the README.md file we need todo two important things:
>=20
>  * Document our interpretation of the "combined work" license
>    situation for applications consuming the project.
>  * Declare that *ALL* manually written code contributions
>    are exclusively MIT-0.
>=20
> With regards,
> Daniel
>=20
> [1] NB, there are languages where some code comments can have semantic
>     impacts on the compiled out. I don't believe that to be the case for
>     any human targetted API docs that we would be copying over from the
>     QAPI schema though in the Golang case.

Cheers,
Victor

--mvtersjbptrnwigl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmct3SQACgkQl9kSPeN6
SE9DaRAAiCvKSUsfbe/Q6p0ykOFH9Y0nXTtHl7skYRx9LX0tgx7rFuk48Y8cDxFx
ssFH3G/1UR5OVJEzZClrURb5kKOPdizZk6PGgFqsmg5x+UKessdX62qpqo5IvO8U
VtXkseXvau5xeT60RIWD+rVrPSQVcoB5BuVnNpoX46y35nXN3lf20TqdmmH6b3vb
7tF0NhpAfsnMhGRz/RYy9JH9+HYQ0JCcM4xklK5dV2WcUvhAmZ7ltQbtSpC5ho2s
elHXtAb9fIlhvGHVjQhF3nZTDotAoDOTrICSAmH3UNfi7Zjcd/uPyp6KDzStEzOP
RIzy/W3bU8ELEgpp5++zH8BJoSHgZIFnhHhTNYKB6+YZkmfECglHcB2/PvELgsi4
iD4eydTBcOU6GQjEV70n+Tbhq8kvftC7c3rKYkW4elvGSH72sb2f5xgKVG4YTFUV
GkV2yCqxHD0aAjc25RWPBk1otSFwByWWXoSdc84/CIlKrPQCU3HJX57oJ5qZu0zZ
NMlFYp4w2kKVkkXsyH/1odYh89pxpAMbh31Kl7jjcX4bCJLeUfIZWyM1vhB3IwNc
mdRley6w92ioPHACcxsknA1Vy4/4ZcP//ZchPQIs0mVXsCeqRe9OV4wW9hGSshqM
ACULPjQ/qxGchsObs/YlNEgQpkaJGXWBnDHDqpK2MZMqAIF7CoY=
=Tiyx
-----END PGP SIGNATURE-----

--mvtersjbptrnwigl--


