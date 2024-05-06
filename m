Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3737FC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 18:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4318-0003Ah-R2; Mon, 06 May 2024 14:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s4315-00038e-QM
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s4313-00049Z-Ri
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715019884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D8ONALrLyLSYP31SasNqfoWymeMz7GYlS2O0oVXX4MU=;
 b=MFSuuFprIzNq8nwEwzqTFs0jO4RXVFTvJYG+Jq+G3wAlaXIE/PoXL1B1s+4iBtOqWVlmas
 e3fmk0xlfJRzQkbL8NywJOl8g09vOoW9giBpjj3CAxId4MwXSHZufz52O+pfL0CT32CpHj
 M1C+7CYPg4Ie2FEfLBmcIGVTZfiTvxc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-IjEeafBdMTaECdz4Fmu5lg-1; Mon, 06 May 2024 14:24:41 -0400
X-MC-Unique: IjEeafBdMTaECdz4Fmu5lg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A17348002EA
 for <qemu-devel@nongnu.org>; Mon,  6 May 2024 18:24:41 +0000 (UTC)
Received: from localhost (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25C65492BC6;
 Mon,  6 May 2024 18:24:40 +0000 (UTC)
Date: Mon, 6 May 2024 14:24:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex Kalenyuk <akalenyu@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Adam Litke <alitke@redhat.com>, qemu-devel@nongnu.org,
 kwolf@redhat.com, "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: qemu-img cache modes with Linux cgroup v1
Message-ID: <20240506182439.GC7375@fedora.redhat.com>
References: <20230731154036.GA1258836@fedora> <ZMftO2aPh9YOu5R0@redhat.com>
 <20230731191527.GB1281379@fedora>
 <CAHahevc5nrUYakDezGmBAn3LPCwvvYREuHdGKXZvaQY-n1Q85A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9rn5xFWIXknFijGU"
Content-Disposition: inline
In-Reply-To: <CAHahevc5nrUYakDezGmBAn3LPCwvvYREuHdGKXZvaQY-n1Q85A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--9rn5xFWIXknFijGU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 08:10:25PM +0300, Alex Kalenyuk wrote:
> Hey, just FYI about tmpfs, during some development on Fedora 39 I noticed
> O_DIRECT is now supported on tmpfs (as opposed to our CI which runs Centos
> 9 Stream).
> `qemu-img convert -t none -O raw tests/images/cirros-qcow2.img
> /tmp/cirros.raw`
> where /tmp is indeed a tmpfs.
>=20
> I might be missing something so feel free to call that out

Yes, it was added by:

commit e88e0d366f9cfbb810b0c8509dc5d130d5a53e02
Author: Hugh Dickins <hughd@google.com>
Date:   Thu Aug 10 23:27:07 2023 -0700

    tmpfs: trivial support for direct IO

It's fairly new but great to have.

Stefan

--9rn5xFWIXknFijGU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY5IGcACgkQnKSrs4Gr
c8hFxgf+NsW/RLT/iIOeifSxnrGz0BxNn7O4JxXfTELpavmT9jJPqwuCS/Adj5O6
Nv++ogLX0WRV1Hlf1YmvcudqgWTeLdsUMVS8j+z8L2PTm1AZvyf0RmrzEEZAw4oY
CJN+2aMn+axMFLfBQcXe97zpEMGVvqvt/YzlVANQhBz5b5FLyPuUe1OjWlMlhRf1
PPkjTcDK9iH/ztfCBjWQ2oe2Y3q4JtI+GSFewp/Khf4YJ/2zJlzF7UG+CsNQ1QpL
4smEx+B8lF/8JhDQXjz6szP49H1XHqTkegJx2YS0mnIJu/x4PlsM3oOCsVjUji84
JpRbUTzWhkfb6+yDc6HtIDD8c4g5+Q==
=dhOp
-----END PGP SIGNATURE-----

--9rn5xFWIXknFijGU--


