Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E151606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=X/Q5YqpT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PzuWmP1X;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=myrP2KPB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zE32wgNk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTIwL-0005Ba-7T; Tue, 17 Nov 2026 08:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTIwI-0005BN-Ki
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:09:35 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTIwG-0007ch-EZ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:09:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF97622067;
 Tue, 17 Nov 2026 13:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794920969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6f3dBR1i9EMpUwR2/Gqpb5pGpNreMyLhwdkBFiaKAg=;
 b=X/Q5YqpTqANmjaeaNR++dN43MdAX5sa4k9WbqrB5QnYV9OIMRxQj/p8P54EwPZJk/FvcIz
 XhIycL3+8TKi6Wd/bfD1jjqIO2y9xp4G9A7DAKLeo+iTx3hDuzgI48t5eWrwGz0eRfuUeY
 uUDlS9ihEfGX8FmlCfmTIOQeBDa42gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794920969;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6f3dBR1i9EMpUwR2/Gqpb5pGpNreMyLhwdkBFiaKAg=;
 b=PzuWmP1XOUYJD55ZmU0HWSpSfKcQAMztvcaUFZ1ffLKefx4gymVS3JHpO9i71kWiEXOA7x
 1b9vO25ENoald+Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=myrP2KPB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zE32wgNk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794920965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6f3dBR1i9EMpUwR2/Gqpb5pGpNreMyLhwdkBFiaKAg=;
 b=myrP2KPByXuUxyvc/4HG8VrFcJ6PEN6vL33KLpXWOM9gWS2ZpCHlZ94j+zY3zgsxg5BVTq
 dPalEQVShyyiWSsozsjunIqrDJE5C1CdVCiMs4EZshdiMLlt1BsdCQAjln6V/94hl4G9Dv
 q8581NGLaBr891xuH2pQmVxSP0H7nxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794920965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6f3dBR1i9EMpUwR2/Gqpb5pGpNreMyLhwdkBFiaKAg=;
 b=zE32wgNkE+gzOTBe+PHhySaWaJNa735+FpGH9P9JAnSrlDqiu1wQyVcgRZoyzRod3eLs3g
 o4OjimkhCFBRJYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 668D11334C;
 Tue, 17 Nov 2026 13:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LC1lAAVS/Gq4ZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 13:09:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
Subject: Re: [PATCH] accel: Fix qtest deadlock during unplug
In-Reply-To: <20260918140037.3082357-1-farosas@suse.de>
References: <20260918140037.3082357-1-farosas@suse.de>
Date: Tue, 17 Nov 2026 10:09:18 -0300
Message-ID: <87pkw3siyp.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: EF97622067
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,gitlab.com:url];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email, gitlab.com:url,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.51
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fabiano Rosas <farosas@suse.de> writes:

> This is a revert of one hunk of commit d5e33b5f8f ("accel: make all
> calls to qemu_process_cpu_events look the same"). It regressed
> device-plug-test on ppc64. Run this in a loop and it deadlocks before
> 50 iterations:
>
> QTEST_QEMU_BINARY=./qemu-system-ppc64 ./tests/qtest/device-plug-test -p
> /ppc64/device-plug/spapr-cpu-unplug-request
>
> The deadlocked stacks are:
> T0:
>  #0  in sigtimedwait
>  #1  in sigwait
>  #2  in dummy_cpu_thread_fn (arg=0x558ed4db8eb0) at ../accel/dummy-cpus.c:52
>
> T1:
>  #2  in qemu_thread_join (thread=0x55e3803dfc60) at ../util/qemu-thread-posix.c:554
>  #3  in cpu_remove_sync (cpu=0x558ed4db8eb0) at ../system/cpus.c:633
>  #4  in ppc_cpu_unrealize (dev=0x558ed4db8eb0) at ../target/ppc/cpu_init.c:6967
>
> What the test does is to queue a cpu unplug request to be executed
> during system reset. So we end up with two cpu_exit() calls affecting
> the dummy loop, one via pause_all_cpus() and another via
> cpu_remove_sync().
>
> Moving qemu_process_cpu_events() to the top of the loop has made the
> release of the halt_cond + the read of cpu->unplug not happen
> atomically regarding the BQL anymore.
>
> One cpu_exit() call will cause qemu_process_cpu_events() to make
> progress, the BQL be release and the pending SIG_IPI to be consumed by
> sigwait(). But since the BQL is unlocked, the second qemu_cpu_kick()
> invocation can execute entirely while the BQL is unlocked and issue:
>
> i) another broadcast on halt_cond, which will be queued and,
> ii) another signal, which will be discarded
>
> After the sigwait() returns and qemu_process_cpu_events() executes
> again in the next loop iteration, it exits right away due to the cond
> already being posted, but the sigwait() call for that loop won't see
> any signal. The thread cannot be joined at this point so there's a
> deadlock.
>
> Since the dummy_cpu loop is so simple, I think the best way to fix
> this is to revert that part of the change and move
> qemu_process_cpu_events() back to the end of the loop, where it will
> be within the same BQL locking window as the cpu->unplug check.
>
> Fixes: d5e33b5f8f ("accel: make all calls to qemu_process_cpu_events look the same")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2861429046
> ---
>  accel/dummy-cpus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
> index 5752f6302c..225a47c31f 100644
> --- a/accel/dummy-cpus.c
> +++ b/accel/dummy-cpus.c
> @@ -43,7 +43,6 @@ static void *dummy_cpu_thread_fn(void *arg)
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      do {
> -        qemu_process_cpu_events(cpu);
>          bql_unlock();
>  #ifndef _WIN32
>          do {
> @@ -58,6 +57,7 @@ static void *dummy_cpu_thread_fn(void *arg)
>          qemu_sem_wait(&cpu->sem);
>  #endif
>          bql_lock();
> +        qemu_process_cpu_events(cpu);
>      } while (!cpu->unplug);
>  
>      bql_unlock();

Hi, this issue is still present and the discussion here has veered a bit
into future work territory. Could I get some feedback on the patch
itself?

Thanks

