Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6F4C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twizj-0006gK-Tp; Mon, 24 Mar 2025 10:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twizh-0006fa-Hf
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twizf-0002jQ-AE
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742827293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=372Y/nlyiXulFaN9P6j/PsVFmFNsHrTyxRUnaK0U/v8=;
 b=HTIMfJOxAYjLNEbKvzVdmEX0WcGSNZeTWruoJgudFN96CqvQQhBLwjRTPW3A+y8Zcgu6UY
 44LpDCQVHtFVRaygQTSefnKpI59JV3gQVjEAPrxlcTA8xs8ZLrrhu2TbwqzY/ZAuGez/Ks
 NYHv0pEgK5r08U1ewiX2I3gvyE15xEk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-ymiLp6X6OZOl5dghuAYrfg-1; Mon,
 24 Mar 2025 10:41:29 -0400
X-MC-Unique: ymiLp6X6OZOl5dghuAYrfg-1
X-Mimecast-MFC-AGG-ID: ymiLp6X6OZOl5dghuAYrfg_1742827288
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83E7F196D2DE; Mon, 24 Mar 2025 14:41:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0A8019541A5; Mon, 24 Mar 2025 14:41:27 +0000 (UTC)
Date: Mon, 24 Mar 2025 10:41:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: saz97 <sa.z@qq.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org
Subject: Re: [PATCH 0/1 RFC] FUSE Export Coroutine Integration Cover Letter
Message-ID: <20250324144126.GA64982@fedora>
References: <tencent_4E3504A0739AEE8199766C5415093D24CE05@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hBKmaGxpfIv8LLA7"
Content-Disposition: inline
In-Reply-To: <tencent_4E3504A0739AEE8199766C5415093D24CE05@qq.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--hBKmaGxpfIv8LLA7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 04:05:09PM +0800, saz97 wrote:
> This patch series refactors QEMU's FUSE export module to leverage corouti=
nes for read/write operations,
> addressing concurrency limitations and aligning with QEMU's asynchronous =
I/O model. The changes
> demonstrate measurable performance improvements while simplifying resourc=
e management.
>=20
> 1. technology implementation
>=20
>    according to Stefan suggerstion, i move the processing logic of read_f=
rom_fuse_export into a coroutine for buffer management.
>    and change the fuse_getattr to call: bdrv_co_get_allocated_file_size()=
=2E   =20
>=20
> 2. performance summary
>=20
>    For the coroutine_integration_fuse test, the average results for iodep=
th=3D1 and iodepth=3D64 are as follows:
>     ------------------------------- =20
>     Average results for iodepth=3D1:
>     Read_IOPS: coroutine_integration_fuse: 4492.88 | origin: 4309.39 | 4.=
25% improvement
>     Write_IOPS: coroutine_integration_fuse: 4500.68 | origin: 4318.68 | 4=
=2E21% improvement
>     Read_BW: coroutine_integration_fuse: 17971.00 KB/s | origin: 17237.30=
 KB/s | 4.26% improvement
>     Write_BW: coroutine_integration_fuse: 18002.50 KB/s | origin: 17274.3=
0 KB/s | 4.23% improvement
>     --------------------------------
>     -------------------------------
>     Average results for iodepth=3D64:
>     Read_IOPS: coroutine_integration_fuse: 5576.93 | origin: 5347.13 | 4.=
29% improvement
>     Write_IOPS: coroutine_integration_fuse: 5569.55 | origin: 5337.33 | 4=
=2E33% improvement
>     Read_BW: coroutine_integration_fuse: 22311.40 KB/s | origin: 21392.20=
 KB/s | 4.31% improvement
>     Write_BW: coroutine_integration_fuse: 22282.20 KB/s | origin: 21353.2=
0 KB/s | 4.34% improvement
>     --------------------------------
>    Although all metrics show improvements, the gains are concentrated in =
the 4.2%=E2=80=934.3% range, which is lower than expected. Further investig=
ation using gprof reveals the reasons for this limited improvement.
>=20
> 3. Performance Bottlenecks Identified via gprof
>    After running a fio test with the following command:
>    fio --ioengine=3Dio_uring --numjobs=3D1 --runtime=3D30 --ramp_time=3D5=
 \
>     --rw=3Drandrw --bs=3D4k --time_based=3D1 --name=3Djob1 \
>     --filename=3D/mnt/qemu-fuse --iopath=3D64
>    and analyzing the execution profile using gprof, the following issues =
were identified:
>=20
>    3.1 Increased Overall Execution Time
>    In the original implementation, fuse_write + blk_pwrite accounted for =
8.7% of total execution time (6.0% + 2.7%).
>    After refactoring, fuse_write_coroutine + blk_co_pwrite now accounts f=
or 43.1% (22.9% + 20.2%).
>    This suggests that coroutine overhead is contributing significantly to=
 execution time.
>=20
>    3.2 Increased Read and Write Calls
>    fuse_write calls increased from 173,400 =E2=86=92 333,232.
>    fuse_read calls increased from 173,526 =E2=86=92 332,931.
>    This indicates that the coroutine-based approach is introducing redund=
ant I/O calls, likely due to unnecessary coroutine switches.
>=20
>    3.3 Significant Coroutine Overhead
>    qemu_coroutine_enter is now called 1,572,803 times, compared to ~476,0=
57 previously.
>    This frequent coroutine switching introduces unnecessary overhead, lim=
iting the expected performance improvements.

Due to the remaining performance issues, let's leave this contribution
task here.

Please focus on submitting your Google Summer of Code application at
https://summerofcode.withgoogle.com/ by April 8th.

Thanks,
Stefan

>=20
> saz97 (1):
>   Integration coroutines into fuse export
>=20
>  block/export/fuse.c | 190 +++++++++++++++++++++++++++++---------------
>  1 file changed, 126 insertions(+), 64 deletions(-)
>=20
> --=20
> 2.34.1
>=20

--hBKmaGxpfIv8LLA7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfhbxYACgkQnKSrs4Gr
c8ifIQgAiFzTH8709F6HFz3TMcsBG7F2HKJB+5OxxkFW6V4ZfQc30LGLTCkenTfq
NQObEa5C1tTEThhbhCJuo6LMHITetjbgJ3Gg4mVKfSEwMFmDr59wMEZljHOeqCzq
NGRcV4R1jRgtPYimmGFzUzPyplOkxo39zBMeD0mv6JCKvEE2TdUGrzS4DlM+zsd3
LSdz23aaFDZnup0XBsC03pryIJNS4Q9NhcEhtpw9MfQ5uI1dQ40sDfSyKKKYZo3k
zl5X2MDv92gBhSIZaSbuEiZx9hOmiax3ApSpTwMegiccSQ6fNiHtnewDRHnQrbUY
I5j/IKpwdjf4LHUO8tc213XgghELRA==
=yQll
-----END PGP SIGNATURE-----

--hBKmaGxpfIv8LLA7--


