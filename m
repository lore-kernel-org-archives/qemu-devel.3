Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A42FC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzEEP-0007TM-R4; Mon, 31 Mar 2025 08:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzEEM-0007Sm-9F
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:27:06 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzEEJ-0005y1-A1
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:27:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4A12D21190;
 Mon, 31 Mar 2025 12:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743424008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ps66lr75Lu0yX32i/qC85f/j8bACv4FoCGsJV9mBmm4=;
 b=h4UgI2+Ws/mqX9/y6mpDusrrUlzEQ8NfYDSacdVK2cNEtb72MydHAVeCkbibJrQOfsIiQP
 TVtfhUdhaVR7if3YF6kqWJ3LYtVYJoV8TsAjqvwDdsW+k5T3PfuTPyJjR4OsLQpXvoiVSQ
 z9BnlP8hmqaHJHnT1V9SGpQs6XzhKwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743424008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ps66lr75Lu0yX32i/qC85f/j8bACv4FoCGsJV9mBmm4=;
 b=asB8nfegb6kDW4Kc+6zfQeumHxYFUYW4m6CZH5HM5OUEcSKe/w7S3dEASVKEWEhGmnkHUo
 mLT471sUoHg29YAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=h4UgI2+W;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=asB8nfeg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743424008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ps66lr75Lu0yX32i/qC85f/j8bACv4FoCGsJV9mBmm4=;
 b=h4UgI2+Ws/mqX9/y6mpDusrrUlzEQ8NfYDSacdVK2cNEtb72MydHAVeCkbibJrQOfsIiQP
 TVtfhUdhaVR7if3YF6kqWJ3LYtVYJoV8TsAjqvwDdsW+k5T3PfuTPyJjR4OsLQpXvoiVSQ
 z9BnlP8hmqaHJHnT1V9SGpQs6XzhKwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743424008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ps66lr75Lu0yX32i/qC85f/j8bACv4FoCGsJV9mBmm4=;
 b=asB8nfegb6kDW4Kc+6zfQeumHxYFUYW4m6CZH5HM5OUEcSKe/w7S3dEASVKEWEhGmnkHUo
 mLT471sUoHg29YAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B54C7139A1;
 Mon, 31 Mar 2025 12:26:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ko6WHAeK6mfgDAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 31 Mar 2025 12:26:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, Marco Cavenati
 <Marco.Cavenati@eurecom.fr>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] migration: fix SEEK_CUR offset calculation in
 qio_channel_block_seek
In-Reply-To: <a5f19b09-f222-4747-8b52-b2fd67a6832e@tls.msk.ru>
References: <20250326162230.3323199-1-Marco.Cavenati@eurecom.fr>
 <a5f19b09-f222-4747-8b52-b2fd67a6832e@tls.msk.ru>
Date: Mon, 31 Mar 2025 09:26:44 -0300
Message-ID: <871pudmlmj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4A12D21190
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Michael Tokarev <mjt@tls.msk.ru> writes:

> 26.03.2025 19:22, Marco Cavenati wrote:
>> The SEEK_CUR case in qio_channel_block_seek was incorrectly using the
>> 'whence' parameter instead of the 'offset' parameter when calculating the
>> new position.
>> 
>> Fixes: 65cf200a51ddc6d0a28ecceac30dc892233cddd7 ("migration: introduce a QIOChannel impl for BlockDriverState VMState")
>> 
>> Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
>> ---
>>   migration/channel-block.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/migration/channel-block.c b/migration/channel-block.c
>> index fff8d87094..b0477f5b6d 100644
>> --- a/migration/channel-block.c
>> +++ b/migration/channel-block.c
>> @@ -123,7 +123,7 @@ qio_channel_block_seek(QIOChannel *ioc,
>>           bioc->offset = offset;
>>           break;
>>       case SEEK_CUR:
>> -        bioc->offset += whence;
>> +        bioc->offset += offset;
>>           break;
>>       case SEEK_END:
>>           error_setg(errp, "Size of VMstate region is unknown");
>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
>
> This is a (trivial) bugfix, I'd say it should be in 10.0.
> Will you guys send a pullreq for the block layer, or should
> I make a single-patch pullreq from the trivial tree?

I'll take it. It's not entirely trivial as it shifts a value by 1 in
mapped-ram migration. Fortunately, it's a value that doesn't need to be
the same between migration source and destination.

Thanks

>
> Thanks,
>
> /mjt

