Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B6606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vkefr1cn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ESlKwPh1;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vkefr1cn;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ESlKwPh1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiFd-00041q-UT; Tue, 27 Oct 2026 10:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xLiFX-0003jl-5s
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:34:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xLiFV-0005S4-0c
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:34:02 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45D5D21EF8;
 Tue, 27 Oct 2026 14:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793111635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEk9WIh5Iy+lfOG/19TWBUIfrzqv+7Z+A0UdIPk8wNw=;
 b=vkefr1cnIlBOciha3LmCj43SJJKA9iaBNZXqO42O9hC14hBqu0Bf8Fy1eOrAkRCXI4ZsXt
 1uEEm3sXdAcKNrJhsVPWBr6dxAAWuDoSfOl/cL3z2SgWYhfcsAQxJu1n35glpaZ0yU931W
 rw1RqaSoBeEp0UXa64bZUJMaXk411UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793111635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEk9WIh5Iy+lfOG/19TWBUIfrzqv+7Z+A0UdIPk8wNw=;
 b=ESlKwPh1bn5kwIRwp0EzWaakZWVPdlK3aKPKt1khrqmR5tPLZ2FHrQbQFmypWQLRn4ZNA0
 Hj30ecCgCgw5AXBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793111635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEk9WIh5Iy+lfOG/19TWBUIfrzqv+7Z+A0UdIPk8wNw=;
 b=vkefr1cnIlBOciha3LmCj43SJJKA9iaBNZXqO42O9hC14hBqu0Bf8Fy1eOrAkRCXI4ZsXt
 1uEEm3sXdAcKNrJhsVPWBr6dxAAWuDoSfOl/cL3z2SgWYhfcsAQxJu1n35glpaZ0yU931W
 rw1RqaSoBeEp0UXa64bZUJMaXk411UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793111635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEk9WIh5Iy+lfOG/19TWBUIfrzqv+7Z+A0UdIPk8wNw=;
 b=ESlKwPh1bn5kwIRwp0EzWaakZWVPdlK3aKPKt1khrqmR5tPLZ2FHrQbQFmypWQLRn4ZNA0
 Hj30ecCgCgw5AXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA5121321C;
 Tue, 27 Oct 2026 14:33:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Pg6XF1K24GrYEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 Oct 2026 14:33:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2] docs: Add security considerations for migration
In-Reply-To: <CAFEAcA9GDRQoqEXAt5-Mnm7jTPvpkZ6EPPvxiL7h_mFZOMuW6w@mail.gmail.com>
References: <20260721131457.3062767-1-farosas@suse.de>
 <CAFEAcA9GDRQoqEXAt5-Mnm7jTPvpkZ6EPPvxiL7h_mFZOMuW6w@mail.gmail.com>
Date: Tue, 27 Oct 2026 11:33:52 -0300
Message-ID: <87ik2njjqn.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:email]
X-Spam-Score: -13.30
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 21 Jul 2026 at 14:15, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Add the security considerations that are unique to migration and that
>> do not already fall into one of the other categories. Some aspects are
>> better framed as security architecture considerations, so extend that
>> section to mention TLS and clarify that disk images and guest network
>> also need to be isolated from other processes, not just other guests.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  docs/system/security.rst | 22 ++++++++++++++++++----
>>  1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/docs/system/security.rst b/docs/system/security.rst
>> index 52bbf0cc7a2..af626a42307 100644
>> --- a/docs/system/security.rst
>> +++ b/docs/system/security.rst
>> @@ -133,6 +133,16 @@ an issue as a normal bug.
>>    that affect the level 0 QEMU process. While these bugs should be
>>    fixed, they will not be triaged as security flaws at this time.
>>
>> +* **migration/snapshots**. Migration failures and snapshot load
>> +  failures are considered part of normal operation as long as the
>> +  source virtual machine and savevm file, respectively, are still
>> +  functional. Aborting the QEMU process at the migration/snapshot
>> +  destination is similarly not considered a security issue. The
>> +  migration stream is assumed to be secure as long as the design
>> +  principles described in the Architecture section are held, in
>> +  which case plain manipulation of the stream is not considered as
>> +  an attack vector.
>
> Reading this (which is now in our docs), it seems unclear to me
> about whether it intends to say that any and all bugs that can
> be triggered only by manipulating the migration stream are outside
> the security scope, or only some of them.
>

All of them, but we're talking specifically about feeding bad data into
QEMU from the host level.

> It says "plain manipulation of the stream is not considered as
> an attack vector", which suggests "everything is out of scope".

By "plain manipulation", we mean that if someone loads a compromised
loadvm image or if they have access to the infrastructure and proceed to
inject bytes into the migration stream that is considered out of the
scope of what we considered a security issue. The premise is that
migration is a special process that requires a secure network and the
usage of encryption. If you migrate in plain text over the internet,
that's on you.

The other scenario, this one in scope, would be an attack that starts on
the guest operating system and trips the migration code to cause an
effect. This would be an indirect stream manipulation, if we want to
call it that.

> But on the other hand it has an explicit list ("migration
> failures", "snapshot load failures", "aborting the QEMU process"),
> so does it mean by that that other things than those listed
> (e.g. "overruns a buffer in the destination") still are security
> issues ?
>

Yes, we're only isolating the scenario of attacker-controlled migration
stream at the network level. That situation is (IMO) undefendable.

All issues that lead _only_ to a migration failure while still in
precopy (including destination abort) will not cause any damage from the
perspective of the guest's isolation. Those are considered normal
operation, migrations sometimes fail.

If a legitimate migration operation - started by the admin, within a
secure network, using encryption - can be influenced to cause what would
otherwise be considered a security issue, then that's a security issue.

> I'd appreciate clarification, as it would make it easier to
> triage reported issues out of the confidential state.
>
> thanks
> -- PMM

