Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8104FC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 13:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl6j8-0006AP-RL; Thu, 20 Feb 2025 08:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tl6j4-0006A6-3p
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:36:26 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tl6j2-00008q-0t
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:36:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE75621182;
 Thu, 20 Feb 2025 13:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740058582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dcrNVqXIvx+qrgixaOV7/gy4eNeVuehWVeMOOgCUv1M=;
 b=BTxA1IBtduxfHei/A7CV4ZHOrV/iu2yBaSTSE4TB8REjiwDa7F6D/GRklu41NLinfy2B+F
 5rBfWRPoTQvpRncrUU3UrsPY9pKMQEhIzQ0Gnn38GARxTcFUNRHNzheWk0pg+cPVYD3D72
 T54lGOl9gX3qxFZwrtCjMwjJ1Y1HyFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740058582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dcrNVqXIvx+qrgixaOV7/gy4eNeVuehWVeMOOgCUv1M=;
 b=RfAK5r6DRUve1KXJk99Kt7gyWuBD1+4YgVqDHvQFICNg55KirVNtW64d4CQnkE+oTQ/EB5
 XGTpvWrw+92m34AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L9gqZroy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zA48Zo1m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740058580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dcrNVqXIvx+qrgixaOV7/gy4eNeVuehWVeMOOgCUv1M=;
 b=L9gqZroyzEMPs/faWgB3tMAnKACATZ8VfEeOeWiRNsjPm+1IwFz+JsrWwHrStXqnTn+vXn
 /zAEIzPJj1mz1HLUwpMY4tTN0ZWoXZ/45ZfPzZsWoZwyoiGW6wiO0/ZwwYHO4ZvoTmgO6k
 aO7PpLW3aCIALoNMhG79dxj5BariaR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740058580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dcrNVqXIvx+qrgixaOV7/gy4eNeVuehWVeMOOgCUv1M=;
 b=zA48Zo1m4DGY0ZsRcaXu7aQKJD6FBXak5AxCXlxmNIgG+vUp9PTKWtIk7T4aMhtCBNPeRd
 xO+Ygwqh+UbfdeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4635313A42;
 Thu, 20 Feb 2025 13:36:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zP9/AdQvt2fFRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 20 Feb 2025 13:36:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v6 2/4] migration: enable multifd and postcopy together
In-Reply-To: <CAE8KmOyzkLS3zvb7a32CUVJuvS-VEkZwSAfJUZwQqT-xiZLnJw@mail.gmail.com>
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-3-ppandit@redhat.com> <87y0y4tf5q.fsf@suse.de>
 <CAE8KmOxYE=10+xjMjH5ZhbMmRJHgxJKHj2wH-nB-qiBSHEVh1w@mail.gmail.com>
 <878qq39vu3.fsf@suse.de>
 <CAE8KmOyy=ybDaRFpFr0DTJWScyjCX+99PKHzLibv6zhtUpw8Ng@mail.gmail.com>
 <87r03t97ep.fsf@suse.de>
 <CAE8KmOyzkLS3zvb7a32CUVJuvS-VEkZwSAfJUZwQqT-xiZLnJw@mail.gmail.com>
Date: Thu, 20 Feb 2025 10:36:17 -0300
Message-ID: <87jz9k91ri.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: CE75621182
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hello,
>
> On Wed, 19 Feb 2025 at 22:53, Fabiano Rosas <farosas@suse.de> wrote:
>> I don't see anything stopping postcopy_start() from being called in the
>> source in relation to multifd recv threads being setup in the
>> destination. So far it seems possible that the source is opening the
>> preempt channel while multifd still hasn't seen all threads. There's
>> also pre-7.2 machines which create the postcopy channel early.
>
> * If we can not predict the sequence/timings of when different types
> of connections are initiated and processed, maybe source and
> destination QEMUs could work in tandem. ie. before initiating a
> connection, source QEMU could send an 'initiate' message saying I'm
> initiating 'X' connection. Only when destination QEMU says 'okay',
> source QEMU could proceed with actual connection.
>
>      QEMU-A  -> Initiate connection type X -> QEMU-B
>      QEMU-A  <-            okay           <-        <- QEMU-B
>      QEMU-A ->       connect type X            -> QEMU-B
>
>    (thinking out loud)
>

This is more or less the handshake idea. Or at least it could be
included in that work.

I have parked the handshake idea for now because I'm not seeing an
immediate need for it and there are more pressing issues to be dealt
with first such as bugs and coordinating the new features (and their
possible outcomings) that IMO need to be looked at first.

>>>> > * migration_needs_multiple_sockets()
>>> Then it should return 'True' when both migrate_multifd() and postcopy_preempt() are enabled.
>> Why?
>
> * I was thinking multiple_sockets is multiple types of sockets:
> multifd & postcopy. But it seems here multiple sockets is any type of
> multiple sockets.
>

Yes this means main channel + others.

>> I thought you meant the CH_MAIN stuff. So now I don't know what you
>> mean. You want to do away with multifd?
>
> * Yes, CH_DEFAULT -> CH_MAIN was introduced in this series to identify
> channels and accordingly call relevant functions.
>
> * Not to do away with multifd, but more of making it same as the main
> channel, ex: virsh migrate --threads <N> N = 1...255. All precopy
> threads/connections behave the same. Differentiation of precopy and
> postcopy shall still exist, because they operate/work in opposite
> directions.
>

I'm not opposed to that idea. When I started working with migration I
had the impression that was the direction and that we could put every
workload in a pool of multifd threads. Now, knowing the code better, I'm
not sure that's feasible. Specially the dependence on a "main" channel
seems difficult to do away with. It's also somewhat convenient to have a
maint thread. But we could still attempt to group extra threads, such as
what we're doing with the new thread pool in the device state series. At
least thread management could be done entirely in a separate pool, main
channel and all.

>> Continue with this patch and fix the stuff I mentioned. You can ignore
>> the first two paragraphs of that reply.
>>
>> https://lore.kernel.org/r/87y0y4tf5q.fsf@suse.de
>>
>> I still think we need to test that preempt + multifd scenario, but it
>> should be easy to write a test for that once the series is in more of a
>> final shape.
>
> * Okay.
>
>> We can't add magic values, as we've discussed.
>
> Okay.
>
> Thank you.
> ---
>   - Prasad

