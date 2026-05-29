Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52BFCD6E50
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyY6-0003rx-Fg; Fri, 29 May 2026 10:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSyXy-0003rj-9U
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSyXv-0002fZ-GZ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780066245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGla/wgbdafyrn06eAwrU1+catW4xLXg0ingzJsBON8=;
 b=HJ34EWclzAckCVhrMqrePHAaA0oUc9MNDZTz7Z6KesooJx72rotElkfWY+jPxANB5e0rOX
 8KrnaCC/Q5u3/Ea/F69IXi5UPGZpXPB6wQsa6Z//pvEOqKalSLUqdYyJbw2Wa2AhqrTeFD
 fkd6b07jFZRldmEnJvdBmVdjlkZ6uv0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-J3Z9MV1QOk65Fs5NUyJ6Tw-1; Fri, 29 May 2026 10:50:44 -0400
X-MC-Unique: J3Z9MV1QOk65Fs5NUyJ6Tw-1
X-Mimecast-MFC-AGG-ID: J3Z9MV1QOk65Fs5NUyJ6Tw_1780066243
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-516cde13e8cso172157451cf.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780066243; x=1780671043; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rGla/wgbdafyrn06eAwrU1+catW4xLXg0ingzJsBON8=;
 b=rzXllZKFFZ4+MQciiE4KCV1ewnWlMhkin78SBEiBxsH+aURN1I/d4hSqmDErqM8L3F
 UeWI+v88ZWkqUs/7BPacXADy37E4vTkpNX8pEXIp9FbIs9NhYONgCeNOqIwJWylaoSFB
 MnzksMzI5obE9u1SViTRccNf1KzNM8xgacrKc1eBY8ttFcOxaj3d8/LQ8CdFrBs1zqwP
 7WhTjVINgCLEiI07jZ11DTCTiHkkaJNpSid0ZB7IokX46mpqzor1vqLlo4ZB6neXuTQm
 WOka3T4yRP0nx+KXGwpNxELnJPO+1nYgyRtnD/4JxtvJx2ZFG34AH0XkDB2mWVnujYWI
 eU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780066243; x=1780671043;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rGla/wgbdafyrn06eAwrU1+catW4xLXg0ingzJsBON8=;
 b=NKtJT/s50HSGl9c+E7xF5mm+V8V+n5ewjyJfvLrx5nwlXJg0yvHyI45SFniT4Ny1ik
 IZv85pIEamJ+GXyseBr+gtvYxesEC8PyCTfWrvYNmFzNo2mHmFJAdDECmaEwgCfc5gqH
 Im4EWjcV3vT2pLR/y/pq5NbhoJYdqLlJI4+h1cep+l03fv5f9V8jpaablTXyKr35r/R9
 MSkQLLwx3rNIx9LexWHSJs+A0BSlUA/BDSlboONVerM6Vg7K4bsfGlF3HnrArsG7JNt7
 TGWzl9NRfN8ncxBl/121+bhsJdSSgL1p/kPOB2x/o2n26ALj/r46Sdsm5IeqS+YN8KUH
 0Y9A==
X-Gm-Message-State: AOJu0YwIQNAqFaxYxzm3wc4Gds9CWSPwWLxM4xX56gffPMWxTtrBLPWW
 kct2wM38SYKUpR84fIEdDIE0NlEAoMS2iheD70JutAOkrElWp29KQ2vpfx1C279YV0WHaRpVpSM
 NOocRVqsgHz8yUFUd4ZA1ineQLl3UwsevRliHohGbeE3bA962GTFKYbIy
