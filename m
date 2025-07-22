Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFDBC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 16:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueG9H-0001dY-14; Tue, 22 Jul 2025 12:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ueFA1-0007Ao-Qw
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ueF9z-000311-RV
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753199047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ckXdNtgalhmSe4eladYM9C9gn+mq1uQWd4ygKF1K7oA=;
 b=SeHavgxIBcshIvj3cbOr4ceY1hLgN0UpQxGOL4WxdL1M+mw+NPuZSKCkTaEZvPX+qoBIh5
 SAbtJc3tO13miougfBMbVFEaAU/Jd/brdoUhS0BmYeD3GP0P5fBms93vBUT0LbBz1nCw8k
 jAdM02IdQr/T+dxDnXniJCYKtUeo8xw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-Eiew-dIvOGyWCPdrF3XH8g-1; Tue,
 22 Jul 2025 11:44:01 -0400
X-MC-Unique: Eiew-dIvOGyWCPdrF3XH8g-1
X-Mimecast-MFC-AGG-ID: Eiew-dIvOGyWCPdrF3XH8g_1753199040
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E7CC1800C33; Tue, 22 Jul 2025 15:44:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.72])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDA4D195608D; Tue, 22 Jul 2025 15:43:58 +0000 (UTC)
Date: Tue, 22 Jul 2025 11:43:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Brian Song <hibriansong@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "hreitz@redhat.com" <hreitz@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>
Subject: Re: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for
 QEMU FUSE Exports
Message-ID: <20250722154357.GA21935@fedora>
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250716183824.216257-2-hibriansong@gmail.com>
 <20250721005346.GB32887@fedora>
 <e8210399-9d04-46c1-8a23-6e8cdb472c6f@ddn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LUJKDuXeMFH41MIW"
