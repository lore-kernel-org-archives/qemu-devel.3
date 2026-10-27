Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E536606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qgIVQf/r;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=us4o/ZTU;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TSFPErL+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dVJqfkKm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjE7-000235-6d; Tue, 27 Oct 2026 11:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xLjE4-00022o-9F
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:36:36 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xLjE0-0003Uz-J4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:36:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9EBC221C1B;
 Tue, 27 Oct 2026 15:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793115391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCINiWHvZwszE1H10YxUyN09cHXePHvPVDM8IsKQw54=;
 b=qgIVQf/rBTfr2K3HuTH5x3TdbnAk/9iNuPpaTMSGlWhuCjzaRj3QZcwATxV/OcKLt5RTsL
 aD0QMyIsVZtYqZRmB6+Wi4JTvcLaJutyvfMO9lk817P/eq0iGOW17G+OweVuOH0XQ1nPHX
 C7HMk+PVwvWAn6dKz8VvHXJgtSPgJT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793115391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCINiWHvZwszE1H10YxUyN09cHXePHvPVDM8IsKQw54=;
 b=us4o/ZTUBzxVtTsYlqCDJUlU7NmAS0leBHTgIZnBr2jJgW/BxUlOQta1IGkOAxwkcHm+6O
 4mjdRBo7zqrGoZAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793115389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCINiWHvZwszE1H10YxUyN09cHXePHvPVDM8IsKQw54=;
 b=TSFPErL+qk6NJMFFJvg6G4Q1haPtmNpypvrkFShnxe67/oVk2H+VT9ACxK9fK/LthqaL+z
 LJhHvbiAyraB9UG64MAek0Ge5ASO6neb5vXiVcehGpBoMOl4O5axlWRe3KzrMc2CnigVQN
 I1SaY/T8z2sthPObxszcCZnL5DHR/kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793115389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCINiWHvZwszE1H10YxUyN09cHXePHvPVDM8IsKQw54=;
 b=dVJqfkKmrDUQFMOE8ahp1YqZzhG4lNU66rVGrt/PUqCi73afk1irWLz8YlLQjqX7IPynYs
 wDt0Zavo81/G7BAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CAF113319;
 Tue, 27 Oct 2026 15:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lrgDLfzE4GqbUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 Oct 2026 15:36:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, mjt@tls.msk.ru, peterx@redhat.com
Subject: Re: [PATCH v3 0/3] releases: build and run any QEMU release easily!
In-Reply-To: <786c36d6-d321-46f0-9e66-eb5847baabe9@oss.qualcomm.com>
References: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
 <87h5icl9dw.fsf@suse.de>
 <c4b4213c-6013-4a96-aa13-509778bbb6eb@oss.qualcomm.com>
 <87zew0jud9.fsf@suse.de>
 <786c36d6-d321-46f0-9e66-eb5847baabe9@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 12:36:18 -0300
Message-ID: <87fqxrjgul.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-13.10 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 SUBJECT_ENDS_EXCLAIM(0.20)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[generate_release_links.sh:url,
 imap1.dmz-prg2.suse.org:helo, build_release_container.sh:url,
 qualcomm.com:email]
X-Spam-Score: -13.10
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 10/26/2026 8:32 AM, Fabiano Rosas wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>> 
>>> On 10/23/2026 8:33 AM, Fabiano Rosas wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> This series was inspired by a recent post from Fabiano to provide container
>>>>> images for migration tests:
>>>>> https://lore.kernel.org/qemu-devel/24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com/T/#m353f119dc1a24fa437dde8a96d1891629e64303c
>>>>>
>>>>> The idea to be able to build and run any QEMU (past) release with containers was
>>>>> in my mind for some time, so I gave it a shot. Finally, it was easier than
>>>>> expected to obtain a single dockerfile (with a few hacks) that works over all
>>>>> our releases.
>>>>>
>>>>
>>>> Good stuff, thanks for this work. I'm just not sure how much of it fits
>>>> upstream in the current shape, let's discuss...
>>>>
>>>> You say this was in your mind for a while, could you elaborate a bit on
>>>> how you think this could benefit the project?
>>>>
>>>
>>> First usage that comes to my mind is that it would greatly help for
>>> migration, allowing automatic testing in CI, by just downloading any
>>> previous QEMU, dump a machine, and restore it on current version.
>> 
>> Don't we also build QEMU several times over in CI? Maybe I'm wrong, but
>> it might allow us to decouple a few tests from the build steps.
>>
>
> This is for current version, not past ones. I'm not sure it's worth
> adding an identical build for past versions on every pipeline.
>

