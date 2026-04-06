Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B68AE64016
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 13:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kF2-0004AK-2p; Mon, 06 Apr 2026 09:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w9kF0-0004AC-UU
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 09:43:46 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w9kEy-0001WY-Sy
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 09:43:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3CCBA4DF04;
 Mon,  6 Apr 2026 13:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775483022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6mdPaYbhYrJntX9/BaxgFMR3MVh2A117zaxrHaA+wzE=;
 b=uneaRN1SfTLohKasq96jGE+rh5n6iNTFI/qBiIwJFdlCQvlzr1bUshuir+ooJMVbsA4Kpn
 bdurG6v8xJ6tIjPqnC2Lc8C46oJfLSinfHgbCP1nhJxqts6W8im8P2hHM4ANpLyWSH31Fq
 VSgbDuQ6HCxa0eaqb/BlDy3ok4nmf+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775483022;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6mdPaYbhYrJntX9/BaxgFMR3MVh2A117zaxrHaA+wzE=;
 b=mYwMy2CaARKOkLBsttpdzozvyrslhKZW207rJYX0kGDhFWpwWH6gsyWrG8O7L815LX51Dl
 mlbxLn0Heyz6m8AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uneaRN1S;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mYwMy2Ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775483022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6mdPaYbhYrJntX9/BaxgFMR3MVh2A117zaxrHaA+wzE=;
 b=uneaRN1SfTLohKasq96jGE+rh5n6iNTFI/qBiIwJFdlCQvlzr1bUshuir+ooJMVbsA4Kpn
 bdurG6v8xJ6tIjPqnC2Lc8C46oJfLSinfHgbCP1nhJxqts6W8im8P2hHM4ANpLyWSH31Fq
 VSgbDuQ6HCxa0eaqb/BlDy3ok4nmf+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775483022;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6mdPaYbhYrJntX9/BaxgFMR3MVh2A117zaxrHaA+wzE=;
 b=mYwMy2CaARKOkLBsttpdzozvyrslhKZW207rJYX0kGDhFWpwWH6gsyWrG8O7L815LX51Dl
 mlbxLn0Heyz6m8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C02F44A0B0;
 Mon,  6 Apr 2026 13:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 97GXIo2402lASQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 06 Apr 2026 13:43:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Peter Xu <peterx@redhat.com>, Eric
 Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] migration: add optional capabilities field to migrate
 and migrate-incoming
In-Reply-To: <20260404152736.30190-1-viking4@gmail.com>
References: <20260404152736.30190-1-viking4@gmail.com>
Date: Mon, 06 Apr 2026 10:43:39 -0300
Message-ID: <87h5po5hmc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 3CCBA4DF04
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Trieu Huynh <vikingtc4@gmail.com> writes:

> From: Trieu Huynh <vikingtc4@gmail.com>
>
> When invoking migration, user must call migrate-set-capabilities as a
> separate QMP command before calling migrate or migrate-incoming.
>
> Add an optional 'capabilities' field to both commands. When provided,
> the capabilities are applied before the migration starts, in the same
> order as a migrate-set-capabilities call would apply them. Existing
> callers that do not pass the field are unaffected.
>
> This is particularly useful, eg. for snapshot-load workflows where a
> single migrate-incoming call should express the full migration
> configuration:
>
>   { "execute": "migrate-incoming",
>     "arguments": {
>       "uri": "file:/tmp/snapshot",
>       "capabilities": [{"capability": "mapped-ram", "state": true}]
>     }}
>
> Internal callers (HMP migrate-incoming, vl.c -incoming) pass
> has_capabilities=false so their behaviour is unchanged.
>
> Related-to: https://wiki.qemu.org/ToDo/LiveMigration#Allow_QMP_command_%22migrate[_incoming]%22_to_take_capabilities_and_parameters
>

Hi!

This is a change that comes with a lot of implications from the
maintenance perspective. We have an ongoing attempt at moving all
configurable migration options to be arguments of the two main migration
commands, but it seems the consensus is diverging a bit, see:

https://lore.kernel.org/r/20251215220041.12657-1-farosas@suse.de
https://lore.kernel.org/r/aURtVveE88n31AN_@x1.local

The main point is whether this change in design direction is worth the
maintenance burden. I do think it is, but it's not so simple, we'll have
practically another set of commands to test and document, ensure there's
no bad interactions with the old way of setting options, etc. Then,
there's the entire aspect of deprecating old commands, informing users,
switching to the new commands, etc.

Peter also mentions in the thread I linked that we haven't seen a real
need for this type of feature. There's the general consensus (I think)
that passing options via the migrate commands is a good design approach,
but that doesn't mean we currently _need_ to do it, there is nothing
technically requiring it. In which case the "more stuff to maintain"
argument becomes stronger.

Your patch makes me realise that we could divide the whole work in
steps, first add capabilities argument to migrate, then add parameters,
then deprecate set-capabilities, then deprecate set-parameters. This
would definitely ease the burden of the change, but we might get stuck
in the middle of the process and end up with an inconsistent interface.

Let's hear what others think on whether a simplified approach like this
is better and whether the whole endevour is still desirable.

