Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B8ACE9D53
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd8uQ-0005K4-RJ; Tue, 06 Jan 2026 10:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vd8uP-0005JH-K7
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:23:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vd8uM-0004rQ-Tb
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767713021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tTTO7AOu9FF2/HVYbaAgd9OXok0a5uAww2mRR/B3sdk=;
 b=VWANCdkD2AlerTJgV4KRaZvtG8DizSw8RbgMcbE6o0oqwh/Sv4kiryEWkaf5d35WTo4Ujj
 zPXdbzvCKfWX+IiYi3m6VqjrfKunDwDgPcbpR7gLEKDL2O7bl1WSj5SwWM34KgFY/3DkbL
 mHEmzwBPWQVBp2kaPBJcMcTho8WfE+k=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-GlDAVlq1MqeLL88OWDT1Xg-1; Tue, 06 Jan 2026 10:23:39 -0500
X-MC-Unique: GlDAVlq1MqeLL88OWDT1Xg-1
X-Mimecast-MFC-AGG-ID: GlDAVlq1MqeLL88OWDT1Xg_1767713019
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88a25a341ebso25881186d6.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767713019; x=1768317819; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tTTO7AOu9FF2/HVYbaAgd9OXok0a5uAww2mRR/B3sdk=;
 b=Bl05g+ny/Oy9wk1tIzvct6TOrCHRtxZ/BdrCmk/7MnHw/Y0I5mUWr0/WVdEMKWA5dt
 yScczrJ4XS70VwJZd7rvaM/lDnMo9ROg2ap+CHqQKNy+RGxWBTO6KOiy3TdQlca16R0k
 wn6SP40eSGoUZHKTI7Xk3JmGO7AKaGPOqcTcZsMNw9cynwlag6uyJUko3CgK7m5Ecnf0
 FoERs2O1uPWUTM7emT+q74dF2+28im/udLeSWRvLflanzOXKhwXgTSq3qWoKcGiSnTcT
 hxDrc60TEF8Dg9JbbFQIcOQTpLMVerENO1DQ7tC5QziQcz8164Q+0m3ritTzQ0Uvf131
 D4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767713019; x=1768317819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tTTO7AOu9FF2/HVYbaAgd9OXok0a5uAww2mRR/B3sdk=;
 b=Ok65sdxs+h+BKCjsNjPDjwOUUdU0rZCpprQlCFtdPjrzggzLuSBEy5yrBRPUwmp7Rx
 sdSeCoJY/I+U0gMyDP5cuby72p/uKYBeAWqY/w6dZg5Uhne+hpEJ9yOsQIUwtYW/G7Oq
 yDJxvprOUZZIEWeLkonLsHm0I5n5qgsYbeb6/6NQUdNqN2FMbsDF9wB6u0xfIpbbhoLy
 v/JGKEhu7Frm48gBdC9N3SCnaL+jF+gayYSRvdzvGIQ4WJ0WfjAEfkPYrUG3o63xmfH8
 bq5iWEaFgP0G2XAzjrrGlj5rTfkHdqCfQ+Q1xnOXzz0GuR/DQNp/Jed3tIB4bxxwzOhT
 0uhA==
X-Gm-Message-State: AOJu0YxMLBFBN+TbnGDKT2M3qj9T0exWJ/NFsoSwcLWhYyzVD3PdWqEt
 8fVxysVWajbsyUMyt1qBEF06m4irk0OdIdjAAsZ5aA6Ly6zVF9dsIjnRph6gEqPE28on+YfPRAe
 llErwDx1N7gVWNxG3u6ibzhqgNdZme36aeR5fzPArFj75/nTE6ns+Mwg1
X-Gm-Gg: AY/fxX65rmov9rSQjPyxHqPdXtQqjxnM5LWl8l2QywKIi2vrJjuw2KEJJOsp5G0jPFg
 fXUsS92gq7WXkA1VCrSr+yF+5n2s32KKWHLhyueldHVtwXitxUD4kIh4ei5R7rGXtbcvvdKKUTX
 QBd5Bx4GjODkhaP5XMHsVV6rTfA6rRoJZlCm48icNudowujH8bfJfzbcFriH6AYZo2gGzbG/YwQ
 BJLuRsn5fKc10i9MYbz5CBi9u5kQuEag2eEsk+hb+2xzQMweyKSHnPF/zfbk8HuxCaOV0LGloEf
 Ohd6JetdPTxEJu2eFbdyBCfeEFacF3dVISy+07BYpE1uc/IX2SU+eCySSkaq6WrW+puOuDbIukM
 s2fc=
