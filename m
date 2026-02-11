Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD67BEEA845
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqbop-0003wN-Fy; Thu, 12 Feb 2026 13:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqbon-0003v2-8k
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqbol-000463-Ia
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770922414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x4iUlvqXKnrZzj1obTFPsNhhha3Zq4TsL9tgQNcxVhQ=;
 b=UigAKWUCwSX7SMkpShm1TNtsj7PFTwN+Ie3WBdkREa7FLx78yxh8ruST9jEiJ1wljnOFtZ
 PHusinpQM1/JxDRvtbf5L7bwdxx8B2uOu2ziNr7ST9IlP8/C98Ymel9+e8jEyIzCoZ/Iq4
 NPPJAfF7b2gAWAf/MH9rx7GN4J1PK7Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-kFE9aGa4OE2JHDETqfOkBA-1; Thu,
 12 Feb 2026 13:53:31 -0500
X-MC-Unique: kFE9aGa4OE2JHDETqfOkBA-1
X-Mimecast-MFC-AGG-ID: kFE9aGa4OE2JHDETqfOkBA_1770922410
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 373741800454; Thu, 12 Feb 2026 18:53:30 +0000 (UTC)
Received: from localhost (unknown [10.2.17.121])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D82A1800465; Thu, 12 Feb 2026 18:53:29 +0000 (UTC)
Date: Wed, 11 Feb 2026 15:56:11 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 fam@euphon.net, bernd@bsbernd.com
Subject: Re: [Patch v4 2/7] fuse: io_uring mode init
Message-ID: <20260211205611.GB234157@fedora>
References: <20260207120901.17222-1-hibriansong@gmail.com>
 <20260207120901.17222-3-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dJ4cyOTkREdAou4u"
