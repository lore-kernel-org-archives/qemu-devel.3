Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8003FC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Qus-0006Js-PH; Tue, 01 Sep 2026 12:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1Quq-0006J5-KZ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1Quo-0000ui-GB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788278447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v5xr28GMUjXmHZ/dL9gf/HkpUzLj907UopSwziDkVnc=;
 b=OImp+tv1LHYmasvMdAX5Ebd0OP41X97/kuBxzNXT1524MeFMSJYr+r3PTvvIsHjzIfy/S1
 qHNf9wAW/+drdRfJKvhpb69X3W4FfeKvEeNTw/VzIt8S7Z6hdgKqdt3s+Pzs97ei6knLCx
 bRQFfYYabK+qBnIzr3mTunAbF3rnejs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-a5GLjdDPNnqdWgeGwRwv7Q-1; Tue,
 01 Sept 2026 12:00:45 -0400
X-MC-Unique: a5GLjdDPNnqdWgeGwRwv7Q-1
X-Mimecast-MFC-AGG-ID: a5GLjdDPNnqdWgeGwRwv7Q_1788278444
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 041A11800149; Tue,  1 Sep 2026 16:00:44 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F8237D8; Tue,  1 Sep 2026 16:00:43 +0000 (UTC)
Date: Tue, 1 Sep 2026 12:00:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Huiba Li <lihuiba@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [RFC] block: add an overlaybd image format driver
Message-ID: <20260901160042.GB600046@fedora>
References: <CA+AFTT-iZ8wbUOkEaU_SCM0rnqRJsefkOr=CTgC6T22nz_ZFoA@mail.gmail.com>
 <CA+AFTT-8odiRzg8mcnZiEQTyTiMeK5rHUFB6an+6wFgYLtyh1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K93S3P7oQOf97aEr"
Content-Disposition: inline
In-Reply-To: <CA+AFTT-8odiRzg8mcnZiEQTyTiMeK5rHUFB6an+6wFgYLtyh1g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--K93S3P7oQOf97aEr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 11:09:56AM +0800, Huiba Li wrote:
> Hi all,
>=20
> Gentle ping on this RFC from Aug 18.

Hi Huiba,
Sorry your RFC was not seen. Kevin is on vacation and I will take a look
in the meantime. Please CC stefanha@redhat.com in future emails so it
comes to my attention.

Thanks!

Stefan

