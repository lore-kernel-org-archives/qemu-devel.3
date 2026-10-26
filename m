Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E7606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zg9u7AE/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NuaFaaC8;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zg9u7AE/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NuaFaaC8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLjX-0008SH-8P; Mon, 26 Oct 2026 10:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xLLjW-0008S8-Dp
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 10:31:30 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xLLjT-0004rJ-U3
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 10:31:30 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 755191F78B;
 Mon, 26 Oct 2026 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793025084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QfeFAilp8uAtqamvW5tV2LhfjZNgbDhw2ZsyZzv7AQ=;
 b=zg9u7AE/TQMRKRHnp6wqNEKS1jPw2VUzWPvqDOAo4PGeTBH6mUUxSFkZLXnu23L8n3BCsm
 iq82mNxJPbft4XAkBuMSdfm6p7AocDYctV1cWCyRoAmx/HW225Q73kW/HjM02TDl56P9g9
 HMMfIVNY+78B/a7uPs3TY3IBwEvJlTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793025084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QfeFAilp8uAtqamvW5tV2LhfjZNgbDhw2ZsyZzv7AQ=;
 b=NuaFaaC8YLutgSfFL5VmyIrv3pVniP5pGub3ABVazGH4WgYxiDwxFR8SFpqP17xWb8ZHW/
 8wTzbT/Z074hmvBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="zg9u7AE/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NuaFaaC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793025084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QfeFAilp8uAtqamvW5tV2LhfjZNgbDhw2ZsyZzv7AQ=;
 b=zg9u7AE/TQMRKRHnp6wqNEKS1jPw2VUzWPvqDOAo4PGeTBH6mUUxSFkZLXnu23L8n3BCsm
 iq82mNxJPbft4XAkBuMSdfm6p7AocDYctV1cWCyRoAmx/HW225Q73kW/HjM02TDl56P9g9
 HMMfIVNY+78B/a7uPs3TY3IBwEvJlTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793025084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QfeFAilp8uAtqamvW5tV2LhfjZNgbDhw2ZsyZzv7AQ=;
 b=NuaFaaC8YLutgSfFL5VmyIrv3pVniP5pGub3ABVazGH4WgYxiDwxFR8SFpqP17xWb8ZHW/
 8wTzbT/Z074hmvBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E015413319;
 Mon, 26 Oct 2026 14:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QlKlIDtk32p+OgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Oct 2026 14:31:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, mjt@tls.msk.ru, peterx@redhat.com
Subject: Re: [PATCH v3 1/3] tests/docker/dockerfiles: add release.docker
In-Reply-To: <9aca799c-3f3b-4234-a38b-725879818755@oss.qualcomm.com>
References: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014005338.34657-2-pierrick.bouvier@oss.qualcomm.com>
 <87ecdgl7v6.fsf@suse.de>
 <9aca799c-3f3b-4234-a38b-725879818755@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:31:17 -0300
