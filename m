Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C9EC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 12:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udpns-0006Ou-T2; Mon, 21 Jul 2025 08:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udpnl-0005Vc-OP
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 08:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udpng-0004FW-S0
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 08:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753101563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6vTgkmv9dKRn73Bd1GVCdnpgFQshx6c7JC7ssUgTZsI=;
 b=HLZm7AIksaTJV6F0Ns8EuR90YRoh2leV4WVuL5RAEd8cLhgra7oHX9/Ub4hnoZFopIMdHQ
 6HoXx9TfhsjVYb6gmlTkx5rhPiVTNoGY4fw0Kh9BD9WpDLw/1EiH53g3NeDeDU+P+VffEr
 kMjlNDKRLgqAxesRVTNtK1QJZr2wlyo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-KlUWViC3NdGjLrvVv4vhfQ-1; Mon,
 21 Jul 2025 08:39:21 -0400
X-MC-Unique: KlUWViC3NdGjLrvVv4vhfQ-1
X-Mimecast-MFC-AGG-ID: KlUWViC3NdGjLrvVv4vhfQ_1753101560
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A19D41956080; Mon, 21 Jul 2025 12:39:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C436918002AF; Mon, 21 Jul 2025 12:39:19 +0000 (UTC)
Date: Sun, 20 Jul 2025 20:53:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bschubert@ddn.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for
 QEMU FUSE Exports
Message-ID: <20250721005346.GB32887@fedora>
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250716183824.216257-2-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SyVFkGfT6WI1YWU3"
Content-Disposition: inline
In-Reply-To: <20250716183824.216257-2-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.926, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--SyVFkGfT6WI1YWU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 02:38:24PM -0400, Brian Song wrote:
> This work provides an initial implementation of fuse-over-io_uring
> support for QEMU export. According to the fuse-over-io_uring protocol
> specification, the userspace side must create the same number of queues
> as the number of CPUs (nr_cpu), just like the kernel. Currently, each
> queue contains only a single SQE entry, which is used to validate the
> correctness of the fuse-over-io_uring functionality.
>=20
> All FUSE read and write operations interact with the kernel via io
> vectors embedded in the SQE entry during submission and CQE fetching.
> The req_header and op_payload members of each entry are included as
> parts of the io vector: req_header carries the FUSE operation header,
> and op_payload carries the data payload, such as file attributes in a
> getattr reply, file content in a read reply, or file content being
> written to the FUSE client in a write operation.
>=20
> At present, multi-threading support is still incomplete. In addition,
> handling connection termination and managing the "drained" state of a
> FUSE block export in QEMU remain as pending work.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>
>=20
> ---
>  block/export/fuse.c                  | 423 +++++++++++++++++++++++++--
>  docs/tools/qemu-storage-daemon.rst   |  10 +-
>  qapi/block-export.json               |   6 +-
>  storage-daemon/qemu-storage-daemon.c |   1 +
>  util/fdmon-io_uring.c                |   5 +-
>  5 files changed, 420 insertions(+), 25 deletions(-)

Here is feedback from a first pass over this patch.

>=20
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index c0ad4696ce..637d36186a 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -48,6 +48,11 @@
>  #include <linux/fs.h>
>  #endif
> =20
> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
> +
> +/* room needed in buffer to accommodate header */
> +#define FUSE_BUFFER_HEADER_SIZE 0x1000
> +
>  /* Prevent overly long bounce buffer allocations */
>  #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024=
))
>  /*
> @@ -64,6 +69,26 @@
> =20
>  typedef struct FuseExport FuseExport;
> =20
> +struct FuseQueue;

Use "typedef struct FuseQueue FuseQueue;" here...

> +
> +typedef struct FuseRingEnt {
> +    /* back pointer */
> +    struct FuseQueue *q;

=2E..and then this can be "FuseQueue *q;" so that QEMU coding style is
followed.