>=20
> In short: overlaybd is an openly specified image format (CNCF-hosted;
> read-only blob stack + writable top, O(1) lookup regardless of chain
> depth) deployed at scale for container/VM image streaming. The RFC
> proposes an in-tree C block driver, starting with read-only support
> (index merge at open, raw + ZFile layers), writes handled by a
> qcow2/raw file on top.
>=20
> I'd especially appreciate thoughts on the four questions in the RFC:
>=20
>   1. Is a new in-tree format driver acceptable in principle?
>   2. Is read-only-first a reasonable initial scope (with iotests and a
>      docs/interop spec page)?
>   3. Remote blobs: compose over block/curl, or fetch in-driver?
>   4. CLI surface: point -drive at the OCI-style JSON config, or
>      per-layer options?
>=20
> Question 1 is the main gate -- if in-principle feedback is easier to
> give than a full design review, that alone would help me decide
> whether to proceed with the first series.
>=20
> Thanks,
> Huiba
>=20
>=20
> Huiba Li <lihuiba@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=BA=8C 17:38=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi,
> >
> > I would like to propose adding a QEMU block driver for the
> > overlaybd image format, and I am looking for early feedback on
> > scope and design before sending patches.
> >
> > What overlaybd is
> > -----------------
> > Overlaybd is an open-source image format (https://containerd.github.io/=
overlaybd/)
> > hosted as a sub-project of containerd (CNCF graduated). A disk
> > image is a stack of read-only snapshot blobs plus a writable top
> > file, in a layout compatible with OCI image registries: a base
> > image is stored once and shared by every derivative image, and
> > data is fetched on demand rather than pulled in full before boot.
> >
> > Two properties distinguish it from qcow2/VHDX/VMDK-style chains:
> >
> >   * Lookup cost is O(1) in chain depth. At open time the per-file
> >     indices are merged into a single in-memory index (an
> >     extent-based log-structured merge tree), so a read never walks
> >     backing files, and per-file index caches do not multiply with
> >     snapshots.
> >
> >   * The merged index is small (about 300 KB average for 50+ GB
> >     images in our production data), and because extents are
> >     variable-length, writes land at 512-byte granularity with no
> >     cluster copy-on-write.
> >
> > The format is openly specified:
> >   https://github.com/containerd/overlaybd/tree/main/docs/specs/lsmt.md
> >   https://github.com/containerd/overlaybd/tree/main/docs/specs/zfile.md
> >
> > Reference implementation:
> >   https://github.com/containerd/overlaybd
> >
> > Overlaybd has been in production at Alibaba for years (Taobao,
> > Tmall, Alibaba Cloud, Function Compute) and is used by Azure AKS
> > Artifact Streaming, Databricks serverless compute, and several
> > microVM-based sandbox platforms. The design is documented in two
> > USENIX ATC papers (DADI, ATC'20; FaaSNet, ATC'21). I am one of the
> > overlaybd/DADI authors.
> >
> > Why a QEMU driver
> > -----------------
> > Today overlaybd images are served to VMs through a kernel blk dev
> > and a userspace daemon. That fits container workloads well, but
> > a native QEMU driver would let any QEMU-based stack (libvirt,
> > KubeVirt, OpenStack, plain qemu-system-*) boot overlaybd images
> > directly, with QEMU's usual amenities (backing files, block jobs,
> > throttling, migration) and no extra daemon on the host. This is
> > beneficial to agent sandboxes.
> >
> > Proposed implementation
> > -----------------------
> > A new block format driver, block/overlaybd.c, written in C from the
> > open spec (like the existing vmdk/vhdx drivers) rather than binding
> > the C++ reference implementation:
> >
> >   * v1: read-only support. Local layer files, index merge at open,
> >     raw and ZFile blobs (lz4/zstd are already optional QEMU
> >     dependencies). Writes can be served by a qcow2/raw file on top,
> >     exactly like booting a read-only backing image today.
> >   * v2: native writable layer, and lazy fetching of remote blobs =E2=80=
=94
> >     either composed over the existing curl driver or with a small
> >     built-in HTTP fetcher; guidance welcome.
> >
> > Questions
> > ---------
> >   1. Is a new in-tree format driver acceptable in principle, given
> >      the format is stable, openly specified, and deployed at scale?
> >   2. Is read-only-first a reasonable merge scope for the initial
> >      series (with iotests and a docs/interop/ spec page)?
> >   3. For remote blobs: compose over block/curl, or fetch in-driver
> >      with a local cache?
> >   4. CLI surface: point -drive at the OCI-style JSON image config
> >      (which lists the layer blobs), or expose per-layer options?
> >
> > I will write the iotests and the docs/interop format page, and add
> > myself to MAINTAINERS in the first series.
> >
> > Thanks for any comments,
> > Huiba Li
>=20

--K93S3P7oQOf97aEr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqW9qoACgkQnKSrs4Gr
c8gBBQgAp6OtbQAOY9lh9SuSrn/ArjI3DUrzhZvgydvwy5zq2DqhbJKuElWWN0li
WOxlSUklo1CkQXXlIHvxTas5XS36kWLAiGWqP5Xbg2Gyx5dJnMkDj4SWFYS2uMLB
2TLvj6iLpnWEfM0BevgBfs0Y0k/Ij3yArtbJIq7t8Ph/Ff6iNC/yE8Dkab1Hv+Lb
dWHwfygBVFkuxRG05m7leBDddOPhmBsa4m6SmzB0LxuE2lZNejS9fSVHx1xD0L1L
dvmjZA6yCHzLt8/AgsalocmzWAcBynF+Rm8fCIARTozUcnM6l+bI2Hs+ukIuJF9Z
jZmNzHgbUBD+mSXbeFNXRGKGj5hPEw==
=AljY
-----END PGP SIGNATURE-----

--K93S3P7oQOf97aEr--


