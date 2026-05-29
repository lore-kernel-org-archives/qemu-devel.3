Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D40CD6E50
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 15:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSynM-0007D9-R0; Fri, 29 May 2026 11:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSynH-0007CB-2l
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSynE-0000G5-29
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780067191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kJzDJkKVEJNFq35g2VVVSJWQHMNf1CqTH/551gMXzaQ=;
 b=FGUGavDIi9QpmFnEbkeVsLIMJGR36kr69jXAT5wA+5bBxLqSdd+CKBygi0us5lJF6CH7E1
 FJIfzpZ/m5WOPbXvUHfMCq/PfRmTp7+E214zUDY8z2MnRwLPa+8HP63Iv2wZKIz1I+/0f8
 gDe9c2O3q2x2jqxBhOiIHGlb6iIzGUE=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-UeMU_AfkNoin06sDRiS31w-1; Fri, 29 May 2026 11:06:29 -0400
X-MC-Unique: UeMU_AfkNoin06sDRiS31w-1
X-Mimecast-MFC-AGG-ID: UeMU_AfkNoin06sDRiS31w_1780067189
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6583252c117so20942004d50.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780067189; x=1780671989; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kJzDJkKVEJNFq35g2VVVSJWQHMNf1CqTH/551gMXzaQ=;
 b=kO6jW4LEDlOeSsPZqB2hhHC3XHESQDeBVBafSlmHSx6BxmJvgERKCu6lxYToO472Pb
 RPRHbPSr4PBBd5uOBzu1s3A7ADH8VpESciXU0cSCYKoLOxg79qxJNEtn+nlcTzzfyY5Y
 19GJX9OPZQwYH2m02jHiFwa5QFqrQF3uXPMdddLuwSDaasyn/MbXm1OOvGtric1IDf0G
 K7YMzaBcF/UCy8djql3PBmtBhR6ClWHWzez254WvtFfGz8FI5Jxj9YxaC2h2lFahKbMO
 5NiKcBr2kXxUCkPW9JJ6uiK9v1DbJ/1Qb7IOYcdDZsHG/OgwHF4JuvKqm7eyy7ezI7pj
 fEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780067189; x=1780671989;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJzDJkKVEJNFq35g2VVVSJWQHMNf1CqTH/551gMXzaQ=;
 b=ESK7hnrDyr56kS5tTVoP62W8gQnxmSd3JqJOYmxJoRuSvhSKrCqQKGO0XDjhzMTYTm
 GjHrm5O5oBq7XUzdwaLgfZbbtDGuccRDTbIWTzkG4vB4c+4+ExM7y6XWkcJhpB2tv5x5
 7SDPVy5zkKxwZ+GpNuvP7Yp7p6qty02BaRBm2b0nzreB7Ri3ZbMtLjADagovn352G296
 aehn6DWdxrFNAlmakywTEGbPj5fFtz9OgFuJUYTa3RJ+/iPcyuW/ody3sKnoH5z+LuJf
 WnMBnCNPkUXTIJvTr1CfLZ/dcAIyQ2eddp85yFgg4Sa6/ZwahSx4ScEirQzd4xrO9TbA
 gBOQ==
X-Gm-Message-State: AOJu0Yy7KXAoDdVBDzGEdQOGsZUFd2SP5gWJPL/FZ2zMzzGX7Hnz7Ibm
 ilia2Rnn9yGTQ3WiM8aD638BIINInHu2e2PX9n9M3x92kFzpSImoi5g6efUFXt0o4MVzXp0rKxb
 10bFxCbscWw7UJCO/JphVpG3ZN+C1wdpTPHqAfPDQTAvUAIjMWlHmO2dd
X-Gm-Gg: Acq92OFkChG0tZRUNt5hyIh+HclcaNWXskJ/aUOwr79IryD17XAmnC1vNPGBeG/ZQYQ
 xd9A+FTxYgH0ZbTbU8IsrnW2ibPNZtamQCsoSdUDkbTpLx5dX1l9r629xwi4k5td1+gcQJBNxQh
 qxmFy6JLuuHu/zFLkjRV+ljhjclCrR3wibDRcQpzgesd25+nB3ByYE+0PID3VFbc1snlaaPitSg
 7h2m04E1sm/Lpih9lNN40Xa1d0jl7AAsFmrQW12Ue4wqJyzK/y++qQOnUpD4aQrPbGNSchIVRYu
 3y5lLLFnfA3Ou+TNuPGgwm7q6XCq479uyniyaMzQalDkbC34/dj8u1+RcVC1PhHh5+4DxSbNaf1
 TFTG+whBxEG7s3JLQIDkO2kcjLkcplLQ/JKcvswNQjrRSh8OSHIhh8Xql5A==
X-Received: by 2002:a05:690e:4191:b0:65e:3c29:cb42 with SMTP id
 956f58d0204a3-66052ed2223mr2000445d50.38.1780067188676; 
 Fri, 29 May 2026 08:06:28 -0700 (PDT)
