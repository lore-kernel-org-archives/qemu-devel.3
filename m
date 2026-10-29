Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C38606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xwzIs/fM;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/DRx6MFv;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xwzIs/fM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/DRx6MFv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMV2q-0000mj-2E; Thu, 29 Oct 2026 14:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV2d-0000id-06
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:40:00 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMV2a-0001G0-HJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:39:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C52E1F449;
 Thu, 29 Oct 2026 18:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxh5Vg3fa9jpC/yim+1k52mqrz8e1+lCG5E/SDez7nM=;
 b=xwzIs/fM+x1qWiTYhvONsw5Tqq7YF/2A1QgwLlTZCMMPn5ZCK1A3yb7SZUI5rqNHcoNzWG
 427Vy0g1Bmv/FtygRrFHd+Xk0TBH4dC3Exw/ZVtSFk8apZzMrO2zq8hxpb5G+7l3TYImZj
 Ttjc/gAU8buWStxYH17JLoip0DD4KEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxh5Vg3fa9jpC/yim+1k52mqrz8e1+lCG5E/SDez7nM=;
 b=/DRx6MFvqeQzMDf8YF+J8mA+P8kT2nUt5rw2TCBIJXp7llUyjS029hAvQORD6X9552pURJ
 qOTXXOiDTb8Eq/DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793299194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxh5Vg3fa9jpC/yim+1k52mqrz8e1+lCG5E/SDez7nM=;
 b=xwzIs/fM+x1qWiTYhvONsw5Tqq7YF/2A1QgwLlTZCMMPn5ZCK1A3yb7SZUI5rqNHcoNzWG
 427Vy0g1Bmv/FtygRrFHd+Xk0TBH4dC3Exw/ZVtSFk8apZzMrO2zq8hxpb5G+7l3TYImZj
 Ttjc/gAU8buWStxYH17JLoip0DD4KEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793299194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxh5Vg3fa9jpC/yim+1k52mqrz8e1+lCG5E/SDez7nM=;
 b=/DRx6MFvqeQzMDf8YF+J8mA+P8kT2nUt5rw2TCBIJXp7llUyjS029hAvQORD6X9552pURJ
 qOTXXOiDTb8Eq/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E459C13419;
 Thu, 29 Oct 2026 18:39:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7TEpIvmS42qVSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 18:39:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peterx@redhat.com, mjt@tls.msk.ru,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/2] tests/docker/dockerfiles: add release.docker
In-Reply-To: <7757e99b-0338-4508-b36f-9460d4efdb2f@oss.qualcomm.com>
References: <20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com>
 <20261029000853.15166-2-pierrick.bouvier@oss.qualcomm.com>
 <87ld7gin6q.fsf@suse.de>
 <7757e99b-0338-4508-b36f-9460d4efdb2f@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 15:39:43 -0300
Message-ID: <87fqxoic5s.fsf@suse.de>
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
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, gitlab.com:url,
 suse.de:email, qualcomm.com:email]
X-Spam-Score: -13.30
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 10/29/2026 6:41 AM, Fabiano Rosas wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> This new dockerfile allows to build a distroless image containing only
>>> qemu stripped release binaries, their lib dependencies, and installed
>>> artifacts (roms, keymap, ...). There is no shell, no python, nothing
>>> else. This is achieved thanks to a multi-stage build, where we add qemu
>>> binaries, artifacts and libraries in a new scratch image. Image has
>>> the minimal size possible.
>>>
>>> This is based on Ubuntu, which has the advantage to have working
>>> containers available down to 14.04. Debian old old stable have broken
>>> apt sources for instance.
>>>
>>> This unique dockerfile works for all qemu versions >=3D 3.1.0 (2018).
>>> We could build down to v0.12.0, but it would require more tweaks in the
>>> dockerfile, so we keep it simple instead.
>>>
>>> To build the image, you need to provide a qemu and ubuntu version:
>>> $ podman build -f release.Dockerfile --build-arg QEMU_VERSION=3Dv11.1.0=
 --build-arg UBUNTU_VERSION=3D24.04 -t qemu/v11.1.0
