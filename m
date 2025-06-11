Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B75C678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPLnN-00015I-Pc; Wed, 11 Jun 2025 09:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPLn3-0000rB-Si
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPLn0-0001qY-96
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749649608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KX5m1HYUb10zrmaOyQfsJ1hzF7BMuvzEn6pz8QgkaE=;
 b=bBznegQcRiRG7Pel2j8wfh4GoHbZyrBCKTVdACzdrYcrwhVXNr+zit+9iv1beR0aCy9cMn
 +7bAdFVwT/Lhw+snH3U51z8GVT9p2FA1qI3IaYnOhWzCfiLLUiz6a7+pO3nu9PD6jXz911
 b7zAf/89d4rtbriKN5FoKfrPSY2hFAw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-YrwcyI-3PKWqIn3w_lIG4w-1; Wed,
 11 Jun 2025 09:46:44 -0400
X-MC-Unique: YrwcyI-3PKWqIn3w_lIG4w-1
X-Mimecast-MFC-AGG-ID: YrwcyI-3PKWqIn3w_lIG4w_1749649603
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99FE0180028F; Wed, 11 Jun 2025 13:46:43 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8EB519560B2; Wed, 11 Jun 2025 13:46:42 +0000 (UTC)
Date: Wed, 11 Jun 2025 09:46:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian <hibriansong@gmail.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 21/21] fuse: Increase MAX_WRITE_SIZE with a second
 buffer
Message-ID: <20250611134641.GA160966@fedora>
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-22-hreitz@redhat.com>
 <0eb2f89d-7be4-4480-a7e3-1b16344364db@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JX61mAXjLPRtfxNN"
Content-Disposition: inline
In-Reply-To: <0eb2f89d-7be4-4480-a7e3-1b16344364db@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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


--JX61mAXjLPRtfxNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 07:37:34PM -0400, Brian wrote:
> Hi all,
>=20
> I'm currently working on the fuse over io_uring feature for QEMU
> FUSE export. When I submit SQEs to the /dev/fuse file descriptor
> during the register phase, the kernel returns an error (in the
> fuse_uring_create_ring_ent()). It seems this is because the payload
> size (i.e. spillover_buf size, which is FUSE_MAX_WRITE_BYTES (64 *
> 4k) minus FUSE_IN_PLACE_WRITE_BYTES (4 * 4k)) is smaller than
> ring->max_payload_sz (which is 32 pages * 4k).
>=20
> Do we need to increase the spillover_buf size, or is there any
> other workaround?

When you implement support for concurrent FUSE-over-io_uring requests
you'll need to pre-allocate a buffer for each request. That
pre-allocation code will be separate from the request buffer that this
patch series defines. So I think this issue is specific to
FUSE-over-io_uring and something that can be done in your upcoming
patches rather than something that affects this patch series.

How about going ahead and writing the FUSE-over-io_uring-specific code
for pre-allocating request buffers right away instead of using
FuseQueue->request_buf[] in your code?

Stefan