I thought we re-built current qemu a few times, no? We have containers
for various distros and then make; make check inside of them. The
question was whether a step 0 to build the binary container for this
release would allow some builds to be skipped.

>>> We could do it for last 10 releases to ensure migration from packaged
>>> versions in all supported distros (red hat, alpine, ubuntu, ...) work
>>> as expected.
>>>
>> 
>> It's a nice idea but potentially a costly one. I don't think there is a
>> guarantee that the downstream package is migration-compatible with the
>> upstream package.
>>
>
> What would be costly? It seems it would just be a download + savevm
> through monitor, and a loadvm from current version tested.
>

Setting it up would be simple. Working with it, not so much. It's a test
that once it fails, then it becomes a tedious job of figuring out
whether the issue is a failure on our side or if it's merely an
incompatibility between upstream vs. downstream. The packaged QEMU can
have all sorts of tweaks, extra patches, fewer patches, different code
entirely, different machine type ABI, etc (their own QMP commands
even). The distro can guarantee it all works inside their environment.

When a problem happens on the intersection between the two binaries, if
it's on our side, we'd need to determine whether to fix it or tell the
distro "don't do that". If it's on their side then we open a bug report
and hope that this is even a priority for them.

So overall I'm in favor, but I don't expect it to be game changing.

>>> It could be a enhancement compared to the manual process done once per
>>> release. I read many times in review "it breaks the migration", that
>>> yes, it would be nice to have CI saying "this series broke the migration
>>> from qemu x.y".
>>>
>> 
>> Most of the "breaks migration" issues are due to device migration. What
>> we have today in terms of migration testing cannot detect most of those.
>>
>
> Ok.
>
>>> Beyond that, I think we could also offer a "rebase on steroids" tool. We
>>> could extend list of containers published to all top merge commits (git
>>> log --first-parent), and provide a fast rebase, based on download only.
>> 
>> Bisect requires a test of some sort. Will this cause the opposite
>> problem than what migration-test encounters? I.e. instead of "old QEMU
>> needs old OS" you'd have "new test needs QEMU from new OS". One
>> alternative would be to build the tests into an image as well. Or
>> perhaps it wouldn't be a problem in practice.
>>
>
> I don't think adding tests in image has a specific value. What we want
> is to keep the same test source, but just change the binary used. In
> this case, the container just acts as a binary.
>

There are requirements such as QEMU command line, external binaries,
maybe even the code itself, in the case of unit tests. Exchanging the
QEMU binary while keeping the same test (whether binary or not) may not
work.

- At some point we added the -audio command line option and updated
libqtest to include the option by default. Now older binaries can't
start when called by the new test code.

- If a test is sensitive to qemu output, deprecation warnings and error
message format changes might break it.

- qemu-img and qemu-io might have implicit dependencies on a range of
versions.

If we're being rigorous, two commits with completely different test and
QEMU code could still test the same functionality. That's how we do
normal bisect anyway. The requirement of test compatibility across QEMU
versions is something we probably never thought about before. I have
just recently started thinking about what can be done to libqtest to
allow more flexibility in this case.

