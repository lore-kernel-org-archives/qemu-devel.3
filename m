Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA0CCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT0tr-0003eo-63; Fri, 29 May 2026 13:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wT0tp-0003eX-AX
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:21:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wT0tm-00027a-6g
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:21:33 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C34566D07;
 Fri, 29 May 2026 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780075288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dMlFEaEUSg6onvX4QtvcIa3VJFuG97QRzTVowWsB8KQ=;
 b=X85ahHRfLPfXvf95qZ4QGa5tt5AAPJafiCpjz4sY05VwAiswvqZv9QrajyepgUJ5qqd8KD
 nGtRErJBQivoYB3EpFkCsm2T3Z59FMvifwns+80FSRvWTwCzRZ4DBYzTgQ1yPBia3jHHij
 OjmnwIP/KHx6pZg/FZ5zKY1Ne54fBx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780075288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dMlFEaEUSg6onvX4QtvcIa3VJFuG97QRzTVowWsB8KQ=;
 b=o17anRSMZ/5PaBfhnb1Nb6KV48KflKp7Rifjh+K0sv6EL7NCYH//td+Jmeg+1tDu6imtbk
 Jh9NP8XBlDMNvfBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X85ahHRf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o17anRSM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780075288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dMlFEaEUSg6onvX4QtvcIa3VJFuG97QRzTVowWsB8KQ=;
 b=X85ahHRfLPfXvf95qZ4QGa5tt5AAPJafiCpjz4sY05VwAiswvqZv9QrajyepgUJ5qqd8KD
 nGtRErJBQivoYB3EpFkCsm2T3Z59FMvifwns+80FSRvWTwCzRZ4DBYzTgQ1yPBia3jHHij
 OjmnwIP/KHx6pZg/FZ5zKY1Ne54fBx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780075288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dMlFEaEUSg6onvX4QtvcIa3VJFuG97QRzTVowWsB8KQ=;
 b=o17anRSMZ/5PaBfhnb1Nb6KV48KflKp7Rifjh+K0sv6EL7NCYH//td+Jmeg+1tDu6imtbk
 Jh9NP8XBlDMNvfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1ECC779A7;
 Fri, 29 May 2026 17:21:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M9sHHhfLGWphKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 29 May 2026 17:21:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda
 <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Maciej S.
 Szmigiero" <maciej.szmigiero@oracle.com>, Jason Wang
 <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 2/2] migration/cpr: Opt-in "mode" parameter for
 early boot access
In-Reply-To: <ahmnwR3CdYJ5MO5n@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <20260528212947.368132-3-peterx@redhat.com> <87mrxjt8wo.fsf@suse.de>
 <ahmnwR3CdYJ5MO5n@x1.local>
Date: Fri, 29 May 2026 14:21:17 -0300
Message-ID: <87a4tit9ma.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3C34566D07
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, May 28, 2026 at 08:24:23PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Make "mode" to be the first parameter to opt-in for early boot access.  CPR
>> > will start to consume this early boot parameter.  With this, we can remove
>> > the special "incoming_mode" variable together with cpr_get_incoming_mode().
>> >
>> 
>> Hmm, it's now possible to invoke QEMU with:
>> 
>> -incoming config:mode=cpr-exec,cpr-exec-command=-incoming config:
>> 
>> Seems like it could be an issue.
>
> Do you mean when being abused, or some issue that can happen with existing
> cpr-exec?
>

Abused. Or just overall user confusion over the syntax.

You imply in this patch that we want the users to eventually set the
mode in the -incoming option instead of relying in the automatic
detection at cpr_state_load(). Ok.

Then it's natural that the user will also want to set cpr-exec-command
via the -incoming option. But the definition of cpr-exec-command says
that it must include the -incoming option for the new machine. So now
the -incoming option has to deal with a potentially huge string. It's
also undefined what happens if the second commad line also contains
cpr-exec-command in it.

> For normal cpr-exec operation, we should only pass in -incoming file:*.  No
> config should be passed in.
>

Hmm, but there's no "should" here, is there? This patch allows the mode
to be set.

