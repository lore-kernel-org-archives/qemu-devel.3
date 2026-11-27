Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6B3606A329
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WdzT+qPs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Uj3Pw/Sa;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WdzT+qPs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Uj3Pw/Sa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwpC-0008LQ-IK; Fri, 27 Nov 2026 09:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWwp9-0008F0-Jh
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:21:15 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWwp7-0003j2-VS
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:21:15 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DB391F443;
 Fri, 27 Nov 2026 14:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795789272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oDOGEiNUVlEkt+3Uzrag/96aB5decPwC1I5b/hUoryo=;
 b=WdzT+qPs+sQJcShdOJgt0TTHTq89dB8AGSshzGmLMW1qwNiOH0I9Tez3tqFtwV9lYBOQkT
 mWPA3YnDa9l93EpTu5rN7I3Gi0/ofTUZ//FsAYMe6CgGcgnroDPARN0tI9jpjordX6sO6u
 tEasdy49hTr7THVdmUvHh5LV68RQ8Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795789272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oDOGEiNUVlEkt+3Uzrag/96aB5decPwC1I5b/hUoryo=;
 b=Uj3Pw/SaeqcA0BQPvwP2XSBgVsyTNQcT2EX6sujB+1G+DgCGj4NdP272XZ5+tKV1vB2AHB
 l8Uh9nmI9PmBufAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WdzT+qPs;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Uj3Pw/Sa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795789272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oDOGEiNUVlEkt+3Uzrag/96aB5decPwC1I5b/hUoryo=;
 b=WdzT+qPs+sQJcShdOJgt0TTHTq89dB8AGSshzGmLMW1qwNiOH0I9Tez3tqFtwV9lYBOQkT
 mWPA3YnDa9l93EpTu5rN7I3Gi0/ofTUZ//FsAYMe6CgGcgnroDPARN0tI9jpjordX6sO6u
 tEasdy49hTr7THVdmUvHh5LV68RQ8Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795789272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oDOGEiNUVlEkt+3Uzrag/96aB5decPwC1I5b/hUoryo=;
 b=Uj3Pw/SaeqcA0BQPvwP2XSBgVsyTNQcT2EX6sujB+1G+DgCGj4NdP272XZ5+tKV1vB2AHB
 l8Uh9nmI9PmBufAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B04A13432;
 Fri, 27 Nov 2026 14:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +vhYCdeRCWuhSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Nov 2026 14:21:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/2] migration: fix a source hang on cancel before the
 channel connects
In-Reply-To: <awmFhmY655FPdXI8@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261125193102.1423555-1-den@openvz.org> <878q2gsdak.fsf@suse.de>
 <6314eded-6904-4722-92f8-8db90cc4688b@virtuozzo.com>
 <8733snslnt.fsf@suse.de>
 <awiJUEoMb3WxUjPo@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87y0afqoho.fsf@suse.de>
 <awl2GemtkJBdjcXk@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87v75iqw0h.fsf@suse.de>
 <awmFhmY655FPdXI8@zhexu-thinkpadt14gen5.rmtcaon.csb>
Date: Fri, 27 Nov 2026 11:21:08 -0300
Message-ID: <87jylyqrsb.fsf@suse.de>
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
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Rspamd-Queue-Id: 1DB391F443
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Nov 27, 2026 at 09:49:50AM -0300, Fabiano Rosas wrote:
>> >> One of the cancel tests issues migrate_cancel(to), that puts the error
>> >> in s->error and since QEMU keeps running, a subsequent migration
>> >> crashes. We free the error at migrate_init() and migrate_prepare() for
>> >> similar reasons I think.
>> >
>> > But this is migrate_incoming, which means if something got wrong, instead
>> > of retrying, we should kill the qemu and re-initiate?  I don't know if we
>> > could have other loopholes on this path to be invoked more than once.. as I
>> > never expected it to run twice (either success and take over, or halted for
>> > query error only, or killed).
>> >
>> 
>> I think this is only about calling cancel _without_ any migration:
>> 
>> $ (echo "migrate_cancel"; echo "quit") | ~/qemu-system-x86_64 -S -monitor stdio -incoming defer -trace migration_cancel
>> QEMU 11.1.92 monitor - type 'help' for more information
>> (qemu) migrate_cancel
>> migration_cancel 
>> (qemu) quit
>> migration_cancel
>> 
>> So a state check in there could be good enough.
>
> Ouch, so it runs through even without migration? :(
>
> If the "state check" you mentioned means failing migrate_cancel() when
> !migration_is_running(), I definitely agree.

Are there any consequences for the user in failing the command? We could
also simply skip.

I'll pickup patch 2 from Denis and put into a series along with this^
check.

