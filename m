Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271D310F9968
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAZ2A-0004fQ-7R; Wed, 08 Apr 2026 15:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wAZ28-0004e3-7C
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:57:52 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wAZ25-00025C-Ss
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:57:51 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35d971fbcddso135432a91.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775678268; x=1776283068; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lmQn+RHurwH+/X5CwqlEKehddxkAH1bL60Pvx3NKG/M=;
 b=A8gGF17lvgY1gdnv2DAu9Pfw57mrtSFhpqG5EqXGJWjLd+wTQfkMGXF7XFgqRkBM0g
 ezRwNkvlF51XWtKQHfVmvjW9WvEVsdKD3Txt6YNuf18ZBK+FGrBHCHRBfJlr901/KLtA
 /O38sZ5JLgl3iIENxajLXQWEADt+QzmxsOYJx3biHHW4sTMaSEJxdjCl9jC5eSGhnPkB
 dIyJB3pm+CPY0BuzXpdA2PFMkbivj2l6y9325dufAS+AZDwrNLFr6rZ8L6CKw42vTlee
 +EVBtcFB6rHJVTaP27uCPOY4mVSGjJVeMXLh3bJJDLdaaAga1kkSLdimHHIy1Ok4bCSq
 JVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775678268; x=1776283068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmQn+RHurwH+/X5CwqlEKehddxkAH1bL60Pvx3NKG/M=;
 b=ZvfD4O0vHjjNo7UflnISfrKHT9+gRxm5bg8KNbtJrpqdOuXtFEDhWd7TAdLP83zwly
 zduJU7mE6vRgDIl43wB+Mc/Xo+7qB1650oYKsivMngHmwUl9FrSDFWjUPoCVaUWcaRbE
 Hgi5xdxJoBvy+4+Z9I1KDzCBwtRvgEC9mGSr0k6donT4V14A3PxE86cTr497hqtF5fDk
 u3EDoo4iOQbkL/zvYkrvnuN2euGJq8R3QLVPEzmlE8BnKc6EyQpdeSpSkEeBFh2YO/4g
 HXI1U2AYhWMSX1SBKS8tN17KPtvZ67VR7N2eVZYgicmR71UdwnakCMXcz7qsn3xTB8Kg
 iiOA==
X-Gm-Message-State: AOJu0YwNF+ihaUrymBzFSXu+HXuiZ3JxD70+bDatpGJwvvdqn8Javw0p
 IOvUaPUAKMZio/nzIfdL2uWzISBzX8AGCF5TEzJAyq1LYJK2OrR/Qy7p
X-Gm-Gg: AeBDiestL/TbXAGfSMzKSdAmSJOR/yZ5nCdarVh0OhU/7qM6vtF/dVBdHrjNX4TMJDU
 HFX2Cv57zptp0q69Fmgan8DMrO7OaCyojP+nHSQ0Ma7CYQCmukAc4kFvBuEyMyFgw/LXS4kPV9h
 I/Zd/EG7zQZOpFYF+dGRZqDcqcdnLI2c+Kh2eCkIW8+FG5B6QanE/O31ph4ogwXk8CPJGOn6ZHv
 Xqz979V+JgnaZrRSN/kpjdk4hfjzstdpw2gMVQYVq/RYgPWMG6ZO2vklK6ELU+QczOgKSUB8GXu
 KUkWCTClOjowCuaIIF9gDHW5pZXEqtHJ5PCTJNAu9rAW3ftRRrv1KhS7Ze32WNnyj10MiYoJWZb
 zR2Ai9a7snT7fzeNyou3qEnFPAqHTgW0zYR2CfB47gu4oizMb/k3TXGqZbXjrTgLI6C0k3Hmp2L
 LHLfXDqkJQ2cxdynQg9SHzKI3oAZw3wrE=
X-Received: by 2002:a17:90b:3e81:b0:359:8df1:8553 with SMTP id
 98e67ed59e1d1-35e3542917bmr620296a91.9.1775678268101; 
 Wed, 08 Apr 2026 12:57:48 -0700 (PDT)
