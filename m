Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6840CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 16:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzeRJ-0002Uj-PO; Fri, 19 Sep 2025 12:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzeRE-0002TU-VC
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 12:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzeR9-0004gl-UB
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 12:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758301093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E4cog+qkRSK6YwiVNtph4zDUDTMLigsHoyR8ATPXP7k=;
 b=Zf4TZynIlijwjFDoT1ns6+eZNZo0SeiDv+uhpRO6MKSr1EVr7tItK22Uc7hbNt1bdoQpes
 j0njk04+S3UXmAvufogPFdyrEIb/4Zucwf1zY5PS5rTKzQrAjdoU+1IXyCDirL/KdgBMma
 aLpGgsCDuwfVE8JLTSi/sNejl1o35To=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-1Sl2Sqq4P2CTicPPaXNHMA-1; Fri, 19 Sep 2025 12:58:11 -0400
X-MC-Unique: 1Sl2Sqq4P2CTicPPaXNHMA-1
X-Mimecast-MFC-AGG-ID: 1Sl2Sqq4P2CTicPPaXNHMA_1758301091
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-79538b281cdso29266716d6.0
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 09:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758301091; x=1758905891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4cog+qkRSK6YwiVNtph4zDUDTMLigsHoyR8ATPXP7k=;
 b=f9iR8vyRs15t+35dsUSRDblkTzJOBImfCt2P/3Sdat8UwtY4zws4NzekX8xbDyriRx
 vP7RFhAa15vyITXbes/JGEuVZ0X7HuNT5JmB6g8D60BXAWIjrRLzFQmIfnVVn3GjWw58
 FPsK6j+SMHkeNgdGVuoAlPeZst+4hq7ircSXYLOuE8AsoxZXfde7Ws5QSFwWuempeDMH
 ZKpMAFIgQvNYwOx/+O6UwvjFdS2EvXpZzsWj71cNotbmrgu02lM16sfFQGtviaMTVLDO
 N0vsTSGQqJFZB96wjX1ZIB8kXqHPP4s9onJqBiBA9UC5WRTgtBQn0PRAk0+YqxQ7H/UC
 /RbQ==
X-Gm-Message-State: AOJu0YzsX6N76JC25PdYLa05r2C+T4hAyJKlUNdJfiYNFnnkvAYiMJ/9
 cdagZIJ9uV55XUQotiJZP2kTvnL9E0Bbso7Z+pM1Rlt85JINyJ0ABsUFtCxLHSIobbXgCFDuWbX
 2GdpQISuOVGtyJRfMSi5Nj+SEAWwicaTNXlmeURtCK/kqwtCxRq2pctzi
X-Gm-Gg: ASbGncvAs5BSW5ymWwVrKD90PVvWbYFfZDs9am8usYD74U2rKYbVwtL6vQMcBREvzRN
 VS721y8ZzGT/fnWuONzZ5jXNIlLgtPg0nltz9ecWCnHukIY+CMREOeNf+WfpA8XDUsRPChEwJeP
 G2HdszTxL6UIE58AIPK1PNyrWGs+gQ208ooTq85DIEIYEEhXWbyC1qyFiys2cTlkkQKiJWdCakw
 YGfYtF1a2a8Ot4r9nRJjecQ2OXPoOjyaBcyJnvqHLwi7Z7kiYdKN5Dfr1/W8kSsruf8/aXRK5RZ
 CFhp42ttvMktSvlUheaQy4UTZBzoDRBc
X-Received: by 2002:a05:6214:c64:b0:78e:2582:fe4 with SMTP id
 6a1803df08f44-798c5fb8721mr44431956d6.30.1758301090749; 
 Fri, 19 Sep 2025 09:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYB1IGeEtLrCho6zTr/U1K3TPuCX2lpW3E43I1PyoGYz0W++opH0b3Mfyu1Of5wn0arIQzwg==
X-Received: by 2002:a05:6214:c64:b0:78e:2582:fe4 with SMTP id
 6a1803df08f44-798c5fb8721mr44431526d6.30.1758301090209; 
 Fri, 19 Sep 2025 09:58:10 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-79351f71705sm31711196d6.39.2025.09.19.09.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 09:58:09 -0700 (PDT)
