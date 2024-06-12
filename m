Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105C6C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHPzo-0000Js-IR; Wed, 12 Jun 2024 11:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sHPzn-0000JW-4t
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:34:43 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sHPzl-00045x-8Y
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:34:42 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6f9398390fcso2153857a34.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718206480; x=1718811280; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ze8c5CsI/Ai9FlRhp5UjNXXdqYHhftXKuXJjvZtRXHo=;
 b=jpgdOrSsCvxDfd8qgq7sRVEzR59m5AZKKG7ixd/Z3VHCdsrd3DBc9Vx5Sd2p7VHy94
 /fzr2u72okEaJdYFFPNE4X1ARhUj2JrOyijTzRT43RF0Dfihglkobu65uBYnk9aUxEgb
 1bYiuKALoTlvLlb6/887MIGfsTn/PaNLHG41Euy8l4vtVnJ1BNXTbOR4jYiAQfkEHrfY
 TR7at7IgY5ZJgxstJA6a9/BiPSZcpjO+xQUWGBKHf369kQM5JkkSLwBBQoozJIB7CvF2
 rOKw+Ow3D8ncZHEQpALGezrsQJRpPpiipuF1YkRhEJfPyc1IQwaq5oSlZ3pA2GKXZO3o
 CBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718206480; x=1718811280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ze8c5CsI/Ai9FlRhp5UjNXXdqYHhftXKuXJjvZtRXHo=;
 b=GodghcB1XlaV/ahX+w/dtLyWuFd2bCmEjDKK6UrcGQYKWROICCOwQrPoe5nXW7wpyF
 0aHOSl5+wJQ3bmnqGXT8wVxzcNTg84OY3ijaeS0ZUQJBuK+O9OhBQPonNSef+efjOfu+
 BzFN30TjsihBW6Z7MvXU3pSKYPGjWoGLT2QQ41kq8rgZHNz7PDAD+1W0BA9KF8vzJVk6
 rVQdjZnssWtN/SULcWrLyjQO9m81vDBuv90d85KFeNTpe++XM9zMtVq7TS5YdimcUeaR
 yTS74M3ECm8yZPhp/ouPList9oA+fld2AQODNlNJot2D0cNvH1yGvf4QpabbFGoYCpCs
 lQ5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXZ6njwXQ7isBOtkxCxmLcWAR+bUafmeazZDH6SJrJXJzn1qZaY+Ml33zBgphLSx3LYFJGzjvChp50z/oRnPTLRbWQR/w=
X-Gm-Message-State: AOJu0YzYgntr6lVxy1lnfDc4QmvJ3VPvNsyK2V9c5yJbLkj1n7bQEL6/
 ngVoyR8PkUYnkrL6Ldk0QoFBCm/yac6Le6F5gwidJIzXbEhUweCs+oa08vPKN1UlS6L7prJdvRG
 WUzcjRsom5uby8k/cCau7vnH4OyA=
X-Google-Smtp-Source: AGHT+IGln0QWRufvTYnw0/bVcMD4gDRyS+19n3fc3TcaP4+8K78+319oHtR1jkF7Iqx82+8P9Pm/yWYYv/qJfBtqvys=
X-Received: by 2002:a9d:7501:0:b0:6fa:18e8:444a with SMTP id
 46e09a7af769-6fa1be2b43dmr2478567a34.4.1718206479347; Wed, 12 Jun 2024
 08:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240605120848.358654-1-f.ebner@proxmox.com>
 <20240606183638.GC198201@fedora.redhat.com>
 <6d64f07d-1638-44dc-848b-b307c0ebd0ad@proxmox.com>
 <20240611140449.GA366375@fedora.redhat.com>
 <08689bad-80f3-4cc1-bdd9-39df04b40d89@proxmox.com>
In-Reply-To: <08689bad-80f3-4cc1-bdd9-39df04b40d89@proxmox.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 12 Jun 2024 11:34:27 -0400
Message-ID: <CAJSP0QUJ2dsAgMaoesTSF7Ni+EPQsCxzOavTvU0sgj7h+7vkQg@mail.gmail.com>
Subject: Re: [RFC PATCH] migration/savevm: do not schedule snapshot_save_job_bh
 in qemu_aio_context
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, 
 farosas@suse.de, pbonzini@redhat.com, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 12 Jun 2024 at 05:21, Fiona Ebner <f.ebner@proxmox.com> wrote:
