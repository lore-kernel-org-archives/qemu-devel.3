Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB26606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ovjKIKaK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YHWDHa9m;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ovjKIKaK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YHWDHa9m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRLk-0003LU-0n; Thu, 29 Oct 2026 10:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMRLi-0003LE-Cl
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:43:26 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMRLg-00084c-Ie
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:43:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E88A1F863;
 Thu, 29 Oct 2026 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793285003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYugPvjJ2WVDlzrqItQHn+4Or1Bz4IfCofWykTqQyKM=;
 b=ovjKIKaKtkwqazheSEz/vpve4lGutj5JR7OOLosc+YT39NORIFOhq4VO63oLNsrR3POnxH
 Ln721tKUdX3FR2+rqjBMh+zt8XOuH0iZxAnn2L6gW4sgFrfNS/U21nGCZ39ZS9KNJnLcjh
 hZXNTEEQGWIgtrtoZXDsNV/iXuBm2uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793285003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYugPvjJ2WVDlzrqItQHn+4Or1Bz4IfCofWykTqQyKM=;
 b=YHWDHa9mzFCvROtvuA13/Yrm3V+MeCNT6FCiooZ1XjAKQVim1OWV7oALrazY8hwkxQf+dl
 qYtHeiVVkVWEzCBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ovjKIKaK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YHWDHa9m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793285003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYugPvjJ2WVDlzrqItQHn+4Or1Bz4IfCofWykTqQyKM=;
 b=ovjKIKaKtkwqazheSEz/vpve4lGutj5JR7OOLosc+YT39NORIFOhq4VO63oLNsrR3POnxH
 Ln721tKUdX3FR2+rqjBMh+zt8XOuH0iZxAnn2L6gW4sgFrfNS/U21nGCZ39ZS9KNJnLcjh
 hZXNTEEQGWIgtrtoZXDsNV/iXuBm2uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793285003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYugPvjJ2WVDlzrqItQHn+4Or1Bz4IfCofWykTqQyKM=;
 b=YHWDHa9mzFCvROtvuA13/Yrm3V+MeCNT6FCiooZ1XjAKQVim1OWV7oALrazY8hwkxQf+dl
 qYtHeiVVkVWEzCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90A331339F;
 Thu, 29 Oct 2026 14:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7B2TDYpb42p5UgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 14:43:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peterx@redhat.com, mjt@tls.msk.ru,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/2] scripts: add build_release_container.sh
In-Reply-To: <20261029000853.15166-3-pierrick.bouvier@oss.qualcomm.com>
References: <20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com>
 <20261029000853.15166-3-pierrick.bouvier@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:43:16 -0300
Message-ID: <87ik2kin3v.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Rspamd-Queue-Id: 1E88A1F863
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

> This script allows to easily build a qemu release container, based on
> dockerfile introduced in previous commit.
>
> It names image "qemu/$version" and automatically detects which ubuntu
> version should be used to build it.
>
> $ ./scripts/build_release_container.sh v3.1.0
> $ podman run -it --rm qemu/v3.1.0 qemu-system-arm --version
> QEMU emulator version 3.1.0 (-dirty)
> Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  scripts/build_release_container.sh | 63 ++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100755 scripts/build_release_container.sh
>
> diff --git a/scripts/build_release_container.sh b/scripts/build_release_c=
ontainer.sh
> new file mode 100755
> index 00000000000..7dd477deea8
> --- /dev/null
> +++ b/scripts/build_release_container.sh
> @@ -0,0 +1,63 @@
> +#!/usr/bin/env bash
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +set -euo pipefail
> +
> +script_dir=3D$(dirname $(readlink -f $0))
> +
> +# The oldest buildable release we support is v3.1.0, as previous ones re=
quire
> +# additional tweaks in Dockerfile.
> +# For building previous releases (down to v0.12.0),
> +# see: 20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com
> +oldest_release=3Dv3.1.0
> +
> +if [ $# -lt 1 ] || [ $# -gt 2 ]; then
> +    echo "usage: version [git_repo]"
> +    echo
> +    echo "- version: tag or sha-1 (>=3D v3.1.0)"
> +    echo "- git_repo: (optional) QEMU repository URL"
> +    exit 1
> +fi
> +version=3D$1;shift
> +
> +git_repo=3D"https://gitlab.com/qemu-project/qemu.git"
> +if [ $# -eq 1 ]; then
> +    git_repo=3D$1;shift
> +fi
> +
> +year=3D$(date +%Y)
> +month=3D$(date +%m)
> +if git rev-parse $version >& /dev/null; then
> +    year=3D$(git log -1 --format=3D'%cd' --date=3D'format:%Y' $version)
> +    month=3D$(git log -1 --format=3D'%cd' --date=3D'format:%m' $version)
> +fi
> +
> +# Ubuntu LTS are published every (even) two years in April.
> +ubuntu=3D
> +if [ $((year % 2)) -eq 1 ]; then
> +    # pick latest LTS from previous year
> +    ubuntu=3D$((year - 1))
> +elif [ $month -gt 6 ]; then
> +    # LTS published this year should work
> +    ubuntu=3D$year
> +else
> +    # pick latest LTS from two years ago
> +    ubuntu=3D$((year - 2))
> +fi
> +if [ $ubuntu -lt 2014 ]; then
> +    # oldest ubuntu release available with containers is 14.04
> +    ubuntu=3D2014
> +fi
> +ubuntu=3D$((ubuntu - 2000))
> +ubuntu_version=3D$ubuntu.04
> +
> +dockerfile=3D$script_dir/../tests/docker/dockerfiles/release.docker
> +docker=3D$($script_dir/../tests/docker/docker.py probe)
> +
> +set -x
> +$docker build . \
> +    -f $dockerfile \
> +    --build-arg QEMU_VERSION=3D$version \
> +    --build-arg UBUNTU_VERSION=3D$ubuntu_version \
> +    --build-arg QEMU_REPO=3D"$git_repo" \
> +    -t qemu/$version

I have successfully tested the migration-next branch with this
series. It's a great improvement over what I had before. Thank you for
this work.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