> +
> +    /* commit id of a fuse request */
> +    uint64_t req_commit_id;
> +
> +    /* fuse request header and payload */
> +    struct fuse_uring_req_header *req_header;
> +    void *op_payload;
> +    size_t req_payload_sz;
> +
> +    /* The vector passed to the kernel */
> +    struct iovec iov[2];
> +
> +    CqeHandler fuse_cqe_handler;
> +} FuseRingEnt;
> +
>  /*
>   * One FUSE "queue", representing one FUSE FD from which requests are fe=
tched
>   * and processed.  Each queue is tied to an AioContext.
> @@ -73,6 +98,7 @@ typedef struct FuseQueue {
> =20
>      AioContext *ctx;
>      int fuse_fd;
> +    int qid;

Could this go inside #ifdef CONFIG_LINUX_IO_URING? It seems to be
specific to FUSE-over-io_uring.

> =20
>      /*
>       * The request buffer must be able to hold a full write, and/or at l=
east
> @@ -109,6 +135,17 @@ typedef struct FuseQueue {
>       * Free this buffer with qemu_vfree().
>       */
>      void *spillover_buf;
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +    FuseRingEnt ent;
> +
> +    /*
> +     * TODO
> +     * Support multi-threaded FUSE over io_uring by using eventfd and al=
locating
> +     * an extra SQE for each thread to be notified when the connection
> +     * shuts down.
> +     */

eventfd and the extra SQE won't be necessary because
aio_bh_schedule_oneshot() can be used to cause threads to execute a
function.

(I think this comment effectively says that connection shutdown still
needs to be implemented. The implementation details don't matter at this
point.)

> +#endif
>  } FuseQueue;
> =20
>  /*
> @@ -148,6 +185,7 @@ struct FuseExport {
>      bool growable;
>      /* Whether allow_other was used as a mount option or not */
>      bool allow_other;
> +    bool is_uring;
> =20
>      mode_t st_mode;
>      uid_t st_uid;
> @@ -257,6 +295,126 @@ static const BlockDevOps fuse_export_blk_dev_ops =
=3D {
>      .drained_poll  =3D fuse_export_drained_poll,
>  };
> =20
> +#ifdef CONFIG_LINUX_IO_URING
> +static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *ent);
> +
> +static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)
> +{
> +    CqeHandler *cqe_handler =3D opaque;
> +    FuseRingEnt *ent =3D container_of(cqe_handler, FuseRingEnt, fuse_cqe=
_handler);

Passing ent in opaque instead of cqe_handler would simplify this.

> +    FuseExport *exp =3D ent->q->exp;
> +
> +    fuse_uring_co_process_request(ent);
> +
> +    fuse_dec_in_flight(exp);
> +}
> +
> +static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
> +{
> +    FuseRingEnt *ent =3D container_of(cqe_handler, FuseRingEnt, fuse_cqe=
_handler);
> +    FuseQueue *q =3D ent->q;
> +    Coroutine *co;
> +    FuseExport *exp =3D ent->q->exp;
> +
> +    int err =3D cqe_handler->cqe.res;
> +    if (err !=3D 0) {
> +        /* TODO end_conn support */
> +
> +        /* -ENOTCONN is ok on umount  */
> +        if (err !=3D -EINTR && err !=3D -EOPNOTSUPP &&
> +            err !=3D -EAGAIN && err !=3D -ENOTCONN) {
> +            fuse_export_halt(exp);
> +        }
> +    } else {
> +        co =3D qemu_coroutine_create(co_fuse_uring_queue_handle_cqes,
> +                            cqe_handler);
> +        /* Decremented by co_fuse_uring_queue_handle_cqes() */
> +        fuse_inc_in_flight(q->exp);

Can this be moved inside co_fuse_uring_queue_handle_cqes() to avoid
calling inc/dec from different functions? That would make the code
easier to understand and more robust against future bugs.

> +        qemu_coroutine_enter(co);
> +    }
> +}
> +
> +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
> +                    const unsigned int qid,
> +                    const unsigned int commit_id)
> +{
> +    req->qid =3D qid;
> +    req->commit_id =3D commit_id;
> +    req->flags =3D 0;
> +}
> +
> +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseRingEnt=
 *ent,
