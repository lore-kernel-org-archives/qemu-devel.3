Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512A7C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 15:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulr2m-0005R6-2T; Tue, 12 Aug 2025 11:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ulr2i-0005Nt-0H
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 11:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ulr2Y-0004Zb-LV
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 11:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755012949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RdbFae0a7i+vYfkxG1F8H0ckQQcLNnNJoBFXlpG8kqI=;
 b=Af5wi0317JtwtDjIN06+tVTQG7YXtTwhZJF9VX9+UGeh3RcyEovcw8xFFxmAYEPe9t+PGo
 aAqGdBe8RhRZ+jFdaKw5S00ybIupzyRXyhyM1mazP2m+dOT83FhRu5CVIqe4a0hZ9jcK5T
 usY4dfk+KTnJCciF9mm6GK/ljCn8AeQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-n9Djet4POMmFjz1TpflV_Q-1; Tue,
 12 Aug 2025 11:35:48 -0400
X-MC-Unique: n9Djet4POMmFjz1TpflV_Q-1
X-Mimecast-MFC-AGG-ID: n9Djet4POMmFjz1TpflV_Q_1755012947
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E449719560B6; Tue, 12 Aug 2025 15:35:46 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.181])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2291F1800290; Tue, 12 Aug 2025 15:35:42 +0000 (UTC)
Date: Tue, 12 Aug 2025 17:35:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Martin Kletzander <mkletzan@redhat.com>
Cc: "Dr. Werner Fink" <werner@suse.de>, Fabiano Rosas <farosas@suse.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/2] tests/qemu-iotests: Indent expected error messages
Message-ID: <aJtfTBrqAd7x-q7k@redhat.com>
References: <cover.1754060086.git.mkletzan@redhat.com>
 <f5be6d407c105fa199d10867f5de48bbd25c008c.1754060086.git.mkletzan@redhat.com>
 <aIzhtcg-TNZE0zH8@redhat.com> <87v7n63lld.fsf@suse.de>
 <aJCaoULvGgKjEL16@redhat.com>
 <aJL8RH8ePPNEteMg@boole.nue2.suse.org>
 <aJmyZjo0ridS7XXz@wheatley.k8r.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BwU4UP9CK+8Knz70"
Content-Disposition: inline
In-Reply-To: <aJmyZjo0ridS7XXz@wheatley.k8r.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--BwU4UP9CK+8Knz70
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.08.2025 um 11:05 hat Martin Kletzander geschrieben:
> On Wed, Aug 06, 2025 at 08:54:51AM +0200, Dr. Werner Fink wrote:
> > On 2025/08/04 13:33:53 +0200, Kevin Wolf wrote:
> > > Am 01.08.2025 um 21:09 hat Fabiano Rosas geschrieben:
> > > > Daniel P. Berrang=E9 <berrange@redhat.com> writes:
> > > >
> > > > > On Fri, Aug 01, 2025 at 04:59:50PM +0200, Martin Kletzander wrote:
> > > > >> From: Martin Kletzander <mkletzan@redhat.com>
> > > > >>
> > > > >> When running all tests the expected "killed" messages are indent=
ed
> > > > >> differently than the actual ones, by three more spaces.  Change =
it so
> > > > >> that the messages match and tests pass.
> > > > >
> > > > > This would break the tests on my system and CI too.
> > > > >
> > > > > What distro are you seeing this on ?
> > > > >
> > > > > I'm guessing this is a different in either valgrind or C library ?
> > > >
> > > > It's bash, we have an open issue about it:
> > > >
> > > > https://gitlab.com/qemu-project/qemu/-/issues/3050
> > >=20
> > > I see a patch has been posted to that bug, the most important part of
> > > which is this added filtering:
> > >=20
> > > --- a/tests/qemu-iotests/common.filter
> > > +++ b/tests/qemu-iotests/common.filter  2025-07-25 11:39:22.419665788=
 +0000
