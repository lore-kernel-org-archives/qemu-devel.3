Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E17CA0EDC
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Aug 2025 13:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1undeN-0003Uw-Vc; Sun, 17 Aug 2025 09:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1undeL-0003UI-HP
 for qemu-devel@nongnu.org; Sun, 17 Aug 2025 09:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1undeI-0006Lg-EQ
 for qemu-devel@nongnu.org; Sun, 17 Aug 2025 09:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755438131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/CjYzTdOC4Ps5K0jcbZoXCj05B8TpdVppCSCXlgkTtM=;
 b=XmyOh09+ieDEur7okrYGGIerIWu0iT8chTh2VE9cbr5K1HHszx1IYqaFLOjBZ4D7lNAghZ
 8JEMcJuCs85KajyC3VOhRd30Vj6OK1rGgV0/CkcfqnD/oiSKcZQrFDsm42Ig+DD00QlrXu
 hGPkcnJmdSfOg2Op6G5k5hHYeJd9CmQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-8dxubFuhM-2oaEwx04fL8A-1; Sun,
 17 Aug 2025 09:42:07 -0400
X-MC-Unique: 8dxubFuhM-2oaEwx04fL8A-1
X-Mimecast-MFC-AGG-ID: 8dxubFuhM-2oaEwx04fL8A_1755438126
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 478501800446; Sun, 17 Aug 2025 13:42:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.33])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F12471800447; Sun, 17 Aug 2025 13:42:04 +0000 (UTC)
Date: Sun, 17 Aug 2025 09:42:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH 1/3] fuse: add FUSE-over-io_uring enable opt and init
Message-ID: <20250817134203.GA320731@fedora>
References: <20250815034619.51980-1-hizhisong@gmail.com>
 <20250815034619.51980-2-hizhisong@gmail.com>
 <beb43845-a761-4031-a7b7-aaca56abb6de@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1XEZCFtcz5bkNERX"
Content-Disposition: inline
In-Reply-To: <beb43845-a761-4031-a7b7-aaca56abb6de@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--1XEZCFtcz5bkNERX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 07:13:53PM -0400, Brian Song wrote:
>=20
>=20
> On 8/14/25 11:46 PM, Brian Song wrote:
> > From: Brian Song <hibriansong@gmail.com>
> >=20
> > This patch adds a new export option for storage-export-daemon to enable
> > or disable FUSE-over-io_uring via the switch io-uring=3Don|off (disable
> > by default). It also implements the protocol handshake with the Linux
> > kernel during the FUSE-over-io_uring initialization phase.
> >=20
> > See: https://docs.kernel.org/filesystems/fuse-io-uring.html
> >=20
> > The kernel documentation describes in detail how FUSE-over-io_uring
> > works. This patch implements the Initial SQE stage shown in thediagram:
> > it initializes one queue per IOThread, each currently supporting a
> > single submission queue entry (SQE). When the FUSE driver sends the
> > first FUSE request (FUSE_INIT), storage-export-daemon calls
> > fuse_uring_start() to complete initialization, ultimately submitting
> > the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
> > successful initialization with the kernel.
> >=20
> > Suggested-by: Kevin Wolf <kwolf@redhat.com>
> > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Brian Song <hibriansong@gmail.com>
> > ---
> >   block/export/fuse.c                  | 161 ++++++++++++++++++++++++---
> >   docs/tools/qemu-storage-daemon.rst   |  11 +-
> >   qapi/block-export.json               |   5 +-
> >   storage-daemon/qemu-storage-daemon.c |   1 +
> >   util/fdmon-io_uring.c                |   5 +-
> >   5 files changed, 159 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/block/export/fuse.c b/block/export/fuse.c
> > index c0ad4696ce..59fa79f486 100644
> > --- a/block/export/fuse.c
> > +++ b/block/export/fuse.c
> > @@ -48,6 +48,11 @@
> >   #include <linux/fs.h>
> >   #endif
> >=20
> > +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
> > +
> > +/* room needed in buffer to accommodate header */
> > +#define FUSE_BUFFER_HEADER_SIZE 0x1000
> > +
> >   /* Prevent overly long bounce buffer allocations */
> >   #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1=
024))
> >   /*
> > @@ -63,12 +68,31 @@
> >       (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
> >=20
> >   typedef struct FuseExport FuseExport;
> > +typedef struct FuseQueue FuseQueue;
> > +
> > +typedef struct FuseRingEnt {
> > +    /* back pointer */
> > +    FuseQueue *q;
> > +
> > +    /* commit id of a fuse request */
> > +    uint64_t req_commit_id;
> > +
> > +    /* fuse request header and payload */
> > +    struct fuse_uring_req_header req_header;
> > +    void *op_payload;
> > +    size_t req_payload_sz;
> > +
> > +    /* The vector passed to the kernel */
> > +    struct iovec iov[2];
> > +
> > +    CqeHandler fuse_cqe_handler;
> > +} FuseRingEnt;
> >=20
> >   /*
> >    * One FUSE "queue", representing one FUSE FD from which requests are=
 fetched
> >    * and processed.  Each queue is tied to an AioContext.
> >    */
> > -typedef struct FuseQueue {
> > +struct FuseQueue {
> >       FuseExport *exp;
> >=20
> >       AioContext *ctx;
> > @@ -109,7 +133,12 @@ typedef struct FuseQueue {
> >        * Free this buffer with qemu_vfree().
> >        */
> >       void *spillover_buf;
> > -} FuseQueue;
> > +
> > +#ifdef CONFIG_LINUX_IO_URING
> > +    int qid;
> > +    FuseRingEnt ent;
> > +#endif
> > +};
> >=20
> >   /*
> >    * Verify that FuseQueue.request_buf plus the spill-over buffer toget=
her
> > @@ -148,6 +177,7 @@ struct FuseExport {
> >       bool growable;
> >       /* Whether allow_other was used as a mount option or not */
> >       bool allow_other;
> > +    bool is_uring;
> >=20
> >       mode_t st_mode;
> >       uid_t st_uid;
> > @@ -257,6 +287,93 @@ static const BlockDevOps fuse_export_blk_dev_ops =
=3D {
> >       .drained_poll  =3D fuse_export_drained_poll,
> >   };
> >=20
> > +#ifdef CONFIG_LINUX_IO_URING
> > +
> > +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
> > +                    const unsigned int qid,
> > +                    const unsigned int commit_id)
> > +{
> > +    req->qid =3D qid;
> > +    req->commit_id =3D commit_id;
> > +    req->flags =3D 0;
> > +}
> > +
> > +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue=
 *q,
