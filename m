Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41931C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1VwD-0000wi-Jb; Tue, 01 Sep 2026 17:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1VwC-0000wJ-7g
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 17:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1VwA-0006ij-CR
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 17:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788297753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f2bvx5/r6NSOfsFPxpjPrTx2jO4JToaFlcJbmvcY99k=;
 b=aETqYxmsfJCPrR5kurU4WoPOFV62qoExbf2344eMa/Y+3MiVe7K7eMZKn3gl+q8Dj6pUsw
 bWUFOiL8GMNosVCvhMxILIaxawum5Zewx4va0V6n5N4LzOCD8MUuNPrXI4gJG6+ANSj6rH
 XPvAx1rVaSkQEv79A0Rjro1Dq+8mHVI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-bYJ_fBCzMtWeZ1c-FU1GlQ-1; Tue,
 01 Sept 2026 17:22:29 -0400
X-MC-Unique: bYJ_fBCzMtWeZ1c-FU1GlQ-1
X-Mimecast-MFC-AGG-ID: bYJ_fBCzMtWeZ1c-FU1GlQ_1788297749
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92326195394A; Tue,  1 Sep 2026 21:22:28 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D04ED1955F09; Tue,  1 Sep 2026 21:22:27 +0000 (UTC)
Date: Tue, 1 Sep 2026 17:22:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Huiba Li <lihuiba@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [RFC] block: add an overlaybd image format driver
Message-ID: <20260901212226.GA736562@fedora>
References: <CA+AFTT-iZ8wbUOkEaU_SCM0rnqRJsefkOr=CTgC6T22nz_ZFoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Bv0ijUMCo66Z7aHQ"
Content-Disposition: inline
In-Reply-To: <CA+AFTT-iZ8wbUOkEaU_SCM0rnqRJsefkOr=CTgC6T22nz_ZFoA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--Bv0ijUMCo66Z7aHQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 05:38:38PM +0800, Huiba Li wrote:
> Hi,
>=20
> I would like to propose adding a QEMU block driver for the
> overlaybd image format, and I am looking for early feedback on
> scope and design before sending patches.
>=20
> What overlaybd is
> -----------------
> Overlaybd is an open-source image format (
> https://containerd.github.io/overlaybd/)
> hosted as a sub-project of containerd (CNCF graduated). A disk
> image is a stack of read-only snapshot blobs plus a writable top
> file, in a layout compatible with OCI image registries: a base
> image is stored once and shared by every derivative image, and
> data is fetched on demand rather than pulled in full before boot.

This looks interesting. I've pondered whether the layered and immutable
image trends in recent years can be used effectively for virtual
machines. I will take a look at the specs you linked to understand the
internals better, but in the meantime some answers to your questions
below...

>=20
> Two properties distinguish it from qcow2/VHDX/VMDK-style chains:
>=20
>   * Lookup cost is O(1) in chain depth. At open time the per-file
>     indices are merged into a single in-memory index (an
>     extent-based log-structured merge tree), so a read never walks
>     backing files, and per-file index caches do not multiply with
>     snapshots.
>=20
>   * The merged index is small (about 300 KB average for 50+ GB
>     images in our production data), and because extents are
>     variable-length, writes land at 512-byte granularity with no
>     cluster copy-on-write.
>=20
> The format is openly specified:
>   https://github.com/containerd/overlaybd/tree/main/docs/specs/lsmt.md
>   https://github.com/containerd/overlaybd/tree/main/docs/specs/zfile.md
>=20
> Reference implementation:
>   https://github.com/containerd/overlaybd
>=20
> Overlaybd has been in production at Alibaba for years (Taobao,
> Tmall, Alibaba Cloud, Function Compute) and is used by Azure AKS
> Artifact Streaming, Databricks serverless compute, and several
> microVM-based sandbox platforms. The design is documented in two
> USENIX ATC papers (DADI, ATC'20; FaaSNet, ATC'21). I am one of the
> overlaybd/DADI authors.
>=20
> Why a QEMU driver
> -----------------
> Today overlaybd images are served to VMs through a kernel blk dev
> and a userspace daemon. That fits container workloads well, but
> a native QEMU driver would let any QEMU-based stack (libvirt,
> KubeVirt, OpenStack, plain qemu-system-*) boot overlaybd images
> directly, with QEMU's usual amenities (backing files, block jobs,
> throttling, migration) and no extra daemon on the host. This is
> beneficial to agent sandboxes.
>=20
> Proposed implementation
> -----------------------
> A new block format driver, block/overlaybd.c, written in C from the
> open spec (like the existing vmdk/vhdx drivers) rather than binding
> the C++ reference implementation:
>=20
>   * v1: read-only support. Local layer files, index merge at open,
>     raw and ZFile blobs (lz4/zstd are already optional QEMU
>     dependencies). Writes can be served by a qcow2/raw file on top,
>     exactly like booting a read-only backing image today.
>   * v2: native writable layer, and lazy fetching of remote blobs =E2=80=94
>     either composed over the existing curl driver or with a small
>     built-in HTTP fetcher; guidance welcome.
>=20
> Questions
> ---------
>   1. Is a new in-tree format driver acceptable in principle, given
>      the format is stable, openly specified, and deployed at scale?