Content-Disposition: inline
In-Reply-To: <e8210399-9d04-46c1-8a23-6e8cdb472c6f@ddn.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--LUJKDuXeMFH41MIW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 02:06:04PM +0000, Bernd Schubert wrote:
> On 7/21/25 02:53, Stefan Hajnoczi wrote:
> > On Wed, Jul 16, 2025 at 02:38:24PM -0400, Brian Song wrote:
> >> This work provides an initial implementation of fuse-over-io_uring
> >> support for QEMU export. According to the fuse-over-io_uring protocol
> >> specification, the userspace side must create the same number of queues
> >> as the number of CPUs (nr_cpu), just like the kernel. Currently, each
> >> queue contains only a single SQE entry, which is used to validate the
> >> correctness of the fuse-over-io_uring functionality.
> >>
> >> All FUSE read and write operations interact with the kernel via io
> >> vectors embedded in the SQE entry during submission and CQE fetching.
> >> The req_header and op_payload members of each entry are included as
> >> parts of the io vector: req_header carries the FUSE operation header,
> >> and op_payload carries the data payload, such as file attributes in a
> >> getattr reply, file content in a read reply, or file content being
> >> written to the FUSE client in a write operation.
> >>
> >> At present, multi-threading support is still incomplete. In addition,
> >> handling connection termination and managing the "drained" state of a
> >> FUSE block export in QEMU remain as pending work.
> >>
> >> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> >> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> Signed-off-by: Brian Song <hibriansong@gmail.com>
> >>
> >> ---
> >>  block/export/fuse.c                  | 423 +++++++++++++++++++++++++--
> >>  docs/tools/qemu-storage-daemon.rst   |  10 +-
> >>  qapi/block-export.json               |   6 +-
> >>  storage-daemon/qemu-storage-daemon.c |   1 +
> >>  util/fdmon-io_uring.c                |   5 +-
> >>  5 files changed, 420 insertions(+), 25 deletions(-)
> >=20
> > Here is feedback from a first pass over this patch.
> >=20
> >>
> >> diff --git a/block/export/fuse.c b/block/export/fuse.c
> >> index c0ad4696ce..637d36186a 100644
> >> --- a/block/export/fuse.c
> >> +++ b/block/export/fuse.c
> >> @@ -48,6 +48,11 @@
> >>  #include <linux/fs.h>
> >>  #endif
> >> =20
> >> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
> >> +
> >> +/* room needed in buffer to accommodate header */
> >> +#define FUSE_BUFFER_HEADER_SIZE 0x1000
> >> +
> >>  /* Prevent overly long bounce buffer allocations */
> >>  #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1=
024))
> >>  /*
> >> @@ -64,6 +69,26 @@
> >> =20
> >>  typedef struct FuseExport FuseExport;
> >> =20
> >> +struct FuseQueue;
> >=20
> > Use "typedef struct FuseQueue FuseQueue;" here...
> >=20
> >> +
> >> +typedef struct FuseRingEnt {
> >> +    /* back pointer */
> >> +    struct FuseQueue *q;
> >=20
> > ...and then this can be "FuseQueue *q;" so that QEMU coding style is
> > followed.
> >=20
> >> +
> >> +    /* commit id of a fuse request */
> >> +    uint64_t req_commit_id;
> >> +
> >> +    /* fuse request header and payload */
> >> +    struct fuse_uring_req_header *req_header;
> >> +    void *op_payload;
> >> +    size_t req_payload_sz;
> >> +
> >> +    /* The vector passed to the kernel */
> >> +    struct iovec iov[2];
> >> +
> >> +    CqeHandler fuse_cqe_handler;
> >> +} FuseRingEnt;
> >> +
> >>  /*
> >>   * One FUSE "queue", representing one FUSE FD from which requests are=
 fetched
> >>   * and processed.  Each queue is tied to an AioContext.
> >> @@ -73,6 +98,7 @@ typedef struct FuseQueue {
> >> =20
> >>      AioContext *ctx;
> >>      int fuse_fd;
> >> +    int qid;
> >=20
> > Could this go inside #ifdef CONFIG_LINUX_IO_URING? It seems to be
> > specific to FUSE-over-io_uring.
> >=20
> >> =20
> >>      /*
> >>       * The request buffer must be able to hold a full write, and/or a=
t least
> >> @@ -109,6 +135,17 @@ typedef struct FuseQueue {
> >>       * Free this buffer with qemu_vfree().
> >>       */
> >>      void *spillover_buf;
> >> +
> >> +#ifdef CONFIG_LINUX_IO_URING
> >> +    FuseRingEnt ent;
> >> +
> >> +    /*
> >> +     * TODO
> >> +     * Support multi-threaded FUSE over io_uring by using eventfd and=
 allocating
> >> +     * an extra SQE for each thread to be notified when the connection
> >> +     * shuts down.
> >> +     */
> >=20
> > eventfd and the extra SQE won't be necessary because
> > aio_bh_schedule_oneshot() can be used to cause threads to execute a
> > function.
> >=20
> > (I think this comment effectively says that connection shutdown still
> > needs to be implemented. The implementation details don't matter at this
> > point.)
> >=20
> >> +#endif
> >>  } FuseQueue;
> >> =20
> >>  /*
> >> @@ -148,6 +185,7 @@ struct FuseExport {
> >>      bool growable;
> >>      /* Whether allow_other was used as a mount option or not */
> >>      bool allow_other;
> >> +    bool is_uring;
> >> =20
> >>      mode_t st_mode;
> >>      uid_t st_uid;
> >> @@ -257,6 +295,126 @@ static const BlockDevOps fuse_export_blk_dev_ops=
 =3D {
> >>      .drained_poll  =3D fuse_export_drained_poll,
> >>  };
> >> =20
> >> +#ifdef CONFIG_LINUX_IO_URING
> >> +static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *e=
nt);
> >> +
> >> +static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)
> >> +{
> >> +    CqeHandler *cqe_handler =3D opaque;
> >> +    FuseRingEnt *ent =3D container_of(cqe_handler, FuseRingEnt, fuse_=
cqe_handler);
> >=20
> > Passing ent in opaque instead of cqe_handler would simplify this.
> >=20
> >> +    FuseExport *exp =3D ent->q->exp;
> >> +
> >> +    fuse_uring_co_process_request(ent);
> >> +
> >> +    fuse_dec_in_flight(exp);
> >> +}
> >> +
> >> +static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
> >> +{
> >> +    FuseRingEnt *ent =3D container_of(cqe_handler, FuseRingEnt, fuse_=
cqe_handler);
> >> +    FuseQueue *q =3D ent->q;
> >> +    Coroutine *co;
> >> +    FuseExport *exp =3D ent->q->exp;
> >> +
> >> +    int err =3D cqe_handler->cqe.res;
> >> +    if (err !=3D 0) {
> >> +        /* TODO end_conn support */
> >> +
> >> +        /* -ENOTCONN is ok on umount  */
> >> +        if (err !=3D -EINTR && err !=3D -EOPNOTSUPP &&
> >> +            err !=3D -EAGAIN && err !=3D -ENOTCONN) {
> >> +            fuse_export_halt(exp);
> >> +        }
> >> +    } else {
> >> +        co =3D qemu_coroutine_create(co_fuse_uring_queue_handle_cqes,
> >> +                            cqe_handler);
> >> +        /* Decremented by co_fuse_uring_queue_handle_cqes() */
> >> +        fuse_inc_in_flight(q->exp);
> >=20
> > Can this be moved inside co_fuse_uring_queue_handle_cqes() to avoid
> > calling inc/dec from different functions? That would make the code
> > easier to understand and more robust against future bugs.
> >=20
> >> +        qemu_coroutine_enter(co);
> >> +    }
> >> +}
> >> +
> >> +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *re=
q,
> >> +                    const unsigned int qid,
> >> +                    const unsigned int commit_id)
> >> +{
> >> +    req->qid =3D qid;
> >> +    req->commit_id =3D commit_id;
> >> +    req->flags =3D 0;
> >> +}
> >> +
> >> +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseRing=
Ent *ent,
> >> +               __u32 cmd_op)
> >> +{
> >> +    sqe->opcode =3D IORING_OP_URING_CMD;
> >> +
> >> +    sqe->fd =3D ent->q->fuse_fd;
> >> +    sqe->rw_flags =3D 0;
> >> +    sqe->ioprio =3D 0;
> >> +    sqe->off =3D 0;
> >> +
> >> +    sqe->cmd_op =3D cmd_op;
> >> +    sqe->__pad1 =3D 0;
> >> +}
> >> +
> >> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, vo=
id *opaque)
> >> +{
> >> +    FuseQueue *q =3D opaque;
> >> +    struct fuse_uring_cmd_req *req =3D (void *)&sqe->cmd[0];
> >> +
> >> +    fuse_uring_sqe_prepare(sqe, &q->ent, FUSE_IO_URING_CMD_REGISTER);
> >> +
> >> +    sqe->addr =3D (uint64_t)(q->ent.iov);
> >> +    sqe->len =3D 2;
> >> +
> >> +    fuse_uring_sqe_set_req_data(req, q->qid, 0);
> >> +}
> >> +
> >> +static void fuse_uring_start(FuseExport *exp, struct fuse_init_out *o=
ut)
> >> +{
> >> +    /*
> >> +     * Since we didn't enable the FUSE_MAX_PAGES feature, the value of
> >> +     * fc->max_pages should be FUSE_DEFAULT_MAX_PAGES_PER_REQ, which =
is set by
> >> +     * the kernel by default. Also, max_write should not exceed
> >> +     * FUSE_DEFAULT_MAX_PAGES_PER_REQ * PAGE_SIZE.
> >> +     */
> >> +    size_t bufsize =3D out->max_write + FUSE_BUFFER_HEADER_SIZE;
> >> +
> >> +    if (!(out->flags & FUSE_MAX_PAGES)) {
> >> +        /*
> >> +         * bufsize =3D MIN(FUSE_DEFAULT_MAX_PAGES_PER_REQ *
> >> +         *       qemu_real_host_page_size() + FUSE_BUFFER_HEADER_SIZE=
, bufsize);
> >> +         */
> >> +        bufsize =3D FUSE_DEFAULT_MAX_PAGES_PER_REQ * qemu_real_host_p=
age_size()
> >> +                         + FUSE_BUFFER_HEADER_SIZE;
> >> +    }
> >> +
> >> +    for (int i =3D 0; i < exp->num_queues; i++) {
> >> +        FuseQueue *q =3D &exp->queues[i];
> >> +
> >> +        q->ent.q =3D q;
> >> +
> >> +        q->ent.req_header =3D g_malloc0(sizeof(struct fuse_uring_req_=
header));
> >=20
> > It's probably easier to embed the header as a FuseRingEnt field instead
> > of heap allocating it.
>=20
> Hmm well. So we have two additional patch in the DDN branch for which I=
=20
> didn't have time to upstream them yet. These patches allow to pin these
> buffers/pages and with that the application doing IO can directly write
> into the buffer - saves context swithes. The initial RFC kernel patches
> were using mmaped buffers and when I had to switch to userspace buffers,
> performance went badly down. I didn't run real benchmarks, but just
> xfstests  - with mmapped buffers it was running like 3 times faster than
> legacy fuse and that advantage got lost with normal buffers that
> get mapped per request. Switching to pinned buffers brought back the
> fast xfstest runs.
> Issue is that the buffer needs to be page aligned - which is why libfuse
> takes an extra allocation here.
> In libfuse I should probably make this optional, as pinned buffers
> will mostly only work for root (needs locked memory).
>=20
> In principle I would need to document these details somewhere, I should
> probably create blog or so.

That sounds like something we'd like to try out, although we try to
minimize privileges needed for qemu-storage-daemon.

A question about pinning and resource limits: qemu-storage-daemon uses
O_DIRECT for I/O as non-root without hitting mlock resource limits. Is
there a difference between pin_user_pages(FOLL_PIN) (for direct I/O) and
pin_user_pages(FOLL_PIN | FOLL_LONGTERM) (possibly for
FUSE-over-io_uring pinning) in terms of resource limit behavior?

Thanks,
Stefan

--LUJKDuXeMFH41MIW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh/sb0ACgkQnKSrs4Gr
c8hWIgf/QzmXZHPSyDrg5jsc5xv7reXiXiGTBkmttd/4KsL52MEnf9EiRLUCF9yX
NZCtQfJo/7Xuv+u5blmqHP+3KlDL638BMoaB4YHfl/OBM+QTDFJj6ASBn98THdGt
EFn8uoGlWBiAd6dMk1GruESJyt/0QplGDVnAbSMRs/C6e3U6ZQT8Oy1Mcm7Huggv
9sblLwu2Eh1+TzwcsxsOTQJVWosnD2mDRMMglCG2JBBHe5UEhm5pjWs6cPBtfRSz
8vPxa4JXplidVnXxGtiWlQvWJMlF5cEqVKTGjNZp/Umv9fAYGHpj2pX8G0Yyyfsj
AAny4NexGQFYH6DDBvVAa9dWGGWrZA==
=zo3O
-----END PGP SIGNATURE-----

--LUJKDuXeMFH41MIW--


