Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F39606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xVyIFXhi;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HxCK0SNU;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xVyIFXhi;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HxCK0SNU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1RR-0006XK-Gz; Fri, 27 Nov 2026 14:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xX1QB-0005Do-SN
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 14:15:50 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xX1Q9-0002e5-Dt
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 14:15:47 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C5F51F7BF;
 Fri, 27 Nov 2026 19:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795806943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BGry1CutMnt6Z+gYxvavsropaS2qkixE6ZiSmiRAU9A=;
 b=xVyIFXhiCZctmfY6z2BnSzRssBIV1EE2CMrm3mnEjkqF/o7drpxA1eogUphde4bASlK6nr
 lCFqzb4GfUmEybIFoSdLzcGTbW1TAa9RtelU6JfI4AEz35HkZNpQkCX+PY7O/KcTmn0506
 meeWJJa1uCb2e8LEFgeHO0KeS/Bl6lA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795806943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BGry1CutMnt6Z+gYxvavsropaS2qkixE6ZiSmiRAU9A=;
 b=HxCK0SNUJVUNZ72IkgKt0zcmFAXdgYplpGLmivn2M+se9I36q3N2Y0zQyT2SMd0mItnY4j
 8a0ChScw4q2vbvCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xVyIFXhi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HxCK0SNU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795806943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BGry1CutMnt6Z+gYxvavsropaS2qkixE6ZiSmiRAU9A=;
 b=xVyIFXhiCZctmfY6z2BnSzRssBIV1EE2CMrm3mnEjkqF/o7drpxA1eogUphde4bASlK6nr
 lCFqzb4GfUmEybIFoSdLzcGTbW1TAa9RtelU6JfI4AEz35HkZNpQkCX+PY7O/KcTmn0506
 meeWJJa1uCb2e8LEFgeHO0KeS/Bl6lA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795806943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BGry1CutMnt6Z+gYxvavsropaS2qkixE6ZiSmiRAU9A=;
 b=HxCK0SNUJVUNZ72IkgKt0zcmFAXdgYplpGLmivn2M+se9I36q3N2Y0zQyT2SMd0mItnY4j
 8a0ChScw4q2vbvCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E88F413432;
 Fri, 27 Nov 2026 19:15:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id esY1IN7WCWvedwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Nov 2026 19:15:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/5] migration-test: Support running a real kernel
In-Reply-To: <awmbT3VAyPdCYkdO@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261126214704.3108327-1-farosas@suse.de>
 <awmJYLLhnMxlWhQP@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <awmNKb0WevtA0L_L@redhat.com>
 <awmbT3VAyPdCYkdO@zhexu-thinkpadt14gen5.rmtcaon.csb>
Date: Fri, 27 Nov 2026 16:15:40 -0300
Message-ID: <87cxrqqe5f.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-14.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -14.51
X-Rspamd-Queue-Id: 7C5F51F7BF
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Nov 27, 2026 at 02:01:13PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Nov 27, 2026 at 08:45:04AM -0500, Peter Xu wrote:
>> > On Thu, Nov 26, 2026 at 06:46:59PM -0300, Fabiano Rosas wrote:
>> > > There's a class of migration performance bugs that are very specific
>> > > to the internals of QEMU and most likely require work on our side, b=
ut
>> > > are currently invisible to our testing because migration-test runs a
>> > > simple guest workload (not even that, really). The more important on=
es
>> > > are BQL contention issues that result in vcpu starvation.
>> > >=20
>> > > My plan is to incrementally add some pieces to migration-test to
>> > > reduce that testing gap.
>> > >=20
>> > > The first piece is adding support for running a kernel + initrd insi=
de
>> > > the guest which gives us an easy way to start exercising migration of
>> > > a more loaded guest that can already cause VM exits.
>> > >=20
>> > > This series adds support for -kernel and -initrd arguments to
>> > > migration-test and runs the same set of tests we currently have, but
>> > > with the kernel instead of the custom loop. By default it uses the
>> > > initrd from tests/migration-stress/ which runs a read-write loop over
>> > > all memory and has customizable vcpu and memory size.
>> >=20
>> > The whole thing sounds useful, I'll read into details after I flush mo=
re of
>> > the older patches.. which will take some time (it also depends on if n=
ext
>> > week I got some more urgent task "injected"..).
>> >=20
>> > One high level question: this will grow qtest closer to what the funct=
ional
>> > test is doing.  Have you thought of the relationship between the two, =
after
>> > we move qtest more over there?  I assumed not, based on what you menti=
oned
>> > in the rest part of cover letter that you planned to have it only for =
dev
>> > debug purpose.  But still, we'll start to ask the question to ourselve=
s at
>> > some point, IIUC.  So I ask first. :)
>>=20
>> In terms of the boundary between functional tests and qtests, I
>> think the guidance is in the names.
>>=20
>> If it is a "qtest" test then it should be primarily making use
>> of QTest to interrogate the QEMU internalprocess state.
>>=20
>> If it is a "functional"  test, then it is interested in running
>> real kernels & real accelerators and validating the behaviour of
>> QEMU via its external mgmt interfaces.
>>=20
>> By this definition, IMHO, the migration-test would be a functional
>> test, if it were created from scratch to.
>
> True.
>
>>=20
>> It only uses libqtest.h APIs for the purpose of sending QMP
>> commands, not examining internal device state. Essentially it is a
>> historical accident that it is written as a qtest instead of a
>> functional test, as that was the best choice at the time.
>
> Yes, I didn't try to measure functional tests, but I think qtest is good
> choice even for now being very fast.
>

Come on, it's a good choice because it exists. Look at the amount of
stuff we test in migration-test.c.

> Then the question is similar, where we will have two functional tests for
> migration, and we'll at some point think about what we do when they start
> to overlap (perhaps, already).

We could have avoided putting ourselves in this situation if we had
agreed upfront on what the plan would be. We had 3 or 4 useless tests in
avocado that could have just been dropped back then and now we'd have
only one test-suite for migration functional testing. People insisted
anyway and now: ooops, duplicated effort! =3D)

Unfortunately, I get the short end of the stick because instead of
implementing some custom solution downstream I decided to use the
upstream code for my testing.

Do we want to centralize on the python code? Let's decide one way or
another. I promise I won't complain after the fact.

- We could freeze migration-test.c now and declare new tests go to
  either qos, functional or unit only.

- Or keep migration-test.c as a suite for testing subsystem core
  features only (the various capabilities, dirty tracking, etc.) and
  unless a new feature comes up, tests go in functional/.

- Or something else...

I'm about to start some work on vmstate-static-checker.py now that
Pierrick provided us with the infra to build every QEMU version in a
container, so it's an opportune time.

Don't forget that once the AI gates fully open we'll probably get a
flood of new tests, it would be good to have a single message.

