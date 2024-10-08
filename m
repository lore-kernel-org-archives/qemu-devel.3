Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17C2CEFC27
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 15:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syCOs-0007bK-9M; Tue, 08 Oct 2024 11:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syCOj-0007aW-3N
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syCOg-0003bx-0L
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728402312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NOTESuifx+GxdynsbE3tK/a1J0DecfmBqRZlAjYzf6c=;
 b=c0iGMEt+sDZ7Z5SqLTPBFNpRjLWyt/+QlV8i8aS0SqEuPrQZQOZOJkJuZQKcdUMuzDbsM/
 zxtd8wJD2nb14kcciyVoMD3feHjjmyBXf0Na8ZF7stCeS9o2cfUGVj3RJPIM0ITOx5AlBu
 ljixwf6kJKZHy889XYKB/33evXOp7/w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-4Y6MOyytP4agt53FTCdHJw-1; Tue, 08 Oct 2024 11:45:11 -0400
X-MC-Unique: 4Y6MOyytP4agt53FTCdHJw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a9a6634b08so942393885a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 08:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728402310; x=1729007110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOTESuifx+GxdynsbE3tK/a1J0DecfmBqRZlAjYzf6c=;
 b=bzi4q02y7fMxDr25K/b3sIoninmpMrAYZfIdxB+GO52UHxwd13uXok9xItK+42DeAC
 0M+4GRXXZ0dQwuLqENYacGCp2AwF/FzI4csnTL/c37A1EIH+3jGFdDxJ0vPR4KhthmCr
 nRmsr3xl8pP7g53t6g3/RlkzcdfVK3EsVh9ITMfhDPX2NTUa+0kJSA0qcb3jyD7i3Pf8
 RwzVl11ud57jnpGVD5ch52irJyfpFxgvydvImjazvvYOeOMvB+t+HMd3sa5r8I4iCR9O
 wLKfIXM+g3OVj9EDH6LwAdGEhsxiYAFcGgeVVVcuiweBZ+3+jXwA49V+rMpYe5D6AxHe
 4MDA==
X-Gm-Message-State: AOJu0Yw7ysAbCslulUJF4Yt7awVfkYawjMUolpMa+n4U4/qz43ltt+0j
 LiGy5zB52THmDVcmw7qDFjFDy+8E4eeRBqWJtk0gt4P3/mhfPkANA/kXfbQQr/gjqoV58Wk4bF5
 aZ29s3TGKR/vCQFjhxwLVgDmjvwem0vxr3A795AYwPEHFZq0SRR4o
X-Received: by 2002:a05:620a:6689:b0:7a7:fe96:880a with SMTP id
 af79cd13be357-7ae85f85435mr481600385a.31.1728402310192; 
 Tue, 08 Oct 2024 08:45:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYahr0Ej9+B4pfXerR97Hf8pfagKO6zrLvi0l8zNVAQ99DsDJw/vXNBQxU8ww1XtFYipFJGQ==
X-Received: by 2002:a05:620a:6689:b0:7a7:fe96:880a with SMTP id
 af79cd13be357-7ae85f85435mr481594985a.31.1728402309630; 
 Tue, 08 Oct 2024 08:45:09 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae756611b5sm364520885a.77.2024.10.08.08.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 08:45:09 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:45:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
Message-ID: <ZwVTgl9t3KButBDs@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n>
 <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 07, 2024 at 04:39:25PM -0400, Steven Sistare wrote:
