Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84B1C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 12:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueBgl-0007vT-2X; Tue, 22 Jul 2025 08:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1ueBga-0007hF-HZ; Tue, 22 Jul 2025 08:01:33 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1ueBgU-0001GO-O8; Tue, 22 Jul 2025 08:01:32 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-615913ff67fso3304959eaf.0; 
 Tue, 22 Jul 2025 05:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753185681; x=1753790481; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+wW6CG8qeQ76uqKIJrdpRUwBQrGQ6/XGlIzCqEyeFnI=;
 b=DtBUq+Sle2jglJaNwRgz4UUjWHK1mWQpfLuC9kbAKTXs+mCX3QnNwfu0xLqKDqvopd
 91mOsdNZojB+l+vvS2wOIbg9B7jssbl4Ahh6zhiqMayskgzZBiFYhTYM9W8ksNHUK+Rj
 avcJ5MbrCapbu9imUzNJWm+VmNnDA29iSeiO9qzE7BjOxfXHz/X2fO/edAf4ZP2hlhv4
 9tc+0bYX+CYuYmvghaEG2dOJemVPkwgnFXTLnwx1XXTgS3bZZlAS4IEjHkq3qkTrRT7K
 LZAr6RHGAKDlK9XRU9ioeu+rBtg3zaBdhPzujMh5807WM/zfXZlaxRU2NtR29MJhQYB7
 hE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753185681; x=1753790481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+wW6CG8qeQ76uqKIJrdpRUwBQrGQ6/XGlIzCqEyeFnI=;
 b=Y6PQmZTsH6tnpQL0/16K5lo4i3isZ+mp4Z9gQ6A5fcKC+olv8jIy6jo1ItC1fftO1Y
 sXFwUSJ7rnki3jI8f/dmrO3XhkTythhRrve2axthFWwnThZKpD83auqDcfX9s67/uIsT
 Eke3DhikIp7rjhTvtnXhslad2+VSC3XQFvh6pXF/t04AkyBxhsxRyz3oWXXAo4Dn69qx
 MUnrktU+wzeFpKCtcUt1wuPZqMsEoVWINf5voe7gxxh7cocWqt4vtST3gLIM/Hdyq5fw
 BGu9jl6vMwlPijjCC4/dQM2EBFXbIct+Ipa0SeqbReED9UP6AWEu5ut/afDOTx5YJ8g1
 2XWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVZv6gGa6ypCYvmkAy0VS1q9eYMWC/Ulgtb68vpboBFTcgUom08HNn548Rhv5RXyQfriltLU+KfDdz@nongnu.org
X-Gm-Message-State: AOJu0YwDGSVYJ7gNhDzG3k2Ylya36MjyMVh2qz0PWfDMd8XFH90BOhWS
 TIjWYCjacOMvColFuwqpPcTXHNhgVkPcO1813xR1qEwcY3XV8+cVXbJMxfB2wKlcriAsCPR8/Qx
 USJEiGrBeXGjTv/zjliyeAVc50mHMVrY=
X-Gm-Gg: ASbGncu5TGanQipDmO48HJGZ/UFPJ65TEEzL1IhTPjTJWpSa6oVj57+EhNigEmn7q0d
 hg7hElmgRdrg2W2FFpoK8nbPYdQMJPpJZJdkVcBA9iW3dzblE7vMTvPrIsqiTBEoWJDryU0uES5
 r3MVBz7yonCrJdaeVl/7fm4IaaPteGSoKAdlavNKov9lA20K5nvsw3Vl7Qcm9lFm0bixO7UUbRV
 s+N3g==
X-Google-Smtp-Source: AGHT+IG3vMtFNPWQXbT41fxuBvVLogIClLE/v6D37nOlN6VpBqA5bIBdIJoe6s6ojBHkha2mOIkpiqt0Flmxk69DYxA=
X-Received: by 2002:a05:6820:2918:b0:615:9a1e:8d30 with SMTP id
 006d021491bc7-615ee675ef2mr3019525eaf.2.1753185680663; Tue, 22 Jul 2025
 05:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250716183824.216257-2-hibriansong@gmail.com>
 <20250721005346.GB32887@fedora>
In-Reply-To: <20250721005346.GB32887@fedora>
From: Brian Song <hibriansong@gmail.com>
Date: Tue, 22 Jul 2025 08:00:00 -0400
X-Gm-Features: Ac12FXylTXuQSISNV9CmcrRFe_JOgw5o75fKZxzg67-2fx-dxcElcIEYNX2L3yo
Message-ID: <CAKWCU7WEv=qohQJ6XUzHS9ffHN8gT0yuRZojmrTgpqja3ghaiw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for QEMU
 FUSE Exports
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, 
 bschubert@ddn.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=hibriansong@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 7/20/25 8:53 PM, Stefan Hajnoczi wrote:
