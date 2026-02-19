Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946B7C531CE
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBDl-00050A-9o; Thu, 19 Feb 2026 16:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vtBDc-0004ss-Gn
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:05:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vtBDZ-0003H8-R8
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771535147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NhvgdU2zX5ZysvEtkFZRA8JmrMbf7tFpLre4MN6j60o=;
 b=dh4XP8+g3qgAb8HqMeTKqOg/VtIwrS89OkWo9Al011SfK02/Gu1ZLT9hKMQCK0+h+CD9WM
 D7PD/fin1bolCJ9zi+lvGjnbEQfD2EvHW4NO6oP1tGEUuUFuWyy6WhtOkYecXwNfGvnFpk
 E4TIs7bAQIb/VA5khsZsuANa304bhvk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-xPKORS8KMGOs2JbybrWa-w-1; Thu, 19 Feb 2026 16:05:46 -0500
X-MC-Unique: xPKORS8KMGOs2JbybrWa-w-1
X-Mimecast-MFC-AGG-ID: xPKORS8KMGOs2JbybrWa-w_1771535145
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-896fa0fcf27so152547436d6.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771535145; x=1772139945; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NhvgdU2zX5ZysvEtkFZRA8JmrMbf7tFpLre4MN6j60o=;
 b=TTOmwG7cnbfO3eEzwmUHn31coYpyf6bkNaZXTVZWDNuc77vUbo8LW5sXcFkCwEFB2b
 VsoLVlZaeB0lRvNzHo1rqmvIpTnLog05uQ3hEBE7RyNLtJJU3wqaY4GVCMQLne2AsMQb
 kpykUfj/nnzkxzcttD1aB5tlxcAXx3l+GLoAhNPReZbpoRneQw+KBKAXu9H6QL/J8RrH
 Kt9RkLaGPrKYgxQ005uyUWyiD2+9J6v9Rpyiu+tIP+nKeE861Ystmsf6bpASHOW5lOLN
 F2NErRAPbhBkJfzU/5RPZF/xWupdc3pGKsSEbNaIiOm0eQRxQOz1ZfORuZ3BU7VTHcWN
 VGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771535145; x=1772139945;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhvgdU2zX5ZysvEtkFZRA8JmrMbf7tFpLre4MN6j60o=;
 b=FWyZA/3p3RkeTtIJGYzTRmTQ9bHQsNcj2/igsjiwefL5CbCVZb/OLGrchCV8W/O1YQ
 cZAyzLOfQLJ7+B8TS6+Szxu6x1OjwJ6V4CHGW0shHPpBIDIt8VWdCQYmsnUgU+imXLRF
 PRQALa/3Rzh7JQw0rw1Ge/osF8V3rS0GiH5J+b2ic69LsvlYi8cEZXtV6xAzaBYmhEdf
 vhTKJkP5dWsphywyA98VTx6240JWp47N6gj/o3DAT4Qm7XztMvJUCxw/ygAqpfZfr1jl
 CY9og4ZQOyRMiXCcg6UAIXDqIL2V5kS75JkAgw2COoAAncRNdfcHa9bsEjN6dS4+Paw2
 erWA==
X-Gm-Message-State: AOJu0YzmjuYyQHStXT7o5cFL09zxrJVPjAtcGrRN0G6CzE6A93/dzCNl
 b1dlA6aK7H+eKFa3qjzNOo+laCzmpTgwcU+uvQqvgl3aeGK718zINhpdf+S4VkleBAi4b8OZNC2
 K1NosBanl2n+ma2l2aewqOFfaltXvkeIZ3W2YntKTUpmdVdzuDpaeMm8Ofqlb20ld
X-Gm-Gg: AZuq6aKoxN7lg5HRm7xRMQmoG/IG82IF+5r7gEwyqvT/JbvuGNQfi+swZXsIIVhQtj9
 CtLMgglold4Bf72HRk0ip3jlfhmfGud0DStEi2H+BOP1ry9iAVe1GmSRoGkMPLDLkHDtqcq6KN0
 5pqn5Q1dQDQoYxhcbhAJC7N5F48MvPeEUs8zw/wbm7ak0EXHRr52lvzN7ZsUcbnjpfNIo7qbAqy
 Psba/jmixvAw2YNF/9sEi6rGx6VSWglJ8G5vXVn7XO1WMxYmFnTlCDtqYs06TA5w42QLg1CO5As
 0JTkEZD5DKtG2HAT9YxF9YQarz5bwXPfdmc6RiKkJfedz0uwC2JZRM9z3WW4hiT7Vl2ZVQOtZaq
 Jo6gHmfaA4+a4Fw==
