Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79E7C47BF2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 13:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd7PT-0001mE-RG; Tue, 06 Jan 2026 08:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vd7PO-0001lf-OG
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 08:47:39 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vd7PM-0008LI-TN
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 08:47:38 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE6305BCD5;
 Tue,  6 Jan 2026 13:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767707253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVNNgqQQiJPv7wRJbFsl8DmdpVTMBAjU3y3/RMyolX8=;
 b=T677Igdw8CuNc1z3/OVhLtpyL8lBjkMP8vO1DtDHBSFkN7VdvhiacGzlnqbYNxRT6rEu1X
 jPcC64FiZZ0s75ds7eURxcBfqY3schoI1If2mdyDGojJh57a9Y7I1BATVa3kW+INOQCmBZ
 qva+BJDsaWS0FluMkOGKbw0sMyRC9/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767707253;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVNNgqQQiJPv7wRJbFsl8DmdpVTMBAjU3y3/RMyolX8=;
 b=4s645y+6prt+eqc129wRmB5DiOqjMZ3mgfjuVhhT0ySb4rmemAdTYr0qrE91w6VS2HhRS8
 7q39dkTnjdTxEPAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T677Igdw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4s645y+6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767707253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVNNgqQQiJPv7wRJbFsl8DmdpVTMBAjU3y3/RMyolX8=;
 b=T677Igdw8CuNc1z3/OVhLtpyL8lBjkMP8vO1DtDHBSFkN7VdvhiacGzlnqbYNxRT6rEu1X
 jPcC64FiZZ0s75ds7eURxcBfqY3schoI1If2mdyDGojJh57a9Y7I1BATVa3kW+INOQCmBZ
 qva+BJDsaWS0FluMkOGKbw0sMyRC9/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767707253;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVNNgqQQiJPv7wRJbFsl8DmdpVTMBAjU3y3/RMyolX8=;
 b=4s645y+6prt+eqc129wRmB5DiOqjMZ3mgfjuVhhT0ySb4rmemAdTYr0qrE91w6VS2HhRS8
 7q39dkTnjdTxEPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DA143EA63;
 Tue,  6 Jan 2026 13:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Vmf1A3USXWm4TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 06 Jan 2026 13:47:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
In-Reply-To: <CAE8KmOzcOdYhnxpDr8BMV8zjixpEh9r+COe=xyLfXCVWKD0CRw@mail.gmail.com>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de> <aUq1oA73W9rAdCgG@x1.local>
 <CAE8KmOzcOdYhnxpDr8BMV8zjixpEh9r+COe=xyLfXCVWKD0CRw@mail.gmail.com>
