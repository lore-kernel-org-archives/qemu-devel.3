Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B65606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zZ9I3mAf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WamxWTod;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pQJjBVc8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gHJhd4N8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHH1-0008Cp-41; Fri, 23 Oct 2026 11:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xKHGp-00087Q-Iu
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:33:30 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xKHGl-0005zW-Uz
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:33:25 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4953B1F44F;
 Fri, 23 Oct 2026 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792769599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7VxXiuUf+SdMoWOPkNS+kIqYY2makgI1EG0fF9VMJWc=;
 b=zZ9I3mAfTrhfYWjWZo6XKJD8gb+bgkaJ/jaZ+HYiTgj4VER+HyRY6Sp/lH1iJ288quONcg
 SvJoZSeTqHAqXxH2yDBCGzC+gFt7Je4GzqfXxBw9vi7TTPgSMfwMtonUKxdzm4SV15BAUO
 I1QIyut7RIL5d2+9E4ZI5DPdICXvoX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792769599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7VxXiuUf+SdMoWOPkNS+kIqYY2makgI1EG0fF9VMJWc=;
 b=WamxWTodYjFvvs36xZ30dRx1zWVdlcai+raPqxg/IR5qsxNPr5VL3yv73pWAss7v9rueyG
 IQ0lmp+XEy50GPBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pQJjBVc8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gHJhd4N8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792769598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7VxXiuUf+SdMoWOPkNS+kIqYY2makgI1EG0fF9VMJWc=;
 b=pQJjBVc8CWwVv1XXiuWrUL2HrehWS9YcYH16qsv7baFbg0WywxmyeuEeBFjk9UlFytHW/G
 623qsQfwVr1EK/OU2Wo/OAOHJ2VobEv+ncKU+tzikNH2hXyaCo9lSDpAgjzmZBhmooQB3f
 fa8G4WGyTk/UFiYqjVpCwZrhee/2urc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792769598;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7VxXiuUf+SdMoWOPkNS+kIqYY2makgI1EG0fF9VMJWc=;
 b=gHJhd4N83p2MpDewU3AnEz348vQigV6tpPsFLnF3AD8ElkaIwPzU1yTL0dHXxXqP5iE+l1
 68atbzLfeeNxGQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A7F8133F6;
 Fri, 23 Oct 2026 15:33:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tqCRDz1+22oVTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Oct 2026 15:33:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>, mjt@tls.msk.ru, peterx@redhat.com
Subject: Re: [PATCH v3 0/3] releases: build and run any QEMU release easily!
In-Reply-To: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:33:15 -0300
Message-ID: <87h5icl9dw.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4953B1F44F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.31 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 SUBJECT_ENDS_EXCLAIM(0.20)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,build_release_container.sh:url,suse.de:dkim,generate_release_wrappers.sh:url,qualcomm.com:email,generate_release_links.sh:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.31
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> This series was inspired by a recent post from Fabiano to provide container
> images for migration tests:
> https://lore.kernel.org/qemu-devel/24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com/T/#m353f119dc1a24fa437dde8a96d1891629e64303c
>
> The idea to be able to build and run any QEMU (past) release with containers was
> in my mind for some time, so I gave it a shot. Finally, it was easier than
> expected to obtain a single dockerfile (with a few hacks) that works over all
> our releases.
>

Good stuff, thanks for this work. I'm just not sure how much of it fits
upstream in the current shape, let's discuss...

You say this was in your mind for a while, could you elaborate a bit on
how you think this could benefit the project?

To be clear, my use-case is simply to produce a few containers for
testing migration on my workstation. Your series can help a lot with
that, but from my point of view, some parts are clearly extra and some
are missing.

Also beware that what you're touching here is both "infrastructure" and
"publishing". This has implications for how people consume the work of
the project. There's a chance that people see this as "official QEMU
containers" and try to use them in all sorts of weird scenarios that we
as a community are not prepared to maintain. You might get some
push-back on that basis.

> The oldest functional distro we can find nowadays is ubuntu 12.04. Because of
> this, the oldest QEMU release we can build is v0.12.0. Previous ones require an
> environment we can't get easily today.
>

I think the ability to go all the way back is very cool, but unless we
want to look at this from a archival or heritage perspective, I'd say
there's a line somewhere to how old we should go. I don't see an
use-case for very old binaries. Even knowing if they still work would
already incur in a maintenance cost.