X-Received: by 2002:a05:620a:3911:b0:8cb:2d00:a3c3 with SMTP id
 af79cd13be357-8cb424b40c1mr2668132385a.86.1771535145022; 
 Thu, 19 Feb 2026 13:05:45 -0800 (PST)
X-Received: by 2002:a05:620a:3911:b0:8cb:2d00:a3c3 with SMTP id
 af79cd13be357-8cb424b40c1mr2668126485a.86.1771535144403; 
 Thu, 19 Feb 2026 13:05:44 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb3a3e9adesm1813260885a.49.2026.02.19.13.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 13:05:43 -0800 (PST)
Date: Thu, 19 Feb 2026 16:05:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de,
 Prasad Pandit <pjp@fedoraproject.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v1] migration: introduce MIGRATION_STATUS_FAILING
Message-ID: <aZd7HDcOa3R2wj8r@x1.local>
References: <20260209132303.717784-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209132303.717784-1-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 09, 2026 at 06:53:03PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> When migration connection is broken, the QEMU and libvirtd(8)
> process on the source side receive TCP connection reset
> notification. QEMU sets the migration status to FAILED and
> proceeds to migration_cleanup(). Meanwhile, Libvirtd(8) sends
> a QMP command to migrate_set_capabilities().
> 
> The migration_cleanup() and qmp_migrate_set_capabilities()
> calls race with each other. When the latter is invoked first,
> since the migration is not running (FAILED), migration
> capabilities are reset to false, so during migration_cleanup()
> the QEMU process crashes with assertion failure.
> 
> Introduce a new migration status FAILING and use it as an
> interim status when an error occurs. Once migration_cleanup()
> is done, it sets the migration status to FAILED. This helps
> to avoid the above race condition and ensuing failure.
> 
> Interim status FAILING is set wherever the execution moves
> towards migration_cleanup():
>   - postcopy_start()
>   - migration_thread()
>   - migration_cleanup()
>   - multifd_send_setup()
>   - bg_migration_thread()
>   - migration_completion()
>   - migration_detect_error()
>   - bg_migration_completion()
>   - multifd_send_error_propagate()
>   - migration_connect_error_propagate()
> 
> The migration status finally moves to FAILED and reports an
> appropriate error to the user.
> 
> Interim status FAILING is _NOT_ set in the following routines
> because they do not follow the migration_cleanup() path to the
> FAILED state:
>   - cpr_exec_cb()
>   - qemu_savevm_state()
>   - postcopy_listen_thread()
>   - process_incoming_migration_co()
>   - multifd_recv_terminate_threads()
>   - migration_channel_process_incoming()
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Thanks for the lists, they all look correct to me.

I only have one trivial nitpick below,