> On 10/7/2024 3:44 PM, Peter Xu wrote:
> > On Mon, Sep 30, 2024 at 12:40:44PM -0700, Steve Sistare wrote:
> > > Add the cpr-transfer migration mode.  Usage:
> > >    qemu-system-$arch -machine anon-alloc=memfd ...
> > > 
> > >    start new QEMU with "-incoming <uri-1> -cpr-uri <uri-2>"
> > > 
> > >    Issue commands to old QEMU:
> > >    migrate_set_parameter mode cpr-transfer
> > >    migrate_set_parameter cpr-uri <uri-2>
> > >    migrate -d <uri-1>
> > > 
> > > The migrate command stops the VM, saves CPR state to uri-2, saves
> > > normal migration state to uri-1, and old QEMU enters the postmigrate
> > > state.  The user starts new QEMU on the same host as old QEMU, with the
> > > same arguments as old QEMU, plus the -incoming option.  Guest RAM is
> > > preserved in place, albeit with new virtual addresses in new QEMU.
> > > 
> > > This mode requires a second migration channel, specified by the
> > > cpr-uri migration property on the outgoing side, and by the cpr-uri
> > > QEMU command-line option on the incoming side.  The channel must
> > > be a type, such as unix socket, that supports SCM_RIGHTS.
> > > 
> > > Memory-backend objects must have the share=on attribute, but
> > > memory-backend-epc is not supported.  The VM must be started with
> > > the '-machine anon-alloc=memfd' option, which allows anonymous
> > > memory to be transferred in place to the new process.  The memfds
> > > are kept open by sending the descriptors to new QEMU via the
> > > cpr-uri, which must support SCM_RIGHTS, and they are mmap'd
> > > in new QEMU.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > ---
> > >   include/migration/cpr.h   |  1 +
> > >   migration/cpr.c           | 34 +++++++++++++++++++----
> > >   migration/migration.c     | 69 +++++++++++++++++++++++++++++++++++++++++++++--
> > >   migration/migration.h     |  2 ++
> > >   migration/ram.c           |  2 ++
> > >   migration/vmstate-types.c |  5 ++--
> > >   qapi/migration.json       | 27 ++++++++++++++++++-
> > >   stubs/vmstate.c           |  7 +++++
> > >   8 files changed, 137 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> > > index e886c98..5cd373f 100644
> > > --- a/include/migration/cpr.h
> > > +++ b/include/migration/cpr.h
> > > @@ -30,6 +30,7 @@ int cpr_state_save(Error **errp);
> > >   int cpr_state_load(Error **errp);
> > >   void cpr_state_close(void);
> > >   struct QIOChannel *cpr_state_ioc(void);
> > > +bool cpr_needed_for_reuse(void *opaque);
> > >   QEMUFile *cpr_transfer_output(const char *uri, Error **errp);
> > >   QEMUFile *cpr_transfer_input(const char *uri, Error **errp);
> > > diff --git a/migration/cpr.c b/migration/cpr.c
> > > index 86f66c1..911b556 100644
> > > --- a/migration/cpr.c
> > > +++ b/migration/cpr.c
> > > @@ -9,6 +9,7 @@
> > >   #include "qapi/error.h"
> > >   #include "migration/cpr.h"
> > >   #include "migration/misc.h"
> > > +#include "migration/options.h"
> > >   #include "migration/qemu-file.h"
> > >   #include "migration/savevm.h"
> > >   #include "migration/vmstate.h"
> > > @@ -57,7 +58,7 @@ static const VMStateDescription vmstate_cpr_fd = {
> > >           VMSTATE_UINT32(namelen, CprFd),
> > >           VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
> > >           VMSTATE_INT32(id, CprFd),
> > > -        VMSTATE_INT32(fd, CprFd),
> > > +        VMSTATE_FD(fd, CprFd),
> > >           VMSTATE_END_OF_LIST()
> > >       }
> > >   };
> > > @@ -174,9 +175,16 @@ int cpr_state_save(Error **errp)
> > >   {
> > >       int ret;
> > >       QEMUFile *f;
> > > +    MigMode mode = migrate_mode();
> > > -    /* set f based on mode in a later patch in this series */
> > > -    return 0;
> > > +    if (mode == MIG_MODE_CPR_TRANSFER) {
> > > +        f = cpr_transfer_output(migrate_cpr_uri(), errp);
> > > +    } else {
> > > +        return 0;
> > > +    }
> > > +    if (!f) {
> > > +        return -1;
> > > +    }
> > >       qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
> > >       qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
> > > @@ -205,8 +213,18 @@ int cpr_state_load(Error **errp)
> > >       uint32_t v;
> > >       QEMUFile *f;
> > > -    /* set f based on mode in a later patch in this series */
> > > -    return 0;
> > > +    /*
> > > +     * Mode will be loaded in CPR state, so cannot use it to decide which
> > > +     * form of state to load.
> > > +     */
> > > +    if (cpr_uri) {
> > > +        f = cpr_transfer_input(cpr_uri, errp);
> > > +    } else {
> > > +        return 0;
> > > +    }
> > > +    if (!f) {
> > > +        return -1;
> > > +    }
> > >       v = qemu_get_be32(f);
> > >       if (v != QEMU_CPR_FILE_MAGIC) {
> > > @@ -243,3 +261,9 @@ void cpr_state_close(void)
> > >           cpr_state_file = NULL;
> > >       }
> > >   }
> > > +
> > > +bool cpr_needed_for_reuse(void *opaque)
> > > +{
> > > +    MigMode mode = migrate_mode();
> > > +    return mode == MIG_MODE_CPR_TRANSFER;
> > > +}
> > 
> > Drop it until used?
> 
> Maybe, but here is my reason for including it here.
> 
> These common functions like cpr_needed_for_reuse and cpr_resave_fd are needed
> by multiple follow-on series: vfio, tap, iommufd.  To send those for comment,
> as I have beem, I need to prepend a patch for cpr_needed_for_reuse to each of
> those series, which is redundant.  It makes more sense IMO to include them in
> this initial series.
> 
> But, it's your call.