Date: Tue, 06 Jan 2026 10:47:30 -0300
Message-ID: <87zf6q26q5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CE6305BCD5
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hi,
>
> On Tue, 23 Dec 2025 at 21:00, Peter Xu <peterx@redhat.com> wrote:
>> One thing good about exposing such status via QAPI is, it can help us
>> diagnose issues by seeing CANCELLING / FAILING even looking at
>> query-migrate results (as normally when bug happens we can't see the
>> internal status..), so that we know either it's explicitly cancelled, or
>> something went wrong.
>>
>> If it's a completely hidden / internal status, we may see ACTIVE even if
>> something wrong happened..
>
> * Both process state and reason(s) for the state change needs to be
> visible to the user. But states like cancelling/failing are redundant,
> users would derive the same conclusion from CANCELLED and CANCELLING
> OR FAILED AND FAILING. Besides, migration_cleanup() does exactly the
> same steps irrespective of whether migration is failing or cancelling
> or failed or cancelled.
>
>> My current hope is any mgmt should normally by default ignore new migration
>> states..  If that's always achieved, it looks to me adding FAILING directly
>> into migration status would still have some benefits on debugging.
>
> * libvirtd(8) complains about unknown states multiple times:
>       libvirtd[2194267]: unknown status 'failing' in migration event
>       libvirtd[2194267]: unknown status 'failing' in migration event
>       libvirtd[2194267]: unknown status 'failing' in migration event
>
>
>> > > @@ -2907,7 +2914,7 @@ fail_closefb:
>> > >      qemu_fclose(fb);
>> > >  fail:
>> > >      if (ms->state != MIGRATION_STATUS_CANCELLING) {
>> > > -        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
>> > > +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILING);
>> > >      }
>> >
>> > This is a good example where having MigrationStatus makes the code more
>> > complicated. This could be exiting=true, running=false, etc. It
>> > shouldn't matter why this routine failed. If we reach
>> > migration_cleanup() and, at the very end, state is CANCELLING, then we
>> > know the cancel command has caused this and set the state to
>> > CANCELLED. If the state was something else, then it's unintended and we
>> > set FAILED.
>>
>> If it'll be an internal status, we'll still need to identify if someone
>> already have cancelled it, right?
>>
>> Assuming we introduce stop_reason flag, making it:
>>
>> enum {
>>     MIG_STOP_REASON_CANCEL,
>>     MIG_STOP_REASON_FAIL,
>> } MigrationStopReason;
>>
>> Then we can switch to CANCELLED / FAILED when cleanup from those reasons.
>>
>> Then here, logically we also need logic like:
>>
>>     if (stop_reason != MIG_STOP_REASON_CANCEL) {
>>         stop_reason = MIG_STOP_REASON_FAIL;
>>     }
>>
>> Because we want to make sure when the user already triggered cancel, it
>> won't show FAILED but only show CANCELLED at last?
>
> * I think the way we are setting/changing these states in as many
> locations is only adding to the complications. Do we have to
> explicitly set these states like this? What if migration_cleanup()
> always sets the state to 'STOP'. Similarly other places set the state
> to a predefined state. OR
> ===
>     struct {
>         current_state;
>         old_state;
>         event/trigger;
>         reason[];
>     } MigrationState s;
>
>     migration_change_state(s) {
>           s->old_state = s->current_state;
>           if (s->current_state == START && s->trigger ==
> 'connections-established') {
>               s->current_state = ACTIVE;
>               s->reason = "connections-established, migration starting"
>           } else if (s->current_state == ACTIVE && s->trigger == 'completed') {
>               s->current_state = STOP
>               s->reason = "migration completed"
>           } else if (s->current_state == ACTIVE  && s->trigger == 'pause') {
>               s->current_state = PAUSE
>               s->reason = "pause, migration paused"
>           } else if (s->current_state == ACTIVE && s->trigger ==
> 'error-occurred') {
>               s->current_state = STOP
>               s->reason = "Error occurred, migration failed"
>           } else if (s->current_state == ACTIVE && s->trigger ==
> 'user-cancel') {
>               s->current_state = STOP
>               s->reason = "user-cancel, migration cancelled"
>          } else {
>               s->current_state = s->current_state;
>               warn_msg("unknown combination, maybe define a new rule?");
>          }
>     }
> ===
> * We define explicit rules for the state change and accordingly we
> only call migration_change_state() at any point and it'll change to an
> appropriate next state, recording the due reason for the change.
>

If we had a linear state transition table, i.e. a DFA without any
branching, that would be ideal. But since we have states that can reach
(and be reached from) multiple other states, then we'll always need some
input to migration_change_state(). Here you're making it the
s->trigger. Where will that come from?

Looking at runstate.c and job.c, it seems we could at least define a
state transition table and do away with the second parameter to
migrate_set_state(s, old, new).

As we've been discussing, the current state-change mechanism has the
dual purpose of emitting the state change event and also serving as
internal tracking of the migration state. It's not clear to me whether
you're covering both in this proposal or just one of them.

I don't think we've established actually what are the goals of having
any state changes. Do we even need state changes for internal tracking?
We could use your s->trigger as an enum and just check it wherever
necessary. And keep the MIGRATION_STATUS exclusive for the external API,
in which case, it's probably better to just set it unconditionally (in
many places migrate_set_state already takes the current state as
argument, i.e. it doesn't care about the current state).

> Wdyt...?
>
> Thank you.
> ---
>   - Prasad

