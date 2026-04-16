Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25636F8DFC3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDU3i-00005l-KS; Thu, 16 Apr 2026 17:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wDU3Y-0008VZ-UF
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:15:26 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wDU3X-0004bf-AD
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:15:24 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0FEE96A819;
 Thu, 16 Apr 2026 21:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776374120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jw/sNkW5CJ2pSiJZkGYNjsAYZAtiXrpF+Lqqgm7nYXI=;
 b=YGuACo/sEWu2m1/HSQ5io1anFTP+GPDIPhJA7T6Li04xMOjFs4msJ1gf7hpywXWilJBCVw
 ozpXRe2F53GPsUlwmKKhirZvCt5R+roHRC8rJtLnnOIIv14ElTTXt9E9i4EArfc5Zb0taI
 rzHdXILR+BTx0wt795M3AWKURAnGwAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776374120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jw/sNkW5CJ2pSiJZkGYNjsAYZAtiXrpF+Lqqgm7nYXI=;
 b=cID+4p1VaIznQa8/I3/Q1uwHQGgZ67IHuOSQYM33Q4KFPaBBt4XlVcgJxr58ZQVj6PH4dt
 0JPq00p22hJS/MDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="YGuACo/s";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cID+4p1V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776374120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jw/sNkW5CJ2pSiJZkGYNjsAYZAtiXrpF+Lqqgm7nYXI=;
 b=YGuACo/sEWu2m1/HSQ5io1anFTP+GPDIPhJA7T6Li04xMOjFs4msJ1gf7hpywXWilJBCVw
 ozpXRe2F53GPsUlwmKKhirZvCt5R+roHRC8rJtLnnOIIv14ElTTXt9E9i4EArfc5Zb0taI
 rzHdXILR+BTx0wt795M3AWKURAnGwAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776374120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jw/sNkW5CJ2pSiJZkGYNjsAYZAtiXrpF+Lqqgm7nYXI=;
 b=cID+4p1VaIznQa8/I3/Q1uwHQGgZ67IHuOSQYM33Q4KFPaBBt4XlVcgJxr58ZQVj6PH4dt
 0JPq00p22hJS/MDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47B40593A3;
 Thu, 16 Apr 2026 21:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id spo3BWdR4WmYHgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 16 Apr 2026 21:15:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>, Prasad
 Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Joao
 Martins <joao.m.martins@oracle.com>, Markus Armbruster
 <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>, Hyman Huang
 <yong.huang@smartx.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 09/14] migration: Move iteration counter out of RAM
In-Reply-To: <aeEnNQO_c6LzM2FD@x1.local>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-10-peterx@redhat.com> <8734136atk.fsf@suse.de>
 <aeEnNQO_c6LzM2FD@x1.local>
Date: Thu, 16 Apr 2026 18:15:08 -0300
Message-ID: <87qzoey5cz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[15];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 0FEE96A819
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Apr 09, 2026 at 07:14:15PM -0300, Fabiano Rosas wrote:
>> > diff --git a/migration/ram.c b/migration/ram.c
>> > index e5b7217bf5..686162643d 100644
>> > --- a/migration/ram.c
>> > +++ b/migration/ram.c
>> > @@ -1136,8 +1136,6 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
>> >      RAMBlock *block;
>> >      int64_t end_time;
>> >  
>> > -    qatomic_add(&mig_stats.dirty_sync_count, 1);
>> > -
>> >      if (!rs->time_last_bitmap_sync) {
>> >          rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>> 
>> Tangent: aren't these updates to time_last_bitmap_sync racy with the
>> sync from the throttle code?
>
> It looks fine to me.  This variable (along with log sync) should require
> BQL, so I expect normal form of race condition won't happen.
>
> But maybe you meant when migration_bitmap_sync() can be invoked by the
> timer kick-offed in cpu_throttle_dirty_sync_timer_tick()?
>

Yep.

> Indeed that could happen together with the migration thread trying to sync
> by other reasons, but so far I see no issues: time_last_bitmap_sync might
> get updated sooner, but it should always reflect the time that whoever
> synced the last, and when both want to do it they contend on BQL, which
> looks ok.
>

Hm, I think I need to do a deeper audit, there's several access to
RAMState there. But I agree on the surface there's nothing too
egregious.

> So the expectation is that timer just makes sure sync happens slightly more
> frequently, where QEMU src might used to sync toooo less times on huge VMs
> (because each iteration took tooo long).

