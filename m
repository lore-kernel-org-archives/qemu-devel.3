Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDDDC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 12:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkkf0-0000Nl-D2; Thu, 14 Mar 2024 08:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rkkem-0000Ir-Uk
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rkkek-0008Bs-S0
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710421077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nqPV+SswNtmsITti1WF7cfvwbDahOVE5laST+dvSOWI=;
 b=Rp1bbY/b2mOXc3M/b7udWYSrynq27QQ04dgarlK8TjIw8zaIAmkMnQnvQdlHUSaXXwsedl
 ph6zlEanU9/ToxRpo9tSQRF9XV8F5RnOzCW1GcyFabudMeokEoFVWkI0MZlcs7op2ge6wf
 Iqyjoc3CiebG0OiT9cccXzU2xtEmm4Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-JdTJs4TbMQaamgXC_tdorA-1; Thu,
 14 Mar 2024 08:57:55 -0400
X-MC-Unique: JdTJs4TbMQaamgXC_tdorA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A65CD3C0D7CA;
 Thu, 14 Mar 2024 12:57:55 +0000 (UTC)
Received: from localhost (unknown [10.39.195.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D0363C22;
 Thu, 14 Mar 2024 12:57:54 +0000 (UTC)
Date: Thu, 14 Mar 2024 08:57:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 mtosatti@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] file-posix: rearrange BDRVRawState fields
Message-ID: <20240314125753.GC611723@fedora>
References: <20240314111741.1508705-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wykzdalrKpzHNa+X"
Content-Disposition: inline
In-Reply-To: <20240314111741.1508705-1-ppandit@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--wykzdalrKpzHNa+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 04:47:41PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
>=20
> Rearrange BRDVRawState structure fields to avoid memory
> fragments in its object's memory and save some(~8) bytes
> per object.
>=20
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  block/file-posix.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wykzdalrKpzHNa+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXy9FEACgkQnKSrs4Gr
c8iAxwf9GmY7uy+WbZvL/jM8TOhh9TjCwXT9Ru0kfAVi1z52FRvC1IsDFNJcNjnF
dh7NLZRbinYXGgU/RvMPWdLX1qQ6XWRFeqBQTib2Efprh6v8mWXQiWWGbLoN8VVC
YclBFDRZH6o8rQVG5qBOJuTipMsj5XVVlo4gRFVR8HuRPHx+iOqluPR3S0jBXvfZ
1dA8bB8IniX5nF0u6TqjjxQV7+ovG0GkiAn4Y/SYHPi0k+ArTAS0xhojJKhdDKeE
XiFjqF81yoTRkiGZ5+WkZfuJOL9ere+wHdByo7IOgdiIJtWMrckNsuFLFt79Moit
SA79e/Sg2Ha+IwWyemSgKQOXPdAp9w==
=MC/3
-----END PGP SIGNATURE-----

--wykzdalrKpzHNa+X--


