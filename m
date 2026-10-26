Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A6606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jebU6uRM;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Psh60bbC;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tV0wBGIZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EQcqUn2s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLRqF-00028R-I9; Mon, 26 Oct 2026 17:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1xLRqD-00027x-D2; Mon, 26 Oct 2026 17:02:49 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1xLRqA-0004pk-JE; Mon, 26 Oct 2026 17:02:49 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7FE4E22124;
 Mon, 26 Oct 2026 21:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793048562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vF/1BOUXatDELo21OIW5VThMGNaOhzvFhUi9cc6/DIk=;
 b=jebU6uRMSVMyQzuKesgdfz7qiJDLNfiVYeOIkO8SwBUFvxkLwhIVhYr1K54EunGm7g+2EL
 oNslYVpvLNxhlit64BGJzTQs+Ome+GfZ17f/6PT/F3XtdEXJFM16txg7cg71qdBB5AJ1XV
 oAPjsNf/4oqyKob5aGukYsY1nUqODl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793048562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vF/1BOUXatDELo21OIW5VThMGNaOhzvFhUi9cc6/DIk=;
 b=Psh60bbCYT4kVycf9YrpGvAb69rvhkoLXjm+DBDdMOxul9jCh9w+bK5L0FWGv3tKW43mHJ
 F2Ijr+f4SVx7isDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793048561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vF/1BOUXatDELo21OIW5VThMGNaOhzvFhUi9cc6/DIk=;
 b=tV0wBGIZ7Y3z3QSK8yofa3iRE1t0oKfmTPH2prEx/18iP7BqhMy29hLtW0oX6qfrvyWGw1
 9OGxm6Fj2EPhIIWAayOa5wt8rczAix8hlp4080uBSGb6FeT+zad+5/Vbs83oc8x/4+fGMi
 0SF9MGybAtAvlEUjD8evv1+7ZYywfAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793048561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vF/1BOUXatDELo21OIW5VThMGNaOhzvFhUi9cc6/DIk=;
 b=EQcqUn2sb94sMGAVRLuoou2XbPB5crqMM8Yw8gjp4DBJCT2FPX8T+HST+0VJEn4RX0lW4f
 /dtm/Gak5MmR1MAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D264413319;
 Mon, 26 Oct 2026 21:02:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vKcDHfC/32rSUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Oct 2026 21:02:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Elliot Berman
 <elliotjb+anduril@elliotjb.com>, qemu-devel@nongnu.org, Peter Xu
 <peterx@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] hw/block/pflash: invalidate TBs on flash update
In-Reply-To: <f54905bf-8641-4554-ac44-6d526266876c@oss.qualcomm.com>
References: <20261016-pflash-update-invalidate-tbs-v1-1-3cf1ecaa76bc@elliotjb.com>
 <f54905bf-8641-4554-ac44-6d526266876c@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 18:02:34 -0300
Message-ID: <87wlr4jhud.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TAGGED_RCPT(0.00)[anduril];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 qualcomm.com:email]
X-Spam-Score: -11.80
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> Hi Elliot,
>
> On 16/10/26 21:15, Elliot Berman wrote:
>> When pflash_cfi01/02 are out of Read Array mode and being reprogrammed
>> or erased (such as a firmware update) by a guest under TCG, TBs from
>> when the guest was executing instructions from the pflash are never
>> invalidated. After re-enabling Read Array, the guest continues to
>> execute instructions from the stale TBs.
>>=20
>> Call memory_region_flush_rom_device() from pflash_update() so the TBs
>> over the updated range are invalidated.
>>=20
>> memory_region_flush_rom_device() asserted that the memory region was in
>> romd_mode (i.e. Read Array mode), but the pflash is not in romd_mode
>> when processing MemoryRegionOps->write() commands. Since the RAM can
>> change even when !romd_mode, relax the assertion so it only checks
>> rom_device.
>>=20
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4490
>> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Elliot Berman <elliotjb+anduril@elliotjb.com>
>> ---
>>   hw/block/pflash_cfi01.c | 5 ++++-
>>   hw/block/pflash_cfi02.c | 3 +++
>>   system/physmem.c        | 2 +-
>>   3 files changed, 8 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 486fc6350d..66ecdb0969 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -388,12 +388,15 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwad=
dr offset,
>>       return ret;
>>   }
>>=20=20=20
>> -/* update flash content on disk */
>> +/* update flash content on disk and invalidate the guest view of RAM */
>
>   /*
>    * Flush modified flash content: mark the range dirty, invalidate the
>    * TBs translated from it, and write it back to the block backend.
>    */
>
>>   static void pflash_update(PFlashCFI01 *pfl, int offset,
>>                             int size)
>>   {
>>       int offset_end;
>>       int ret;
>> +
>> +    memory_region_flush_rom_device(&pfl->mem, offset, size);
>> +
>>       if (pfl->blk) {
>>           offset_end =3D offset + size;
>>           /* widen to sector boundaries */
>
> I'd like feedback from migration maintainers: could we be writing
> staled content during live migration? Or maybe we are already safe.
> invalidate_and_set_dirty() gets DIRTY_MEMORY_MIGRATION set via the
> memory_region_get_dirty_log_mask call. Hmm so this change also fixes
> migration then. If confirmed, worth mentioning in the patch description:
>
>
>    Direct writes to the flash RAM were not marked dirty for migration,
>    so pages reprogrammed during pre-copy were not re-sent, and
>    postload_update_cb() wrote the stale content to the block backend.
>    The memory_region_flush_rom_device() call now also fixes this.
>

Yes, this does seem to be the case. I couldn't find any path where the
writes from pflash_write() are invalidated.


