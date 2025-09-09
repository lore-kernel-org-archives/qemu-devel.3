Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86973CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzdt-0001ac-Rh; Tue, 09 Sep 2025 10:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvzdq-0001Z3-DF
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvzdl-0004pm-8t
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757429291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G2M1zuDQFhURgN0/qUvN3ovkLxB/MDdeRJkXRvqFoRc=;
 b=BxlK0j+HK0ceX1VOKJKU4Xddm1dyCX+luac8Q517mNKAef+9EgIEqETC0eNQAdD07Ykcrj
 2mYm4CUulRGQrlZ/ighEtvXomaowVq0KpVW3x/dN56vPZuNkz3BT+fWusH8/nf/fch9c+H
 5O9eRoRapk6Jp25C89F5BkhLopgdeas=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-r-O7v7mDM_SuQv8HBKBOgg-1; Tue,
 09 Sep 2025 10:48:08 -0400
X-MC-Unique: r-O7v7mDM_SuQv8HBKBOgg-1
X-Mimecast-MFC-AGG-ID: r-O7v7mDM_SuQv8HBKBOgg_1757429286
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 890741800562; Tue,  9 Sep 2025 14:48:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.59])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A01C13000198; Tue,  9 Sep 2025 14:48:05 +0000 (UTC)
Date: Tue, 9 Sep 2025 10:48:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH 1/4] export/fuse: add opt to enable FUSE-over-io_uring
Message-ID: <20250909144804.GC218449@fedora>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-2-hibriansong@gmail.com>
 <20250903105325.GB106431@fedora>
 <da5f4b75-2543-4f33-97d9-360c409c6079@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4cSMGEK+PQ92wREy"
Content-Disposition: inline
In-Reply-To: <da5f4b75-2543-4f33-97d9-360c409c6079@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--4cSMGEK+PQ92wREy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 03, 2025 at 02:00:55PM -0400, Brian Song wrote:
>=20
>=20
> On 9/3/25 6:53 AM, Stefan Hajnoczi wrote:
> > On Fri, Aug 29, 2025 at 10:50:22PM -0400, Brian Song wrote:
> > > This patch adds a new export option for storage-export-daemon to enab=
le
> > > FUSE-over-io_uring via the switch io-uring=3Don|off (disableby defaul=
t).
> > > It also implements the protocol handshake with the Linux kernel
> > > during the FUSE-over-io_uring initialization phase.
> > >=20
> > > See: https://docs.kernel.org/filesystems/fuse-io-uring.html
> > >=20
> > > The kernel documentation describes in detail how FUSE-over-io_uring
> > > works. This patch implements the Initial SQE stage shown in thediagra=
m:
> > > it initializes one queue per IOThread, each currently supporting a
> > > single submission queue entry (SQE). When the FUSE driver sends the
> > > first FUSE request (FUSE_INIT), storage-export-daemon calls
> > > fuse_uring_start() to complete initialization, ultimately submitting
> > > the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
> > > successful initialization with the kernel.
> > >=20
> > > We also added support for multiple IOThreads. The current Linux kernel
> > > requires registering $(nproc) queues when setting up FUSE-over-io_uri=
ng
> > > To let users customize the number of FUSE Queues (i.e., IOThreads),
> > > we first create nproc Ring Queues as required by the kernel, then
> > > distribute them in a round-robin manner to the FUSE Queues for
> > > registration. In addition, to support multiple in-flight requests,
> > > we configure each Ring Queue with FUSE_DEFAULT_RING_QUEUE_DEPTH
> > > entries/requests.
> >=20
> > The previous paragraph says "each currently supporting a single
> > submission queue entry (SQE)" whereas this paragraph says "we configure
> > each Ring Queue with FUSE_DEFAULT_RING_QUEUE_DEPTH entries/requests".
> > Maybe this paragraph was squashed into the commit description in a later
> > step and the previous paragraph can be updated to reflect that multiple
> > SQEs are submitted?
> >=20
> > >=20
> > > Suggested-by: Kevin Wolf <kwolf@redhat.com>
> > > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Brian Song <hibriansong@gmail.com>
> > > ---
> > >   block/export/fuse.c                  | 310 ++++++++++++++++++++++++=
+--
> > >   docs/tools/qemu-storage-daemon.rst   |  11 +-
> > >   qapi/block-export.json               |   5 +-
> > >   storage-daemon/qemu-storage-daemon.c |   1 +
> > >   util/fdmon-io_uring.c                |   5 +-
> > >   5 files changed, 309 insertions(+), 23 deletions(-)
> > >=20
> > > diff --git a/block/export/fuse.c b/block/export/fuse.c
> > > index c0ad4696ce..19bf9e5f74 100644
> > > --- a/block/export/fuse.c
> > > +++ b/block/export/fuse.c
> > > @@ -48,6 +48,9 @@
> > >   #include <linux/fs.h>
> > >   #endif
> > > +/* room needed in buffer to accommodate header */
> > > +#define FUSE_BUFFER_HEADER_SIZE 0x1000
> >=20
> > Is it possible to write this in a way that shows how the constant is
> > calculated? That way the constant would automatically adjust on systems
> > where the underlying assumptions have changed (e.g. page size, header
> > struct size). This approach is also self-documenting so it's possible to
> > understand where the magic number comes from.
> >=20
> > For example:
> >=20
> >    #define FUSE_BUFFER_HEADER_SIZE DIV_ROUND_UP(sizeof(struct fuse_urin=
g_req_header), qemu_real_host_page_size())
> >=20
> > (I'm guessing what the formula you used is, so this example may be
> > incorrect...)
> >=20
>=20
> In libfuse, the way to calculate the bufsize (for req_payload) is the same
> as in this patch. For different requests, the request header sizes are not
> the same, but they should never exceed a certain value. So is that why
> libfuse has this kind of magic number?

