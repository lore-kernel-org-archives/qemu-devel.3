Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30DBC87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 12:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udpnp-0005gw-2P; Mon, 21 Jul 2025 08:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udpnj-0005E1-VE
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 08:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udpng-0004FN-A6
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 08:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753101563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zAB20DBaGxbXTmz/aKytmtD2+yIyNSGFc2uCLnWbDpE=;
 b=HpKH8IcvcbbzeMb20n+WRYwys5OzVTBiqeH1TvuOd1FYq16AaM6PTtKFaWwFn9hgrwM4rT
 tgM8LNnq60IPbkjoqanj9jXP3/Z5rOgUdaKRkkw8nPkhS2qCwo/6XR1OCjlAoKGBpJ+nSE
 d9c3Xflvj9T5ya66+C3y44ShB7FpH+w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-7t5rM-F9MjezYkU9O0G7wg-1; Mon,
 21 Jul 2025 08:39:19 -0400
X-MC-Unique: 7t5rM-F9MjezYkU9O0G7wg-1
X-Mimecast-MFC-AGG-ID: 7t5rM-F9MjezYkU9O0G7wg_1753101558
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 639FC195FD2B; Mon, 21 Jul 2025 12:39:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E68719560A3; Mon, 21 Jul 2025 12:39:17 +0000 (UTC)
Date: Sun, 20 Jul 2025 12:13:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bschubert@ddn.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH RFC 0/1] block/export: FUSE-over-io_uring Support for
 QEMU FUSE Exports
Message-ID: <20250720161351.GA32887@fedora>
References: <20250716183824.216257-1-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SezE4twLgtxkGkmM"
Content-Disposition: inline
In-Reply-To: <20250716183824.216257-1-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.926, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--SezE4twLgtxkGkmM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 02:38:23PM -0400, Brian Song wrote:
> This RFC patch represents an initial implementation of the FUSE-over-=20
> io_uring Exports idea proposed for Google Summer of Code (2025) under=20
> the QEMU community:
> https://wiki.qemu.org/Google_Summer_of_Code_2025#FUSE-over-io_uring_expor=
ts
>=20
> The implementation approach is primarily borrowed from how libfuse=20
> interacts with the kernel.
>=20
> FUSE-over-io_uring (https://docs.kernel.org/next/filesystems/fuse-io-=20
> uring.html) has been officially merged into the Linux kernel. The idea=20
> is to replace the traditional /dev/fuse based communication with a more=
=20
> efficient io_uring-based approach. In this model, userspace registers=20
> io_uring SQEs via the FUSE_IO_URING_CMD_REGISTER opcode, and then waits=
=20
> for the kernel to forward FUSE requests as CQEs. These are processed by=
=20
> the FUSE exports implementation in userspace and then committed back to=
=20
> the kernel using FUSE_IO_URING_CMD_COMMIT_AND_FETCH.
>=20
> To enable this feature in qemu-export-daemon, simply add the uring=3Don=
=20
> option to the export configuration.

For consistency with the --blockdev file,aio=3Dio_uring option, please
name it "io_uring=3Don" instead of "uring=3Don".

>=20
> As this patch is still in the RFC stage, it currently supports **only=20
> single thread**. Due to protocol requirements in FUSE-over-io_uring,
> the number of FUSE threads must match the number of CPUs. Therefore,
> this initial version only works on single-core VMs (i.e., QEMU started
> with -smp 1) or single core machine.
>=20
> Brian Song (1):
>   block/export: FUSE-over-io_uring Support for QEMU FUSE Exports
>=20
>  block/export/fuse.c                  | 423 +++++++++++++++++++++++++--
>  docs/tools/qemu-storage-daemon.rst   |  10 +-
>  qapi/block-export.json               |   6 +-
>  storage-daemon/qemu-storage-daemon.c |   1 +
>  util/fdmon-io_uring.c                |   5 +-
>  5 files changed, 420 insertions(+), 25 deletions(-)
>=20
> --=20
> 2.50.1
>=20

--SezE4twLgtxkGkmM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh9Fb4ACgkQnKSrs4Gr
c8ioUAf+NdtbezyiQ6w0MzegtZyDJ5LSzEQQ/wRwIKqDs+Z1UR4p/Hp6m/NxAiLz
PYvMyYEIgeir49wHVxcOYj677Rj2wl8BVX9E9553AfZhajDDu7uDIo+s4Ci0YIWk
qYcZcTYHtOzlE3rTSY/IEmjgtgv0ebRhpPOHYevvSVxG0Ao0jviHGLT8jB+50Ob1
sGzNXd7bNhyjKk4KIgkrfMvgCIy5oSge6Ko1Ehr1MY1PvMVP9JcYZentt1Lvf4Rx
3wwE6SCFf3iDpai3YQEMv/qAyfoeUvGZEvt0kp+MuN7vzuUAxRwPYkJma1409teh
DMJVN93QVo4DgJRCeEZ4a66SeVdIIQ==
=MVNo
-----END PGP SIGNATURE-----

--SezE4twLgtxkGkmM--


