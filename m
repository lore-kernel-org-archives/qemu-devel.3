Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791A8D3EE6C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 14:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vivZ0-0005lm-Up; Thu, 22 Jan 2026 09:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vivYt-0005lT-GF
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 09:21:28 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vivYr-000544-Oh
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 09:21:27 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 74E31336A1;
 Thu, 22 Jan 2026 14:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769091683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v/lrSP45NNFwTzNS41ykeZn07P0BCFKx7Mx7nNdg6Jg=;
 b=Y+5L+Fx0iTJJpTaRJ3Z0Hy+0T8mv18izThoLIDnEEwrCkG8J/NFbPZZKtul4Y+8cdPDEmd
 A/kDa+P8WaCYYKpxaNnnGi6vFnkH/Fk/BECTwywGMzuUQHG63NshgdXiutMI2jyKV+Hcrj
 JXqztAfdwsATiC/r9qf+L8wqruNl2S4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769091683;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v/lrSP45NNFwTzNS41ykeZn07P0BCFKx7Mx7nNdg6Jg=;
 b=rAOM9mh1FQYMV0JMCf9HPML7iXlorBDCAyO3ks0rNC/TOaNKLxx9406scvVNQC1zxTq1dK
 JhCUj960lTh2ZOCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769091683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v/lrSP45NNFwTzNS41ykeZn07P0BCFKx7Mx7nNdg6Jg=;
 b=Y+5L+Fx0iTJJpTaRJ3Z0Hy+0T8mv18izThoLIDnEEwrCkG8J/NFbPZZKtul4Y+8cdPDEmd
 A/kDa+P8WaCYYKpxaNnnGi6vFnkH/Fk/BECTwywGMzuUQHG63NshgdXiutMI2jyKV+Hcrj
 JXqztAfdwsATiC/r9qf+L8wqruNl2S4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769091683;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v/lrSP45NNFwTzNS41ykeZn07P0BCFKx7Mx7nNdg6Jg=;
 b=rAOM9mh1FQYMV0JMCf9HPML7iXlorBDCAyO3ks0rNC/TOaNKLxx9406scvVNQC1zxTq1dK
 JhCUj960lTh2ZOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE9271395E;
 Thu, 22 Jan 2026 14:21:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1V1NJ2Iycmn/HwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Jan 2026 14:21:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com
Subject: Re: [PATCH 5/5] migration/options: Use QAPI_MERGE in
 migrate_params_test_apply
In-Reply-To: <CAE8KmOwGXSXpmFhLod57R8LE6fPEg0rgbOPki7LQ3FAWnCD3gg@mail.gmail.com>
References: <20260114132309.5832-1-farosas@suse.de>
 <20260114132309.5832-6-farosas@suse.de>
 <CAE8KmOxNPToj2r__BNGMxm=ckGLwbMD2t6_3h=-KVCQxV8RVxw@mail.gmail.com>
 <874ioelip2.fsf@suse.de>
 <CAE8KmOwGXSXpmFhLod57R8LE6fPEg0rgbOPki7LQ3FAWnCD3gg@mail.gmail.com>
