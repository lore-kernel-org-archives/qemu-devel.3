Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8710CFB45F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 20:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxu3h-0006zC-UJ; Mon, 07 Oct 2024 16:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxu3c-0006yf-9f
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxu3a-0001lc-52
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728331811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hte5B+XF+osINWtRHQ9ZVuumOAHmF8ij4Wqbgm1eNjw=;
 b=PwFlRQlLa7W9nneKg9O70BG1ZPaLzsFWt+hThWKuaEfXhMm3c4r+JaWynbfUapajogSNNf
 estffLBggd1Q5YopSDvzaNzEPe2koo6m/nWKtf4dAy89WiSjDDB1iatIX1AdDmncMeMvsb
 CEVwz2yfunOvJfZcTy67pLNbIo1pgl0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-tR88UK-SNQaiEbTJKyfnuA-1; Mon, 07 Oct 2024 16:10:09 -0400
X-MC-Unique: tR88UK-SNQaiEbTJKyfnuA-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a3453139c0so66133825ab.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 13:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728331809; x=1728936609;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hte5B+XF+osINWtRHQ9ZVuumOAHmF8ij4Wqbgm1eNjw=;
 b=TmU3I6q20JCJSv2duMHwiO1uaLleXad8P/wZJVdvU01v0QL/UYgMpOWG2blGcPOXUl
 Rv3MXHXgr8UkAEJeLbcYfSAoKrVWKYquDT1+PpItst2n1kJg7iawjzXI83iaYww+ygNU
 PVbn9oPQEMWQU8sPl7oIWcjTDlPn364DKN7yRGAtHiikSshUf15+bOhQGJfw8L1Aawhk
 xaF6VKtdwhX1HpoDTI1v2fGzMIcNdQYy6vQenB1j3ETxYEL0e3E4sv9LSI2CdynoFf6z
 PG/UgWcN0CGQJuHrmrOYwy3K/jf2zzsBwfv3VZu+UDdzLsSGdSVPh7ZKOrTYtiUE7VU3
 YZSg==
X-Gm-Message-State: AOJu0YySvtqUVNgxYN5rIJU+SG2oVibvKw1NtkETCQm3Wf+2Vavc3swy
 uImWyOoD2vm243GU6tlch6fuB1S6E+DzfK7/ZLvGiWRECQtw0TfhXmt+PQf+OxFL4HaVGy5xa3c
 CIQhzmiCHUdnYEDvqzIvJeuFZqAaJWKDY7gKTsEoDMk6vHU0sSNJz
X-Received: by 2002:a92:cda2:0:b0:3a0:a3cd:f239 with SMTP id
 e9e14a558f8ab-3a375994d4cmr111732965ab.8.1728331809232; 
 Mon, 07 Oct 2024 13:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB9KemA3s7xVwcVpF3a96UhJreeLX7jbEYHHzfHYAJX1nBv7VKP5a7ZfKZbStBAhxOZm8hFg==
X-Received: by 2002:a92:cda2:0:b0:3a0:a3cd:f239 with SMTP id
 e9e14a558f8ab-3a375994d4cmr111732675ab.8.1728331808869; 
 Mon, 07 Oct 2024 13:10:08 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4db81d551b9sm799502173.34.2024.10.07.13.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 13:10:08 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:10:05 -0400
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
Subject: Re: [PATCH V2 03/13] migration: save cpr mode
Message-ID: <ZwRAHeS9bTipmUIv@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-4-git-send-email-steven.sistare@oracle.com>
 <ZwP7v5pZNsMuXPgW@x1n>
 <68f5b27f-a06c-44f6-ab4d-3d0a32195b70@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68f5b27f-a06c-44f6-ab4d-3d0a32195b70@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Oct 07, 2024 at 03:31:09PM -0400, Steven Sistare wrote:
