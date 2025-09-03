Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA149CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utl7V-00048g-Dt; Wed, 03 Sep 2025 06:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1utl7T-00048H-Pi
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1utl7Q-0008Pa-FA
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756896813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrFVTwxaEBkfhV3Ly33uBgIveu5Nm1+5QlKzPUaLUHw=;
 b=EGUIVdgYXj0vPPlX7NQcZ95rAm/XpHS4Ds3Lr6iZOcdCCs7BGv7yBqVkofKLL7kWpKi2AK
 97BEGxwKmuc2J/lfrSmMl+XLWX9gUttWA8erRs6CDYktKE3OMIHhMX6O6FfVJDIGs2+Gib
 X28ov/Cy6CI5feiR+z9HbTkl0TYipck=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-S6XOTAuKPl281hrwlHw8Jw-1; Wed,
 03 Sep 2025 06:53:30 -0400
X-MC-Unique: S6XOTAuKPl281hrwlHw8Jw-1
X-Mimecast-MFC-AGG-ID: S6XOTAuKPl281hrwlHw8Jw_1756896809
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8D401800562; Wed,  3 Sep 2025 10:53:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9ECFE1800451; Wed,  3 Sep 2025 10:53:27 +0000 (UTC)
Date: Wed, 3 Sep 2025 12:53:25 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH 1/4] export/fuse: add opt to enable FUSE-over-io_uring
Message-ID: <20250903105325.GB106431@fedora>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-2-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pOkYF4ZkALzC9oZ7"
Content-Disposition: inline
In-Reply-To: <20250830025025.3610-2-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--pOkYF4ZkALzC9oZ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 10:50:22PM -0400, Brian Song wrote:
> This patch adds a new export option for storage-export-daemon to enable
> FUSE-over-io_uring via the switch io-uring=3Don|off (disableby default).
> It also implements the protocol handshake with the Linux kernel
> during the FUSE-over-io_uring initialization phase.
>=20
> See: https://docs.kernel.org/filesystems/fuse-io-uring.html
>=20
> The kernel documentation describes in detail how FUSE-over-io_uring
> works. This patch implements the Initial SQE stage shown in thediagram:
> it initializes one queue per IOThread, each currently supporting a
> single submission queue entry (SQE). When the FUSE driver sends the
> first FUSE request (FUSE_INIT), storage-export-daemon calls
> fuse_uring_start() to complete initialization, ultimately submitting
> the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
> successful initialization with the kernel.
>=20
> We also added support for multiple IOThreads. The current Linux kernel
> requires registering $(nproc) queues when setting up FUSE-over-io_uring
> To let users customize the number of FUSE Queues (i.e., IOThreads),
> we first create nproc Ring Queues as required by the kernel, then
> distribute them in a round-robin manner to the FUSE Queues for
> registration. In addition, to support multiple in-flight requests,
> we configure each Ring Queue with FUSE_DEFAULT_RING_QUEUE_DEPTH
> entries/requests.

The previous paragraph says "each currently supporting a single
submission queue entry (SQE)" whereas this paragraph says "we configure
each Ring Queue with FUSE_DEFAULT_RING_QUEUE_DEPTH entries/requests".
Maybe this paragraph was squashed into the commit description in a later
step and the previous paragraph can be updated to reflect that multiple
SQEs are submitted?

>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>
> ---
>  block/export/fuse.c                  | 310 +++++++++++++++++++++++++--
>  docs/tools/qemu-storage-daemon.rst   |  11 +-
>  qapi/block-export.json               |   5 +-
>  storage-daemon/qemu-storage-daemon.c |   1 +
>  util/fdmon-io_uring.c                |   5 +-
>  5 files changed, 309 insertions(+), 23 deletions(-)
>=20
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index c0ad4696ce..19bf9e5f74 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -48,6 +48,9 @@
>  #include <linux/fs.h>
>  #endif
> =20
> +/* room needed in buffer to accommodate header */
> +#define FUSE_BUFFER_HEADER_SIZE 0x1000

