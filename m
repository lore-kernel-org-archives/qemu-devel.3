Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3AAD65C7B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 17:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVusk-0000V1-I6; Wed, 17 Dec 2025 12:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVusW-0000UE-6i
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 11:59:56 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVusT-0001fG-Av
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 11:59:55 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A45B33694;
 Wed, 17 Dec 2025 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765990789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4XUA67siRWR15aB5YkCMdFPh8NMD2GQhrC1v53DIWY=;
 b=mhoIQ8Ihi3i/cokbwAzH9T9kxvlAY9HVQtAaGIhMEEflGp2aerYSMYGdV7+2Aa0vvyNJb6
 +ie/qKH26R9fSb+sctaAvfmq1eWALPQJhGoZSeqU2LBeSzLVPIF3xHkQQAcXCI+DZsg/65
 zNBd7JHc6Zyo/JoLsz3MzO7VIZ7m0Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765990789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4XUA67siRWR15aB5YkCMdFPh8NMD2GQhrC1v53DIWY=;
 b=8Qrbv1NU6FQYUFbga28OISxtp2+mGzNGQ0mERQ033a+Sn+u+CLy4huYyO8lMKANA+SXnfG
 hLdgfe20Xf2GncAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FNd4GOs7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FN1Du1cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765990788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4XUA67siRWR15aB5YkCMdFPh8NMD2GQhrC1v53DIWY=;
 b=FNd4GOs7RiOTxKyEGRtNWuCTXjSt5fFzXfJ970ojk1ec9Acp4bPh0nCaLhAEUw2N6mD7Pt
 qgN7fwccZ84gvZ3vXx+jo0Blo+qLsdvgTQ63MND0ZS0V+rzSoAbzuGU95lI8A9mMlo6c6A
 TjW0UQkWFhDnwBOpfcgJYj+91a8X1QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765990788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s4XUA67siRWR15aB5YkCMdFPh8NMD2GQhrC1v53DIWY=;
 b=FN1Du1cnrjyfCAftYH4uBjI82rPT4I1IM0uhPg6Rqq6vekLkGMaAuwcJZFozao6eIP0X2v
 UYUvjx1orVhwzTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8D143EA63;
 Wed, 17 Dec 2025 16:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZY5RKYPhQmnkGQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Dec 2025 16:59:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 27/51] tests/qtest/migration: Fix misuse of listen_uri
In-Reply-To: <aULMlFMCcGXWVEjd@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-28-farosas@suse.de> <aULMlFMCcGXWVEjd@x1.local>
Date: Wed, 17 Dec 2025 13:59:45 -0300
Message-ID: <87h5tp11tq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 7A45B33694
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Dec 15, 2025 at 07:00:13PM -0300, Fabiano Rosas wrote:
>> The listen_uri parameter is supposed to be used for the incoming
>> migration while connect_uri for the outgoing migration. This is well
>> documented in the header file.
>> 
>> However, due to -incoming "defer", some tests set listen-uri =
>> "defer", which is fine. But then, being without another parameter to
>> define the uri to be use in migrate_incoming, some tests have been
>> misusing connect_uri.
>> 
>> Add a separate flag to denote "defer" and spare the tests from passing
>> the string. Change the usage of listen_uri to it's original purpose.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration/compression-tests.c | 12 +++----
>>  tests/qtest/migration/cpr-tests.c         | 17 +++++++---
>>  tests/qtest/migration/file-tests.c        | 38 ++++++++++++++++-------
>>  tests/qtest/migration/framework.c         | 12 +++----
>>  tests/qtest/migration/framework.h         |  7 +++++
>>  tests/qtest/migration/misc-tests.c        |  4 +--
>>  tests/qtest/migration/precopy-tests.c     | 26 ++++++++++------
>>  tests/qtest/migration/tls-tests.c         | 16 +++++-----
>>  8 files changed, 85 insertions(+), 47 deletions(-)
>
> Makes sense.
>
> But there's one missing?  I'm staring at a tree where wholeset applied, I
> can still see:
>
> static void test_mode_exec(char *name, MigrateCommon *args)
> {
>     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
>                                            FILE_TEST_FILENAME);
>     g_autofree char *listen_uri = g_strdup_printf("defer"); <-------------
>

Missed that one.

>     args->connect_uri = uri;
>     args->listen_uri = listen_uri;
>     ...
> }
>
> The other question is, after this patch, can we assume connect_uri and
> listen_uri should always be the same?  Can we merge the two already into
> "uri"?
>

Yes, because the tests run on the same machine, so the endpoint is
always the same. I don't think we do any tricks of making them mismatch
just to see it burn. It could be useful for testing maybe, or not. I'll
check and if they're indeed always the same I can merge them, it would
clarify the code a lot.

> For the latter - not a request to do it in this series, I suggest we land
> this series without keep growing, or you'll have endless pain rebasing..
> However no hurt to discuss the next step so you can send them afterwards if
> you see fit.


