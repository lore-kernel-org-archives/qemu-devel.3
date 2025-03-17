Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40334C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 20:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuHW7-0001F9-6B; Mon, 17 Mar 2025 16:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tuHW5-0001EQ-Bj
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tuHW3-0001VL-8e
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742245013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mAXaF/B+yEL20OEDYR7ujt6zDeyDYLil+/6J4BvH8Gc=;
 b=Fb5vpfHhTFd/ptqOLznHTdS4mWX4Pa1vn/sGWoJ5gZFpQEVjIMybmrpzy5OgAkHlLsa95Z
 +J+lf9daz5+IQqsoPP88dCVvwL3Nx///08ETPalqQz2HkYrl7nFlTg22JjKAx4REuDyqRh
 Rgm3kBeEcLjKIX6ibbycPpADmirvyTs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-K_0lkqF9PvmJ8MxJAZ4eTQ-1; Mon,
 17 Mar 2025 16:56:48 -0400
X-MC-Unique: K_0lkqF9PvmJ8MxJAZ4eTQ-1
X-Mimecast-MFC-AGG-ID: K_0lkqF9PvmJ8MxJAZ4eTQ_1742245007
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B8801955DC5; Mon, 17 Mar 2025 20:56:47 +0000 (UTC)
Received: from localhost (unknown [10.2.17.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2ADE01828A80; Mon, 17 Mar 2025 20:56:45 +0000 (UTC)
Date: Mon, 17 Mar 2025 16:56:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: saz97 <sa.z@qq.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org
Subject: Re: [PATCH 0/1 RFC] FUSE Export Coroutine Integration Cover Letter
Message-ID: <20250317205644.GE1214048@fedora>
References: <tencent_768F19A8DEA12BC51D868074DAD0E933DF0A@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VgHPRCzCjzwHF5kg"
Content-Disposition: inline
In-Reply-To: <tencent_768F19A8DEA12BC51D868074DAD0E933DF0A@qq.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--VgHPRCzCjzwHF5kg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 01:30:06AM +0800, saz97 wrote:
> Signed-off-by: Changzhi Xie <sa.z@qq.com>
>=20
> FUSE Export Coroutine Integration Cover Letter
>=20
> This patch series refactors QEMU's FUSE export module to leverage corouti=
nes for read/write operations,=20
> addressing concurrency limitations and aligning with QEMU's asynchronous =
I/O model. The changes=20
> demonstrate measurable performance improvements while simplifying resourc=
e management.
>=20
> 1. Technical Implementation
> Key modifications address prior review feedback (Stefan Hajnoczi) and opt=
imize execution flow:
>=20
> =E2=80=8B1.1 Coroutine Integration
> Convert fuse_read()/fuse_write() to launch coroutines (fuse_*_coroutine)
> Utilize non-blocking blk_co_pread()/blk_co_pwrite() for block layer access
> Eliminate main loop blocking during heavy I/O workloads
>=20
> 1.2 =E2=80=8BBuffer Management
> Removed explicit buffer pre-allocation in read_from_fuse_export()
> Replaced fuse_buf_free() with g_free() due to libfuse3 API constraints
>=20
> =E2=80=8B1.3 Resource Lifecycle
> Moved in_flight decrement and blk_exp_unref() into coroutines
> Added FUSE opcode checks (FUSE_READ/FUSE_WRITE) to prevent premature clea=
nup
>=20
> 1.4 =E2=80=8BStructural Improvements
> Simplified FuseIORequest structure:
> Removed redundant fuse_ino_t and fuse_file_info fields
> Retained minimal parameter passing requirements
>=20
> 2. Performance Validation
> Tested using fio with 4K random RW pattern, and the result is the average=
 of 5 runs:
> fio --ioengine=3Dio_uring --numjobs=3D1 --runtime=3D30 --ramp_time=3D5 --=
rw=3Drandrw --bs=3D4k --time_based=3D1
>=20
> Key Results
>=20
> Metric	       iodepth=3D1	           iodepth=3D64
> =E2=80=8BRead Latency	  =E2=96=BC 2.7% (3.8k=E2=86=923kns)	  =E2=96=BC 1.=
3% (4.7M=E2=86=924.6M ns)
> =E2=80=8BWrite Latency	=E2=96=BC 3.6% (112k=E2=86=92108kns)	=E2=96=BC 2.8=
% (5.2M=E2=86=925.0M ns)
> =E2=80=8BRead IOPS	    4740 =E2=86=92 4729 (=C2=B10.2%)	  =E2=96=B2 2.1% =
(6391=E2=86=926529)
> =E2=80=8BWrite IOPS	    4738 =E2=86=92 4727 (=C2=B10.2%)	  =E2=96=B2 2.2%=
 (6390=E2=86=926529)
> =E2=80=8BThroughput	    ~18.9 GB/s (stable)	  =E2=96=B2 2.1% (25.6=E2=86=
=9226.1 GB/s)

Are you sure throughput is GB/s instead of MB/s?

iodepth=3D1 read 4729 IOPS * bs=3D4k =3D 18 MB/s

Also, fio was configured with --rw=3Drandrw, so the total throughput
should be read throughput + write throughput. Based on the read and
write IOPS numbers, the total throughput should be ~36 MB/s. Which
throughput number are you showing?

>=20
> Analysis
>=20
> =E2=80=8BHigh Concurrency (iodepth=3D64):
> Sustained throughput gains (+2.1-2.2%) demonstrate improved scalability
> Latency reductions confirm reduced contention in concurrent operations

This is surprising. Before this patch series the FUSE export code only
submits 1 request at a time, so the iodepth=3D64 results should be only a
little better than the iodepth=3D1 results. After this patch series the
FUSE export code should be submitting all 64 requests concurrently and
improving performance by more than 2%.

Why was the improvement only 2%?

>=20
> saz97 (1):
>   Integration coroutines into fuse export
>=20
>  block/export/fuse.c | 189 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 132 insertions(+), 57 deletions(-)
>=20
> --=20
> 2.34.1
>=20

--VgHPRCzCjzwHF5kg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfYjIwACgkQnKSrs4Gr
c8hnAwf9HMfFhjvY1grxydun/2OS7WMSzKknpkiBwWJswPa79a+Oa64biQortcSp
oCGkDqE5uh3upZaXUNpy/svepg4E80k3Fc8k2/aXHVrY84y1vyKZEWPRqCJkmtPQ
eyFSraYmz81X6yH1EuJ+rBM0fngKQLDpb5KgAvUB46ttXzBeGu8EqjElx8pNnOTw
BQ6KdpG5HDUBKZLXB0aMC0qRyZSMhgStSeKBMwi3yBFcAFMTruInZOpgo8eSLrW4
85WVkduPsUlMF0blyjyGNjeZHBLkvUtLIvzhUMSUGkIns0NJbfy+1l2h2HKMkySP
6iRR/pMU61JV+xX+tKMlO3rler7JPw==
=vjvm
-----END PGP SIGNATURE-----

--VgHPRCzCjzwHF5kg--


