Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7B2CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 16:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw1Gv-0007Ih-7R; Tue, 09 Sep 2025 12:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw1Gs-0007Hz-OH
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:32:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw1Gk-0004J1-MH
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757435549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A/rS49g7/DUOwKVgpfoCrHTaeaH64NL9mhQzTr6LNGM=;
 b=FS529h4S/uko2Rnvk21R9AXdxkCa+v5Umo3HBdPxJmZadl1qcFwgSCtTOF4VOCFAOuc7Xp
 4a+AGbgkpUURkHVQo634aUehchj+4n3wqHFwU2KbxPHBrr9csFEdQ5c8XZGUpblfiFibH8
 Yeg9FQEQm/gkDbrQAcwPECX+O9DuoPw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-mmnwLU6ZPIyZFe1gW2nu4A-1; Tue, 09 Sep 2025 12:32:28 -0400
X-MC-Unique: mmnwLU6ZPIyZFe1gW2nu4A-1
X-Mimecast-MFC-AGG-ID: mmnwLU6ZPIyZFe1gW2nu4A_1757435547
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7ffb4a65951so2285755685a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 09:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757435547; x=1758040347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/rS49g7/DUOwKVgpfoCrHTaeaH64NL9mhQzTr6LNGM=;
 b=krhyXx8ilTgVJu2RIbm4s2WPD2w2xMBGQMc1bpizrhHaxk3Ns6cEMJZFHQlhIRotRl
 Pjc+erwzEf/lETEkJBegCGxriAKrxZ3/HKPx/YXe166jBt+cVTdel7EMzYE9fMPPR868
 6V0G2qIfEibdSh7fH3/aH36j4MB1qEQrIfuQS+2LoRARyxSPmM7fK/6ziCQhWObYH7YJ
 t0YlLawYzZh+PWiYJenHpgXMNuOJqsH4c/debW18UNAMhHXdbpwKkopGq8cdnobmYTcR
 HovW5ck1Lmxo8bPeyboPzePJ0B+0okGIvRw1ifRo+mDS9ozSjNEG6JbcUQE1KP8KbwjE
 JbVw==
X-Gm-Message-State: AOJu0YxPDUt4pqKzu6MFWcQ8OLJsmJADAzygouzQC184SeoULs64gMYv
 q9fULcmYypLKuZ8X1oni/7DO9sO+sJsiaE4sQ43gvtDMUWEGpZPWUVkPoy/8Kx1ZAQz9rGIyupu
 aEIV3cvMV7Wjp/4pyF+MqbxNvDYS+RgaMqtF+watxQHKBOzjc8sEeV0Jw
X-Gm-Gg: ASbGncuGO4Hf80ho9XNSbTbaW724FOZYrS37gA6g+bFa+BF0JvdSoXKDEWvUwkvL5wW
 G8aw4RmCVkfyx6k6xqCLtXxt5ZxkTqOA50vTk78/slESM6SDalLnSrkDlX66Vgieju5YnZ8xigQ
 ouoZsLrA8P8OpuROCwxTR5445JQP4QFn8Yf3CtfDO5BbKkSQhjWgAYuQpvD0F9nQKyOolYtP+3C
 1Y/LxKa0vJGIaDwFVrRioytmrPd1Bf+3hjqoJrHoLwIQE8EHN4z9JA2Z3qw0DLjfoIbz8HG7YCa
 d6h1g9nZIBfjhcdTer7uTmzGC9zY39w/
X-Received: by 2002:a05:620a:1a99:b0:7e8:4400:d082 with SMTP id
 af79cd13be357-813bf8b5129mr1097899085a.36.1757435546793; 
 Tue, 09 Sep 2025 09:32:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYNGEfINgg/TBBtDaAqqoDuo4xghfWy76CqQGAlUOKkE5i4C3y/vGocBraWqLq4UbRmcK/RQ==
X-Received: by 2002:a05:620a:1a99:b0:7e8:4400:d082 with SMTP id
 af79cd13be357-813bf8b5129mr1097891485a.36.1757435545857; 
 Tue, 09 Sep 2025 09:32:25 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b61bbf161dsm11364521cf.44.2025.09.09.09.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 09:32:25 -0700 (PDT)
