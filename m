Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79129C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 17:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUTot-0007oN-RA; Wed, 25 Jun 2025 13:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uUToq-0007nq-3r
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 13:21:56 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uUToV-0007SH-3X
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 13:21:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 38D602118A;
 Wed, 25 Jun 2025 17:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750872093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wunuiCMCESB2qh5kyC48vwWqa7TEoQZ6sA0xxwows0=;
 b=NxxVp9zqk/fSiRPOPGOspURjq8th6VrLYs9xE+m2G35dj3eVzsrAKaA6oKZNwYiZ/ke/Fi
 CmaAABh0/PV6u/giJ6wiBsbAeuOPPuC0rFBRhmybejZ1OOM4zaNKwuQBvLifz16BAVQbPL
 sEc0+Epknl3/Ex6Rp/btkP1Am9zfLJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750872093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wunuiCMCESB2qh5kyC48vwWqa7TEoQZ6sA0xxwows0=;
 b=xoaQ4fn1K7EyhUc3tFVl5jXhkMbL0lG4+95HV21njLMFczLRpDjENYF0oFZl+IVaWrz8IF
 kOmwuK59O1xHsCDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750872093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wunuiCMCESB2qh5kyC48vwWqa7TEoQZ6sA0xxwows0=;
 b=NxxVp9zqk/fSiRPOPGOspURjq8th6VrLYs9xE+m2G35dj3eVzsrAKaA6oKZNwYiZ/ke/Fi
 CmaAABh0/PV6u/giJ6wiBsbAeuOPPuC0rFBRhmybejZ1OOM4zaNKwuQBvLifz16BAVQbPL
 sEc0+Epknl3/Ex6Rp/btkP1Am9zfLJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750872093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wunuiCMCESB2qh5kyC48vwWqa7TEoQZ6sA0xxwows0=;
 b=xoaQ4fn1K7EyhUc3tFVl5jXhkMbL0lG4+95HV21njLMFczLRpDjENYF0oFZl+IVaWrz8IF
 kOmwuK59O1xHsCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AECE713485;
 Wed, 25 Jun 2025 17:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 17Y2HBwwXGhKSQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 25 Jun 2025 17:21:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 02/21] migration: Remove MigrateSetParameters
In-Reply-To: <87y0tg5a7l.fsf@pond.sub.org>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-3-farosas@suse.de> <87y0tg5a7l.fsf@pond.sub.org>
Date: Wed, 25 Jun 2025 14:21:30 -0300
Message-ID: <875xgj7n51.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[4]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Now that the TLS options have been made the same between
>> migrate-set-parameters and query-migrate-parameters, a single type can
>> be used. Remove MigrateSetParameters.
>>
>> The TLS options documentation from MigrationParameters were replaced
>> with the ones from MigrateSetParameters which was more complete.
>>
>> I'm choosing to somewhat ignore any ambiguity between "query" and
>> "set" because other options' docs are already ambiguous in that
>> regard.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration-hmp-cmds.c |   4 +-
>>  migration/options.c            |   6 +-
>>  qapi/migration.json            | 221 +++------------------------------
>>  3 files changed, 20 insertions(+), 211 deletions(-)
>>
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index bc8179c582..aacffdc532 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -490,7 +490,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>      const char *param = qdict_get_str(qdict, "parameter");
>>      const char *valuestr = qdict_get_str(qdict, "value");
>>      Visitor *v = string_input_visitor_new(valuestr);
>> -    MigrateSetParameters *p = g_new0(MigrateSetParameters, 1);
>> +    MigrationParameters *p = g_new0(MigrationParameters, 1);
>>      uint64_t valuebw = 0;
>>      uint64_t cache_size;
>>      Error *err = NULL;
>> @@ -656,7 +656,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>      qmp_migrate_set_parameters(p, &err);
>>  
>>   cleanup:
>> -    qapi_free_MigrateSetParameters(p);
>> +    qapi_free_MigrationParameters(p);
>>      visit_free(v);
>>      hmp_handle_error(mon, err);
>>  }
>> diff --git a/migration/options.c b/migration/options.c
>> index 45a95dc6da..e49d584a99 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -1227,7 +1227,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>>      return true;
>>  }
>>  
>> -static void migrate_params_test_apply(MigrateSetParameters *params,
>> +static void migrate_params_test_apply(MigrationParameters *params,
>>                                        MigrationParameters *dest)
>>  {
>>      *dest = migrate_get_current()->parameters;
>> @@ -1350,7 +1350,7 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>>      }
>>  }
>>  
>> -static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>> +static void migrate_params_apply(MigrationParameters *params, Error **errp)
>>  {
>>      MigrationState *s = migrate_get_current();
>>  
>> @@ -1479,7 +1479,7 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>>      }
>>  }
>>  
>> -void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>> +void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>>  {
>>      MigrationParameters tmp;
>>  
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index fa42d94810..080968993a 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -914,202 +914,6 @@
>>             'zero-page-detection',
>>             'direct-io'] }
>>  
>> -##
>> -# @MigrateSetParameters:
>
> Only use is argument type of migrate-set-parameters.  You're replacing
> it by MigrationParameters there.  Let's compare the deleted docs to
> their replacement.  I'll quote replacement docs exactly where they
> differ.
>
>    # @MigrationParameters:
>    #
>    # Migration parameters. Optional members are optional when used with
>    # an input command, otherwise mandatory.
>
> Figuring out which commands are input commands is left to the reader.
> Why not simply "optional with migrate-set-parameters"?
>