Is it possible to write this in a way that shows how the constant is
calculated? That way the constant would automatically adjust on systems
where the underlying assumptions have changed (e.g. page size, header
struct size). This approach is also self-documenting so it's possible to
understand where the magic number comes from.

For example:

  #define FUSE_BUFFER_HEADER_SIZE DIV_ROUND_UP(sizeof(struct fuse_uring_req=
_header), qemu_real_host_page_size())

(I'm guessing what the formula you used is, so this example may be
incorrect...)

> +
>  /* Prevent overly long bounce buffer allocations */
>  #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024=
))
>  /*
> @@ -63,12 +66,59 @@
>      (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
> =20
>  typedef struct FuseExport FuseExport;
> +typedef struct FuseQueue FuseQueue;
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +#define FUSE_DEFAULT_RING_QUEUE_DEPTH 64
> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
> +
> +typedef struct FuseRingQueue FuseRingQueue;
> +typedef struct FuseRingEnt {
> +    /* back pointer */
> +    FuseRingQueue *rq;
> +
> +    /* commit id of a fuse request */
> +    uint64_t req_commit_id;

This field is not used in this commit. Please introduce it in the commit
that uses it so it's easier to review and understand the purpose of this
field.

> +
> +    /* fuse request header and payload */
> +    struct fuse_uring_req_header req_header;
> +    void *op_payload;
> +    size_t req_payload_sz;

op_payload and req_payload_sz refer to the same buffer, and they are
submitted alongside req_header. It would be nice to name the fields
consistently:

  struct fuse_uring_req_header req_header;
  void *req_payload;
  size_t req_payload_sz;

req_payload and req_payload_sz could be eliminated since they are also
stored in iov[1].iov_base and .iov_len. If you feel that would be harder
to understand, then it's okay to keep the duplicate fields.

> +
> +    /* The vector passed to the kernel */
> +    struct iovec iov[2];
> +
> +    CqeHandler fuse_cqe_handler;
> +} FuseRingEnt;
> +
> +struct FuseRingQueue {

A comment would be nice here to explain that the kernel requires one
FuseRingQueue per host CPU and this concept is independent of /dev/fuse
(FuseQueue).

> +    int rqid;
> +
> +    /* back pointer */
> +    FuseQueue *q;
> +    FuseRingEnt *ent;
> +
> +    /* List entry for ring_queues */
> +    QLIST_ENTRY(FuseRingQueue) next;
> +};
> +
> +/*
> + * Round-robin distribution of ring queues across FUSE queues.
> + * This structure manages the mapping between kernel ring queues and user
> + * FUSE queues.
> + */
> +typedef struct FuseRingQueueManager {
> +    FuseRingQueue *ring_queues;
> +    int num_ring_queues;
> +    int num_fuse_queues;
> +} FuseRingQueueManager;
> +#endif

It's easy to forget which #ifdef we're inside after a few lines, so it
helps to indicate that in a comment:

#endif /* CONFIG_LINUX_IO_URING */