X-Gm-Gg: Acq92OGsraYfNNG3UVoGx6Y51QfK09hRK2YEIc2QLDJq4iZizvVVe2F28idMnfSEXQD
 CAKvOQN2Cggio642amwTkPccfmFHSFk+KRqVztA3NBZr1JkS0eRK2/hptC1p9TpQzEuq/rHezIv
 M4Msrb+j8Z6aC7HmCD5T+nCGiePCjSO20/MNvEjdSn7qpu4/fVbRjFYxa3H0r1JfjJJrNWTGVmO
 gHx09jojLGHudSSx//ZOeuZCs7tGyuGJaMqyyRKylv7cbd6TL2RJZDbUppR58IkXvVR3zqrJvPK
 J+VX1qub+keLrs8BViiFTixe6aCwf+70gHF6ihYce4SLZUpU1RhA1Hakf7lc0TfEa/o/hGjWngO
 u/pQFIJxHxMwSzTP2vWgHiyZ7qjEyhz5bVKOCwYWJLavwslERM0F3PmYHYA==
X-Received: by 2002:a05:622a:1e18:b0:509:3257:c050 with SMTP id
 d75a77b69052e-5172dc8f15amr39832221cf.24.1780066243401; 
 Fri, 29 May 2026 07:50:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1e18:b0:509:3257:c050 with SMTP id
 d75a77b69052e-5172dc8f15amr39831691cf.24.1780066242751; 
 Fri, 29 May 2026 07:50:42 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5172e9a5034sm22814921cf.6.2026.05.29.07.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 07:50:42 -0700 (PDT)
Date: Fri, 29 May 2026 10:50:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 2/2] migration/cpr: Opt-in "mode" parameter for early
 boot access
Message-ID: <ahmnwR3CdYJ5MO5n@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <20260528212947.368132-3-peterx@redhat.com>
 <87mrxjt8wo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mrxjt8wo.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 28, 2026 at 08:24:23PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Make "mode" to be the first parameter to opt-in for early boot access.  CPR
> > will start to consume this early boot parameter.  With this, we can remove
> > the special "incoming_mode" variable together with cpr_get_incoming_mode().
> >
> 
> Hmm, it's now possible to invoke QEMU with:
> 
> -incoming config:mode=cpr-exec,cpr-exec-command=-incoming config:
> 
> Seems like it could be an issue.

Do you mean when being abused, or some issue that can happen with existing
cpr-exec?

For normal cpr-exec operation, we should only pass in -incoming file:*.  No
config should be passed in.

But indeed if we want to decouple the implied "mode=" change for cpr-exec
and cpr-transfer, we may want to also have "-incoming config:mode=cpr-exec"
in the cpr-exec-command=.  But still, I don't see an issue so far.

If we think that's too much, we can still stick with the
cpr_set_incoming_mode() implicitly setting mode for cpr-*.

> 
> > One thing to mention is, to make cpr_is_incoming() work like before, we
> > need to do extra check on INMIGRATE runstate to make sure it only returns
> > true while during the incoming migration.
> 
> ...
> 
> > It used to be achieved by a
> > pretty hackish "cpr_set_incoming_mode(MIG_MODE_NONE)" when incoming
> > migration destroys.  Now we can remove it.
> 
> That's not it, I think. cpr_is_incoming() only returns true on incoming
> migration because on outgoing there's no parsing of -incoming and
> therefore cpr_state_load() doesn't call cpr_set_incoming_mode().

Yes, I believe it's done by both these steps: cpr_set_incoming_mode() start
to make it return true, then the other set of MIG_MODE_NONE (that I
mentioned above) to explicitly turn it off.  Now with INMIGRATE check it
should hopefully keep the exact same behavior.