Date: Tue, 9 Sep 2025 12:32:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH V3 7/9] migration: cpr-exec mode
Message-ID: <aMBWjBGPnmz3rtwh@x1.local>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-8-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1755191843-283480-8-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 14, 2025 at 10:17:21AM -0700, Steve Sistare wrote:
> Add the cpr-exec migration mode.  Usage:
>   qemu-system-$arch -machine aux-ram-share=on ...
>   migrate_set_parameter mode cpr-exec
>   migrate_set_parameter cpr-exec-command \
>     <arg1> <arg2> ... -incoming <uri-1> \
>   migrate -d <uri-1>
> 
> The migrate command stops the VM, saves state to uri-1,
> directly exec's a new version of QEMU on the same host,
> replacing the original process while retaining its PID, and
> loads state from uri-1.  Guest RAM is preserved in place,
> albeit with new virtual addresses.
> 
> The new QEMU process is started by exec'ing the command
> specified by the @cpr-exec-command parameter.  The first word of
> the command is the binary, and the remaining words are its
> arguments.  The command may be a direct invocation of new QEMU,
> or may be a non-QEMU command that exec's the new QEMU binary.
> 
> This mode creates a second migration channel that is not visible
> to the user.  At the start of migration, old QEMU saves CPR state
> to the second channel, and at the end of migration, it tells the
> main loop to call cpr_exec.  New QEMU loads CPR state early, before
> objects are created.
> 
> Because old QEMU terminates when new QEMU starts, one cannot
> stream data between the two, so uri-1 must be a type,
> such as a file, that accepts all data before old QEMU exits.
> Otherwise, old QEMU may quietly block writing to the channel.
> 
> Memory-backend objects must have the share=on attribute, but
> memory-backend-epc is not supported.  The VM must be started with
> the '-machine aux-ram-share=on' option, which allows anonymous
> memory to be transferred in place to the new process.  The memfds
> are kept open across exec by clearing the close-on-exec flag, their
> values are saved in CPR state, and they are mmap'd in new QEMU.

Some generic questions around exec..

How do we know we can already safely kill all threads?

IIUC vcpu threads must be all stopped.  I wonder if we want to assert that
in the exec helper below.

What about rest threads?  RCU threads should be for freeing resources,
looks ok if to be ignored.  But others?

Or would process states still matter in some cases? e.g. when QEMU is
talking to another vhost-user, or vfio-user, or virtio-fs, or ... whatever
other process, then suddenly the other process doesn't recognize this QEMU
anymore?

What about file locks or similiar shared locks that can be running in an
iothread?  Is it possible that old QEMU took some shared locks, suddenly
qemu exec(), then the lock is never released?

> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  qapi/migration.json       | 25 +++++++++++++++-
>  include/migration/cpr.h   |  1 +
>  migration/cpr-exec.c      | 74 +++++++++++++++++++++++++++++++++++++++++++++++
>  migration/cpr.c           | 26 ++++++++++++++++-
>  migration/migration.c     | 10 ++++++-
>  migration/ram.c           |  1 +
>  migration/vmstate-types.c |  8 +++++
>  migration/trace-events    |  1 +
>  8 files changed, 143 insertions(+), 3 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index ea410fd..cbc90e8 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -694,9 +694,32 @@
>  #     until you issue the `migrate-incoming` command.
>  #
>  #     (since 10.0)
> +#
> +# @cpr-exec: The migrate command stops the VM, saves state to the
> +#     migration channel, directly exec's a new version of QEMU on the
> +#     same host, replacing the original process while retaining its
> +#     PID, and loads state from the channel.  Guest RAM is preserved
> +#     in place.  Devices and their pinned pages are also preserved for
> +#     VFIO and IOMMUFD.
> +#
> +#     Old QEMU starts new QEMU by exec'ing the command specified by
> +#     the @cpr-exec-command parameter.  The command may be a direct
> +#     invocation of new QEMU, or may be a non-QEMU command that exec's
> +#     the new QEMU binary.
> +#
> +#     Because old QEMU terminates when new QEMU starts, one cannot
> +#     stream data between the two, so the channel must be a type,
> +#     such as a file, that accepts all data before old QEMU exits.
> +#     Otherwise, old QEMU may quietly block writing to the channel.

The CPR channel (in case of exec mode) is persisted via env var.  Why not
do that too for the main migration stream?

Does it has something to do with the size of the binary chunk to store all
device states (and some private mem)?  Or other concerns?

It just feels like it would look cleaner for cpr-exec to not need -incoming
XXX at all, e.g. if the series already used envvar anyway, we can use that
too so new QEMU would know it's cpr-exec incoming migration, without
-incoming parameter at all.