Hmm, logically we shouldn't keep any dead code in QEMU, but indeed this is
slightly special.

Would you mind keeping all these helpers in a separate patch after the base
patches?  The commit message should describe what future projects will
start to use it, then whoever noticed later (I at least know Dave has quite
a few patches recently removing dead code in QEMU) will know that's
potentially to-be-used code, so should keep them around.

> 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 3301583..73b85aa 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -76,6 +76,7 @@
> > >   static NotifierWithReturnList migration_state_notifiers[] = {
> > >       NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
> > >       NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
> > > +    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_TRANSFER),
> > >   };
> > >   /* Messages sent on the return path from destination to source */
> > > @@ -109,6 +110,7 @@ static int migration_maybe_pause(MigrationState *s,
> > >   static void migrate_fd_cancel(MigrationState *s);
> > >   static bool close_return_path_on_source(MigrationState *s);
> > >   static void migration_completion_end(MigrationState *s);
> > > +static void migrate_hup_delete(MigrationState *s);
> > >   static void migration_downtime_start(MigrationState *s)
> > >   {
> > > @@ -204,6 +206,12 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
> > >           return false;
> > >       }
> > > +    if (migrate_mode() == MIG_MODE_CPR_TRANSFER &&
> > > +        addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> > > +        error_setg(errp, "Migration requires streamable transport (eg unix)");
> > > +        return false;
> > > +    }
> > > +
> > >       return true;
> > >   }
> > > @@ -316,6 +324,7 @@ void migration_cancel(const Error *error)
> > >           qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
> > >       }
> > >       migrate_fd_cancel(current_migration);
> > > +    migrate_hup_delete(current_migration);
> > >   }
> > >   void migration_shutdown(void)
> > > @@ -718,6 +727,9 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
> > >       } else {
> > >           error_setg(errp, "unknown migration protocol: %s", uri);
> > >       }
> > > +
> > > +    /* Close cpr socket to tell source that we are listening */
> > > +    cpr_state_close();
> > 
> > Would it be possible to use some explicit reply message to mark this?
> 
> In theory yes, but I fear that using a return channel with message parsing and
> dispatch adds more code than it is worth.
> 
> > So
> > far looks like src QEMU will continue with qmp_migrate_finish() even if the
> > cpr channel was closed due to error.
> 
> Yes, but we recover just fine.  The target hits some error, fails to read all the
> cpr state, closes the channel prematurely, and does *not* create a listen socket
> for the normal migration channel.  Hence qmp_migrate_finish fails to connect to the
> normal channel, and recovers.

This is slightly tricky part and would be nice to be documented somewhere,
perhaps starting from in the commit message.

Then the error will say "failed to connect to destination QEMU" hiding the
real failure (cpr save/load failed), right?  That's slightly a pity.

I'm OK with the HUP as of now, but if you care about accurate CPR-stage
error reporting, then feel free to draft something else in the next post.

