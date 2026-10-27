Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05601606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ejBZCDrh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bSi0UIPz;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NAsIt3DG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7SCOg3u4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLgKM-0002ha-Pl; Tue, 27 Oct 2026 08:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xLgKL-0002hE-6D
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:30:53 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xLgKJ-0002JX-GU
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:30:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9F84421F3F;
 Tue, 27 Oct 2026 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793104250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJYTWW9ySfgHPwEvrJ2GoSbDWprqBgLS4eh/IwHmdDU=;
 b=ejBZCDrhFNegIMPGWtS78bxT8BeuRLlvRrSp/zqbqxJ7EUQ62UAATp/miJWQu4I4WiQO7z
 XoJ7ZLYwac1C3MLSSB3s3wmN0Nm6E/jRpIE+JiQCQYF0npHd/guEiY9MOoLJCwB7AotuWr
 /qavCineOQTcpTPDohWaOQ4sYeHQQ+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793104250;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJYTWW9ySfgHPwEvrJ2GoSbDWprqBgLS4eh/IwHmdDU=;
 b=bSi0UIPzy8PdA9EkMZRONcpvD4EVsQsVON2jPs8scdJB/hiHL1prmN/8/ZjwSIAiDBCDIj
 LGl4lw5sS0d4c4Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NAsIt3DG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7SCOg3u4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793104248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJYTWW9ySfgHPwEvrJ2GoSbDWprqBgLS4eh/IwHmdDU=;
 b=NAsIt3DG4nBSvOEwP//mMowXXN1bHEQ34mBdYacALPDDCF1718TfifwctqmZtrZDDaD1hU
 0AV184YjEyeJySoiO0962lcFI5TubYPw+wMrWjXl6NKF8ygDK82hZOV+rmjgUIA75dhmL2
 3MG6IK09Oafk1hZVOv9Kvg04/rw32fA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793104248;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJYTWW9ySfgHPwEvrJ2GoSbDWprqBgLS4eh/IwHmdDU=;
 b=7SCOg3u428LhuNrRq+85crh4B4GkIeU++p6K1EVMqjxHXAqSBGrLaHcv3/9uzGZqr99y0R
 r32h/QHjd53evEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 215901321C;
 Tue, 27 Oct 2026 12:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Sx0cLneZ4GoqDwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 Oct 2026 12:30:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] qtest: Remove 256 IRQ limit on irq intercepts
In-Reply-To: <20261026125655.2668658-1-peter.maydell@linaro.org>
References: <20261026125655.2668658-1-peter.maydell@linaro.org>
Date: Tue, 27 Oct 2026 09:30:41 -0300
Message-ID: <87ld7jjpfy.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,linaro.org:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Rspamd-Queue-Id: 9F84421F3F
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Maydell <peter.maydell@linaro.org> writes:

> Currently both system/qtest.c and libqtest have a 256 IRQ limit
> on the size of an irq_intercept_in. If you try it with more then
> qtest.c will overrun its array, and libqtest will trip an assert.
> We have some real devices in board models that use more inbound
> IRQs than this (e.g. the GIC in the Arm virt board).
>
> This series removes both the fixed-sized arrays, so there's
> no artificial limit on how many GPIO lines we can cope with.
> I also fix in patch 2 a bug I noticed while doing this, where
> we don't check the GPIO group name for irq_intercept_in, so
> we apply the intercept to every input GPIO group the device
> has rather than only to the unnamed GPIO inputs.
>
> I haven't bothered to cc:stable on these because we don't
> trip over the limit for any of our existing qtests, though
> I don't anticipate there being any issues with the backport.
>
> thanks
> -- PMM
>
> Peter Maydell (3):
>   system/qtest: Avoid fixed-size irq_levels array for IRQ intercept
>   system/qtest: Check ngl->name for irq_intercept_in
>   tests/qtest/libqtest: Use a GArray for QTestState::irq_level[]
>
>  system/qtest.c         | 47 +++++++++++++++++++++++++++++-------------
>  tests/qtest/libqtest.c | 28 ++++++++++++-------------
>  2 files changed, 47 insertions(+), 28 deletions(-)

Queued, thanks.

