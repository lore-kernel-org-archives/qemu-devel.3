Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7968E6F09D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4R6-0005ha-CS; Tue, 23 Dec 2025 10:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vY4R4-0005hO-Ff
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:36:30 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vY4R2-0005bw-5s
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:36:30 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 179A933694;
 Tue, 23 Dec 2025 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766504184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VGzWKJT2R5twOhsSMTT5Eh0HYFFv+3zwlfX5K6uuvqQ=;
 b=QNBAYy8hI3tohrnsLlHXhcw+5sHQ8S5y0qvkHyrIaEtQ/afb0bKfmWe8AgskdIUQnd+rhr
 rv2b5gksOlo6qUCdkxlSJmFyu+h4ObKMh9zgYnk2b40pQYlCyBEFoKZtUzUUb8PntQbQI5
 slN1zFGMwTU/IOYmU0b/iEjEqhE32hM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766504184;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VGzWKJT2R5twOhsSMTT5Eh0HYFFv+3zwlfX5K6uuvqQ=;
 b=J+xNqhYjL3cnlmn1Sn9+sGK53fhFLq/nytlcrD1E4bG5ZDaT60DfNrT4tWfnrEKffIgv70
 Oag4WD1bH+mP7rBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=afL8cBiH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ILnteHBz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766504183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VGzWKJT2R5twOhsSMTT5Eh0HYFFv+3zwlfX5K6uuvqQ=;
 b=afL8cBiHrYT1TgdNHcSNT+5ssjD9GyM2hO3mBq+9x22mrMemyNfqyXe2p9uVVZncUhm9fJ
 MPTv4SK2+DAQcWykbRbtqUyg1i/j7XHC4/gbarO6Z2D7fOGJHX/RI9yBDI2ogg9I/hxypx
 777WJ5SdqhYwd9hzSOv8frk3+LAL+tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766504183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VGzWKJT2R5twOhsSMTT5Eh0HYFFv+3zwlfX5K6uuvqQ=;
 b=ILnteHBz2SsDoROeJZYQNQ2E6SRoNz0CFMFm7L9W4JJEOGPoH3nb1WEzqzVFpdvyowSQ1E
 7+eShoPfjyuEG8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 898333EA63;
 Tue, 23 Dec 2025 15:36:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hw0xE/a2SmniBAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 23 Dec 2025 15:36:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
