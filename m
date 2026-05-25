Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADC2CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRXDc-0007Dd-8V; Mon, 25 May 2026 11:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRXDa-0007BA-Hr
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:27:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRXDY-0007M5-3F
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779722866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pTKVsCB69qVS1Mxpnsu7vKBah+yuhygLkCE3A3WK6F8=;
 b=J+mQgGkLPXXZjXBzad4oYcNpCqQu9hi+NtKl+tJ6VnxereVhtqAPz3H4ziRTYMpyl5XoBC
 QUB3VteAZGN0SQxxOc7hu3++U1gKsp43BprUANNV3XO4JaYvyLrdo59z5c2SLtBvHZYhIf
 GF0x6U4MPceMvVBnpZ4pCebO0jXAgRo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-1nFQqK8WMyaZzIcILqfrew-1; Mon,
 25 May 2026 11:27:44 -0400
X-MC-Unique: 1nFQqK8WMyaZzIcILqfrew-1
X-Mimecast-MFC-AGG-ID: 1nFQqK8WMyaZzIcILqfrew_1779722863
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8742118005B5; Mon, 25 May 2026 15:27:43 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E4A93300019F; Mon, 25 May 2026 15:27:42 +0000 (UTC)
Date: Mon, 25 May 2026 11:27:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: on ai generated and code provenance
Message-ID: <20260525152741.GA1644136@fedora>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <87v7ccd9eh.fsf@draig.linaro.org>
 <20260524161048-mutt-send-email-mst@kernel.org>
 <CAJSP0QVuRHg+gkP=aQzbCAeZfMVFF7qWj58QcJwSPTfinApa_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jQHkRXMZ4J9ZBZWu"
Content-Disposition: inline
In-Reply-To: <CAJSP0QVuRHg+gkP=aQzbCAeZfMVFF7qWj58QcJwSPTfinApa_w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--jQHkRXMZ4J9ZBZWu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 04:44:41PM -0400, Stefan Hajnoczi wrote:
> On Sun, May 24, 2026 at 4:12=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Sun, May 24, 2026 at 06:06:46PM +0100, Alex Benn=C3=A9e wrote:
> > > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > >
> > > > So, I had to reject a perfectly reasonable patch:
> > > > https://lore.kernel.org/qemu-devel/20260320193746.242704-1-jinpu.wa=
ng@ionos.com/
> > > > just because of a tool used to make it.
> > > >
> > > >
> > > >     How contributors could comply with DCO terms (b) or (c) for the=
 output of AI
> > > >     content generators commonly available today is unclear.  The QE=
MU project is
> > > >     not willing or able to accept the legal risks of non-compliance.
> > >
> > > In the linked case the LLM is basically doing a glorified search and
> > > replace. There seems to be no danger of accidentally regurgitating any
> > > training data which is where the worry about inadvertent copyright
> > > infringement comes from.
> >
> > Does this mean I can merge it, in your view?
>=20
> It would be a good time to revisit the AI policy. From the QEMU Summit
> 2026 minutes:

Oops, "2026" should have been "2025".

I think the policy should be updated if we're going to depart from the
policy.

Stefan

--jQHkRXMZ4J9ZBZWu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoUam0ACgkQnKSrs4Gr
c8jUFAgAkAADKLcLE0/xhQ4LeMhbXsUfBIX7dalh1OMDvgfuzqoXbC1TRaRQQSUM
v+fx0zgHUu2rmSTjsmaGHCL7kS6hqPNEPbM/ag2Dgv9ved9JvYcqQsP6YZTuMJhc
eAt/Gani52C0kQJQ6PEWgrRd6apN+smhdvZR63dt16QEBgoIZJbUgkHB99/UbusF
BKs22EtXCoKUi3CTY5bXVcHfnmmcrWhiSx7nqX0qhrzGf+NQs0wrAcSwILkW572h
SlmNQwhAO6QC79BG8lEPnn6ToqAk0z+ux1L90rqSuhMlKnwWSVV4Sw3q8tUTd66c
1yEHycEKBhXIoGanuIZcTFJX/EQsgw==
=ObHE
-----END PGP SIGNATURE-----

--jQHkRXMZ4J9ZBZWu--