Future patches include migrate and migrate-incoming. I can enumerate
them if that's better.

> However, it doesn't end there.  The paragraph creates a problem with
> John Snow's "inliner", which I hope to merge later this year.  Let me
> explain.
>
> Generated command documentation normally looks like this:
>
>     Command migrate-set-capabilities (Since: 1.2)
>
>        Enable/Disable the following migration capabilities (like xbzrle)
>
>        Arguments:
>           * **capabilities** ("[""MigrationCapabilityStatus""]") -- json
>             array of capability modifications to make
>
> Except when we happen to use a named type for the arguments.  This
> should be an implementation detail, and it is, except for generated
> documentation, which looks like
>
>     Command migrate-set-parameters (Since: 2.4)
>
>        Set various migration parameters.
>
>        Arguments:
>           * The members of "MigrationParameters".
>
> The arguments are hidden behind a link.  The "inliner" will show the
> them normally *always*, for better usability.  It will not, however,
> inline the introductory paragraph above.  I can explain why if
> necessary.
>
> To compensate for the loss of that paragraph, we'll have to add suitable
> text to migrate-set-parameters's doc comment.
>
> I think we could just as well do that *now*: scratch the paragraph here,
> add a suitable paragraph there.
>

Ok, no worries.

>> -#
>> -# @announce-initial: Initial delay (in milliseconds) before sending
>> -#     the first announce (Since 4.0)
>> -#
>> -# @announce-max: Maximum delay (in milliseconds) between packets in
>> -#     the announcement (Since 4.0)
>> -#
>> -# @announce-rounds: Number of self-announce packets sent after
>> -#     migration (Since 4.0)
>> -#
>> -# @announce-step: Increase in delay (in milliseconds) between
>> -#     subsequent packets in the announcement (Since 4.0)
>> -#
>> -# @throttle-trigger-threshold: The ratio of bytes_dirty_period and
>> -#     bytes_xfer_period to trigger throttling.  It is expressed as
>> -#     percentage.  The default value is 50.  (Since 5.0)
>> -#
>> -# @cpu-throttle-initial: Initial percentage of time guest cpus are
>> -#     throttled when migration auto-converge is activated.  The
>> -#     default value is 20.  (Since 2.7)
>> -#
>
>    # @cpu-throttle-initial: Initial percentage of time guest cpus are
>    #     throttled when migration auto-converge is activated.  (Since
>    #     2.7)
>
> We no longer document the default value.
>

