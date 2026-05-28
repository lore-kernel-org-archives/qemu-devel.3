Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0E1CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSinn-0005IH-0G; Thu, 28 May 2026 18:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wSink-0005Hq-KN
 for qemu-devel@nongnu.org; Thu, 28 May 2026 18:02:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wSini-0006QL-GF
 for qemu-devel@nongnu.org; Thu, 28 May 2026 18:02:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1D966AA53;
 Thu, 28 May 2026 22:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780005720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GLALtPeIKawcvIaJSyno2p0wG7JNK/3FpXrtsztYR50=;
 b=ONI5QePxzSqWEDb24TO5RgAMRb8pAxhxo9aJZUrsXjQisMJ7E/JLMItCHb0PNck+LOUJrD
 Magwq+9mqgevNOHKd1gFhGt+XWaAyzkfBqxQ2sNYPHy88GJjTCP/ogLnffhx0qfrusIVwJ
 7C4Q3N3q4E35Gx/5ohlblmQL0rZOj5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780005720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GLALtPeIKawcvIaJSyno2p0wG7JNK/3FpXrtsztYR50=;
 b=b801tBXvZ+1XQFV0kC0CyCOCBnUL8VArGwwRP+dpMH86g98olxzynLnimxWNqZVLSdoV0W
 yqAHqCE5Pj92BNBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iNQlIQFK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ps6YcaC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780005716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GLALtPeIKawcvIaJSyno2p0wG7JNK/3FpXrtsztYR50=;
 b=iNQlIQFKKENwMRxRouo/HuGzE9e1EuLhw4kqCw/5hzXFgQohA7JlmeFtRAtJCkxxBvc5sU
 uSK6+QKXY7GbFD2VNGMqXZGqY+fSbqp+XRBH4vIbYePP9RFkfuq7zkDhGXgbZw89kRpycz
 bN0l1G1usRe4d59tavYvyCw+SWbAvSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780005716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GLALtPeIKawcvIaJSyno2p0wG7JNK/3FpXrtsztYR50=;
 b=ps6YcaC8lz01t6xM7SqpP7Qbu7dok4ryDFWZpHFpxDPuNWnBYMKYen5PbbkkRLzSJPtcMG
 JfzCB9Bh4GoBy3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 621665AFE9;
 Thu, 28 May 2026 22:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GBE2DVS7GGq9PQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 28 May 2026 22:01:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Mark
 Kanda <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, Jason Wang
 <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
In-Reply-To: <20260528212947.368132-1-peterx@redhat.com>
References: <20260528212947.368132-1-peterx@redhat.com>
Date: Thu, 28 May 2026 19:01:50 -0300
Message-ID: <87se7btcq9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C1D966AA53
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,gitlab.com:url,suse.de:dkim,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> CI: https://gitlab.com/peterx/qemu/-/pipelines/2560168907
>
> This series introduces a generic way to specify migration parameters that
> can be used even during the early boot phase of QEMU.
>
> One example use case that already existed is CPR-transfer / CPR-exec.
> currently QEMU has a temporary global variable (incoming_mode) to achieve
> this, but it's hard to understand and this hack bleeded into quite a few
> places that we could have avoided.  The lines in patch 2 touched may
> provide some idea.
>
> With a generic approach of setting migration parameters with cmdlines, we
> can remove this hack meanwhile QEMU should be able to keep the CPR behavior
> as before.  To CPR maintainers and reviewers: please have a closer look,
> even better if it can be smoke tested, to see if this works for Oracle's
> environment, TIA.
>
> The 1st patch implemented that new semantics.  It is straightforward: now
> we can setup any migration parameter using an extra line of:
>
>   -incoming config:key1=value1,key2=value2,...

Just merge my code mate.
https://lore.kernel.org/r/20251215220041.12657-25-farosas@suse.de

A couple of differences from my patch:

- old-style keyval vs. json;

Isn't json preferred nowadays?

- using "config:"

This makes it non-uniform with uri and channels which don't have a
keyword in front of them. I guess I could live with it, but it seems
odd. I see that it makes parsing way easier.

>
> So far only one such instance is allowed for simplicity, but it should be
> enough.  We still allow multiple -incoming for specifying channels, used
> together with one "-incoming config:*".
>
> Then parameters set this way will be visible almost anytime for QEMU, for
> example, during initialization of device backends (which is before
> migration object created).
>
> I posted this series majorly because I want to see if this will make a
> possible new user for the new "local" migration parameter proposed in
> Vladimir's series:
>
>   https://lore.kernel.org/r/20260522120534.77653-1-vsementsov@yandex-team.ru
>
> Especially, there're some context on this idea too in this email:
>
>   https://lore.kernel.org/all/ahdI7Vl5KraK566D@x1.local/
>

I like the idea overall.

> With this series, we should be able to drop "incoming-fds" TAP property
> from the other series, instead relying on the existing "local" parameters
> both in migration core and in TAP's property should suffice.
>
> One thing to mention is I didn't further make only-migratable into a
> migration parameter.  Logically it will also work now with only-migratable,
> but it then also means I'll need to convert it to a parameter, which will
> be mutable even after VM started.  It will change how only-migratable used
> to work, hence I skipped.
>
> After this, we also almost have no reason to use -global for migration
> parameters.  Capabilities are still not supported in -incoming cmdline,
> though.
>

Will we still merge capabilities and parameters? Then it would be a free
upgrade.

> Thanks,
>
> Peter Xu (2):
>   migration/vl: Allow set parameters with -incoming config:*
>   migration/cpr: Opt-in "mode" parameter for early boot access
>
>  include/migration/cpr.h  |  3 --
>  include/migration/misc.h |  5 +++
>  migration/migration.h    |  3 ++
>  migration/cpr.c          | 18 ++++----
>  migration/migration.c    | 91 +++++++++++++++++++++++++++++++++++++++-
>  migration/options.c      | 10 ++---
>  system/vl.c              |  7 ++++
>  qemu-options.hx          | 18 +++++++-
>  8 files changed, 133 insertions(+), 22 deletions(-)

