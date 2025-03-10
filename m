Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EEFC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 14:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tre3V-0004wl-Pt; Mon, 10 Mar 2025 10:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tre3U-0004wN-IC
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:24:32 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tre3N-0007iQ-C0
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:24:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1F841F387;
 Mon, 10 Mar 2025 14:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741616660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gf77IGRQ6gyiVaXeBNXa17pRaxN5fR8O4bX9mXRfyGg=;
 b=aAIQv8gGIY/isSrBAmcEyq4b+xsknUewrTrXiEQp4WUoCj9CT79vIJlaUo/GKe2RsSZTP9
 IRPgB2BE/y9XH5GgD+NBHSHzguMb791Voci9cfRF/CgwzC9DX/B8pa7+bujFhzKxY8XPkb
 wuYUZ5/aLG1xGOB/cskF/Ypc7sB+AKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741616660;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gf77IGRQ6gyiVaXeBNXa17pRaxN5fR8O4bX9mXRfyGg=;
 b=AHCj3VPWYcvdKjbIJ9zNQ1ahzdHdK65ylkft0OJV+nWGK3EHGIymv4h6GzbCj9OJGltomX
 aXDYjTbdpKjEknDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZStpUi0P;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7YdCCwr1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741616658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gf77IGRQ6gyiVaXeBNXa17pRaxN5fR8O4bX9mXRfyGg=;
 b=ZStpUi0PGP5PjuDT+IXufDeFcjl8uMH71a2jGyGGfyb5V8B+dTRfQBwGzGcGCNOd8rXlCI
 dHfdAeXQaNJr7ORcEW4EQZiGPxquA5NbLutmuDy+CPcU4lPjq3KM+WsAA8TKV8h3oDZKxm
 t65er69D9NGGsqhrMDnTqwGibiIRkf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741616658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gf77IGRQ6gyiVaXeBNXa17pRaxN5fR8O4bX9mXRfyGg=;
 b=7YdCCwr1F6tVe1YF+DejRRpi4EwriZBaze9O3OBzAtboI+rxCmXd0gYXipC5ro0+cOlJy5
 sCNWywvJ6+9J2PAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68FE9139E7;
 Mon, 10 Mar 2025 14:24:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q5yaCRL2zmerNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 10 Mar 2025 14:24:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration: Add some documentation for multifd
In-Reply-To: <Z8tv53G5s9MLYv6f@x1.local>
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-2-farosas@suse.de> <Z8ssc0NETt9KJjTG@x1.local>
 <87tt84u0d2.fsf@suse.de> <Z8tv53G5s9MLYv6f@x1.local>
Date: Mon, 10 Mar 2025 11:24:15 -0300
Message-ID: <87o6y9t14g.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: F1F841F387
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,sched.com:url,huawei.com:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Fri, Mar 07, 2025 at 04:06:17PM -0300, Fabiano Rosas wrote:
>> > I never tried vsock, would it be used in any use case?
>> >
>> 
>> I don't know, I'm going by what's in the code.
>> 
>> > It seems to be introduced by accident in 72a8192e225cea, but I'm not sure.
>> > Maybe there's something I missed.
>> 
>> The code was always had some variation of:
>> 
>> static bool transport_supports_multi_channels(SocketAddress *saddr)
>> {
>>     return strstart(uri, "tcp:", NULL) || strstart(uri, "unix:", NULL) ||
>>            strstart(uri, "vsock:", NULL);
>> }
>> 
>> Introduced by b7acd65707 ("migration: allow multifd for socket protocol
>> only").
>
> Looks like a copy-paste error..  I found it, should be 9ba3b2baa1
> ("migration: add vsock as data channel support").
>
> https://lore.kernel.org/all/2bc0e226-ee71-330a-1bcd-bd9d097509bc@huawei.com/
> https://kvmforum2019.sched.com/event/Tmzh/zero-next-generation-virtualization-platform-for-huawei-cloud-jinsong-liu-zhichao-huang-huawei
> https://e.huawei.com/sa/material/event/HC/e37b9c4c33e14e869bb1183fab468fed
>

Great, thanks for finding those. I'll add it to my little "lore"
folder. This kind of information is always good to know.

> So if I read it right.. the VM in this case is inside a container or
> something, then it talks to an "agent" on a PCIe device which understands
> virtio-vsock protocol.  So maybe vsock just performs better than other ways
> to dig that tunnel for the container.
>
> In that case, mentioning vsock is at least ok.
>
> [...]
>
>> >> +After the channels have been put into a wait state by the sync
>> >> +functions, the client code may continue to transmit additional data by
>> >> +issuing ``multifd_send()`` once again.
>> >> +
>> >> +Note:
>> >> +
>> >> +- the RAM migration does, effectively, a global synchronization by
>> >> +  chaining a call to ``multifd_send_sync_main()`` with the emission of a
>> >> +  flag on the main migration channel (``RAM_SAVE_FLAG_MULTIFD_FLUSH``)
>> >
>> > ... or RAM_SAVE_FLAG_EOS ... depending on the machine type.
>> >
>> 
>> Eh.. big compatibility mess. I rather not mention it.
>
> It's not strictly a compatibility mess.  IIUC, it was used to be designed
> to always work with EOS.  I think at that time Juan was still focused on
> making it work and not whole perf tunings, but then we found it can be a
> major perf issue if we flush too soon.  Then if we flush it once per round,
> it may not always pair with a EOS.  That's why we needed a new message.
>

Being fully honest, at the time I got the impression the situation was
"random person inside RH decided to measure performance of random thing
and upstream maintainer felt pressure to push a fix".

Whether that was the case or not, it doesn't matter now, but we can't
deny that this _has_ generated some headache, just look at how many
issues arose from the introduction of that flag.

> But hey, you're writting a doc that helps everyone.  You deserve to decide
> whether you like to mention it or not on this one. :)

