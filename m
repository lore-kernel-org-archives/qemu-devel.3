Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D292C52D71
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 13:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbgxE-0005Eh-US; Wed, 07 Aug 2024 09:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sbgxB-0005B0-1i
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 09:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sbgx8-0005Fm-Ra
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 09:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723038226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kFLHuBTceLZdkp9LrWzZltOOiHtJfnR4o1vCph6qHUk=;
 b=O3ulOYoIfvt46GA+asUggGd/7+Nv5esXywH6oXztQrselc4AS94aMP9pWnWCnASj+y7yR7
 iE13uCmZDS7D1J8+JDNfXM3lXHzF6pFWakvtIuotpa8Wkkt/UxpZSR3UjPn00OgJ8+FC+b
 xuYwLoVMSWPt1og2KsMnFY40I7XI6IA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-64YDBk6vNoOfla6hoSeHFA-1; Wed,
 07 Aug 2024 09:43:42 -0400
X-MC-Unique: 64YDBk6vNoOfla6hoSeHFA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71CF919560B3; Wed,  7 Aug 2024 13:43:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.129])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55E9E300018D; Wed,  7 Aug 2024 13:43:40 +0000 (UTC)
Date: Wed, 7 Aug 2024 09:43:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, rjones@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 2/2] qemu-img: CVE-XXX Sanitize untrusted output from NBD
 server
Message-ID: <20240807134339.GC131475@fedora.redhat.com>
References: <20240802194156.2131519-4-eblake@redhat.com>
 <20240802194156.2131519-6-eblake@redhat.com>
 <ac870295-4fe0-4c46-a5f1-36eb2945a5dd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PYMA5bPjvqDOfO8A"
Content-Disposition: inline
In-Reply-To: <ac870295-4fe0-4c46-a5f1-36eb2945a5dd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--PYMA5bPjvqDOfO8A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 11:41:35PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 2/8/24 21:26, Eric Blake wrote:
> > Error messages from an NBD server must be treated as untrusted; a
> > malicious server can inject escape sequences to try and trigger RCE
> > flaws via escape sequences to whatever terminal happens to be running
> > qemu-img.  The easiest solution is to sanitize the output with the
> > same code we use to produce sanitized (pseudo-)JSON over QMP.
> >=20
> > Rich Jones originally pointed this flaw out at:
> > https://lists.libguestfs.org/archives/list/guestfs@lists.libguestfs.org=
/thread/2NXA23G2V3HPWJYAO726PLNBEAAEUJAU/
> >=20
> > With this patch, and a malicious server run with nbdkit 1.40 as:
> >=20
> > $ nbdkit --log=3Dnull eval open=3D' printf \
> >    "EPERM x\\r mess up the output \e[31mmess up the output\e[m mess up"=
 >&2; \
> >    exit 1 ' get_size=3D' echo 0 ' --run 'qemu-img info "$uri"'
> >=20
> > we now get:
> >=20
> > qemu-img: Could not open 'nbd://localhost': Requested export not availa=
ble
> > server reported: /tmp/nbdkitOZHOKB/open: x\r mess up the output \u001B[=
31mmess up the output\u001B[m mess up
> >=20
> > instead of an attempt to hide the name of the Unix socket and forcing
> > the terminal to render part of the text red.
> >=20
> > Note that I did _not_ sanitize the string being sent through
> > trace-events in trace_nbd_server_error_msg; this is because I assume
> > that our trace engines already treat all string strings as untrusted
> > input and apply their own escaping as needed.
> >=20
> > Reported-by: "Richard W.M. Jones" <rjones@redhat.com>
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> >=20
> > ---
> >=20
> > If my assumption about allowing raw escape bytes through to trace_
> > calls is wrong (such as when tracing to stderr), let me know.  That's
> > a much bigger audit to determine which trace points, if any, should
> > sanitize data before tracing, and/or change the trace engines to
> > sanitize all strings (with possible knock-on effects if trace output
> > changes unexpectedly for a tool expecting something unsanitized).
>=20
> I doubt the trace core layer sanitizes, but it feels it is the
> trace backend responsibility, since core layer might just pass
> pointer to the backends.

Yes, strings are not escaped by the core tracing code. They probably
should not be escaped by QEMU since the trace backend may wish to
process the strings and it expects to operate on raw strings.

>=20
> > ---
> >   nbd/client.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
>=20

--PYMA5bPjvqDOfO8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmazegsACgkQnKSrs4Gr
c8iGEgf/R7G+JRdXlYdVTpK/fyjTDZ+t/ZGrdIPdkr+MOe79XhSJE05/i9Z7mTEs
PviHx3zY5GYu8hh9QdBOQyD5i4APel7U/zKh6r0MC47BghiFkFXFQipi+pIhNd8r
dk69mowBqkx4ATDJM8CVFNUzTFQyVhdR+gU6KJLDhPuwxm08YNwZJgsOx4/uy7nI
PlSOv09DYsfEg9QkH6++9GPGg71dSt4e7ASDZSB1OcVOKJM+c7Zus1yLB6whg1gN
g+0efS/gtQAbLZjogwfFYveFDdTnAyXCx1b1k+lfgsnNb8HmTAobMqy36mA5IWAN
2s4apGVyy8mQxci0YJHdIKOWyeFp7A==
=SCQh
-----END PGP SIGNATURE-----

--PYMA5bPjvqDOfO8A--


