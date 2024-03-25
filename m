Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9749C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 20:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roqaG-0001tE-VQ; Mon, 25 Mar 2024 16:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1roqaE-0001sZ-Dc
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 16:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1roqaB-0007QE-Sf
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 16:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711397168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AVODJGUYd/VsvF2tPl6vDThtr/kvmRd+0KaDEHHmwRU=;
 b=bKLI3kVKM6g0KL8HrHQHvcB43KfEgh5Lgkl81dxOlQi84EQsC+g/0lsArjf+5vdozpV1av
 6lKG4TnC13hYuS5LnoF4bhYK775uBxbJKyAc3CbZQTWOQE7A+RscYz39xfWTSS9o9fZMA4
 VSn+Vw+6WSAf5v1wLC3JSMinGb2oxAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-URHS6XKtNRiQEaS5ymVGaA-1; Mon, 25 Mar 2024 16:06:06 -0400
X-MC-Unique: URHS6XKtNRiQEaS5ymVGaA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 277478007A1;
 Mon, 25 Mar 2024 20:06:06 +0000 (UTC)
Received: from localhost (unknown [10.39.192.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97863492BD6;
 Mon, 25 Mar 2024 20:06:05 +0000 (UTC)
Date: Mon, 25 Mar 2024 16:06:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net,
 t.lamprecht@proxmox.com, w.bumiller@proxmox.com
Subject: Re: [PATCH v3 2/4] block-backend: fix edge case in bdrv_next() where
 BDS associated to BB changes
Message-ID: <20240325200600.GB1944176@fedora>
References: <20240322095009.346989-1-f.ebner@proxmox.com>
 <20240322095009.346989-3-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LVRyxxsVAdelT9ON"
Content-Disposition: inline
In-Reply-To: <20240322095009.346989-3-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--LVRyxxsVAdelT9ON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 10:50:07AM +0100, Fiona Ebner wrote:
> The old_bs variable in bdrv_next() is currently determined by looking
> at the old block backend. However, if the block graph changes before
> the next bdrv_next() call, it might be that the associated BDS is not
> the same that was referenced previously. In that case, the wrong BDS
> is unreferenced, leading to an assertion failure later:
>=20
> > bdrv_unref: Assertion `bs->refcnt > 0' failed.
>=20
> In particular, this can happen in the context of bdrv_flush_all(),
> when polling for bdrv_co_flush() in the generated co-wrapper leads to
> a graph change (for example with a stream block job [0]).
>=20
> A racy reproducer:
>=20
> > #!/bin/bash
> > rm -f /tmp/backing.qcow2
> > rm -f /tmp/top.qcow2
> > ./qemu-img create /tmp/backing.qcow2 -f qcow2 64M
> > ./qemu-io -c "write -P42 0x0 0x1" /tmp/backing.qcow2
> > ./qemu-img create /tmp/top.qcow2 -f qcow2 64M -b /tmp/backing.qcow2 -F =
qcow2
> > ./qemu-system-x86_64 --qmp stdio \
> > --blockdev qcow2,node-name=3Dnode0,file.driver=3Dfile,file.filename=3D/=
tmp/top.qcow2 \
> > <<EOF
> > {"execute": "qmp_capabilities"}
> > {"execute": "block-stream", "arguments": { "job-id": "stream0", "device=
": "node0" } }
> > {"execute": "quit"}
> > EOF
>=20
> [0]:
>=20
> > #0  bdrv_replace_child_tran (child=3D..., new_bs=3D..., tran=3D...)
> > #1  bdrv_replace_node_noperm (from=3D..., to=3D..., auto_skip=3D..., tr=
an=3D..., errp=3D...)
> > #2  bdrv_replace_node_common (from=3D..., to=3D..., auto_skip=3D..., de=
tach_subchain=3D..., errp=3D...)
> > #3  bdrv_drop_filter (bs=3D..., errp=3D...)
> > #4  bdrv_cor_filter_drop (cor_filter_bs=3D...)
> > #5  stream_prepare (job=3D...)
> > #6  job_prepare_locked (job=3D...)
> > #7  job_txn_apply_locked (fn=3D..., job=3D...)
> > #8  job_do_finalize_locked (job=3D...)
> > #9  job_exit (opaque=3D...)
> > #10 aio_bh_poll (ctx=3D...)
> > #11 aio_poll (ctx=3D..., blocking=3D...)
> > #12 bdrv_poll_co (s=3D...)
> > #13 bdrv_flush (bs=3D...)
> > #14 bdrv_flush_all ()
> > #15 do_vm_stop (state=3D..., send_stop=3D...)
> > #16 vm_shutdown ()
>=20
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>=20
> No changes in v3.
> New in v2.
>=20
>  block/block-backend.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LVRyxxsVAdelT9ON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYB2SgACgkQnKSrs4Gr
c8joawgAqw7wNEZfMdxjhOrtJQP7wwBN/gRZc+6359Pwx/3p7eyYp0++QJDXnopi
25cPPY6pn2JybQnUfFEWMv3Gwk0Z49uJUlh2By1TPxYAVwm60GaiaG5wv8swnDE1
zl0XxAmqVdMIycfyHQoVr6kMCZqn0wxVnb0AxsaUAJGsZCFE0AC+5FKqfh4SbDiF
98IaoLyxRCcHKTQm79OijBEDB9+oXGao5ZOu8QGjiK8S/Ym64g6udHZzpdzPfgZ6
uNRhkAjh77wypfuq4M0t4/LOSIqsZh034/b/6+RgylJaF71Ou2sKtGDODXHKmfIR
oNnRl/7kUyLFrAavHz4V7/D+rMl3Eg==
=dFG8
-----END PGP SIGNATURE-----

--LVRyxxsVAdelT9ON--