> But indeed if we want to decouple the implied "mode=" change for cpr-exec
> and cpr-transfer, we may want to also have "-incoming config:mode=cpr-exec"
> in the cpr-exec-command=.  But still, I don't see an issue so far.
>

Ok, keep it in mind though.

> If we think that's too much, we can still stick with the
> cpr_set_incoming_mode() implicitly setting mode for cpr-*.
>

Meh.. It's fine either way I think.

>> 
>> > One thing to mention is, to make cpr_is_incoming() work like before, we
>> > need to do extra check on INMIGRATE runstate to make sure it only returns
>> > true while during the incoming migration.
>> 
>> ...
>> 
>> > It used to be achieved by a
>> > pretty hackish "cpr_set_incoming_mode(MIG_MODE_NONE)" when incoming
>> > migration destroys.  Now we can remove it.
>> 
>> That's not it, I think. cpr_is_incoming() only returns true on incoming
>> migration because on outgoing there's no parsing of -incoming and
>> therefore cpr_state_load() doesn't call cpr_set_incoming_mode().
>
> Yes, I believe it's done by both these steps: cpr_set_incoming_mode() start
> to make it return true, then the other set of MIG_MODE_NONE (that I
> mentioned above) to explicitly turn it off.  Now with INMIGRATE check it
> should hopefully keep the exact same behavior.
>

Well, the new QEMU could be used to live update again, then the mode
should indeed be reset. Might as well have been made part of
migrate_prepare. I don't see the need to clear it like that aside from a
general cleanup action. Whatever, it's not relevant to this discussion.

