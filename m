Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F17606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DCQu3058;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qgMpvESz;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=su7fHzgb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PdwWfKvz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM44C-0003n1-F8; Wed, 28 Oct 2026 09:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xM44A-0003kR-7Z
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:51:46 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xM448-0000dW-AL
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:51:45 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C831A1F7AF;
 Wed, 28 Oct 2026 13:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793195502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5gidrUoC9HrCNtSjoo5p8r/LjMZoxwU2vKPL5yKtrHc=;
 b=DCQu3058EATVdGR1WGgukgtN3J2q1mxuXCj5fMLlbA2bp5wJXspEVvd/CCTKTCXdAPcClS
 +3iPh0h3Dh1LNFJK8R0HImH/ayhE/OOZvJBSBiFDq28Kd8CJ3wPxmpNadI0HYVF72hCUoT
 6NOULKMvoofJt7PUKBeIOafI9kRsECI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793195502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5gidrUoC9HrCNtSjoo5p8r/LjMZoxwU2vKPL5yKtrHc=;
 b=qgMpvESz0ORL3YW9tCP0q1guMnWWwkX+GFvhvgz2jWtxb0/MGdNaWoucLifxD1lQxVzgth
 3P0OLkk+AA9vg1Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793195500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5gidrUoC9HrCNtSjoo5p8r/LjMZoxwU2vKPL5yKtrHc=;
 b=su7fHzgbUNZkNA/LoZ8Hgp6fSG6Fq64KdKWk0TGDHdYaMfCCELdqeJlTSteabsHi0MqCyG
 6qXtob05Sh+UVtqWzJEqKPxiRtp9waDyhgaQgD6F5kK4kPD0noOHRfpje911numpkipIGF
 0GQSKwfs7+FPTuw74a+RO/aoeyuWR4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793195500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5gidrUoC9HrCNtSjoo5p8r/LjMZoxwU2vKPL5yKtrHc=;
 b=PdwWfKvzPJb7qd8yZAzmcLiayqDOEsmgfbtc6rTC9eh2J7oGmcOE1S54AQjlf3tJTY+HO9
 gTW5lvuX1BCcTtBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4921D1321C;
 Wed, 28 Oct 2026 13:51:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QOFzN+v94WrMUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Oct 2026 13:51:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2] docs: Add security considerations for migration
In-Reply-To: <CAFEAcA8vq-zFsou=A4H+XDZ-zsWKJK3-RzASs6aV_s9efFyQyw@mail.gmail.com>
References: <20260721131457.3062767-1-farosas@suse.de>
 <CAFEAcA9GDRQoqEXAt5-Mnm7jTPvpkZ6EPPvxiL7h_mFZOMuW6w@mail.gmail.com>
 <87ik2njjqn.fsf@suse.de>
 <CAFEAcA8vq-zFsou=A4H+XDZ-zsWKJK3-RzASs6aV_s9efFyQyw@mail.gmail.com>
Date: Wed, 28 Oct 2026 10:51:29 -0300
Message-ID: <877bj2j5lq.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 linaro.org:email]
X-Spam-Score: -13.30
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 27 Oct 2026 at 14:33, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Tue, 21 Jul 2026 at 14:15, Fabiano Rosas <farosas@suse.de> wrote:
>> >> +* **migration/snapshots**. Migration failures and snapshot load
>> >> +  failures are considered part of normal operation as long as the
>> >> +  source virtual machine and savevm file, respectively, are still
>> >> +  functional. Aborting the QEMU process at the migration/snapshot
>> >> +  destination is similarly not considered a security issue. The
>> >> +  migration stream is assumed to be secure as long as the design
>> >> +  principles described in the Architecture section are held, in
>> >> +  which case plain manipulation of the stream is not considered as
>> >> +  an attack vector.
>> >
>> > Reading this (which is now in our docs), it seems unclear to me
>> > about whether it intends to say that any and all bugs that can
>> > be triggered only by manipulating the migration stream are outside
>> > the security scope, or only some of them.
>> >
>>
>> All of them, but we're talking specifically about feeding bad data into
>> QEMU from the host level.
>>
>> > It says "plain manipulation of the stream is not considered as
>> > an attack vector", which suggests "everything is out of scope".
>>
>> By "plain manipulation", we mean that if someone loads a compromised
>> loadvm image or if they have access to the infrastructure and proceed to
>> inject bytes into the migration stream that is considered out of the
>> scope of what we considered a security issue. The premise is that
>> migration is a special process that requires a secure network and the
>> usage of encryption. If you migrate in plain text over the internet,
>> that's on you.
>>
>> The other scenario, this one in scope, would be an attack that starts on
>> the guest operating system and trips the migration code to cause an
>> effect. This would be an indirect stream manipulation, if we want to
>> call it that.
>
> Thanks. I think we could maybe make the text clearer. Here's my
> suggestion, that splits out the cases into a set of bullet points:
>
> * **migration/snapshots**. The user must deploy QEMU following the
>   design principles described in the Architecture section to ensure
>   that the migration stream is secure. Plain manipulation of the stream
>   is not considered to be an attack vector. This means that:
>   * Migration failures and snapshot load failures are part of normal
>     operation; these are not bugs as long as the source virtual machine
>     or savevm file are still functional
>   * Aborts, crashes or misbehaviour of the destination QEMU due to
>     an externally manipulated migration stream are bugs, but not
>     security issues
>   * A crash of the destination QEMU that can be triggered by a guest
>     manipulating a device on the source QEMU before a migration may
>     be a security issue, if it meets the other criteria we document
>     for security issues
>
> How does that sound?
>

Looks good, thanks. I'll send a patch.

> I think we should also:
>
>  * add a subsection to the "Sensitive configurations" part of this
>    document at the bottom, that makes it clear that the user needs
>    to be careful about the migration stream and loadvm files
>    (to parallel the one that says "it's your job to lock down
>    monitor access")
>  * update the part at the to of the document that includes in
>    its list of untrusted entities "Network protocols (e.g. NBD,
>    live migration)" as this suggests the opposite of what the
>    later text says. I guess just delete "live migration" ?
>

Yes, this one has been coming up frequently. The point was to keep
developers thinking about migration stream validation. But it's
misleading, better to remove it.

> We also have 15 or so existing bugs that are labelled "confidential"
> but which are "crafted migration stream can exploit the destination
> QEMU". Unless you object I'll mark all those as non-confidential
> non-security issues.
>

Ack

> thanks
> -- PMM