> 
> >
> > Another good side effect is, we can finally drop MIG_MODE_NONE: it was
> > never a valid value, only used by the temp global variable.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/migration/cpr.h |  3 ---
> >  migration/migration.h   |  3 +++
> >  migration/cpr.c         | 18 +++++++++---------
> >  migration/migration.c   | 37 ++++++++++++++++++++++++++++++++++++-
> >  migration/options.c     | 10 +++-------
> >  5 files changed, 51 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> > index 56fb67e6b4..27061ad629 100644
> > --- a/include/migration/cpr.h
> > +++ b/include/migration/cpr.h
> > @@ -12,8 +12,6 @@
> >  #include "io/channel.h"
> >  #include "qemu/queue.h"
> >  
> > -#define MIG_MODE_NONE           -1
> > -
> >  #define QEMU_CPR_FILE_MAGIC     0x51435052
> >  #define QEMU_CPR_FILE_VERSION   0x00000001
> >  #define CPR_STATE "CprState"
> > @@ -38,7 +36,6 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
> >  typedef bool (*cpr_walk_fd_cb)(int fd);
> >  bool cpr_walk_fd(cpr_walk_fd_cb cb);
> >  
> > -MigMode cpr_get_incoming_mode(void);
> >  void cpr_set_incoming_mode(MigMode mode);
> >  bool cpr_is_incoming(void);
> >  
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 841f49b215..9fa97f6d9a 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -609,4 +609,7 @@ void migration_bitmap_sync_precopy(bool last_stage);
> >  void dirty_bitmap_mig_init(void);
> >  bool should_send_vmdesc(void);
> >  
> > +void migration_parameters_boot_set_mode(MigMode mode);
> > +MigrationParameters *migration_get_parameters(void);
> > +
> >  #endif
> > diff --git a/migration/cpr.c b/migration/cpr.c
> > index bca43e9bf3..1f49afe109 100644
> > --- a/migration/cpr.c
> > +++ b/migration/cpr.c
> > @@ -16,6 +16,7 @@
> >  #include "migration/qemu-file.h"
> >  #include "migration/savevm.h"
> >  #include "migration/vmstate.h"
> > +#include "migration/migration.h"
> >  #include "monitor/monitor.h"
> >  #include "system/runstate.h"
> >  #include "trace.h"
> > @@ -239,21 +240,20 @@ QIOChannel *cpr_state_ioc(void)
> >      return qemu_file_get_ioc(cpr_state_file);
> >  }
> >  
> > -static MigMode incoming_mode = MIG_MODE_NONE;
> > -
> > -MigMode cpr_get_incoming_mode(void)
> > -{
> > -    return incoming_mode;
> > -}
> > -
> >  void cpr_set_incoming_mode(MigMode mode)
> >  {
> > -    incoming_mode = mode;
> > +    migration_parameters_boot_set_mode(mode);
> >  }
> >  
> >  bool cpr_is_incoming(void)
> >  {
> > -    return incoming_mode != MIG_MODE_NONE;
> > +    MigMode mode = migrate_mode();
> > +
> > +    if (!runstate_check(RUN_STATE_INMIGRATE)) {
> > +        return false;
> > +    }
> > +
> > +    return mode == MIG_MODE_CPR_EXEC || mode == MIG_MODE_CPR_TRANSFER;
> >  }
> >  
> >  bool cpr_state_save(MigrationChannel *channel, Error **errp)
> > diff --git a/migration/migration.c b/migration/migration.c
> > index d918be7a44..d7591571ed 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -145,6 +145,42 @@ static void migration_parameters_boot_apply(void)
> >      }
> >  }
> >  
> > +static void migration_parameters_boot_init(void)
> > +{
> > +    if (!mig_boot_params) {
> > +        mig_boot_params = g_new0(MigrationParameters, 1);
> > +    }
> > +}
> > +
> > +/*
> > + * This should only be used during boot by CPR.  NOTE: This is only needed
> > + * to be compatible with old CPR use case, if we decide to have users
> > + * switch to -incoming config:mode=cpr-* then this can be removed.
> 
> This new scheme does create some usability weirdness of allowing a
> parameter to be set in -incoming and then to be changed later with
> migrate-set-parameters. Hopefully it's ok.

I assume it's OK?  It's the same as -global migration.* in this case,
updates to global parameters.

> 
> > + */
> > +void migration_parameters_boot_set_mode(MigMode mode)
> > +{
> > +    assert(!current_migration);
> > +    migration_parameters_boot_init();
> > +    mig_boot_params->has_mode = true;
> > +    mig_boot_params->mode = mode;
> 
> I bet there's some visitor trick that could make this function generic
> for all parameters.

Yeah, that's why I relied on the qmp_migrate_set_parameters() API to apply
these configs in patch 1, waiting for you to introduce that trick in your
other series to not hard-code has_* checks. :)