> ---
>  migration/migration.c                 | 34 +++++++++++++++++----------
>  migration/multifd.c                   |  4 ++--
>  qapi/migration.json                   |  8 ++++---
>  tests/qtest/migration/migration-qmp.c |  3 ++-
>  tests/qtest/migration/precopy-tests.c |  3 ++-
>  5 files changed, 32 insertions(+), 20 deletions(-)
> 
> v1:
>  - Rebase patch on the latest upstream version
>  - Add list of functions where interim state FAILING is set
>    and where it is not changed.
> 
> 67/67 qtest+qtest-x86_64 - qemu:qtest-x86_64/migration-test                 OK             113.97s   84 subtests passed
> 68/68 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             107.20s   84 subtests passed
> 
> v0:
>  - https://lore.kernel.org/qemu-devel/20251222114822.327623-1-ppandit@redhat.com/T/#u
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index b103a82fc0..16c71e502a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1016,6 +1016,7 @@ bool migration_is_running(void)
>      case MIGRATION_STATUS_DEVICE:
>      case MIGRATION_STATUS_WAIT_UNPLUG:
>      case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_COLO:
>          return true;
>      default:
> @@ -1158,6 +1159,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>      case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>      case MIGRATION_STATUS_POSTCOPY_RECOVER:
> +    case MIGRATION_STATUS_FAILING:
>          /* TODO add some postcopy stats */
>          populate_time_info(info, s);
>          populate_ram_info(info, s);
> @@ -1210,6 +1212,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>      case MIGRATION_STATUS_POSTCOPY_RECOVER:
>      case MIGRATION_STATUS_FAILED:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_COLO:
>          info->has_status = true;
>          break;
> @@ -1331,6 +1334,9 @@ static void migration_cleanup(MigrationState *s)
>      if (s->state == MIGRATION_STATUS_CANCELLING) {
>          migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
>                            MIGRATION_STATUS_CANCELLED);
> +    } else if (s->state == MIGRATION_STATUS_FAILING) {
> +        migrate_set_state(&s->state, MIGRATION_STATUS_FAILING,
> +                          MIGRATION_STATUS_FAILED);
>      }
> 
>      type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
> @@ -1383,7 +1389,7 @@ void migration_connect_error_propagate(MigrationState *s, Error *error)
> 
>      switch (current) {
>      case MIGRATION_STATUS_SETUP:
> -        next = MIGRATION_STATUS_FAILED;
> +        next = MIGRATION_STATUS_FAILING;
>          break;
> 
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
> @@ -1397,9 +1403,10 @@ void migration_connect_error_propagate(MigrationState *s, Error *error)
>          break;
> 
>      case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_FAILING:
>          /*
> -         * Don't move out of CANCELLING, the only valid transition is to
> -         * CANCELLED, at migration_cleanup().
> +         * Keep the current state, next transition is to be done
> +         * in migration_cleanup().
>           */
>          break;
> 
> @@ -1547,6 +1554,7 @@ bool migration_has_failed(MigrationState *s)
>  {
>      return (s->state == MIGRATION_STATUS_CANCELLING ||
>              s->state == MIGRATION_STATUS_CANCELLED ||
> +            s->state == MIGRATION_STATUS_FAILING ||
>              s->state == MIGRATION_STATUS_FAILED);
>  }
> 
> @@ -2472,7 +2480,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>          if (postcopy_preempt_establish_channel(ms)) {
>              if (ms->state != MIGRATION_STATUS_CANCELLING) {
>                  migrate_set_state(&ms->state, ms->state,
> -                                  MIGRATION_STATUS_FAILED);
> +                                  MIGRATION_STATUS_FAILING);
>              }
>              error_setg(errp, "%s: Failed to establish preempt channel",
>                         __func__);
> @@ -2635,7 +2643,7 @@ fail_closefb:
>      qemu_fclose(fb);
>  fail:
>      if (ms->state != MIGRATION_STATUS_CANCELLING) {
> -        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILING);
>      }
>      migration_block_activate(NULL);
>      migration_call_notifiers(MIG_EVENT_PRECOPY_FAILED, NULL);
> @@ -2828,7 +2836,7 @@ fail:
>      }
> 
>      if (s->state != MIGRATION_STATUS_CANCELLING) {
> -        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILING);
>      }
>  }
> 
> @@ -2865,7 +2873,7 @@ static void bg_migration_completion(MigrationState *s)
> 
>  fail:
>      migrate_set_state(&s->state, current_active_state,
> -                      MIGRATION_STATUS_FAILED);
> +                      MIGRATION_STATUS_FAILING);
>  }
> 
>  typedef enum MigThrError {
> @@ -3066,7 +3074,7 @@ static MigThrError migration_detect_error(MigrationState *s)
>           * For precopy (or postcopy with error outside IO, or before dest
>           * starts), we fail with no time.
>           */
> -        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILING);
>          trace_migration_thread_file_err();
> 
>          /* Time to stop the migration, now. */
> @@ -3297,7 +3305,7 @@ static void migration_iteration_finish(MigrationState *s)
>          migrate_start_colo_process(s);
>          s->vm_old_state = RUN_STATE_RUNNING;
>          /* Fallthrough */
> -    case MIGRATION_STATUS_FAILED:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_CANCELLING:
>          if (!migration_block_activate(&local_err)) {
> @@ -3356,7 +3364,7 @@ static void bg_migration_iteration_finish(MigrationState *s)
>      switch (s->state) {
>      case MIGRATION_STATUS_COMPLETED:
>      case MIGRATION_STATUS_ACTIVE:
> -    case MIGRATION_STATUS_FAILED:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_CANCELLING:
>          break;
> @@ -3541,7 +3549,7 @@ static void *migration_thread(void *opaque)
>      if (ret) {
>          migrate_error_propagate(s, local_err);
>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                          MIGRATION_STATUS_FAILED);
> +                          MIGRATION_STATUS_FAILING);
>          goto out;
>      }
> 
> @@ -3664,7 +3672,7 @@ static void *bg_migration_thread(void *opaque)
>      if (ret) {
>          migrate_error_propagate(s, local_err);
>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                          MIGRATION_STATUS_FAILED);
> +                          MIGRATION_STATUS_FAILING);
>          goto fail_setup;
>      }
> 
> @@ -3727,7 +3735,7 @@ static void *bg_migration_thread(void *opaque)
>  fail:
>      if (early_fail) {
>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                MIGRATION_STATUS_FAILED);
> +                MIGRATION_STATUS_FAILING);
>          bql_unlock();
>      }
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index ad6261688f..178c6b3350 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -431,7 +431,7 @@ static void multifd_send_error_propagate(Error *err)
>              s->state == MIGRATION_STATUS_DEVICE ||
>              s->state == MIGRATION_STATUS_ACTIVE) {
>              migrate_set_state(&s->state, s->state,
> -                              MIGRATION_STATUS_FAILED);
> +                              MIGRATION_STATUS_FAILING);
>          }
>      }
>  }
> @@ -986,7 +986,7 @@ bool multifd_send_setup(void)
> 
>  err:
>      migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> -                      MIGRATION_STATUS_FAILED);
> +                      MIGRATION_STATUS_FAILING);
>      return false;
>  }
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index f925e5541b..903c1d9618 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -158,7 +158,9 @@
>  #
>  # @completed: migration is finished.
>  #
> -# @failed: some error occurred during migration process.
> +# @failing: error occurred during migration, clean-up underway.