My rant aside, I really want to avoid any readers having to think too
much about this flush thing. We're already seeing some confusion when
discussing it with Prasad in the other thread. The code itself and the
git log are more reliable to explain the compat situation IMO.

>
> IIRC we updated our compat rule so we maintain each machine type for only 6
> years.  It means the whole per-iteration + EOS stuff can be removed in 3.5
> years or so - we did that work in July 2022.  So it isn't that important
> either to mention indeed.
>

Yep, that as well.

>> 
>> > Maybe we should also add a sentence on the relationship of
>> > MULTIFD_FLAG_SYNC and RAM_SAVE_FLAG_MULTIFD_FLUSH (or RAM_SAVE_FLAG_EOS ),
>> > in that they should always be sent together, and only if so would it
>> > provide ordering of multifd messages and what happens in the main migration
>> > thread.
>> >
>> 
>> The problem is that RAM_SAVE_FLAGs are a ram.c thing. In theory the need
>> for RAM_SAVE_FLAG_MULTIFD_FLUSH is just because the RAM migration is
>> driven by the source machine by the flags that are put on the
>> stream. IOW, this is a RAM migration design, not a multifd design. The
>> multifd design is (could be, we decide) that once sync packets are sent,
>> _something_ must do the following:
>> 
>>     for (i = 0; i < thread_count; i++) {
>>         trace_multifd_recv_sync_main_wait(i);
>>         qemu_sem_wait(&multifd_recv_state->sem_sync);
>>     }
>> 
>> ... which is already part of multifd_recv_sync_main(), but that just
>> _happens to be_ called by ram.c when it sees the
>> RAM_SAVE_FLAG_MULTIFD_FLUSH flag on the stream, that's not a multifd
>> design requirement. The ram.c code could for instance do the sync when
>> some QEMU_VM_SECTION_EOS (or whatever it's called) appears.
>
> I still think it should be done in RAM code only.  One major goal (if not
> the only goal..) is it wants to order different versions of pages and
> that's only what the RAM module is about, not migration in general.
>
> From that POV, having a QEMU_VM_* is kind of the wrong layer - they should
> work for migration in general.
>
> Said so, I agree we do violate it from time to time, for example, we have a
> bunch of subcmds (MIG_CMD_POSTCOPY*) just for postcopy, which is under
> QEMU_VM_COMMAND.  But IIUC that was either kind of ancient (so we need to
> stick with them now.. postcopy was there for 10 years) or it needs some
> ping-pong messages in which case QEMU_VM_COMMAND is the easiest.. IMHO we
> should still try to stick with the layering if possible.

All good points, but I was talking of something else:

I was just throwing an example of how it could be done differently to
make the point clear that the recv_sync has nothing to do with the ram
flag, that's just implementation detail. I was thinking specifically
about the multifd+postcopy work where we might need syncs but there is
no RAM_FLAGS there.

We don't actually _need_ to sync with the migration thread on the
destination like that. The client could send control information in it's
opaque packet (instead of in the migration thread) or in a completely
separate channel if it wanted. That sync is also not necessary if there
is no dependency around the data being transferred (i.e. mapped-ram just
takes data form the file and writes to guest memory)

To be clear I'm not suggesting we change anything, I'm only trying to
reflect in the docs some level of separation between multifd.c and ram.c
(or whatever else) because we've seen that mixing the two makes the
design less clean. We've already cleared much of the "p->pages" kind of
issues and the packet definition is more versatile after Maciej's work,
but I still think the separation should be more strict (hence all the
"client" talk in this doc).

(I realise I'm hijacking the documentation thread to talk about high
level design, my apologies).