Rebase blunder, I believe the defaults were added recently.

>> -# @cpu-throttle-increment: throttle percentage increase each time
>> -#     auto-converge detects that migration is not making progress.
>> -#     The default value is 10.  (Since 2.7)
>
>    # @cpu-throttle-increment: throttle percentage increase each time
>    #     auto-converge detects that migration is not making progress.
>    #     (Since 2.7)
>
> Likewise.
>

Here as well.

>> -#
>> -# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage At
>> -#     the tail stage of throttling, the Guest is very sensitive to CPU
>> -#     percentage while the @cpu-throttle -increment is excessive
>> -#     usually at tail stage.  If this parameter is true, we will
>> -#     compute the ideal CPU percentage used by the Guest, which may
>> -#     exactly make the dirty rate match the dirty rate threshold.
>> -#     Then we will choose a smaller throttle increment between the one
>> -#     specified by @cpu-throttle-increment and the one generated by
>> -#     ideal CPU percentage.  Therefore, it is compatible to
>> -#     traditional throttling, meanwhile the throttle increment won't
>> -#     be excessive at tail stage.  The default value is false.  (Since
>> -#     5.1)
>> -#
>> -# @tls-creds: ID of the 'tls-creds' object that provides credentials
>> -#     for establishing a TLS connection over the migration data
>> -#     channel.  On the outgoing side of the migration, the credentials
>> -#     must be for a 'client' endpoint, while for the incoming side the
>> -#     credentials must be for a 'server' endpoint.  Setting this to a
>> -#     non-empty string enables TLS for all migrations.  An empty
>> -#     string means that QEMU will use plain text mode for migration,
>> -#     rather than TLS.  This is the default.  (Since 2.7)
>> -#
>> -# @tls-hostname: migration target's hostname for validating the
>> -#     server's x509 certificate identity.  If empty, QEMU will use the
>> -#     hostname from the migration URI, if any.  A non-empty value is
>> -#     required when using x509 based TLS credentials and the migration
>> -#     URI does not include a hostname, such as fd: or exec: based
>> -#     migration.  (Since 2.7)
>> -#
>> -#     Note: empty value works only since 2.9.
>> -#
>> -# @tls-authz: ID of the 'authz' object subclass that provides access
>> -#     control checking of the TLS x509 certificate distinguished name.
>> -#     This object is only resolved at time of use, so can be deleted
>> -#     and recreated on the fly while the migration server is active.
>> -#     If missing, it will default to denying access (Since 4.0)
>> -#
>> -# @max-bandwidth: maximum speed for migration, in bytes per second.
>> -#     (Since 2.8)
>> -#
>> -# @avail-switchover-bandwidth: to set the available bandwidth that
>> -#     migration can use during switchover phase.  NOTE!  This does not
>> -#     limit the bandwidth during switchover, but only for calculations
>> -#     when making decisions to switchover.  By default, this value is
>> -#     zero, which means QEMU will estimate the bandwidth
>> -#     automatically.  This can be set when the estimated value is not
>> -#     accurate, while the user is able to guarantee such bandwidth is
>> -#     available when switching over.  When specified correctly, this
>> -#     can make the switchover decision much more accurate.
>> -#     (Since 8.2)
>> -#
>> -# @downtime-limit: set maximum tolerated downtime for migration.
>> -#     maximum downtime in milliseconds (Since 2.8)
>> -#
>> -# @x-checkpoint-delay: The delay time (in ms) between two COLO
>> -#     checkpoints in periodic mode.  (Since 2.8)
>
>    # @x-checkpoint-delay: the delay time between two COLO checkpoints.
>    #     (Since 2.8)
>
> We no longer mention periodic mode.
>

I'll fix it.