> > > @@ -75,7 +75,7 @@ _filter_qemu_io()
> > >      _filter_win32 | \
> > >      gsed -e "s/[0-9]* ops\; [0-9/:. sec]* ([0-9/.inf]* [EPTGMKiBbyte=
s]*\/sec and [0-9/.inf]* ops\/sec)/X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX=
 ops\/sec)/" \
> > >          -e "s/: line [0-9][0-9]*:  *[0-9][0-9]*\( Aborted\| Killed\)=
/:\1/" \
> > > -        -e "s/qemu-io> //g"
> > > +        -e "s/qemu-io> //g" -e '/Killed/{ s/ \{2,\}/ /}'
> > >  }
> > >=20
> > >  # replace occurrences of QEMU_PROG with "qemu"
> > >=20
> > > This approach makes sense to me, though I would have kept each sed
> > > expression on a separate line.
> > >=20
> > > And given that the context line above includes "Aborted" as well, may=
be
> > > have it here, too, though none of the actual test outputs have an
> > > Aborted message any more since commit 3f39447. Or we could have a
> > > cleanup patch first that removes the unused "Abort" above, just to ke=
ep
> > > things consistent.
> > >=20
> > > Either way, please post this as a proper patch on the mailing list.
> >=20
> > Just next try in tha attached patch with a fixed version of
> > the sed command.
> >=20
> > Werner
> >=20
> > --=20
> >  "Having a smoking section in a restaurant is like having
> >          a peeing section in a swimming pool." -- Edward Burr
>=20
> > From: Werner Fink <werner@suse.de>
> > Date: Fri, 08 Aug 06:41:23 +0000
> > Subject: [PATCH 1/1] Avoid dependency on padding on signal messages
> >=20
> > New bash 5.3 uses a different padding for reporting job status.
> >=20
> > Resolves: boo#1246830
>=20
> Not sure you meant that or
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3050

I just updated the commit message to contain both.

> > Signed-off-by: Werner Fink <werner@suse.de>
>=20
> but, FWIW, if that makes any difference,
>=20
> Tested-by: Martin Kletzander <mkletzan@redhat.com>

Thanks, applied to the block branch.

Kevin

--BwU4UP9CK+8Knz70
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmibX0wACgkQfwmycsiP
L9Y0ABAAtfaqDF2JvURfP8yGFY0mkupg3mkgypPOLLjkGuuWUOaEVO4q35qNeMRJ
sltBSD7NENYDhjoA7C7HP6P3rRvyzDYaeJuIa/B0YYhut1v8zihg65uhlzfHfjDe
y09bccFBE4wLEQg6zYSfxBvmK2yLfZcM6wqcnr8pUjXbsUDQThAst3HndvnKxml3
Kt9UF/mi1NmtQgUqynbynNmhGnf88U0HGzapBthW+jldiHlIyFndJmWIt+vgAuSN
wzNtdQebN8pcDWlOcE2XsB2BRbUpydh+3Gbpm8hIb9mejP21FMmcho8Fcrm4T7z5
jkSmjcRzsyVppA6pXesIEtdCQw0MUJtjUvXHUXk+X42IsObBwiuuYTpXqzUYdStO
F4r/2ZF3nL/DbpZWp3P/B2R4OCmq0hUVsvaSS9AXVATxtSUSLRA3tA0InPOkhyA3
Fu1ZekqSI7+H1I5L/wOgm9f7mjZ1RDNlIpapm+r8uL4yJq6mDj9VLl8ZBuFxfImb
FqJhRZHzav96ove0QHKiPh0mrsECkuym7yxuZW1xKX2WrxUolo2VkM+AjLrHmXSW
lLuhoF1A4TV3eQ11q26yiZwzGg3mfzriJsYsj3REscCQOPAhlCrI6u38YELs9Rg5
sJrmZfu6K5yMAzmVZtbuKyFPEyy/AYb/dOjmzu/YMKPIn8SIxo0=
=PtQ3
-----END PGP SIGNATURE-----

--BwU4UP9CK+8Knz70--