Date: Thu, 22 Jan 2026 11:21:20 -0300
Message-ID: <87qzrhk9sv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hi,
>
> On Thu, 22 Jan 2026 at 03:41, Fabiano Rosas <farosas@suse.de> wrote:
>> See if the following looks better to you. It's not one single function,
>> but I folded what I could while keeping the distinct function names.
>>
>> static void migrate_params_apply(MigrationParameters *new, Error **errp)
>> {
>>     MigrationState *s = migrate_get_current();
>>     MigrationParameters *cur = &s->parameters;
>>     MigrationParameters *tmp = QAPI_CLONE(MigrationParameters, cur);
>>
>>     QAPI_MERGE(MigrationParameters, tmp, new);
>>
>>     if (!migrate_params_check(tmp, errp)) {
>>         return;
>>     }
>>
>>     migrate_ptr_opts_free(cur);
>>
>>     /* mark all present, so they're all copied */
>>     migrate_mark_all_params_present(params);
>>     QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
>>
>>     migrate_post_update_params(new, errp);
>> }
>>
>> void qmp_migrate_set_parameters(MigrationParameters *new, Error **errp)
>> {
>>     /*
>>      * Convert QTYPE_QNULL and NULL to the empty string (""). Even
>>      * though NULL is cleaner to deal with in C code, that would force
>>      * query-migrate-parameters to convert it once more to the empty
>>      * string, so avoid that. The migrate_tls_*() helpers that expose
>>      * the options to the rest of the migration code already use
>>      * return NULL when the empty string is found.
>>      */
>>     tls_opt_to_str(new->tls_creds);
>>     tls_opt_to_str(new->tls_hostname);
>>     tls_opt_to_str(new->tls_authz);
>>
>>     migrate_params_apply(new, errp);
>> }
>>
>
> * I'm thinking as:
> ===
> v0:
>
> void qmp_migrate_set_parameters(MigrationParameters *new, Error **errp)
> {
>     /*
>      * Convert QTYPE_QNULL and NULL to the empty string (""). Even
>      * though NULL is cleaner to deal with in C code, that would force
>      * query-migrate-parameters to convert it once more to the empty
>      * string, so avoid that. The migrate_tls_*() helpers that expose
>      * the options to the rest of the migration code already use
>      * return NULL when the empty string is found.
>      */
>     tls_opt_to_str(new->tls_creds);
>     tls_opt_to_str(new->tls_hostname);
>     tls_opt_to_str(new->tls_authz);
>
>     MigrationState *s = migrate_get_current();
>     MigrationParameters *cur = &s->parameters;
>     MigrationParameters *tmp = QAPI_CLONE(MigrationParameters, cur);
>
>     QAPI_MERGE(MigrationParameters, tmp, new);
>
>     if (!migrate_params_check(tmp, errp)) {
>         return;
>     }
>     migrate_ptr_opts_free(cur);
>
>     /* mark all present, so they're all copied */
>     migrate_mark_all_params_present(tpm);
>     QAPI_CLONE_MEMBERS(MigrationParameters, cur, tmp);
>
>     migrate_post_update_params(cur, errp);
> }
> ===
> v1:
>
> void qmp_migrate_set_parameters(MigrationParameters *new, Error **errp)
> {
>     /*
>      * Convert QTYPE_QNULL and NULL to the empty string (""). Even
>      * though NULL is cleaner to deal with in C code, that would force
>      * query-migrate-parameters to convert it once more to the empty
>      * string, so avoid that. The migrate_tls_*() helpers that expose
>      * the options to the rest of the migration code already use
>      * return NULL when the empty string is found.
>      */
>     tls_opt_to_str(new->tls_creds);
>     tls_opt_to_str(new->tls_hostname);
>     tls_opt_to_str(new->tls_authz);
>
>     MigrationState *s = migrate_get_current();
>     MigrationParameters *cur = &s->parameters;
>     MigrationParameters *tmp = QAPI_CLONE(MigrationParameters, cur);      ...[1]
>
>     QAPI_MERGE(MigrationParameters, tmp, new);
>                  ...[2]
>
>     if (!migrate_params_check(tmp, errp)) {
>         return;
>     }
>     migrate_ptr_opts_free(cur);
>
>     /* mark all present, so they're all copied */
>     migrate_mark_all_params_present(tpm);
>     QAPI_CLONE_MEMBERS(MigrationParameters, cur, tmp);
>        ...[3]
>
>     /* update MigrationState after parameters change */
>                      ...[4]
>     if (cur->has_max_bandwidth) {
>         if (s->to_dst_file && !migration_in_postcopy()) {
>             migration_rate_set(cur->max_bandwidth);
>         }
>     }
>     if (cur->has_x_checkpoint_delay) {
>         colo_checkpoint_delay_set();
>     }
>     if (cur->has_xbzrle_cache_size) {
>         xbzrle_cache_resize(cur->xbzrle_cache_size, errp);
>     }
>     if (cur->has_max_postcopy_bandwidth) {
>         if (s->to_dst_file && migration_in_postcopy()) {
>             migration_rate_set(cur->max_postcopy_bandwidth);
>         }
>     }
> }
> ===
>
> * I'd go with v1 above.
> * Reasons for folding migrate_params_apply() and migrate_post_update_params():
>    - Both static functions are called _only_ from
> qmp_migrate_set_parameters(). They are not reusable from elsewhere.
>    - Earlier migrate_params_apply() was quite long due to  if...else
> conditionals, so it made sense to break one long function into 2-3
> smaller ones.
>    - Now with QAPI_CLONE/MERGE changes qmp_migrate_set_parameters() is
> concise and easy to follow.
>    - Reader can see all steps (1,2,3,4 above) together in one function.
>
> * Just sharing my thoughts. You pick what you think is best.
>

Ok, thanks, let's see in what mood I'm in when reposting =)

> Thank you.
> ---
>   - Prasad