Yes.

There are other options like writing a FUSE, iSCSI, or NBD daemon. Linux
ublk (https://www.kernel.org/doc/html/latest/block/ublk.html) is a newer
option with potentially better performance than other daemon approaches.

The advantage of a block driver is that it has better integration with
QEMU and may avoid the need for privileges. The downside is that it's
extra work to integrate with QEMU (and add libvirt support) that
non-QEMU use cases don't benefit from the QEMU block driver.

The choice is yours. There is no fundamental blocker from the QEMU side
if you're willing to write the QEMU code and the format is an open spec.

>   2. Is read-only-first a reasonable merge scope for the initial
>      series (with iotests and a docs/interop/ spec page)?

Yes.

>   3. For remote blobs: compose over block/curl, or fetch in-driver
>      with a local cache?

QEMU's block layer is designed around graphs of block driver nodes.
Reusing the curl block driver would be a natural choice that avoids code
duplication.

However, if you hit issues and it becomes clear that directly calling
libcurl is a better solution, then that's an option too.

>   4. CLI surface: point -drive at the OCI-style JSON image config
>      (which lists the layer blobs), or expose per-layer options?

Both :). Per-layer options allow for run-time (re)configuration or
hotplug using blockdev-add and similar monitor commands. Users may
prefer to point QEMU at a JSON file rather than building long
command-line options.

>=20
> I will write the iotests and the docs/interop format page, and add
> myself to MAINTAINERS in the first series.

You do not need to document the on-disk format in docs/interop/ if you
already maintain the spec in
https://github.com/containerd/overlaybd.git. It would be fine to include
a comment in block/overlaybd.c with the spec URLs.

If it helps we could have a call with Kevin Wolf in about 2 weeks to
discuss any topics you have in more depth.

Stefan

--Bv0ijUMCo66Z7aHQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqXQhIACgkQnKSrs4Gr
c8i/Vwf/Yb4qRT8NvKEzs39vS+YfCwvbsjaz2YJqLLKNjKHUSewHub6pW3Gla8ju
JA+YRk37laCG2o8QdB+Aaa/yPh6YxOm50F9PSntWGSLTCOgk2jwrIN6QYkFOStHb
gcmh2246v98Yc8ov/8XUvCWiuV4Aws3CegODew4/RcrUs7i66SGiAIzZpHnJc1Ma
D5a0kuaXG/J+emlI0PIHv8EB/z5JTj09BL3Sasr7zUXagIRVh9ojXsk5tYWvk4U1
xIxtB1/8uYimqBzjuGaK4du14okKxt0T78Nql5K4l3kZXGSvMhVTFvVMPAbxsjuP
+LrxOj/ed5cQfRwtYNfeAUvWYJNSSg==
=LBhv
-----END PGP SIGNATURE-----

--Bv0ijUMCo66Z7aHQ--


