Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0FFC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7OE-0002iv-0D; Tue, 12 Mar 2024 15:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7O9-0002gs-GQ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7O8-0005Gr-2R
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710270131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j1UprhdJa1cyA3COiycxa9Oa9JLFO+7ER3vFO5RlsgQ=;
 b=K9HUHD/jhOV86ZGQLzDbHwckAYZNkO8pZgXu47u/TzNc4LyCxrxPLfhDIyLckyLCP8PPu8
 wBXO26hO6ilwf4+2BEJTlYdMCg8UXEKNuP2H4bhRIdU+FHYH5xqvqY9PzG+0k02c3m7wQB
 ZM9jSGixAbaeF7sKRAKkGVxuHaVfepM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-ZppjLN63Nfmtu8in9SjYAw-1; Tue,
 12 Mar 2024 15:02:07 -0400
X-MC-Unique: ZppjLN63Nfmtu8in9SjYAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 545C03802B85;
 Tue, 12 Mar 2024 19:02:07 +0000 (UTC)
Received: from localhost (unknown [10.39.192.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C2511C060A4;
 Tue, 12 Mar 2024 19:02:06 +0000 (UTC)
Date: Tue, 12 Mar 2024 14:42:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/2] trace: fix ability to use systemtap with qemu tools
Message-ID: <20240312184245.GD389553@fedora>
References: <20240108171356.1037059-1-berrange@redhat.com>
 <Zc9ejRbEun9VF7fh@redhat.com> <ZfA9vRfC_6xEKmL2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mXzIrmNrlyhok+QB"
Content-Disposition: inline
In-Reply-To: <ZfA9vRfC_6xEKmL2@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--mXzIrmNrlyhok+QB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:34:21AM +0000, Daniel P. Berrang=E9 wrote:
> Ping again for these patches to get into this release.
>=20
> On Fri, Feb 16, 2024 at 01:09:33PM +0000, Daniel P. Berrang=E9 wrote:
> > Ping: Stefan, are you OK with picking up these trace patches
> > for merge ?

Sorry, I missed them.

Stefan

--mXzIrmNrlyhok+QB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXwoiUACgkQnKSrs4Gr
c8hSpwf/RnMCrcSkAM02M2nwEwzMfxdgA1/x1zSwF6JB8twnCVcbRrhnHMopHm1N
roWZY6Vb6JxIvh20L1HKHifyGCQCYrPcHgisK+KA49MoALFIBBgopBaLiJ20y8xs
Te3+Khksr8ygcZTmrJGcbJol2SM8ZLXhKuNREMd7+mJeg2Gy6BSA+Dt6lvLsQzQ2
ji+WsZr+iFiSIPS3V8KIPSnz/YsgyKaTQH32YI6rN2F4UhA7/M3b1g1sLRrN1ZM3
mXIB9/RcrEuZ32DWpgw4Sqfux7Z0pKPPMDhxfzAEaw1tEdKG3itwuGhHzuNWKX7i
TINt1rpOYaEQNTfZPfieRxcEj5TW9w==
=LqCB
-----END PGP SIGNATURE-----

--mXzIrmNrlyhok+QB--


