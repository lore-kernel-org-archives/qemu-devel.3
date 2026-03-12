Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145EC1067038
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 14:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0gpN-0004FU-CB; Thu, 12 Mar 2026 10:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0gpK-0004F4-BF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:15:51 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0gpI-0005O8-Ex
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:15:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B97375BCCA;
 Thu, 12 Mar 2026 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773324946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awvffkyqIimVaSjjWIvkUuZ+0tnQKdyQs4bNFb37EQA=;
 b=y92SN5JO/wvzDKYffKoJ1PZ3XZ3KSlAdy9HZzaKkPXaJspBXPCdCQY5Gy9e7kcm7U0VqUK
 hpSFlskiuqQpPyyBJTsp8rza9sti9W4Kl6qAF5eZvFi+T4y181S96DCqRbmKFPRCRrDknK
 Zbc3PgkkZeHSllxZK0X+017fKj1D/HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773324946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awvffkyqIimVaSjjWIvkUuZ+0tnQKdyQs4bNFb37EQA=;
 b=2LkPeBNLZDoh5t8VQZO9/NtbPzUwP8+A1328gj1O5qbQWc2Sq3EpZxv59pavplrylXjZz6
 Xu44F2uyXL2yY7AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y92SN5JO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2LkPeBNL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773324946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awvffkyqIimVaSjjWIvkUuZ+0tnQKdyQs4bNFb37EQA=;
 b=y92SN5JO/wvzDKYffKoJ1PZ3XZ3KSlAdy9HZzaKkPXaJspBXPCdCQY5Gy9e7kcm7U0VqUK
 hpSFlskiuqQpPyyBJTsp8rza9sti9W4Kl6qAF5eZvFi+T4y181S96DCqRbmKFPRCRrDknK
 Zbc3PgkkZeHSllxZK0X+017fKj1D/HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773324946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awvffkyqIimVaSjjWIvkUuZ+0tnQKdyQs4bNFb37EQA=;
 b=2LkPeBNLZDoh5t8VQZO9/NtbPzUwP8+A1328gj1O5qbQWc2Sq3EpZxv59pavplrylXjZz6
 Xu44F2uyXL2yY7AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 444853FFEA;
 Thu, 12 Mar 2026 14:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PAZHA5LKsmm2aAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Mar 2026 14:15:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Alexandr
 Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3] vmstate: fix subsection load name check
In-Reply-To: <c38f6c8d-1f10-427e-bf38-23cb282f5370@yandex-team.ru>
References: <20260312102626.891359-1-dtalexundeer@yandex-team.ru>
 <c38f6c8d-1f10-427e-bf38-23cb282f5370@yandex-team.ru>
Date: Thu, 12 Mar 2026 11:15:43 -0300
Message-ID: <875x71yvzk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_EQ_ADDR_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yandex-team.ru:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B97375BCCA
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 12.03.26 13:26, Alexandr Moshkov wrote:
>> When loading a subset, its name is checked for the parent prefix. The
>> following bug may occur here:
>> 
>> Let's say there is a vmstate named "virtio-blk", it has a subsection
>> named "virtio-blk/subsection", and it also has another vmstate named
>> "virtio" in the fields.
>> Then, during the migration, when trying to load this subsection for
>> "virtio", the prefix condition will pass for "virtio-blk/subsection" and
>> then the migration will break, because this vmstate does not have such a
>> subsection.
>> 
>> In other words, if a field inside vmstate1 is set via vmstate2 with a
>> name that is a prefix of the parent vmstate, then the field can "steal"
>> a subsection belonging to the parent state.
>> 
>> Looks like it happens because migration stream for "virtio-blk" looks
>> like this:
>> 
>>   [virtio-blk header] [virtio-blk fields] [virtio-blk subsections]
>> 
>> "virtio-blk" contains "virtio" field, so migration stream is:
>> 
>>   [virtio-blk header] [virtio header] [virtio fields] [virtio
>> subsections] [virtio-blk subsections]
>> 
>> And when we load the subsections of the "virtio" device,
>> vmstate_subsection_load() uses qemu_peek_byte() to try to figure out if
>> this is his subsection. This is where we encounter an error.
>> 
>> Thus, the error occurs due to the fact that vmsd does not know how many
>> subsections it has when loading (this does not appear anywhere in the
>> migration stream), so it tries to load all the appropriate ones by
>> names.
>> 
>> To fix this issue, we call vmstate_get_subsection() and, in case of
>> fail, ignore it, pop the VMSD stack and will try to define this
>> subsection for outer VMSD
>> 
>> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>> ---
>>   migration/vmstate.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>> 
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index 4d28364f7b..8f3a69c26e 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -639,9 +639,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>
> more contex:
>
>          if (strncmp(vmsd->name, idstr, strlen(vmsd->name)) != 0) {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(prefix)");
>              /* it doesn't have a valid subsection name */
>              return 0;
>          }
>
> If go this way, I think this check for prefix ^^^ should be removed.
>

+1