> =20
>  /*
>   * One FUSE "queue", representing one FUSE FD from which requests are fe=
tched
>   * and processed.  Each queue is tied to an AioContext.
>   */
> -typedef struct FuseQueue {
> +struct FuseQueue {
>      FuseExport *exp;
> =20
>      AioContext *ctx;
> @@ -109,15 +159,11 @@ typedef struct FuseQueue {
>       * Free this buffer with qemu_vfree().
>       */
>      void *spillover_buf;
> -} FuseQueue;
> =20
> -/*
> - * Verify that FuseQueue.request_buf plus the spill-over buffer together
> - * are big enough to be accepted by the FUSE kernel driver.
> - */
> -QEMU_BUILD_BUG_ON(sizeof(((FuseQueue *)0)->request_buf) +
> -                  FUSE_SPILLOVER_BUF_SIZE <
> -                  FUSE_MIN_READ_BUFFER);

Why was this removed, it's probably still necessary in the non-io_uring
case (which is compiled in even when CONFIG_LINUX_IO_URING is defined)?

> +#ifdef CONFIG_LINUX_IO_URING
> +    QLIST_HEAD(, FuseRingQueue) ring_queue_list;
> +#endif
> +};
> =20
>  struct FuseExport {
>      BlockExport common;
> @@ -133,7 +179,7 @@ struct FuseExport {
>       */
>      bool halted;
> =20
> -    int num_queues;
> +    size_t num_queues;
>      FuseQueue *queues;
>      /*
>       * True if this export should follow the generic export's AioContext.
> @@ -149,6 +195,12 @@ struct FuseExport {
>      /* Whether allow_other was used as a mount option or not */
>      bool allow_other;
> =20
> +#ifdef CONFIG_LINUX_IO_URING
> +    bool is_uring;
> +    size_t ring_queue_depth;
> +    FuseRingQueueManager *ring_queue_manager;
> +#endif
> +
>      mode_t st_mode;
>      uid_t st_uid;
>      gid_t st_gid;
> @@ -205,7 +257,7 @@ static void fuse_attach_handlers(FuseExport *exp)
>          return;
>      }
> =20
> -    for (int i =3D 0; i < exp->num_queues; i++) {
> +    for (size_t i =3D 0; i < exp->num_queues; i++) {
>          aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
>                             read_from_fuse_fd, NULL, NULL, NULL,
>                             &exp->queues[i]);
> @@ -257,6 +309,189 @@ static const BlockDevOps fuse_export_blk_dev_ops =
=3D {
>      .drained_poll  =3D fuse_export_drained_poll,
>  };
> =20
> +#ifdef CONFIG_LINUX_IO_URING
> +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
> +                    const unsigned int rqid,
> +                    const unsigned int commit_id)
> +{
> +    req->qid =3D rqid;
> +    req->commit_id =3D commit_id;
> +    req->flags =3D 0;
> +}
> +
> +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *=
q,
> +               __u32 cmd_op)
> +{
> +    sqe->opcode =3D IORING_OP_URING_CMD;
> +
> +    sqe->fd =3D q->fuse_fd;
> +    sqe->rw_flags =3D 0;
> +    sqe->ioprio =3D 0;
> +    sqe->off =3D 0;
> +
> +    sqe->cmd_op =3D cmd_op;
> +    sqe->__pad1 =3D 0;
> +}
> +
> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void =
*opaque)
> +{
> +    FuseRingEnt *ent =3D opaque;
> +    struct fuse_uring_cmd_req *req =3D (void *)&sqe->cmd[0];
> +
> +    fuse_uring_sqe_prepare(sqe, ent->rq->q, FUSE_IO_URING_CMD_REGISTER);
> +
> +    sqe->addr =3D (uint64_t)(ent->iov);
> +    sqe->len =3D 2;
> +
> +    fuse_uring_sqe_set_req_data(req, ent->rq->rqid, 0);
> +}
> +
> +static void fuse_uring_submit_register(void *opaque)
> +{
> +    FuseRingEnt *ent =3D opaque;
> +    FuseExport *exp =3D ent->rq->q->exp;

This variable is unused in this commit? Does this commit compile for
you? Usually the compiler warns about unused variables.

> +
> +
> +    aio_add_sqe(fuse_uring_prep_sqe_register, ent, &(ent->fuse_cqe_handl=
er));
> +}
> +
> +/**
> + * Distribute ring queues across FUSE queues using round-robin algorithm.
> + * This ensures even distribution of kernel ring queues across user-spec=
ified
> + * FUSE queues.
> + */
> +static
> +FuseRingQueueManager *fuse_ring_queue_manager_create(int num_fuse_queues,
> +                                                    size_t ring_queue_de=
pth,
> +                                                    size_t bufsize)
> +{
> +    int num_ring_queues =3D get_nprocs();

The kernel code uses num_possible_cpus() in
fs/fuse/dev_uring.c:fuse_uring_create() so I think this should be
get_nprocs_conf() instead of get_nprocs().

> +    FuseRingQueueManager *manager =3D g_new(FuseRingQueueManager, 1);
> +
> +    if (!manager) {

g_new() never returns NULL, so you can remove this if statement. If
memory cannot be allocated then the process will abort.

> +        return NULL;
> +    }
> +
> +    manager->ring_queues =3D g_new(FuseRingQueue, num_ring_queues);
> +    manager->num_ring_queues =3D num_ring_queues;
> +    manager->num_fuse_queues =3D num_fuse_queues;
> +
> +    if (!manager->ring_queues) {

Same here.

> +        g_free(manager);
> +        return NULL;
> +    }
> +
> +    for (int i =3D 0; i < num_ring_queues; i++) {
> +        FuseRingQueue *rq =3D &manager->ring_queues[i];
> +        rq->rqid =3D i;
> +        rq->ent =3D g_new(FuseRingEnt, ring_queue_depth);
> +
> +        if (!rq->ent) {

Same here.

> +            for (int j =3D 0; j < i; j++) {
> +                g_free(manager->ring_queues[j].ent);
> +            }
> +            g_free(manager->ring_queues);
> +            g_free(manager);
> +            return NULL;
> +        }
> +
> +        for (size_t j =3D 0; j < ring_queue_depth; j++) {
> +            FuseRingEnt *ent =3D &rq->ent[j];
> +            ent->rq =3D rq;
> +            ent->req_payload_sz =3D bufsize - FUSE_BUFFER_HEADER_SIZE;
> +            ent->op_payload =3D g_malloc0(ent->req_payload_sz);
> +
> +            if (!ent->op_payload) {

Same here.

> +                for (size_t k =3D 0; k < j; k++) {
> +                    g_free(rq->ent[k].op_payload);
> +                }
> +                g_free(rq->ent);
> +                for (int k =3D 0; k < i; k++) {
> +                    g_free(manager->ring_queues[k].ent);
> +                }
> +                g_free(manager->ring_queues);
> +                g_free(manager);

Where are these structures freed in the normal lifecycle of a FUSE
export? I only see this error handling code, but nothing is freed when
the export is shut down.

> +                return NULL;
> +            }
> +
> +            ent->iov[0] =3D (struct iovec) {
> +                &(ent->req_header),
> +                sizeof(struct fuse_uring_req_header)
> +            };
> +            ent->iov[1] =3D (struct iovec) {
> +                ent->op_payload,
> +                ent->req_payload_sz
> +            };
> +
> +            ent->fuse_cqe_handler.cb =3D fuse_uring_cqe_handler;
> +        }
> +    }
> +
> +    return manager;
> +}
> +
> +static
> +void fuse_distribute_ring_queues(FuseExport *exp, FuseRingQueueManager *=
manager)
> +{
> +    int queue_index =3D 0;
> +
> +    for (int i =3D 0; i < manager->num_ring_queues; i++) {
> +        FuseRingQueue *rq =3D &manager->ring_queues[i];
> +
> +        rq->q =3D &exp->queues[queue_index];
> +        QLIST_INSERT_HEAD(&(rq->q->ring_queue_list), rq, next);
> +
> +        queue_index =3D (queue_index + 1) % manager->num_fuse_queues;
> +    }
> +}
> +
> +static
> +void fuse_schedule_ring_queue_registrations(FuseExport *exp,
> +                                            FuseRingQueueManager *manage=
r)
> +{
> +    for (int i =3D 0; i < manager->num_fuse_queues; i++) {
> +        FuseQueue *q =3D &exp->queues[i];
> +        FuseRingQueue *rq;
> +
> +        QLIST_FOREACH(rq, &q->ring_queue_list, next) {
> +            for (int j =3D 0; j < exp->ring_queue_depth; j++) {
> +                aio_bh_schedule_oneshot(q->ctx, fuse_uring_submit_regist=
er,
> +                                        &(rq->ent[j]));
> +            }
> +        }
> +    }
> +}
> +
> +static void fuse_uring_start(FuseExport *exp, struct fuse_init_out *out)
> +{
> +    /*
> +     * Since we didn't enable the FUSE_MAX_PAGES feature, the value of
> +     * fc->max_pages should be FUSE_DEFAULT_MAX_PAGES_PER_REQ, which is =
set by
> +     * the kernel by default. Also, max_write should not exceed
> +     * FUSE_DEFAULT_MAX_PAGES_PER_REQ * PAGE_SIZE.
> +     */
> +    size_t bufsize =3D out->max_write + FUSE_BUFFER_HEADER_SIZE;
> +
> +    if (!(out->flags & FUSE_MAX_PAGES)) {
> +        bufsize =3D FUSE_DEFAULT_MAX_PAGES_PER_REQ * qemu_real_host_page=
_size()
> +                         + FUSE_BUFFER_HEADER_SIZE;
> +    }
> +
> +    exp->ring_queue_manager =3D fuse_ring_queue_manager_create(
> +        exp->num_queues, exp->ring_queue_depth, bufsize);
> +
> +    if (!exp->ring_queue_manager) {
> +        error_report("Failed to create ring queue manager");
> +        return;
> +    }
> +
> +    /* Distribute ring queues across FUSE queues using round-robin */
> +    fuse_distribute_ring_queues(exp, exp->ring_queue_manager);
> +
> +    fuse_schedule_ring_queue_registrations(exp, exp->ring_queue_manager);
> +}
> +#endif
> +
>  static int fuse_export_create(BlockExport *blk_exp,
>                                BlockExportOptions *blk_exp_args,
>                                AioContext *const *multithread,
> @@ -270,6 +505,11 @@ static int fuse_export_create(BlockExport *blk_exp,
> =20
>      assert(blk_exp_args->type =3D=3D BLOCK_EXPORT_TYPE_FUSE);
> =20
> +#ifdef CONFIG_LINUX_IO_URING
> +    exp->is_uring =3D args->io_uring;
> +    exp->ring_queue_depth =3D FUSE_DEFAULT_RING_QUEUE_DEPTH;
> +#endif
> +
>      if (multithread) {
>          /* Guaranteed by common export code */
>          assert(mt_count >=3D 1);
> @@ -283,6 +523,10 @@ static int fuse_export_create(BlockExport *blk_exp,
>                  .exp =3D exp,
>                  .ctx =3D multithread[i],
>                  .fuse_fd =3D -1,
> +#ifdef CONFIG_LINUX_IO_URING
> +                .ring_queue_list =3D
> +                    QLIST_HEAD_INITIALIZER(exp->queues[i].ring_queue_lis=
t),
> +#endif
>              };
>          }
>      } else {
> @@ -296,6 +540,10 @@ static int fuse_export_create(BlockExport *blk_exp,
>              .exp =3D exp,
>              .ctx =3D exp->common.ctx,
>              .fuse_fd =3D -1,
> +#ifdef CONFIG_LINUX_IO_URING
> +            .ring_queue_list =3D
> +                QLIST_HEAD_INITIALIZER(exp->queues[0].ring_queue_list),
> +#endif
>          };
>      }
> =20
> @@ -685,17 +933,39 @@ static bool is_regular_file(const char *path, Error=
 **errp)
>   */
>  static ssize_t coroutine_fn
>  fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
> -             uint32_t max_readahead, uint32_t flags)
> +             uint32_t max_readahead, const struct fuse_init_in *in)
>  {
> -    const uint32_t supported_flags =3D FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
> +    uint64_t supported_flags =3D FUSE_ASYNC_READ | FUSE_ASYNC_DIO
> +                                     | FUSE_INIT_EXT;
> +    uint64_t outargflags =3D 0;
> +    uint64_t inargflags =3D in->flags;
> +
> +    ssize_t ret =3D 0;
> +
> +    if (inargflags & FUSE_INIT_EXT) {
> +        inargflags =3D inargflags | (uint64_t) in->flags2 << 32;
> +    }
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (exp->is_uring) {
> +        if (inargflags & FUSE_OVER_IO_URING) {
> +            supported_flags |=3D FUSE_OVER_IO_URING;
> +        } else {
> +            exp->is_uring =3D false;
> +            ret =3D -ENODEV;
> +        }
> +    }
> +#endif
> +
> +    outargflags =3D inargflags & supported_flags;
> =20
>      *out =3D (struct fuse_init_out) {
>          .major =3D FUSE_KERNEL_VERSION,
>          .minor =3D FUSE_KERNEL_MINOR_VERSION,
>          .max_readahead =3D max_readahead,
>          .max_write =3D FUSE_MAX_WRITE_BYTES,
> -        .flags =3D flags & supported_flags,
> -        .flags2 =3D 0,
> +        .flags =3D outargflags,
> +        .flags2 =3D outargflags >> 32,
> =20
>          /* libfuse maximum: 2^16 - 1 */
>          .max_background =3D UINT16_MAX,
> @@ -717,7 +987,7 @@ fuse_co_init(FuseExport *exp, struct fuse_init_out *o=
ut,
>          .map_alignment =3D 0,
>      };
> =20
> -    return sizeof(*out);
> +    return ret < 0 ? ret : sizeof(*out);
>  }
> =20
>  /**
> @@ -1506,6 +1776,14 @@ fuse_co_process_request(FuseQueue *q, void *spillo=
ver_buf)
>          fuse_write_buf_response(q->fuse_fd, req_id, out_hdr,
>                                  out_data_buffer, ret);
>          qemu_vfree(out_data_buffer);
> +#ifdef CONFIG_LINUX_IO_URING
> +    /* Handle FUSE-over-io_uring initialization */
> +    if (unlikely(opcode =3D=3D FUSE_INIT && exp->is_uring)) {
> +        struct fuse_init_out *out =3D
> +            (struct fuse_init_out *)FUSE_OUT_OP_STRUCT(out_buf);
> +        fuse_uring_start(exp, out);

Is there any scenario where FUSE_INIT can be received multiple times?
Maybe if the FUSE file system is umounted and mounted again? I want to
check that this doesn't leak previously allocated ring state.

> +    }
> +#endif
>      } else {
>          fuse_write_response(q->fuse_fd, req_id, out_hdr,
>                              ret < 0 ? ret : 0,
> diff --git a/docs/tools/qemu-storage-daemon.rst b/docs/tools/qemu-storage=
-daemon.rst
> index 35ab2d7807..c5076101e0 100644
> --- a/docs/tools/qemu-storage-daemon.rst
> +++ b/docs/tools/qemu-storage-daemon.rst
> @@ -78,7 +78,7 @@ Standard options:
>  .. option:: --export [type=3D]nbd,id=3D<id>,node-name=3D<node-name>[,nam=
e=3D<export-name>][,writable=3Don|off][,bitmap=3D<name>]
>    --export [type=3D]vhost-user-blk,id=3D<id>,node-name=3D<node-name>,add=
r.type=3Dunix,addr.path=3D<socket-path>[,writable=3Don|off][,logical-block-=
size=3D<block-size>][,num-queues=3D<num-queues>]
>    --export [type=3D]vhost-user-blk,id=3D<id>,node-name=3D<node-name>,add=
r.type=3Dfd,addr.str=3D<fd>[,writable=3Don|off][,logical-block-size=3D<bloc=
k-size>][,num-queues=3D<num-queues>]
> -  --export [type=3D]fuse,id=3D<id>,node-name=3D<node-name>,mountpoint=3D=
<file>[,growable=3Don|off][,writable=3Don|off][,allow-other=3Don|off|auto]
> +  --export [type=3D]fuse,id=3D<id>,node-name=3D<node-name>,mountpoint=3D=
<file>[,growable=3Don|off][,writable=3Don|off][,allow-other=3Don|off|auto][=
,io-uring=3Don|off]
>    --export [type=3D]vduse-blk,id=3D<id>,node-name=3D<node-name>,name=3D<=
vduse-name>[,writable=3Don|off][,num-queues=3D<num-queues>][,queue-size=3D<=
queue-size>][,logical-block-size=3D<block-size>][,serial=3D<serial-number>]
> =20
>    is a block export definition. ``node-name`` is the block node that sho=
uld be
> @@ -111,10 +111,11 @@ Standard options:
>    that enabling this option as a non-root user requires enabling the
>    user_allow_other option in the global fuse.conf configuration file.  S=
etting
>    ``allow-other`` to auto (the default) will try enabling this option, a=
nd on
> -  error fall back to disabling it.
> -
> -  The ``vduse-blk`` export type takes a ``name`` (must be unique across =
the host)
> -  to create the VDUSE device.
> +  error fall back to disabling it. Once ``io-uring`` is enabled (off by =
default),
> +  the FUSE-over-io_uring-related settings will be initialized to bypass =
the
> +  traditional /dev/fuse communication mechanism and instead use io_uring=
 to
> +  handle FUSE operations. The ``vduse-blk`` export type takes a ``name``
> +  (must be unique across the host) to create the VDUSE device.
>    ``num-queues`` sets the number of virtqueues (the default is 1).
>    ``queue-size`` sets the virtqueue descriptor table size (the default i=
s 256).
> =20
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 9ae703ad01..37f2fc47e2 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -184,12 +184,15 @@
>  #     mount the export with allow_other, and if that fails, try again
>  #     without.  (since 6.1; default: auto)
>  #
> +# @io-uring: Use FUSE-over-io-uring.  (since 10.2; default: false)
> +#
>  # Since: 6.0
>  ##
>  { 'struct': 'BlockExportOptionsFuse',
>    'data': { 'mountpoint': 'str',
>              '*growable': 'bool',
> -            '*allow-other': 'FuseExportAllowOther' },
> +            '*allow-other': 'FuseExportAllowOther',
> +            '*io-uring': 'bool' },
>    'if': 'CONFIG_FUSE' }
> =20
>  ##
> diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-s=
torage-daemon.c
> index eb72561358..0cd4cd2b58 100644
> --- a/storage-daemon/qemu-storage-daemon.c
> +++ b/storage-daemon/qemu-storage-daemon.c
> @@ -107,6 +107,7 @@ static void help(void)
>  #ifdef CONFIG_FUSE
>  "  --export [type=3D]fuse,id=3D<id>,node-name=3D<node-name>,mountpoint=
=3D<file>\n"
>  "           [,growable=3Don|off][,writable=3Don|off][,allow-other=3Don|o=
ff|auto]\n"
> +"           [,io-uring=3Don|off]"
>  "                         export the specified block node over FUSE\n"
>  "\n"
>  #endif /* CONFIG_FUSE */
> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> index d2433d1d99..68d3fe8e01 100644
> --- a/util/fdmon-io_uring.c
> +++ b/util/fdmon-io_uring.c
> @@ -452,10 +452,13 @@ static const FDMonOps fdmon_io_uring_ops =3D {
>  void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
>  {
>      int ret;
> +    int flags;
> =20
>      ctx->io_uring_fd_tag =3D NULL;
> +    flags =3D IORING_SETUP_SQE128;

Please add /* needed by FUSE-over-io_uring */ so it's clear who the user
is.

> =20
> -    ret =3D io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_u=
ring, 0);
> +    ret =3D io_uring_queue_init(FDMON_IO_URING_ENTRIES,
> +                            &ctx->fdmon_io_uring, flags);
>      if (ret !=3D 0) {
>          error_setg_errno(errp, -ret, "Failed to initialize io_uring");
>          return;
> --=20
> 2.45.2
>=20

--pOkYF4ZkALzC9oZ7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmi4HiUACgkQnKSrs4Gr
c8j+MggAhboG/RRwa0kbO2XgCrORif80xENZIj1WJpls+TuU7q/QhvPPlUehD2Yr
sWye/EWgVP1+QcBy3b6LQbODTktWJil7Op866bYTqCbs8d5utzpOMu/3umu8vzCb
Lyec6nq89yBRi31Qtnq6m5v1oBOF0QFGaagTVlBpKvE7hLKBVfyqBGgoLDPmoJlU
Fzjubw3OaKBI+4QXcZIzoTsPcZfBeREIV9qqW5hHvnBRgPeVK6UocQ9qsJidMUlS
WdX2W0JJwUfo/J41LCMsfMq8LmKTQ3MASSAlDX2pk2N3t15XA6IjQJ/ykf6uJcgx
k/v0lxuA3dBepoCpeOAk6exzfjiNxg==
=GdJ/
-----END PGP SIGNATURE-----

--pOkYF4ZkALzC9oZ7--


