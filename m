Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4CB606A334
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VscYAZAJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z8l8/D1w;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zS44YQkB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hQRNBcYH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNlz-00046U-2r; Tue, 17 Nov 2026 13:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTNlx-000465-LC
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:19:13 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTNlw-0002NN-0Y
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:19:13 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 29EDA1F7B7;
 Tue, 17 Nov 2026 18:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794939550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hlav4QP/rfy69zGzfH3MUALxy4iGQTUSCsDGefJA3gM=;
 b=VscYAZAJ60HmjY5CVNiKNK6GsL+NzbkkwBzt9OA2YM45c6xjg1hO9gv4sGyBZj28R4vtww
 6IX0kS+gPIactVJ3A5By6yRpd6zSr6dgJzOJU/lxh5kgtV/aQsE9jXVmhyiQ/81sqiE619
 Xh1cQlVCbyFKcLC9Y6J0gQ3pjN5ni4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794939550;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hlav4QP/rfy69zGzfH3MUALxy4iGQTUSCsDGefJA3gM=;
 b=Z8l8/D1wO/GnNSDVI3sad3lGkbi48EZOG/Ulmqrak/GAo504jhaWIZ4wJYIV78EnpA0IqF
 vhMYTqCW+ekFcgDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794939549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hlav4QP/rfy69zGzfH3MUALxy4iGQTUSCsDGefJA3gM=;
 b=zS44YQkBkEJ3Ubd0WstV1JBMaoAN0+aSSGJb6g1ZAAbPeXl3IGgALdcgIkkrgPeW3zK+IS
 aXZW3QGiVxPSG20hV1bNQCNlm7xGdY6Bm3bKzCYVLzabWm7yTR4gpduK88M4YHEHt9oveS
 FDCQ6rZj62iGHl9NGPeCvXM7hg3NtEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794939549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hlav4QP/rfy69zGzfH3MUALxy4iGQTUSCsDGefJA3gM=;
 b=hQRNBcYH2xDaeM/Ve96vYnnkZ6IznPwLH0bCHm7FZ7ScLLkvsEduNTITQA2gMNRFp2D9ct
 Td5EA8InCQ22/7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A4B613302;
 Tue, 17 Nov 2026 18:19:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ff8uCZya/Gq1LgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 18:19:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Zhao Liu <zhao1.liu@intel.com>, =?utf-8?Q?Dani?=
 =?utf-8?Q?el_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?utf-8?Q?Marc-A?=
 =?utf-8?Q?ndr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 06/10] oslib: report each thread's program counter
In-Reply-To: <20260915203455.580999-7-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-7-den@openvz.org>
Date: Tue, 17 Nov 2026 15:19:06 -0300
Message-ID: <87eccjs4md.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[openvz.org:email, imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Denis V. Lunev" <den@openvz.org> writes:

> From: Denis V. Lunev <den@openvz.org>
>
> A kernel stack describes a thread asleep in a syscall and says nothing
> about one spinning in userspace, which is the other way a thread stops
> making progress.
>
> Ask each thread where it is by signalling it and reading the program
> counter out of the signal frame. That is a register read and a store,
> which a handler may do, unlike unwinding: backtrace() is not async
> signal safe and takes the loader lock the first time it runs.
>
> Ask all of them at once, once every passive read is taken. The signal
> interrupts whatever a thread was blocked in, so probing earlier would
> make the kernel stack and the wait channel describe the interruption
> instead of the hang, and probing one at a time would spend the timeout
> again for every thread that never answers. Insert the answers from the
> back, so the offsets recorded during the reads still point where they
> did.
>
> A thread that never answers within the deadline can still run the
> handler later, once whatever held it lets go, and by then the slots it
> would write to are gone.

Is this situation worth logging? Some "thread X got released" warning.


