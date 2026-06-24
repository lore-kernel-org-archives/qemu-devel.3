Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53348CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcOMD-0000tx-Ng; Wed, 24 Jun 2026 10:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wcOM5-0000tM-FA
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:13:29 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wcOLs-0006Yv-CL
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:13:18 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5B29676087;
 Wed, 24 Jun 2026 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782310393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nh9fuyMvTLDyYp8hOlh8VJ6SZ878Ag/1mlv0365pJv4=;
 b=o3kgL3rIqbW3BX1WUen22kwEma3hP1GzSXjHjtHOBrryv/KiZEsidpmb4GQO1xRyrV9Hr7
 pPzGrzgXAoxZ+J2oEMA1fh+5S9op4j5A1Q+w/piFLdCO6NTvkMXgNeBaE0OzZGXStEH5MA
 8V+WFFtzHF6VTEjnWNvjyfjXYyyF/9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782310393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nh9fuyMvTLDyYp8hOlh8VJ6SZ878Ag/1mlv0365pJv4=;
 b=/SylvyXek4bujQR9uiJ+E1hAyyroT1drktJmHUMDf/akB6997cqrArQJo0spj2UR0ID9r+
 O/0szrtFg2aUi0AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FS09SwoT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="H/CxjJo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782310392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nh9fuyMvTLDyYp8hOlh8VJ6SZ878Ag/1mlv0365pJv4=;
 b=FS09SwoTkaUIK3QgVM3COzSBGWUw9Qgy5wgzsFeQzpiMvYxi9DkhLWUazDiVb9Gpk9BWIS
 UeC75jC8Y5Pdlu8xUS/61nMCAdKfS0Js+qSGcw5ktmOjdFOOyZm1gVdX8OJDSjI/y1egT0
 LEy0hCJcRPzEm1spOe7zlmjMPLKXTQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782310392;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nh9fuyMvTLDyYp8hOlh8VJ6SZ878Ag/1mlv0365pJv4=;
 b=H/CxjJo7LmsVczh+P26PBdpc4FXNesg7JJk2NwzY+ypRUMFCARkxCFAluT49DfeOo77Fuu
 cUtF1kpiskZuUIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECEEA779A8;
 Wed, 24 Jun 2026 14:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9pa6LvflO2q8NAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 24 Jun 2026 14:13:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Aadeshveer Singh <aadeshveer07@gmail.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, Aadeshveer Singh
 <aadeshveer07@gmail.com>
Subject: Re: [RFC PATCH 0/5] migration: fast snapshot load
In-Reply-To: <20260618032010.88755-1-aadeshveer07@gmail.com>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
Date: Wed, 24 Jun 2026 11:13:05 -0300
Message-ID: <878q84owlq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,mailo.com,saferwall.com,gmail.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5B29676087
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

Aadeshveer Singh <aadeshveer07@gmail.com> writes:

> This RFC implements a "fast snapshot load" mechanism to significantly
> reduce the perceived resume time of a VM from a snapshot file.
>
> Currently, resuming a VM from a snapshot file requires loading all RAM
> pages into the QEMU instance before execution begins. This extension
> allows the user to run the VM nearly instantly by loading only the
> required device states up front and loading RAM pages lazily, by
> trapping access to pages that have not yet been loaded.
>
> Using the Linux userfaultfd syscall, a fault thread catches all page
> faults caused by the guest and loads in the pages required to keep
> the VM running. Concurrently, an eager background thread iteratively
> loads all remaining pages into RAM so the guest does not have to
> depend on the fault thread indefinitely.
>
> Much of code is reused from postcopy for fault handling and precopy
> for reading mapped ram file. Implementation revolves around two
> threads named the fault thread and eager load thread. Fault thread as
> name suggests catches page faults by the guest and serves them using
> userfaultfd. Postcopy fault thread is reused but instead of requesting
> source for a page it loads the page directly by reading form file. In
> order to remove the dependency of guest on fault thread indefinitely
> the eager load thread loads in the entire RAM sequentially, and after
> iterating through the entire RAM signals fault thread to exit and
> calls cleanup.
>
> In order to prevent the case of a page being loaded twice(in the
> case when eager load thread is loading it and fault thread also
> tries to serve fault on same page) a bitmap called pending_bmap is
> used to track pages which are pending and not being loaded by any
> thread. Atomic operations on this bitmap allows coordination between
> threads to prevent any unwanted behaviours
>

How does it work if a second savevm happens while the RAM has not been
yet entirely loaded?

> This patch was tested using a Debian 13 bare minimum system and Fedora
> 44 KDE, snapshots for both are loaded successfully with no error.
>
> Next Steps:
> - Add testing framework, in qtest and unit tests
> - Add support for postcopy-blocktime
> - Update documentation
>
> Future direction:
> - Add support for hugepages
> - Add support for multifd
> - Add support for vhost-user
>
> Aadeshveer Singh (5):
>   migration: add RAM Block fields and helpers for fast snapshot load
>   migration: add support for fault thread to load pages from disk
>   migration: add eager load thread for fast snapshot load
>   migration: write up code to run fast snapshot load in
>     qemu_loadvm_state
>   migration/tests: remove capability conflict test
>     postcopy-ram+mapped-ram
>
>  include/system/ramblock.h          |   8 ++
>  migration/migration.c              |  10 +-
>  migration/migration.h              |   5 +
>  migration/options.c                |  11 +-
>  migration/options.h                |   1 +
>  migration/postcopy-ram.c           | 167 ++++++++++++++++++++++++++---
>  migration/postcopy-ram.h           |   2 +
>  migration/qemu-file.c              |  10 +-
>  migration/ram.c                    |  61 +++++++++--
>  migration/savevm.c                 |  52 ++++++++-
>  migration/savevm.h                 |   2 +
>  migration/trace-events             |   2 +
>  tests/qtest/migration/misc-tests.c |  52 ---------
>  13 files changed, 283 insertions(+), 100 deletions(-)