In-Reply-To: <aUqyfkOtXwl6cy9A@x1.local>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <aUqyfkOtXwl6cy9A@x1.local>
Date: Tue, 23 Dec 2025 12:36:19 -0300
Message-ID: <87a4z9ky6k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[fedoraproject.org:email,suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 179A933694
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Dec 22, 2025 at 05:18:22PM +0530, Prasad Pandit wrote:
>> From: Prasad Pandit <pjp@fedoraproject.org>
>> 
>> When migration connection is broken, the QEMU and libvirtd(8)
>> process on the source side receive TCP connection reset
>> notification. QEMU sets the migration status to FAILED and
>> proceeds to migration_cleanup(). Meanwhile, Libvirtd(8) sends
>> a QMP command to migrate_set_capabilities().
>> 
>> The migration_cleanup() and qmp_migrate_set_capabilities()
>> calls race with each other. When the latter is invoked first,
>> since the migration is not running (FAILED), migration
>> capabilities are reset to false, so during migration_cleanup()
>> the QEMU process crashes with assertion failure.
>> 
>>   Stack trace of thread 255014:
>>    #0  __pthread_kill_implementation (libc.so.6 + 0x822e8)
>>    #1  raise (libc.so.6 + 0x3a73c)
>>    #2  abort (libc.so.6 + 0x27034)
>>    #3  __assert_fail_base (libc.so.6 + 0x34090)
>>    #4  __assert_fail (libc.so.6 + 0x34100)
>>    #5  yank_unregister_instance (qemu-kvm + 0x8b8280)
>>    #6  migrate_fd_cleanup (qemu-kvm + 0x3c6308)
>>    #7  migration_bh_dispatch_bh (qemu-kvm + 0x3c2144)
>>    #8  aio_bh_poll (qemu-kvm + 0x8ba358)
>>    #9  aio_dispatch (qemu-kvm + 0x8a0ab4)
>>    #10 aio_ctx_dispatch (qemu-kvm + 0x8bb180)
>> 
>> Introduce a new migration status FAILING and use it as an
>> interim status when an error occurs. Once migration_cleanup()
>> is done, it sets the migration status to FAILED. This helps
>> to avoid the above race condition and ensuing failure.
>> 
>> Interim status FAILING is set wherever the execution moves
>> towards migration_cleanup() directly OR via:
>> 
>>   migration_iteration_finish  bg_migration_iteration_finish
>>   -> migration_bh_schedule    -> migration_bh_schedule
>>    -> migration_cleanup_bh     -> migration_cleanup_bh
>>     -> migration_cleanup        -> migration_cleanup
>>      -> FAILED                   -> FAILED
>> 
>> The migration status finally moves to FAILED and reports an
>> appropriate error to the user.
>
> I raised a request while I was discussing with you internally, I didn't see
> this, I will request again:
>
> Would you please list where you decided to switch from FAILED -> FAILING,
> and where you decided not, with justifications for each of them?
>
> Let me give a detailed example in this patch, please see below.
>
>> 
>> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
>> ---
>>  migration/migration.c                 | 33 +++++++++++++++------------
>>  migration/multifd.c                   |  4 ++--
>>  qapi/migration.json                   |  8 ++++---
>>  tests/qtest/migration/migration-qmp.c |  3 ++-
>>  tests/qtest/migration/precopy-tests.c |  5 ++--
>>  5 files changed, 31 insertions(+), 22 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index b316ee01ab..5c32bc8fe5 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1216,6 +1216,7 @@ bool migration_is_running(void)
>>      case MIGRATION_STATUS_DEVICE:
>>      case MIGRATION_STATUS_WAIT_UNPLUG:
>>      case MIGRATION_STATUS_CANCELLING:
>> +    case MIGRATION_STATUS_FAILING:
>>      case MIGRATION_STATUS_COLO:
>>          return true;
>>      default:
>> @@ -1351,6 +1352,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>>          break;
>>      case MIGRATION_STATUS_ACTIVE:
>>      case MIGRATION_STATUS_CANCELLING:
>> +    case MIGRATION_STATUS_FAILING:
>>      case MIGRATION_STATUS_POSTCOPY_DEVICE:
>>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>>      case MIGRATION_STATUS_PRE_SWITCHOVER:
>> @@ -1409,6 +1411,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
>>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>>      case MIGRATION_STATUS_POSTCOPY_RECOVER:
>> +    case MIGRATION_STATUS_FAILING:
>>      case MIGRATION_STATUS_FAILED:
>>      case MIGRATION_STATUS_COLO:
>>          info->has_status = true;
>> @@ -1531,6 +1534,9 @@ static void migration_cleanup(MigrationState *s)
>>      if (s->state == MIGRATION_STATUS_CANCELLING) {
>>          migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
>>                            MIGRATION_STATUS_CANCELLED);
>> +    } else if (s->state == MIGRATION_STATUS_FAILING) {
>> +        migrate_set_state(&s->state, MIGRATION_STATUS_FAILING,
>> +                          MIGRATION_STATUS_FAILED);
>>      }
>>  
>>      if (s->error) {
>> @@ -1584,7 +1590,7 @@ static void migration_connect_set_error(MigrationState *s, const Error *error)
>>  
>>      switch (current) {
>>      case MIGRATION_STATUS_SETUP:
>> -        next = MIGRATION_STATUS_FAILED;
>> +        next = MIGRATION_STATUS_FAILING;
>
> This is the first real change that we'll switch to FAILING when
> migration_connect_set_error() is invoked and migration failed.
>
> Please justify why setting FAILING is correct here.
>
> This function is invoked in three callers:
>
> qmp_migrate[2302]              migration_connect_set_error(s, local_err);
> qmp_migrate_finish[2347]       migration_connect_set_error(s, local_err);
> migration_connect[4047]        migration_connect_set_error(s, error_in);
>
> At least from the initial two callers, I don't see migration_cleanup()
> invoked after setting FAILING.  Could this cause migration to get into
> FAILING status forever without finally move to FAILED?
>

Good point, I'm working on some cleanups to connection code and one
change I did there is to add a migration_cleanup() call into
migration_connect_error_propagate().

1) branch WIP:
https://gitlab.com/farosas/qemu/-/commits/migration-connect-cleanup

2) the patch:
---
From 1f9eeb898f3a5efba7c183e351fa36a5471fd0b2 Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Thu, 18 Dec 2025 10:54:46 -0300
Subject: [PATCH] migration: Fold migration_cleanup into
 migration_connect_error_propagate

