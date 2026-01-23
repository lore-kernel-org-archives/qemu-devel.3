Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB4AD74EDA
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHt1-0003fl-1l; Fri, 23 Jan 2026 09:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHsL-0002p2-TA
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:11:03 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHsK-0002nv-38
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:11:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DE37233809;
 Fri, 23 Jan 2026 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769177458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oeaqfEpFLnCAsxUZJ4dZ+z2NiGFWDN517jou1adReWQ=;
 b=ZDRURObnzWEVjpyv5cx5LavAqqn3nb5QcB1QUyd0zMf/XhZ1KNGdx3Rk26vWI+/tpKcw/X
 lpK8qT7VlNQ8lleL0y/hC2SnslC76TISCxjfeUETnSdC9Fc+eTOidy/+PLrW+aoqDZGPSg
 C+POTIxDleTqm49e5yBgVHaoldIrPkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769177458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oeaqfEpFLnCAsxUZJ4dZ+z2NiGFWDN517jou1adReWQ=;
 b=dJtp9WJMJZKF0BL7QCyR3xFeev3MeOd6F/SAL5+QrWtZV8AMyxqcXHroQVDFayhBHqsYk5
 8rnemp798/9r9+Ag==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uryXtPii;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GvWZWBCL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769177457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oeaqfEpFLnCAsxUZJ4dZ+z2NiGFWDN517jou1adReWQ=;
 b=uryXtPiiVWgdDqk4E9sRmXFz4Td/V44Ja0jYu1l/rN6iI7RVtQ7AEcWCVEYiDtsNrKVL5q
 HFVmsEuvYcp7JaoKqzoTrqtDYe9MxaCm4/kpFwtYIQ7+huu5DtlHdH7ZFKwjmyTUg1XBmA
 V4xG7uH60TQ3iY+evCrM4zKUHsHxVjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769177457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oeaqfEpFLnCAsxUZJ4dZ+z2NiGFWDN517jou1adReWQ=;
 b=GvWZWBCLaz/jBrNjz4iU35UAyLjFth0AdB6YFNSFHWnc67vZqiBv6UUoUx6SzS4Bze70kD
 Kn5rPgboRzJSDSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 532691395E;
 Fri, 23 Jan 2026 14:10:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pdE0BXGBc2kCFwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 14:10:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH 09/10] migration/colo: Move qemu_fflush() closer to its
 user for fb
In-Reply-To: <20260121223336.3381912-10-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
 <20260121223336.3381912-10-peterx@redhat.com>
Date: Fri, 23 Jan 2026 11:10:54 -0300
Message-ID: <871pjgifm9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[web.de];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DE37233809
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

> COLO caches all device states in a buffer channel `fb'.  Flush it right
> before pushing the buffer to make sure everything needed will be flushed,
> add a comment explaning it.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/colo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index f92803dd29..e2307f1907 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -472,8 +472,6 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>      qemu_savevm_state_complete_precopy_iterable(s->to_dst_file, false);
>      qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
>  
> -    qemu_fflush(fb);
> -
>      /*
>       * We need the size of the VMstate data in Secondary side,
>       * With which we can decide how much data should be read.
> @@ -484,6 +482,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>          goto out;
>      }
>  
> +    /* Flush to make sure everything lands bioc->data */
> +    qemu_fflush(fb);
>      qemu_put_buffer(s->to_dst_file, bioc->data, bioc->usage);
>      ret = qemu_fflush(s->to_dst_file);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

Wait, aren't we wasting a memcpy here? Isn't this the same, but without
the copy of bioc->data to s->to_dst_file->buf:

qemu_fflush(fb);                                        // ensure bioc->data is populated
qemu_fflush(s->to_dst_file);                            // send buffered data from migration stream
qemu_put_buffer_async(s->to_dst_file, bioc->data, ...); // point s->to_dst_file->iov to bioc->data
qemu_fflush(s->to_dst_file);                            // send s->to_dst_file->iov contents

>      if (ret < 0) {

