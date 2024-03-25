Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C06C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roqRH-0007jY-HC; Mon, 25 Mar 2024 15:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1roqRA-0007iv-K1
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1roqR9-0005k4-1l
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711396609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7WYCJ/fs5qtm0lfmnlO1gUKlf4Od1iU5/JbvJs425q4=;
 b=BKrce+owaU4KmvQwf/R4XykksXHBiJuXNZ1buDCOYWrnZeG+omjmj2M2mtA6nfWXtLVfrq
 XVXChMfDQIgmeJE4DSdhDedFFC5IzCs3NF/yFs6iMqazp6fRWZ/+3gMhFdcyH+4vObZGfC
 xjMCuYJeom+yimgJOovEwanYDHsM0mg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Tz6ZBPMGNdy4zZ1tDXSThQ-1; Mon, 25 Mar 2024 15:56:45 -0400
X-MC-Unique: Tz6ZBPMGNdy4zZ1tDXSThQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A9D88FA220;
 Mon, 25 Mar 2024 19:56:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71159492BD0;
 Mon, 25 Mar 2024 19:56:44 +0000 (UTC)
Date: Mon, 25 Mar 2024 15:56:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net,
 t.lamprecht@proxmox.com, w.bumiller@proxmox.com
Subject: Re: [PATCH v3 1/4] block/io: accept NULL qiov in bdrv_pad_request
Message-ID: <20240325195638.GA1944176@fedora>
References: <20240322095009.346989-1-f.ebner@proxmox.com>
 <20240322095009.346989-2-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GPYy9dBDu50Ywqcl"
Content-Disposition: inline
In-Reply-To: <20240322095009.346989-2-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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


--GPYy9dBDu50Ywqcl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 10:50:06AM +0100, Fiona Ebner wrote:
> From: Stefan Reiter <s.reiter@proxmox.com>
>=20
> Some operations, e.g. block-stream, perform reads while discarding the
> results (only copy-on-read matters). In this case, they will pass NULL
> as the target QEMUIOVector, which will however trip bdrv_pad_request,
> since it wants to extend its passed vector. In particular, this is the
> case for the blk_co_preadv() call in stream_populate().
>=20
> If there is no qiov, no operation can be done with it, but the bytes
> and offset still need to be updated, so the subsequent aligned read
> will actually be aligned and not run into an assertion failure.
>=20
> In particular, this can happen when the request alignment of the top
> node is larger than the allocated part of the bottom node, in which
> case padding becomes necessary. For example:
>=20
> > ./qemu-img create /tmp/backing.qcow2 -f qcow2 64M -o cluster_size=3D327=
68
> > ./qemu-io -c "write -P42 0x0 0x1" /tmp/backing.qcow2
> > ./qemu-img create /tmp/top.qcow2 -f qcow2 64M -b /tmp/backing.qcow2 -F =
qcow2
> > ./qemu-system-x86_64 --qmp stdio \
> > --blockdev qcow2,node-name=3Dnode0,file.driver=3Dfile,file.filename=3D/=
tmp/top.qcow2 \
> > <<EOF
> > {"execute": "qmp_capabilities"}
> > {"execute": "blockdev-add", "arguments": { "driver": "compress", "file"=
: "node0", "node-name": "node1" } }
> > {"execute": "block-stream", "arguments": { "job-id": "stream0", "device=
": "node1" } }
> > EOF
>=20
> Originally-by: Stefan Reiter <s.reiter@proxmox.com>
> Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
> [FE: do update bytes and offset in any case
>      add reproducer to commit message]
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>=20
> No changes in v3.
> No changes in v2.
>=20
>  block/io.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GPYy9dBDu50Ywqcl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYB1vYACgkQnKSrs4Gr
c8g6gQgAurkX9/v/rP6xPV0XPQZpnL/T2sM688MOA3UAhg2QjdYyfsU79mbAZ7pe
TNHDMfiYtOlfjp4qgK6GfPfTlbTPig6H2finN+PCM044txIexy2qfBzUmjIqhOzt
6fvJDiggcRu5VuH8aCWwPc6Mzld1YgZ1YBLryo33mb6F6ImaMRorSUu3p1pkMZkm
bOn/aE3uuRjMTFiaqVvYCXLxT+pn8jGcAfCOdcAL3PtWQHPyt3MjKfyBf0+8u1Jm
pPyrQ1tH+g/EeW4kNS0GX1JOo3B/1PzuxSWOXRnfwwRHp35XqdAD6QWhzpi0ybcX
Q9bQgKIBb7O77PPEf1T326AyICto1Q==
=E78V
-----END PGP SIGNATURE-----

--GPYy9dBDu50Ywqcl--


