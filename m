Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13B3C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEZCM-0004JC-VW; Mon, 12 May 2025 15:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEZCL-0004If-Pv
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEZCJ-0004aD-52
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747079541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uDmejlCcQUDGcNOfwvOiW+2xZsslu2yfdr7goRWj8J8=;
 b=UxM3dA0Q1I8j/oD0Yg2ColPS/AOf3SmnaLUH4whwJa1k1/vDB744QkCvSN+0k/o3C1upag
 DjFBRgBQ7qlnaX1sD0LIc65KCubivBvnFV06eHd1WMeMuycVHxT+VDZMLFYcBsHQNkv5jZ
 HySXNbpds/DeRBgQoNu6Y08bw5sRt3c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-TkrMVBEENPy9WQg4k-7nQQ-1; Mon,
 12 May 2025 15:52:17 -0400
X-MC-Unique: TkrMVBEENPy9WQg4k-7nQQ-1
X-Mimecast-MFC-AGG-ID: TkrMVBEENPy9WQg4k-7nQQ_1747079536
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 133B91800368; Mon, 12 May 2025 19:52:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.161])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C90C51801390; Mon, 12 May 2025 19:52:13 +0000 (UTC)
Date: Mon, 12 May 2025 15:52:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Xie Yongji <xieyongji@bytedance.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Raphael Norwitz <raphael@enfabrica.net>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [RFC v2 4/4] vduse-blk: Add VIRTIO_BLK_T_OUT_FUA command support
Message-ID: <20250512195212.GN141177@fedora>
References: <20250508162044.857655-1-afaria@redhat.com>
 <20250508162044.857655-5-afaria@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jBHkX2v6NAogvEgO"
Content-Disposition: inline
In-Reply-To: <20250508162044.857655-5-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--jBHkX2v6NAogvEgO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 05:20:44PM +0100, Alberto Faria wrote:

If you respin, please add something to the commit description explaining
that an earlier commit already updated
block/export/virtio-blk-handler.c:virtio_blk_process_req() to handle FUA
requests.

> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  block/export/vduse-blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/export/vduse-blk.c b/block/export/vduse-blk.c
> index bd852e538dc..36c3c0a56e6 100644
> --- a/block/export/vduse-blk.c
> +++ b/block/export/vduse-blk.c
> @@ -329,7 +329,8 @@ static int vduse_blk_exp_create(BlockExport *exp, Blo=
ckExportOptions *opts,
>                 (1ULL << VIRTIO_BLK_F_BLK_SIZE) |
>                 (1ULL << VIRTIO_BLK_F_FLUSH) |
>                 (1ULL << VIRTIO_BLK_F_DISCARD) |
> -               (1ULL << VIRTIO_BLK_F_WRITE_ZEROES);
> +               (1ULL << VIRTIO_BLK_F_WRITE_ZEROES) |
> +               (1ULL << VIRTIO_BLK_F_OUT_FUA);
> =20
>      if (num_queues > 1) {
>          features |=3D 1ULL << VIRTIO_BLK_F_MQ;
> --=20
> 2.49.0
>=20

--jBHkX2v6NAogvEgO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgiUWwACgkQnKSrs4Gr
c8j5EAgArdeMzJ/LZAFC53aJIDBgD01RqcH1nRwhUDiQuCzhbMOYuBYW8pzipn2j
PG8Z2rTy8Jd6777ALnz5S4BotBpIy0ADGX1mj5WaiN72oyLQVVN24/LvgJ1+4xpW
NuZJad32IIZNnPmwpcS6STBnJ6g0AwogHRt7jaAo8xNSXGRa2R9Xg45sLXXQwTN7
uMqJ6nEq3+l4e7CKZwkMGLizOfLc08SeJfya21JBV7Op4mgaRvTuzCjLjJdtz0eo
rp9t88mFxuBtjsHipKwUn5VdLhSSxCv1iq1dnTrEbmO4/R6/3Avo3W2tjImd2MsT
vyv+IOdJLgJfALNs3GspWY8g/EeROg==
=Awq+
-----END PGP SIGNATURE-----

--jBHkX2v6NAogvEgO--


