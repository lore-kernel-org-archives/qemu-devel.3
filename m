Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6E8C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 16:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6aW-0007qG-5t; Wed, 15 Jan 2025 11:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tY6aO-0007pt-Ux
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:49:45 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tY6aM-0003DW-Pn
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:49:44 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 420721F7C0;
 Wed, 15 Jan 2025 16:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736959779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zA3RKcUixx4ZeTnWOP230OH0WBrF+g1aSEj2WD8eznk=;
 b=Q8iXpYMVtjQodf4Qsgoii/ZAk7Bhe2UwddSSqXRhfwn2xu5fv60eqlFIUmP3SYKXVcwRIh
 VaPMdJaFByBeQ94HNPvZXpgtN9xVJdPHFiv4JUqAgRoxlayEWYLU2dsfIbUQEB2SuZJYpb
 nhXChRMYl3m7okhOeanOA9aIezYOfAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736959779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zA3RKcUixx4ZeTnWOP230OH0WBrF+g1aSEj2WD8eznk=;
 b=9x5L0W1O8opYnXG+SowvG0W7kL1uXy9H4+p1r/vsJYxpfClkRKZdljTkiIt4JRwx2PKOhr
 C73f6nPoh+QTnpBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q8iXpYMV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9x5L0W1O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736959779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zA3RKcUixx4ZeTnWOP230OH0WBrF+g1aSEj2WD8eznk=;
 b=Q8iXpYMVtjQodf4Qsgoii/ZAk7Bhe2UwddSSqXRhfwn2xu5fv60eqlFIUmP3SYKXVcwRIh
 VaPMdJaFByBeQ94HNPvZXpgtN9xVJdPHFiv4JUqAgRoxlayEWYLU2dsfIbUQEB2SuZJYpb
 nhXChRMYl3m7okhOeanOA9aIezYOfAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736959779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zA3RKcUixx4ZeTnWOP230OH0WBrF+g1aSEj2WD8eznk=;
 b=9x5L0W1O8opYnXG+SowvG0W7kL1uXy9H4+p1r/vsJYxpfClkRKZdljTkiIt4JRwx2PKOhr
 C73f6nPoh+QTnpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC40713A6F;
 Wed, 15 Jan 2025 16:49:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cSDVHyLnh2djIwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 15 Jan 2025 16:49:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>, Julia Suvorova
 <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH 00/16] migration: Switchover phase refactoring
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
Date: Wed, 15 Jan 2025 13:49:36 -0300
Message-ID: <878qrcf2e7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 420721F7C0
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> CI: https://gitlab.com/peterx/qemu/-/pipelines/1625266692
>     (note: warning is present on rust stuff, but shouldn't be relevant)
>
> This series refactors the migration switchover path quite a bit.  I started
> this work initially to measure the JSON writer overhead, but then I decided
> to cleanup the switchover path in general when I am at it altogether, as I
> wanted to do this for a long time.
>
> A few major things I tried to do:
>
>   - About the JSON writer
>
>     Currently, precopy migration always dumps a chunk of data called VM
>     description (QEMU_VM_VMDESCRIPTION) for debugging purpose.  That is a
>     JSON blob explaining all the vmstates dumped in the migration stream.
>     QEMU has a machine property suppress-vmdesc deciding whether migration
>     will have that JSON chunk included.
>
>     Postcopy does not have such JSON dump because postcopy is live session
>     and it can't normally be debugged from stream level (e.g. as a streamed
>     file).
>
>     A tiny problem is we don't yet have a clue on how much cpu cycles we
>     need to construct and dump these JSONs even if they're only for
>     debugging, and even if suppress-vmdesc=on QEMU will still try to
>     construct these JSONs (e.g. also for postcopy).
>
>     This series has a few patches just to make sure the JSON blob won't be
>     constructed if not needed (either postcopy, or suppress-vmdesc=on).  I
>     tried to measure the downtime diff with/without these changes, the time
>     QEMU takes to construct / dump the JSON blob is still not measurable.
>     So I suppose unconditionally having this is ok.  Said that, let's still
>     have these changes around so we avoid JSON operations if not needed.
>
>   - DEVICE migration state
>
>     QEMU has a very special DEVICE migration state, that only happens with
>     precopy, and only when pause-before-switchover capability is enabled.
>     Due to that specialty we can't merge precopy and postcopy code on
>     switchover starts, because the state machine will be different.
>
>     However after I checked the history and also with libvirt developers,
>     this seems unnecessary.  So I had one patch making DEVICE state to be
>     the "switchover" phase for precopy/postcopy unconditionally.  That will
>     make the state machine much easier for both modes, meanwhile nothing is
>     expected to break with it (but please still shoot if anyone knows /
>     suspect something will, or could, break..).
>
>   - General cleanups and fixes
>
>     Most of the rest changes are random cleanups and fixes in the
>     switchover path.
>
>     E.g., postcopy_start() has some code that isn't easy to read due to
>     some special flags here and there, mostly around the two calls of
>     qemu_savevm_state_complete_precopy().  This series will remove most of
>     those special treatments here and there.
>
>     We could have done something twice in the past in postcopy switchover
>     (e.g. I believe we sync CPU twice.. but only happens with postcopy),
>     now they should all be sorted out.
>
>     And quite some other things hopefully can be separately discussed and
>     justified in each patch.  After these cleanups, we will be able to have
>     an unified entrance for precopy/postcopy on switchover.
>
> Initially I thought this could optimize the downtime slightly, but after
> some tests, it turns out there's no measureable difference, at least in my
> current setup... So let's take this as a cleanup series at least for now,
> and I hope they would still make some sense.  Comments welcomed.
>
> Thanks,
>
> Peter Xu (16):
>   migration: Remove postcopy implications in should_send_vmdesc()
>   migration: Do not construct JSON description if suppressed
>   migration: Optimize postcopy on downtime by avoiding JSON writer
>   migration: Avoid two src-downtime-end tracepoints for postcopy
>   migration: Drop inactivate_disk param in qemu_savevm_state_complete*
>   migration: Synchronize all CPU states only for non-iterable dump
>   migration: Adjust postcopy bandwidth during switchover
>   migration: Adjust locking in migration_maybe_pause()
>   migration: Drop cached migration state in migration_maybe_pause()
>   migration: Take BQL slightly longer in postcopy_start()
>   migration: Notify COMPLETE once for postcopy
>   migration: Unwrap qemu_savevm_state_complete_precopy() in postcopy
>   migration: Cleanup qemu_savevm_state_complete_precopy()
>   migration: Always set DEVICE state
>   migration: Merge precopy/postcopy on switchover start
>   migration: Trivial cleanup on JSON writer of vmstate_save()
>
>  qapi/migration.json         |   7 +-
>  migration/migration.h       |   1 +
>  migration/savevm.h          |   6 +-
>  migration/migration.c       | 209 +++++++++++++++++++++++-------------
>  migration/savevm.c          | 116 ++++++++------------
>  migration/vmstate.c         |   6 +-
>  tests/qtest/libqos/libqos.c |   3 +-
>  migration/trace-events      |   2 +-
>  tests/qemu-iotests/194.out  |   1 +
>  tests/qemu-iotests/203.out  |   1 +
>  tests/qemu-iotests/234.out  |   2 +
>  tests/qemu-iotests/262.out  |   1 +
>  tests/qemu-iotests/280.out  |   1 +
>  13 files changed, 200 insertions(+), 156 deletions(-)

Queued, thanks!

