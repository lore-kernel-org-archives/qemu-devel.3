Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C120D29FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg03a-00079s-Pd; Wed, 14 Jan 2026 07:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg02c-0006rS-JA
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:32:05 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg02b-00033e-28
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:32:02 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 644795C592;
 Wed, 14 Jan 2026 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768393919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q2AfWIqVo7aGdx+GE2Za0fR9bRM/eFz2K0zJPRqxPi0=;
 b=CFJzdfdJ9ipwgndEtqR6eoh8C0pke4BQMCDip0K33M1Q35BEJe3rS9vr/9zmDegPoU3gyA
 Tru/ecRxQbHPi6bp5bqrMKdyWbY7bpA80LxI4R9Yf1R0jdpHaAqvYkQdNlcnDj/qPnFCCg
 kSbBbBKFkx3oXdo5oiX96+TE4xC/GTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768393919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q2AfWIqVo7aGdx+GE2Za0fR9bRM/eFz2K0zJPRqxPi0=;
 b=zesiEHi9KC1whqAAJnpOIxY6I/zodnTr1NQOGVaE+W5EVhe7+tENseUE5M2mzJ2/laF1+L
 /WmW4AgQch6rmhDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CFJzdfdJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zesiEHi9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768393919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q2AfWIqVo7aGdx+GE2Za0fR9bRM/eFz2K0zJPRqxPi0=;
 b=CFJzdfdJ9ipwgndEtqR6eoh8C0pke4BQMCDip0K33M1Q35BEJe3rS9vr/9zmDegPoU3gyA
 Tru/ecRxQbHPi6bp5bqrMKdyWbY7bpA80LxI4R9Yf1R0jdpHaAqvYkQdNlcnDj/qPnFCCg
 kSbBbBKFkx3oXdo5oiX96+TE4xC/GTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768393919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q2AfWIqVo7aGdx+GE2Za0fR9bRM/eFz2K0zJPRqxPi0=;
 b=zesiEHi9KC1whqAAJnpOIxY6I/zodnTr1NQOGVaE+W5EVhe7+tENseUE5M2mzJ2/laF1+L
 /WmW4AgQch6rmhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D72023EA63;
 Wed, 14 Jan 2026 12:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nCGIJb6MZ2ncTwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Jan 2026 12:31:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, dtalexundeer@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: Re: [PATCH 3/5] qemu-file: qemu_file_get_fd(): get byte in one shot
In-Reply-To: <20260114064710.176268-4-vsementsov@yandex-team.ru>
References: <20260114064710.176268-1-vsementsov@yandex-team.ru>
 <20260114064710.176268-4-vsementsov@yandex-team.ru>
Date: Wed, 14 Jan 2026 09:31:56 -0300
Message-ID: <87sec8nznn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.74 / 50.00]; BAYES_HAM(-2.23)[96.36%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 644795C592
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> No reason to split into peek + get.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/qemu-file.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 02f30c1c21..3a9a0a49d4 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -396,8 +396,7 @@ int qemu_file_get_fd(QEMUFile *f)
>          goto fail;
>      }
>  
> -    /* Force the dummy byte and its fd passenger to appear. */
> -    qemu_peek_byte(f, 0);
> +    qemu_get_byte(f);
>  
>      fde = QTAILQ_FIRST(&f->fds);
>      if (!fde) {
> @@ -405,7 +404,6 @@ int qemu_file_get_fd(QEMUFile *f)
>          goto fail;
>      }
>  
> -    qemu_get_byte(f);       /* Drop the dummy byte */
>      fd = fde->fd;
>      QTAILQ_REMOVE(&f->fds, fde, entry);
>      g_free(fde);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

