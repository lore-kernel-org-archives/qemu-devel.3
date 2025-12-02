Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01399CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 13:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQQqc-0003xk-WC; Tue, 02 Dec 2025 08:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vQQqc-0003xM-9o
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:55:18 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vQQqZ-00038g-H2
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:55:17 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3650B336C8;
 Tue,  2 Dec 2025 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764683709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2+TxJBKM5wt77Bdyf5gbISIquXOagx5At2SN2KYxzX0=;
 b=QN1FWiiNs2OzSMZInbMRXMWZ6Jt3jKzA/HPAHBUtRmfXyjGwaWeNWzFaVb+8IviPikrh5X
 kQnhn1HPODEbGxScJRk9HB0WfJRPLBXkyqTv1UAr+HVRikQg4It08Tn9tPY8obR2q39KGy
 nSZSfX6wN1bYrDH2nfUoO2mWXOUYFr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764683709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2+TxJBKM5wt77Bdyf5gbISIquXOagx5At2SN2KYxzX0=;
 b=DcuvMNuNsfW60Dy0LShfnvw+8EYE48ppqveIELC714X/Hh2yy3a1AcMw7WhTKWb1qVZoXi
 oHaCShfV780ADwAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Mz1glClG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ohr4BFF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764683708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2+TxJBKM5wt77Bdyf5gbISIquXOagx5At2SN2KYxzX0=;
 b=Mz1glClGHqmo/pviqIW6dNs5Z9GGfgDINejooaCQAWmXNWZpfpgQG+lPMl6/DXwj8DY8rd
 BzZvewPVDICGuvU2nClditSUKcWuvPg11zD2UgfLQf+WlFI1hw5qbhYleNO/r56zcczFZT
 In47hYJiBDx0uHHJX1WOUkwysVGxR/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764683708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2+TxJBKM5wt77Bdyf5gbISIquXOagx5At2SN2KYxzX0=;
 b=Ohr4BFF9OMjkGvraoCfWj28Q8fVzPlewlFn3RuqdDSjxMxFxZMlm7nq2ZnEV+xT3iRDbin
 43uLORXZCJG4g9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A73A83EA63;
 Tue,  2 Dec 2025 13:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uwreGLvvLmnlVwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 02 Dec 2025 13:55:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH for-11.0 v2 0/7] migration: Error reporting cleanups
In-Reply-To: <20251201194510.1121221-1-peterx@redhat.com>
References: <20251201194510.1121221-1-peterx@redhat.com>
Date: Tue, 02 Dec 2025 10:55:04 -0300
Message-ID: <877bv5aszr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3650B336C8
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

> Based-on: <20251125070554.2256181-1-armbru@redhat.com>
>
> This series is based on Markus's recent fix:
>
> [PATCH] migration: Fix double-free on error path
> https://lore.kernel.org/r/20251125070554.2256181-1-armbru@redhat.com
>
> v2:
> - Added R-bs
> - Patch 1:
>   - update commit message on s/accidentally merged/merged without proper
>     review/ [Markus]
> - Patch 2:
>   - Added a new follow up patch here from Markus to poison Error's autoptr
> - Patch 3:
>   - Rename migration_connect_set_error to migration_connect_error_propagate
>     [Markus]
>   - Add comments in commit log for both migrate_connect() and the rename
>     [Markus]
> - Patch 4:
>   - Rename multifd_send_set_error to multifd_send_error_propagate [Markus]
> - Patch 6:
>   - Make migrate_error_propagate() take MigrationState* as before [Markus]
>   - Remove the one use case of g_clear_pointer() [Markus]
>   - Touch up commit message for the change
>
> This series should address the issues discussed in this thread here:
>
> https://lore.kernel.org/r/871plmk1bc.fsf@pond.sub.org

Thank you Markus for this. It's very helpful to have someone keeping us
in check regarding the usage of generic QEMU interfaces. Migration code
tends to drift incredibly..

>
> The problem is Error is not a good candidate of g_autoptr, however the
> cleanup function was merged without enough review.  Luckily, we only have
> two users so far (after Markus's patch above lands).  This series removes
> the last two in migration code and reverts the auto cleanup function for
> Error.  Instead, poison the auto cleanup function.
>
> When at it, it'll also change migrate_set_error() to start taking ownership
> of errors, just like what most error APIs do.  When at it, it is renamed to
> migrate_error_propagate() to imply migration version of error_propagate().
>
> Comments welcomed, thanks.
>

I think with this series we could now work to reduce the complexity of
migration_connect():

The outgoing code in socket.c and tls.c could call
migration_connect_error_propagate directly so migration_channel_connect
only needs to check migrate_has_error() and then exit as early as
possible. From migration_connect onwards we can assume connection
success.

What do you think?

tangent:
(is it too much bikeshedding if I send a patch doing s/migrat*_/mig_/
all over the place? it's so annoying having to check the code to get the
prefix correct when writing emails)