> +#
> +#     Memory-backend objects must have the share=on attribute, but
> +#     memory-backend-epc is not supported.  The VM must be started
> +#     with the '-machine aux-ram-share=on' option.
> +#
> +#     (since 10.2)
>  ##
>  { 'enum': 'MigMode',
> -  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
>  
>  ##
>  # @ZeroPageDetection:
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index aaeec02..e99e48e 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -54,6 +54,7 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index, bool cpr,
>  QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>  QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>  
> +void cpr_exec_init(void);
>  QEMUFile *cpr_exec_output(Error **errp);
>  QEMUFile *cpr_exec_input(Error **errp);
>  void cpr_exec_persist_state(QEMUFile *f);
> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> index 2c32e9c..7d0429f 100644
> --- a/migration/cpr-exec.c
> +++ b/migration/cpr-exec.c
> @@ -6,15 +6,20 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
> +#include "qemu/error-report.h"
>  #include "qemu/memfd.h"
>  #include "qapi/error.h"
>  #include "io/channel-file.h"
>  #include "io/channel-socket.h"
> +#include "block/block-global-state.h"
> +#include "qemu/main-loop.h"
>  #include "migration/cpr.h"
>  #include "migration/qemu-file.h"
> +#include "migration/migration.h"
>  #include "migration/misc.h"
>  #include "migration/vmstate.h"
>  #include "system/runstate.h"
> +#include "trace.h"
>  
>  #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
>  
> @@ -92,3 +97,72 @@ QEMUFile *cpr_exec_input(Error **errp)
>      lseek(mfd, 0, SEEK_SET);
>      return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
>  }
> +
> +static bool preserve_fd(int fd)
> +{
> +    qemu_clear_cloexec(fd);
> +    return true;
> +}
> +
> +static bool unpreserve_fd(int fd)
> +{
> +    qemu_set_cloexec(fd);
> +    return true;
> +}
> +
> +static void cpr_exec(char **argv)
> +{
> +    MigrationState *s = migrate_get_current();
> +    Error *err = NULL;
> +
> +    /*
> +     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
> +     * earlier because they should not persist across miscellaneous fork and
> +     * exec calls that are performed during normal operation.
> +     */
> +    cpr_walk_fd(preserve_fd);
> +
> +    trace_cpr_exec();
> +    execvp(argv[0], argv);
> +
> +    cpr_walk_fd(unpreserve_fd);
> +
> +    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
> +    error_report_err(error_copy(err));

Feel free to ignore my question in the other patch, so we dump some errors
here.. which makes sense.

> +    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);

This is indeed FAILED migration, however it seems to imply it can catch
whatever possible failures that incoming could have.  Strictly speaking
this is not migration failure, but exec failure..  Maybe we need a comment
above this one explaining that we won't be able to capture any migration
issues, it's too late after exec() succeeded, so there's higher risk of
crashing the VM.

Luckily we still are on the same host, so things like mismatched kernel
versions at least won't crash this migration.. aka not as easy to fail a
migration as cross- hosts indeed. But still, I'd say I agree with Vladimir
that this is a major flaw of the design if so.

