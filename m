Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5614DCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kVB-0001lO-KR; Thu, 25 Sep 2025 07:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v1kV9-0001kB-EX
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v1kV3-0002wQ-Vc
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758801054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=loDgZfObUa1D8DOjgaKpXrKxqNyOW4vu/eGuHA8XyGc=;
 b=IZoFsIXlbuqwq32pOTWgimnM3MUXmt115XsU6OZr3c9LetG48rtYZE4KgbpKzQkF+a9Q2T
 KH4nnk41RiUjN8JvE5pQT5WIZEjACUJjYfOThOgYXBqjB5W6VOJ9jTpPp933ZUnwMItN+T
 FcqlXqVpRf+byqe/Sci46mAAVENZr1s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-VwfgZHqlP9qE3WIOS-FdfA-1; Thu,
 25 Sep 2025 07:50:51 -0400
X-MC-Unique: VwfgZHqlP9qE3WIOS-FdfA-1
X-Mimecast-MFC-AGG-ID: VwfgZHqlP9qE3WIOS-FdfA_1758801050
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8918219560B2; Thu, 25 Sep 2025 11:50:49 +0000 (UTC)
Received: from localhost (unknown [10.2.16.58])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8B2C19560AB; Thu, 25 Sep 2025 11:50:48 +0000 (UTC)
Date: Thu, 25 Sep 2025 07:50:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 08/16] tracetool: Add Rust format support
Message-ID: <20250925115047.GA22729@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-9-pbonzini@redhat.com>
 <20250923192354.GL509965@fedora>
 <85ebee67-3c30-4f14-93ca-d9cf65708619@redhat.com>
 <20250924181024.GB6015@fedora>
 <CABgObfbDphuWOx9r8JEpQCtvGtZM2XYkEd+mBxO4LeqoVPvW6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2ZzLMx0wZTbEd4or"
Content-Disposition: inline
In-Reply-To: <CABgObfbDphuWOx9r8JEpQCtvGtZM2XYkEd+mBxO4LeqoVPvW6A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


--2ZzLMx0wZTbEd4or
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 09:58:04PM +0200, Paolo Bonzini wrote:
> On Wed, Sep 24, 2025, 20:10 Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > > fn trace_event_state_is_enabled(dstate: u16) -> bool {
> > >      unsafe { trace_events_enabled_count } !=3D 0 && dstate !=3D 0
> > > }
> >
> > The generated code is missing DTrace's SDT semaphore (see
> > generate_h_backend_dstate() in scripts/tracetool/backend/dtrace.py). The
> > conditional must be taken when a tool like SystemTap or GDB sets the SDT
> > semaphore. Right now it will not be taken because the conditional only
> > looks at _ ## id ## _DSTATE and not the SDT semaphore.
> >
>=20
> This is private code to trace-*.rs, for use within the tracepoint functio=
ns
> only; it's not a public "is the tracepoint active" API. The public side in
> C does look at the semaphore.

You're right, the code is fine just with the function renamed.

Stefan

--2ZzLMx0wZTbEd4or
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjVLJcACgkQnKSrs4Gr
c8hTzwgAnzuRmWP2uTysNqyrc6SI23wwwLvser1sVxSaRSSL/ptHTgSaWzEXD5T0
tSnof/GZYRScMTYtZDf/9dEgkvs/DWTCb2rBmZoNHuiTid/ibv8KTVz2lUTFFpvo
3s5QKwBNsJedQ4sD2TuaT1UBlzH1Qmbys+2VFQBMVVEiMunvWD4390n/G58VQtCu
J3pN0sTui4AQVpzh+v9YdrUmZMAu/5VRMNr+itPDrbJkHsW/ynvj9i2dZ2DAUzpo
GiIOtgfjbC7m6chn4bzBKUA1kiW8wUQTNxippAU3Glvo2aLEWSOOnWgdVyp0fd1f
4EX3EPMLcNHZQBUt2oJQgh9UqlGGVA==
=KtO8
-----END PGP SIGNATURE-----

--2ZzLMx0wZTbEd4or--