=46rom <linux/fuse.h>:

  #define FUSE_URING_IN_OUT_HEADER_SZ 128
  #define FUSE_URING_OP_IN_OUT_SZ 128
  ...
  struct fuse_uring_req_header {
          /* struct fuse_in_header / struct fuse_out_header */
          char in_out[FUSE_URING_IN_OUT_HEADER_SZ];

          /* per op code header */
          char op_in[FUSE_URING_OP_IN_OUT_SZ];

          struct fuse_uring_ent_in_out ring_ent_in_out;
  };

The size of struct fuse_uring_req_header is 128 + 128 + (4 * 8) =3D 288
bytes. A single 4 KB page easily fits this. I guess that's why 0x1000
was chosen in libfuse.

>=20
> > > +
> > >   /* Prevent overly long bounce buffer allocations */
> > >   #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 *=
 1024))
> > >   /*
> > > @@ -63,12 +66,59 @@
> > >       (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
> > >   typedef struct FuseExport FuseExport;
> > > +typedef struct FuseQueue FuseQueue;
> > > +
> > > +#ifdef CONFIG_LINUX_IO_URING
> > > +#define FUSE_DEFAULT_RING_QUEUE_DEPTH 64
> > > +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
> > > +
> > > +typedef struct FuseRingQueue FuseRingQueue;
> > > +typedef struct FuseRingEnt {
> > > +    /* back pointer */
> > > +    FuseRingQueue *rq;
> > > +
> > > +    /* commit id of a fuse request */
> > > +    uint64_t req_commit_id;
> >=20
> > This field is not used in this commit. Please introduce it in the commit
> > that uses it so it's easier to review and understand the purpose of this
> > field.
> >=20
> > > +
> > > +    /* fuse request header and payload */
> > > +    struct fuse_uring_req_header req_header;
> > > +    void *op_payload;
> > > +    size_t req_payload_sz;
> >=20
> > op_payload and req_payload_sz refer to the same buffer, and they are
> > submitted alongside req_header. It would be nice to name the fields
> > consistently:
> >=20
> >    struct fuse_uring_req_header req_header;
> >    void *req_payload;
> >    size_t req_payload_sz;
> >=20
> > req_payload and req_payload_sz could be eliminated since they are also
> > stored in iov[1].iov_base and .iov_len. If you feel that would be harder
> > to understand, then it's okay to keep the duplicate fields.
> >=20
>=20
> Makes sense. I followed the design in libfuse. Probably best to just leave
> them in the struct for readability
>=20
> > > +
> > > +    /* The vector passed to the kernel */
> > > +    struct iovec iov[2];
> > > +
> > > +    CqeHandler fuse_cqe_handler;
> > > +} FuseRingEnt;
> > > +
> > > +struct FuseRingQueue {
> >=20
> > A comment would be nice here to explain that the kernel requires one
> > FuseRingQueue per host CPU and this concept is independent of /dev/fuse
> > (FuseQueue).
> >=20
> > > +    int rqid;
> > > +
> > > +    /* back pointer */
> > > +    FuseQueue *q;
> > > +    FuseRingEnt *ent;
> > > +
> > > +    /* List entry for ring_queues */
> > > +    QLIST_ENTRY(FuseRingQueue) next;
> > > +};
> > > +
> > > +/*
> > > + * Round-robin distribution of ring queues across FUSE queues.
> > > + * This structure manages the mapping between kernel ring queues and=
 user
> > > + * FUSE queues.
> > > + */
> > > +typedef struct FuseRingQueueManager {
> > > +    FuseRingQueue *ring_queues;
> > > +    int num_ring_queues;
> > > +    int num_fuse_queues;
> > > +} FuseRingQueueManager;
> > > +#endif
> >=20
> > It's easy to forget which #ifdef we're inside after a few lines, so it
> > helps to indicate that in a comment:
> >=20
> > #endif /* CONFIG_LINUX_IO_URING */
> >=20
> > >   /*
> > >    * One FUSE "queue", representing one FUSE FD from which requests a=
re fetched
> > >    * and processed.  Each queue is tied to an AioContext.
> > >    */
> > > -typedef struct FuseQueue {
> > > +struct FuseQueue {
> > >       FuseExport *exp;
> > >       AioContext *ctx;
> > > @@ -109,15 +159,11 @@ typedef struct FuseQueue {
> > >        * Free this buffer with qemu_vfree().
> > >        */
> > >       void *spillover_buf;
> > > -} FuseQueue;
> > > -/*
> > > - * Verify that FuseQueue.request_buf plus the spill-over buffer toge=
ther
> > > - * are big enough to be accepted by the FUSE kernel driver.
> > > - */
> > > -QEMU_BUILD_BUG_ON(sizeof(((FuseQueue *)0)->request_buf) +
> > > -                  FUSE_SPILLOVER_BUF_SIZE <
> > > -                  FUSE_MIN_READ_BUFFER);
> >=20
> > Why was this removed, it's probably still necessary in the non-io_uring
> > case (which is compiled in even when CONFIG_LINUX_IO_URING is defined)?
> >=20
>=20
> You can check Hanna=E2=80=99s patch. In fuse_co_process_request, Hanna in=
troduced
> this check when using FUSE_OUT_OP_STRUCT to cast void *buf into the
> corresponding in/out header for the given operation.
>=20
> But in the v2 patch, we merged the legacy process_request and the uring
> version into one. This caused the legacy path to pass the array into the
> common function as a pointer. Now, when we do the buf header size check,
> what gets checked is just the pointer size.
>=20
> #define FUSE_OUT_OP_STRUCT(op_name, out_buf) \
>     ({ \
>         struct fuse_out_header *__out_hdr =3D \
>             (struct fuse_out_header *)(out_buf); \
>         struct fuse_##op_name##_out *__out =3D \
>             (struct fuse_##op_name##_out *)(__out_hdr + 1); \
>         \
>         QEMU_BUILD_BUG_ON(sizeof(*__out_hdr) + sizeof(*__out) > \
>                           sizeof(out_buf)); \
>         \
>         __out; \
>     })

Your patch does not change how ->request_buf is used by the non-io_uring
code path. ->request_buf needs to fit at least FUSE_MIN_READ_BUFFER
bytes so I think this QEMU_BUILD_BUG_ON() should not be deleted.

>=20
>=20
> > > +#ifdef CONFIG_LINUX_IO_URING
> > > +    QLIST_HEAD(, FuseRingQueue) ring_queue_list;
> > > +#endif
> > > +};
> > >   struct FuseExport {
> > >       BlockExport common;
> > > @@ -133,7 +179,7 @@ struct FuseExport {
> > >        */
> > >       bool halted;
> > > -    int num_queues;
> > > +    size_t num_queues;
> > >       FuseQueue *queues;
> > >       /*
> > >        * True if this export should follow the generic export's AioCo=
ntext.
> > > @@ -149,6 +195,12 @@ struct FuseExport {
> > >       /* Whether allow_other was used as a mount option or not */
> > >       bool allow_other;
> > > +#ifdef CONFIG_LINUX_IO_URING
> > > +    bool is_uring;
> > > +    size_t ring_queue_depth;
> > > +    FuseRingQueueManager *ring_queue_manager;
> > > +#endif
> > > +
> > >       mode_t st_mode;
> > >       uid_t st_uid;
> > >       gid_t st_gid;
> > > @@ -205,7 +257,7 @@ static void fuse_attach_handlers(FuseExport *exp)
> > >           return;
> > >       }
> > > -    for (int i =3D 0; i < exp->num_queues; i++) {
> > > +    for (size_t i =3D 0; i < exp->num_queues; i++) {
> > >           aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_=
fd,
> > >                              read_from_fuse_fd, NULL, NULL, NULL,
> > >                              &exp->queues[i]);
> > > @@ -257,6 +309,189 @@ static const BlockDevOps fuse_export_blk_dev_op=
s =3D {
> > >       .drained_poll  =3D fuse_export_drained_poll,
> > >   };
> > > +#ifdef CONFIG_LINUX_IO_URING
> > > +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *r=
eq,
> > > +                    const unsigned int rqid,
> > > +                    const unsigned int commit_id)
> > > +{
> > > +    req->qid =3D rqid;
> > > +    req->commit_id =3D commit_id;
> > > +    req->flags =3D 0;
> > > +}
> > > +
> > > +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQue=
ue *q,
> > > +               __u32 cmd_op)
> > > +{
> > > +    sqe->opcode =3D IORING_OP_URING_CMD;
> > > +
> > > +    sqe->fd =3D q->fuse_fd;
> > > +    sqe->rw_flags =3D 0;
> > > +    sqe->ioprio =3D 0;
> > > +    sqe->off =3D 0;
> > > +
> > > +    sqe->cmd_op =3D cmd_op;
> > > +    sqe->__pad1 =3D 0;
> > > +}
> > > +
> > > +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, v=
oid *opaque)
> > > +{
> > > +    FuseRingEnt *ent =3D opaque;
> > > +    struct fuse_uring_cmd_req *req =3D (void *)&sqe->cmd[0];
> > > +
> > > +    fuse_uring_sqe_prepare(sqe, ent->rq->q, FUSE_IO_URING_CMD_REGIST=
ER);
> > > +
> > > +    sqe->addr =3D (uint64_t)(ent->iov);
> > > +    sqe->len =3D 2;
> > > +
> > > +    fuse_uring_sqe_set_req_data(req, ent->rq->rqid, 0);
> > > +}
> > > +
> > > +static void fuse_uring_submit_register(void *opaque)
> > > +{
> > > +    FuseRingEnt *ent =3D opaque;
> > > +    FuseExport *exp =3D ent->rq->q->exp;
> >=20
> > This variable is unused in this commit? Does this commit compile for
> > you? Usually the compiler warns about unused variables.
> >=20
>=20
> The first version was a large single patch. I split it with git, and this
> variable is now used in a different patch
>=20
> > > +
> > > +
> > > +    aio_add_sqe(fuse_uring_prep_sqe_register, ent, &(ent->fuse_cqe_h=
andler));
> > > +}
> > > +
> > > +/**
> > > + * Distribute ring queues across FUSE queues using round-robin algor=
ithm.
> > > + * This ensures even distribution of kernel ring queues across user-=
specified
> > > + * FUSE queues.
> > > + */
> > > +static
> > > +FuseRingQueueManager *fuse_ring_queue_manager_create(int num_fuse_qu=
eues,
> > > +                                                    size_t ring_queu=
e_depth,
> > > +                                                    size_t bufsize)
> > > +{
> > > +    int num_ring_queues =3D get_nprocs();
> >=20
> > The kernel code uses num_possible_cpus() in
> > fs/fuse/dev_uring.c:fuse_uring_create() so I think this should be
> > get_nprocs_conf() instead of get_nprocs().
> >=20
> > > +    FuseRingQueueManager *manager =3D g_new(FuseRingQueueManager, 1);
> > > +
> > > +    if (!manager) {
> >=20
> > g_new() never returns NULL, so you can remove this if statement. If
> > memory cannot be allocated then the process will abort.
> >=20
> > > +        return NULL;
> > > +    }
> > > +
> > > +    manager->ring_queues =3D g_new(FuseRingQueue, num_ring_queues);
> > > +    manager->num_ring_queues =3D num_ring_queues;
> > > +    manager->num_fuse_queues =3D num_fuse_queues;
> > > +
> > > +    if (!manager->ring_queues) {
> >=20
> > Same here.
> >=20
> > > +        g_free(manager);
> > > +        return NULL;
> > > +    }
> > > +
> > > +    for (int i =3D 0; i < num_ring_queues; i++) {
> > > +        FuseRingQueue *rq =3D &manager->ring_queues[i];
> > > +        rq->rqid =3D i;
> > > +        rq->ent =3D g_new(FuseRingEnt, ring_queue_depth);
> > > +
> > > +        if (!rq->ent) {
> >=20
> > Same here.
> >=20
> > > +            for (int j =3D 0; j < i; j++) {
> > > +                g_free(manager->ring_queues[j].ent);
> > > +            }
> > > +            g_free(manager->ring_queues);
> > > +            g_free(manager);
> > > +            return NULL;
> > > +        }
> > > +
> > > +        for (size_t j =3D 0; j < ring_queue_depth; j++) {
> > > +            FuseRingEnt *ent =3D &rq->ent[j];
> > > +            ent->rq =3D rq;
> > > +            ent->req_payload_sz =3D bufsize - FUSE_BUFFER_HEADER_SIZ=
E;
> > > +            ent->op_payload =3D g_malloc0(ent->req_payload_sz);
> > > +
> > > +            if (!ent->op_payload) {
> >=20
> > Same here.
> >=20
> > > +                for (size_t k =3D 0; k < j; k++) {
> > > +                    g_free(rq->ent[k].op_payload);
> > > +                }
> > > +                g_free(rq->ent);
> > > +                for (int k =3D 0; k < i; k++) {
> > > +                    g_free(manager->ring_queues[k].ent);
> > > +                }
> > > +                g_free(manager->ring_queues);
> > > +                g_free(manager);
> >=20
> > Where are these structures freed in the normal lifecycle of a FUSE
> > export? I only see this error handling code, but nothing is freed when
> > the export is shut down.
>=20
>=20
> Same here. The first version was a large single patch. I split it with gi=
t,
> and we do cleanup in a different patch

It's easier for reviewers and safer for backports if each patch is
self-contained with the cleanup code included in the same patch where
the resource is created. If you make changes to the patch organization
in the next revision then it would be nice to included the cleanup in
this patch.

>=20
> >=20
> > > +                return NULL;
> > > +            }
> > > +
> > > +            ent->iov[0] =3D (struct iovec) {
> > > +                &(ent->req_header),
> > > +                sizeof(struct fuse_uring_req_header)
> > > +            };
> > > +            ent->iov[1] =3D (struct iovec) {
> > > +                ent->op_payload,
> > > +                ent->req_payload_sz
> > > +            };
> > > +
> > > +            ent->fuse_cqe_handler.cb =3D fuse_uring_cqe_handler;
> > > +        }
> > > +    }
> > > +
> > > +    return manager;
> > > +}
> > > +
> > > +static
> > > +void fuse_distribute_ring_queues(FuseExport *exp, FuseRingQueueManag=
er *manager)
> > > +{
> > > +    int queue_index =3D 0;
> > > +
> > > +    for (int i =3D 0; i < manager->num_ring_queues; i++) {
> > > +        FuseRingQueue *rq =3D &manager->ring_queues[i];
> > > +
> > > +        rq->q =3D &exp->queues[queue_index];
> > > +        QLIST_INSERT_HEAD(&(rq->q->ring_queue_list), rq, next);
> > > +
> > > +        queue_index =3D (queue_index + 1) % manager->num_fuse_queues;
> > > +    }
> > > +}
> > > +
> > > +static
> > > +void fuse_schedule_ring_queue_registrations(FuseExport *exp,
> > > +                                            FuseRingQueueManager *ma=
nager)
> > > +{
> > > +    for (int i =3D 0; i < manager->num_fuse_queues; i++) {
> > > +        FuseQueue *q =3D &exp->queues[i];
> > > +        FuseRingQueue *rq;
> > > +
> > > +        QLIST_FOREACH(rq, &q->ring_queue_list, next) {
> > > +            for (int j =3D 0; j < exp->ring_queue_depth; j++) {
> > > +                aio_bh_schedule_oneshot(q->ctx, fuse_uring_submit_re=
gister,
> > > +                                        &(rq->ent[j]));
> > > +            }
> > > +        }
> > > +    }
> > > +}
> > > +
> > > +static void fuse_uring_start(FuseExport *exp, struct fuse_init_out *=
out)
> > > +{
> > > +    /*
> > > +     * Since we didn't enable the FUSE_MAX_PAGES feature, the value =
of
> > > +     * fc->max_pages should be FUSE_DEFAULT_MAX_PAGES_PER_REQ, which=
 is set by
> > > +     * the kernel by default. Also, max_write should not exceed
> > > +     * FUSE_DEFAULT_MAX_PAGES_PER_REQ * PAGE_SIZE.
> > > +     */
> > > +    size_t bufsize =3D out->max_write + FUSE_BUFFER_HEADER_SIZE;
> > > +
> > > +    if (!(out->flags & FUSE_MAX_PAGES)) {
> > > +        bufsize =3D FUSE_DEFAULT_MAX_PAGES_PER_REQ * qemu_real_host_=
page_size()
> > > +                         + FUSE_BUFFER_HEADER_SIZE;
> > > +    }
> > > +
> > > +    exp->ring_queue_manager =3D fuse_ring_queue_manager_create(
> > > +        exp->num_queues, exp->ring_queue_depth, bufsize);
> > > +
> > > +    if (!exp->ring_queue_manager) {
> > > +        error_report("Failed to create ring queue manager");
> > > +        return;
> > > +    }
> > > +
> > > +    /* Distribute ring queues across FUSE queues using round-robin */
> > > +    fuse_distribute_ring_queues(exp, exp->ring_queue_manager);
> > > +
> > > +    fuse_schedule_ring_queue_registrations(exp, exp->ring_queue_mana=
ger);
> > > +}
> > > +#endif
> > > +
> > >   static int fuse_export_create(BlockExport *blk_exp,
> > >                                 BlockExportOptions *blk_exp_args,
> > >                                 AioContext *const *multithread,
> > > @@ -270,6 +505,11 @@ static int fuse_export_create(BlockExport *blk_e=
xp,
> > >       assert(blk_exp_args->type =3D=3D BLOCK_EXPORT_TYPE_FUSE);
> > > +#ifdef CONFIG_LINUX_IO_URING
> > > +    exp->is_uring =3D args->io_uring;
> > > +    exp->ring_queue_depth =3D FUSE_DEFAULT_RING_QUEUE_DEPTH;
> > > +#endif
> > > +
> > >       if (multithread) {
> > >           /* Guaranteed by common export code */
> > >           assert(mt_count >=3D 1);
> > > @@ -283,6 +523,10 @@ static int fuse_export_create(BlockExport *blk_e=
xp,
> > >                   .exp =3D exp,
> > >                   .ctx =3D multithread[i],
> > >                   .fuse_fd =3D -1,
> > > +#ifdef CONFIG_LINUX_IO_URING
> > > +                .ring_queue_list =3D
> > > +                    QLIST_HEAD_INITIALIZER(exp->queues[i].ring_queue=
_list),
> > > +#endif
> > >               };
> > >           }
> > >       } else {
> > > @@ -296,6 +540,10 @@ static int fuse_export_create(BlockExport *blk_e=
xp,
> > >               .exp =3D exp,
> > >               .ctx =3D exp->common.ctx,
> > >               .fuse_fd =3D -1,
> > > +#ifdef CONFIG_LINUX_IO_URING
> > > +            .ring_queue_list =3D
> > > +                QLIST_HEAD_INITIALIZER(exp->queues[0].ring_queue_lis=
t),
> > > +#endif
> > >           };
> > >       }
> > > @@ -685,17 +933,39 @@ static bool is_regular_file(const char *path, E=
rror **errp)
> > >    */
> > >   static ssize_t coroutine_fn
> > >   fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
> > > -             uint32_t max_readahead, uint32_t flags)
> > > +             uint32_t max_readahead, const struct fuse_init_in *in)
> > >   {
> > > -    const uint32_t supported_flags =3D FUSE_ASYNC_READ | FUSE_ASYNC_=
DIO;
> > > +    uint64_t supported_flags =3D FUSE_ASYNC_READ | FUSE_ASYNC_DIO
> > > +                                     | FUSE_INIT_EXT;
> > > +    uint64_t outargflags =3D 0;
> > > +    uint64_t inargflags =3D in->flags;
> > > +
> > > +    ssize_t ret =3D 0;
> > > +
> > > +    if (inargflags & FUSE_INIT_EXT) {
> > > +        inargflags =3D inargflags | (uint64_t) in->flags2 << 32;
> > > +    }
> > > +
> > > +#ifdef CONFIG_LINUX_IO_URING
> > > +    if (exp->is_uring) {
> > > +        if (inargflags & FUSE_OVER_IO_URING) {
> > > +            supported_flags |=3D FUSE_OVER_IO_URING;
> > > +        } else {
> > > +            exp->is_uring =3D false;
> > > +            ret =3D -ENODEV;
> > > +        }
> > > +    }
> > > +#endif
> > > +
> > > +    outargflags =3D inargflags & supported_flags;
> > >       *out =3D (struct fuse_init_out) {
> > >           .major =3D FUSE_KERNEL_VERSION,
> > >           .minor =3D FUSE_KERNEL_MINOR_VERSION,
> > >           .max_readahead =3D max_readahead,
> > >           .max_write =3D FUSE_MAX_WRITE_BYTES,
> > > -        .flags =3D flags & supported_flags,
> > > -        .flags2 =3D 0,
> > > +        .flags =3D outargflags,
> > > +        .flags2 =3D outargflags >> 32,
> > >           /* libfuse maximum: 2^16 - 1 */
> > >           .max_background =3D UINT16_MAX,
> > > @@ -717,7 +987,7 @@ fuse_co_init(FuseExport *exp, struct fuse_init_ou=
t *out,
> > >           .map_alignment =3D 0,
> > >       };
> > > -    return sizeof(*out);
> > > +    return ret < 0 ? ret : sizeof(*out);
> > >   }
> > >   /**
> > > @@ -1506,6 +1776,14 @@ fuse_co_process_request(FuseQueue *q, void *sp=
illover_buf)
> > >           fuse_write_buf_response(q->fuse_fd, req_id, out_hdr,
> > >                                   out_data_buffer, ret);
> > >           qemu_vfree(out_data_buffer);
> > > +#ifdef CONFIG_LINUX_IO_URING
> > > +    /* Handle FUSE-over-io_uring initialization */
> > > +    if (unlikely(opcode =3D=3D FUSE_INIT && exp->is_uring)) {
> > > +        struct fuse_init_out *out =3D
> > > +            (struct fuse_init_out *)FUSE_OUT_OP_STRUCT(out_buf);
> > > +        fuse_uring_start(exp, out);
> >=20
> > Is there any scenario where FUSE_INIT can be received multiple times?
> > Maybe if the FUSE file system is umounted and mounted again? I want to
> > check that this doesn't leak previously allocated ring state.
> >=20
>=20
> I don't think so, even in a multi-threaded FUSE setup, the kernel only se=
nds
> a single FUSE_INIT to userspace. In the legacy mode, whichever thread
> receives that request can handle it and initialize FUSE-over-io_uring

Okay. Please add an assertion to fuse_uring_start() to catch the case
where it is called twice.

Thanks,
Stefan

--4cSMGEK+PQ92wREy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjAPiQACgkQnKSrs4Gr
c8irXwf/aY/V2S7qV1T5bbgD+2Ho/JuFu5QuE1nVASId+Y3siDeJu/58rzSHidow
YQ7bCAt2BZYozy6MTf4ys35hTeKDO3cCpyV3rWoCSFAW+6tlCTMGjBYKrzf0Mg7H
86pPmF1ge8AaI5BP9bB/dV72w2cq3t5tB4L44a8ixl4qibf2Ug2UtEgB0BkJ16gm
8Sh69Y9eFd/Vu6t25txNqiYFIIed3OrKZ58EvIgGGvjVKAzDbewE+akdr3sWnp5G
+x2Fxj4iFJW+SLdRBE9jrVmKgp7pFAfqfGvGCmweBA5Fdw9eJ/38F9lEKB6WywW/
iM/9g0NUPgX7HqvjTD3rr8MbGZH4VQ==
=UoVS
-----END PGP SIGNATURE-----

--4cSMGEK+PQ92wREy--


