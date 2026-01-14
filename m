Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370B7D29FF8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfzoA-0006X2-Co; Wed, 14 Jan 2026 07:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfznJ-0006Cu-Ut
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:16:27 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfznD-0004hC-Hj
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:16:10 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA7D45C4CD;
 Wed, 14 Jan 2026 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768392965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l1fFmJgpaAB+DKo6mZ8K6IFohrorf/I+DKJKu0qCovo=;
 b=hn09Ds6nYJvtDGUH8WVVoY70Q6AH1+NPa2CBS6cz+lnaw+KxoDG1AEFO8G+jFc3+6H/5p6
 DTH7TtuIt5kbiPu2ms3TD+wmxlH7ebblnqpjuXWrUAWqPTDG+Ra1IVbnlIPekDm95rrlfE
 PjbQMPk/YfvbfxFaXKnbWiMFsNl6QwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768392965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l1fFmJgpaAB+DKo6mZ8K6IFohrorf/I+DKJKu0qCovo=;
 b=gRZXZvKZJifg8VC2UUQcVN+VL2KVbC7nyL1Z2SR3q8PupiG9mLS624IkgQjyTQ9aizWTvg
 4YPlGp+AczNp2RDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hn09Ds6n;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gRZXZvKZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768392965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l1fFmJgpaAB+DKo6mZ8K6IFohrorf/I+DKJKu0qCovo=;
 b=hn09Ds6nYJvtDGUH8WVVoY70Q6AH1+NPa2CBS6cz+lnaw+KxoDG1AEFO8G+jFc3+6H/5p6
 DTH7TtuIt5kbiPu2ms3TD+wmxlH7ebblnqpjuXWrUAWqPTDG+Ra1IVbnlIPekDm95rrlfE
 PjbQMPk/YfvbfxFaXKnbWiMFsNl6QwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768392965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l1fFmJgpaAB+DKo6mZ8K6IFohrorf/I+DKJKu0qCovo=;
 b=gRZXZvKZJifg8VC2UUQcVN+VL2KVbC7nyL1Z2SR3q8PupiG9mLS624IkgQjyTQ9aizWTvg
 4YPlGp+AczNp2RDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A3673EA63;
 Wed, 14 Jan 2026 12:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZDPWNgSJZ2nyPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Jan 2026 12:16:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
In-Reply-To: <CAE8KmOw+g3gZYJfay=9gwkhtkviA_K9BapfmJBhD+BzTCcxLxg@mail.gmail.com>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de> <aUq1oA73W9rAdCgG@x1.local>
 <CAE8KmOzcOdYhnxpDr8BMV8zjixpEh9r+COe=xyLfXCVWKD0CRw@mail.gmail.com>
 <87zf6q26q5.fsf@suse.de>
 <CAE8KmOzxDn7X7rohJGT5AeW3+5oJFgueVtaQCpUc2bmBvrgRXg@mail.gmail.com>
 <874ioxzhcm.fsf@suse.de>
 <CAE8KmOx0ikDueu-znY14RCmp6weX_G+CJMUrQOmOuv-OPwPR+Q@mail.gmail.com>
 <87y0m2zkc3.fsf@suse.de>
 <CAE8KmOw+g3gZYJfay=9gwkhtkviA_K9BapfmJBhD+BzTCcxLxg@mail.gmail.com>
Date: Wed, 14 Jan 2026 09:16:02 -0300
Message-ID: <871pjspeyl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AA7D45C4CD
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Tue, 13 Jan 2026 at 01:15, Fabiano Rosas <farosas@suse.de> wrote:
>> There are failures that happen _because_ we cancelled. As I've mentioned
>> somewhere else before, the cancellation is not "informed" to all threads
>> running migration code, there are some code paths that will simply fail
>> as a result of migration_cancel(). We need to allow cancelling to work
>> in a possibly stuck thread (such as a blocked recv in the return path),
>> but this means we end up calling qemu_file_shutdown indiscriminately.
>> In these cases, parts of the code would set FAILED, but that failure is
>> a result of cancelling. We've determined that migrate-cancel should
>> always lead to CANCELLED and a new migration should always be possible.
>
> * I see.
>
>> This is ok, call it an error and done.
>>
>> > OTOH, if we cancel while processing an error/failure, end user
>> > may not see that error because we report - migration was cancelled.
>> >
>>
>> This is interesting, I _think_ it wouldn't be possible to cancel while
>> handling an error due to BQL locked, the migrate-cancel wouldn't be
>> issued while migration_cleanup is ongoing. However, I don't think we ever
>> tested this scenario in particular. Maybe you could try to catch
>> something by modifying the /migration/cancel tests, if you're willing.
>
> * I have made a note of looking at it at a later time.
>
>> Aside from the QAPI states, there are some internal states we already
>> track with separate flags, e.g.:
>>
>> rp_thread_created, start_postcopy, migration_thread_running,
>> switchover_acked, postcopy_package_loaded, fault_thread_quit,
>> preempt_thread_status, load_threads_abort.
>>
>> A bit array could maybe cover all of these and more.
>>
>> ---
>>
>> You could send a PoC patch with your idea fixing this FAILING bug? We'd
>> need a trigger for migrate, set_caps, etc and the failed event.
>>
>> If that new patch doesn't get consensus then we merge this one and work
>> on a new design as time permits.
>
> * Considering the above wider coverage area, I think it is best to
> first fix the issue at hand and then move to this new change. For now
> I'll try to rebase my current patch on your v3: cleanup early
> connection code series. Once that is through, I'll take the states
> change patch. Hope that's okay.
>

Ok, go ahead.

> Thank you.
> ---
>   - Prasad

