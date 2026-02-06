Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1182FEE2091
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 12:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voL2S-00059K-Hw; Fri, 06 Feb 2026 07:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1voL2Q-00058k-T7
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:34:18 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1voL2P-00069Z-16
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:34:18 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3E0175BCC5;
 Fri,  6 Feb 2026 12:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770381255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RR48pqPsRZmekRfGfhAXqXlIZwpZqaixLiW4ztpam+Q=;
 b=Sux3p0kvyj/c9SYYEMsSb55tr2GECD4SDKsFlbfj0RM3zuhPZb/XMPZGUrXhARAW6e4RBV
 0zduFsboFA8MYJL3OPVLL8XAcK2LDwbm+dc6LHva16bcPGdnD4Gi/WH0AYsE8sn9vnd/uJ
 AbGBnUmbzkMGjkaXw++t7cjJgrE8/iY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770381255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RR48pqPsRZmekRfGfhAXqXlIZwpZqaixLiW4ztpam+Q=;
 b=ou2/KKeBf5lcuqCkmHE1qaWRZftFWbxWvHevRt3XQkk8vwBH3pD4XLQQTD60HB3ZBe6R/r
 V0fCjx9O7d/3hmAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Sux3p0kv;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ou2/KKeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770381255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RR48pqPsRZmekRfGfhAXqXlIZwpZqaixLiW4ztpam+Q=;
 b=Sux3p0kvyj/c9SYYEMsSb55tr2GECD4SDKsFlbfj0RM3zuhPZb/XMPZGUrXhARAW6e4RBV
 0zduFsboFA8MYJL3OPVLL8XAcK2LDwbm+dc6LHva16bcPGdnD4Gi/WH0AYsE8sn9vnd/uJ
 AbGBnUmbzkMGjkaXw++t7cjJgrE8/iY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770381255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RR48pqPsRZmekRfGfhAXqXlIZwpZqaixLiW4ztpam+Q=;
 b=ou2/KKeBf5lcuqCkmHE1qaWRZftFWbxWvHevRt3XQkk8vwBH3pD4XLQQTD60HB3ZBe6R/r
 V0fCjx9O7d/3hmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A637A3EA63;
 Fri,  6 Feb 2026 12:34:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D/bBGcbfhWnzJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Feb 2026 12:34:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com
Subject: Re: [PATCH v2 0/9] qapi: Use visitors for migration parameters
 handling
In-Reply-To: <aYUUQ5sAiwR-nvul@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <aYUUQ5sAiwR-nvul@x1.local>
Date: Fri, 06 Feb 2026 09:34:12 -0300
Message-ID: <877bsqqce3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 3E0175BCC5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Mon, Feb 02, 2026 at 07:40:52PM -0300, Fabiano Rosas wrote:
>> Hi, just a few more patches until options.c is fully using QAPI_CLONE
>> instead of open-coding options handling, we're almost there.
>
> While I'm reading your series, I found one thing that migration might be
> racy against for a while, and this series should enlarge that window of
> this issue: I don't think it's safe to free elements in MigrationParameters
> in the main thread, even if we hold BQL. Because migration thread can
> access parameters anytime without BQL... logically it can read any
> parameter, then if it's not a scalar we need some luck not crashing.
>

Good point, I had thought of it and convinced myself it was ok
somehow. I'll take another look.

> IMHO we may need to move faster on the "whitelist that can be dynamically
> set during migration" plan on migration parameters and capabilities.
>

Or we make set-parameters always work on top of temporary
MigrationParameter objects and switch the pointer atomically. Might be a
good idea regardless.

> I don't think any cap (after converted to parameters) should be on this
> whitelist... for parameters, I'm trying to be conservative but I believe
> the list should look like this:
>
> CPU throttle knobs:
>
>         throttle-trigger-threshold
>         cpu-throttle-increment
>         cpu-throttle-tailslow
>         max-cpu-throttle
>         x-vcpu-dirty-limit-period
>         vcpu-dirty-limit
>
> Bandwith knobs:
>
>         max-bandwidth
>         avail-switchover-bandwidth
>         downtime-limit
>         max-postcopy-bandwidth
>
> COLO knob:
>
>         x-checkpoint-delay
>
> That really should be all parameters we allow to change..  Luckily all of
> them are scalars, so it's fine to keep the current migrate_params_free()
> and logic to "free then update".
>
> I wonder if we should even consider having this whitelist alongside with
> your this series if we want to be extra safe, but I'll let you decide.. I'm
> also OK we do it later, but maybe we don't want it to be too late either.

Yeah.. I'll see what I can do. Thanks for the reviews this far!