X-Received: by 2002:a05:6214:2b88:b0:882:4572:19b4 with SMTP id
 6a1803df08f44-89075ed022fmr42599146d6.58.1767713018679; 
 Tue, 06 Jan 2026 07:23:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJwYNmpi9wAGKaE2BS+0kOq+b0bpzrseG5/Y4N31kAZHof79o6hqIgha9/gp+VqioRdywbUQ==
X-Received: by 2002:a05:6214:2b88:b0:882:4572:19b4 with SMTP id
 6a1803df08f44-89075ed022fmr42598586d6.58.1767713017952; 
 Tue, 06 Jan 2026 07:23:37 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89077234ca1sm14957966d6.36.2026.01.06.07.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 07:23:37 -0800 (PST)
Date: Tue, 6 Jan 2026 10:23:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
Message-ID: <aV0o-EYEC-4rvdSz@x1.local>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <aUqyfkOtXwl6cy9A@x1.local>
 <CAE8KmOwnPYoK0i53LB8nO95gC53QK4FoNvMrbb9anR3OB+RS4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOwnPYoK0i53LB8nO95gC53QK4FoNvMrbb9anR3OB+RS4Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 06, 2026 at 04:19:44PM +0530, Prasad Pandit wrote:
> Hello Peter, Fabiano,
> 
> * Thank you for the comments.
> 
> On Tue, 23 Dec 2025 at 20:47, Peter Xu <peterx@redhat.com> wrote:
> > I raised a request while I was discussing with you internally, I didn't see
> > this, I will request again:
> >
> > Would you please list where you decided to switch from FAILED -> FAILING,
> > and where you decided not, with justifications for each of them?
> >
> > Let me give a detailed example in this patch, please see below.
> > This is the first real change that we'll switch to FAILING when
> > migration_connect_set_error() is invoked and migration failed.
> >
> > Please justify why setting FAILING is correct here.
> >
> > This function is invoked in three callers:
> >
> > qmp_migrate[2302]              migration_connect_set_error(s, local_err);
> > qmp_migrate_finish[2347]       migration_connect_set_error(s, local_err);
> > migration_connect[4047]        migration_connect_set_error(s, error_in);
> >
> > At least from the initial two callers, I don't see migration_cleanup()
> > invoked after setting FAILING.  Could this cause migration to get into
> > FAILING status forever without finally move to FAILED?
> 
> * Ah, sorry about this; I missed removing this and
> qmp_migrate_finish() change from this patch. Idea was to switch to the
> interim FAILING state wherever execution follows the
> migration_iteration_finish() OR bg_migration_iteration_finish() path
> and leads to migration_cleanup() setting the final state to FAILED. (I
> create/test patches on a pair of machines and then copy them to the
> local repository on my laptop to send upstream, can not do git
> send-email from test machines, these discrepancies fall through at
> times)
> 
> * As you requested, please see below the list of calls where the
> change was applied and where it was not. Justification for changing to
> the interim 'FAILING' state is that execution follows through to
> migration_cleanup() path. And Justification for not changing the state
> is that execution does not follow through to the migration_cleanup()
> path.
> ===
> 01  void migration_channel_process_incoming(QIOChannel *ioc)
>       ...
>         error_report_err(local_err);
>         migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> 
> 02  static void cpr_exec_cb(void *opaque)
>       ...
>         error_report_err(error_copy(err));
>         migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> 
> 03  static void coroutine_fn process_incoming_migration_co(void *opaque)
>       ...
>       fail:
>          migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                            MIGRATION_STATUS_FAILED);
>          migrate_error_propagate(s, local_err);
> 
> 04  static void migration_connect_error_propagate(MigrationState *s,
> Error *error)
>       ...
>         case MIGRATION_STATUS_SETUP:
>             next = MIGRATION_STATUS_FAILED;
>             break;
>         migrate_error_propagate(s, error);
> 
> 05  static void qmp_migrate_finish(MigrationAddress *addr, ...)
>       ...
>         else {
>             error_setg(&local_err, "uri is not a valid migration protocol");
>             migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                               MIGRATION_STATUS_FAILED);
> 
> 06  static void multifd_recv_terminate_threads(Error *err)
>       ...
>         if (s->state == MIGRATION_STATUS_SETUP ||
>             s->state == MIGRATION_STATUS_ACTIVE) {
>             migrate_set_state(&s->state, s->state,
>                               MIGRATION_STATUS_FAILED);
> 
> 07  static void *postcopy_listen_thread(void *opaque)
>       ...
>         error_report_err(local_err);
>         migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
>         goto out;
> 
> 08  static int qemu_savevm_state(QEMUFile *f, Error **errp)
>       ...
>       cleanup:
>         if (ret != 0) {
>           status = MIGRATION_STATUS_FAILED;
>         } else {
>           status = MIGRATION_STATUS_COMPLETED;
>         }
>         migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP, status);
> 
> * Above MIGRATION_STATUS_FAILED instances are _not_ changed because
> they do not follow the migration_cleanup() path. The instances below
> are changed to the interim FAILING state because execution follows
> through the migration_cleanup() path, wherein the interim state
> changes to the FAILED state.
> 
> 09  static int postcopy_start(MigrationState *ms, Error **errp)
>       ...
>         if (ms->state != MIGRATION_STATUS_CANCELLING) {
>            migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> 
>       ...
>       fail:
>         if (ms->state != MIGRATION_STATUS_CANCELLING) {
>             migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
>         }
> 
> 10  static void migration_completion(MigrationState *s)
>       ...
>       fail:
>         if (s->state != MIGRATION_STATUS_CANCELLING) {
>             migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>         }
> 
> 11  static void bg_migration_completion(MigrationState *s)
>       ...
>       fail:
>         migrate_set_state(&s->state, current_active_state,
> MIGRATION_STATUS_FAILED);
> 
> 12  static MigThrError migration_detect_error(MigrationState *s)
>       ...
>         migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
>         /* Time to stop the migration, now. */
>         return MIG_THR_ERR_FATAL;
> 
> 13  static void *migration_thread(void *opaque)
>       ...
>         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> MIGRATION_STATUS_FAILED);
>         goto out;
> 
> 14  static void *bg_migration_thread(void *opaque)
>       ...
>         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> MIGRATION_STATUS_FAILED);
>         goto fail_setup;
> 
>       fail:
>         if (early_fail) {
>             migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> MIGRATION_STATUS_FAILED);
>         }
>       fail_setup:
>         bg_migration_iteration_finish(s);
> 
> 15  void migration_connect(MigrationState *s, Error *error_in)
>       ...
>         if (s->state != MIGRATION_STATUS_CANCELLING) {
>             migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>         }
>         migration_cleanup(s);
> 
> 16  static void multifd_send_error_propagate(Error *err)
>       ...
>         s->state == MIGRATION_STATUS_DEVICE ||
>         s->state == MIGRATION_STATUS_ACTIVE) {
>             migrate_set_state(&s->state, s->state,
>                               MIGRATION_STATUS_FAILED);
> 
> 17  bool multifd_send_setup(void)
>       ...
>       err:
>         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                       MIGRATION_STATUS_FAILED);
>       return false;
> ===

