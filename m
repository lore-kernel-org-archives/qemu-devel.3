Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576E4CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 18:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ey1-0002L5-IR; Tue, 30 Sep 2025 14:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3exy-0002KN-7C
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 14:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3exp-0000Cm-Ak
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 14:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759256431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RYwTn4HzJTcCQEOpnapkNDAavBd5/ET0fxgiCaZoNrM=;
 b=i7AqA1IZzvx5Mq5TQdFpG+eeWfG3vykKWHLPTaHtky6Rf1TmkRONnFPeau8DiJAyzE1Kr6
 g8ChnaA1LzQZb+NhZIW1gqy5FUsWCQHrIKM6H22vUutCNUMvSzqzH0EYz3oJ51dvG2BmlA
 S9L3JYcTWGBm5RxeowOXzwBljeP/zC0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-5fZ4hsPLMMKbFO62EkMuLA-1; Tue, 30 Sep 2025 14:20:29 -0400
X-MC-Unique: 5fZ4hsPLMMKbFO62EkMuLA-1
X-Mimecast-MFC-AGG-ID: 5fZ4hsPLMMKbFO62EkMuLA_1759256429
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-797ab35807eso26281286d6.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 11:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759256429; x=1759861229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYwTn4HzJTcCQEOpnapkNDAavBd5/ET0fxgiCaZoNrM=;
 b=crH/U59iZdbQ9hXxptjUZ+r4MjAX0bz98Z72xc5ViTZCINALVniDiZYvP87WrB4thi
 NfAfTsHBQo6Ut7wvvA/mztKZAs65Pi8gap2Ft+7ug+ROKdC9AuMw213+zU3xOeTIlS8W
 0WXdEKokpcbq0Mlsi3OlYafFXbPaVKIidkrBImEdFs4eph5fKymd4/R9CBCNT8XTbwuR
 7+++/DkaJohW83gv/+kIHoDkEmcIlkPinh8yExKXNnTOxOQGaep3DiMO5p69kmwkUqxO
 ExGHiGzVXjoyneOUIsFWjiRBHCGSFldq3TQ5VTUEBScoMgQ217b74K21HMNSBz+49o3I
 MBvg==
X-Gm-Message-State: AOJu0YxSUTu11HYbvHWmQ+5n9Qh1gWBYJ5SYe6GquD8CwtWO/ZJntuYd
 3yg7wxF+mb66oeTMXYDC9C8HnhSRBh1Veb4b8Ao6q9XNTfK/6ubJ+/6PAlOP65TW1+J0K2NmAk1
 tGB+oDneLxGm3oqNF64cUSJHa3IE8CrquGk1yUTkTfk7oYUt7Jb2SHk8F
X-Gm-Gg: ASbGncsMAKUBCJroptmFfqm08IUNXbOs9t/ECkc9CNNBPwoBHdCDp5eJ3nhvbICHqzr
 Xgi62vggIRm1u4rRnOQmHAvHbml/tUHP4igYsLiM7xIquvO2YR3n18RQh8w17M2QnRqfVJOTzOq
 nYRp2KzT1SRMtQUrBVcaqiDcfejiht/R6gt4eIkezIRfxv0Q0GJh0J8DgIGTycwAuYdByzKNVlo
 jy5suWjTyndtM0irXjGaNCRehS0oOjtB7UHEGtMRKFmUm3cnWHNfLWXVEVixYB2X6Nf4CFsBYZM
 ANlWQhNBfYYUaR/nnJuOjfwwFS81tfhNVefZlA==
X-Received: by 2002:a05:6214:d61:b0:79a:6359:14c6 with SMTP id
 6a1803df08f44-873a79e7b35mr10459496d6.40.1759256428749; 
 Tue, 30 Sep 2025 11:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZYMcgoZuRx1+R3ff5cx2NhAdXqpCrML7KH6plhY2hOyWUlliDPoYoMQiPio61TVnxicrItw==