> > +               __u32 cmd_op)
> > +{
> > +    sqe->opcode =3D IORING_OP_URING_CMD;
> > +
> > +    sqe->fd =3D q->fuse_fd;
> > +    sqe->rw_flags =3D 0;
> > +    sqe->ioprio =3D 0;
> > +    sqe->off =3D 0;
> > +
> > +    sqe->cmd_op =3D cmd_op;
> > +    sqe->__pad1 =3D 0;
> > +}
> > +
> > +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, voi=
d *opaque)
> > +{
> > +    FuseQueue *q =3D opaque;
> > +    struct fuse_uring_cmd_req *req =3D (void *)&sqe->cmd[0];
> > +
> > +    fuse_uring_sqe_prepare(sqe, q, FUSE_IO_URING_CMD_REGISTER);
> > +
> > +    sqe->addr =3D (uint64_t)(q->ent.iov);
> > +    sqe->len =3D 2;
> > +
> > +    fuse_uring_sqe_set_req_data(req, q->qid, 0);
> > +}
> > +
> > +static void fuse_uring_submit_register(void *opaque)
> > +{
> > +    FuseQueue *q =3D opaque;
> > +    FuseExport *exp =3D q->exp;
> > +
> > +
> > +    aio_add_sqe(fuse_uring_prep_sqe_register, q, &(q->ent.fuse_cqe_han=
dler));
>=20
> I think there might be a tricky issue with the io_uring integration in QE=
MU.
> Currently, when the number of IOThreads goes above ~6 or 7, there=E2=80=
=99s a pretty
> high chance of a hang. I added some debug logging in the kernel=E2=80=99s
> fuse_uring_cmd() registration part, and noticed that the number of regist=
er
> calls is less than the total number of entries in the queue. In theory, we
> should be registering each entry for each queue.
>=20
> On the userspace side, everything seems normal, the number of aio_add_sqe=
()
> calls matches the number of IOThreads. But here=E2=80=99s the weird part:=
 if I add a
> printf inside the while loop in fdmon-io_uring.c::fdmon_io_uring_wait(),
> suddenly everything works fine, and the kernel receives registration
> requests for all entries as expected.
>=20
>     do {
>         ret =3D io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
>         fprintf(stderr, "io_uring_submit_and_wait ret: %d\n", ret);
>     } while (ret =3D=3D -EINTR);
>=20
> My guess is that printf is just slowing down the loop, or maybe there=E2=
=80=99s some
> implicit memory barrier happening. Obviously, the right fix isn=E2=80=99t=
 to
> sprinkle fprintfs around. I suspect there might be a subtle
> synchronization/race issue here.

Strange, your fprintf(3) is after io_uring_submit_and_wait(3). I'm not
sure how that would influence timing because there should be num_cpus
IOThreads independently submitting 1 REGISTER uring_cmd.

Debugging ideas:

- When QEMU hangs, cat /proc/<pid>/fdinfo/<fd> for each IOThread's
  io_uring file descriptor. That shows you what the kernel sees,
  including the state of the SQ/CQ rings. If userspace has filled in the
  SQE then the output should reflect that.

- Replace the REGISTER uring_cmd SQE with a IORING_OP_NOP SQE. This way
  you eliminate FUSE and can focus purely on testing io_uring. If the
  CQE is still missing then there is probably a bug in QEMU's
  aio_add_sqe() API.

Stefan

>=20
> Brian
>=20

--1XEZCFtcz5bkNERX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmih3CsACgkQnKSrs4Gr
c8ixXggAouzTi3jvqB5JJ8l+7QPeX9obPwwB00aCEd3d3WmIdefJKg6O7tDHWDTK
kc3R8oqCF4TaI7qWR9GaKUaLZjb3D/LoinyyCnmUK6Sw2PAhyebH30/oA7p1DI8h
6QUgXJKiLNCAyuQyEJHvQmdkI58a9+o9q1SetEfFEahlXnaRqpl+7bzdsYdYEyMK
mPZ1CqcLbm+lVmD3I9KJEajivFOlPvd4bGQAFx6o5ByVYjv7Rbu7iuOn11qd3BWv
emFavImbzvtu9WdUb8zqd9JNarY8DilJMCwmhglud9+sLPY6SwCIzLhK/SJhnqDV
vixdeWAvq9Okkt9tA5GbWxiyrLUiyg==
=fb9f
-----END PGP SIGNATURE-----

--1XEZCFtcz5bkNERX--


