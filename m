Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF37C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 15:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueEh3-0007ME-Jq; Tue, 22 Jul 2025 11:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ueELJ-0002Rm-1d
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:51:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ueELH-0004ki-4N
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753195901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L8PmE92wTCS0FhvKnf59sbCAMAQqJbFdxejwZqFUDag=;
 b=L133Dnu14hlarNvQbRPlUv+HQk4ZhvmJ1WV8evHXTjn7Wpb3hnn8erJBUTcbLnmibdwQhc
 LUDpzi7u3taHJd+uyWYEIXf4FQUol/UuhcNYxMM0No3CV4ovHrOV3H+X9dnyKCs4YOSRRz
 ZWklh1RjNCuUa7dSUiKi93e7AvTq93w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-XMZAkbxlPAK2DOaU4icc5w-1; Tue,
 22 Jul 2025 10:51:35 -0400
X-MC-Unique: XMZAkbxlPAK2DOaU4icc5w-1
X-Mimecast-MFC-AGG-ID: XMZAkbxlPAK2DOaU4icc5w_1753195894
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F4941800C32; Tue, 22 Jul 2025 14:51:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.72])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C616195608D; Tue, 22 Jul 2025 14:51:32 +0000 (UTC)
Date: Tue, 22 Jul 2025 10:51:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "hreitz@redhat.com" <hreitz@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>
Subject: Re: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for
 QEMU FUSE Exports
Message-ID: <20250722145131.GE8264@fedora>
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250716183824.216257-2-hibriansong@gmail.com>
 <e13f8119-7c60-4aa6-91b0-860ac0a462f5@ddn.com>
 <CAKWCU7WijF5zaEePtCRNVPS3CZF09vfxnkVYVBQQy8V93GUPFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0UMIuhf6K4gnWsoZ"
Content-Disposition: inline
In-Reply-To: <CAKWCU7WijF5zaEePtCRNVPS3CZF09vfxnkVYVBQQy8V93GUPFg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--0UMIuhf6K4gnWsoZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 08:00:00AM -0400, Brian Song wrote:
> On 7/21/25 9:51 AM, Bernd Schubert wrote:
> >> +    struct fuse_in_header *in_hdr =3D (struct fuse_in_header *)&rrh->=
in_out;
> >> +    opcode =3D in_hdr->opcode;
> >> +    req_id =3D in_hdr->unique;
> >> +
> >> +    ent->req_commit_id =3D ent_in_out->commit_id;
> >> +
> >> +    if (unlikely(ent->req_commit_id =3D=3D 0)) {
> >> +        /*
> >> +         * If this happens kernel will not find the response - it will
> >> +         * be stuck forever - better to abort immediately.
> >> +         */
> >> +        error_report("If this happens kernel will not find the respon=
se"
> >> +        " - it will be stuck forever - better to abort immediately.");
> >
> > Dunno about qemu style, but isn't it better to keep the string in a sin=
gle
> > line to make it greppable?
> >
>=20
> The actual log output doesn=E2=80=99t include any line breaks. I just bro=
ke the
> line in the code to keep it under 80 characters per line.

QEMU coding style is stricter about 80 characters per line. Linux allows
long error message strings on a line so it is easier to grep for them in
the source code.

I think it's just a difference in coding style and splitting strings is
generally how QEMU code does it.

Stefan

--0UMIuhf6K4gnWsoZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh/pXMACgkQnKSrs4Gr
c8iVoQf/bAWD0hZSn7QEJrcdvVc2YQZsxkS5EcZAQROq9i8UStAEG00hvEusy2NM
ahw9xJFiKjTTdaeK/WfLo0sBtcZhCzAWXtyHt0lqhR355cFxWagS9wkzQzoGloEL
XlHJDNhXPqOGzqjuaTnW9jzY8vdRM1OjOT454rPZZ5atVo+DYA4yZw00mmS1BwL+
QiqG9U60OtxaToVx5TuYWmRTyCVIygpqBVG2VIjj+N03UROCGuIBis+QegJWv99g
ylwmhuiXGzrnFgxSzOYC0Ugond/5UdlNXwnFDyGiakIAqkpzMQaIKwtLlnXuYwhw
P2xg9C8s0iiA1UUZQxikpryqqY2Qmw==
=lveL
-----END PGP SIGNATURE-----

--0UMIuhf6K4gnWsoZ--


