Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6FFC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6cO-0005gM-Mk; Tue, 25 Mar 2025 11:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tx6cK-0005cc-4r
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tx6cH-0005lM-Ef
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pFNvwWTwjfiMfrT0u5aGt03lDB5lH20SuFriwYmQ2aQ=;
 b=TYAJbzyWgI53PMscWx9w8l8ZUwxi+0caK9jQQnRraTPPQ7krZrc6rtz+oREBQyNUJXdl8p
 rtnGZ8/WKRUTWa2u/YMw2uROg+kMaQwbycWGpEgI8B4xqi3Sbe2tQjsO+Pv5CFmNxrgrfd
 4VN6++a/W+sSzvx8jEOJt2eDnin5dvo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-BXofkwqiMx28KDyM1WnKeA-1; Tue,
 25 Mar 2025 11:54:54 -0400
X-MC-Unique: BXofkwqiMx28KDyM1WnKeA-1
X-Mimecast-MFC-AGG-ID: BXofkwqiMx28KDyM1WnKeA_1742918093
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E4D01800267; Tue, 25 Mar 2025 15:54:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.160])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 265BD30001A1; Tue, 25 Mar 2025 15:54:49 +0000 (UTC)
Date: Tue, 25 Mar 2025 11:54:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Faria <afaria@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] scsi-disk: Add native FUA support
Message-ID: <20250325155448.GA137279@fedora>
References: <20250304155232.1325581-1-afaria@redhat.com>
 <20250304155232.1325581-3-afaria@redhat.com>
 <Z8l56U16vyT7cnvi@redhat.com> <Z-KmIyWX8hxRNe2u@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FACcvvGWLfQZGLck"
Content-Disposition: inline
In-Reply-To: <Z-KmIyWX8hxRNe2u@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--FACcvvGWLfQZGLck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 01:48:35PM +0100, Kevin Wolf wrote:
> Am 06.03.2025 um 11:33 hat Kevin Wolf geschrieben:
> > Am 04.03.2025 um 16:52 hat Alberto Faria geschrieben:
> > > Avoid emulating FUA when the driver supports it natively. This should
> > > provide better performance than a full flush after the write.
> > >=20
> > > Signed-off-by: Alberto Faria <afaria@redhat.com>
> >=20
> > Did you try out if you can see performance improvements in practice?
> > It's always nice to have numbers in the commit message for patches that
> > promise performance improvements.
>=20
> I was curious enough to see how this and the recent series by Stefan
> (virtio-scsi multiqueue) and myself (FUA on the backend + polling
> improvements) play out with virtio-scsi, so I just ran some fio
> benchmarks with sync=3D1 myself to compare:
>=20
> iops bs=3D4k cache=3Dnone           |    virtio-scsi    |     virtio-blk =
   |
> O_SYNC workload                 |   qd 1  |  qd 16  |   qd 1  |  qd 16  |
> --------------------------------+---------+---------+---------+---------+
> master                          |   21296 |  109747 |   25762 |  130576 |
> + virtio-scsi multiqueue        |   28798 |  121170 |       - |       - |
> + FUA in scsi-disk              |   51893 |  204199 |       - |       - |
> --------------------------------+---------+---------+---------+---------+
> Total change                    | +143.7% |  +86.1% |       - |       - |
>=20
> (No new numbers for virtio-blk because virtio-scsi patches obviously
> don't change anything about it. Also no numbers for FUA in file-posix
> because it's unused with cache=3Dnone.)
>=20
> iops bs=3D4k cache=3Ddirectsync     |    virtio-scsi    |     virtio-blk =
   |
> O_SYNC workload                 |   qd 1  |  qd 16  |   qd 1  |  qd 16  |
> --------------------------------+---------+---------+---------+---------+
> master                          |   32223 |  109748 |   45583 |  258416 |
> + FUA in file-posix + polling   |   32148 |  198665 |   58601 |  320190 |
> + virtio-scsi multiqueue        |   51739 |  225031 |       - |       - |
> + FUA in scsi-disk              |   56061 |  227535 |       - |       - |
> --------------------------------+---------+---------+---------+---------+
> Total change                    |  +74.0% | +107.3% |  +28.6% |  +23.9% |
>=20
> Of course, the huge improvements on the virtio-scsi side only show how
> bad it was before. In most numbers it is still behind virtio-blk even
> after all three patch series (apart from cache=3Dnone where the
> availability of FUA on the device side makes a big difference, and I
> expect that virtio-blk will improve similarly once we implement it
> there).
>=20
> Also note that when testing the virtio-scsi multiqueue patches, this
> was still a single iothread, i.e. I wasn't even making use of the new
> feature per se. I assume much of this comes from enabling polling
> because the series moved the event queue handling to the main loop,
> which prevented polling for virtio-scsi before. The series also got rid
> of an extra coroutine per request for the blk_is_available() call in
> virtio_scsi_ctx_check(), which might play a role, too.
>=20
> Anyway, I like these numbers for FUA in scsi-disk. It makes write back
> cache modes almost catch up to write through with O_SYNC workloads. We
> should definitely get this merged and do the same for virtio-blk.

Thanks for sharing! Nice IOPS improvements across the board.

Stefan

--FACcvvGWLfQZGLck
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfi0ccACgkQnKSrs4Gr
c8hMZwf6AuUWz2XyIzWh+iYY6PHY7ewC/B/vwgxR/SFjPAD8kSNO4IUU2wrlVBxf
O4uO4nFt+XoskAsj5bW4j+3OZi127IF+stZnztjI6YXVgw8ecfIL3wpIgHUAQRw0
m6LCECuHztcueJo8CWtIR7FilnbG5Mcx25GvQE4/0WxQV8KnNN9Py/gtqR7ZViwz
HQ0eskZYM/441LBFlu/5JkyyEyH79qD5z0COcLDyo3i+yHeDm89mqfFnH81mgRMb
ssdlyQGu/4Kdml1YZ1Az4I4auOEVBrRt0Woc6gHrqz7U2SXORxR+7XxYUnb72zz6
LHgsboQXn9GqYiVG2HNmUbOHl1B+Aw==
=PXYA
-----END PGP SIGNATURE-----

--FACcvvGWLfQZGLck--