The code path from qmp_migrate() until the migration thread starts is
a little twisty due to the async nature of some routines. One issue is
that the async functions cannot return errors to their callers and
must instead call forward into migration_channel_connect() and pass
the error as input.

Ideally we'd have a function that just receives the error as input and
handles it. However, currently migration_channel_connect() has a code
path that moves forward into migration_connect(), also passing the
error as input, only for migration_connect() to then check that an
error happened and call migration_cleanup().

Clean this up:

1) Make migration_connect_error_propagate() be the function that
handles the error and call it at the point the error happens in the
async code. (this is all migration code, there's no layering
violation)

2) Stop checking for an incoming error in migration_connect(), that
function should be only reached when everything that came before
succeeded.

3) Fold migration_cleanup() into migration_connect_error_propagate()
so the cleanup happens at the moment the error is detected and not
several calls down the stack.

4) To address the quirk that during postcopy recovery there should be
no cleanup, move that check into migration_cleanup() and return early
if doing resume.

Notable functional changes:

i) Assumes a larger window for what it means to be "in resume"
   before: from qmp_migrate until migration_connect
   after: from qmp_migration until the state transition into
          MIGRATION_STATUS_POSTCOPY_RECOVER

ii) After an error, MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP changes to
    MIGRATION_STATUS_POSTCOPY_PAUSED.

    This is already the case when migration_connect_error_propagate()
    was used, but not when migration_connect() receives
    error_in. Seems like a pre-existing bug actually.

iii) If the socket_start_outgoing_migration function *returns* an
     error, now migration_cleanup() is called. Previously, cleanup
     only happened when the error was *passed* forward, i.e. only
     after the async call.

iv) If cpr_state_save() fails, now migration_cleanup() is called.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4b1afcab24..52c1a97e46 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1481,6 +1481,14 @@ static void migration_cleanup(MigrationState *s)
     MigrationEventType type;
     QEMUFile *tmp = NULL;
 
+    /*
+     * Don't do cleanup if we're waiting for another connection from
+     * the user.
+     */
+    if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP) {
+        return;
+    }
+
     trace_migration_cleanup();
 
     migration_cleanup_json_writer(s);
@@ -1585,6 +1593,14 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
         /* Never fail a postcopy migration; switch back to PAUSED instead */
         next = MIGRATION_STATUS_POSTCOPY_PAUSED;
+
+        /*
+         * Give HMP user a hint on what failed.  It's normally done in
+         * migration_cleanup(), but call it here explicitly because we
+         * don't do cleanup when waiting for postcopy recover.
+         */
+        error_report_err(error_copy(error));
+
         break;
     default:
         /*
@@ -1598,6 +1614,7 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
 
     migrate_set_state(&s->state, current, next);
     migrate_error_propagate(s, error);
+    migration_cleanup(s);
 }
 
 void migration_cancel(void)
@@ -2326,12 +2343,8 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
     }
 
     if (local_err) {
-        if (!resume_requested) {
-            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
-        }
-        migration_connect_error_propagate(s, error_copy(local_err));
+        migration_connect_error_propagate(s, local_err);
         error_propagate(errp, local_err);
-        return;
     }
 }
 
@@ -4026,18 +4039,6 @@ void migration_connect(MigrationState *s, Error *error_in)
     s->expected_downtime = migrate_downtime_limit();
     if (error_in) {
         migration_connect_error_propagate(s, error_in);
-        if (resume) {
-            /*
-             * Don't do cleanup for resume if channel is invalid, but only dump
-             * the error.  We wait for another channel connect from the user.
-             * The error_report still gives HMP user a hint on what failed.
-             * It's normally done in migration_cleanup(), but call it here
-             * explicitly.
-             */
-            error_report_err(error_copy(s->error));
-        } else {
-            migration_cleanup(s);
-        }
         return;
     }
 
-- 

