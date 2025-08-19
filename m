Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8909CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 22:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoUnD-0002LQ-MK; Tue, 19 Aug 2025 18:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bernd@bsbernd.com>)
 id 1uoUn8-0002FJ-Rx; Tue, 19 Aug 2025 18:26:55 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bernd@bsbernd.com>)
 id 1uoUn5-0006Ct-70; Tue, 19 Aug 2025 18:26:54 -0400
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id AB5AAEC0498;
 Tue, 19 Aug 2025 18:26:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Tue, 19 Aug 2025 18:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1755642408;
 x=1755728808; bh=YrjN8JaFB7zZxvdOBy35FFjNrz+KzjkHaom4E62HN/M=; b=
 jj/F0phyYX4L6eScInfCH3vnWjdpCUzDHa/FU/+A0ASGdRBIWSOllAnxmqemNQoo
 WZ5C8BX1zhPh5NR/mEsl6hTUz6ecIVOlH037vp+7+oDqZQ2x8S/m0ocoJi0dBTub
 Tft93+AsCUbI4c8B2UTEfB4iFSJQd1IRnqdAEa8U5f2/T+VFzADw42XAaVxcPkUn
 QhLZICUZB0eTL02iDN7QzqCayP05JG2Js0bjj3cxz4NpqQbwwaOsl82xxggKUhsh
 WA6yPt2GywVb/uxSQCiEQDDU8VaYzhfAXKx2cnEn+osGC+Lwm0JJ7K211lvtRnhQ
 Ybx45bTphpQOfPP0sEpI7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755642408; x=
 1755728808; bh=YrjN8JaFB7zZxvdOBy35FFjNrz+KzjkHaom4E62HN/M=; b=E
 iv+79Kjvydjsybkm6rXXCdShfFgn/Uy7oTEFrQVemkk0DdK7qDTr7JwNTXujmrun
 MdFRW5dtMPCYa943oimzchB61wQ4957X4OPd3T0cDdXmo2Qbey9HGAs9kwfrkQzM
 3K8c331szVb1xGh5OKfBsKl046Dwd1VJXlwlOOldIWmEfPXMsOpisGuPJGO3idkx
 Q9Rq+coxcLR/Za05dfCTmFbYkvcTQ9H/5iCBLQzZViTtyjDNbJWSwbtf4tetbkOG
 XnaDkgI1gadc8ZpWczMdfQnU3HuGFDy9yzSQzZlnh6sRfn9hJ3Yy+4orGuCnfz96
 K4R7MtBfkcTmzPrP9GdVw==
X-ME-Sender: <xms:J_qkaLk9LFXcAltvkX3cWX2f4Bn4OjbgH59IvwwhOalyffUVpIIzWA>
 <xme:J_qkaGfZsMtCuxAnwE2n9dAGAfA0zg0LBYuLSwy0Z3-CpLxYX9xhHvKK3QZclZBO8
 j3VZ2jzPGm4G1dT>
X-ME-Received: <xmr:J_qkaPQV_OjKvW5Vm8NWbaKAYaatsGXBLYG9PGkZOB6zhkMbT2Igt8nSBW1piLBRjQjyoRV2QsZ0hQe61_aFT06ft11AOxcu3xWNbSl8iJtEmc-DIxA8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeiieekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
 ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
 htthgvrhhnpeetiefgkefgteegledvjeeiueehfffhjeekjefgheejjeejgeeuudehgfel
 geevtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
 evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
 segsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpoh
 huthdprhgtphhtthhopehhihgsrhhirghnshhonhhgsehgmhgrihhlrdgtohhmpdhrtghp
 thhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvg
 hmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheprghrmhgsrhhusehr
 vgguhhgrthdrtghomhdprhgtphhtthhopehfrghmsegvuhhphhhonhdrnhgvthdprhgtph
 htthhopehhrhgvihhtiiesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhifohhlfhes
 rhgvughhrghtrdgtohhmpdhrtghpthhtohepshhtvghfrghnhhgrsehrvgguhhgrthdrtg
 homh
X-ME-Proxy: <xmx:J_qkaNtOixdRWtqBgReHBem-OYESkiFOK8OoyIOX9Yd_HQnk7aPGwA>
 <xmx:KPqkaAdz9j9DDG7dATetxZ8HuFZ2pGWS5PXRYfsajJUsrJ5m0Brcxg>
 <xmx:KPqkaHbS-ev6pfAZsu_XMCGLmriOII5P2tDdiJQUG3-okgvRjA1tZg>
 <xmx:KPqkaCae9CXLHFrwNUrlL-U9F7Ky5vNHmi0fDO6xw6q-WMajFclABg>
 <xmx:KPqkaJtOg8tCTiLhpunQlqsnM4TdZrnX3FvqXFFLbZne7ecKmq1ar0qi>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 18:26:46 -0400 (EDT)
