Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2C7C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 09:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvoj-0005kg-0r; Tue, 11 Mar 2025 05:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trvof-0005jl-On
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trvoV-0006Am-Fl
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741684933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eO3oNrxfuji4hL2Qmea6MvBcmdG9B0CZMpfCSm+oUaA=;
 b=czuX5HPiBQA11r/1xQchPBmR6JWYRBsiCifPqnfRlkb9pLWDaVzbVavqfuXVON7Txk0mLH
 5JpZ3U+oP0nt71Bnjz428XyYAy1sNygfB4wAP2VxJC3pOh63vLytksxxOz+xicPa+m2S8b
 qiQW2uKRXzsSYkGlklqk0LJiCTAqVSc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-_Sj5Ng9yPpu-V8dkt0npAA-1; Tue,
 11 Mar 2025 05:22:09 -0400
X-MC-Unique: _Sj5Ng9yPpu-V8dkt0npAA-1
X-Mimecast-MFC-AGG-ID: _Sj5Ng9yPpu-V8dkt0npAA_1741684928
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D61D619560AD; Tue, 11 Mar 2025 09:22:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.75])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C9501800373; Tue, 11 Mar 2025 09:22:04 +0000 (UTC)
Date: Tue, 11 Mar 2025 17:22:02 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, pkrempa@redhat.com,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 00/12] virtio-scsi: add iothread-vq-mapping parameter
Message-ID: <20250311092202.GB939747@fedora>
References: <20250213180043.713434-1-stefanha@redhat.com>
 <Z876rXYchAvup5_6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mFuRxwpGn849Irk+"
Content-Disposition: inline
In-Reply-To: <Z876rXYchAvup5_6@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--mFuRxwpGn849Irk+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 03:43:57PM +0100, Kevin Wolf wrote:
> Am 13.02.2025 um 19:00 hat Stefan Hajnoczi geschrieben:
> > Implement --device virtio-scsi-pci,iothread-vq-mapping=3D support so th=
at
> > virtqueues can be assigned to different IOThreads. This improves SMP gu=
est
> > scalability where I/O-intensive applications can become bottlenecked on=
 a
> > single IOThread.
> >=20
> > The following benchmark results show the effect of iothread-vq-mapping.=
 fio
> > randread 4k iodepth=3D64 results from a 4 vCPU guest with an Intel P480=
0X SSD:
> > iothreads IOPS
> > ------------------------------
> > 1         189576
> > 2         312698
> > 4         346744
> >=20
> > The virtio-scsi device model and core SCSI emulation currently assume t=
hat
> > requests are processed in a single AioContext. This patch series goes a=
bout
> > modifying this as follows:
> >=20
> > scsi-disk: drop unused SCSIDiskState->bh field
> > dma: use current AioContext for dma_blk_io()
> >=20
> > Make dma-helpers.c support the QEMU multi-queue block layer by using
> > qemu_get_current_aio_context().
> >=20
> > scsi: track per-SCSIRequest AioContext
> > scsi: introduce requests_lock
> >=20
> > Make the core SCSI emulation code support processing requests in multip=
le
> > AioContexts by protecting the per-SCSIDevice requests list.
> >=20
> > virtio-scsi: introduce event and ctrl virtqueue locks
> > virtio-scsi: protect events_dropped field
> > virtio-scsi: perform TMFs in appropriate AioContexts
> >=20
> > Make the virtio-scsi emulation code support processing requests in mult=
iple
> > AioContexts. The event and ctrl virtqueues can interact with multiple
> > AioContexts. Especially the SCSI Task Management Functions (TMFs) handl=
ed by
> > the ctrl virtqueue need to be made thread-safe.
> >=20
> > virtio-blk: extract cleanup_iothread_vq_mapping() function
> > virtio-blk: tidy up iothread_vq_mapping functions
> > virtio: extract iothread-vq-mapping.h API
> > virtio-scsi: add iothread-vq-mapping parameter
> >=20
> > Port over the iothread-vq-mapping qdev property from virtio-blk to virt=
io-scsi.
> >=20
> > virtio-scsi: handle ctrl virtqueue in main loop
> >=20
> > Simplify TMF handling now that there is no longer a single AioContext w=
here all
> > requests are processed.
> >=20
> > Stefan Hajnoczi (12):
> >   scsi-disk: drop unused SCSIDiskState->bh field
> >   dma: use current AioContext for dma_blk_io()
> >   scsi: track per-SCSIRequest AioContext
> >   scsi: introduce requests_lock
> >   virtio-scsi: introduce event and ctrl virtqueue locks
> >   virtio-scsi: protect events_dropped field
> >   virtio-scsi: perform TMFs in appropriate AioContexts
> >   virtio-blk: extract cleanup_iothread_vq_mapping() function
> >   virtio-blk: tidy up iothread_vq_mapping functions
> >   virtio: extract iothread-vq-mapping.h API
> >   virtio-scsi: add iothread-vq-mapping parameter
> >   virtio-scsi: handle ctrl virtqueue in main loop
>=20
> Patches 1-10: Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Thank you. I'm preparing another revision that applies a fixed mapping
to the ctrl and event vqs and only exposes the command vqs through the
iothread-vq-mapping property.

Stefan

--mFuRxwpGn849Irk+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfQALoACgkQnKSrs4Gr
c8j5qwf/Qa/MNOGoLmsfQV8l6122UHWIo3RkaGFBT8rKhwW3qHzN90G8qOG24dLY
1B23HsoAwgVPXeK3fxtOdXZY42VAyTF0cB3dF4zNXfhKRizgctN7Wo+6zVrOQsQF
7GBZkqTOCxRPKCFjjdbytURQUwJL/gzVf6MTZkvj6jtM6v5siUVnNr4dyOLIZuJa
q7+R9TwBgHtZexX2JXMNAt+r+891B3UJujlVknib3UXahB3mNiSoNS+AR6PWrIbl
MbFvGtplSms7aIxsWXLWsDtfe+nPqyo+PzXEiL+rt7nwSmW3BL/eMwMU1APjYXi4
R0WKNSnPbFerUFmqIWsWq2xZiC5Q3Q==
=lKKT
-----END PGP SIGNATURE-----

--mFuRxwpGn849Irk+--