> On 10/7/2024 11:18 AM, Peter Xu wrote:
> > On Mon, Sep 30, 2024 at 12:40:34PM -0700, Steve Sistare wrote:
> > > Save the mode in CPR state, so the user does not need to explicitly specify
> > > it for the target.  Modify migrate_mode() so it returns the incoming mode on
> > > the target.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > ---
> > >   include/migration/cpr.h |  7 +++++++
> > >   migration/cpr.c         | 23 ++++++++++++++++++++++-
> > >   migration/migration.c   |  1 +
> > >   migration/options.c     |  9 +++++++--
> > >   4 files changed, 37 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> > > index e7b898b..ac7a63e 100644
> > > --- a/include/migration/cpr.h
> > > +++ b/include/migration/cpr.h
> > > @@ -8,9 +8,16 @@
> > >   #ifndef MIGRATION_CPR_H
> > >   #define MIGRATION_CPR_H
> > > +#include "qapi/qapi-types-migration.h"
> > > +
> > > +#define MIG_MODE_NONE           -1
> > > +
> > >   #define QEMU_CPR_FILE_MAGIC     0x51435052
> > >   #define QEMU_CPR_FILE_VERSION   0x00000001
> > > +MigMode cpr_get_incoming_mode(void);
> > > +void cpr_set_incoming_mode(MigMode mode);
> > > +
> > >   typedef int (*cpr_walk_fd_cb)(int fd);
> > >   void cpr_save_fd(const char *name, int id, int fd);
> > >   void cpr_delete_fd(const char *name, int id);
> > > diff --git a/migration/cpr.c b/migration/cpr.c
> > > index e50fc75..7514c4e 100644
> > > --- a/migration/cpr.c
> > > +++ b/migration/cpr.c
> > > @@ -21,10 +21,23 @@
> > >   typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
> > >   typedef struct CprState {
> > > +    MigMode mode;
> > >       CprFdList fds;
> > >   } CprState;
> > > -static CprState cpr_state;
> > > +static CprState cpr_state = {
> > > +    .mode = MIG_MODE_NONE,
> > > +};
> > > +
> > > +MigMode cpr_get_incoming_mode(void)
> > > +{
> > > +    return cpr_state.mode;
> > > +}
> > > +
> > > +void cpr_set_incoming_mode(MigMode mode)
> > > +{
> > > +    cpr_state.mode = mode;
> > > +}
> > >   /****************************************************************************/
> > > @@ -124,11 +137,19 @@ void cpr_resave_fd(const char *name, int id, int fd)
> > >   /*************************************************************************/
> > >   #define CPR_STATE "CprState"
> > > +static int cpr_state_presave(void *opaque)
> > > +{
> > > +    cpr_state.mode = migrate_mode();
> > > +    return 0;
> > > +}
> > > +
> > >   static const VMStateDescription vmstate_cpr_state = {
> > >       .name = CPR_STATE,
> > >       .version_id = 1,
> > >       .minimum_version_id = 1,
> > > +    .pre_save = cpr_state_presave,
> > >       .fields = (VMStateField[]) {
> > > +        VMSTATE_UINT32(mode, CprState),
> > >           VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
> > >           VMSTATE_END_OF_LIST()
> > >       }
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 834b0a2..df00e5c 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -416,6 +416,7 @@ void migration_incoming_state_destroy(void)
> > >           mis->postcopy_qemufile_dst = NULL;
> > >       }
> > > +    cpr_set_incoming_mode(MIG_MODE_NONE);
> > >       yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> > >   }
> > > diff --git a/migration/options.c b/migration/options.c
> > > index 147cd2b..cc85a84 100644
> > > --- a/migration/options.c
> > > +++ b/migration/options.c
> > > @@ -22,6 +22,7 @@
> > >   #include "qapi/qmp/qnull.h"
> > >   #include "sysemu/runstate.h"
> > >   #include "migration/colo.h"
> > > +#include "migration/cpr.h"
> > >   #include "migration/misc.h"
> > >   #include "migration.h"
> > >   #include "migration-stats.h"
> > > @@ -768,8 +769,12 @@ uint64_t migrate_max_postcopy_bandwidth(void)
> > >   MigMode migrate_mode(void)
> > >   {
> > > -    MigrationState *s = migrate_get_current();
> > > -    MigMode mode = s->parameters.mode;
> > > +    MigMode mode = cpr_get_incoming_mode();
> > > +
> > > +    if (mode == MIG_MODE_NONE) {
> > > +        MigrationState *s = migrate_get_current();
> > > +        mode = s->parameters.mode;
> > > +    }
> > 
> > Is this trying to avoid interfering with what user specified?
> 
> No.
> 
> > I can kind of get the point of it, but it'll also look pretty werid in this
> > case that user can set the mode but then when query before cpr-transfer
> > incoming completes it won't read what was set previously, but what was
> > migrated via the cpr channel.
> > 
> > And IIUC it is needed to migrate this mode in cpr stream so as to avoid
> > another new qemu cmdline on dest qemu.  If true this needs to be mentioned
> > in the commit message; so far it reads like it's optional, then it's not
> > clear why only cpr-mode needs to be migrated not other migration parameters.
> 
> The mode is needed on the incoming side early -- before migration_object_init,
> and before the monitor is started.  Thus the user cannot set it as a normal
> migration parameter.
> 
> > If that won't get right easily, I wonder whether we could just overwrite
> > parameters.mode directly by the cpr stream.
> 
> I considered that, but parameters.mode cannot be set before migration_object_init,
> and some code needs to know mode before that.

Ah OK...

I wonder whether it really helps in migrating this mode at all, knowing
that no other mode should be there but the cpr-transfer mode when with
-cpr-uri cmdline.

How about we use cpr_uri to detect early stage cpr transfer mode, then
after early load stage we unset cpr_uri and always stick with what user
specified (instead of special casing NONE mode)?  Then it looks like:

MigMode migrate_mode(void)
{
  /*
   * When cpr_uri set, it always means QEMU is currently in early
   * cpr-transfer loading stage.
   */ 
  if (cpr_uri) {
      return MIG_MODE_CPR_TRANSFER;
  }

  return migrate_get_current()->parameters.mode;
}

Then we don't need to migrate the mode either, which is good as it aligns
with other migration parameters.

Would this look slightly cleaner?

-- 
Peter Xu


