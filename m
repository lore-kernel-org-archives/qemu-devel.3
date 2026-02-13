Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D63EF48ED
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqp5o-0004Hi-2h; Fri, 13 Feb 2026 04:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1vqp5m-0004HI-My
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:04:02 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1vqp5j-0004wT-VH
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:04:02 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2aadc18f230so4966355ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 01:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770973438; x=1771578238; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqF69bYdGyQE2o5rbNrFzroUhHngMZU0JTCZonaReQA=;
 b=gozQUT5frBpMkC+k2aNJJD151GqmZXv30YSWHYu2/XJarJrJjvfm8Sc24snJKvE6hS
 6kF/iODnce86WfnRpdGwAGNWwXfmvLTVFtLjN8+l82SM7bWOuE2bPKkWdhEb+wyIiQtp
 cgME0nWw6WTzODJ0PttqILI2/TLsGsbPF3xZT0I3luGX/XLiJiHZzB/R2v8j5rdisuv7
 HcOkuR09msetcb54T66UbL++gwrBfuDGN1JhOrD4DA74FznzKWLUYBvm64yXI5IU+nQ0
 fKl6NfVU0jlBRAPQ5PNT89RCGXbEai5y7r99nrkdR4Vjmm4L4361U9vuPZ4QHQhaNog5
 fcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770973438; x=1771578238;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sqF69bYdGyQE2o5rbNrFzroUhHngMZU0JTCZonaReQA=;
 b=Yurht6IlsUBUOXJLoyNXC+caCUdkiRkeWUmeErVWZ3RzRR+4KxZHIFMSqMurRjwXbX
 HF7Z57K9/iGaQpWcM/tBQIgS56N+0cd+6U0vNOCa5nkg7BzQ6Q/RGHBuCNiBsPt7rWeW
 LmtvZ+BsTIpkmYIWko1p8PGvHu5cLJ6I5DVp13/UzCzgpVCSNvgfib8MeIRsLA93Tiyh
 tuRYft0XuqK+gwIKBfjgsKBQlSSPeFOZ68/Mq+MY2e/DEoh4ePXSdG7iQ0EtMijjjYGe
 ek282vyUbtqzpCQX6juj0gupA07Y6ksdMN7UPR9pFnTOry6yzPKUrZIJaA84LT6tqEhb
 Nshg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr27Tnw6ecCQbLks9Wa1bauJEa02T698cPmhV9etmbb/m5qJ9XudIqnScuTNLnAfKsuuvCalsh1Kye@nongnu.org
X-Gm-Message-State: AOJu0Yzt+FdaF/+D7E7yEG4BXGrqi6/512SN0/jACymb9xcN8o/enZE5
 USng2XateyCgz5zxAF1q7FtK0sYWB10LlVbpHepgndap/S/C+9V4akGk
X-Gm-Gg: AZuq6aJvECz+VuFm84vv51fnSSCZ4AwxoAOtPb88ebsaXhGA5GeHl/xncH6d5fZa6fp
 SoGuFBBhAJr1xUhvZPr5ON6LXXK5nnPeXfyYZcvG3GM3AZQ/VLBwQWc4JaMtWGopCP6pZwy0yvy
 Vc1ToSolJw02NtmxiR1npKbrMJ/OndH46GTSNUxaaS3obJCFN4IoWa2ry4ZxdlSLZlrHkuKYGcF
 QESTgM1wztDFYRGuJRPO5jHyRoQsZ9FbdES1iz7kvr64PK5FlS94aDqyi6TkwXMoJJrP1xy/LcI
 FzsYpIzfwtaEfJFGt5blVQWi9nfdmD84Og7pOg9uipGheLJr4qnK+V4sG4nDTppAfOkHU+ce5lm
 p81rlHXrDK7uM/n08GM0p8zVA0RvUfOGSzeKt9/GjIF4lJi5k3BgU2S2LrE0eoS2Ws7QIO77oSj
 1bwgnvp4fyOgN/GWT7JPUkc2UZIElkuqghKIvRkhooPCh7gxnw/FroGCm+p9cd
X-Received: by 2002:a17:903:1109:b0:2aa:fad8:7478 with SMTP id
 d9443c01a7336-2ab5051a141mr12445855ad.10.1770973438109; 
 Fri, 13 Feb 2026 01:03:58 -0800 (PST)
