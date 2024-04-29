Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EBDC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 13:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1RGW-0004hK-0g; Mon, 29 Apr 2024 09:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s1RGT-0004gn-2O
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 09:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s1RGM-0001Lp-RK
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 09:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714398104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MNWxOlxBbmr/gWxj8okDSWghmT7xubKC0vYU5u91Ea8=;
 b=i3i1cOWFossf5ntaY2oZFORe9NxK1y4L2pYq+agGxVbCi2LhdO1VM9RFfuB9n8F+gNIesr
 Lncr4Lpbnc+2bYH6KMCDVpipzL2FItxjj5GMvB5UYxgwVFW+aP5fVpyd3yByiVmLwTlCaH
 0B3bdAJy1UBkur8sHfregsRuAm21oaA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-3Ngy_Qj0NKicQv_LPC69kg-1; Mon, 29 Apr 2024 09:41:39 -0400
X-MC-Unique: 3Ngy_Qj0NKicQv_LPC69kg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EF55812C59;
 Mon, 29 Apr 2024 13:41:39 +0000 (UTC)
Received: from localhost (unknown [10.39.195.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B25B72166B31;
 Mon, 29 Apr 2024 13:41:38 +0000 (UTC)
Date: Mon, 29 Apr 2024 09:41:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, pbonzini@redhat.com,
 qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, zheyuma97@gmail.com
Subject: Re: [PULL 0/1] ufs queue
Message-ID: <20240429134136.GA306956@fedora.redhat.com>
References: <cover.1714360640.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G1XgqGIMTWMpUBBy"
Content-Disposition: inline
In-Reply-To: <cover.1714360640.git.jeuk20.kim@samsung.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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


--G1XgqGIMTWMpUBBy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:25:37PM +0900, Jeuk Kim wrote:
> From: Jeuk Kim <jeuk20.kim@samsung.com>
>=20
> The following changes since commit fd87be1dada5672f877e03c2ca8504458292c4=
79:
>=20
>   Merge tag 'accel-20240426' of https://github.com/philmd/qemu into stagi=
ng (2024-04-26 15:28:13 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20240429
>=20
> for you to fetch changes up to f2c8aeb1afefcda92054c448b21fc59cdd99db30:
>=20
>   hw/ufs: Fix buffer overflow bug (2024-04-29 12:13:35 +0900)
>=20
> ----------------------------------------------------------------
> ufs queue
>=20
> - Fix ufs sanitizer vulnerability
>=20
> ----------------------------------------------------------------
> Jeuk Kim (1):
>       hw/ufs: Fix buffer overflow bug
>=20
>  hw/ufs/ufs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

It will be included in my next block pull request.

You are welcome to send pull requests directly to the qemu.git/master
maintainer (Richard Henderson is on duty for this release cycle). If you
do that, make sure to GPG sign your pull request.

Stefan

--G1XgqGIMTWMpUBBy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYvo5AACgkQnKSrs4Gr
c8jAXQf+In4yzeHFuON6nFs1Vd0MsQx9OunlTBJzfCcYzhoaNAKXrUj0FokxadRb
A4ayv7HBcNhnHwm33d7jiyh9BN8fq0tyHwjKmNmRhV1S7MnS8M2W8TZRAvg6l1z7
X07CJBVKKjLTBb8hBZQvOkNfyaCcVkr/Jy9OSbKvxX9uv81MrnvF2654UtdhxR3L
fu1H6q6TllESgjQMjy70pRDK6DSNOnTfe57bBr42nmDRhtCIhqWFMDKOuSTz6pX3
WsfPppKuOsdw4+vr9yZxPpzI+f3jLqoK8JfCSHHgx6FS3jDmo3UW7ZowzTbpZFc0
pP/zoqTzRf8LNTveyQ1ANN/FpE0rZQ==
=Lb1O
-----END PGP SIGNATURE-----

--G1XgqGIMTWMpUBBy--