> On Wed, Jul 16, 2025 at 02:38:24PM -0400, Brian Song wrote:
>> This work provides an initial implementation of fuse-over-io_uring
>> support for QEMU export. According to the fuse-over-io_uring protocol
>> specification, the userspace side must create the same number of queues
>> as the number of CPUs (nr_cpu), just like the kernel. Currently, each
>> queue contains only a single SQE entry, which is used to validate the
>> correctness of the fuse-over-io_uring functionality.
>>
>> All FUSE read and write operations interact with the kernel via io
>> vectors embedded in the SQE entry during submission and CQE fetching.
>> The req_header and op_payload members of each entry are included as
>> parts of the io vector: req_header carries the FUSE operation header,
>> and op_payload carries the data payload, such as file attributes in a
>> getattr reply, file content in a read reply, or file content being
>> written to the FUSE client in a write operation.
>>
>> At present, multi-threading support is still incomplete. In addition,
>> handling connection termination and managing the "drained" state of a
>> FUSE block export in QEMU remain as pending work.
>>
>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>>
>> ---
>>   block/export/fuse.c                  | 423 +++++++++++++++++++++++++--
>>   docs/tools/qemu-storage-daemon.rst   |  10 +-
>>   qapi/block-export.json               |   6 +-
>>   storage-daemon/qemu-storage-daemon.c |   1 +
>>   util/fdmon-io_uring.c                |   5 +-
>>   5 files changed, 420 insertions(+), 25 deletions(-)
>
> Here is feedback from a first pass over this patch.
>
>>
>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>> index c0ad4696ce..637d36186a 100644
>> --- a/block/export/fuse.c
>> +++ b/block/export/fuse.c
>> @@ -48,6 +48,11 @@
>>   #include <linux/fs.h>
>>   #endif
>>
>> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
>> +
>> +/* room needed in buffer to accommodate header */
>> +#define FUSE_BUFFER_HEADER_SIZE 0x1000
>> +
>>   /* Prevent overly long bounce buffer allocations */
>>   #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
>>   /*
>> @@ -64,6 +69,26 @@
>>
>>   typedef struct FuseExport FuseExport;
>>
>> +struct FuseQueue;
>
> Use "typedef struct FuseQueue FuseQueue;" here...
>
>> +
>> +typedef struct FuseRingEnt {
>> +    /* back pointer */
>> +    struct FuseQueue *q;
>
> ...and then this can be "FuseQueue *q;" so that QEMU coding style is
> followed.

Done.