Message-ID: <8733tsleiy.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 755191F78B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.71 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 SEM_URIBL(3.50)[ubuntu.com:url]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 BAD_REP_POLICIES(0.10)[]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 R_DKIM_ALLOW(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:url, ubuntu.com:url,
 qualcomm.com:email, gitlab.com:url, suse.de:dkim, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -9.71
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 10/23/2026 9:06 AM, Fabiano Rosas wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>> 
>>> This new dockerfile allows to build a distroless image containing only
>>> qemu stripped release binaries, their lib dependencies, and installed
>>> artifacts (roms, keymap, ...). There is no shell, no python, nothing
>>> else. This is achieved thanks to a multi-stage build, where we add qemu
>>> binaries, artifacts and libraries in a new scratch image. Image has
>>> the minimal size possible.
>>>
>>> This is based on Ubuntu, which has the advantage to have working
>>> containers available up to 12.04. Debian old old stable have broken apt
>>> sources for instance. Ubuntu 10.04 binaries segfault due to missing
>>> vsyscall emulation on modern kernels, so 12.04 is the lowest possible.
>>>
>>> This unique dockerfile works for all qemu versions, with 0.12.0 being the
>>> oldest we can build today (based on ubuntu 12.04). Previous ones need an
>>> older compiler.
>>>
>>> To build the image, you need to provide a qemu and ubuntu version:
>>> $ podman build -f release.Dockerfile --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0
>>>
>>> To run it, as there is no shell, and no defined entrypoint, you need to
>>> choose the binary you want explicitely:
>>> $ podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version
>>>
>>> Notes: We could optimize a bit further, by creating a base container for
>>> each ubuntu version, that is reused between all qemu versions built with
>>> it. Given that recent QEMU have around 800MB of binaries + artifacts,
>>> and only 100MB of library dependency, I don't think it's worth the extra
>>> complexity.
>>>
>>> Notes: Also, I considered create one image per binary. Problem is
>>> that qemu depends on other artifacts (rom, keymap, etc) and it's not
>>> easy to identify what is needed for one binary. Thus, I think it's
>>> better to stick to one container with all binaries per release.
>>>
>> 
>> Yeah, it's fine this way.
>> 
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>  tests/docker/dockerfiles/release.docker | 76 +++++++++++++++++++++++++
>>>  1 file changed, 76 insertions(+)
>>>  create mode 100644 tests/docker/dockerfiles/release.docker
>>>
>>> diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
>>> new file mode 100644
>>> index 00000000000..611ecca9859
>>> --- /dev/null
>>> +++ b/tests/docker/dockerfiles/release.docker
>>> @@ -0,0 +1,76 @@
>>> +ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
>>> +FROM ubuntu:$UBUNTU_VERSION as build
>> 
>> I believe FROM should be capitalized the same as AS.
>>
>
> Dockerfile instructions are not case sensitive, but yes, AS would be
> more consistent, I'll change it.
>

Docker emits a warning about the mismatch.

>>> +ARG UBUNTU_VERSION
>> 
>> Is this duplicated?
>>
>
> ARG have to be duplicated for each stage of the build.
> In this case:
> - pre-stage (to be used in first FROM)
> - first-stage (to be used inside this stage)
>

Got it.

>>> +
>>> +# add deb-src for apt build-dep
>>> +RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
>>> +RUN sed -e 's/# deb-src/deb-src/' -i /etc/apt/sources.list
>>> +# archive.canonical.com is not reachable anymore, and cause a long timeout
>>> +RUN sed -e '/archive.canonical.com/d' -i /etc/apt/sources.list
>>> +# LTS < 14.04 are hosted on https://old-releases.ubuntu.com/releases/
>>> +RUN if [ $(echo $UBUNTU_VERSION | cut -f 1 -d '.') -lt 14 ]; then \
>>> +    sed -e 's/archive/old-releases/g' -i /etc/apt/sources.list; \
>>> +fi
>> 
>> Hm, so I imagine these containers have reached end-of-life? I wonder
>> whether we should cap how further back we go based on this. It's one
>> thing to workaround a few installation bugs we list/install our
>> dependencies, another thing is the distro image poiting to dead URLs.
>>
>
> If we want to cap it, then 14.04 is the lowest limit with fixed url.
> Note that archive.canonical.com still has to be removed, it's present in
> some LTS > 14.04 and create a long timeout for apt update.
>
>>> +
>>> +# use apt-get since apt was missing -y option in some ancient distro
>> 
>> Ok, this is a reasonable issue to encounter and fix in the dockerfile. I
>> pointed at this on the cover letter, but we don't gain much in knowing
>> exactly which apt version has -y or not.
>> 
>>> +RUN apt-get update && \
>>> +env DEBIAN_FRONTEND=noninteractive apt-get install -y git build-essential
>>> +RUN apt-get update && \
>>> +env DEBIAN_FRONTEND=noninteractive apt-get build-dep -y --arch-only qemu
>>> +# additional dependencies that are missing at some point in history
>>> +RUN apt-get update && \
>>> +env DEBIAN_FRONTEND=noninteractive apt-get install -y ninja-build flex bison libpixman-1-dev
>> 
>> So a discrepancy on which QEMU version and how the distro packaged it at
>> the time vs. which dependencies we had. Is this something that would
>> have been solved by lcitool? (Hm, did we even use it back then?)
>>
>
> It's new dependencies added by QEMU over time, that distro didn't
> reflect yet at a past date. (ninja introduction, or recently hexagon
> target which requires flex/bison for idef tool).
>

Right, and they may never add it, because it's either already in the
past or because they simply don't need that dependency for their
package.

If we're around release time and for some reason they change what's in
their package, it would be annoying to have to figure this out to
unbreak CI or something similar.

It's a situation that tends to degenerate to that last line simply
becoming the full list of dependencies. There's also the whack-a-mole-y
job of removing packages (for tidyness) from the last line if they end
up being provided by build-dep.

Granted it's containers and there may be little expectation of things
working indefinitely without code changes, so I'll let the maintainers
do what they prefer.

>>> +# python3-venv didn't exist in ancient ubuntu distro
>>> +RUN apt-get update && \
>>> +if apt-cache show python3-venv; then \
>>> +    env DEBIAN_FRONTEND=noninteractive apt-get install -y python3-venv; \
>>> +fi
>> 
>> Maybe good to know which version so we know when to drop this block?
>> 
>> I see some of these check the ubuntu version, some not, I wonder how
>> easy it will be to break an older image's build when trying to fix a new
>> one. I find it a bit confusing.
>>
>
> Good point, I think I had this written *before* trying to go before
> 14.04, thus the inconsistency.
>
>>> +
>>> +# patch cc and c++ to inject warning suppression options
>>> +RUN mv /usr/bin/cc /usr/bin/cc.real
>>> +RUN echo "#!/usr/bin/env bash" > /usr/bin/cc && \
>>> +echo "exec /usr/bin/cc.real \"\$@\" -Wno-error -Wno-int-conversion" >> /usr/bin/cc && \
>>> +chmod +x /usr/bin/cc
>>> +RUN mv /usr/bin/c++ /usr/bin/c++.real
>>> +RUN echo "#!/usr/bin/env bash" > /usr/bin/c++ && \
>>> +echo "exec /usr/bin/c++.real \"\$@\" -Wno-error -Wno-int-conversion" >> /usr/bin/c++ && \
>>> +chmod +x /usr/bin/c++
>>> +
>> 
>> This assumes this dockerfile will not be used to test a current
>> build. Probably ok.
>>
>
> Why is it a problem? It just disables werror in a systematic way,
> without relying on configure --disable-werror that was not always there.
>

Depends on how we use this image. If it runs early in some CI it might
be better to let it catch the warnings.

>>> +# 2.9.0 => 3.1.0: clone git submodules from expired url, replace them with gitlab.

This sentence may need rewording.

>>> +# 2.9.0 => 2.11.0: issue with libfdt version, solved with dtc submodule, which
>>> +#                  was removed later.
>>> +# Ubuntu < 14.04: git has no --single-branch, so perform manual fetch after clone.
>> 
>> See how unstructured this has become? A comment here, the code down
>> there, nothing actually checks the version, the sed happens for all
>> versions, etc. Dockerfiles are bad at this kind of thing.
>>
>
> This one is just a comment, and the code below has a single
> implementation that works over all versions.
> We could have ifs with multiple code paths, just a question of personal
> taste I suppose.
>

Could be.

> Out of the if on ubuntu version at the beginning, the general approach
> was to have a single code path for all versions of QEMU/Ubuntu, without
> ifs per version.
>

Ok, makes sense.

>>> +ARG QEMU_VERSION
>>> +RUN echo "QEMU_VERSION=${QEMU_VERSION:?QEMU_VERSION build arg must be set}"
>> 
>> In order to build local trees I added at this point:
>> 
>> RUN --mount=type=bind,from=qemu-src,target=/tmp/qemu-src,rw \
>> cd /tmp && \
>> if echo "${QEMU_VERSION}" | grep -q "\."; then \
>>     git clone https://gitlab.com/qemu-project/qemu.git --depth 1 && cd qemu && \
>>     git fetch origin "${QEMU_VERSION}" --depth 1 && \
>>     git checkout FETCH_HEAD; \
>> else \
>>     git clone qemu-src qemu && cd qemu && \
>>     git checkout "${QEMU_VERSION}"; \
>> fi && \
>>
>
> We can extend to support any sha-1 (it's just a matter of doing full vs
> shallow clone).
>

+1

> For the local build, I don't like the idea to build from local state, it
> has zero guarantee for reproducibility, which goes against what
> dockerfiles are IMHO.
>

Could this be crafted to take the git repo url as argument, then? Your
point is valid, but once this image is used for something that exposes a
bug, it's natural to want to re-execute with a modified codebase to
debug or test a fix.

> Regards,
> Pierrick