>>> See it as a giant immutable precompiled cache. Dockerhub storage is free
>>> and unlimited.
>>> Some quick math: Since 8.0, there are ~2000 top merge commits. Each
>>> image is < 250MB compressed, so the whole thing would be < 500GB.
>>>
>>> Finally, in my personal case, while working on single binary, I had to
>>> compare output of qemu help between versions. I'm also interested to
>>> track QEMU binary size evolution over time. And some personal fun with
>>> software archeology on the project too for anyone.
>>>
>>>> To be clear, my use-case is simply to produce a few containers for
>>>> testing migration on my workstation. Your series can help a lot with
>>>> that, but from my point of view, some parts are clearly extra and some
>>>> are missing.
>>>>
>>>> Also beware that what you're touching here is both "infrastructure" and
>>>> "publishing". This has implications for how people consume the work of
>>>> the project. There's a chance that people see this as "official QEMU
>>>> containers" and try to use them in all sorts of weird scenarios that we
>>>> as a community are not prepared to maintain. You might get some
>>>> push-back on that basis.
>>>>
>>>
>>> Sure, it was free to generate all images and push them on my personal
>>> dockerhub, and it's now automated to push any feature release also in a
>>> GitHub nightly job. If we want to make it more official, it should
>>> really be hosted on an official account.
>>>
>>>>> The oldest functional distro we can find nowadays is ubuntu 12.04. Because of
>>>>> this, the oldest QEMU release we can build is v0.12.0. Previous ones require an
>>>>> environment we can't get easily today.
>>>>>
>>>>
>>>> I think the ability to go all the way back is very cool, but unless we
>>>> want to look at this from a archival or heritage perspective, I'd say
>>>> there's a line somewhere to how old we should go. I don't see an
>>>> use-case for very old binaries. Even knowing if they still work would
>>>> already incur in a maintenance cost.
>>>>
>>>
>>> Agree, mostly was a fun challenge. I was also curious to see until when
>>> we can go back in past from 2026.
>>>
>>> For the "maintenance" a scheduled CI job running nightly is a free thing
>>> for me, but I understand opinions on "maintenance cost" may differ. I
>>> also co-maintain tests/docker with Alex, so I'll be the one taking the
>>> load, and I'm fine with it.
>> 
>> Fair enough.
>> 
>>>   >> Images have the absolute minimal content possible. It's only qemu
>>> binaries,
>>>>> artifacts (roms, keymap, ...), and libraries. There is no shell or any other
>>>>> tool included. As a result, images have a size from 149MB (v0.12.0) to 1.48GB
>>>>> (v11.1.2).
>>>>>
>>>>
>>>> No shell means the first thing to do if one wants to debug the image is
>>>> to rebuild with a shell in. Not sure how frequent it will be, maybe it's
>>>> ok like this.
>>>>
>>>
>>> We could leave a base system, for only ~100MB per image, which is not
>>> the end of the world (+10% in size). Personally, I appreciate to have no
>>> shell, it reduces possibility of exploit when running an older QEMU
>>> having CVEs.
>>>
>>>>> This series adds 3 pieces:
>>>>> - a unique dockerfile to build any QEMU release. User has to provide an explicit
>>>>>   Ubuntu version when building a given QEMU version.
>>>>
>>>> This is the tricky part. We'll be carrying code (script+dockerfile) that
>>>> only works on master. If we tag today and tomorrow the old distro repo
>>>> breaks, we obviously cannot fix it retroactively. So we need to be
>>>> careful of where we direct the maintenance effort.
>>>>
>>>> 1) I'd suggest first of all to keep the release image entirely separate
>>>> from the ubuntu image. Treat release.docker as we treat the other
>>>> dockerfiles and update it to work for the current release without
>>>> looking at past ones. Have it clone, checkout, build and gather
>>>> deps. Allow the configure to be tweaked via parameter in case we need to
>>>> disable something in an older build.
>>>>
>>>> The script would then build a distro image (or dockerfile) with the
>>>> knowledge that it has about ubuntu depending on the QEMU tag vs. ubuntu
>>>> version combination. This would allow us to track the cludges more
>>>> precisely instead of "some ancient distro" as the dockerfile currently
>>>> says.
>>>>
>>>> This is more of a layering concern and how easy it will be to drop/add
>>>> version-specific fixes.
>>>>
>>>
>>> IIUC I think that's the approach Fabiano took, to use Dockerfile from
>>> previous versions, and the conclusion was that it requires some seds and
>>> hacks to have something that work. Internet state is not immutable.
>>> IMHO, building previous QEMU with past Dockerfiles is doomed to fail.
>>>
>> 
>> That's not what I'm suggesting here. I'm saying that "current
>> dockerfile" should have less tweaks and "current
>> build_release_container.sh" should be the one responsible for doing the
>> ubuntu-version-to-tweak mapping.
>>
>
> Got you.
>
>> But maybe you meant to reply to the second point below. In that case,
>> yes the past dockerfiles require tweaks, but they also provide most of
>> the time the exact list of dependencies for the previous QEMU, and that
>> work was already done by the people from the past.
>> 
>>> Only thing you can control/guarantee is that "current dockerfile on
>>> master works".
>>>
>>>> 2) I wonder if the usage of apt-get build-dep might be a convenience
>>>> trap. In theory, some of the adaptations that are required (such as
>>>> tweaking dependencies) have already been done by us when working on that
>>>> development window.  If we take the dockerfiles from the git tag, those
>>>> changes don't need to be done again and for the issues that didn't exist
>>>> at the time, we can map them to the git tag instead of ubuntu version;
>>>> (we tend to know more about QEMU releases than ubuntu releases).
>>>>
>>>> Another issue with buid-dep is that it lists _ubuntu package_
>>>> dependencies. The distro can change how it builds the package without us
>>>> noticing. There is already some work done by lcitool, I imagine that it
>>>> would then be duplicated. Or worse(!) be different because build-dep
>>>> might be listing way more packages that what we need for the default
>>>> build.
>>>>
>>>> This is more of a push towards using existing infra because those pieces
>>>> are already looked after for other purposes.
>>>>
>>>>> - A script build_release_container.sh which automatically detects which ubuntu
>>>>>   version a given release should be buildable on (based on date). It works
>>>>>   great, and the heuristic works for all our versions.
>>>>> - a script generate_release_links.sh which creates wrapper scripts automatically
>>>>>   using prebuilt images (hosted on my dockerhub).
>>>>>
>>>
>>> Sure, lcitool could work to express all that. Would I like to spend time
>>> to rewrite all the missing bits in yaml when debian did it for me? not
>>> really.
>>>
>> 
>> I may have misled you. I'm not suggesting to use lcitool for the missing
>> bits, I'm suggesting we consume what's already in
>> tests/docker/dockerfiles. That point you already got.
>>
>
> Oh I see ok. Like extract the list of packages, and inject that.
> Well, I'm not sure it will be simpler than just doing an apt build-dep
> to be honest, and not sure what we gain from taking this information
> from our sources.
>