Date: Fri, 19 Sep 2025 12:58:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aM2LoGDh5WsVnEi8@x1.local>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-5-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915115918.3520735-5-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Sep 15, 2025 at 01:59:15PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Currently, when postcopy starts, the source VM starts switchover and
> sends a package containing the state of all non-postcopiable devices.
> When the destination loads this package, the switchover is complete and
> the destination VM starts. However, if the device state load fails or
> the destination side crashes, the source side is already in
> POSTCOPY_ACTIVE state and cannot be recovered, even when it has the most
> up-to-date machine state as the destination has not yet started.
> 
> This patch introduces a new POSTCOPY_DEVICE state which is active
> while the destination machine is loading the device state, is not yet
> running, and the source side can be resumed in case of a migration
> failure.
> 
> To transition from POSTCOPY_DEVICE to POSTCOPY_ACTIVE, the source
> side uses a PONG message that is a response to a PING message processed
> just before the POSTCOPY_RUN command that starts the destination VM.
> Thus, this change does not require any changes on the destination side
> and is effective even with older destination versions.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/migration.c                 | 23 ++++++++++++++++++-----
>  migration/savevm.h                    |  2 ++
>  migration/trace-events                |  1 +
>  qapi/migration.json                   |  8 ++++++--
>  tests/qtest/migration/precopy-tests.c |  3 ++-
>  5 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 7222e3de13..e63a7487be 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1223,6 +1223,7 @@ bool migration_is_running(void)
>  
>      switch (s->state) {
>      case MIGRATION_STATUS_ACTIVE:
> +    case MIGRATION_STATUS_POSTCOPY_DEVICE:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>      case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
> @@ -1244,6 +1245,7 @@ static bool migration_is_active(void)
>      MigrationState *s = current_migration;
>  
>      return (s->state == MIGRATION_STATUS_ACTIVE ||
> +            s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
>              s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>  }
>  
> @@ -1366,6 +1368,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>          break;
>      case MIGRATION_STATUS_ACTIVE:
>      case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_POSTCOPY_DEVICE:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>      case MIGRATION_STATUS_PRE_SWITCHOVER:
>      case MIGRATION_STATUS_DEVICE:
> @@ -1419,6 +1422,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
>      case MIGRATION_STATUS_CANCELLING:
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_ACTIVE:
> +    case MIGRATION_STATUS_POSTCOPY_DEVICE:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>      case MIGRATION_STATUS_POSTCOPY_RECOVER:
> @@ -1719,6 +1723,7 @@ bool migration_in_postcopy(void)
>      MigrationState *s = migrate_get_current();
>  
>      switch (s->state) {
> +    case MIGRATION_STATUS_POSTCOPY_DEVICE:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>      case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
> @@ -2564,6 +2569,11 @@ static void *source_return_path_thread(void *opaque)
>              tmp32 = ldl_be_p(buf);
>              trace_source_return_path_thread_pong(tmp32);
>              qemu_sem_post(&ms->rp_state.rp_pong_acks);
> +            if (tmp32 == QEMU_VM_PING_PACKAGED_LOADED) {
> +                trace_source_return_path_thread_dst_started();
> +                migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> +                                  MIGRATION_STATUS_POSTCOPY_ACTIVE);

Could this race with the migration thread modifying the state concurrently?

To avoid it, we could have a bool, set it here once, and in the iterations
do something like:

diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25d..55230e10ee 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3449,6 +3449,16 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     trace_migrate_pending_estimate(pending_size, must_precopy, can_postcopy);
 
     if (in_postcopy) {
+        if (s->postcopy_package_loaded) {
+            assert(s->state == MIGRATION_STATUS_POSTCOPY_DEVICE);
+            migrate_set_state(s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
+                              MIGRATION_STATUS_POSTCOPY_ACTIVE);
+            /*
+             * Since postcopy cannot be re-initiated, this flag will only
+             * be set at most once for QEMU's whole lifecyce.
+             */
+            s->postcopy_package_loaded = false;
+        }
         /*
          * Iterate in postcopy until all pending data flushed.  Note that
          * postcopy completion doesn't rely on can_switchover, because when

> +            }
>              break;
>  
>          case MIG_RP_MSG_REQ_PAGES:
> @@ -2814,6 +2824,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>      if (migrate_postcopy_ram()) {
>          qemu_savevm_send_ping(fb, 3);
>      }
> +    qemu_savevm_send_ping(fb, QEMU_VM_PING_PACKAGED_LOADED);

Nitpick: some comment would be nice here describing this ping, especially
when it becomes functional.  The name does provide some info, but not
extremely clear what PACKAGED_LOADED mean if in a PONG yet.

>  
>      qemu_savevm_send_postcopy_run(fb);
>  
> @@ -2871,7 +2882,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>  
>      /* Now, switchover looks all fine, switching to postcopy-active */
>      migrate_set_state(&ms->state, MIGRATION_STATUS_DEVICE,
> -                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +                      MIGRATION_STATUS_POSTCOPY_DEVICE);
>  
>      bql_unlock();
>  
> @@ -3035,7 +3046,8 @@ static void migration_completion(MigrationState *s)
>  
>      if (s->state == MIGRATION_STATUS_ACTIVE) {
>          ret = migration_completion_precopy(s);
> -    } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +    } else if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
> +               s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {

Exactly.  We need to be prepared that src sending too fast so when device
loading on dest we finished.

>          migration_completion_postcopy(s);
>      } else {
>          ret = -1;
> @@ -3311,8 +3323,8 @@ static MigThrError migration_detect_error(MigrationState *s)
>          return postcopy_pause(s);
>      } else {
>          /*
> -         * For precopy (or postcopy with error outside IO), we fail
> -         * with no time.
> +         * For precopy (or postcopy with error outside IO, or before dest
> +         * starts), we fail with no time.
>           */
>          migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
>          trace_migration_thread_file_err();
> @@ -3447,7 +3459,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>  {
>      uint64_t must_precopy, can_postcopy, pending_size;
>      Error *local_err = NULL;
> -    bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
> +    bool in_postcopy = (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
> +                        s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>      bool can_switchover = migration_can_switchover(s);
>      bool complete_ready;
>  
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 2d5e9c7166..c4de0325eb 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -29,6 +29,8 @@
>  #define QEMU_VM_COMMAND              0x08
>  #define QEMU_VM_SECTION_FOOTER       0x7e
>  
> +#define QEMU_VM_PING_PACKAGED_LOADED 0x42

Only curious how you picked it. :)

It's fine, it can also be 5, as we know exactly what we used to use (1-4).

> +
>  bool qemu_savevm_state_blocked(Error **errp);
>  void qemu_savevm_non_migratable_list(strList **reasons);
>  int qemu_savevm_state_prepare(Error **errp);
> diff --git a/migration/trace-events b/migration/trace-events
> index 706db97def..007b5c407e 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -191,6 +191,7 @@ source_return_path_thread_pong(uint32_t val) "0x%x"
>  source_return_path_thread_shut(uint32_t val) "0x%x"
>  source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
>  source_return_path_thread_switchover_acked(void) ""
> +source_return_path_thread_dst_started(void) ""
>  migration_thread_low_pending(uint64_t pending) "%" PRIu64
>  migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
>  process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 2387c21e9c..89a20d858d 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -142,6 +142,10 @@
>  # @postcopy-active: like active, but now in postcopy mode.
>  #     (since 2.5)
>  #
> +# @postcopy-device: like postcopy-active, but the destination is still
> +#     loading device state and is not running yet.  If migration fails
> +#     during this state, the source side will resume.  (since 10.2)

Is it worthwhile to mention we could jump from postcopy-device to
completed?  I also wonder if it happens if libvirt would get confused.
Worth checking with Jiri.

Thanks,

> +#
>  # @postcopy-paused: during postcopy but paused.  (since 3.0)
>  #
>  # @postcopy-recover-setup: setup phase for a postcopy recovery
> @@ -173,8 +177,8 @@
>  ##
>  { 'enum': 'MigrationStatus',
>    'data': [ 'none', 'setup', 'cancelling', 'cancelled',
> -            'active', 'postcopy-active', 'postcopy-paused',
> -            'postcopy-recover-setup',
> +            'active', 'postcopy-device', 'postcopy-active',
> +            'postcopy-paused', 'postcopy-recover-setup',
>              'postcopy-recover', 'completed', 'failed', 'colo',
>              'pre-switchover', 'device', 'wait-unplug' ] }
>  ##
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index bb38292550..57ca623de5 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -1316,13 +1316,14 @@ void migration_test_add_precopy(MigrationTestEnv *env)
>      }
>  
>      /* ensure new status don't go unnoticed */
> -    assert(MIGRATION_STATUS__MAX == 15);
> +    assert(MIGRATION_STATUS__MAX == 16);
>  
>      for (int i = MIGRATION_STATUS_NONE; i < MIGRATION_STATUS__MAX; i++) {
>          switch (i) {
>          case MIGRATION_STATUS_DEVICE: /* happens too fast */
>          case MIGRATION_STATUS_WAIT_UNPLUG: /* no support in tests */
>          case MIGRATION_STATUS_COLO: /* no support in tests */
> +        case MIGRATION_STATUS_POSTCOPY_DEVICE: /* postcopy can't be cancelled */
>          case MIGRATION_STATUS_POSTCOPY_ACTIVE: /* postcopy can't be cancelled */
>          case MIGRATION_STATUS_POSTCOPY_PAUSED:
>          case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
> -- 
> 2.51.0
> 

-- 
Peter Xu


