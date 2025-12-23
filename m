Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BD8E6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY48n-0002v1-GU; Tue, 23 Dec 2025 10:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY48k-0002uZ-M4
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:17:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY48d-000618-55
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766503044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r+k/q55yy/+F/V/G1nCMo3dRcm4uPMCVs3wIJ8WCVYg=;
 b=Yoyz7uvcJckLOb5L4IjACEeb1GYZsGm+7DLUhl2GA5TJjbaFybr84vcOmBORKvh5S1nbwF
 EAtQoC1SDBhkYyagLFy+nvxgezsUb0vscDvXNTtCTPVqoL5MG0oYrIZgN1WYI9ow7mpTI3
 fWtf/IqbCtznLhqrC+LhBoCzuPI7zno=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-suzlQdzwOVqleMI1GpFPeA-1; Tue, 23 Dec 2025 10:17:21 -0500
X-MC-Unique: suzlQdzwOVqleMI1GpFPeA-1
X-Mimecast-MFC-AGG-ID: suzlQdzwOVqleMI1GpFPeA_1766503041
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a316ede50so99086786d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 07:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766503041; x=1767107841; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r+k/q55yy/+F/V/G1nCMo3dRcm4uPMCVs3wIJ8WCVYg=;
 b=IuDyJMoAI+6QtPUvGP82S2WrMPottUVW8slVKIkWr3rMpVgYME0iahcL2F4Lfx1RRg
 E+jYQBPH9hFagG4UFDy4aNg9aqgZmg0NsDU5RvQ/V/OgroSwh7kOutNHP9d9A5cwKcfW
 DYEwKt8idmeeuO/pO9cBpcINaprzPaPumX5k7Y34iWLBsu8Jz22RvN2dlRIhL1BYiyek
 /KhkoKLz4f5FeJFtFoRqlRskriD7u223hbYHgP+T+ET+IM1ZGvA6CteVih+TwfFFfpvD
 3k9TtFch4cJnvM7pKpfEbXGUJhd0CnIH2WySeScEdC+/0j/gfsWwUI21p3RMYfYecEFD
 /Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766503041; x=1767107841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+k/q55yy/+F/V/G1nCMo3dRcm4uPMCVs3wIJ8WCVYg=;
 b=pyKTK1xDtAGaAk+TguBWON9BWRYlsrA1/nrtZdBD+KCeu+slTOkm1t27VQL52fMcsC
 t9S8eYGUc0q7IL/+0i+UWEa4ljVGvlSzJfzM2/2GWepas0XRC1N4V0myckl/lceuEVg5
 Uxet5f0EGDQZz3AO70GW+JNHZ/MRrjWjoLFeqqVS46W9aP9IladPJI9j0KlBwwk6uUIX
 vCGu5onnCfCH8AHJ9e9TyhuhL85FBoyeYS5J0QkSYNv7PZKNhHLxvcNZRWi9yrvFy6LY
 le5VG7G7EhU78FPLYiXRpt9y6B3tzJadfWeukRi0UMFdE/GBU105AcjJqFAjyij9Pjhu
 LGXg==
X-Gm-Message-State: AOJu0YzauLt96Xw87ybH48DUj9iejycpfjsbVghjkDcuRacVJjX0tqGN
 yGkBWD0yCBArZQRcC7plbpPPa5EY5ahcj529WuNoppYk2xQ1OulpggF/50h6XK3fLTxb8qwtOl7
 Mmb9ydEK+7q9MRw7HdnNPmoEpqtbjPylHowK4xniDEFbQl+c8C5DdygaQ
