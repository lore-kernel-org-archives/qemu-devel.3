Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEFDC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 20:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roqbz-00030m-1a; Mon, 25 Mar 2024 16:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1roqbx-0002zT-2j
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 16:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1roqbv-0007g8-P7
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 16:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711397279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3anxDgp+nkyA65Xf+FZxwOE3U/qKDuFqNBudNZQbhJs=;
 b=OzJ38PHxxtVqwocUVhixhlUjeYrL6NmooIKq9VbWbY+dXOCpZHsh8979n7XkbbrP+voS8U
 0OnwRg/ixHEJ1zgtYsvoSd/GP4RNwcPRtmM1SueVE6VWCjya/WRlH6leaLrzfd2kHCmdym
 ta8zs1REnR4Z+nNFkY+EH/hmXetTNSg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-RQcawOvGP5Gneemt6-3iwQ-1; Mon,
 25 Mar 2024 16:07:55 -0400
X-MC-Unique: RQcawOvGP5Gneemt6-3iwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB9873C0C483;
 Mon, 25 Mar 2024 20:07:54 +0000 (UTC)
Received: from localhost (unknown [10.39.192.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A6951C060D1;
 Mon, 25 Mar 2024 20:07:53 +0000 (UTC)
Date: Mon, 25 Mar 2024 16:07:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net,
 t.lamprecht@proxmox.com, w.bumiller@proxmox.com
Subject: Re: [PATCH v3 3/4] block-backend: fix edge case in
 bdrv_next_cleanup() where BDS associated to BB changes
Message-ID: <20240325200748.GC1944176@fedora>
References: <20240322095009.346989-1-f.ebner@proxmox.com>
 <20240322095009.346989-4-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bZ+BGFkn9m6+g2gu"
Content-Disposition: inline
In-Reply-To: <20240322095009.346989-4-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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


--bZ+BGFkn9m6+g2gu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 10:50:08AM +0100, Fiona Ebner wrote:
> Same rationale as for commit "block-backend: fix edge case in
> bdrv_next() where BDS associated to BB changes". The block graph might
> change between the bdrv_next() call and the bdrv_next_cleanup() call,
> so it could be that the associated BDS is not the same that was
> referenced previously anymore. Instead, rely on bdrv_next() to set
> it->bs to the BDS it referenced and unreference that one in any case.
>=20
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>=20
> New in v3.
>=20
>  block/block-backend.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bZ+BGFkn9m6+g2gu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYB2ZQACgkQnKSrs4Gr
c8hbkAf/UqRCdtq9QBQF3l//3PCUetXAdhahZFt8XUogpEx7iXqvtlytWAVig24B
Scjocyj9E+7P5P/xBFJyczKjlwynEx7syTuotEbrpn5al6b5fagRRdkRuNtRVVu5
2Jyr73SyEgx2ioUEJvQ7LUNijoJ95EiodtjKSEk5I3a9H/Qo3oookJaQlX/Qxo5v
8UkuKA9EozB61lzAQ25cVAt6/GmFDYwfsWZqLulbsHKjVX3lrOA6A42y9vFm6el/
CC7VT7SPFGOVh7Bi0Cz2K7N3R9fHxoWx6Oj3dMj6YhxHGCP1U5Bu8p6AeO56sWmB
olhyik+AazhAy7+VJeS4keUOb027Cw==
=8M87
-----END PGP SIGNATURE-----

--bZ+BGFkn9m6+g2gu--


