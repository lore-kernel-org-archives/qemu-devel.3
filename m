Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9966CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 13:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQQEg-0007gO-V4; Fri, 22 May 2026 09:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wQQEf-0007g2-2T
 for qemu-devel@nongnu.org; Fri, 22 May 2026 09:48:21 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wQQEd-0007FW-EF
 for qemu-devel@nongnu.org; Fri, 22 May 2026 09:48:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D85D966EBC;
 Fri, 22 May 2026 13:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779457695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFbsxQaeTumRrQCoK0lvv7gWPkPMOXM4Ke8vssSSTe4=;
 b=GeAgFrbgGaE+tIZL+BjqxjbJ7YwDw9NhIYu2tdXSKI/esWiimh9u3uwvfMb+f/4JFtktyp
 iHJJpBCitNc5J7QhK7AeS9YNUXci4n+pceAXmu+64/LGoUKwVx/3D//Zf//VTBPAmvWkHx
 VpPSksuFxG3YR5I5wLlVL64TJMd/l14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779457695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFbsxQaeTumRrQCoK0lvv7gWPkPMOXM4Ke8vssSSTe4=;
 b=7oCh3YtOQx1+x9qSL1+nB5L1/DlgeE/f1/EuHrGo4qK/2+Gjul59gQrrZew6SzlLb0iHYN
 0W52nymZbaFg1TBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OXizzVnZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XdzG9mVe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779457694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFbsxQaeTumRrQCoK0lvv7gWPkPMOXM4Ke8vssSSTe4=;
 b=OXizzVnZmjXhnTj9D7q7vNkiJmwfEmmUcKjfjW/YhyaFqwoQAVgCW45FZS/KGxeQ7KMs9P
 jM/q9JRwioeeKSD9E+oVsptmS0MZxi6Zfj3il7GjOTFWFT9/RGsLqqrq0ll0Dv28dW/0Mw
 LD9aVSntM/OyLpEXTUCKUCUZzstlRJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779457694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFbsxQaeTumRrQCoK0lvv7gWPkPMOXM4Ke8vssSSTe4=;
 b=XdzG9mVeEVROG4i+fPbsI72kuPpVVfu3TAXAqPRy6xNrUJBNv4IIBqdCvNR8xGyj0o4R5z
 s1rNHXh2VHIwvfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78061593A8;
 Fri, 22 May 2026 13:48:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HuRSEp5eEGoPRQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 22 May 2026 13:48:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] thread-pool: Allow at least 1 thread in
 thread_pool_adjust_max_threads_to_work()
In-Reply-To: <b76c763f576b0fb8a35960a8e3c3da59701d2a74.1779390317.git.maciej.szmigiero@oracle.com>
References: <b76c763f576b0fb8a35960a8e3c3da59701d2a74.1779390317.git.maciej.szmigiero@oracle.com>
Date: Fri, 22 May 2026 10:48:12 -0300
Message-ID: <87mrxr5zdv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D85D966EBC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.46 / 50.00]; BAYES_HAM(-2.95)[99.79%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,oracle.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,szmigiero.name:email,oracle.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> thread_pool_adjust_max_threads_to_work() is supposed to give each task its
> own thread by setting the pool max thread count limit accordingly.
>
> However, if there aren't any tasks currently in the pool the pool max
> thread count will be set to 0, which will trigger an assertion failure
> in thread_pool_set_max_threads() - because setting this value would
> completely block the pool by not allowing it to process any submitted
> tasks.
>
> This also can happen if a task is submitted via
> thread_pool_submit_immediate() to an empty pool but the task completes so
> quickly that by the time this function calls
> thread_pool_adjust_max_threads_to_work() the pool again has no unfinished
> tasks in it.
>
> Fix this by making sure that the pool is allowed to create at least 1
> thread.
>
> Fixes: b5aa74968b27 ("thread-pool: Implement generic (non-AIO) pool support")
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  util/thread-pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index 8f8cb38d5ce0..4e75191c983e 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -493,5 +493,5 @@ bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool)
>  {
>      QEMU_LOCK_GUARD(&pool->cur_work_lock);
>  
> -    return thread_pool_set_max_threads(pool, pool->cur_work);
> +    return thread_pool_set_max_threads(pool, MAX(pool->cur_work, 1));
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