(from my side, I'm in favor of continuing with the work I started. Time
investment has been a challenge recently, maybe Trieu could help with
it. To be clear, I'm definitely not against other approaches, as long as
we all agree and it gets done.)

> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  migration/migration-hmp-cmds.c |  4 ++--
>  migration/migration.c          | 19 +++++++++++++++++++
>  qapi/migration.json            | 12 ++++++++++++
>  system/vl.c                    |  3 ++-
>  4 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 0a193b8f54..32c338103d 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -522,7 +522,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>      }
>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>  
> -    qmp_migrate_incoming(NULL, true, caps, true, false, &err);
> +    qmp_migrate_incoming(NULL, true, caps, false, NULL, true, false, &err);
>      qapi_free_MigrationChannelList(caps);
>  
>  end:
> @@ -829,7 +829,7 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      }
>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>  
> -    qmp_migrate(NULL, true, caps, true, resume, &err);
> +    qmp_migrate(NULL, true, caps, false, NULL, true, resume, &err);
>      if (hmp_handle_error(mon, err)) {
>          return;
>      }
> diff --git a/migration/migration.c b/migration/migration.c
> index 5c9aaa6e58..eb1a734dd9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1752,6 +1752,8 @@ void migrate_del_blocker(Error **reasonp)
>  
>  void qmp_migrate_incoming(const char *uri, bool has_channels,
>                            MigrationChannelList *channels,
> +                          bool has_capabilities,
> +                          MigrationCapabilityStatusList *capabilities,
>                            bool has_exit_on_error, bool exit_on_error,
>                            Error **errp)
>  {
> @@ -1772,6 +1774,14 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
>          return;
>      }
>  
> +    if (has_capabilities) {
> +        qmp_migrate_set_capabilities(capabilities, errp);
> +        if (*errp) {
> +            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> +            return;
> +        }
> +    }
> +
>      mis->exit_on_error =
>          has_exit_on_error ? exit_on_error : INMIGRATE_DEFAULT_EXIT_ON_ERROR;
>  
> @@ -2020,6 +2030,8 @@ static gboolean migration_connect_outgoing_cb(QIOChannel *channel,
>  
>  void qmp_migrate(const char *uri, bool has_channels,
>                   MigrationChannelList *channels,
> +                 bool has_capabilities,
> +                 MigrationCapabilityStatusList *capabilities,
>                   bool has_resume, bool resume, Error **errp)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -2036,6 +2048,13 @@ void qmp_migrate(const char *uri, bool has_channels,
>          return;
>      }
>  
> +    if (has_capabilities) {
> +        qmp_migrate_set_capabilities(capabilities, errp);
> +        if (*errp) {
> +            return;
> +        }
> +    }
> +
>      if (!migrate_prepare(s, has_resume && resume, errp)) {
>          /* Error detected, put into errp */
>          return;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7134d4ce47..58d934f8fe 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1388,6 +1388,11 @@
>  # @channels: list of migration stream channels with each stream in the
>  #     list connected to a destination interface endpoint.
>  #
> +# @capabilities: list of migration capabilities to set before
> +#     starting the migration.  Equivalent to calling
> +#     `migrate-set-capabilities` before `migrate`, but more
> +#     convenient.
> +#
>  # @resume: when set, use the new uri/channels specified to resume
>  #     paused postcopy migration.  This flag should only be used if
>  #     the previous postcopy migration was interrupted.  The command
> @@ -1453,6 +1458,7 @@
>  { 'command': 'migrate',
>    'data': {'*uri': 'str',
>             '*channels': [ 'MigrationChannel' ],
> +           '*capabilities': ['MigrationCapabilityStatus'],
>             '*resume': 'bool' } }
>  
>  ##
> @@ -1467,6 +1473,11 @@
>  # @channels: list of migration stream channels with each stream in the
>  #     list connected to a destination interface endpoint.
>  #
> +# @capabilities: list of migration capabilities to set before
> +#     starting the migration.  Equivalent to calling
> +#     `migrate-set-capabilities` before `migrate-incoming`, but more
> +#     convenient.
> +#
>  # @exit-on-error: Exit on incoming migration failure.  Default true.
>  #     When set to false, the failure triggers a
>  #     :qapi:event:`MIGRATION` event, and error details could be
> @@ -1525,6 +1536,7 @@
>  { 'command': 'migrate-incoming',
>               'data': {'*uri': 'str',
>                        '*channels': [ 'MigrationChannel' ],
> +                      '*capabilities': ['MigrationCapabilityStatus'],
>                        '*exit-on-error': 'bool' } }
>  
>  ##
> diff --git a/system/vl.c b/system/vl.c
> index 246623b319..ed569d75e7 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2826,7 +2826,8 @@ void qmp_x_exit_preconfig(Error **errp)
>                  g_new0(MigrationChannelList, 1);
>  
>              channels->value = incoming_channels[MIGRATION_CHANNEL_TYPE_MAIN];
> -            qmp_migrate_incoming(NULL, true, channels, true, true, &local_err);
> +            qmp_migrate_incoming(NULL, true, channels, false, NULL, true,
> +                                 true, &local_err);
>              if (local_err) {
>                  error_reportf_err(local_err, "-incoming %s: ", incoming);
>                  exit(1);