X-Gm-Gg: AY/fxX596W54VIkpX/t8I7qJr7zAsT/Oj1xhDTp8+sbrB54HpGOkmoJBqUFJctNSWgQ
 tRhng7+fHae/cXRRn5zeQWojxQwTJLH6sp0wUCtNguDPT9GfvWwXMRSTXW2swyF9FYYtuSeuCHM
 Q+mmRXgIF5DXfQufQ86D7A5ms32zddrd4d93lFyW6lQecC7ZqWOUfiZFS2DVYiEkUwF0TY95Ddw
 6HBSR6iiGbeUI+hZrJ7xf4wPP0UqCpr5q/enJ5MRmjaFAcnwO3jPYaiQEMKMVHVRotOIQaKXXBX
 HJVKhiCxMMdqJsvD/3j5LniNv9Q4K47WJ7ksdRt5QSXIMyONMndp09Uk3SQRHzEvJJQM52coa3X
 vqqY=
X-Received: by 2002:a05:6214:1c4a:b0:880:4ed1:ce32 with SMTP id
 6a1803df08f44-88d833b580bmr235146896d6.45.1766503040364; 
 Tue, 23 Dec 2025 07:17:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbNKB9nHV4new0XQcteXA6dlBkiIc4eI/5O0qMrf6BqNNIrpSapbfz7tyFV1EHwmg0L8v4pw==
X-Received: by 2002:a05:6214:1c4a:b0:880:4ed1:ce32 with SMTP id
 6a1803df08f44-88d833b580bmr235146186d6.45.1766503039471; 
 Tue, 23 Dec 2025 07:17:19 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d9623fdfdsm109351086d6.5.2025.12.23.07.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 07:17:19 -0800 (PST)
Date: Tue, 23 Dec 2025 10:17:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
Message-ID: <aUqyfkOtXwl6cy9A@x1.local>
References: <20251222114822.327623-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222114822.327623-1-ppandit@redhat.com>
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

On Mon, Dec 22, 2025 at 05:18:22PM +0530, Prasad Pandit wrote:
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
>   Stack trace of thread 255014:
>    #0  __pthread_kill_implementation (libc.so.6 + 0x822e8)
>    #1  raise (libc.so.6 + 0x3a73c)
>    #2  abort (libc.so.6 + 0x27034)
>    #3  __assert_fail_base (libc.so.6 + 0x34090)
>    #4  __assert_fail (libc.so.6 + 0x34100)
>    #5  yank_unregister_instance (qemu-kvm + 0x8b8280)
>    #6  migrate_fd_cleanup (qemu-kvm + 0x3c6308)
>    #7  migration_bh_dispatch_bh (qemu-kvm + 0x3c2144)
>    #8  aio_bh_poll (qemu-kvm + 0x8ba358)
>    #9  aio_dispatch (qemu-kvm + 0x8a0ab4)
>    #10 aio_ctx_dispatch (qemu-kvm + 0x8bb180)
> 
> Introduce a new migration status FAILING and use it as an
> interim status when an error occurs. Once migration_cleanup()
> is done, it sets the migration status to FAILED. This helps
> to avoid the above race condition and ensuing failure.
> 
> Interim status FAILING is set wherever the execution moves
> towards migration_cleanup() directly OR via:
> 
>   migration_iteration_finish  bg_migration_iteration_finish
>   -> migration_bh_schedule    -> migration_bh_schedule
>    -> migration_cleanup_bh     -> migration_cleanup_bh
>     -> migration_cleanup        -> migration_cleanup
>      -> FAILED                   -> FAILED
> 
> The migration status finally moves to FAILED and reports an
> appropriate error to the user.

I raised a request while I was discussing with you internally, I didn't see
this, I will request again:

Would you please list where you decided to switch from FAILED -> FAILING,
and where you decided not, with justifications for each of them?

Let me give a detailed example in this patch, please see below.

> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/migration.c                 | 33 +++++++++++++++------------
>  migration/multifd.c                   |  4 ++--
>  qapi/migration.json                   |  8 ++++---
>  tests/qtest/migration/migration-qmp.c |  3 ++-
>  tests/qtest/migration/precopy-tests.c |  5 ++--
>  5 files changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index b316ee01ab..5c32bc8fe5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1216,6 +1216,7 @@ bool migration_is_running(void)
>      case MIGRATION_STATUS_DEVICE:
>      case MIGRATION_STATUS_WAIT_UNPLUG:
>      case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_COLO:
>          return true;
>      default:
> @@ -1351,6 +1352,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>          break;
>      case MIGRATION_STATUS_ACTIVE:
>      case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_POSTCOPY_DEVICE:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>      case MIGRATION_STATUS_PRE_SWITCHOVER:
> @@ -1409,6 +1411,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>      case MIGRATION_STATUS_POSTCOPY_RECOVER:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_FAILED:
>      case MIGRATION_STATUS_COLO:
>          info->has_status = true;
> @@ -1531,6 +1534,9 @@ static void migration_cleanup(MigrationState *s)
>      if (s->state == MIGRATION_STATUS_CANCELLING) {
>          migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
>                            MIGRATION_STATUS_CANCELLED);
> +    } else if (s->state == MIGRATION_STATUS_FAILING) {
> +        migrate_set_state(&s->state, MIGRATION_STATUS_FAILING,
> +                          MIGRATION_STATUS_FAILED);
>      }
>  
>      if (s->error) {
> @@ -1584,7 +1590,7 @@ static void migration_connect_set_error(MigrationState *s, const Error *error)
>  
>      switch (current) {
>      case MIGRATION_STATUS_SETUP:
> -        next = MIGRATION_STATUS_FAILED;
> +        next = MIGRATION_STATUS_FAILING;

This is the first real change that we'll switch to FAILING when
migration_connect_set_error() is invoked and migration failed.

Please justify why setting FAILING is correct here.

This function is invoked in three callers:

qmp_migrate[2302]              migration_connect_set_error(s, local_err);
qmp_migrate_finish[2347]       migration_connect_set_error(s, local_err);
migration_connect[4047]        migration_connect_set_error(s, error_in);

At least from the initial two callers, I don't see migration_cleanup()
invoked after setting FAILING.  Could this cause migration to get into
FAILING status forever without finally move to FAILED?

>          break;
>      case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>          /* Never fail a postcopy migration; switch back to PAUSED instead */
> @@ -1728,6 +1734,7 @@ bool migration_has_failed(MigrationState *s)
>  {
>      return (s->state == MIGRATION_STATUS_CANCELLING ||
>              s->state == MIGRATION_STATUS_CANCELLED ||
> +            s->state == MIGRATION_STATUS_FAILING ||
>              s->state == MIGRATION_STATUS_FAILED);
>  }
>  
> @@ -2744,7 +2751,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>          if (postcopy_preempt_establish_channel(ms)) {
>              if (ms->state != MIGRATION_STATUS_CANCELLING) {
>                  migrate_set_state(&ms->state, ms->state,
> -                                  MIGRATION_STATUS_FAILED);
> +                                  MIGRATION_STATUS_FAILING);
>              }
>              error_setg(errp, "%s: Failed to establish preempt channel",
>                         __func__);
> @@ -2907,7 +2914,7 @@ fail_closefb:
>      qemu_fclose(fb);
>  fail:
>      if (ms->state != MIGRATION_STATUS_CANCELLING) {
> -        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILING);
>      }
>      migration_block_activate(NULL);
>      migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
> @@ -3102,7 +3109,7 @@ fail:
>      }
>  
>      if (s->state != MIGRATION_STATUS_CANCELLING) {
> -        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILING);
>      }
>  }
>  
> @@ -3139,7 +3146,7 @@ static void bg_migration_completion(MigrationState *s)
>  
>  fail:
>      migrate_set_state(&s->state, current_active_state,
> -                      MIGRATION_STATUS_FAILED);
> +                      MIGRATION_STATUS_FAILING);
>  }
>  
>  typedef enum MigThrError {
> @@ -3341,7 +3348,7 @@ static MigThrError migration_detect_error(MigrationState *s)
>           * For precopy (or postcopy with error outside IO, or before dest
>           * starts), we fail with no time.
>           */
> -        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILING);
>          trace_migration_thread_file_err();
>  
>          /* Time to stop the migration, now. */
> @@ -3572,7 +3579,7 @@ static void migration_iteration_finish(MigrationState *s)
>          migrate_start_colo_process(s);
>          s->vm_old_state = RUN_STATE_RUNNING;
>          /* Fallthrough */
> -    case MIGRATION_STATUS_FAILED:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_CANCELLING:
>          if (!migration_block_activate(&local_err)) {
> @@ -3631,7 +3638,7 @@ static void bg_migration_iteration_finish(MigrationState *s)
>      switch (s->state) {
>      case MIGRATION_STATUS_COMPLETED:
>      case MIGRATION_STATUS_ACTIVE:
> -    case MIGRATION_STATUS_FAILED:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_CANCELLING:
>          break;
> @@ -3821,7 +3828,7 @@ static void *migration_thread(void *opaque)
>          migrate_set_error(s, local_err);
>          error_free(local_err);
>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                          MIGRATION_STATUS_FAILED);
> +                          MIGRATION_STATUS_FAILING);
>          goto out;
>      }
>  
> @@ -3945,8 +3952,6 @@ static void *bg_migration_thread(void *opaque)
>      if (ret) {
>          migrate_set_error(s, local_err);
>          error_free(local_err);
> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                          MIGRATION_STATUS_FAILED);
>          goto fail_setup;
>      }
>  
> @@ -4008,12 +4013,12 @@ static void *bg_migration_thread(void *opaque)
>  
>  fail:
>      if (early_fail) {
> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                MIGRATION_STATUS_FAILED);
>          bql_unlock();
>      }
>  
>  fail_setup:
> +    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                        MIGRATION_STATUS_FAILING);
>      bg_migration_iteration_finish(s);
>  
>      qemu_fclose(fb);
> @@ -4128,7 +4133,7 @@ void migration_connect(MigrationState *s, Error *error_in)
>  fail:
>      migrate_set_error(s, local_err);
>      if (s->state != MIGRATION_STATUS_CANCELLING) {
> -        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILING);
>      }
>      error_report_err(local_err);
>      migration_cleanup(s);
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 3203dc98e1..970633474e 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -434,7 +434,7 @@ static void multifd_send_set_error(Error *err)
>              s->state == MIGRATION_STATUS_DEVICE ||
>              s->state == MIGRATION_STATUS_ACTIVE) {
>              migrate_set_state(&s->state, s->state,
> -                              MIGRATION_STATUS_FAILED);
> +                              MIGRATION_STATUS_FAILING);
>          }
>      }
>  }
> @@ -1001,7 +1001,7 @@ bool multifd_send_setup(void)
>  
>  err:
>      migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> -                      MIGRATION_STATUS_FAILED);
> +                      MIGRATION_STATUS_FAILING);
>      return false;
>  }
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index cf023bd29d..85f4961781 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -158,7 +158,9 @@
>  #
>  # @completed: migration is finished.
>  #
> -# @failed: some error occurred during migration process.
> +# @failing: error occurred during migration, clean-up underway.
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
> index c803fcee9d..ceb40efd56 100644
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
> index 57ca623de5..a04442df96 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -807,7 +807,8 @@ static void test_cancel_src_after_status(void *opaque)
>      } else if (g_str_equal(phase, "completed")) {
>          test_cancel_src_after_complete(from, to, uri, phase);
>  
> -    } else if (g_str_equal(phase, "failed")) {
> +    } else if (g_str_equal(phase, "failing") ||
> +               g_str_equal(phase, "failed")) {
>          test_cancel_src_after_failed(from, to, uri, phase);
>  
>      } else if (g_str_equal(phase, "none")) {
> @@ -1316,7 +1317,7 @@ void migration_test_add_precopy(MigrationTestEnv *env)
>      }
>  
>      /* ensure new status don't go unnoticed */
> -    assert(MIGRATION_STATUS__MAX == 16);
> +    assert(MIGRATION_STATUS__MAX == 17);
>  
>      for (int i = MIGRATION_STATUS_NONE; i < MIGRATION_STATUS__MAX; i++) {
>          switch (i) {
> -- 
> 2.52.0
> 

-- 
Peter Xu