>> -#
>> -# @multifd-channels: Number of channels used to migrate data in
>> -#     parallel.  This is the same number that the number of sockets
>> -#     used for migration.  The default value is 2 (since 4.0)
>> -#
>> -# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
>> -#     needs to be a multiple of the target page size and a power of 2
>> -#     (Since 2.11)
>> -#
>> -# @max-postcopy-bandwidth: Background transfer bandwidth during
>> -#     postcopy.  Defaults to 0 (unlimited).  In bytes per second.
>> -#     (Since 3.0)
>> -#
>> -# @max-cpu-throttle: maximum cpu throttle percentage.  Defaults to 99.
>> -#     (Since 3.1)
>> -#
>> -# @multifd-compression: Which compression method to use.  Defaults to
>> -#     none.  (Since 5.0)
>> -#
>> -# @multifd-zlib-level: Set the compression level to be used in live
>> -#     migration, the compression level is an integer between 0 and 9,
>> -#     where 0 means no compression, 1 means the best compression
>> -#     speed, and 9 means best compression ratio which will consume
>> -#     more CPU.  Defaults to 1.  (Since 5.0)
>> -#
>> -# @multifd-qatzip-level: Set the compression level to be used in live
>> -#     migration. The level is an integer between 1 and 9, where 1 means
>> -#     the best compression speed, and 9 means the best compression
>> -#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
>> -#
>> -# @multifd-zstd-level: Set the compression level to be used in live
>> -#     migration, the compression level is an integer between 0 and 20,
>> -#     where 0 means no compression, 1 means the best compression
>> -#     speed, and 20 means best compression ratio which will consume
>> -#     more CPU.  Defaults to 1.  (Since 5.0)
>> -#
>> -# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>> -#     aliases for the purpose of dirty bitmap migration.  Such aliases
>> -#     may for example be the corresponding names on the opposite site.
>> -#     The mapping must be one-to-one, but not necessarily complete: On
>> -#     the source, unmapped bitmaps and all bitmaps on unmapped nodes
>> -#     will be ignored.  On the destination, encountering an unmapped
>> -#     alias in the incoming migration stream will result in a report,
>> -#     and all further bitmap migration data will then be discarded.
>> -#     Note that the destination does not know about bitmaps it does
>> -#     not receive, so there is no limitation or requirement regarding
>> -#     the number of bitmaps received, or how they are named, or on
>> -#     which nodes they are placed.  By default (when this parameter
>> -#     has never been set), bitmap names are mapped to themselves.
>> -#     Nodes are mapped to their block device name if there is one, and
>> -#     to their node name otherwise.  (Since 5.2)
>> -#
>> -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
>> -#     limit during live migration.  Should be in the range 1 to
>> -#     1000ms.  Defaults to 1000ms.  (Since 8.1)
>> -#
>> -# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
>> -#     Defaults to 1.  (Since 8.1)
>> -#
>> -# @mode: Migration mode.  See description in @MigMode.  Default is
>> -#     'normal'.  (Since 8.2)
>> -#
>> -# @zero-page-detection: Whether and how to detect zero pages.
>> -#     See description in @ZeroPageDetection.  Default is 'multifd'.
>> -#     (since 9.0)
>> -#
>> -# @direct-io: Open migration files with O_DIRECT when possible.  This
>> -#     only has effect if the @mapped-ram capability is enabled.
>> -#     (Since 9.1)
>> -#
>> -# Features:
>> -#
>> -# @unstable: Members @x-checkpoint-delay and
>> -#     @x-vcpu-dirty-limit-period are experimental.
>> -#
>> -# TODO: either fuse back into MigrationParameters, or make
>> -#     MigrationParameters members mandatory
>
> The TODO is gone.  Makes sense.
>
>> -#
>> -# Since: 2.4
>> -##
>> -{ 'struct': 'MigrateSetParameters',
>> -  'data': { '*announce-initial': 'size',
>> -            '*announce-max': 'size',
>> -            '*announce-rounds': 'size',
>> -            '*announce-step': 'size',
>> -            '*throttle-trigger-threshold': 'uint8',
>> -            '*cpu-throttle-initial': 'uint8',
>> -            '*cpu-throttle-increment': 'uint8',
>> -            '*cpu-throttle-tailslow': 'bool',
>> -            '*tls-creds': 'StrOrNull',
>> -            '*tls-hostname': 'StrOrNull',
>> -            '*tls-authz': 'StrOrNull',
>> -            '*max-bandwidth': 'size',
>> -            '*avail-switchover-bandwidth': 'size',
>> -            '*downtime-limit': 'uint64',
>> -            '*x-checkpoint-delay': { 'type': 'uint32',
>> -                                     'features': [ 'unstable' ] },
>> -            '*multifd-channels': 'uint8',
>> -            '*xbzrle-cache-size': 'size',
>> -            '*max-postcopy-bandwidth': 'size',
>> -            '*max-cpu-throttle': 'uint8',
>> -            '*multifd-compression': 'MultiFDCompression',
>> -            '*multifd-zlib-level': 'uint8',
>> -            '*multifd-qatzip-level': 'uint8',
>> -            '*multifd-zstd-level': 'uint8',
>> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>> -            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>> -                                            'features': [ 'unstable' ] },
>> -            '*vcpu-dirty-limit': 'uint64',
>> -            '*mode': 'MigMode',
>> -            '*zero-page-detection': 'ZeroPageDetection',
>> -            '*direct-io': 'bool' } }
>> -
>>  ##
>>  # @migrate-set-parameters:
>>  #
>> @@ -1124,12 +928,13 @@
>>  #     <- { "return": {} }
>>  ##
>>  { 'command': 'migrate-set-parameters', 'boxed': true,
>> -  'data': 'MigrateSetParameters' }
>> +  'data': 'MigrationParameters' }
>>  
>>  ##
>>  # @MigrationParameters:
>>  #
>> -# The optional members aren't actually optional.
>> +# Migration parameters. Optional members are optional when used with
>> +# an input command, otherwise mandatory.
>>  #
>>  # @announce-initial: Initial delay (in milliseconds) before sending
>>  #     the first announce (Since 4.0)
>> @@ -1172,21 +977,25 @@
>>  #     for establishing a TLS connection over the migration data
>>  #     channel.  On the outgoing side of the migration, the credentials
>>  #     must be for a 'client' endpoint, while for the incoming side the
>> -#     credentials must be for a 'server' endpoint.  An empty string
>> -#     means that QEMU will use plain text mode for migration, rather
>> -#     than TLS.  (Since 2.7)
>> -#
>> -#     Note: 2.8 omits empty @tls-creds instead.
>> +#     credentials must be for a 'server' endpoint.  Setting this to a
>> +#     non-empty string enables TLS for all migrations.  An empty
>> +#     string means that QEMU will use plain text mode for migration,
>> +#     rather than TLS.  This is the default.  (Since 2.7)
>>  #
>>  # @tls-hostname: migration target's hostname for validating the
>>  #     server's x509 certificate identity.  If empty, QEMU will use the
>> -#     hostname from the migration URI, if any.  (Since 2.7)
>> +#     hostname from the migration URI, if any.  A non-empty value is
>> +#     required when using x509 based TLS credentials and the migration
>> +#     URI does not include a hostname, such as fd: or exec: based
>> +#     migration.  (Since 2.7)
>>  #
>> -#     Note: 2.8 omits empty @tls-hostname instead.
>> +#     Note: empty value works only since 2.9.
>>  #
>>  # @tls-authz: ID of the 'authz' object subclass that provides access
>>  #     control checking of the TLS x509 certificate distinguished name.
>> -#     (Since 4.0)
>> +#     This object is only resolved at time of use, so can be deleted
>> +#     and recreated on the fly while the migration server is active.
>> +#     If missing, it will default to denying access (Since 4.0)
>>  #
>>  # @max-bandwidth: maximum speed for migration, in bytes per second.
>>  #     (Since 2.8)