>>>
>>> To run it, as there is no shell, and no defined entrypoint, you need to
>>> choose the binary you want explicitely:
>>> $ podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version
>>>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>  tests/docker/dockerfiles/release.docker | 48 +++++++++++++++++++++++++
>>>  1 file changed, 48 insertions(+)
>>>  create mode 100644 tests/docker/dockerfiles/release.docker
>>>
>>> diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/doc=
kerfiles/release.docker
>>> new file mode 100644
>>> index 00000000000..ca6babde01e
>>> --- /dev/null
>>> +++ b/tests/docker/dockerfiles/release.docker
>>> @@ -0,0 +1,48 @@
>>> +ARG UBUNTU_VERSION=3D"UBUNTU_VERSION_build_arg_must_be_set"
>>> +
>>> +FROM ubuntu:$UBUNTU_VERSION AS build
>>> +
>>> +# add deb-src for apt build-dep
>>> +RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list=
.d/* || true
>>> +RUN sed -e 's/# deb-src/deb-src/' -i /etc/apt/sources.list
>>> +# archive.canonical.com is not reachable anymore, and cause a long tim=
eout
>>> +RUN sed -e '/archive.canonical.com/d' -i /etc/apt/sources.list
>>> +
>>> +# build dependencies
>>> +RUN apt update && \
>>> +env DEBIAN_FRONTEND=3Dnoninteractive apt install -y git build-essentia=
l flex bison
>>> +RUN apt update && \
>>> +env DEBIAN_FRONTEND=3Dnoninteractive apt build-dep -y --arch-only qemu
>>> +
>>> +ARG QEMU_VERSION
>>> +RUN echo "QEMU_VERSION=3D${QEMU_VERSION:?QEMU_VERSION build arg must b=
e set}"
>>> +ARG QEMU_REPO=3D"https://gitlab.com/qemu-project/qemu.git"
>>> +
>>> +RUN cd /tmp && \
>>> +mkdir qemu && cd qemu && git init && \
>>> +git remote add origin "${QEMU_REPO}" && \
>>> +git fetch origin "${QEMU_VERSION}" --depth 1 && \
>>> +git checkout FETCH_HEAD && \
>>> +./configure --prefix=3D/opt/qemu --disable-docs --disable-werror && \
>>> +make install -j $(nproc) && \
>>> +strip /opt/qemu/bin/* && \
>>=20
>> For the record, here I included a 'cp <list of bins> /opt/qemu/bin' line
>> to make migration-test work from inside the container:
>>=20
>> migration-test
>> sh
>> env
>> docker (installed as docker.io up there)
>> cat
>>
>
> You mean by mounting current folder in the container?
>

I mean having the test binary present in the container as well.

This is something specific to migration compat testing: to avoid having
issues due to features mismatches, we run the older version of
migration-test when testing two different QEMU versions.

But then...
$ git checkout <old tag>
$ make check-build
$ ./migration-test <QEMU old container> <QEMU new container>

is kind of wasteful. I can simply build a container with QEMU +
migration-test already in it and invoke:

$ ./<migration-test old container> <QEMU old container> <QEMU new container>

> I'm not against it, but I feel that if we go this way, it's just easier
> to say "let's use the full base image", since it will become "I need to
> run python, and X, and Y, and Z".
>

I think we should merge this series as is. However if we intend to use
it in the future for something more complex, something like the above
will probably come up. Anyway, I posted literally "for the record".

> What is missing to just use the container as a binary, instead of having
> to mount anything inside it?
>
>>> +rm -rf /tmp/*
>>> +
>>> +# retrieve runtime dependencies (libs)
>>> +RUN ldd /opt/qemu/bin/* | grep '=3D>' | sed -e 's/.*=3D>//' -e 's/(.*/=
/' | sort -u > /opt/qemu/libs
>>> +# store them in /deps/lib
>>> +RUN mkdir -p /deps/lib && cp --preserve --dereference $(cat /opt/qemu/=
libs) /deps/lib
>>> +# copy loader (with its original path)
>>> +RUN cp --preserve --parents --dereference /lib*/ld-linux* /deps/
>>> +
>>> +######################################################################=
##########
>>> +FROM scratch
>>> +
>>> +COPY --from=3Dbuild /deps /
>>> +# copy qemu and all associated artifacts (roms, ...)
>>> +COPY --from=3Dbuild /opt/qemu /usr
>>> +
>>> +# build with:
>>> +# podman build -f release.docker --build-arg QEMU_VERSION=3Dv11.1.0 --=
build-arg UBUNTU_VERSION=3D24.04 -t qemu/v11.1.0
>>> +# run with:
>>> +# podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version