Let's add "(since 11.0)" for new status.

I've copied Markus and Eric because this touches qapi/, meanwhile copying
Juraj because he used to also look at this failure paths.

If you fix the qapi doc, feel free to add:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

> +#
> +# @failed: error occurred during migration, clean-up done.
>  #
>  # @colo: VM is in the process of fault tolerance, VM can not get into
>  #     this state unless colo capability is enabled for migration.
> @@ -181,8 +183,8 @@
>    'data': [ 'none', 'setup', 'cancelling', 'cancelled',
>              'active', 'postcopy-device', 'postcopy-active',
>              'postcopy-paused', 'postcopy-recover-setup',
> -            'postcopy-recover', 'completed', 'failed', 'colo',
> -            'pre-switchover', 'device', 'wait-unplug' ] }
> +            'postcopy-recover', 'completed', 'failing', 'failed',
> +            'colo', 'pre-switchover', 'device', 'wait-unplug' ] }
> 
>  ##
>  # @VfioStats:
> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
> index 5c46ceb3e6..8279504db1 100644
> --- a/tests/qtest/migration/migration-qmp.c
> +++ b/tests/qtest/migration/migration-qmp.c
> @@ -241,7 +241,8 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
>      do {
>          status = migrate_query_status(from);
>          bool result = !strcmp(status, "setup") || !strcmp(status, "failed") ||
> -            (allow_active && !strcmp(status, "active"));
> +            (allow_active && !strcmp(status, "active")) ||
> +            !strcmp(status, "failing");
>          if (!result) {
>              fprintf(stderr, "%s: unexpected status status=%s allow_active=%d\n",
>                      __func__, status, allow_active);
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index a5423ca33c..f17dc5176d 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -1247,7 +1247,7 @@ void migration_test_add_precopy(MigrationTestEnv *env)
>      }
> 
>      /* ensure new status don't go unnoticed */
> -    assert(MIGRATION_STATUS__MAX == 16);
> +    assert(MIGRATION_STATUS__MAX == 17);
> 
>      for (int i = MIGRATION_STATUS_NONE; i < MIGRATION_STATUS__MAX; i++) {
>          switch (i) {
> @@ -1259,6 +1259,7 @@ void migration_test_add_precopy(MigrationTestEnv *env)
>          case MIGRATION_STATUS_POSTCOPY_PAUSED:
>          case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>          case MIGRATION_STATUS_POSTCOPY_RECOVER:
> +        case MIGRATION_STATUS_FAILING:
>              continue;
>          default:
>              migration_test_add_suffix("/migration/cancel/src/after/",
> --
> 2.53.0
> 

-- 
Peter Xu