Received: from localhost ([42.118.191.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e34eb2ad9sm210814a91.3.2026.04.08.12.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 12:57:47 -0700 (PDT)
Date: Thu, 9 Apr 2026 02:57:43 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] migration: add optional capabilities field to migrate
 and migrate-incoming
Message-ID: <qnofe7ildi6yf7i3amdd23fipjafu7x4hgkyphcjg2q7anxrwe@mn4hi5prqgms>
References: <20260404152736.30190-1-viking4@gmail.com> <87h5po5hmc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5po5hmc.fsf@suse.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=vikingtc4@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Apr 06, 2026 at 10:43:39AM -0300, Fabiano Rosas wrote:
> Trieu Huynh <vikingtc4@gmail.com> writes:
> 
> > From: Trieu Huynh <vikingtc4@gmail.com>
> >
> > When invoking migration, user must call migrate-set-capabilities as a
> > separate QMP command before calling migrate or migrate-incoming.
> >
> > Add an optional 'capabilities' field to both commands. When provided,
> > the capabilities are applied before the migration starts, in the same
> > order as a migrate-set-capabilities call would apply them. Existing
> > callers that do not pass the field are unaffected.
> >
> > This is particularly useful, eg. for snapshot-load workflows where a
> > single migrate-incoming call should express the full migration
> > configuration:
> >
> >   { "execute": "migrate-incoming",
> >     "arguments": {
> >       "uri": "file:/tmp/snapshot",
> >       "capabilities": [{"capability": "mapped-ram", "state": true}]
> >     }}
> >
> > Internal callers (HMP migrate-incoming, vl.c -incoming) pass
> > has_capabilities=false so their behaviour is unchanged.
> >
> > Related-to: https://wiki.qemu.org/ToDo/LiveMigration#Allow_QMP_command_%22migrate[_incoming]%22_to_take_capabilities_and_parameters
> >
> 
> Hi!
> 
> This is a change that comes with a lot of implications from the
> maintenance perspective. We have an ongoing attempt at moving all
> configurable migration options to be arguments of the two main migration
> commands, but it seems the consensus is diverging a bit, see:
> 
> https://lore.kernel.org/r/20251215220041.12657-1-farosas@suse.de
> https://lore.kernel.org/r/aURtVveE88n31AN_@x1.local
> 
Oops, thanks for the context. I've checked the mailing list but might drop
these.. Glad this patch surfaced the overlap btw.
> The main point is whether this change in design direction is worth the
> maintenance burden. I do think it is, but it's not so simple, we'll have
> practically another set of commands to test and document, ensure there's
> no bad interactions with the old way of setting options, etc. Then,
> there's the entire aspect of deprecating old commands, informing users,
> switching to the new commands, etc.
> 
> Peter also mentions in the thread I linked that we haven't seen a real
> need for this type of feature. There's the general consensus (I think)
> that passing options via the migrate commands is a good design approach,
> but that doesn't mean we currently _need_ to do it, there is nothing
> technically requiring it. In which case the "more stuff to maintain"
> argument becomes stronger.
> 
The snapshot-load use case IMHO is a practical motivator. Requiring users
to issue "migrate-set-capabilities" as a seperate command before
"migrate-incoming" is a footgun. Since if they forget, they get silent
wrong behavior. Having capabilities (for eg) as part of the command, makes
the intent atomic and easier to use correctly.
> Your patch makes me realise that we could divide the whole work in
> steps, first add capabilities argument to migrate, then add parameters,
> then deprecate set-capabilities, then deprecate set-parameters. This
> would definitely ease the burden of the change, but we might get stuck
> in the middle of the process and end up with an inconsistent interface.
I agree the incremental approach is the safer path. It let us validate
the design at each step before committing to the next.
> 
> Let's hear what others think on whether a simplified approach like this
> is better and whether the whole endevour is still desirable.
Agree. Let's waiting.
> 
> (from my side, I'm in favor of continuing with the work I started. Time
> investment has been a challenge recently, maybe Trieu could help with
> it. To be clear, I'm definitely not against other approaches, as long as
> we all agree and it gets done.)
> 
It's my pleasure. Since I'm newbie here so I just try to learn more from
you and happy to help carry your series forward.

BRs,
Trieu Huynh
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> > ---
> >  migration/migration-hmp-cmds.c |  4 ++--
> >  migration/migration.c          | 19 +++++++++++++++++++
> >  qapi/migration.json            | 12 ++++++++++++
> >  system/vl.c                    |  3 ++-
> >  4 files changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> > index 0a193b8f54..32c338103d 100644
> > --- a/migration/migration-hmp-cmds.c
> > +++ b/migration/migration-hmp-cmds.c
> > @@ -522,7 +522,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
> >      }
> >      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
> >  
> > -    qmp_migrate_incoming(NULL, true, caps, true, false, &err);
> > +    qmp_migrate_incoming(NULL, true, caps, false, NULL, true, false, &err);
> >      qapi_free_MigrationChannelList(caps);
> >  
> >  end:
> > @@ -829,7 +829,7 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
> >      }
> >      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
> >  
> > -    qmp_migrate(NULL, true, caps, true, resume, &err);
> > +    qmp_migrate(NULL, true, caps, false, NULL, true, resume, &err);
> >      if (hmp_handle_error(mon, err)) {
> >          return;
> >      }
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 5c9aaa6e58..eb1a734dd9 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1752,6 +1752,8 @@ void migrate_del_blocker(Error **reasonp)
> >  
> >  void qmp_migrate_incoming(const char *uri, bool has_channels,
> >                            MigrationChannelList *channels,
> > +                          bool has_capabilities,
> > +                          MigrationCapabilityStatusList *capabilities,
> >                            bool has_exit_on_error, bool exit_on_error,
> >                            Error **errp)
> >  {
> > @@ -1772,6 +1774,14 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
> >          return;
> >      }
> >  
> > +    if (has_capabilities) {
> > +        qmp_migrate_set_capabilities(capabilities, errp);
> > +        if (*errp) {
> > +            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> > +            return;
> > +        }
> > +    }
> > +
> >      mis->exit_on_error =
> >          has_exit_on_error ? exit_on_error : INMIGRATE_DEFAULT_EXIT_ON_ERROR;
> >  
> > @@ -2020,6 +2030,8 @@ static gboolean migration_connect_outgoing_cb(QIOChannel *channel,
> >  
> >  void qmp_migrate(const char *uri, bool has_channels,
> >                   MigrationChannelList *channels,
> > +                 bool has_capabilities,
> > +                 MigrationCapabilityStatusList *capabilities,
> >                   bool has_resume, bool resume, Error **errp)
> >  {
> >      MigrationState *s = migrate_get_current();
> > @@ -2036,6 +2048,13 @@ void qmp_migrate(const char *uri, bool has_channels,
> >          return;
> >      }
> >  
> > +    if (has_capabilities) {
> > +        qmp_migrate_set_capabilities(capabilities, errp);
> > +        if (*errp) {
> > +            return;
> > +        }
> > +    }
> > +
> >      if (!migrate_prepare(s, has_resume && resume, errp)) {
> >          /* Error detected, put into errp */
> >          return;
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 7134d4ce47..58d934f8fe 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1388,6 +1388,11 @@
> >  # @channels: list of migration stream channels with each stream in the
> >  #     list connected to a destination interface endpoint.
> >  #
> > +# @capabilities: list of migration capabilities to set before
> > +#     starting the migration.  Equivalent to calling
> > +#     `migrate-set-capabilities` before `migrate`, but more
> > +#     convenient.
> > +#
> >  # @resume: when set, use the new uri/channels specified to resume
> >  #     paused postcopy migration.  This flag should only be used if
> >  #     the previous postcopy migration was interrupted.  The command
> > @@ -1453,6 +1458,7 @@
> >  { 'command': 'migrate',
> >    'data': {'*uri': 'str',
> >             '*channels': [ 'MigrationChannel' ],
> > +           '*capabilities': ['MigrationCapabilityStatus'],
> >             '*resume': 'bool' } }
> >  
> >  ##
> > @@ -1467,6 +1473,11 @@
> >  # @channels: list of migration stream channels with each stream in the
> >  #     list connected to a destination interface endpoint.
> >  #
> > +# @capabilities: list of migration capabilities to set before
> > +#     starting the migration.  Equivalent to calling
> > +#     `migrate-set-capabilities` before `migrate-incoming`, but more
> > +#     convenient.
> > +#
> >  # @exit-on-error: Exit on incoming migration failure.  Default true.
> >  #     When set to false, the failure triggers a
> >  #     :qapi:event:`MIGRATION` event, and error details could be
> > @@ -1525,6 +1536,7 @@
> >  { 'command': 'migrate-incoming',
> >               'data': {'*uri': 'str',
> >                        '*channels': [ 'MigrationChannel' ],
> > +                      '*capabilities': ['MigrationCapabilityStatus'],
> >                        '*exit-on-error': 'bool' } }
> >  
> >  ##
> > diff --git a/system/vl.c b/system/vl.c
> > index 246623b319..ed569d75e7 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -2826,7 +2826,8 @@ void qmp_x_exit_preconfig(Error **errp)
> >                  g_new0(MigrationChannelList, 1);
> >  
> >              channels->value = incoming_channels[MIGRATION_CHANNEL_TYPE_MAIN];
> > -            qmp_migrate_incoming(NULL, true, channels, true, true, &local_err);
> > +            qmp_migrate_incoming(NULL, true, channels, false, NULL, true,
> > +                                 true, &local_err);
> >              if (local_err) {
> >                  error_reportf_err(local_err, "-incoming %s: ", incoming);
> >                  exit(1);