>
> Am 11.06.24 um 16:04 schrieb Stefan Hajnoczi:
> > On Tue, Jun 11, 2024 at 02:08:49PM +0200, Fiona Ebner wrote:
> >> Am 06.06.24 um 20:36 schrieb Stefan Hajnoczi:
> >>> On Wed, Jun 05, 2024 at 02:08:48PM +0200, Fiona Ebner wrote:
> >>>> The fact that the snapshot_save_job_bh() is scheduled in the main
> >>>> loop's qemu_aio_context AioContext means that it might get executed
> >>>> during a vCPU thread's aio_poll(). But saving of the VM state cannot
> >>>> happen while the guest or devices are active and can lead to assertion
> >>>> failures. See issue #2111 for two examples. Avoid the problem by
> >>>> scheduling the snapshot_save_job_bh() in the iohandler AioContext,
> >>>> which is not polled by vCPU threads.
> >>>>
> >>>> Solves Issue #2111.
> >>>>
> >>>> This change also solves the following issue:
> >>>>
> >>>> Since commit effd60c878 ("monitor: only run coroutine commands in
> >>>> qemu_aio_context"), the 'snapshot-save' QMP call would not respond
> >>>> right after starting the job anymore, but only after the job finished,
> >>>> which can take a long time. The reason is, because after commit
> >>>> effd60c878, do_qmp_dispatch_bh() runs in the iohandler AioContext.
> >>>> When do_qmp_dispatch_bh() wakes the qmp_dispatch() coroutine, the
> >>>> coroutine cannot be entered immediately anymore, but needs to be
> >>>> scheduled to the main loop's qemu_aio_context AioContext. But
> >>>> snapshot_save_job_bh() was scheduled first to the same AioContext and
> >>>> thus gets executed first.
> >>>>
> >>>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/2111
> >>>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> >>>> ---
> >>>>
> >>>> While initial smoke testing seems fine, I'm not familiar enough with
> >>>> this to rule out any pitfalls with the approach. Any reason why
> >>>> scheduling to the iohandler AioContext could be wrong here?
> >>>
> >>> If something waits for a BlockJob to finish using aio_poll() from
> >>> qemu_aio_context then a deadlock is possible since the iohandler_ctx
> >>> won't get a chance to execute. The only suspicious code path I found was
> >>> job_completed_txn_abort_locked() -> job_finish_sync_locked() but I'm not
> >>> sure whether it triggers this scenario. Please check that code path.
> >>>
> >>
> >> Sorry, I don't understand. Isn't executing the scheduled BH the only
> >> additional progress that the iohandler_ctx needs to make compared to
> >> before the patch? How exactly would that cause issues when waiting for a
> >> BlockJob?
> >>
> >> Or do you mean something waiting for the SnapshotJob from
> >> qemu_aio_context before snapshot_save_job_bh had the chance to run?
> >
> > Yes, exactly. job_finish_sync_locked() will hang since iohandler_ctx has
> > no chance to execute. But I haven't audited the code to understand
> > whether this can happen.
> So job_finish_sync_locked() is executed in
> job_completed_txn_abort_locked() when the following branch is taken
>
> > if (!job_is_completed_locked(other_job))
>
> and there is no other job in the transaction, so we can assume other_job
> being the snapshot-save job itself.
>
> The callers of job_completed_txn_abort_locked():
>
> 1. in job_do_finalize_locked() if job->ret is non-zero. The callers of
> which are:
>
> 1a. in job_finalize_locked() if JOB_VERB_FINALIZE is allowed, meaning
> job->status is JOB_STATUS_PENDING, so job_is_completed_locked() will be
> true.
>
> 1b. job_completed_txn_success_locked() sets job->status to
> JOB_STATUS_WAITING before, so job_is_completed_locked() will be true.
>
> 2. in job_completed_locked() it is only done if job->ret is non-zero, in
> which case job->status was set to JOB_STATUS_ABORTING by the preceding
> job_update_rc_locked(), and thus job_is_completed_locked() will be true.
>
> 3. in job_cancel_locked() if job->deferred_to_main_loop is true, which
> is set in job_co_entry() before job_exit() is scheduled as a BH and is
> also set in job_do_dismiss_locked(). In the former case, the
> snapshot_save_job_bh has already been executed. In the latter case,
> job_is_completed_locked() will be true (since job_early_fail() is not
> used for the snapshot job).
>
>
> However, job_finish_sync_locked() is also executed via
> job_cancel_sync_all() during qemu_cleanup(). With bad timing there, I
> suppose the issue could arise.
>
> In fact, I could trigger it with the following hack on top:
>
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 0086b76ab0..42c93176ba 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -3429,6 +3429,17 @@ static void snapshot_load_job_bh(void *opaque)
> >
> >  static void snapshot_save_job_bh(void *opaque)
> >  {
> > +    static int n = 0;
> > +    n++;
> > +    if (n < 10000000) {
> > +        aio_bh_schedule_oneshot(iohandler_get_aio_context(),
> > +                                snapshot_save_job_bh, opaque);
> > +        if (n % 1000000 == 0) {
> > +            error_report("iteration %d", n);
> > +        }
> > +        return;
> > +    }
> > +
> >      Job *job = opaque;
> >      SnapshotJob *s = container_of(job, SnapshotJob, common);
> >
>
> Once the AIO_WAIT_WHILE_UNLOCKED(job->aio_context, ...) was hit in
> job_finish_sync_locked(), the snapshot_save_job_bh would never be
> executed again, leading to the deadlock you described.

Thank you for investigating! It looks like we would be trading one
issue (the assertion failures you mentioned) for another (a rare, but
possible, hang).

I'm not sure what the best solution is. It seems like vm_stop() is the
first place where things go awry. It's where we should exit device
emulation code. Doing that probably requires an asynchronous API that
takes a callback. Do you want to try that?

CCing Kevin in case he has ideas.

Stefan