> +               __u32 cmd_op)
> +{
> +    sqe->opcode =3D IORING_OP_URING_CMD;
> +
> +    sqe->fd =3D ent->q->fuse_fd;
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
> +    FuseQueue *q =3D opaque;
> +    struct fuse_uring_cmd_req *req =3D (void *)&sqe->cmd[0];
> +
> +    fuse_uring_sqe_prepare(sqe, &q->ent, FUSE_IO_URING_CMD_REGISTER);
> +
> +    sqe->addr =3D (uint64_t)(q->ent.iov);
> +    sqe->len =3D 2;
> +
> +    fuse_uring_sqe_set_req_data(req, q->qid, 0);
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
> +        /*
> +         * bufsize =3D MIN(FUSE_DEFAULT_MAX_PAGES_PER_REQ *
> +         *       qemu_real_host_page_size() + FUSE_BUFFER_HEADER_SIZE, b=
ufsize);
> +         */
> +        bufsize =3D FUSE_DEFAULT_MAX_PAGES_PER_REQ * qemu_real_host_page=
_size()
> +                         + FUSE_BUFFER_HEADER_SIZE;
> +    }
> +
> +    for (int i =3D 0; i < exp->num_queues; i++) {
> +        FuseQueue *q =3D &exp->queues[i];
> +
> +        q->ent.q =3D q;
> +
> +        q->ent.req_header =3D g_malloc0(sizeof(struct fuse_uring_req_hea=
der));

It's probably easier to embed the header as a FuseRingEnt field instead
of heap allocating it.

> +        q->ent.req_payload_sz =3D bufsize - FUSE_BUFFER_HEADER_SIZE;
> +        q->ent.op_payload =3D g_malloc0(q->ent.req_payload_sz);


> +
> +        q->ent.iov[0] =3D (struct iovec) {
> +            q->ent.req_header,
> +            sizeof(struct fuse_uring_req_header)
> +        };
> +        q->ent.iov[1] =3D (struct iovec) {
> +            q->ent.op_payload,
> +            q->ent.req_payload_sz
> +        };
> +
> +        exp->queues[i].ent.fuse_cqe_handler.cb =3D fuse_uring_cqe_handle=
r;
> +
> +        aio_add_sqe(fuse_uring_prep_sqe_register, &(exp->queues[i]),
> +            &(exp->queues[i].ent.fuse_cqe_handler));
> +    }
> +}
> +#endif
> +
>  static int fuse_export_create(BlockExport *blk_exp,
>                                BlockExportOptions *blk_exp_args,
>                                AioContext *const *multithread,
> @@ -280,6 +438,7 @@ static int fuse_export_create(BlockExport *blk_exp,
> =20
>          for (size_t i =3D 0; i < mt_count; i++) {
>              exp->queues[i] =3D (FuseQueue) {
> +                .qid =3D i,
>                  .exp =3D exp,
>                  .ctx =3D multithread[i],
>                  .fuse_fd =3D -1,
> @@ -293,6 +452,7 @@ static int fuse_export_create(BlockExport *blk_exp,
>          exp->num_queues =3D 1;
>          exp->queues =3D g_new(FuseQueue, 1);
>          exp->queues[0] =3D (FuseQueue) {
> +            .qid =3D 0,
>              .exp =3D exp,
>              .ctx =3D exp->common.ctx,
>              .fuse_fd =3D -1,
> @@ -312,6 +472,8 @@ static int fuse_export_create(BlockExport *blk_exp,
>          }
>      }
> =20
> +    exp->is_uring =3D args->uring ? true : false;
> +
>      blk_set_dev_ops(exp->common.blk, &fuse_export_blk_dev_ops, exp);
> =20
>      /*
> @@ -597,6 +759,22 @@ static void read_from_fuse_fd(void *opaque)
>      qemu_coroutine_enter(co);
>  }
> =20
> +#ifdef CONFIG_LINUX_IO_URING
> +static void fuse_export_delete_uring(FuseExport *exp)
> +{
> +    exp->is_uring =3D false;
> +
> +    /*
> +     * TODO
> +     * end_conn handling
> +     */
> +    for (size_t qid =3D 0; qid < exp->num_queues; qid++) {
> +        g_free(exp->queues[qid].ent.req_header);
> +        g_free(exp->queues[qid].ent.op_payload);
> +    }
> +}
> +#endif
> +
>  static void fuse_export_shutdown(BlockExport *blk_exp)
>  {
>      FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
> @@ -618,6 +796,11 @@ static void fuse_export_delete(BlockExport *blk_exp)
>  {
>      FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
> =20
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (exp->is_uring)
> +        fuse_export_delete_uring(exp);
> +#endif
> +
>      for (int i =3D 0; i < exp->num_queues; i++) {
>          FuseQueue *q =3D &exp->queues[i];
> =20
> @@ -687,15 +870,22 @@ static ssize_t coroutine_fn
>  fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
>               uint32_t max_readahead, uint32_t flags)
>  {
> -    const uint32_t supported_flags =3D FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
> +    const uint32_t supported_flags =3D FUSE_ASYNC_READ | FUSE_ASYNC_DIO
> +                                     | FUSE_INIT_EXT;
> +    uint64_t outargflags =3D flags;
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (exp->is_uring)
> +        outargflags |=3D FUSE_OVER_IO_URING;
> +#endif
> =20
>      *out =3D (struct fuse_init_out) {
>          .major =3D FUSE_KERNEL_VERSION,
>          .minor =3D FUSE_KERNEL_MINOR_VERSION,
>          .max_readahead =3D max_readahead,
>          .max_write =3D FUSE_MAX_WRITE_BYTES,
> -        .flags =3D flags & supported_flags,
> -        .flags2 =3D 0,
> +        .flags =3D outargflags & supported_flags,
> +        .flags2 =3D outargflags >> 32,
> =20
>          /* libfuse maximum: 2^16 - 1 */
>          .max_background =3D UINT16_MAX,
> @@ -943,6 +1133,9 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_=
t offset, uint32_t size)
>   * Data in @in_place_buf is assumed to be overwritten after yielding, so=
 will
>   * be copied to a bounce buffer beforehand.  @spillover_buf in contrast =
is
>   * assumed to be exclusively owned and will be used as-is.
> + * In FUSE-over-io_uring mode, the actual op_payload content is stored in
> + * @spillover_buf. To ensure this buffer is used for writing, @in_place_=
buf
> + * is explicitly set to NULL.
>   * Return the number of bytes written to *out on success, and -errno on =
error.
>   */
>  static ssize_t coroutine_fn
> @@ -950,8 +1143,8 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out=
 *out,
>                uint64_t offset, uint32_t size,
>                const void *in_place_buf, const void *spillover_buf)
>  {
> -    size_t in_place_size;
> -    void *copied;
> +    size_t in_place_size =3D 0;
> +    void *copied =3D NULL;
>      int64_t blk_len;
>      int ret;
>      struct iovec iov[2];
> @@ -966,10 +1159,12 @@ fuse_co_write(FuseExport *exp, struct fuse_write_o=
ut *out,
>          return -EACCES;
>      }
> =20
> -    /* Must copy to bounce buffer before potentially yielding */
> -    in_place_size =3D MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
> -    copied =3D blk_blockalign(exp->common.blk, in_place_size);
> -    memcpy(copied, in_place_buf, in_place_size);
> +    if (in_place_buf) {
> +        /* Must copy to bounce buffer before potentially yielding */
> +        in_place_size =3D MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
> +        copied =3D blk_blockalign(exp->common.blk, in_place_size);
> +        memcpy(copied, in_place_buf, in_place_size);
> +    }
> =20
>      /**
>       * Clients will expect short writes at EOF, so we have to limit
> @@ -993,26 +1188,37 @@ fuse_co_write(FuseExport *exp, struct fuse_write_o=
ut *out,
>          }
>      }
> =20
> -    iov[0] =3D (struct iovec) {
> -        .iov_base =3D copied,
> -        .iov_len =3D in_place_size,
> -    };
> -    if (size > FUSE_IN_PLACE_WRITE_BYTES) {
> -        assert(size - FUSE_IN_PLACE_WRITE_BYTES <=3D FUSE_SPILLOVER_BUF_=
SIZE);
> -        iov[1] =3D (struct iovec) {
> -            .iov_base =3D (void *)spillover_buf,
> -            .iov_len =3D size - FUSE_IN_PLACE_WRITE_BYTES,
> +    if (in_place_buf) {
> +        iov[0] =3D (struct iovec) {
> +            .iov_base =3D copied,
> +            .iov_len =3D in_place_size,
>          };
> -        qemu_iovec_init_external(&qiov, iov, 2);
> +        if (size > FUSE_IN_PLACE_WRITE_BYTES) {
> +            assert(size - FUSE_IN_PLACE_WRITE_BYTES <=3D FUSE_SPILLOVER_=
BUF_SIZE);
> +            iov[1] =3D (struct iovec) {
> +                .iov_base =3D (void *)spillover_buf,
> +                .iov_len =3D size - FUSE_IN_PLACE_WRITE_BYTES,
> +            };
> +            qemu_iovec_init_external(&qiov, iov, 2);
> +        } else {
> +            qemu_iovec_init_external(&qiov, iov, 1);
> +        }
>      } else {
> +        /* fuse over io_uring */
> +        iov[0] =3D (struct iovec) {
> +            .iov_base =3D (void *)spillover_buf,
> +            .iov_len =3D size,
> +        };
>          qemu_iovec_init_external(&qiov, iov, 1);
>      }
> +
>      ret =3D blk_co_pwritev(exp->common.blk, offset, size, &qiov, 0);
>      if (ret < 0) {
>          goto fail_free_buffer;
>      }
> =20
> -    qemu_vfree(copied);
> +    if (in_place_buf)
> +        qemu_vfree(copied);
> =20
>      *out =3D (struct fuse_write_out) {
>          .size =3D size,
> @@ -1020,7 +1226,9 @@ fuse_co_write(FuseExport *exp, struct fuse_write_ou=
t *out,
>      return sizeof(*out);
> =20
>  fail_free_buffer:
> -    qemu_vfree(copied);
> +    if (in_place_buf) {
> +        qemu_vfree(copied);
> +    }
>      return ret;
>  }
> =20
> @@ -1409,6 +1617,12 @@ fuse_co_process_request(FuseQueue *q, void *spillo=
ver_buf)
>          const struct fuse_init_in *in =3D FUSE_IN_OP_STRUCT(init, q);
>          ret =3D fuse_co_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
>                             in->max_readahead, in->flags);
> +#ifdef CONFIG_LINUX_IO_URING
> +        /* Set up fuse over io_uring after replying to the first FUSE_IN=
IT */
> +        if (exp->is_uring) {
> +            fuse_uring_start(exp, FUSE_OUT_OP_STRUCT(init, out_buf));
> +        }
> +#endif
>          break;
>      }
> =20
> @@ -1515,6 +1729,173 @@ fuse_co_process_request(FuseQueue *q, void *spill=
over_buf)
>      qemu_vfree(spillover_buf);
>  }
> =20
> +#ifdef CONFIG_LINUX_IO_URING
> +static void fuse_uring_prep_sqe_commit(struct io_uring_sqe *sqe, void *o=
paque)
> +{
> +    FuseRingEnt *ent =3D opaque;
> +    struct fuse_uring_cmd_req *req =3D (void *)&sqe->cmd[0];
> +
> +    fuse_uring_sqe_prepare(sqe, ent, FUSE_IO_URING_CMD_COMMIT_AND_FETCH);
> +    fuse_uring_sqe_set_req_data(req, ent->q->qid,
> +                                     ent->req_commit_id);
> +}
> +
> +static void
> +fuse_uring_write_response(FuseRingEnt *ent, uint32_t req_id, ssize_t ret,
> +                          const void *out_op_hdr, const void *buf)
> +{
> +    struct fuse_uring_req_header *rrh =3D ent->req_header;
> +    struct fuse_out_header *out_header =3D (struct fuse_out_header *)&rr=
h->in_out;
> +    struct fuse_uring_ent_in_out *ent_in_out =3D
> +        (struct fuse_uring_ent_in_out *)&rrh->ring_ent_in_out;
> +
> +    if (buf) {
> +        memcpy(ent->op_payload, buf, ret);
> +    } else if (ret > 0) {
> +        if (ret > ent->req_payload_sz) {
> +            warn_report("data size %zu exceeds payload buffer size %zu",
> +                        ret, ent->req_payload_sz);
> +                        ret =3D -EINVAL;
> +        } else {
> +            memcpy(ent->op_payload, out_op_hdr, ret);
> +        }
> +    }
> +
> +    out_header->error  =3D ret < 0 ? ret : 0;
> +    out_header->unique =3D req_id;
> +    /* out_header->len =3D ret > 0 ? ret : 0; */
> +    ent_in_out->payload_sz =3D ret > 0 ? ret : 0;
> +
> +    aio_add_sqe(fuse_uring_prep_sqe_commit, ent,
> +                    &ent->fuse_cqe_handler);
> +}
> +
> +static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *ent)
> +{
> +    FuseQueue *q =3D ent->q;
> +    FuseExport *exp =3D q->exp;
> +    struct fuse_uring_req_header *rrh =3D ent->req_header;
> +    struct fuse_uring_ent_in_out *ent_in_out =3D
> +        (struct fuse_uring_ent_in_out *)&rrh->ring_ent_in_out;
> +
> +    char out_op_hdr[MAX_CONST(sizeof(struct fuse_init_out),
> +                 MAX_CONST(sizeof(struct fuse_open_out),
> +                 MAX_CONST(sizeof(struct fuse_attr_out),
> +                 MAX_CONST(sizeof(struct fuse_write_out),
> +                           sizeof(struct fuse_lseek_out)))))];

A union would be cleaner because the casts below could be avoided and
MAX_CONST() would be unnecessary:

  union {
      struct fuse_init_out init;
      struct fuse_open out open;
      struct fuse_attr_out attr;
      struct fuse_write_out write;
      struct fuse_lseek_out lseek;
  } out_op_hdr;

> +
> +    void *out_data_buffer =3D NULL;
> +
> +    uint32_t opcode;
> +    uint64_t req_id;
> +
> +    struct fuse_in_header *in_hdr =3D (struct fuse_in_header *)&rrh->in_=
out;
> +    opcode =3D in_hdr->opcode;
> +    req_id =3D in_hdr->unique;
> +
> +    ent->req_commit_id =3D ent_in_out->commit_id;
> +
> +    if (unlikely(ent->req_commit_id =3D=3D 0)) {
> +        /*
> +         * If this happens kernel will not find the response - it will
> +         * be stuck forever - better to abort immediately.
> +         */
> +        error_report("If this happens kernel will not find the response"
> +        " - it will be stuck forever - better to abort immediately.");
> +        fuse_export_halt(exp);
> +        fuse_dec_in_flight(exp);
> +        return;
> +    }
> +
> +    ssize_t ret;
> +
> +    switch (opcode) {
> +    case FUSE_OPEN:
> +        ret =3D fuse_co_open(exp, (struct fuse_open_out *)out_op_hdr);
> +        break;
> +
> +    case FUSE_RELEASE:
> +        ret =3D 0;
> +        break;
> +
> +    case FUSE_LOOKUP:
> +        ret =3D -ENOENT; /* There is no node but the root node */
> +        break;
> +
> +    case FUSE_GETATTR:
> +        ret =3D fuse_co_getattr(exp, (struct fuse_attr_out *)out_op_hdr);
> +        break;
> +
> +    case FUSE_SETATTR: {
> +        const struct fuse_setattr_in *in =3D
> +                        (const struct fuse_setattr_in *)&rrh->op_in;
> +        ret =3D fuse_co_setattr(exp, (struct fuse_attr_out *)out_op_hdr,
> +                              in->valid, in->size, in->mode, in->uid, in=
->gid);
> +        break;
> +    }
> +
> +    case FUSE_READ: {
> +        const struct fuse_read_in *in =3D
> +                        (const struct fuse_read_in *)&rrh->op_in;
> +        ret =3D fuse_co_read(exp, &out_data_buffer, in->offset, in->size=
);
> +        break;
> +    }
> +
> +    case FUSE_WRITE: {
> +        const struct fuse_write_in *in =3D
> +                        (const struct fuse_write_in *)&rrh->op_in;
> +
> +        assert(in->size =3D=3D ent_in_out->payload_sz);
> +
> +        /*
> +         * poll_fuse_fd() has checked that in_hdr->len matches the numbe=
r of
> +         * bytes read, which cannot exceed the max_write value we set
> +         * (FUSE_MAX_WRITE_BYTES).  So we know that FUSE_MAX_WRITE_BYTES=
 >=3D
> +         * in_hdr->len >=3D in->size + X, so this assertion must hold.
> +         */
> +        assert(in->size <=3D FUSE_MAX_WRITE_BYTES);
> +
> +        ret =3D fuse_co_write(exp, (struct fuse_write_out *)out_op_hdr,
> +                            in->offset, in->size, NULL, ent->op_payload);
> +        break;
> +    }
> +
> +    case FUSE_FALLOCATE: {
> +        const struct fuse_fallocate_in *in =3D
> +                        (const struct fuse_fallocate_in *)&rrh->op_in;
> +        ret =3D fuse_co_fallocate(exp, in->offset, in->length, in->mode);
> +        break;
> +    }
> +
> +    case FUSE_FSYNC:
> +        ret =3D fuse_co_fsync(exp);
> +        break;
> +
> +    case FUSE_FLUSH:
> +        ret =3D fuse_co_flush(exp);
> +        break;
> +
> +#ifdef CONFIG_FUSE_LSEEK
> +    case FUSE_LSEEK: {
> +        const struct fuse_lseek_in *in =3D
> +                        (const struct fuse_lseek_in *)&rrh->op_in;
> +        ret =3D fuse_co_lseek(exp, (struct fuse_lseek_out *)out_op_hdr,
> +                            in->offset, in->whence);
> +        break;
> +    }
> +#endif
> +
> +    default:
> +        ret =3D -ENOSYS;
> +    }

It would be nice to reuse the non-io_uring code rather than duplicating
the switch statement that covers each FUSE opcode. Is the memory layout
so different that the code cannot be shared?

> +
> +    fuse_uring_write_response(ent, req_id, ret, out_op_hdr, out_data_buf=
fer);
> +
> +    if (out_data_buffer)
> +        qemu_vfree(out_data_buffer);
> +}
> +#endif
> +
>  const BlockExportDriver blk_exp_fuse =3D {
>      .type               =3D BLOCK_EXPORT_TYPE_FUSE,
>      .instance_size      =3D sizeof(FuseExport),
> diff --git a/docs/tools/qemu-storage-daemon.rst b/docs/tools/qemu-storage=
-daemon.rst
> index 35ab2d7807..4ec0648e95 100644
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
,uring=3Don|off]
>    --export [type=3D]vduse-blk,id=3D<id>,node-name=3D<node-name>,name=3D<=
vduse-name>[,writable=3Don|off][,num-queues=3D<num-queues>][,queue-size=3D<=
queue-size>][,logical-block-size=3D<block-size>][,serial=3D<serial-number>]
> =20
>    is a block export definition. ``node-name`` is the block node that sho=
uld be
> @@ -111,7 +111,13 @@ Standard options:
>    that enabling this option as a non-root user requires enabling the
>    user_allow_other option in the global fuse.conf configuration file.  S=
etting
>    ``allow-other`` to auto (the default) will try enabling this option, a=
nd on
> -  error fall back to disabling it.
> +  error fall back to disabling it. Once ``uring`` is enabled
> +  (off by default), the initialization of FUSE-over-io_uring-related set=
tings
> +  will be performed in the FUSE_INIT request handler. This setup bypasses
> +  the traditional /dev/fuse communication mechanism and instead uses io_=
uring
> +  for handling FUSE operations.
> +
> +
> =20
>    The ``vduse-blk`` export type takes a ``name`` (must be unique across =
the host)
>    to create the VDUSE device.
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 9ae703ad01..7d14f3f1ba 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -184,12 +184,16 @@
>  #     mount the export with allow_other, and if that fails, try again
>  #     without.  (since 6.1; default: auto)
>  #
> +# @uring: If we enable uring option, it will enable FUSE over io_uring
> +#         feature for QEMU FUSE export.  (default: false)
> +#
>  # Since: 6.0
>  ##
>  { 'struct': 'BlockExportOptionsFuse',
>    'data': { 'mountpoint': 'str',
>              '*growable': 'bool',
> -            '*allow-other': 'FuseExportAllowOther' },
> +            '*allow-other': 'FuseExportAllowOther',
> +            '*uring': 'bool' },
>    'if': 'CONFIG_FUSE' }
> =20
>  ##
> diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-s=
torage-daemon.c
> index eb72561358..803538db29 100644
> --- a/storage-daemon/qemu-storage-daemon.c
> +++ b/storage-daemon/qemu-storage-daemon.c
> @@ -107,6 +107,7 @@ static void help(void)
>  #ifdef CONFIG_FUSE
>  "  --export [type=3D]fuse,id=3D<id>,node-name=3D<node-name>,mountpoint=
=3D<file>\n"
>  "           [,growable=3Don|off][,writable=3Don|off][,allow-other=3Don|o=
ff|auto]\n"
> +"           [,fuse-over-uring=3Don|off]"
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
> =20
> -    ret =3D io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_u=
ring, 0);
> +    ret =3D io_uring_queue_init(FDMON_IO_URING_ENTRIES,
> +                            &ctx->fdmon_io_uring, flags);
>      if (ret !=3D 0) {
>          error_setg_errno(errp, -ret, "Failed to initialize io_uring");
>          return;
> --=20
> 2.50.1
>=20

--SyVFkGfT6WI1YWU3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh9j5oACgkQnKSrs4Gr
c8hQOAgAk2yGPn2Qwkd/+OMoRflI4BVt9IrMWRz6yRfUGGwqdf0UxOFMOKAfuQM8
GpawAwUZ793M2Yy7x2cCoNzVSYtlGYoFQVtwExSAGzHVDGbC38HhDcqlh0V6K7Ff
BbtNMxRzbiZM4cakcp+HsReYIO5ToPrnKOHtE2gm6bRiVKF34vvv+KeaSRBWcQZm
IFwaCTNyPCRTXExPnlVu4LJUZDvmcqdAsc2FmeJReTsqgQo5181c94cLYwkF4teQ
el/v2JxFsfIoA4vUVya0pip834o6og/RlA+fMFqTWJ3A4rQ3C5DRfM7M1nMql/5O
0swyHBNYP+C/VLkZpqv/8bxmRmupgg==
=leHW
-----END PGP SIGNATURE-----

--SyVFkGfT6WI1YWU3--