>=20
>=20
> Brian
>=20
> On 6/4/25 9:28 AM, Hanna Czenczek wrote:
> > We probably want to support larger write sizes than just 4k; 64k seems
> > nice.  However, we cannot read partial requests from the FUSE FD, we
> > always have to read requests in full; so our read buffer must be large
> > enough to accommodate potential 64k writes if we want to support that.
> >=20
> > Always allocating FuseRequest objects with 64k buffers in them seems
> > wasteful, though.  But we can get around the issue by splitting the
> > buffer into two and using readv(): One part will hold all normal (up to
> > 4k) write requests and all other requests, and a second part (the
> > "spill-over buffer") will be used only for larger write requests.  Each
> > FuseQueue has its own spill-over buffer, and only if we find it used
> > when reading a request will we move its ownership into the FuseRequest
> > object and allocate a new spill-over buffer for the queue.
> >=20
> > This way, we get to support "large" write sizes without having to
> > allocate big buffers when they aren't used.
> >=20
> > Also, this even reduces the size of the FuseRequest objects because the
> > read buffer has to have at least FUSE_MIN_READ_BUFFER (8192) bytes; but
> > the requests we support are not quite so large (except for >4k writes),
> > so until now, we basically had to have useless padding in there.
> >=20
> > With the spill-over buffer added, the FUSE_MIN_READ_BUFFER requirement
> > is easily met and we can decrease the size of the buffer portion that is
> > right inside of FuseRequest.
> >=20
> > As for benchmarks, the benefit of this patch can be shown easily by
> > writing a 4G image (with qemu-img convert) to a FUSE export:
> > - Before this patch: Takes 25.6 s (14.4 s with -t none)
> > - After this patch: Takes 4.5 s (5.5 s with -t none)
> >=20
> > Reviewed-by: Stefan Hajnoczi<stefanha@redhat.com>
> > Signed-off-by: Hanna Czenczek<hreitz@redhat.com>
> > ---
> >   block/export/fuse.c | 137 ++++++++++++++++++++++++++++++++++++++------
> >   1 file changed, 118 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/block/export/fuse.c b/block/export/fuse.c
> > index cdec31f2a8..908266d101 100644
> > --- a/block/export/fuse.c
> > +++ b/block/export/fuse.c
> > @@ -50,8 +50,17 @@
> >   /* Prevent overly long bounce buffer allocations */
> >   #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1=
024))
> > -/* Small enough to fit in the request buffer */
> > -#define FUSE_MAX_WRITE_BYTES (4 * 1024)
> > +/*
> > + * FUSE_MAX_WRITE_BYTES determines the maximum number of bytes we supp=
ort in a
> > + * write request; FUSE_IN_PLACE_WRITE_BYTES and FUSE_SPILLOVER_BUF_SIZE
> > + * determine the split between the size of the in-place buffer in Fuse=
Request
> > + * and the spill-over buffer in FuseQueue.  See FuseQueue.spillover_bu=
f for a
> > + * detailed explanation.
> > + */
> > +#define FUSE_IN_PLACE_WRITE_BYTES (4 * 1024)
> > +#define FUSE_MAX_WRITE_BYTES (64 * 1024)
> > +#define FUSE_SPILLOVER_BUF_SIZE \
> > +    (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
> >   typedef struct FuseExport FuseExport;
> > @@ -67,15 +76,49 @@ typedef struct FuseQueue {
> >       /*
> >        * The request buffer must be able to hold a full write, and/or a=
t least
> > -     * FUSE_MIN_READ_BUFFER (from linux/fuse.h) bytes
> > +     * FUSE_MIN_READ_BUFFER (from linux/fuse.h) bytes.
> > +     * This however is just the first part of the buffer; every read i=
s given
> > +     * a vector of this buffer (which should be enough for all normal =
requests,
> > +     * which we check via the static assertion in FUSE_IN_OP_STRUCT())=
 and the
> > +     * spill-over buffer below.
> > +     * Therefore, the size of this buffer plus FUSE_SPILLOVER_BUF_SIZE=
 must be
> > +     * FUSE_MIN_READ_BUFFER or more (checked via static assertion belo=
w).
> > +     */
> > +    char request_buf[sizeof(struct fuse_in_header) +
> > +                     sizeof(struct fuse_write_in) +
> > +                     FUSE_IN_PLACE_WRITE_BYTES];
> > +
> > +    /*
> > +     * When retrieving a FUSE request, the destination buffer must alw=
ays be
> > +     * sufficiently large for the whole request, i.e. with max_write=
=3D64k, we
> > +     * must provide a buffer that fits the WRITE header and 64 kB of s=
pace for
> > +     * data.
> > +     * We do want to support 64k write requests without requiring them=
 to be
> > +     * split up, but at the same time, do not want to do such a large =
allocation
> > +     * for every single request.
> > +     * Therefore, the FuseRequest object provides an in-line buffer th=
at is
> > +     * enough for write requests up to 4k (and all other requests), an=
d for
> > +     * every request that is bigger, we provide a spill-over buffer he=
re (for
> > +     * the remaining 64k - 4k =3D 60k).
> > +     * When poll_fuse_fd() reads a FUSE request, it passes these buffe=
rs as an
> > +     * I/O vector, and then checks the return value (number of bytes r=
ead) to
> > +     * find out whether the spill-over buffer was used.  If so, it wil=
l move the
> > +     * buffer to the request, and will allocate a new spill-over buffe=
r for the
> > +     * next request.
> > +     *
> > +     * Free this buffer with qemu_vfree().
> >        */
> > -    char request_buf[MAX_CONST(
> > -        sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) +
> > -             FUSE_MAX_WRITE_BYTES,
> > -        FUSE_MIN_READ_BUFFER
> > -    )];
> > +    void *spillover_buf;
> >   } FuseQueue;
> > +/*
> > + * Verify that FuseQueue.request_buf plus the spill-over buffer togeth=
er
> > + * are big enough to be accepted by the FUSE kernel driver.
> > + */
> > +QEMU_BUILD_BUG_ON(sizeof(((FuseQueue *)0)->request_buf) +
> > +                  FUSE_SPILLOVER_BUF_SIZE <
> > +                  FUSE_MIN_READ_BUFFER);
> > +
> >   struct FuseExport {
> >       BlockExport common;
> > @@ -131,7 +174,8 @@ static int clone_fuse_fd(int fd, Error **errp);
> >   static bool is_regular_file(const char *path, Error **errp);
> >   static void read_from_fuse_fd(void *opaque);
> > -static void coroutine_fn fuse_co_process_request(FuseQueue *q);
> > +static void coroutine_fn
> > +fuse_co_process_request(FuseQueue *q, void *spillover_buf);
> >   static void fuse_inc_in_flight(FuseExport *exp)
> >   {
> > @@ -476,12 +520,27 @@ static void coroutine_fn co_read_from_fuse_fd(voi=
d *opaque)
> >       FuseExport *exp =3D q->exp;
> >       ssize_t ret;
> >       const struct fuse_in_header *in_hdr;
> > +    struct iovec iov[2];
> > +    void *spillover_buf =3D NULL;
> >       if (unlikely(exp->halted)) {
> >           goto no_request;
> >       }
> > -    ret =3D RETRY_ON_EINTR(read(fuse_fd, q->request_buf, sizeof(q->req=
uest_buf)));
> > +    /*
> > +     * If handling the last request consumed the spill-over buffer, al=
locate a
> > +     * new one.  Align it to the block device's alignment, which admit=
tedly is
> > +     * only useful if FUSE_IN_PLACE_WRITE_BYTES is aligned, too.
> > +     */
> > +    if (unlikely(!q->spillover_buf)) {
> > +        q->spillover_buf =3D blk_blockalign(exp->common.blk,
> > +                                          FUSE_SPILLOVER_BUF_SIZE);
> > +    }
> > +    /* Construct the I/O vector to hold the FUSE request */
> > +    iov[0] =3D (struct iovec) { q->request_buf, sizeof(q->request_buf)=
 };
> > +    iov[1] =3D (struct iovec) { q->spillover_buf, FUSE_SPILLOVER_BUF_S=
IZE };
> > +
> > +    ret =3D RETRY_ON_EINTR(readv(fuse_fd, iov, ARRAY_SIZE(iov)));
> >       if (ret < 0 && errno =3D=3D EAGAIN) {
> >           /* No request available */
> >           goto no_request;
> > @@ -510,7 +569,13 @@ static void coroutine_fn co_read_from_fuse_fd(void=
 *opaque)
> >           goto no_request;
> >       }
> > -    fuse_co_process_request(q);
> > +    if (unlikely(ret > sizeof(q->request_buf))) {
> > +        /* Spillover buffer used, take ownership */
> > +        spillover_buf =3D q->spillover_buf;
> > +        q->spillover_buf =3D NULL;
> > +    }
> > +
> > +    fuse_co_process_request(q, spillover_buf);
> >   no_request:
> >       fuse_dec_in_flight(exp);
> > @@ -560,6 +625,9 @@ static void fuse_export_delete(BlockExport *blk_exp)
> >           if (i > 0 && q->fuse_fd >=3D 0) {
> >               close(q->fuse_fd);
> >           }
> > +        if (q->spillover_buf) {
> > +            qemu_vfree(q->spillover_buf);
> > +        }
> >       }
> >       g_free(exp->queues);
> > @@ -869,17 +937,25 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint=
64_t offset, uint32_t size)
> >   }
> >   /**
> > - * Handle client writes to the exported image.  @buf has the data to b=
e written
> > - * and will be copied to a bounce buffer before yielding for the first=
 time.
> > + * Handle client writes to the exported image.  @in_place_buf has the =
first
> > + * FUSE_IN_PLACE_WRITE_BYTES bytes of the data to be written, @spillov=
er_buf
> > + * contains the rest (if any; NULL otherwise).
> > + * Data in @in_place_buf is assumed to be overwritten after yielding, =
so will
> > + * be copied to a bounce buffer beforehand.  @spillover_buf in contras=
t is
> > + * assumed to be exclusively owned and will be used as-is.
> >    * Return the number of bytes written to *out on success, and -errno =
on error.
> >    */
> >   static ssize_t coroutine_fn
> >   fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
> > -              uint64_t offset, uint32_t size, const void *buf)
> > +              uint64_t offset, uint32_t size,
> > +              const void *in_place_buf, const void *spillover_buf)
> >   {
> > +    size_t in_place_size;
> >       void *copied;
> >       int64_t blk_len;
> >       int ret;
> > +    struct iovec iov[2];
> > +    QEMUIOVector qiov;
> >       /* Limited by max_write, should not happen */
> >       if (size > BDRV_REQUEST_MAX_BYTES) {
> > @@ -891,8 +967,9 @@ fuse_co_write(FuseExport *exp, struct fuse_write_ou=
t *out,
> >       }
> >       /* Must copy to bounce buffer before potentially yielding */
> > -    copied =3D blk_blockalign(exp->common.blk, size);
> > -    memcpy(copied, buf, size);
> > +    in_place_size =3D MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
> > +    copied =3D blk_blockalign(exp->common.blk, in_place_size);
> > +    memcpy(copied, in_place_buf, in_place_size);
> >       /**
> >        * Clients will expect short writes at EOF, so we have to limit
> > @@ -916,7 +993,21 @@ fuse_co_write(FuseExport *exp, struct fuse_write_o=
ut *out,
> >           }
> >       }
> > -    ret =3D blk_co_pwrite(exp->common.blk, offset, size, copied, 0);
> > +    iov[0] =3D (struct iovec) {
> > +        .iov_base =3D copied,
> > +        .iov_len =3D in_place_size,
> > +    };
> > +    if (size > FUSE_IN_PLACE_WRITE_BYTES) {
> > +        assert(size - FUSE_IN_PLACE_WRITE_BYTES <=3D FUSE_SPILLOVER_BU=
F_SIZE);
> > +        iov[1] =3D (struct iovec) {
> > +            .iov_base =3D (void *)spillover_buf,
> > +            .iov_len =3D size - FUSE_IN_PLACE_WRITE_BYTES,
> > +        };
> > +        qemu_iovec_init_external(&qiov, iov, 2);
> > +    } else {
> > +        qemu_iovec_init_external(&qiov, iov, 1);
> > +    }
> > +    ret =3D blk_co_pwritev(exp->common.blk, offset, size, &qiov, 0);
> >       if (ret < 0) {
> >           goto fail_free_buffer;
> >       }
> > @@ -1275,8 +1366,14 @@ static int fuse_write_buf_response(int fd, uint3=
2_t req_id,
> >    * Note that yielding in any request-processing function can overwrit=
e the
> >    * contents of q->request_buf.  Anything that takes a buffer needs to=
 take
> >    * care that the content is copied before yielding.
> > + *
> > + * @spillover_buf can contain the tail of a write request too large to=
 fit into
> > + * q->request_buf.  This function takes ownership of it (i.e. will fre=
e it),
> > + * which assumes that its contents will not be overwritten by concurre=
nt
> > + * requests (as opposed to q->request_buf).
> >    */
> > -static void coroutine_fn fuse_co_process_request(FuseQueue *q)
> > +static void coroutine_fn
> > +fuse_co_process_request(FuseQueue *q, void *spillover_buf)
> >   {
> >       FuseExport *exp =3D q->exp;
> >       uint32_t opcode;
> > @@ -1372,7 +1469,7 @@ static void coroutine_fn fuse_co_process_request(=
FuseQueue *q)
> >            * yielding.
> >            */
> >           ret =3D fuse_co_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
> > -                            in->offset, in->size, in + 1);
> > +                            in->offset, in->size, in + 1, spillover_bu=
f);
> >           break;
> >       }
> > @@ -1414,6 +1511,8 @@ static void coroutine_fn fuse_co_process_request(=
FuseQueue *q)
> >                               ret < 0 ? ret : 0,
> >                               ret < 0 ? 0 : ret);
> >       }
> > +
> > +    qemu_vfree(spillover_buf);
> >   }
> >   const BlockExportDriver blk_exp_fuse =3D {

--JX61mAXjLPRtfxNN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhJiMEACgkQnKSrs4Gr
c8gPQwf8DEGIbJsZtZhVNMXWkmbvar12BsXR0LwpQa1UPXw+grxFaGqL3uHIgmoF
QqHEMxdYlr/QlMGqAHeore+BQ7frn1DaGUAjfjlt1B36BPFMWsphsnyg2NMRkB9T
oW9/zkNZlhNEYPze5kzAczR/X9Cv7yrxtQHsNGfjOfMqpdE8+ZX48HeNtMG1rao4
NRHIeQFL9Mu5JoeeOeZ6ONM8EAvsh7WSedw2tMunYpPZxDtccIQgyTzTJll4qgPT
C3LKgZ9d0fwx5c0TCNTFfE17+Ud2VDg8EhUfsBPt1wcI/6QeXlVdG8fwP+A3ysPy
4vTLSgvBcrsP/XSs9DgiX6a98UVbjA==
=xD3u
-----END PGP SIGNATURE-----

--JX61mAXjLPRtfxNN--