Received: from smtpclient.apple (n058152022160.netvigator.com. [58.152.22.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29966d91sm81576095ad.45.2026.02.13.01.03.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Feb 2026 01:03:57 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [Patch v4 2/7] fuse: io_uring mode init
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <20260211205611.GB234157@fedora>
Date: Fri, 13 Feb 2026 17:03:23 +0800
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, fam@euphon.net,
 bernd@bsbernd.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C001D79E-6269-4DC7-ABD3-AE86B8122909@gmail.com>
References: <20260207120901.17222-1-hibriansong@gmail.com>
 <20260207120901.17222-3-hibriansong@gmail.com>
 <20260211205611.GB234157@fedora>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=hibriansong@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On Feb 12, 2026, at 04:56, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Sat, Feb 07, 2026 at 08:08:56PM +0800, Brian Song wrote:
>> +typedef struct FuseUringEnt {
>> +    /* back pointer */
>> +    FuseUringQueue *rq;
>> +
>> +    /* commit id of a fuse request */
>> +    uint64_t req_commit_id;

[...]

>> +
>> +/**
>> + * Distribute uring queues across FUSE queues in the round-robin =
manner.
>> + * This ensures even distribution of kernel uring queues across =
user-specified
>> + * FUSE queues.
>> + *
>> + * num_uring_queues > num_fuse_queues: Each IOThread manages =
multiple uring
>> + * queues (multi-queue mapping).
>> + * num_uring_queues < num_fuse_queues: Excess IOThreads remain idle =
with no
>> + * assigned uring queues.
>> + */
>> +static void fuse_uring_setup_queues(FuseExport *exp, size_t bufsize)
>> +{
>> +    int num_uring_queues =3D get_nprocs_conf();
>> +
>> +    exp->num_uring_queues =3D num_uring_queues;
>> +    exp->uring_queues =3D g_new(FuseUringQueue, num_uring_queues);
>> +
>> +    for (int i =3D 0; i < num_uring_queues; i++) {
>> +        FuseUringQueue *rq =3D &exp->uring_queues[i];
>> +        rq->rqid =3D i;
>> +        rq->ent =3D g_new(FuseUringEnt, exp->uring_queue_depth);
>> +
>> +        for (int j =3D 0; j < exp->uring_queue_depth; j++) {
>> +            FuseUringEnt *ent =3D &rq->ent[j];
>> +            ent->rq =3D rq;
>> +            ent->req_payload_sz =3D bufsize - =
FUSE_BUFFER_HEADER_SIZE;
>> +            ent->req_payload =3D g_malloc0(ent->req_payload_sz);
>=20
> I don't see a corresponding g_free() in this patch? Exports can be
> deleted at runtime, so this memory must be freed.
>=20

ent->req_payload is deleted in fuse_export_delete_uring() in a later =
patch.
Should we merge patch 5 into this one?

>> +
>> +            ent->iov[0] =3D (struct iovec) {
>> +                &ent->req_header,
>> +                sizeof(struct fuse_uring_req_header)
>> +            };
>> +            ent->iov[1] =3D (struct iovec) {
>> +                ent->req_payload,
>> +                ent->req_payload_sz
>> +            };
>> +
>> +            ent->fuse_cqe_handler.cb =3D fuse_uring_cqe_handler;
>> +        }
>> +
>> +        /* Distribute uring queues across FUSE queues */
>> +        rq->q =3D &exp->queues[i % exp->num_fuse_queues];
>> +        QLIST_INSERT_HEAD(&(rq->q->uring_queue_list), rq, next);
>> +    }
>> +}
>> +
>> +static void
>> +fuse_schedule_ring_queue_registrations(FuseExport *exp)
>> +{
>> +    for (int i =3D 0; i < exp->num_fuse_queues; i++) {
>> +        FuseQueue *q =3D &exp->queues[i];
>> +        FuseUringQueue *rq;
>> +
>> +        QLIST_FOREACH(rq, &q->uring_queue_list, next) {
>> +            aio_bh_schedule_oneshot(q->ctx, =
fuse_uring_submit_register, rq);
>> +        }
>> +    }
>> +}
>> +
>> +static void fuse_uring_start(FuseExport *exp, struct fuse_init_out =
*out)
>> +{
>> +    assert(!exp->uring_started);
>> +    exp->uring_started =3D true;
>> +
>> +    /*
>> +     * Since we dont't enable the FUSE_MAX_PAGES feature, the value =
of
>=20
> s/dont't/don't/


