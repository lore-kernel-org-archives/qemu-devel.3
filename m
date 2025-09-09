Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9064CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 19:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw4B4-0001pF-4J; Tue, 09 Sep 2025 15:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uw4B1-0001oz-Na
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 15:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uw4Au-0006yV-EV
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 15:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757446718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8yBqKPCxQfoPcWIrKv1Jj0dLJT8ZsdU0TqHR6yEwlT4=;
 b=DLtBRE0Jreh0f4nya12CYaFtMUy7yw9ZNnRpeGCWwCw96w/adwbAzFGrND3J6vdDWEuOIw
 Z+IbJ+2yScinC1K/X/B355vyE2yWzADzUsImg8H3peiiJk1QyZdHPg7Hv/2HIJg0hN08dP
 6OiGh1JfsDBVAmuFqXCoulG7uorvV1Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-mAF5nfCAPomBvVsAjZl39w-1; Tue,
 09 Sep 2025 15:38:35 -0400
X-MC-Unique: mAF5nfCAPomBvVsAjZl39w-1
X-Mimecast-MFC-AGG-ID: mAF5nfCAPomBvVsAjZl39w_1757446714
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8EDB19560BA; Tue,  9 Sep 2025 19:38:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.59])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1E18300018D; Tue,  9 Sep 2025 19:38:32 +0000 (UTC)
Date: Tue, 9 Sep 2025 15:38:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH 4/4] iotests: add tests for FUSE-over-io_uring
Message-ID: <20250909193830.GF218449@fedora>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-5-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4jjRJnp4UzcTmE2x"
Content-Disposition: inline
In-Reply-To: <20250830025025.3610-5-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


--4jjRJnp4UzcTmE2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 10:50:25PM -0400, Brian Song wrote:
> To test FUSE-over-io_uring, set the environment variable
> FUSE_OVER_IO_URING=3D1. This applies only when using the
> 'fuse' protocol.
>=20
> $ FUSE_OVER_IO_URING=3D1 ./check -fuse
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>
> ---
>  tests/qemu-iotests/check     |  2 ++
>  tests/qemu-iotests/common.rc | 45 +++++++++++++++++++++++++++---------
>  2 files changed, 36 insertions(+), 11 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 545f9ec7bd..c6fa0f9e3d 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -94,6 +94,8 @@ def make_argparser() -> argparse.ArgumentParser:
>          mg.add_argument('-' + fmt, dest=3D'imgfmt', action=3D'store_cons=
t',
>                          const=3Dfmt, help=3Df'test {fmt}')
> =20
> +    # To test FUSE-over-io_uring, set the environment variable
> +    # FUSE_OVER_IO_URING=3D1. This applies only when using the 'fuse' pr=
otocol
>      protocol_list =3D ['file', 'rbd', 'nbd', 'ssh', 'nfs', 'fuse']
>      g_prt =3D p.add_argument_group(
>          '  image protocol options',
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index e977cb4eb6..f8b79c3810 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -539,17 +539,38 @@ _make_test_img()
>          touch "$export_mp"
>          rm -f "$SOCK_DIR/fuse-output"
> =20
> -        # Usually, users would export formatted nodes.  But we present f=
use as a
> -        # protocol-level driver here, so we have to leave the format to =
the
> -        # client.
> -        # Switch off allow-other, because in general we do not need it f=
or
> -        # iotests.  The default allow-other=3Dauto has the downside of p=
rinting a
> -        # fusermount error on its first attempt if allow_other is not
> -        # permissible, which we would need to filter.

This comment applies to both branches of the if statement. I think
keeping it here is slightly better.

> -        QSD_NEED_PID=3Dy $QSD \
> -              --blockdev file,node-name=3Dexport-node,filename=3D$img_na=
me,discard=3Dunmap \
> -              --export fuse,id=3Dfuse-export,node-name=3Dexport-node,mou=
ntpoint=3D"$export_mp",writable=3Don,growable=3Don,allow-other=3Doff \
> -              &
> +        if [ -n "$FUSE_OVER_IO_URING" ]; then
> +            nr_cpu=3D$(nproc 2>/dev/null || echo 1)
> +            nr_iothreads=3D$((nr_cpu / 2))
> +            if [ $nr_iothreads -lt 1 ]; then
> +                nr_iothreads=3D1
> +            fi

Please add a comment explaining that the purpose of this configuration
based on the number of CPUs is to test multiple IOThreads when the host
allows it, since that is a more interesting case then just 1 IOThread.
Many other configurations are possible as well, but not all of them can
be tested because the test matrix would be large.

> +
> +            iothread_args=3D""
> +            iothread_export_args=3D""
> +            for ((i=3D0; i<$nr_iothreads; i++)); do
> +                iothread_args=3D"$iothread_args --object iothread,id=3Di=
othread$i"
> +                iothread_export_args=3D"$iothread_export_args,iothread.$=
i=3Diothread$i"
> +            done
> +
> +            QSD_NEED_PID=3Dy $QSD \
> +                    $iothread_args \
> +                    --blockdev file,node-name=3Dexport-node,filename=3D$=
img_name,discard=3Dunmap \
> +                    --export fuse,id=3Dfuse-export,node-name=3Dexport-no=
de,mountpoint=3D"$export_mp",writable=3Don,growable=3Don,allow-other=3Doff,=
io-uring=3Don$iothread_export_args \
> +                &
> +        else
> +            # Usually, users would export formatted nodes.  But we prese=
nt fuse as a
> +            # protocol-level driver here, so we have to leave the format=
 to the
> +            # client.
> +            # Switch off allow-other, because in general we do not need =
it for
> +            # iotests.  The default allow-other=3Dauto has the downside =
of printing a
> +            # fusermount error on its first attempt if allow_other is not
> +            # permissible, which we would need to filter.
> +            QSD_NEED_PID=3Dy $QSD \
> +                --blockdev file,node-name=3Dexport-node,filename=3D$img_=
name,discard=3Dunmap \
> +                --export fuse,id=3Dfuse-export,node-name=3Dexport-node,m=
ountpoint=3D"$export_mp",writable=3Don,growable=3Don,allow-other=3Doff \
> +                &
> +        fi
> =20
>          pidfile=3D"$QEMU_TEST_DIR/qemu-storage-daemon.pid"
> =20
> @@ -592,6 +613,8 @@ _rm_test_img()
> =20
>          kill "${FUSE_PIDS[index]}"
> =20
> +        sleep 1
> +

What is the purpose of this sleep command?

>          # Wait until the mount is gone
>          timeout=3D10 # *0.5 s
>          while true; do
> --=20
> 2.45.2
>=20

--4jjRJnp4UzcTmE2x
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjAgjUACgkQnKSrs4Gr
c8itMggApzAV72Akk2b1vaXB0PBExmUjecVkvdujLHbaJzX/VT0EIa4a/B+hcZ8P
VpCZTrN3vaf8c4MPTF14LuKHSxxi4fMdLWP2Ju+SWlvkBJVlgGOg5XitBTGu+F12
wyzWPFWbnVAnIHTKNttrA50za1VlwaIN0o6OVxJWxmDw91z1GZmR9aa4qgk8NIRP
s2R+5SngeQxCsMwVPVlKbUnGcN8nI3/VOi8sk8b4qThE27XYYFOv4kVHmjpOjxfS
UsO/2McLxzj2TMg+PMQ+zk2nzv4+S967aWfmpY2WZPVqdMn0QC6Iu+OvI6q1OTnD
XCCGpcbsZxMz1E1U9pAlnGMQoRaTUA==
=wVrC
-----END PGP SIGNATURE-----

--4jjRJnp4UzcTmE2x--