X-Received: by 2002:a05:6214:d61:b0:79a:6359:14c6 with SMTP id
 6a1803df08f44-873a79e7b35mr10458916d6.40.1759256428051; 
 Tue, 30 Sep 2025 11:20:28 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-81c8496e0besm83711386d6.24.2025.09.30.11.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 11:20:27 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:20:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V4 6/8] migration: cpr-exec mode
Message-ID: <aNwfakXJCoptr1p8@x1.local>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-7-git-send-email-steven.sistare@oracle.com>
 <aNwHz39FkYIq7DgX@x1.local>
 <56116ed1-a299-48b6-b6af-af36ddc9a16b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56116ed1-a299-48b6-b6af-af36ddc9a16b@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 30, 2025 at 01:18:34PM -0400, Steven Sistare wrote:
> On 9/30/2025 12:39 PM, Peter Xu wrote:
> > On Mon, Sep 22, 2025 at 06:49:43AM -0700, Steve Sistare wrote:
> > > Add the cpr-exec migration mode.  Usage:
> > >    qemu-system-$arch -machine aux-ram-share=on ...
> > >    migrate_set_parameter mode cpr-exec
> > >    migrate_set_parameter cpr-exec-command \
> > >      <arg1> <arg2> ... -incoming <uri-1> \
> > >    migrate -d <uri-1>
> > > 
> > > The migrate command stops the VM, saves state to uri-1,
> > > directly exec's a new version of QEMU on the same host,
> > > replacing the original process while retaining its PID, and
> > > loads state from uri-1.  Guest RAM is preserved in place,
> > > albeit with new virtual addresses.
> > > 
> > > The new QEMU process is started by exec'ing the command
> > > specified by the @cpr-exec-command parameter.  The first word of
> > > the command is the binary, and the remaining words are its
> > > arguments.  The command may be a direct invocation of new QEMU,
> > > or may be a non-QEMU command that exec's the new QEMU binary.
> > > 
> > > This mode creates a second migration channel that is not visible
> > > to the user.  At the start of migration, old QEMU saves CPR state
> > > to the second channel, and at the end of migration, it tells the
> > > main loop to call cpr_exec.  New QEMU loads CPR state early, before
> > > objects are created.
> > > 
> > > Because old QEMU terminates when new QEMU starts, one cannot
> > > stream data between the two, so uri-1 must be a type,
> > > such as a file, that accepts all data before old QEMU exits.
> > > Otherwise, old QEMU may quietly block writing to the channel.
> > > 
> > > Memory-backend objects must have the share=on attribute, but
> > > memory-backend-epc is not supported.  The VM must be started with
> > > the '-machine aux-ram-share=on' option, which allows anonymous
> > > memory to be transferred in place to the new process.  The memfds
> > > are kept open across exec by clearing the close-on-exec flag, their
> > > values are saved in CPR state, and they are mmap'd in new QEMU.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > ---
> > >   qapi/migration.json       | 25 +++++++++++++-
> > >   include/migration/cpr.h   |  1 +
> > >   migration/cpr-exec.c      | 84 +++++++++++++++++++++++++++++++++++++++++++++++
> > >   migration/cpr.c           | 28 ++++++++++++++--
> > >   migration/migration.c     | 10 +++++-
> > >   migration/ram.c           |  1 +
> > >   migration/vmstate-types.c |  8 +++++
> > >   system/vl.c               |  4 ++-
> > >   migration/trace-events    |  1 +
> > >   9 files changed, 157 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index 2be8fa1..be0f3fc 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -694,9 +694,32 @@
> > >   #     until you issue the `migrate-incoming` command.
> > >   #
> > >   #     (since 10.0)
> > > +#
> > > +# @cpr-exec: The migrate command stops the VM, saves state to the
> > > +#     migration channel, directly exec's a new version of QEMU on the
> > > +#     same host, replacing the original process while retaining its
> > > +#     PID, and loads state from the channel.  Guest RAM is preserved
> > > +#     in place.  Devices and their pinned pages are also preserved for
> > > +#     VFIO and IOMMUFD.
> > > +#
> > > +#     Old QEMU starts new QEMU by exec'ing the command specified by
> > > +#     the @cpr-exec-command parameter.  The command may be a direct
> > > +#     invocation of new QEMU, or may be a wrapper that exec's the new
> > > +#     QEMU binary.
> > > +#
> > > +#     Because old QEMU terminates when new QEMU starts, one cannot
> > > +#     stream data between the two, so the channel must be a type,
> > > +#     such as a file, that accepts all data before old QEMU exits.
> > > +#     Otherwise, old QEMU may quietly block writing to the channel.
> > > +#
> > > +#     Memory-backend objects must have the share=on attribute, but
> > > +#     memory-backend-epc is not supported.  The VM must be started
> > > +#     with the '-machine aux-ram-share=on' option.
> > > +#
> > > +#     (since 10.2)
> > >   ##
> > >   { 'enum': 'MigMode',
> > > -  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
> > > +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
> > >   ##
> > >   # @ZeroPageDetection:
> > > diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> > > index b84389f..beed392 100644
> > > --- a/include/migration/cpr.h
> > > +++ b/include/migration/cpr.h
> > > @@ -53,6 +53,7 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
> > >   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
> > >   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
> > > +void cpr_exec_init(void);
> > >   QEMUFile *cpr_exec_output(Error **errp);
> > >   QEMUFile *cpr_exec_input(Error **errp);
> > >   void cpr_exec_persist_state(QEMUFile *f);
> > > diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> > > index 2c32e9c..8cf55a3 100644
> > > --- a/migration/cpr-exec.c
> > > +++ b/migration/cpr-exec.c
> > > @@ -6,15 +6,21 @@
> > >   #include "qemu/osdep.h"
> > >   #include "qemu/cutils.h"
> > > +#include "qemu/error-report.h"
> > >   #include "qemu/memfd.h"
> > >   #include "qapi/error.h"
> > > +#include "qapi/type-helpers.h"
> > >   #include "io/channel-file.h"
> > >   #include "io/channel-socket.h"
> > > +#include "block/block-global-state.h"
> > > +#include "qemu/main-loop.h"
> > >   #include "migration/cpr.h"
> > >   #include "migration/qemu-file.h"
> > > +#include "migration/migration.h"
> > >   #include "migration/misc.h"
> > >   #include "migration/vmstate.h"
> > >   #include "system/runstate.h"
> > > +#include "trace.h"
> > >   #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
> > > @@ -92,3 +98,81 @@ QEMUFile *cpr_exec_input(Error **errp)
> > >       lseek(mfd, 0, SEEK_SET);
> > >       return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
> > >   }
> > > +
> > > +static bool preserve_fd(int fd)
> > > +{
> > > +    qemu_clear_cloexec(fd);
> > > +    return true;
> > > +}
> > > +
> > > +static bool unpreserve_fd(int fd)
> > > +{
> > > +    qemu_set_cloexec(fd);
> > > +    return true;
> > > +}
> > > +
> > > +static void cpr_exec_cb(void *opaque)
> > > +{
> > > +    MigrationState *s = migrate_get_current();
> > > +    char **argv = strv_from_str_list(s->parameters.cpr_exec_command);
> > > +    Error *err = NULL;
> > > +
> > > +    /*
> > > +     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
> > > +     * earlier because they should not persist across miscellaneous fork and
> > > +     * exec calls that are performed during normal operation.
> > > +     */
> > > +    cpr_walk_fd(preserve_fd);
> > > +
> > > +    trace_cpr_exec();
> > > +    execvp(argv[0], argv);
> > > +
> > > +    /*
> > > +     * exec should only fail if argv[0] is bogus, or has a permissions problem,
> > > +     * or the system is very short on resources.
> > > +     */
> > > +    g_strfreev(argv);
> > > +    cpr_walk_fd(unpreserve_fd);
> > > +
> > > +    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
> > > +    error_report_err(error_copy(err));
> > > +    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> > 
> > I believe this is the only place we can have the state machine from
> > COMPLETED->FAILED.  It's pretty hacky.  Maybe add a quick comment?
> 
> OK.
> > > +    migrate_set_error(s, err);
> > > +
> > > +    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
> > > +
> > > +    err = NULL;
> > > +    if (!migration_block_activate(&err)) {
> > > +        /* error was already reported */
> > > +        return;
> > > +    }
> > > +
> > > +    if (runstate_is_live(s->vm_old_state)) {
> > > +        vm_start();
> > > +    }
> > 
> > We have rollback logic in migration_iteration_finish().  Make a small
> > helper and reuse the code?
> Hmm.  There is some overlap, but also subtle differences.  For so littlecode, it does not feel worth any risk of regression (or worth the time to
> test and verify all conditions).

We have a fix not yet landed but should likely land soon one way or
another:

https://lore.kernel.org/all/20250915115918.3520735-2-jmarcin@redhat.com/

That should close one gap.

There's definitely reasons on sharing code, e.g. when we fix the path we
fix all users, not one.  We also don't make mistake in one path but not in
the other.  One solid example is, I feel like err is leaked above..

I'm fine if you prefer landing this first, but I'll still suggest a cleanup
on top after above patch lands.

> > > +}
> > > +
> > > +static int cpr_exec_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
> > > +                             Error **errp)
> > > +{
> > > +    MigrationState *s = migrate_get_current();
> > > +
> > > +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> > > +        QEMUBH *cpr_exec_bh = qemu_bh_new(cpr_exec_cb, NULL);
> > > +        assert(s->state == MIGRATION_STATUS_COMPLETED);
> > > +        qemu_bh_schedule(cpr_exec_bh);
> > > +        qemu_notify_event();
> > > +
> > 
> > Newline can be dropped.
> OK.
> 
> > > +    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> > > +        cpr_exec_unpersist_state();
> > > +    }
> > > +    return 0;
> > > +}
> > > +
> > > +void cpr_exec_init(void)
> > > +{
> > > +    static NotifierWithReturn exec_notifier;
> > > +
> > > +    migration_add_notifier_mode(&exec_notifier, cpr_exec_notifier,
> > > +                                MIG_MODE_CPR_EXEC);
> > > +}
> > > diff --git a/migration/cpr.c b/migration/cpr.c
> > > index d3e370e..eea3773 100644
> > > --- a/migration/cpr.c
> > > +++ b/migration/cpr.c
> > > @@ -185,6 +185,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
> > >       if (mode == MIG_MODE_CPR_TRANSFER) {
> > >           g_assert(channel);
> > >           f = cpr_transfer_output(channel, errp);
> > > +    } else if (mode == MIG_MODE_CPR_EXEC) {
> > > +        f = cpr_exec_output(errp);
> > >       } else {
> > >           return 0;
> > >       }
> > > @@ -202,6 +204,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
> > >           return ret;
> > >       }
> > > +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> > > +        cpr_exec_persist_state(f);
> > > +    }
> > > +
> > >       /*
> > >        * Close the socket only partially so we can later detect when the other
> > >        * end closes by getting a HUP event.
> > > @@ -213,6 +219,12 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
> > >       return 0;
> > >   }
> > > +static bool unpreserve_fd(int fd)
> > > +{
> > > +    qemu_set_cloexec(fd);
> > > +    return true;
> > > +}
> > 
> > Is this function defined twice?
> 
> Yes, since it is tiny.  I judged that defining this small helper twice, near each
> of its call sites, was better for the reader.

I still think we should avoid doing that.

Btw, I even think this helper should be removed on both places because
they're almost only used for a cpr_walk_fd() context, so instead looks like
we need cpr_unpreserve_fds(), which does:

        cpr_walk_fd(unpreserve_fd);

Then it can be defined in cpr.c once and export it in cpr.h.  Would that be
better?

-- 
Peter Xu