Message-ID: <4896b694-6f00-49d9-ad8e-04225824eb6c@bsbernd.com>
Date: Wed, 20 Aug 2025 00:26:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fuse: add FUSE-over-io_uring enable opt and init
To: Brian Song <hibriansong@gmail.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, fam@euphon.net,
 hreitz@redhat.com, kwolf@redhat.com, stefanha@redhat.com
References: <20250815034619.51980-1-hizhisong@gmail.com>
 <20250815034619.51980-2-hizhisong@gmail.com>
 <beb43845-a761-4031-a7b7-aaca56abb6de@gmail.com>
 <105d583b-e931-4e60-a113-9a571c18c726@bsbernd.com>
 <a76de187-f181-47d3-a36e-6eb1a865cc5e@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <a76de187-f181-47d3-a36e-6eb1a865cc5e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.150; envelope-from=bernd@bsbernd.com;
 helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



On 8/19/25 03:15, Brian Song wrote:
> 
> 
> On 8/18/25 7:04 PM, Bernd Schubert wrote:
>>
>>
>> On 8/17/25 01:13, Brian Song wrote:
>>>
>>>
>>> On 8/14/25 11:46 PM, Brian Song wrote:
>>>> From: Brian Song <hibriansong@gmail.com>
>>>>
>>>> This patch adds a new export option for storage-export-daemon to enable
>>>> or disable FUSE-over-io_uring via the switch io-uring=on|off (disable
>>>> by default). It also implements the protocol handshake with the Linux
>>>> kernel during the FUSE-over-io_uring initialization phase.
>>>>
>>>> See: https://docs.kernel.org/filesystems/fuse-io-uring.html
>>>>
>>>> The kernel documentation describes in detail how FUSE-over-io_uring
>>>> works. This patch implements the Initial SQE stage shown in thediagram:
>>>> it initializes one queue per IOThread, each currently supporting a
>>>> single submission queue entry (SQE). When the FUSE driver sends the
>>>> first FUSE request (FUSE_INIT), storage-export-daemon calls
>>>> fuse_uring_start() to complete initialization, ultimately submitting
>>>> the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
>>>> successful initialization with the kernel.
>>>>
>>>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>>>> ---
>>>>    block/export/fuse.c                  | 161 ++++++++++++++++++++++++---
>>>>    docs/tools/qemu-storage-daemon.rst   |  11 +-
>>>>    qapi/block-export.json               |   5 +-
>>>>    storage-daemon/qemu-storage-daemon.c |   1 +
>>>>    util/fdmon-io_uring.c                |   5 +-
>>>>    5 files changed, 159 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>>>> index c0ad4696ce..59fa79f486 100644
>>>> --- a/block/export/fuse.c
>>>> +++ b/block/export/fuse.c
>>>> @@ -48,6 +48,11 @@
>>>>    #include <linux/fs.h>
>>>>    #endif
>>>>
>>>> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
>>>> +
>>>> +/* room needed in buffer to accommodate header */
>>>> +#define FUSE_BUFFER_HEADER_SIZE 0x1000
>>>> +
>>>>    /* Prevent overly long bounce buffer allocations */
>>>>    #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
>>>>    /*
>>>> @@ -63,12 +68,31 @@
>>>>        (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
>>>>
>>>>    typedef struct FuseExport FuseExport;
>>>> +typedef struct FuseQueue FuseQueue;
>>>> +
>>>> +typedef struct FuseRingEnt {
>>>> +    /* back pointer */
>>>> +    FuseQueue *q;
>>>> +
>>>> +    /* commit id of a fuse request */
>>>> +    uint64_t req_commit_id;
>>>> +
>>>> +    /* fuse request header and payload */
>>>> +    struct fuse_uring_req_header req_header;
>>>> +    void *op_payload;
>>>> +    size_t req_payload_sz;
>>>> +
>>>> +    /* The vector passed to the kernel */
>>>> +    struct iovec iov[2];
>>>> +
>>>> +    CqeHandler fuse_cqe_handler;
>>>> +} FuseRingEnt;
>>>>
>>>>    /*
>>>>     * One FUSE "queue", representing one FUSE FD from which requests are fetched
>>>>     * and processed.  Each queue is tied to an AioContext.
>>>>     */
>>>> -typedef struct FuseQueue {
>>>> +struct FuseQueue {
>>>>        FuseExport *exp;
>>>>
>>>>        AioContext *ctx;
>>>> @@ -109,7 +133,12 @@ typedef struct FuseQueue {
>>>>         * Free this buffer with qemu_vfree().
>>>>         */
>>>>        void *spillover_buf;
>>>> -} FuseQueue;
>>>> +
>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>> +    int qid;
>>>> +    FuseRingEnt ent;
>>>> +#endif
>>>> +};
>>>>
>>>>    /*
>>>>     * Verify that FuseQueue.request_buf plus the spill-over buffer together
>>>> @@ -148,6 +177,7 @@ struct FuseExport {
>>>>        bool growable;
>>>>        /* Whether allow_other was used as a mount option or not */
>>>>        bool allow_other;
>>>> +    bool is_uring;
>>>>
>>>>        mode_t st_mode;
>>>>        uid_t st_uid;
>>>> @@ -257,6 +287,93 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
>>>>        .drained_poll  = fuse_export_drained_poll,
>>>>    };
>>>>
>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>> +
>>>> +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
>>>> +                    const unsigned int qid,
>>>> +                    const unsigned int commit_id)
>>>> +{
>>>> +    req->qid = qid;
>>>> +    req->commit_id = commit_id;
>>>> +    req->flags = 0;
>>>> +}
>>>> +
>>>> +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q,
>>>> +               __u32 cmd_op)
>>>> +{
>>>> +    sqe->opcode = IORING_OP_URING_CMD;
>>>> +
>>>> +    sqe->fd = q->fuse_fd;
>>>> +    sqe->rw_flags = 0;
>>>> +    sqe->ioprio = 0;
>>>> +    sqe->off = 0;
>>>> +
>>>> +    sqe->cmd_op = cmd_op;
>>>> +    sqe->__pad1 = 0;
>>>> +}
>>>> +
>>>> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void *opaque)
>>>> +{
>>>> +    FuseQueue *q = opaque;
>>>> +    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
>>>> +
>>>> +    fuse_uring_sqe_prepare(sqe, q, FUSE_IO_URING_CMD_REGISTER);
>>>> +
>>>> +    sqe->addr = (uint64_t)(q->ent.iov);
>>>> +    sqe->len = 2;
>>>> +
>>>> +    fuse_uring_sqe_set_req_data(req, q->qid, 0);
>>>> +}
>>>> +
>>>> +static void fuse_uring_submit_register(void *opaque)
>>>> +{
>>>> +    FuseQueue *q = opaque;
>>>> +    FuseExport *exp = q->exp;
>>>> +
>>>> +
>>>> +    aio_add_sqe(fuse_uring_prep_sqe_register, q, &(q->ent.fuse_cqe_handler));
>>>
>>> I think there might be a tricky issue with the io_uring integration in
>>> QEMU. Currently, when the number of IOThreads goes above ~6 or 7,
>>> there’s a pretty high chance of a hang. I added some debug logging in
>>> the kernel’s fuse_uring_cmd() registration part, and noticed that the
>>> number of register calls is less than the total number of entries in the
>>> queue. In theory, we should be registering each entry for each queue.
>>
>> Did you also try to add logging at the top of fuse_uring_cmd()? I wonder
>> if there is a start up race and if initial commands are just getting
>> refused. I had run into issues you are describing in some versions of
>> the -rfc patches, but thought that everything was fixed for that.
>> I.e. not excluded that there is still a kernel issue left.
>>
>> Thanks,
>> Bernd
>>
>>
> 
> Yes. I added a printk at the beginning of fuse_uring_cmd(), another at 
> the beginning of fuse_uring_register(), and one more at the end of 
> fuse_uring_do_register(). Then I created and registered 20 queues, each 
> with a single ring entry. It printed 37 times(diff every time) with 
> opcode FUSE_IO_URING_CMD_REGISTER (would expect 20), and only 6 queues 
> were registered successfully. The rest of fuse_uring_cmd (x31) exited 
> inside the if (!fc->initialized) branch in fuse_uring_cmd()
> 
> dmesg: https://gist.github.com/hibriansong/4eda6e7e92601df497282dcd56fd5470

Thank you for the logs, could you try this?

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 2aa20707f40b..cea57ad5d3ab 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1324,6 +1324,9 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
        if (!fc->connected)
                return -ENOTCONN;
 
+       /* Matches smp_wmb() in fuse_set_initialized() */
+       smp_rmb();
+
        /*
         * fuse_uring_register() needs the ring to be initialized,
         * we need to know the max payload size



Thanks,
Bernd