> Images have the absolute minimal content possible. It's only qemu binaries,
> artifacts (roms, keymap, ...), and libraries. There is no shell or any other
> tool included. As a result, images have a size from 149MB (v0.12.0) to 1.48GB
> (v11.1.2).
>

No shell means the first thing to do if one wants to debug the image is
to rebuild with a shell in. Not sure how frequent it will be, maybe it's
ok like this.

> This series adds 3 pieces:
> - a unique dockerfile to build any QEMU release. User has to provide an explicit
>   Ubuntu version when building a given QEMU version.

This is the tricky part. We'll be carrying code (script+dockerfile) that
only works on master. If we tag today and tomorrow the old distro repo
breaks, we obviously cannot fix it retroactively. So we need to be
careful of where we direct the maintenance effort.

1) I'd suggest first of all to keep the release image entirely separate
from the ubuntu image. Treat release.docker as we treat the other
dockerfiles and update it to work for the current release without
looking at past ones. Have it clone, checkout, build and gather
deps. Allow the configure to be tweaked via parameter in case we need to
disable something in an older build.

The script would then build a distro image (or dockerfile) with the
knowledge that it has about ubuntu depending on the QEMU tag vs. ubuntu
version combination. This would allow us to track the cludges more
precisely instead of "some ancient distro" as the dockerfile currently
says.

This is more of a layering concern and how easy it will be to drop/add
version-specific fixes.

2) I wonder if the usage of apt-get build-dep might be a convenience
trap. In theory, some of the adaptations that are required (such as
tweaking dependencies) have already been done by us when working on that
development window.  If we take the dockerfiles from the git tag, those
changes don't need to be done again and for the issues that didn't exist
at the time, we can map them to the git tag instead of ubuntu version;
(we tend to know more about QEMU releases than ubuntu releases).

Another issue with buid-dep is that it lists _ubuntu package_
dependencies. The distro can change how it builds the package without us
noticing. There is already some work done by lcitool, I imagine that it
would then be duplicated. Or worse(!) be different because build-dep
might be listing way more packages that what we need for the default
build.

This is more of a push towards using existing infra because those pieces
are already looked after for other purposes.

> - A script build_release_container.sh which automatically detects which ubuntu
>   version a given release should be buildable on (based on date). It works
>   great, and the heuristic works for all our versions.
> - a script generate_release_links.sh which creates wrapper scripts automatically
>   using prebuilt images (hosted on my dockerhub).
>

It would be nice if these two could take any hash, instead of just a
tag. This is one of the things that will depend on what you intend to
achieve with this series.

> TLDR:
> $ ./scripts/build_release_container.sh v1.6.1
> $ podman run -it --rm qemu/v1.6.1 qemu-system-arm --version
>
> $ ./script/generate_release_links.sh qemu-time-machine
> $ ./qemu-time-machine/v1.6.1/qemu-system-arm --version
> QEMU emulator version 1.6.1, Copyright (c) 2003-2008 Fabrice Bellard
> $ ./qemu-time-machine/v11.0.0/qemu-system-arm --version
> QEMU emulator version 11.0.0 (v11.0.0)
> Copyright (c) 2003-2026 Fabrice Bellard and the QEMU Project developers
>
> v3
> --
>
> - extend dockerfile to support ubuntu 12.04, and lower older revision we can
>   build from v1.6.1 to v0.12.0.
>
> v2
> --
>
> - fix generate_release_links.sh: was missing userns option for podman
> - dockerfile: cleanup "|| true" and replaced with proper ifs
>
> Pierrick Bouvier (3):
>   tests/docker/dockerfiles: add release.docker
>   scripts: add build_release_container.sh
>   scripts: add generate_release_wrappers.sh
>
>  scripts/build_release_container.sh      | 62 ++++++++++++++++++++
>  scripts/generate_release_wrappers.sh    | 71 +++++++++++++++++++++++
>  tests/docker/dockerfiles/release.docker | 76 +++++++++++++++++++++++++
>  3 files changed, 209 insertions(+)
>  create mode 100755 scripts/build_release_container.sh
>  create mode 100755 scripts/generate_release_wrappers.sh
>  create mode 100644 tests/docker/dockerfiles/release.docker