X-Received: by 2002:a05:690e:4191:b0:65e:3c29:cb42 with SMTP id
 956f58d0204a3-66052ed2223mr2000359d50.38.1780067187864; 
 Fri, 29 May 2026 08:06:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5172ebc7d23sm22686631cf.29.2026.05.29.08.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:06:27 -0700 (PDT)
Date: Fri, 29 May 2026 11:06:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 1/2] migration/vl: Allow set parameters with
 -incoming config:*
Message-ID: <ahmrcVkOWW5iwozk@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <20260528212947.368132-2-peterx@redhat.com>
 <87pl2ftc12.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pl2ftc12.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, May 28, 2026 at 07:16:57PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > QEMU doesn't yet have a good way to specify migration parameters so that
> > they can be available even during early stage of QEMU boots.  It is because
> > the migration object (who owns the migration parameters) will only be
> > created after PHASE_LATE_BACKENDS_CREATED.  It means anything before it
> > reading migration parameters is illegal.
> >
> > However, QEMU does have special use cases for such, namely only-migratable
> > flag, and cpr-transfer. Recently, we have one more possible user to read a
> > to-be-introduced new migration parameters during backend initialization
> > phase.  We can introduce yet another global variable (or per-device
> > parameter) to bypass this limitation, but we can also seek for a generic
> > solution that we can setup migration parameters very early, even during
> > backend initializations.
> >
> > See this discussion for more details on the context of the problem:
> >
> >   https://lore.kernel.org/r/ahdI7Vl5KraK566D@x1.local
> >
> > This patch wants to take the latter approach.
> >
> > As a start, introduce a new way to specify migration parameters in QEMU
> > boot commandline, as proposed in the above discussion:
> >
> >   -incoming config:key1=value1,key2=value2,...
> >
> > When specified, QEMU will parse a string formatted MigrationParameters and
> > keep it.  When migration object is created, it will apply all the settings
> > as initial value.
> >
> > Since the application of boot parameters will be after object_new()
> > completes, it means it happens after all machine compat properties or
> > -global settings (which should be done during instance_post_init()).
> >
> > So far, it's still only a way to specify parameters.  All parameters are
> > not visible before migration object created, like before.  Any parameter
> > that needs to be visible during boot will need to opt-in this feature.
> > Follow up patches will switch the current users to use this model.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/migration/misc.h |  5 ++++
> >  migration/migration.c    | 54 ++++++++++++++++++++++++++++++++++++++++
> >  system/vl.c              |  7 ++++++
> >  qemu-options.hx          | 18 ++++++++++++--
> >  4 files changed, 82 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > index 3159a5e53c..aff79b1380 100644
> > --- a/include/migration/misc.h
> > +++ b/include/migration/misc.h
> > @@ -133,6 +133,11 @@ bool migrate_is_uri(const char *uri);
> >  /* Parse @uri and return @channel, returning true on success */
> >  bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
> >                         Error **errp);
> > +/*
> > + * Parse @config_str in form of "config:key1=value1,..." to initialize
> > + * migration parameters.
> > + */
> > +bool migration_parameters_boot_parse(const char *config_str, Error **errp);
> >  
> 
> 'boot' is not the right word. Maybe 'early'?

I am ok to switch to "early".  Another option is.. "cmdline"?

