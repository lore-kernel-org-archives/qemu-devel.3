Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180AAD74ED8
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHYb-000129-Dy; Fri, 23 Jan 2026 08:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHX1-0000A3-KV
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:48:59 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHX0-0006mG-4S
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:48:59 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E43885BCD4;
 Fri, 23 Jan 2026 13:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769176137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w28CAEWsXvAAbm0nHVddlPZdtpIblRtTW5ImyQzRdpE=;
 b=fu6NiluWF83/vQHwoS+HzzjwD/+SemlRRdROUf1TADwovF2Q1wG+yhKY2Q+Ct64J3uQMW9
 i5QeFG/9bF405FcrgLzCzeyhO/vdFE9c6S13+gVU0ayR9++iVuW0FgT6sdD4VnFaPifkeW
 TNONJXF0tvFoo/lEIQjOCA3YyzFmD5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769176137;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w28CAEWsXvAAbm0nHVddlPZdtpIblRtTW5ImyQzRdpE=;
 b=CLvcKBsJ9/qW/RMRonnUTs8/xCD5b1cJBbXvQcTW3iNynRZzmiUJ+8qftC56tWTm2HSMV0
 SCm1kMYbwFTAi+DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769176136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w28CAEWsXvAAbm0nHVddlPZdtpIblRtTW5ImyQzRdpE=;
 b=a0oPDrOS/Snp7k7hPU0Sm37zMyTorwzGa48NxRqK56O08oAJ5tC2TI1N+EOFWD90Sad4py
 NMJb4as+yxwiAOuj1Gxc7cnrbkkZagiUJyD/8vTzhTOpwzPMriYS7twjyZpfT9fZFjvZg6
 nDQLjMIxqv2KOWbhAFbxqojzpOAd9Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769176136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w28CAEWsXvAAbm0nHVddlPZdtpIblRtTW5ImyQzRdpE=;
 b=2BF7y8UQFleDLKEoYpk+F88gExX70ei14UWCIz6jx3q6YFsrWE10+31EHkyNxVOu28rrvc
 +s2aM4N6xxvpPxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 552481395E;
 Fri, 23 Jan 2026 13:48:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uXU+BUh8c2mefwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 13:48:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH 05/10] migration/colo: Unwrap qemu_savevm_live_state()
In-Reply-To: <20260121223336.3381912-6-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
 <20260121223336.3381912-6-peterx@redhat.com>
Date: Fri, 23 Jan 2026 10:48:53 -0300
Message-ID: <87cy30igmy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,web.de];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

Peter Xu <peterx@redhat.com> writes:

> It's only used in COLO path and only contains two calls.  Unwrap the
> function.  It paves way for further reduce special COLO paths on sync.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.h | 1 -
>  migration/colo.c   | 3 ++-
>  migration/savevm.c | 7 -------
>  3 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 5d815af742..528607f09e 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -64,7 +64,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
>                                             uint64_t *start_list,
>                                             uint64_t *length_list);
>  void qemu_savevm_send_colo_enable(QEMUFile *f);
> -void qemu_savevm_live_state(QEMUFile *f);
>  int qemu_save_device_state(QEMUFile *f);
>  
>  int qemu_loadvm_state(QEMUFile *f, Error **errp);
> diff --git a/migration/colo.c b/migration/colo.c
> index db783f6fa7..e05736ecf0 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -471,7 +471,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>       * TODO: We may need a timeout mechanism to prevent COLO process
>       * to be blocked here.
>       */
> -    qemu_savevm_live_state(s->to_dst_file);
> +    qemu_savevm_state_complete_precopy(s->to_dst_file, true);

Could maybe drop this complete from the name eventually.

> +    qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
>  
>      qemu_fflush(fb);
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f1cd8c913d..529cf310e0 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1854,13 +1854,6 @@ cleanup:
>      return ret;
>  }
>  
> -void qemu_savevm_live_state(QEMUFile *f)
> -{
> -    /* save QEMU_VM_SECTION_END section */
> -    qemu_savevm_state_complete_precopy(f, true);
> -    qemu_put_byte(f, QEMU_VM_EOF);
> -}
> -
>  /* Is a save state entry iterable (e.g. RAM)? */
>  static bool qemu_savevm_se_iterable(SaveStateEntry *se)
>  {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

