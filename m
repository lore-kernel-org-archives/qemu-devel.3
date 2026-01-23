Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281E6D7237F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGA4-0004jX-2h; Fri, 23 Jan 2026 07:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjGA2-0004f1-8k
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:21:10 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjGA0-0004z0-GQ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:21:09 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 05CB85BCCD;
 Fri, 23 Jan 2026 12:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769170865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLwZq+m5IdIPWNnlD4SufYzC1U17Ewc/DumQCLLGkUw=;
 b=AJh4bt36wtByvWbrslK8fIxho4iYH7uOTnoon5gd3AlnQnrYvuyhylH0/+uXAjy1mVuIt+
 xxsFvRYORJbucR9q8hb+7C6l7X/af+uv0z5iSYGs5flG35gw9ID8YLLtrYhPDFKJQnXe8p
 5buRCwu3jbla7OrHkH0YIoduF5g1izc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769170865;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLwZq+m5IdIPWNnlD4SufYzC1U17Ewc/DumQCLLGkUw=;
 b=mBi4g9msfVokej2EGQHJR1i7GvtwbZqxTZU+Fm3MjUPLuexe4gYU0KmsyRZTPF7TQUQOim
 g+soTEBJ2I4r/0AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1MowCCrZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MvOt3tNr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769170864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLwZq+m5IdIPWNnlD4SufYzC1U17Ewc/DumQCLLGkUw=;
 b=1MowCCrZSacy5PpqYdd+JmbwKDjDvX67FeXVLcgAE4N3x+tg07uVEkJOXvjGHvk2QnBwh6
 zHByxypyr1OfLYCbXMjg3glXbFyBLpTXYn/4Tt+svoIoUkk4s2E6QWlOgdSTE712uEK2sh
 W4lYPaj1PF/XwawIQHN1Q/6ksDy0sT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769170864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLwZq+m5IdIPWNnlD4SufYzC1U17Ewc/DumQCLLGkUw=;
 b=MvOt3tNrqfFiEymggfddknt6f9PW5jnAhSi/wo9bXoPUgHDY9MQ2QpB9R9A3pnj7uI44Gm
 aHGX6s8V/RBModAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DC57136AA;
 Fri, 23 Jan 2026 12:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l03kC69nc2mmJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 12:21:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration/options: Fix leaks in StrOrNull accessors
In-Reply-To: <CAE8KmOyAYnB8a-AsZvjCFGrX+xwbCjV3Wv2ybVLoBQu7RofOqA@mail.gmail.com>
References: <20260122232456.12722-1-farosas@suse.de>
 <CAE8KmOyAYnB8a-AsZvjCFGrX+xwbCjV3Wv2ybVLoBQu7RofOqA@mail.gmail.com>
Date: Fri, 23 Jan 2026 09:21:00 -0300
Message-ID: <87fr7wjz9v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 05CB85BCCD
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

> On Fri, 23 Jan 2026 at 04:56, Fabiano Rosas <farosas@suse.de> wrote:
>> Fix a couple of leaks detected by Coverity. Both are currently
>> harmless because the visitor in the setter can never fail and the
>> whole of the getter is unused, it's only purpose at the moment is to
>
> * unused, it's -> unused. Its
>

Thanks

>> provide a complete implementation of the StrOrNull property.
>>
>> Fixes: CID 1643919
>> Fixes: CID 1643920
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2280325023
>> ---
>>  migration/options.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/migration/options.c b/migration/options.c
>> index 9a5a39c886..9dc44a3736 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -225,6 +225,7 @@ static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
>>          str_or_null = g_new0(StrOrNull, 1);
>>          str_or_null->type = QTYPE_QSTRING;
>>          str_or_null->u.s = g_strdup("");
>> +        *ptr = str_or_null;
>>      } else {
>>          /* the setter doesn't allow QNULL */
>>          assert(str_or_null->type != QTYPE_QNULL);
>> @@ -245,6 +246,7 @@ static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
>>       */
>>      str_or_null->type = QTYPE_QSTRING;
>
> * Do we need to add:  str_or_null->u.s = g_strdup("");  here?
>

It would leak, the visitor will allocate new memory for it below.

>>      if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
>> +        qapi_free_StrOrNull(str_or_null);
>>          return;
>>      }
>>
>> --
>
> * visit_type_str() failure is handled in set_StrOrNull, but not in
> get_StrOrNull? Do we need to add qapi_free_StrOrNull(str_or_null) in
> get_StrOrNull()?
>

I'd rather leave to the caller. The errp will be set, I think it's
enough. Looking at the other instances of visit_type_str in qdev, they
all simply return without any handling. I think in practice it's
unlikely that the string visitors will ever set errp because they are
just a g_strdup() usually.

> * Otherwise it looks okay.
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
>
> Thank you.
> ---
>   - Prasad

