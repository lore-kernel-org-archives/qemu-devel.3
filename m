Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5FCC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYQR-00059H-Al; Tue, 17 Jun 2025 11:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRYJN-00017t-IV
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRWyM-0006Qf-63
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 10:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750169253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZjBU+HigXAKQQYnVN3gbkXIJ16yYkfRx0zYRD7UMLoA=;
 b=bB6udaHTKFcDPw8DsbyMLbo3rZmVanDejvsbgaL69bucFCQYIr+PzNntgy73z7Jre++Fp3
 j9BVW0I6C5bEh02iIyTOL5b/zKI0yx0Fw3iVjVgKv8jdb2K9KTfWIGnazU00Adj9VFHrfE
 f7buq7QPYCXNkP9kEnJdFExMpEcoV7E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-5aHIZG_DObWw1IzVWjYt2A-1; Tue,
 17 Jun 2025 10:07:29 -0400
X-MC-Unique: 5aHIZG_DObWw1IzVWjYt2A-1
X-Mimecast-MFC-AGG-ID: 5aHIZG_DObWw1IzVWjYt2A_1750169248
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A10941955E90; Tue, 17 Jun 2025 14:07:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94A8018003FC; Tue, 17 Jun 2025 14:07:26 +0000 (UTC)
Date: Tue, 17 Jun 2025 10:07:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 1/3] tracetool: removed the unused vcpu property
Message-ID: <20250617140725.GA117267@fedora>
References: <20250616201222.6416-1-tanishdesai37@gmail.com>
 <20250616201222.6416-2-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IHCHnmSCRfkf28ke"
Content-Disposition: inline
In-Reply-To: <20250616201222.6416-2-tanishdesai37@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--IHCHnmSCRfkf28ke
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 08:12:20PM +0000, Tanish Desai wrote:
> The vcpu property is no longer used in these backends. Removing it avoids
> unnecessary checks and simplifies the code generation for these trace bac=
kends.
>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  scripts/tracetool/backend/log.py    | 6 +-----
>  scripts/tracetool/backend/simple.py | 6 +-----
>  scripts/tracetool/backend/syslog.py | 6 +-----
>  3 files changed, 3 insertions(+), 15 deletions(-)

Please also remove "vcpu" from scripts/tracetool/__init__.py:Event:

  _VALID_PROPS =3D set(["disable", "vcpu"])

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--IHCHnmSCRfkf28ke
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhRdp0ACgkQnKSrs4Gr
c8iUqwgApBlq4mUjHXaNi51ZVExPp6/hsGoXm1h7zLtnbJQ1bKv/z57JspvdvbFY
OYHNoq/Ym2IjMvy6iR8v163JYcFg0KTQhmcSuiRfhyb7hXVozzRQoTsPE/oVy+s0
FsV1RZW1/ixnOCX+zPQS/A8aSH2I5RlROGVkauPS9Fmd8qOobJVoCmZjFCBmnTLp
/xDMz6GdIa9M01zAnoCNp9VgaszHB/xRXe9835JPe7+xS4xweUuZ8G+2fprhoeE9
RYBZ6ScKtZwT4H2ujcfaz1RaobknYVwIlS7mdoxYVf8tkdWio27UrjVVw6MngLqh
KS7+VybMbKwVpHlj7O8DiBgnxaxFQg==
=C9d+
-----END PGP SIGNATURE-----

--IHCHnmSCRfkf28ke--