Content-Disposition: inline
In-Reply-To: <20260207120901.17222-3-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--dJ4cyOTkREdAou4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 07, 2026 at 08:08:56PM +0800, Brian Song wrote:
> +typedef struct FuseUringEnt {
> +    /* back pointer */
> +    FuseUringQueue *rq;
> +
> +    /* commit id of a fuse request */
> +    uint64_t req_commit_id;

This field is only read by fuse_uring_resubmit() in this patch, never
assigned. Maybe some code later in the patch series should be squashed
into this patch so that this field is initialized somewhere?

Also, is it possible to drop req_commit_id and read from the existing
req_header.ring_ent_in_out.commit_id field instead?

> +static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
> +{
> +    Coroutine *co;
> +    FuseUringEnt *ent =
> +        container_of(cqe_handler, FuseUringEnt, fuse_cqe_handler);
> +    FuseExport *exp = ent->rq->q->exp;
> +
> +    if (unlikely(exp->halted)) {
> +        return;

Missing blk_exp_unref()?

> +    }
> +
> +    int err = cqe_handler->cqe.res;
> +
> +    if (unlikely(err != 0)) {
> +        switch (err) {
> +        case -EAGAIN:
> +        case -EINTR:
> +            aio_add_sqe(fuse_uring_resubmit, ent, &ent->fuse_cqe_handler);
> +            break;
> +        case -ENOTCONN:
> +            /* Connection already gone */
> +            break;
> +        default:
> +            fuse_export_halt(exp);
> +            break;
> +        }
> +
> +        /* A uring entry returned */
> +        blk_exp_unref(&exp->common);
> +    } else {
> +        co = qemu_coroutine_create(co_fuse_uring_queue_handle_cqe, ent);
> +        /* Account this request as in-flight */
> +        fuse_inc_in_flight(exp);
> +        qemu_coroutine_enter(co);
> +    }
> +}
> +
> +static void
> +fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
> +                            const unsigned int rqid,
> +                            const unsigned int commit_id)
> +{
> +    req->qid = rqid;
> +    req->commit_id = commit_id;
> +    req->flags = 0;
> +}
> +
> +static void
> +fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q, __u32 cmd_op)
> +{
> +    sqe->opcode = IORING_OP_URING_CMD;
> +
> +    sqe->fd = q->fuse_fd;
> +    sqe->rw_flags = 0;
> +    sqe->ioprio = 0;
> +    sqe->off = 0;
> +
> +    sqe->cmd_op = cmd_op;
> +    sqe->__pad1 = 0;
> +}
> +
> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void *opaque)
> +{
> +    FuseUringEnt *ent = opaque;
> +    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
> +
> +    ent->last_cmd = FUSE_IO_URING_CMD_REGISTER;
> +    fuse_uring_sqe_prepare(sqe, ent->rq->q, ent->last_cmd);
> +
> +    sqe->addr = (uint64_t)(ent->iov);
> +    sqe->len = 2;
> +
> +    fuse_uring_sqe_set_req_data(req, ent->rq->rqid, 0);
> +}
> +
> +static void fuse_uring_resubmit(struct io_uring_sqe *sqe, void *opaque)
> +{
> +    FuseUringEnt *ent = opaque;
> +    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
> +
> +    fuse_uring_sqe_prepare(sqe, ent->rq->q, ent->last_cmd);
> +
> +    switch (ent->last_cmd) {
> +    case FUSE_IO_URING_CMD_REGISTER:
> +        sqe->addr = (uint64_t)(ent->iov);
> +        sqe->len = 2;
> +        fuse_uring_sqe_set_req_data(req, ent->rq->rqid, 0);
> +        break;
> +    case FUSE_IO_URING_CMD_COMMIT_AND_FETCH:
> +        fuse_uring_sqe_set_req_data(req, ent->rq->rqid, ent->req_commit_id);
> +        break;
> +    default:
> +        error_report("Unknown command type: %d", ent->last_cmd);
> +        break;
> +    }
> +}
> +
> +static void fuse_uring_submit_register(void *opaque)
> +{
> +    FuseUringQueue *rq = opaque;
> +    FuseExport *exp = rq->q->exp;
> +
> +    for (int j = 0; j < exp->uring_queue_depth; j++) {
> +        /* Register a uring entry */
> +        blk_exp_ref(&exp->common);
> +
> +        aio_add_sqe(fuse_uring_prep_sqe_register, &rq->ent[j],
> +                    &rq->ent[j].fuse_cqe_handler);
> +    }
> +}
> +
> +/**
> + * Distribute uring queues across FUSE queues in the round-robin manner.
> + * This ensures even distribution of kernel uring queues across user-specified
> + * FUSE queues.
> + *
> + * num_uring_queues > num_fuse_queues: Each IOThread manages multiple uring
> + * queues (multi-queue mapping).
> + * num_uring_queues < num_fuse_queues: Excess IOThreads remain idle with no
> + * assigned uring queues.
> + */
> +static void fuse_uring_setup_queues(FuseExport *exp, size_t bufsize)
> +{
> +    int num_uring_queues = get_nprocs_conf();
> +
> +    exp->num_uring_queues = num_uring_queues;
> +    exp->uring_queues = g_new(FuseUringQueue, num_uring_queues);
> +
> +    for (int i = 0; i < num_uring_queues; i++) {
> +        FuseUringQueue *rq = &exp->uring_queues[i];
> +        rq->rqid = i;
> +        rq->ent = g_new(FuseUringEnt, exp->uring_queue_depth);
> +
> +        for (int j = 0; j < exp->uring_queue_depth; j++) {
> +            FuseUringEnt *ent = &rq->ent[j];
> +            ent->rq = rq;
> +            ent->req_payload_sz = bufsize - FUSE_BUFFER_HEADER_SIZE;
> +            ent->req_payload = g_malloc0(ent->req_payload_sz);

I don't see a corresponding g_free() in this patch? Exports can be
deleted at runtime, so this memory must be freed.

> +
> +            ent->iov[0] = (struct iovec) {
> +                &ent->req_header,
> +                sizeof(struct fuse_uring_req_header)
> +            };
> +            ent->iov[1] = (struct iovec) {
> +                ent->req_payload,
> +                ent->req_payload_sz
> +            };
> +
> +            ent->fuse_cqe_handler.cb = fuse_uring_cqe_handler;
> +        }
> +
> +        /* Distribute uring queues across FUSE queues */
> +        rq->q = &exp->queues[i % exp->num_fuse_queues];
> +        QLIST_INSERT_HEAD(&(rq->q->uring_queue_list), rq, next);
> +    }
> +}
> +
> +static void
> +fuse_schedule_ring_queue_registrations(FuseExport *exp)
> +{
> +    for (int i = 0; i < exp->num_fuse_queues; i++) {
> +        FuseQueue *q = &exp->queues[i];
> +        FuseUringQueue *rq;
> +
> +        QLIST_FOREACH(rq, &q->uring_queue_list, next) {
> +            aio_bh_schedule_oneshot(q->ctx, fuse_uring_submit_register, rq);
> +        }
> +    }
> +}
> +
> +static void fuse_uring_start(FuseExport *exp, struct fuse_init_out *out)
> +{
> +    assert(!exp->uring_started);
> +    exp->uring_started = true;
> +
> +    /*
> +     * Since we dont't enable the FUSE_MAX_PAGES feature, the value of

s/dont't/don't/

--dJ4cyOTkREdAou4u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmM7OsACgkQnKSrs4Gr
c8jbvAgAm1tbV6tLHFr7uj48LZ2HL4FQGNHHczJ7NsHOQkeABcL4h99ZPgCBLyqF
Br0Bj7U9BSSlUQ0BCzp0SiXYbh79B452JFPA5IILv9fTLX2YkuMwKqEfjRxXTfCw
COtFek8UitWn38pWnB5Hy5mSKZqm200gbXxz0AywOr36lMJikpd6/YR6V3SolM7q
viUx8cFV3B74J8A/cZspIhJI3W9xRVP5JEV5A0hQd7DifMkqxzxBPdch68Y457bf
hZcLjgF5DBHK+w3UYRG1kmsP1SGXf8xRKbAolTO2r0pEX1olBn384mO09AI08WeQ
hNFmNOqFIsm/7qGyrUWBLTaa1jkjuA==
=Rkmj
-----END PGP SIGNATURE-----

--dJ4cyOTkREdAou4u--