But IMHO it's not needed here: we shouldn't even need this helper if we
don't implicitly set mode..  The plan is we should never need another
parameter for such helper.. hence I made it directly accessing it.

> 
> > +}
> > +
> > +/*
> > + * Get the effective migration parameter object.
> > + *
> > + * Three possibilities:
> > + * - Migration object has been initialized, always use it, or,
> > + * - Migration boot parameters are initialized, then use it, or,
> > + * - return NULL
> 
> Hmm, can't we create the early parameters unconditionally so there's no
> NULL case here? A bit annoying having to check for NULL for (eventually)
> every parameter, even on the source side.

We could do that, but remember the default values for parameters are only
applied so far until migration objects init (migration_properties, when
qdev walks it over; unfortunately still a TYPE_DEVICE).

If you want me to finish that part first I can try too; If we plan to merge
the other incoming-fds to TAP then there's also no rush for this work, we
can add some pre-requisite changes.

Or, this series can also be the minimum to drop TAP's incoming-fds, then we
cleanup this NULL case later.

> 
> > + *
> > + * Callers should always check non-NULL pointer first before use.
> > + */
> > +MigrationParameters *migration_get_parameters(void)
> > +{
> > +    return current_migration ?
> > +        &current_migration->parameters : mig_boot_params;
> > +}
> 
> Feels like time to drop the global parameters already. It's a weird
> cognitive load having to grasp that there's two MigrationParameters,
> both used in outgoing and incoming, but one can only be set in
> incoming. The one stored in current_migration might be used
> interchangeably with the one that's flying around. One lives inside and
> shares lifetime with MigrationState, the other is dynamically allocated
> and has a shorter lifetime.

The idea is making mig_boot_params so temprary so nobody notices.

Note that we have at least these layers of values to apply on top of the
parameters:

a) default value (via migration_properties, discussed above)
b) machine type compat value (via instance_post_init() of mig obj)
c) "-incoming config:*" that this series introduced

IIUC, the sane way to prioritize these values is having 3) higher priority
than 1) and 2).  In this case, we will need a buffering mechanism anyway
when:

- take early migration parameters, we make sure parameters available almost
  since the start

- ... qemu initializes machine compat properties ...

- migration object init, apply machine compat properties

When applying machine compat properties, the migration parameter object
cannot be the same that persisted the boot values, so we likely always need
two of them so that after apply compat properties we use boot parameters to
overwrite them.

> 
> > +
> >  static void migration_downtime_start(MigrationState *s)
> >  {
> >      trace_vmstate_downtime_checkpoint("src-downtime-start");
> > @@ -546,7 +582,6 @@ void migration_incoming_state_destroy(void)
> >          mis->postcopy_qemufile_dst = NULL;
> >      }
> >  
> > -    cpr_set_incoming_mode(MIG_MODE_NONE);
> >      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> >  }
> >  
> > diff --git a/migration/options.c b/migration/options.c
> > index 5cbfd29099..c1209cbec3 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -886,16 +886,12 @@ uint64_t migrate_max_postcopy_bandwidth(void)
> >      return s->parameters.max_postcopy_bandwidth;
> >  }
> >  
> > +/* Opt-in "mode" parameter to be available even during boot */
> >  MigMode migrate_mode(void)
> >  {
> > -    MigMode mode = cpr_get_incoming_mode();
> > +    MigrationParameters *params = migration_get_parameters();
> >  
> > -    if (mode == MIG_MODE_NONE) {
> > -        mode = migrate_get_current()->parameters.mode;
> > -    }
> > -
> > -    assert(mode >= 0 && mode < MIG_MODE__MAX);
> > -    return mode;
> > +    return params ? params->mode : MIG_MODE_NORMAL;
> >  }
> >  
> >  int migrate_multifd_channels(void)
> 

-- 
Peter Xu