> 
> >  /* migration/multifd-device-state.c */
> >  typedef struct SaveCompletePrecopyThreadData {
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 074d3f2c69..d918be7a44 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -41,6 +41,7 @@
> >  #include "qapi/qapi-commands-migration.h"
> >  #include "qapi/qapi-events-migration.h"
> >  #include "qapi/qmp/qerror.h"
> > +#include "qapi/qobject-input-visitor.h"
> >  #include "qobject/qnull.h"
> >  #include "qemu/rcu.h"
> >  #include "postcopy-ram.h"
> > @@ -94,6 +95,9 @@ enum mig_rp_message_type {
> >  static MigrationState *current_migration;
> >  static MigrationIncomingState *current_incoming;
> >  
> > +/* Only used during boot, destroyed after migration object initialized */
> > +static MigrationParameters *mig_boot_params;
> > +
> >  static GSList *migration_blockers[MIG_MODE__MAX];
> >  
> >  static bool migration_object_check(MigrationState *ms, Error **errp);
> > @@ -102,6 +106,45 @@ static bool stop_return_path_thread_on_source(MigrationState *s);
> >  static void migration_release_dst_files(MigrationState *ms);
> >  static void migration_completion_end(MigrationState *s);
> >  
> > +bool migration_parameters_boot_parse(const char *config_str, Error **errp)
> > +{
> > +    Visitor *v;
> > +
> > +    if (mig_boot_params) {
> > +        error_setg(errp, "Only one -incoming config:* is allowed.");
> > +        return false;
> > +    }
> > +
> > +    v = qobject_input_visitor_new_str(config_str, NULL, errp);
> > +    if (!v) {
> > +        goto fail;
> > +    }
> > +
> > +    if (!visit_type_MigrationParameters(v, NULL, &mig_boot_params, errp)) {
> > +        goto fail;
> > +    }
> > +
> > +    visit_free(v);
> > +    return true;
> > +
> > +fail:
> > +    visit_free(v);
> > +    return false;
> > +}
> > +
> > +static void migration_parameters_boot_apply(void)
> > +{
> > +    if (mig_boot_params) {
> > +        /*
> > +         * This can fail, because qobject visitor doesn't do sanity check
> > +         * on values while parsing.  It's not too late; we're still in boot
> > +         * phase.
> > +         */
> > +        qmp_migrate_set_parameters(mig_boot_params, &error_abort);
> > +        g_clear_pointer(&mig_boot_params, qapi_free_MigrationParameters);
> > +    }
> > +}
> > +
> >  static void migration_downtime_start(MigrationState *s)
> >  {
> >      trace_vmstate_downtime_checkpoint("src-downtime-start");
> > @@ -322,6 +365,17 @@ void migration_object_init(void)
> >  
> >      current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
> >  
> > +    /*
> > +     * Apply boot migration parameters in case the user specified some via
> > +     * command line "-incoming config:*". NOTE: this will overwrite machine
> > +     * type compat properties and -global settings!
> > +     */
> 
> Hmm, but then it's exactly the same as -global migration.* ? Why do we
> need to extend -incoming?
> 
> Also, I don't see how qmp_migrate_set_parameters can overwrite compat
> properties. They're not part of MigrationParameters.

Some of this should have been mentioned in my other replies, let me know if
there's still concern over there after reading those.

In this case, after we set current_migration pointer compat properties are
applied, due to instance_post_init() happening within object_new().

> 
> > +    migration_parameters_boot_apply();
> > +
> > +    /*
> > +     * The boot parameters should have been verified already, but leave it
> > +     * after applying boot parameters to do one check for everything.
> > +     */
> 
> Will it get expensive? We do that for every QEMU start.

Checking caps and parameters?  Why expensive?

Here I should have mentioned we must do one shot check here, because
sometimes there're illegal mixtures of "-incoming config*" and default
values only after they merged together.  I'll update the comment for it,
IOW we must check here anyway.

> 
> >      migration_object_check(current_migration, &error_fatal);
> >  
> >      ram_mig_init();
> > diff --git a/system/vl.c b/system/vl.c
> > index da36b2c6e1..49f5fa0c7b 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -1838,6 +1838,13 @@ static void incoming_option_parse(const char *str)
> >  
> >      if (!strcmp(str, "defer")) {
> >          channel = NULL;
> > +    } else if (!strncmp(str, "config:", 7)) {
> > +        /*
> > +         * This is not a channel setup, but configuration to incoming
> > +         * migration parameters to make them available during early boot.
> > +         */
> > +        migration_parameters_boot_parse(str + 7, &error_fatal);
> > +        return;
> >      } else if (migrate_is_uri(str)) {
> >          migrate_uri_parse(str, &channel, &error_fatal);
> >      } else {
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 96ae41f787..1fc92a409a 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -5366,11 +5366,15 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
> >      "-incoming <channel>\n" \
> >      "                accept incoming migration on the migration channel\n" \
> >      "-incoming defer\n" \
> > -    "                wait for the URI to be specified via migrate_incoming\n",
> > +    "                wait for the URI to be specified via migrate_incoming\n"
> > +    "-incoming config:key1=value1,key2=value2,...\n" \
> > +    "                specify migration parameters valid even during boot\n",
> >      QEMU_ARCH_ALL)
> >  SRST
> > +
> >  The -incoming option specifies the migration channel for an incoming
> > -migration.  It may be used multiple times to specify multiple
> > +migration, or can also be used to setup migration parameters for the
> > +incoming migration.  It may be used multiple times to specify multiple
> >  migration channel types.  The channel type is specified in <channel>,
> >  or is 'main' for all other forms of -incoming.  If multiple -incoming
> >  options are specified for a channel type, the last one takes precedence.
> > @@ -5411,6 +5415,16 @@ options are specified for a channel type, the last one takes precedence.
> >      Wait for the URI to be specified via migrate\_incoming. The monitor
> >      can be used to change settings (such as migration parameters) prior
> >      to issuing the migrate\_incoming to allow the migration to begin.
> > +
> > +``-incoming config:key1=value1[,key2=value2,...]``
> > +
> > +    Specify migration parameters in QEMU commandlines, so that these
> 
> command line

Fixed.

> 
> > +    parameters will be available even during very early boot of QEMU.
> > +    They will be applied properly after QEMU boots and when the migration
> 
> The "applied properly" part is implementation detail.

True, I simplified it:

``-incoming config:key1=value1[,key2=value2,...]``

    Specify migration parameters in QEMU command line, so that these
    parameters will be available even during very early boot of QEMU.  It
    has similar effect as setting these parameters using QMP command
    ``migrate-set-parameters`` or HMP command ``migrate_set_parameter``.

> 
> > +    core is initialized.  From that POV, it has similar effect as setting
> > +    these parameters using QMP command ``migrate-set-parameters`` or HMP
> > +    command ``migrate_set_parameter``.
> > +
> >  ERST
> >  
> >  DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
> 

-- 
Peter Xu