> +    migrate_set_error(s, err);
> +
> +    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
> +
> +    err = NULL;
> +    if (!migration_block_activate(&err)) {
> +        /* error was already reported */
> +        return;
> +    }
> +
> +    if (runstate_is_live(s->vm_old_state)) {
> +        vm_start();
> +    }
> +}
> +
> +static int cpr_exec_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
> +                             Error **errp)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> +        assert(s->state == MIGRATION_STATUS_COMPLETED);
> +        qemu_system_exec_request(cpr_exec, s->parameters.cpr_exec_command);
> +    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> +        cpr_exec_unpersist_state();
> +    }
> +    return 0;
> +}
> +
> +void cpr_exec_init(void)
> +{
> +    static NotifierWithReturn exec_notifier;
> +
> +    migration_add_notifier_mode(&exec_notifier, cpr_exec_notifier,
> +                                MIG_MODE_CPR_EXEC);

Why using a notifier?  IMHO exec() is something important enough to not be
hiding in a notifier..  and CPR is already a major part of migration in the
framework, IMHO it'll be cleaner to invoke any CPR request in the migration
subsystem.  AFAIU notifiers are normally only for outside migration/ purposes.

> +}
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 021bd6a..2078d05 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -198,6 +198,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>      if (mode == MIG_MODE_CPR_TRANSFER) {
>          g_assert(channel);
>          f = cpr_transfer_output(channel, errp);
> +    } else if (mode == MIG_MODE_CPR_EXEC) {
> +        f = cpr_exec_output(errp);
>      } else {
>          return 0;
>      }
> @@ -215,6 +217,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>          return ret;
>      }
>  
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> +        cpr_exec_persist_state(f);
> +    }
> +
>      /*
>       * Close the socket only partially so we can later detect when the other
>       * end closes by getting a HUP event.
> @@ -226,6 +232,12 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>      return 0;
>  }
>  
> +static bool unpreserve_fd(int fd)
> +{
> +    qemu_set_cloexec(fd);
> +    return true;
> +}
> +
>  int cpr_state_load(MigrationChannel *channel, Error **errp)
>  {
>      int ret;
> @@ -237,6 +249,12 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>          mode = MIG_MODE_CPR_TRANSFER;
>          cpr_set_incoming_mode(mode);
>          f = cpr_transfer_input(channel, errp);
> +    } else if (cpr_exec_has_state()) {
> +        mode = MIG_MODE_CPR_EXEC;
> +        f = cpr_exec_input(errp);
> +        if (channel) {
> +            warn_report("ignoring cpr channel for migration mode cpr-exec");

This looks like dead code?  channel can't be set when reaching here, AFAIU..

> +        }
>      } else {
>          return 0;
>      }
> @@ -245,6 +263,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>      }
>  
>      trace_cpr_state_load(MigMode_str(mode));
> +    cpr_set_incoming_mode(mode);
>  
>      v = qemu_get_be32(f);
>      if (v != QEMU_CPR_FILE_MAGIC) {
> @@ -266,6 +285,11 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>          return ret;
>      }
>  
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> +        /* Set cloexec to prevent fd leaks from fork until the next cpr-exec */
> +        cpr_walk_fd(unpreserve_fd);
> +    }
> +
>      /*
>       * Let the caller decide when to close the socket (and generate a HUP event
>       * for the sending side).
> @@ -286,7 +310,7 @@ void cpr_state_close(void)
>  bool cpr_incoming_needed(void *opaque)
>  {
>      MigMode mode = migrate_mode();
> -    return mode == MIG_MODE_CPR_TRANSFER;
> +    return mode == MIG_MODE_CPR_TRANSFER || mode == MIG_MODE_CPR_EXEC;
>  }
>  
>  /*
> diff --git a/migration/migration.c b/migration/migration.c
> index 271c521..d604284 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -333,6 +333,7 @@ void migration_object_init(void)
>  
>      ram_mig_init();
>      dirty_bitmap_mig_init();
> +    cpr_exec_init();
>  
>      /* Initialize cpu throttle timers */
>      cpu_throttle_init();
> @@ -1797,7 +1798,8 @@ bool migrate_mode_is_cpr(MigrationState *s)
>  {
>      MigMode mode = s->parameters.mode;
>      return mode == MIG_MODE_CPR_REBOOT ||
> -           mode == MIG_MODE_CPR_TRANSFER;
> +           mode == MIG_MODE_CPR_TRANSFER ||
> +           mode == MIG_MODE_CPR_EXEC;
>  }
>  
>  int migrate_init(MigrationState *s, Error **errp)
> @@ -2146,6 +2148,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>          return false;
>      }
>  
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC &&
> +        !s->parameters.has_cpr_exec_command) {
> +        error_setg(errp, "cpr-exec mode requires setting cpr-exec-command");
> +        return false;
> +    }
> +
>      if (migration_is_blocked(errp)) {
>          return false;
>      }
> diff --git a/migration/ram.c b/migration/ram.c
> index 7208bc1..6730a41 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -228,6 +228,7 @@ bool migrate_ram_is_ignored(RAMBlock *block)
>      MigMode mode = migrate_mode();
>      return !qemu_ram_is_migratable(block) ||
>             mode == MIG_MODE_CPR_TRANSFER ||
> +           mode == MIG_MODE_CPR_EXEC ||
>             (migrate_ignore_shared() && qemu_ram_is_shared(block)
>                                      && qemu_ram_is_named_file(block));
>  }
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 741a588..1aa0573 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -321,6 +321,10 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
>                    const VMStateField *field)
>  {
>      int32_t *v = pv;
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> +        qemu_get_sbe32s(f, v);
> +        return 0;
> +    }
>      *v = qemu_file_get_fd(f);
>      return 0;
>  }
> @@ -329,6 +333,10 @@ static int put_fd(QEMUFile *f, void *pv, size_t size,
>                    const VMStateField *field, JSONWriter *vmdesc)
>  {
>      int32_t *v = pv;
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> +        qemu_put_sbe32s(f, v);
> +        return 0;
> +    }
>      return qemu_file_put_fd(f, *v);
>  }
>  
> diff --git a/migration/trace-events b/migration/trace-events
> index 706db97..e8edd1f 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -354,6 +354,7 @@ cpr_state_save(const char *mode) "%s mode"
>  cpr_state_load(const char *mode) "%s mode"
>  cpr_transfer_input(const char *path) "%s"
>  cpr_transfer_output(const char *path) "%s"
> +cpr_exec(void) ""
>  
>  # block-dirty-bitmap.c
>  send_bitmap_header_enter(void) ""
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