>> 
>> >
>> > Another good side effect is, we can finally drop MIG_MODE_NONE: it was
>> > never a valid value, only used by the temp global variable.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  include/migration/cpr.h |  3 ---
>> >  migration/migration.h   |  3 +++
>> >  migration/cpr.c         | 18 +++++++++---------
>> >  migration/migration.c   | 37 ++++++++++++++++++++++++++++++++++++-
>> >  migration/options.c     | 10 +++-------
>> >  5 files changed, 51 insertions(+), 20 deletions(-)
>> >
>> > diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> > index 56fb67e6b4..27061ad629 100644
>> > --- a/include/migration/cpr.h
>> > +++ b/include/migration/cpr.h
>> > @@ -12,8 +12,6 @@
>> >  #include "io/channel.h"
>> >  #include "qemu/queue.h"
>> >  
>> > -#define MIG_MODE_NONE           -1
>> > -
>> >  #define QEMU_CPR_FILE_MAGIC     0x51435052
>> >  #define QEMU_CPR_FILE_VERSION   0x00000001
>> >  #define CPR_STATE "CprState"
>> > @@ -38,7 +36,6 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
>> >  typedef bool (*cpr_walk_fd_cb)(int fd);
>> >  bool cpr_walk_fd(cpr_walk_fd_cb cb);
>> >  
>> > -MigMode cpr_get_incoming_mode(void);
>> >  void cpr_set_incoming_mode(MigMode mode);
>> >  bool cpr_is_incoming(void);
>> >  
>> > diff --git a/migration/migration.h b/migration/migration.h
>> > index 841f49b215..9fa97f6d9a 100644
>> > --- a/migration/migration.h
>> > +++ b/migration/migration.h
>> > @@ -609,4 +609,7 @@ void migration_bitmap_sync_precopy(bool last_stage);
>> >  void dirty_bitmap_mig_init(void);
>> >  bool should_send_vmdesc(void);
>> >  
>> > +void migration_parameters_boot_set_mode(MigMode mode);
>> > +MigrationParameters *migration_get_parameters(void);
>> > +
>> >  #endif
>> > diff --git a/migration/cpr.c b/migration/cpr.c
>> > index bca43e9bf3..1f49afe109 100644
>> > --- a/migration/cpr.c
>> > +++ b/migration/cpr.c
>> > @@ -16,6 +16,7 @@
>> >  #include "migration/qemu-file.h"
>> >  #include "migration/savevm.h"
>> >  #include "migration/vmstate.h"
>> > +#include "migration/migration.h"
>> >  #include "monitor/monitor.h"
>> >  #include "system/runstate.h"
>> >  #include "trace.h"
>> > @@ -239,21 +240,20 @@ QIOChannel *cpr_state_ioc(void)
>> >      return qemu_file_get_ioc(cpr_state_file);
>> >  }
>> >  
>> > -static MigMode incoming_mode = MIG_MODE_NONE;
>> > -
>> > -MigMode cpr_get_incoming_mode(void)
>> > -{
>> > -    return incoming_mode;
>> > -}
>> > -
>> >  void cpr_set_incoming_mode(MigMode mode)
>> >  {
>> > -    incoming_mode = mode;
>> > +    migration_parameters_boot_set_mode(mode);
>> >  }
>> >  
>> >  bool cpr_is_incoming(void)
>> >  {
>> > -    return incoming_mode != MIG_MODE_NONE;
>> > +    MigMode mode = migrate_mode();
>> > +
>> > +    if (!runstate_check(RUN_STATE_INMIGRATE)) {
>> > +        return false;
>> > +    }
>> > +
>> > +    return mode == MIG_MODE_CPR_EXEC || mode == MIG_MODE_CPR_TRANSFER;
>> >  }
>> >  
>> >  bool cpr_state_save(MigrationChannel *channel, Error **errp)
>> > diff --git a/migration/migration.c b/migration/migration.c
>> > index d918be7a44..d7591571ed 100644
>> > --- a/migration/migration.c
>> > +++ b/migration/migration.c
>> > @@ -145,6 +145,42 @@ static void migration_parameters_boot_apply(void)
>> >      }
>> >  }
>> >  
>> > +static void migration_parameters_boot_init(void)
>> > +{
>> > +    if (!mig_boot_params) {
>> > +        mig_boot_params = g_new0(MigrationParameters, 1);
>> > +    }
>> > +}
>> > +
>> > +/*
>> > + * This should only be used during boot by CPR.  NOTE: This is only needed
>> > + * to be compatible with old CPR use case, if we decide to have users
>> > + * switch to -incoming config:mode=cpr-* then this can be removed.
>> 
>> This new scheme does create some usability weirdness of allowing a
>> parameter to be set in -incoming and then to be changed later with
>> migrate-set-parameters. Hopefully it's ok.
>
> I assume it's OK?  It's the same as -global migration.* in this case,
> updates to global parameters.
>
>> 
>> > + */
>> > +void migration_parameters_boot_set_mode(MigMode mode)
>> > +{
>> > +    assert(!current_migration);
>> > +    migration_parameters_boot_init();
>> > +    mig_boot_params->has_mode = true;
>> > +    mig_boot_params->mode = mode;
>> 
>> I bet there's some visitor trick that could make this function generic
>> for all parameters.
>
> Yeah, that's why I relied on the qmp_migrate_set_parameters() API to apply
> these configs in patch 1, waiting for you to introduce that trick in your
> other series to not hard-code has_* checks. :)
>
> But IMHO it's not needed here: we shouldn't even need this helper if we
> don't implicitly set mode..  The plan is we should never need another
> parameter for such helper.. hence I made it directly accessing it.
>

ok