Yes, something like this would be more than welcomed, thanks.  You can
provide a simplified version in the commit log when repost.

Note that I'm not reading carefully into each of them, because we have
concurrent changes from Fabiano recently, essentially it'll change when
migration_cleanup() will be used in above examples:

https://lore.kernel.org/r/20260105190644.14072-12-farosas@suse.de

So we'll need to be careful landing these two changes.

Considering that the other series was close to landing, IMHO it might be
good idea to have your patch (when reposted) based on that series.  Please
have a look.

> 
> * As proposed earlier, I'll request to divide this patchset into two
> (or even) more patches as:
>     - One patch to fix the race condition issue at hand, by way of
> introducing the interim FAILING state.
>     - One or more patches to use the interim FAILING state, where we
> currently set the FAILED state.
> That should help us to do/test/review these changes. It is complicated
> how this state change is done/handled and IIUC, migration code seems
> to serve multiple use cases: one is live VM migration between two
> machines, second is taking snapshots of a VM, third is migrating a VM
> to a new QEMU process in the same host. Doing such a change in a
> single large patch seems risky.

I still think FAILING isn't such a huge change so it needs to be split into
multiple patches.  It's a new status and we need to review every spot of
FAILED status change, in which case one patch is very well self contained.

Even in a backport I think we should backport all relevant changes about
FAILING when necessary.  We should not backport part of it, causing FAILING
status to behave different over different paths.

Thanks,

-- 
Peter Xu