Just so you're aware of my reasoning:

It's information we control, add/remove packages, pin package versions,
write a big commit message explaining why, etc. While apt build-dep is
simple and it works great, it's still a little piece in the hands of a
third party that has their own policies and goals. No one on their side
(whatever distro it is) is thinking "what happens with QEMU CI if I
change this". It makes the project more robust if we limit that kind of
exposure.

>>>>
>>>> It would be nice if these two could take any hash, instead of just a
>>>> tag. This is one of the things that will depend on what you intend to
>>>> achieve with this series.
>>>>
>>>
>>> Very easy, it just needs a non shallow clone.
>>>
>>> ---
>>>
>>> After reading and answering to this message, I feel there are two topics
>>> we can discuss:
>>> 1. the current implementation
>>> 2. what would we like
>>>
>>> 1. Personally, I just posted this series as an example of "yes it's
>>> possible with very limited amount of code", and I don't mind having
>>> something completely different. I feel it's probably not worth reviewing
>>> every line at this point.
>>>
>>> 2. The biggest question seems to be the direction with:
>>> 'do we want to provide a single dockerfile that covers all versions' (a)
>>> VS 'having a dockerfile at a time of history for current version' (b).
>>>
>> 
>> It's probably (b), because the "all versions" part spontaneously spawned
>> to life. If you take a recent-ish QEMU version there will be few or no
>> tweaks at all and then it all becomes a question of "why base this on
>> ubuntu when we already have dockerfiles written for several
>> distros?".
>> 
>> UPDATE: You just replied that you think build-dep is consistently close
>> to the real deps enough that it would be less work to maintain. You
>> could very well be right and we're approaching the hair-splitting zone
>> around this topic. I suggest you carry on using your best judgement and
>> let's leave it to time.
>>
>
> We can also decide to settle on fedora, alpine, debian, suse, or any
> distro. In terms of images, ubuntu was just the most convenient (tried
> with debian first, which required updating apt sources for older versions).
>
>>> I think (b) is what we have now (current ubuntu/suse/debian/alpine image
>>> works for current revision, since it's used in CI), and it was already
>>> proven it fails from Fabiano's feedback.
>> 
>> But the tweaks may be necessary either way. This series adds an
>> indirection to choose an ubuntu version just to be able to issue (some)
>> commands unconditionally in the dockerfile. It could just as well check
>> the qemu version directly.
>>
>
> That's maybe where the philosophy differs. Key idea of this series is to
> tweak the environment so it works all time, and not do specific things
> per version.
>

Sure, but the "all the time" part doesn't convince much. Anyway, that's
only one point and we've discussed it enough. If it fails miserably
you'll learn something, otherwise, I will. =)

>> (yes, there's potentially dealing with all the other distros and lcitool
>> and all _that_, I get it)
>> 
>>> It seems to be that's what you propose also from your answer above.
>>>
>> 
>> Fabiano and I are the same person. =)
>>
>
> Sorry, got confused as Peter answered on v2, and I assumed he was the
> one who answered on v3 also.
>

I'm flattered, thanks.

>>> This series goes in another direction (a), adding a unique dockerfile
>>> covering all versions, independently of all the dockerfiles we have now.
>>>
>>> If we agree (a) is a better direction, unique dockerfile approach can be
>>> vastly simplified by restricting ourselves to qemu >= 3.1.0. If not, no
>>> hard feelings, it's just a proposal.
>
> Regards,
> Pierrick

