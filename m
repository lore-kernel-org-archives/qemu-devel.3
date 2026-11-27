Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEF9606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HjyPbTQB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bmSL+OzW;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HjyPbTQB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bmSL+OzW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxiP-0007wS-Cz; Fri, 27 Nov 2026 10:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWxiM-0007tu-HE
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:18:18 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWxiK-00068v-2k
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:18:18 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 872E01FD59;
 Fri, 27 Nov 2026 15:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795792693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3eBc+As9EBKaeKFSQGIsUIENS9Jd43hkQoPAxKO1YUA=;
 b=HjyPbTQBioynMJUV4L8IBnHiKsNZBLhjjgy2QyE9qfLu/83CEwshg1IgE7uidVwVme1S52
 SLN6G02EjMuH5DEsgWWd2Y0NLXKlTF1AX9KDMjwIhlL5UaudlbO/4IyGA9QDF0iarvE584
 l4EMVcEJOKIK/0k1ZA2XgxInPW4NfaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795792693;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3eBc+As9EBKaeKFSQGIsUIENS9Jd43hkQoPAxKO1YUA=;
 b=bmSL+OzWxgoBjdB39OIOW/QqkP+fFPOWltOMKyvLi07pDwEw9QOAZTsvlTXEYE2W62+9hZ
 ds+p7zYA94OudSBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HjyPbTQB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bmSL+OzW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795792693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3eBc+As9EBKaeKFSQGIsUIENS9Jd43hkQoPAxKO1YUA=;
 b=HjyPbTQBioynMJUV4L8IBnHiKsNZBLhjjgy2QyE9qfLu/83CEwshg1IgE7uidVwVme1S52
 SLN6G02EjMuH5DEsgWWd2Y0NLXKlTF1AX9KDMjwIhlL5UaudlbO/4IyGA9QDF0iarvE584
 l4EMVcEJOKIK/0k1ZA2XgxInPW4NfaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795792693;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3eBc+As9EBKaeKFSQGIsUIENS9Jd43hkQoPAxKO1YUA=;
 b=bmSL+OzWxgoBjdB39OIOW/QqkP+fFPOWltOMKyvLi07pDwEw9QOAZTsvlTXEYE2W62+9hZ
 ds+p7zYA94OudSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F293A134E8;
 Fri, 27 Nov 2026 15:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vJ6tIjSfCWvKBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Nov 2026 15:18:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/5] migration-test: Support running a real kernel
In-Reply-To: <awmNKb0WevtA0L_L@redhat.com>
References: <20261126214704.3108327-1-farosas@suse.de>
 <awmJYLLhnMxlWhQP@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <awmNKb0WevtA0L_L@redhat.com>
Date: Fri, 27 Nov 2026 12:18:10 -0300
Message-ID: <87h5h2qp59.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Rspamd-Queue-Id: 872E01FD59
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
On Fri, Nov 27, 2026 at 08:45:04AM -0500, Peter Xu wrote:

>> On Thu, Nov 26, 2026 at 06:46:59PM -0300, Fabiano Rosas wrote:
>> > There's a class of migration performance bugs that are very specific
>> > to the internals of QEMU and most likely require work on our side, but
>> > are currently invisible to our testing because migration-test runs a
>> > simple guest workload (not even that, really). The more important ones
>> > are BQL contention issues that result in vcpu starvation.
>> >=20
>> > My plan is to incrementally add some pieces to migration-test to
>> > reduce that testing gap.
>> >=20
>> > The first piece is adding support for running a kernel + initrd inside
>> > the guest which gives us an easy way to start exercising migration of
>> > a more loaded guest that can already cause VM exits.
>> >=20
>> > This series adds support for -kernel and -initrd arguments to
>> > migration-test and runs the same set of tests we currently have, but
>> > with the kernel instead of the custom loop. By default it uses the
>> > initrd from tests/migration-stress/ which runs a read-write loop over
>> > all memory and has customizable vcpu and memory size.
>>=20
> The whole thing sounds useful, I'll read into details after I flush more =
of
> the older patches.. which will take some time (it also depends on if next
> week I got some more urgent task "injected"..).
>=20

Take your time. I just need to put these out sooner rather than later
because my internal branch is growing too big and I need feedback from
the list before I get too deep.

The hugepages series will come probably sometime next week and then I'll
give you a break while I work on other stuff.
---

> One high level question: this will grow qtest closer to what the
> functional test is doing.  Have you thought of the relationship
> between the two, after we move qtest more over there?

I'm not sure what "move" you mean. Are we porting tests to python? I'm
definitely open to discussion, whatever it is.

> I assumed not, based on what you mentioned
> in the rest part of cover letter that you planned to have it only for dev
> debug purpose.  But still, we'll start to ask the question to ourselves at
> some point, IIUC.  So I ask first. :)

I'm simply going through the path which I see is of least
resistance. These additions are simple enough. Importantly: with this
series we would be adding a different workload to the guest, but it
still runs all the existing migration-tests.

The same with the hugepages support, it's just another mem_type. For
this to work with the functional tests we'd need to either duplicate the
migration-tests there or write new tests. And we'd isolate the existing
tests entirely from these new features.

E.g.: I want to work on the migration performance around dirty log
disabling, it performs worse when hugepages are enabled, it may trigger
softlockups in the guest and it only happens when migration is aborted.

The /migration/cancel/src/after/ tests can already exercise that path,
work well and have caught bugs before. It just need hugepages and a
kernel:

args->mem_type=3DMEM_TYPE_HUGE=20

MIG_KERNEL=3Dvmlinuz \=20
HUGEPAGES=3D/dev/hugepages/... \
migration-test -p .../cancel/src/after

>
> In terms of the boundary between functional tests and qtests, I
> think the guidance is in the names.
>
> If it is a "qtest" test then it should be primarily making use
> of QTest to interrogate the QEMU internalprocess state.
>

Hm, quite arbitrary. A "qtest" is a test that uses QTest, ok, but we can
do whatever kind of testing we want with it. If we want to stick to any
formal definition, that is. I'm not sure we need to.

> If it is a "functional"  test, then it is interested in running
> real kernels & real accelerators and validating the behaviour of
> QEMU via its external mgmt interfaces.
>
> By this definition, IMHO, the migration-test would be a functional
> test, if it were created from scratch to.
>

By any other definition it already is a functional test.

I'm maybe being too literal. What I think you're trying to indicate
(maybe Peter as well), is that we should preferably group the functional
tests under tests/functional and migration-test.c is more functional
test than anything else, so it should be in there as well. Except that
since migration-test is written in a different programming language, we
would have to leave migration-test.c as is and write new migration tests
under tests/functional.

> It only uses libqtest.h APIs for the purpose of sending QMP
> commands, not examining internal device state. Essentially it is a
> historical accident that it is written as a qtest instead of a
> functional test, as that was the best choice at the time.
>

It uses qtest_read* to validate the guest memory, that was probably the
reason, no?

I also don't understand whatever happened to the whole QGraph/QOS thing,
which, by initial commits seemed it had been written explicitly to
support live migration testing.

