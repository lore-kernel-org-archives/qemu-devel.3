Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90629606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qIQsNUcu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gFTS8kWS;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qIQsNUcu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gFTS8kWS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMCdc-0005kC-Dy; Wed, 28 Oct 2026 19:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMCda-0005k0-Hu
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:00:54 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMCdY-0001Lb-LA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:00:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B19722332;
 Wed, 28 Oct 2026 23:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793228451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=luwR45voTdLoEDcNTynP37kex8DescDcjgXYj19lV/Q=;
 b=qIQsNUcuDAc6nAVp9jT3WubzutKtUhg1YDCm7tvb6oC8bumtXI1+N2WlikMEH7ni0y3kgr
 dEk5IuKpB+6Fy1mvApLgsc/KYZAiHVBpJYpWnw3arrgx1vYK0Q9L7op1mlsyMzqrAtvA6g
 8UmreiyS8v8L6EW0gQhj7CvGoJFlU08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793228451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=luwR45voTdLoEDcNTynP37kex8DescDcjgXYj19lV/Q=;
 b=gFTS8kWSfGEotOJaWt3ieUjK/DKwEi8bWj/T0YfpzwRFX4jqFAh6u7DzaeTHHxMX0NxTYi
 pjZ0ph6VN7JBPFCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793228451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=luwR45voTdLoEDcNTynP37kex8DescDcjgXYj19lV/Q=;
 b=qIQsNUcuDAc6nAVp9jT3WubzutKtUhg1YDCm7tvb6oC8bumtXI1+N2WlikMEH7ni0y3kgr
 dEk5IuKpB+6Fy1mvApLgsc/KYZAiHVBpJYpWnw3arrgx1vYK0Q9L7op1mlsyMzqrAtvA6g
 8UmreiyS8v8L6EW0gQhj7CvGoJFlU08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793228451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=luwR45voTdLoEDcNTynP37kex8DescDcjgXYj19lV/Q=;
 b=gFTS8kWSfGEotOJaWt3ieUjK/DKwEi8bWj/T0YfpzwRFX4jqFAh6u7DzaeTHHxMX0NxTYi
 pjZ0ph6VN7JBPFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8A3C13419;
 Wed, 28 Oct 2026 23:00:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +rdcG6J+4mouCAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Oct 2026 23:00:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, mjt@tls.msk.ru,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/2] tests/docker/dockerfiles: add release.docker
In-Reply-To: <20261026210801.179790-2-pierrick.bouvier@oss.qualcomm.com>
References: <20261026210801.179790-1-pierrick.bouvier@oss.qualcomm.com>
 <20261026210801.179790-2-pierrick.bouvier@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 20:00:48 -0300
Message-ID: <871p99juqn.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, qualcomm.com:email,
 canonical.com:url, suse.de:email]
X-Spam-Score: -13.30
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> This new dockerfile allows to build a distroless image containing only
> qemu stripped release binaries, their lib dependencies, and installed
> artifacts (roms, keymap, ...). There is no shell, no python, nothing
> else. This is achieved thanks to a multi-stage build, where we add qemu
> binaries, artifacts and libraries in a new scratch image. Image has
> the minimal size possible.
>
> This is based on Ubuntu, which has the advantage to have working
> containers available down to 14.04. Debian old old stable have broken
> apt sources for instance.
>
> This unique dockerfile works for all qemu versions >= 3.1.0 (2018).
> We could build down to v0.12.0, but it would require more tweaks in the
> dockerfile, so we keep it simple instead.
>
> To build the image, you need to provide a qemu and ubuntu version:
> $ podman build -f release.Dockerfile --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0
>
> To run it, as there is no shell, and no defined entrypoint, you need to
> choose the binary you want explicitely:
> $ podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/release.docker | 48 +++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/release.docker
>
> diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
> new file mode 100644
> index 00000000000..ca6babde01e
> --- /dev/null
> +++ b/tests/docker/dockerfiles/release.docker
> @@ -0,0 +1,48 @@
> +ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
> +
> +FROM ubuntu:$UBUNTU_VERSION AS build
> +
> +# add deb-src for apt build-dep
> +RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
> +RUN sed -e 's/# deb-src/deb-src/' -i /etc/apt/sources.list
> +# archive.canonical.com is not reachable anymore, and cause a long timeout
> +RUN sed -e '/archive.canonical.com/d' -i /etc/apt/sources.list
> +
> +# build dependencies
> +RUN apt update && \
> +env DEBIAN_FRONTEND=noninteractive apt install -y git build-essential flex bison
> +RUN apt update && \
> +env DEBIAN_FRONTEND=noninteractive apt build-dep -y --arch-only qemu
> +
> +ARG QEMU_VERSION
> +RUN echo "QEMU_VERSION=${QEMU_VERSION:?QEMU_VERSION build arg must be set}"
> +ARG QEMU_REPO="https://gitlab.com/qemu-project/qemu.git"
> +
> +RUN cd /tmp && \
> +mkdir qemu && cd qemu && git init && \
> +git remote add origin "${QEMU_REPO}" && \
> +git fetch origin "${QEMU_VERSION}" --depth 1 && \
> +git checkout FETCH_HEAD && \
> +./configure --prefix=/opt/qemu --disable-docs --disable-werror && \
> +make install -j $(nproc) && \
> +strip /opt/qemu/bin/* && \
> +rm -rf /tmp/*
> +
> +# retrieve runtime dependencies (libs)
> +RUN ldd /opt/qemu/bin/* | grep '=>' | sed -e 's/.*=>//' -e 's/(.*//' | sort -u > /opt/qemu/libs
> +# store them in /deps/lib
> +RUN mkdir -p /deps/lib && cp --preserve --dereference $(cat /opt/qemu/libs) /deps/lib
> +# copy loader (with its original path)
> +RUN cp --preserve --parents --dereference /lib*/ld-linux* /deps/
> +
> +################################################################################
> +FROM scratch
> +
> +COPY --from=build /deps /
> +# copy qemu and all associated artifacts (roms, ...)
> +COPY --from=build /opt/qemu /usr
> +
> +# build with:
> +# podman build -f release.docker --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0
> +# run with:
> +# podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version

Reviewed-by: Fabiano Rosas <farosas@suse.de>