>> +
>> +    /* commit id of a fuse request */
>> +    uint64_t req_commit_id;
>> +
>> +    /* fuse request header and payload */
>> +    struct fuse_uring_req_header *req_header;
>> +    void *op_payload;
>> +    size_t req_payload_sz;
>> +
>> +    /* The vector passed to the kernel */
>> +    struct iovec iov[2];
>> +
>> +    CqeHandler fuse_cqe_handler;
>> +} FuseRingEnt;
>> +
>>   /*
>>    * One FUSE "queue", representing one FUSE FD from which requests are fetched
>>    * and processed.  Each queue is tied to an AioContext.
>> @@ -73,6 +98,7 @@ typedef struct FuseQueue {
>>
>>       AioContext *ctx;
>>       int fuse_fd;
>> +    int qid;
>
> Could this go inside #ifdef CONFIG_LINUX_IO_URING? It seems to be
> specific to FUSE-over-io_uring.

Done.

>>
>>       /*
>>        * The request buffer must be able to hold a full write, and/or at least
>> @@ -109,6 +135,17 @@ typedef struct FuseQueue {
>>        * Free this buffer with qemu_vfree().
>>        */
>>       void *spillover_buf;
>> +
>> +#ifdef CONFIG_LINUX_IO_URING
>> +    FuseRingEnt ent;
>> +
>> +    /*
>> +     * TODO
>> +     * Support multi-threaded FUSE over io_uring by using eventfd and allocating
>> +     * an extra SQE for each thread to be notified when the connection
>> +     * shuts down.
>> +     */
>
> eventfd and the extra SQE won't be necessary because
> aio_bh_schedule_oneshot() can be used to cause threads to execute a
> function.
>
> (I think this comment effectively says that connection shutdown still
> needs to be implemented. The implementation details don't matter at this
> point.)
>
>> +#endif
>>   } FuseQueue;
>>
>>   /*
>> @@ -148,6 +185,7 @@ struct FuseExport {
>>       bool growable;
>>       /* Whether allow_other was used as a mount option or not */
>>       bool allow_other;
>> +    bool is_uring;
>>
>>       mode_t st_mode;
>>       uid_t st_uid;
>> @@ -257,6 +295,126 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
>>       .drained_poll  = fuse_export_drained_poll,
>>   };
>>
>> +#ifdef CONFIG_LINUX_IO_URING
>> +static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *ent);
>> +
>> +static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)
>> +{
>> +    CqeHandler *cqe_handler = opaque;
>> +    FuseRingEnt *ent = container_of(cqe_handler, FuseRingEnt, fuse_cqe_handler);
>
> Passing ent in opaque instead of cqe_handler would simplify this.
>

Done.

>> +    FuseExport *exp = ent->q->exp;
>> +
>> +    fuse_uring_co_process_request(ent);
>> +
>> +    fuse_dec_in_flight(exp);
>> +}
>> +
>> +static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
>> +{
>> +    FuseRingEnt *ent = container_of(cqe_handler, FuseRingEnt, fuse_cqe_handler);
>> +    FuseQueue *q = ent->q;
>> +    Coroutine *co;
>> +    FuseExport *exp = ent->q->exp;
>> +
>> +    int err = cqe_handler->cqe.res;
>> +    if (err != 0) {
>> +        /* TODO end_conn support */
>> +
>> +        /* -ENOTCONN is ok on umount  */
>> +        if (err != -EINTR && err != -EOPNOTSUPP &&
>> +            err != -EAGAIN && err != -ENOTCONN) {
>> +            fuse_export_halt(exp);
>> +        }
>> +    } else {
>> +        co = qemu_coroutine_create(co_fuse_uring_queue_handle_cqes,
>> +                            cqe_handler);
>> +        /* Decremented by co_fuse_uring_queue_handle_cqes() */
>> +        fuse_inc_in_flight(q->exp);
>
> Can this be moved inside co_fuse_uring_queue_handle_cqes() to avoid
> calling inc/dec from different functions? That would make the code
> easier to understand and more robust against future bugs.
>

Yes, I kept some of the logic the same as in the traditional approach
for handling requests


>> +        qemu_coroutine_enter(co);
>> +    }
>> +}
>> +
>> +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
>> +                    const unsigned int qid,
>> +                    const unsigned int commit_id)
>> +{
>> +    req->qid = qid;
>> +    req->commit_id = commit_id;
>> +    req->flags = 0;
>> +}
>> +
>> +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseRingEnt *ent,
>> +               __u32 cmd_op)
>> +{
>> +    sqe->opcode = IORING_OP_URING_CMD;
>> +
>> +    sqe->fd = ent->q->fuse_fd;
>> +    sqe->rw_flags = 0;
>> +    sqe->ioprio = 0;
>> +    sqe->off = 0;
>> +
>> +    sqe->cmd_op = cmd_op;
>> +    sqe->__pad1 = 0;
>> +}
>> +
>> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void *opaque)
>> +{
>> +    FuseQueue *q = opaque;
>> +    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
>> +
>> +    fuse_uring_sqe_prepare(sqe, &q->ent, FUSE_IO_URING_CMD_REGISTER);
>> +
>> +    sqe->addr = (uint64_t)(q->ent.iov);
>> +    sqe->len = 2;
>> +
>> +    fuse_uring_sqe_set_req_data(req, q->qid, 0);
>> +}
>> +
>> +static void fuse_uring_start(FuseExport *exp, struct fuse_init_out *out)
>> +{
>> +    /*
>> +     * Since we didn't enable the FUSE_MAX_PAGES feature, the value of
>> +     * fc->max_pages should be FUSE_DEFAULT_MAX_PAGES_PER_REQ, which is set by
>> +     * the kernel by default. Also, max_write should not exceed
>> +     * FUSE_DEFAULT_MAX_PAGES_PER_REQ * PAGE_SIZE.
>> +     */
>> +    size_t bufsize = out->max_write + FUSE_BUFFER_HEADER_SIZE;
>> +
>> +    if (!(out->flags & FUSE_MAX_PAGES)) {
>> +        /*
>> +         * bufsize = MIN(FUSE_DEFAULT_MAX_PAGES_PER_REQ *
>> +         *       qemu_real_host_page_size() + FUSE_BUFFER_HEADER_SIZE, bufsize);
>> +         */
>> +        bufsize = FUSE_DEFAULT_MAX_PAGES_PER_REQ * qemu_real_host_page_size()
>> +                         + FUSE_BUFFER_HEADER_SIZE;
>> +    }
>> +
>> +    for (int i = 0; i < exp->num_queues; i++) {
>> +        FuseQueue *q = &exp->queues[i];
>> +
>> +        q->ent.q = q;
>> +
>> +        q->ent.req_header = g_malloc0(sizeof(struct fuse_uring_req_header));
>
> It's probably easier to embed the header as a FuseRingEnt field instead
> of heap allocating it.

Done.

>
>> +        q->ent.req_payload_sz = bufsize - FUSE_BUFFER_HEADER_SIZE;
>> +        q->ent.op_payload = g_malloc0(q->ent.req_payload_sz);
>
>
>> +
>> +        q->ent.iov[0] = (struct iovec) {
>> +            q->ent.req_header,
>> +            sizeof(struct fuse_uring_req_header)
>> +        };
>> +        q->ent.iov[1] = (struct iovec) {
>> +            q->ent.op_payload,
>> +            q->ent.req_payload_sz
>> +        };
>> +
>> +        exp->queues[i].ent.fuse_cqe_handler.cb = fuse_uring_cqe_handler;
>> +
>> +        aio_add_sqe(fuse_uring_prep_sqe_register, &(exp->queues[i]),
>> +            &(exp->queues[i].ent.fuse_cqe_handler));
>> +    }
>> +}
>> +#endif
>> +
>>   static int fuse_export_create(BlockExport *blk_exp,
>>                                 BlockExportOptions *blk_exp_args,
>>                                 AioContext *const *multithread,
>> @@ -280,6 +438,7 @@ static int fuse_export_create(BlockExport *blk_exp,
>>
>>           for (size_t i = 0; i < mt_count; i++) {
>>               exp->queues[i] = (FuseQueue) {
>> +                .qid = i,
>>                   .exp = exp,
>>                   .ctx = multithread[i],
>>                   .fuse_fd = -1,
>> @@ -293,6 +452,7 @@ static int fuse_export_create(BlockExport *blk_exp,
>>           exp->num_queues = 1;
>>           exp->queues = g_new(FuseQueue, 1);
>>           exp->queues[0] = (FuseQueue) {
>> +            .qid = 0,
>>               .exp = exp,
>>               .ctx = exp->common.ctx,
>>               .fuse_fd = -1,
>> @@ -312,6 +472,8 @@ static int fuse_export_create(BlockExport *blk_exp,
>>           }
>>       }
>>
>> +    exp->is_uring = args->uring ? true : false;
>> +
>>       blk_set_dev_ops(exp->common.blk, &fuse_export_blk_dev_ops, exp);
>>
>>       /*
>> @@ -597,6 +759,22 @@ static void read_from_fuse_fd(void *opaque)
>>       qemu_coroutine_enter(co);
>>   }
>>
>> +#ifdef CONFIG_LINUX_IO_URING
>> +static void fuse_export_delete_uring(FuseExport *exp)
>> +{
>> +    exp->is_uring = false;
>> +
>> +    /*
>> +     * TODO
>> +     * end_conn handling
>> +     */
>> +    for (size_t qid = 0; qid < exp->num_queues; qid++) {
>> +        g_free(exp->queues[qid].ent.req_header);
>> +        g_free(exp->queues[qid].ent.op_payload);
>> +    }
>> +}
>> +#endif
>> +
>>   static void fuse_export_shutdown(BlockExport *blk_exp)
>>   {
>>       FuseExport *exp = container_of(blk_exp, FuseExport, common);
>> @@ -618,6 +796,11 @@ static void fuse_export_delete(BlockExport *blk_exp)
>>   {
>>       FuseExport *exp = container_of(blk_exp, FuseExport, common);
>>
>> +#ifdef CONFIG_LINUX_IO_URING
>> +    if (exp->is_uring)
>> +        fuse_export_delete_uring(exp);
>> +#endif
>> +
>>       for (int i = 0; i < exp->num_queues; i++) {
>>           FuseQueue *q = &exp->queues[i];
>>
>> @@ -687,15 +870,22 @@ static ssize_t coroutine_fn
>>   fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
>>                uint32_t max_readahead, uint32_t flags)
>>   {
>> -    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
>> +    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO
>> +                                     | FUSE_INIT_EXT;
>> +    uint64_t outargflags = flags;
>> +
>> +#ifdef CONFIG_LINUX_IO_URING
>> +    if (exp->is_uring)
>> +        outargflags |= FUSE_OVER_IO_URING;
>> +#endif
>>
>>       *out = (struct fuse_init_out) {
>>           .major = FUSE_KERNEL_VERSION,
>>           .minor = FUSE_KERNEL_MINOR_VERSION,
>>           .max_readahead = max_readahead,
>>           .max_write = FUSE_MAX_WRITE_BYTES,
>> -        .flags = flags & supported_flags,
>> -        .flags2 = 0,
>> +        .flags = outargflags & supported_flags,
>> +        .flags2 = outargflags >> 32,
>>
>>           /* libfuse maximum: 2^16 - 1 */
>>           .max_background = UINT16_MAX,
>> @@ -943,6 +1133,9 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
>>    * Data in @in_place_buf is assumed to be overwritten after yielding, so will
>>    * be copied to a bounce buffer beforehand.  @spillover_buf in contrast is
>>    * assumed to be exclusively owned and will be used as-is.
>> + * In FUSE-over-io_uring mode, the actual op_payload content is stored in
>> + * @spillover_buf. To ensure this buffer is used for writing, @in_place_buf
>> + * is explicitly set to NULL.
>>    * Return the number of bytes written to *out on success, and -errno on error.
>>    */
>>   static ssize_t coroutine_fn
>> @@ -950,8 +1143,8 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
>>                 uint64_t offset, uint32_t size,
>>                 const void *in_place_buf, const void *spillover_buf)
>>   {
>> -    size_t in_place_size;
>> -    void *copied;
>> +    size_t in_place_size = 0;
>> +    void *copied = NULL;
>>       int64_t blk_len;
>>       int ret;
>>       struct iovec iov[2];
>> @@ -966,10 +1159,12 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
>>           return -EACCES;
>>       }
>>
>> -    /* Must copy to bounce buffer before potentially yielding */
>> -    in_place_size = MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
>> -    copied = blk_blockalign(exp->common.blk, in_place_size);
>> -    memcpy(copied, in_place_buf, in_place_size);
>> +    if (in_place_buf) {
>> +        /* Must copy to bounce buffer before potentially yielding */
>> +        in_place_size = MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
>> +        copied = blk_blockalign(exp->common.blk, in_place_size);
>> +        memcpy(copied, in_place_buf, in_place_size);
>> +    }
>>
>>       /**
>>        * Clients will expect short writes at EOF, so we have to limit
>> @@ -993,26 +1188,37 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
>>           }
>>       }
>>
>> -    iov[0] = (struct iovec) {
>> -        .iov_base = copied,
>> -        .iov_len = in_place_size,
>> -    };
>> -    if (size > FUSE_IN_PLACE_WRITE_BYTES) {
>> -        assert(size - FUSE_IN_PLACE_WRITE_BYTES <= FUSE_SPILLOVER_BUF_SIZE);
>> -        iov[1] = (struct iovec) {
>> -            .iov_base = (void *)spillover_buf,
>> -            .iov_len = size - FUSE_IN_PLACE_WRITE_BYTES,
>> +    if (in_place_buf) {
>> +        iov[0] = (struct iovec) {
>> +            .iov_base = copied,
>> +            .iov_len = in_place_size,
>>           };
>> -        qemu_iovec_init_external(&qiov, iov, 2);
>> +        if (size > FUSE_IN_PLACE_WRITE_BYTES) {
>> +            assert(size - FUSE_IN_PLACE_WRITE_BYTES <= FUSE_SPILLOVER_BUF_SIZE);
>> +            iov[1] = (struct iovec) {
>> +                .iov_base = (void *)spillover_buf,
>> +                .iov_len = size - FUSE_IN_PLACE_WRITE_BYTES,
>> +            };
>> +            qemu_iovec_init_external(&qiov, iov, 2);
>> +        } else {
>> +            qemu_iovec_init_external(&qiov, iov, 1);
>> +        }
>>       } else {
>> +        /* fuse over io_uring */
>> +        iov[0] = (struct iovec) {
>> +            .iov_base = (void *)spillover_buf,
>> +            .iov_len = size,
>> +        };
>>           qemu_iovec_init_external(&qiov, iov, 1);
>>       }
>> +
>>       ret = blk_co_pwritev(exp->common.blk, offset, size, &qiov, 0);
>>       if (ret < 0) {
>>           goto fail_free_buffer;
>>       }
>>
>> -    qemu_vfree(copied);
>> +    if (in_place_buf)
>> +        qemu_vfree(copied);
>>
>>       *out = (struct fuse_write_out) {
>>           .size = size,
>> @@ -1020,7 +1226,9 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
>>       return sizeof(*out);
>>
>>   fail_free_buffer:
>> -    qemu_vfree(copied);
>> +    if (in_place_buf) {
>> +        qemu_vfree(copied);
>> +    }
>>       return ret;
>>   }
>>
>> @@ -1409,6 +1617,12 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
>>           const struct fuse_init_in *in = FUSE_IN_OP_STRUCT(init, q);
>>           ret = fuse_co_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
>>                              in->max_readahead, in->flags);
>> +#ifdef CONFIG_LINUX_IO_URING
>> +        /* Set up fuse over io_uring after replying to the first FUSE_INIT */
>> +        if (exp->is_uring) {
>> +            fuse_uring_start(exp, FUSE_OUT_OP_STRUCT(init, out_buf));
>> +        }
>> +#endif
>>           break;
>>       }
>>
>> @@ -1515,6 +1729,173 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
>>       qemu_vfree(spillover_buf);
>>   }
>>
>> +#ifdef CONFIG_LINUX_IO_URING
>> +static void fuse_uring_prep_sqe_commit(struct io_uring_sqe *sqe, void *opaque)
>> +{
>> +    FuseRingEnt *ent = opaque;
>> +    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
>> +
>> +    fuse_uring_sqe_prepare(sqe, ent, FUSE_IO_URING_CMD_COMMIT_AND_FETCH);
>> +    fuse_uring_sqe_set_req_data(req, ent->q->qid,
>> +                                     ent->req_commit_id);
>> +}
>> +
>> +static void
>> +fuse_uring_write_response(FuseRingEnt *ent, uint32_t req_id, ssize_t ret,
>> +                          const void *out_op_hdr, const void *buf)
>> +{
>> +    struct fuse_uring_req_header *rrh = ent->req_header;
>> +    struct fuse_out_header *out_header = (struct fuse_out_header *)&rrh->in_out;
>> +    struct fuse_uring_ent_in_out *ent_in_out =
>> +        (struct fuse_uring_ent_in_out *)&rrh->ring_ent_in_out;
>> +
>> +    if (buf) {
>> +        memcpy(ent->op_payload, buf, ret);
>> +    } else if (ret > 0) {
>> +        if (ret > ent->req_payload_sz) {
>> +            warn_report("data size %zu exceeds payload buffer size %zu",
>> +                        ret, ent->req_payload_sz);
>> +                        ret = -EINVAL;
>> +        } else {
>> +            memcpy(ent->op_payload, out_op_hdr, ret);
>> +        }
>> +    }
>> +
>> +    out_header->error  = ret < 0 ? ret : 0;
>> +    out_header->unique = req_id;
>> +    /* out_header->len = ret > 0 ? ret : 0; */
>> +    ent_in_out->payload_sz = ret > 0 ? ret : 0;
>> +
>> +    aio_add_sqe(fuse_uring_prep_sqe_commit, ent,
>> +                    &ent->fuse_cqe_handler);
>> +}
>> +
>> +static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *ent)
>> +{
>> +    FuseQueue *q = ent->q;
>> +    FuseExport *exp = q->exp;
>> +    struct fuse_uring_req_header *rrh = ent->req_header;
>> +    struct fuse_uring_ent_in_out *ent_in_out =
>> +        (struct fuse_uring_ent_in_out *)&rrh->ring_ent_in_out;
>> +
>> +    char out_op_hdr[MAX_CONST(sizeof(struct fuse_init_out),
>> +                 MAX_CONST(sizeof(struct fuse_open_out),
>> +                 MAX_CONST(sizeof(struct fuse_attr_out),
>> +                 MAX_CONST(sizeof(struct fuse_write_out),
>> +                           sizeof(struct fuse_lseek_out)))))];
>
> A union would be cleaner because the casts below could be avoided and
> MAX_CONST() would be unnecessary:
>
>    union {
>        struct fuse_init_out init;
>        struct fuse_open out open;
>        struct fuse_attr_out attr;
>        struct fuse_write_out write;
>        struct fuse_lseek_out lseek;
>    } out_op_hdr;

Yep, makes sense

>> +
>> +    void *out_data_buffer = NULL;
>> +
>> +    uint32_t opcode;
>> +    uint64_t req_id;
>> +
>> +    struct fuse_in_header *in_hdr = (struct fuse_in_header *)&rrh->in_out;
>> +    opcode = in_hdr->opcode;
>> +    req_id = in_hdr->unique;
>> +
>> +    ent->req_commit_id = ent_in_out->commit_id;
>> +
>> +    if (unlikely(ent->req_commit_id == 0)) {
>> +        /*
>> +         * If this happens kernel will not find the response - it will
>> +         * be stuck forever - better to abort immediately.
>> +         */
>> +        error_report("If this happens kernel will not find the response"
>> +        " - it will be stuck forever - better to abort immediately.");
>> +        fuse_export_halt(exp);
>> +        fuse_dec_in_flight(exp);
>> +        return;
>> +    }
>> +
>> +    ssize_t ret;
>> +
>> +    switch (opcode) {
>> +    case FUSE_OPEN:
>> +        ret = fuse_co_open(exp, (struct fuse_open_out *)out_op_hdr);
>> +        break;
>> +
>> +    case FUSE_RELEASE:
>> +        ret = 0;
>> +        break;
>> +
>> +    case FUSE_LOOKUP:
>> +        ret = -ENOENT; /* There is no node but the root node */
>> +        break;
>> +
>> +    case FUSE_GETATTR:
>> +        ret = fuse_co_getattr(exp, (struct fuse_attr_out *)out_op_hdr);
>> +        break;
>> +
>> +    case FUSE_SETATTR: {
>> +        const struct fuse_setattr_in *in =
>> +                        (const struct fuse_setattr_in *)&rrh->op_in;
>> +        ret = fuse_co_setattr(exp, (struct fuse_attr_out *)out_op_hdr,
>> +                              in->valid, in->size, in->mode, in->uid, in->gid);
>> +        break;
>> +    }
>> +
>> +    case FUSE_READ: {
>> +        const struct fuse_read_in *in =
>> +                        (const struct fuse_read_in *)&rrh->op_in;
>> +        ret = fuse_co_read(exp, &out_data_buffer, in->offset, in->size);
>> +        break;
>> +    }
>> +
>> +    case FUSE_WRITE: {
>> +        const struct fuse_write_in *in =
>> +                        (const struct fuse_write_in *)&rrh->op_in;
>> +
>> +        assert(in->size == ent_in_out->payload_sz);
>> +
>> +        /*
>> +         * poll_fuse_fd() has checked that in_hdr->len matches the number of
>> +         * bytes read, which cannot exceed the max_write value we set
>> +         * (FUSE_MAX_WRITE_BYTES).  So we know that FUSE_MAX_WRITE_BYTES >=
>> +         * in_hdr->len >= in->size + X, so this assertion must hold.
>> +         */
>> +        assert(in->size <= FUSE_MAX_WRITE_BYTES);
>> +
>> +        ret = fuse_co_write(exp, (struct fuse_write_out *)out_op_hdr,
>> +                            in->offset, in->size, NULL, ent->op_payload);
>> +        break;
>> +    }
>> +
>> +    case FUSE_FALLOCATE: {
>> +        const struct fuse_fallocate_in *in =
>> +                        (const struct fuse_fallocate_in *)&rrh->op_in;
>> +        ret = fuse_co_fallocate(exp, in->offset, in->length, in->mode);
>> +        break;
>> +    }
>> +
>> +    case FUSE_FSYNC:
>> +        ret = fuse_co_fsync(exp);
>> +        break;
>> +
>> +    case FUSE_FLUSH:
>> +        ret = fuse_co_flush(exp);
>> +        break;
>> +
>> +#ifdef CONFIG_FUSE_LSEEK
>> +    case FUSE_LSEEK: {
>> +        const struct fuse_lseek_in *in =
>> +                        (const struct fuse_lseek_in *)&rrh->op_in;
>> +        ret = fuse_co_lseek(exp, (struct fuse_lseek_out *)out_op_hdr,
>> +                            in->offset, in->whence);
>> +        break;
>> +    }
>> +#endif
>> +
>> +    default:
>> +        ret = -ENOSYS;
>> +    }
>
> It would be nice to reuse the non-io_uring code rather than duplicating
> the switch statement that covers each FUSE opcode. Is the memory layout
> so different that the code cannot be shared?
>

Yes. But I think the main issue is that we have to handle too many
differences when it comes to various operations and the final step of
replying to the request. There would be a lot of #ifdef
CONFIG_LINUX_IO_URING and if statements. So, for simplicity, I made it a
separate function.

In the traditional model:
q->request_buf = fuse_in_header + struct fuse_opsxx_in +
FUSE_IN_PLACE_WRITE_BYTES (used for part of the payload data)
q->spillover_buf is used for the rest of the payload data.

In Fuse-over-io_uring:
FuseRingEnt contains req_header (which includes in_out for
fuse_in/out_header, and op_in for struct fuse_opsxx_in)
op_payload corresponds to the final FUSE_IN_PLACE_WRITE_BYTES bytes from
request_buf + spillover_buf in the traditional model but carries either
the out operation headers (fuse_ops_out) or the file data to be written
or read.


>> +
>> +    fuse_uring_write_response(ent, req_id, ret, out_op_hdr, out_data_buffer);
>> +
>> +    if (out_data_buffer)
>> +        qemu_vfree(out_data_buffer);
>> +}
>> +#endif
>> +
>>   const BlockExportDriver blk_exp_fuse = {
>>       .type               = BLOCK_EXPORT_TYPE_FUSE,
>>       .instance_size      = sizeof(FuseExport),
>> diff --git a/docs/tools/qemu-storage-daemon.rst b/docs/tools/qemu-storage-daemon.rst
>> index 35ab2d7807..4ec0648e95 100644
>> --- a/docs/tools/qemu-storage-daemon.rst
>> +++ b/docs/tools/qemu-storage-daemon.rst
>> @@ -78,7 +78,7 @@ Standard options:
>>   .. option:: --export [type=]nbd,id=<id>,node-name=<node-name>[,name=<export-name>][,writable=on|off][,bitmap=<name>]
>>     --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=unix,addr.path=<socket-path>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
>>     --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=fd,addr.str=<fd>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
>> -  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto]
>> +  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto][,uring=on|off]
>>     --export [type=]vduse-blk,id=<id>,node-name=<node-name>,name=<vduse-name>[,writable=on|off][,num-queues=<num-queues>][,queue-size=<queue-size>][,logical-block-size=<block-size>][,serial=<serial-number>]
>>
>>     is a block export definition. ``node-name`` is the block node that should be
>> @@ -111,7 +111,13 @@ Standard options:
>>     that enabling this option as a non-root user requires enabling the
>>     user_allow_other option in the global fuse.conf configuration file.  Setting
>>     ``allow-other`` to auto (the default) will try enabling this option, and on
>> -  error fall back to disabling it.
>> +  error fall back to disabling it. Once ``uring`` is enabled
>> +  (off by default), the initialization of FUSE-over-io_uring-related settings
>> +  will be performed in the FUSE_INIT request handler. This setup bypasses
>> +  the traditional /dev/fuse communication mechanism and instead uses io_uring
>> +  for handling FUSE operations.
>> +
>> +
>>
>>     The ``vduse-blk`` export type takes a ``name`` (must be unique across the host)
>>     to create the VDUSE device.
>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>> index 9ae703ad01..7d14f3f1ba 100644
>> --- a/qapi/block-export.json
>> +++ b/qapi/block-export.json
>> @@ -184,12 +184,16 @@
>>   #     mount the export with allow_other, and if that fails, try again
>>   #     without.  (since 6.1; default: auto)
>>   #
>> +# @uring: If we enable uring option, it will enable FUSE over io_uring
>> +#         feature for QEMU FUSE export.  (default: false)
>> +#
>>   # Since: 6.0
>>   ##
>>   { 'struct': 'BlockExportOptionsFuse',
>>     'data': { 'mountpoint': 'str',
>>               '*growable': 'bool',
>> -            '*allow-other': 'FuseExportAllowOther' },
>> +            '*allow-other': 'FuseExportAllowOther',
>> +            '*uring': 'bool' },
>>     'if': 'CONFIG_FUSE' }
>>
>>   ##
>> diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
>> index eb72561358..803538db29 100644
>> --- a/storage-daemon/qemu-storage-daemon.c
>> +++ b/storage-daemon/qemu-storage-daemon.c
>> @@ -107,6 +107,7 @@ static void help(void)
>>   #ifdef CONFIG_FUSE
>>   "  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>\n"
>>   "           [,growable=on|off][,writable=on|off][,allow-other=on|off|auto]\n"
>> +"           [,fuse-over-uring=on|off]"
>>   "                         export the specified block node over FUSE\n"
>>   "\n"
>>   #endif /* CONFIG_FUSE */
>> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
>> index d2433d1d99..68d3fe8e01 100644
>> --- a/util/fdmon-io_uring.c
>> +++ b/util/fdmon-io_uring.c
>> @@ -452,10 +452,13 @@ static const FDMonOps fdmon_io_uring_ops = {
>>   void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
>>   {
>>       int ret;
>> +    int flags;
>>
>>       ctx->io_uring_fd_tag = NULL;
>> +    flags = IORING_SETUP_SQE128;
>>
>> -    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, 0);
>> +    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES,
>> +                            &ctx->fdmon_io_uring, flags);
>>       if (ret != 0) {
>>           error_setg_errno(errp, -ret, "Failed to initialize io_uring");
>>           return;
>> --
>> 2.50.1
>>