> 
> > I still didn't see how that kind of issue was captured below [1] (e.g., cpr
> > channel broken after sending partial fds)?
> 
> Same as above.
> 
> > >   }
> > >   static void process_incoming_migration_bh(void *opaque)
> > > @@ -1414,6 +1426,8 @@ static void migrate_fd_cleanup(MigrationState *s)
> > >       s->vmdesc = NULL;
> > >       qemu_savevm_state_cleanup();
> > > +    cpr_state_close();
> > > +    migrate_hup_delete(s);
> > >       close_return_path_on_source(s);
> > > @@ -1698,7 +1712,9 @@ bool migration_thread_is_self(void)
> > >   bool migrate_mode_is_cpr(MigrationState *s)
> > >   {
> > > -    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
> > > +    MigMode mode = s->parameters.mode;
> > > +    return mode == MIG_MODE_CPR_REBOOT ||
> > > +           mode == MIG_MODE_CPR_TRANSFER;
> > >   }
> > >   int migrate_init(MigrationState *s, Error **errp)
> > > @@ -2033,6 +2049,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
> > >           return false;
> > >       }
> > > +    if (migrate_mode() == MIG_MODE_CPR_TRANSFER &&
> > > +        !s->parameters.cpr_uri) {
> > > +        error_setg(errp, "cpr-transfer mode requires setting cpr-uri");
> > > +        return false;
> > > +    }
> > > +
> > >       if (migration_is_blocked(errp)) {
> > >           return false;
> > >       }
> > > @@ -2076,6 +2098,37 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
> > >   static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
> > >                                  Error **errp);
> > > +static void migrate_hup_add(MigrationState *s, QIOChannel *ioc, GSourceFunc cb,
> > > +                            void *opaque)
> > > +{
> > > +        s->hup_source = qio_channel_create_watch(ioc, G_IO_HUP);
> > > +        g_source_set_callback(s->hup_source, cb, opaque, NULL);
> > > +        g_source_attach(s->hup_source, NULL);
> > > +}
> > > +
> > > +static void migrate_hup_delete(MigrationState *s)
> > > +{
> > > +    if (s->hup_source) {
> > > +        g_source_destroy(s->hup_source);
> > > +        g_source_unref(s->hup_source);
> > > +        s->hup_source = NULL;
> > > +    }
> > > +}
> > > +
> > > +static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
> > > +                                      GIOCondition cond,
> > > +                                      void *opaque)
> > > +{
> > > +    MigrationAddress *addr = opaque;
> > 
> > [1]
> > 
> > > +
> > > +    qmp_migrate_finish(addr, false, NULL);
> > > +
> > > +    cpr_state_close();
> > > +    migrate_hup_delete(migrate_get_current());
> > > +    qapi_free_MigrationAddress(addr);
> > > +    return G_SOURCE_REMOVE;
> > > +}
> > > +
> > >   void qmp_migrate(const char *uri, bool has_channels,
> > >                    MigrationChannelList *channels, bool has_detach, bool detach,
> > >                    bool has_resume, bool resume, Error **errp)
> > > @@ -2136,7 +2189,19 @@ void qmp_migrate(const char *uri, bool has_channels,
> > >           goto out;
> > >       }
> > > -    qmp_migrate_finish(addr, resume_requested, errp);
> > > +    /*
> > > +     * For cpr-transfer, the target may not be listening yet on the migration
> > > +     * channel, because first it must finish cpr_load_state.  The target tells
> > > +     * us it is listening by closing the cpr-state socket.  Wait for that HUP
> > > +     * event before connecting in qmp_migrate_finish.
> > > +     */
> > > +    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER) {
> > > +        migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
> > > +                        QAPI_CLONE(MigrationAddress, addr));
> > > +
> > > +    } else {
> > > +        qmp_migrate_finish(addr, resume_requested, errp);
> > > +    }
> > >   out:
> > >       if (local_err) {
> > > diff --git a/migration/migration.h b/migration/migration.h
> > > index 38aa140..74c167b 100644
> > > --- a/migration/migration.h
> > > +++ b/migration/migration.h
> > > @@ -457,6 +457,8 @@ struct MigrationState {
> > >       bool switchover_acked;
> > >       /* Is this a rdma migration */
> > >       bool rdma_migration;
> > > +
> > > +    GSource *hup_source;
> > >   };
> > >   void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index 81eda27..e2cef50 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -216,7 +216,9 @@ static bool postcopy_preempt_active(void)
> > >   bool migrate_ram_is_ignored(RAMBlock *block)
> > >   {
> > > +    MigMode mode = migrate_mode();
> > >       return !qemu_ram_is_migratable(block) ||
> > > +           mode == MIG_MODE_CPR_TRANSFER ||
> > >              (migrate_ignore_shared() && qemu_ram_is_shared(block)
> > >                                       && qemu_ram_is_named_file(block));
> > >   }
> > > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> > > index 6e45a4a..b5a55b8 100644
> > > --- a/migration/vmstate-types.c
> > > +++ b/migration/vmstate-types.c
> > > @@ -15,6 +15,7 @@
> > >   #include "qemu-file.h"
> > >   #include "migration.h"
> > >   #include "migration/vmstate.h"
> > > +#include "migration/client-options.h"
> > >   #include "qemu/error-report.h"
> > >   #include "qemu/queue.h"
> > >   #include "trace.h"
> > > @@ -321,7 +322,7 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
> > >   {
> > >       int32_t *v = pv;
> > >       qemu_get_sbe32s(f, v);
> > > -    if (*v < 0) {
> > > +    if (*v < 0 || migrate_mode() != MIG_MODE_CPR_TRANSFER) {
> > >           return 0;
> > >       }
> > >       *v = qemu_file_get_fd(f);
> > > @@ -334,7 +335,7 @@ static int put_fd(QEMUFile *f, void *pv, size_t size,
> > >       int32_t *v = pv;
> > >       qemu_put_sbe32s(f, v);
> > > -    if (*v < 0) {
> > > +    if (*v < 0 || migrate_mode() != MIG_MODE_CPR_TRANSFER) {
> > 
> > So I suppose you wanted to guard VMSTATE_FD being abused.  Then I wonder
> > whether it'll help more by adding a comment above VMSTATE_FD instead; it'll
> > be more straightforward to me.
> > 
> > And if you want to fail hard, assert should work better too in runtime, or
> > the "return 0" can be pretty hard to notice.
> 
> No, this code is not about detecting abuse or errors.  It is there to skip
> the qemu_file_put_fd for cpr-exec mode.  In my next version this function will
> simply be:
> 
> static int put_fd(QEMUFile *f, void *pv, size_t size,
>                   const VMStateField *field, JSONWriter *vmdesc)
> {
>     int32_t *v = pv;
>     return qemu_file_put_fd(f, *v);
> }

Great, thanks.

> 
> > >           return 0;
> > >       }
> > >       return qemu_file_put_fd(f, *v);
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index c0d8bcc..f51b4cb 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -611,9 +611,34 @@
> > >   #     or COLO.
> > >   #
> > >   #     (since 8.2)
> > > +#
> > > +# @cpr-transfer: This mode allows the user to transfer a guest to a
> > > +#     new QEMU instance on the same host with minimal guest pause
> > > +#     time, by preserving guest RAM in place, albeit with new virtual
> > > +#     addresses in new QEMU.
> > > +#
> > > +#     The user starts new QEMU on the same host as old QEMU, with the
> > > +#     the same arguments as old QEMU, plus the -incoming option.  The
> > > +#     user issues the migrate command to old QEMU, which stops the VM,
> > > +#     saves state to the migration channels, and enters the
> > > +#     postmigrate state.  Execution resumes in new QEMU.  Guest RAM is
> > > +#     preserved in place, albeit with new virtual addresses in new
> > > +#     QEMU.  The incoming migration channel cannot be a file type.
> > > +#
> > > +#     This mode requires a second migration channel, specified by the
> > > +#     cpr-uri migration property on the outgoing side, and by
> > > +#     the cpr-uri QEMU command-line option on the incoming
> > > +#     side.  The channel must be a type, such as unix socket, that
> > > +#     supports SCM_RIGHTS.
> > > +#
> > > +#     Memory-backend objects must have the share=on attribute, but
> > > +#     memory-backend-epc is not supported.  The VM must be started
> > > +#     with the '-machine anon-alloc=memfd' option.
> > > +#
> > > +#     (since 9.2)
> > >   ##
> > >   { 'enum': 'MigMode',
> > > -  'data': [ 'normal', 'cpr-reboot' ] }
> > > +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
> > 
> > No need to rush, but please add the CPR.rst and unit test updates when you
> > feel confident on the protocol.  It looks pretty good to me now.
> > 
> > Especially it'll be nice to describe the separate cpr-channel protocol in
> > the new doc page.
> 
> Will do, now that there is light at the end of the tunnel.

I just noticed that we have 1 month left before soft freeze. I'll try to
prioritize review of this series (and the other VFIO one) in the upcoming
month.  Let's see whether it can hit 9.2.

-- 
Peter Xu


