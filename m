Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85539C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 19:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj1k9-0001py-QG; Tue, 27 Aug 2024 15:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sj1k7-0001oi-NW
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sj1k4-0002Wi-H7
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724786434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YQovZ2FvGToAlKG75tverA4PubUQXFXHEniq77HGqAM=;
 b=UBi/U9ulH3UqYzPVWTjsKRVQFgTBc+WHca90hBKN5ro//N0jcSpek90ugJKT9DKMMeYNMr
 cavxcdQJctyLWZ4B5gPqWlM3vi8rnfy3lGbMNBnkKUL16DTGvK+UD0+waO09Dlc2AQf8GA
 fRPJNC+AOxKJuSY75ey8FzT814wRSwc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-JPusnosgPLWZgi6LSIOI4Q-1; Tue,
 27 Aug 2024 15:20:27 -0400
X-MC-Unique: JPusnosgPLWZgi6LSIOI4Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7C2A19560AB; Tue, 27 Aug 2024 19:20:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.119])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E2FC19560AA; Tue, 27 Aug 2024 19:20:24 +0000 (UTC)
Date: Tue, 27 Aug 2024 15:20:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: paul@xen.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, pkrempa@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>
Subject: Re: [PATCH v2 0/2] qdev-monitor: avoid QemuOpts in QMP device_add
Message-ID: <20240827192023.GA937897@fedora.redhat.com>
References: <20240801140552.1021693-1-stefanha@redhat.com>
 <87wmkz5oqk.fsf@pond.sub.org>
 <20240812181534.GC69160@fedora.redhat.com>
 <3a9f0e9a-3873-4cd0-8773-c2ed6230da81@xen.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="N0tVOeh+JhGgb5uc"
Content-Disposition: inline
In-Reply-To: <3a9f0e9a-3873-4cd0-8773-c2ed6230da81@xen.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--N0tVOeh+JhGgb5uc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 09:18:46AM +0100, Paul Durrant wrote:
> On 12/08/2024 19:15, Stefan Hajnoczi wrote:
> > On Fri, Aug 02, 2024 at 10:10:43AM +0200, Markus Armbruster wrote:
> > > Can we additionally cut out the QemuOpts middleman in
> > > usbback_portid_add()?
> > >=20
> > >      qdict =3D qdict_new();
> > >      qdict_put_str(qdict, "driver", "usb-host");
> > >      tmp =3D g_strdup_printf("%s.0", usbif->xendev.qdev.id);
> > >      qdict_put_str(qdict, "bus", tmp);
> > >      g_free(tmp);
> > >      tmp =3D g_strdup_printf("%s-%u", usbif->xendev.qdev.id, port);
> > >      qdict_put_str(qdict, "id", tmp);
> > >      g_free(tmp);
> > >      qdict_put_int(qdict, "port", port);
> > >      qdict_put_int(qdict, "hostbus", atoi(busid));
> > >      qdict_put_str(qdict, "hostport", portname);
> > >      opts =3D qemu_opts_from_qdict(qemu_find_opts("device"), qdict,
> > >                                  &error_abort);
> > >      usbif->ports[port - 1].dev =3D USB_DEVICE(qdev_device_add(opts, =
&local_err));
> > >=20
> > > Trying this is up to you!
> >=20
> > Paul or Anthony: Do you know how to run usbback_portid_add() for
> > testing? I would like to make sure that suggested the code change works
> > and don't have experience running the Xen code in QEMU.
>=20
> Sorry, PV USB is not something I'm familiar with.
> https://wiki.xenproject.org/wiki/Xen_USB_Passthrough suggests that `xl
> usbdev-attach` might be the way to test... but you'd need a system with X=
en
> installed and suitably configured guest, so not trivial to set up.

Thanks for the pointer! I will leave the usbback_portid_add()
refactoring because I don't have a setup for testing it.

Stefan

--N0tVOeh+JhGgb5uc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbOJvcACgkQnKSrs4Gr
c8gk3AgArfAGsYRTFQVSE8rN5VSpkSj/iinU8wj5PPe0r0hnnQSuGdLpc60t1n2o
6UL195FNtS86INESz33H6aPBCr4bJiaQC/TA4kvzohDHsAjTJT8ccMgqxLh/y6FB
b4OL1BoS9Jkk42csPGnAFLxwEdP2UwG+h3wSJigOnzqZYGEBkgQQD3YZtejk7UG7
TRHS7ME8Eq+zgbVOZrrIBErrprU2lDUz+wf6ZRdRKYJXKnXXJhsfVpc0ZpJegXNL
u6ygatRIkjY1pl86uJZh1ozphNepdsTg7WOFvkwmom/VOLvHAIunYsgc/QhlKGuc
KlBdjNtbCPGRue/wEwhCEmYZqkmX4A==
=kImC
-----END PGP SIGNATURE-----

--N0tVOeh+JhGgb5uc--