>> 
>> > +}
>> > +
>> > +/*
>> > + * Get the effective migration parameter object.
>> > + *
>> > + * Three possibilities:
>> > + * - Migration object has been initialized, always use it, or,
>> > + * - Migration boot parameters are initialized, then use it, or,
>> > + * - return NULL
>> 
>> Hmm, can't we create the early parameters unconditionally so there's no
>> NULL case here? A bit annoying having to check for NULL for (eventually)
>> every parameter, even on the source side.
>
> We could do that, but remember the default values for parameters are only
> applied so far until migration objects init (migration_properties, when
> qdev walks it over; unfortunately still a TYPE_DEVICE).
>

Sorry, you kind of lost me. What do the defaults have to do with
allocating mig_boot_params? Do you mean mig_boot_params cannot really be
used interchangeably with s->parameters because it doesn't have any
defaults set?

> If you want me to finish that part first I can try too; If we plan to merge
> the other incoming-fds to TAP then there's also no rush for this work, we
> can add some pre-requisite changes.
>
> Or, this series can also be the minimum to drop TAP's incoming-fds, then we
> cleanup this NULL case later.
>

Sure, let's help with Vladimir's work. But "migration_get_parameters"
returning something other than a valid MigrationParameters is prone to
cause issues down the line. It's not obvious that the early parameters
are only valid on the incoming side and also not obvious that the
function might be called too early even for early parameters.

>> 
>> > + *
>> > + * Callers should always check non-NULL pointer first before use.
>> > + */
>> > +MigrationParameters *migration_get_parameters(void)
>> > +{
>> > +    return current_migration ?
>> > +        &current_migration->parameters : mig_boot_params;
>> > +}
>> 
>> Feels like time to drop the global parameters already. It's a weird
>> cognitive load having to grasp that there's two MigrationParameters,
>> both used in outgoing and incoming, but one can only be set in
>> incoming. The one stored in current_migration might be used
>> interchangeably with the one that's flying around. One lives inside and
>> shares lifetime with MigrationState, the other is dynamically allocated
>> and has a shorter lifetime.
>
> The idea is making mig_boot_params so temprary so nobody notices.
>
> Note that we have at least these layers of values to apply on top of the
> parameters:
>
> a) default value (via migration_properties, discussed above)
> b) machine type compat value (via instance_post_init() of mig obj)
> c) "-incoming config:*" that this series introduced
>
> IIUC, the sane way to prioritize these values is having 3) higher priority
> than 1) and 2).  In this case, we will need a buffering mechanism anyway
> when:
>
> - take early migration parameters, we make sure parameters available almost
>   since the start
>
> - ... qemu initializes machine compat properties ...
>
> - migration object init, apply machine compat properties
>
> When applying machine compat properties, the migration parameter object
> cannot be the same that persisted the boot values, so we likely always need
> two of them so that after apply compat properties we use boot parameters to
> overwrite them.
>

Or we move MigrationParameters out of MigrationState and use it however
we want. At migration_instance_init() add a:

params->zero_page_detection = ms->zero_page_detection;

and that's it.

Of course, it disables the -global usage for setting random
parameters. But the compat properties remain in migration_properties
working like today.

I understand it's a whole can of worms by itself, but don't you think
it's worth it? It would allow to use a single MigrationParameters object
all over.

>> 
>> > +
>> >  static void migration_downtime_start(MigrationState *s)
>> >  {
>> >      trace_vmstate_downtime_checkpoint("src-downtime-start");
>> > @@ -546,7 +582,6 @@ void migration_incoming_state_destroy(void)
>> >          mis->postcopy_qemufile_dst = NULL;
>> >      }
>> >  
>> > -    cpr_set_incoming_mode(MIG_MODE_NONE);
>> >      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>> >  }
>> >  
>> > diff --git a/migration/options.c b/migration/options.c
>> > index 5cbfd29099..c1209cbec3 100644
>> > --- a/migration/options.c
>> > +++ b/migration/options.c
>> > @@ -886,16 +886,12 @@ uint64_t migrate_max_postcopy_bandwidth(void)
>> >      return s->parameters.max_postcopy_bandwidth;
>> >  }
>> >  
>> > +/* Opt-in "mode" parameter to be available even during boot */
>> >  MigMode migrate_mode(void)
>> >  {
>> > -    MigMode mode = cpr_get_incoming_mode();
>> > +    MigrationParameters *params = migration_get_parameters();
>> >  
>> > -    if (mode == MIG_MODE_NONE) {
>> > -        mode = migrate_get_current()->parameters.mode;
>> > -    }
>> > -
>> > -    assert(mode >= 0 && mode < MIG_MODE__MAX);
>> > -    return mode;
>> > +    return params ? params->mode : MIG_MODE_NORMAL;
>> >  }
>> >  
>> >  int migrate_multifd_channels(void)
>> 

