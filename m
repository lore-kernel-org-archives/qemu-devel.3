Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1094C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0KHr-0001N0-Ed; Thu, 03 Apr 2025 09:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u0KHp-0001Mh-IG
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:07:13 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u0KHn-0005T4-Ks
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:07:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B9E721180;
 Thu,  3 Apr 2025 13:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743685629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1iuQSaorUWabAgc6jDeLPIp1/uUYmPqoK+E2pdwgDEo=;
 b=vsuq3rvM6cAEihUHjdqCQnfDUzRZOqKCL3nFXFLF2b4OoNgUcY1wekFeDn+CW0V9V64tB0
 HVnb3bUb0G1yU4WfbZB23uxspllMkcqAVkEXZpAxWoZa6pO7Ka3TjurxXArY++HVcEvaBu
 ZjuiFYJon7KWswRDIoM1BxRcHXNWA7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743685629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1iuQSaorUWabAgc6jDeLPIp1/uUYmPqoK+E2pdwgDEo=;
 b=207CdiegPooCFCMoIgPpQyyIqXPAYf3ImTlQrUkgNwJyYAEtArQEritCvftbqkzkA4E7q+
 mC5OpFOvxb8SiHDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vsuq3rvM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=207Cdieg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743685629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1iuQSaorUWabAgc6jDeLPIp1/uUYmPqoK+E2pdwgDEo=;
 b=vsuq3rvM6cAEihUHjdqCQnfDUzRZOqKCL3nFXFLF2b4OoNgUcY1wekFeDn+CW0V9V64tB0
 HVnb3bUb0G1yU4WfbZB23uxspllMkcqAVkEXZpAxWoZa6pO7Ka3TjurxXArY++HVcEvaBu
 ZjuiFYJon7KWswRDIoM1BxRcHXNWA7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743685629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1iuQSaorUWabAgc6jDeLPIp1/uUYmPqoK+E2pdwgDEo=;
 b=207CdiegPooCFCMoIgPpQyyIqXPAYf3ImTlQrUkgNwJyYAEtArQEritCvftbqkzkA4E7q+
 mC5OpFOvxb8SiHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE6F613A2C;
 Thu,  3 Apr 2025 13:07:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yoDpHvyH7mcIOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Apr 2025 13:07:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v8 7/7] migration/ram: Implement save_postcopy_prepare()
In-Reply-To: <CAE8KmOwiFtQHpUWJE9aYcH2e8__nBjD8rp5vnWCd66wjy7e90Q@mail.gmail.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <20250318123846.1370312-8-ppandit@redhat.com> <87semtkz32.fsf@suse.de>
 <CAE8KmOwiFtQHpUWJE9aYcH2e8__nBjD8rp5vnWCd66wjy7e90Q@mail.gmail.com>
Date: Thu, 03 Apr 2025 10:07:05 -0300
Message-ID: <8734epl7gm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 5B9E721180
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[4];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hi,
>
> On Mon, 31 Mar 2025 at 20:49, Fabiano Rosas <farosas@suse.de> wrote:
>> > +static bool ram_save_postcopy_prepare(QEMUFile *f, void *opaque, Error **errp)
>> > +{
>> > +    int ret;
>> > +
>> > +    if (migrate_multifd()) {
>> > +        /*
>> > +         * When multifd is enabled, source QEMU needs to make sure all the
>> > +         * pages queued before postcopy starts to be flushed.
>>
>> s/to be/have been/
>>
>> > +         *
>> > +         * Meanwhile, the load of these pages must happen before switching
>>
>> s/Meanwhile,//
>>
>> > +         * to postcopy.  It's because loading of guest pages (so far) in
>> > +         * multifd recv threads is still non-atomic, so the load cannot
>> > +         * happen with vCPUs running on destination side.
>> > +         *
>> > +         * This flush and sync will guarantee those pages loaded _before_
>>
>> s/loaded/are loaded/
>>
>> > +         * postcopy starts on destination. The rational is, this happens
>>
>> s/rational/rationale/
>>
>> > +         * before VM stops (and before source QEMU sends all the rest of
>> > +         * the postcopy messages).  So when the destination QEMU received
>> > +         * the postcopy messages, it must have received the sync message on
>> > +         * the main channel (either RAM_SAVE_FLAG_MULTIFD_FLUSH, or
>> > +         * RAM_SAVE_FLAG_EOS), and such message should have guaranteed all
>> > +         * previous guest pages queued in the multifd channels to be
>> > +         * completely loaded.
>> > +         */
>
> * I'll include the above suggested corrections. I'm thinking it might
> help more to have such an explanatory comment at the definition of the
> multifd_ram_flush_and_sync() routine. Because looking at that function
> it is not clear how 'MULTIFD_SYNC_ALL' is used. It sets the
> '->pending_sync' to MULTIFD_SYNC_CALL. And when '->pending_sync' is
> set this way, multifd_send_thread() writes 'MULTIFD_FLAG_SYNC' on each
> multifd channel. At the destination this 'MULTIFD_FLAG_SYNC' flag is
> then used to sync main and multifd_recv threads.
>
> ...wdyt?

The code assumes some understanding of the multifd sync in general. It
doesn't help that we don't have a high level documentation for that
(yet). If you think the comments at the MultiFDSyncReq are not enough,
feel free to propose a separate patch adding documentation to
multifd_ram_flush_and_sync().

>
> Thank you.
> ---
>   - Prasad

