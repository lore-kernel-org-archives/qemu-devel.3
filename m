Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0223E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 10:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKxDn-0006if-9r; Tue, 10 Dec 2024 05:12:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKxDl-0006eR-Dn
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:12:01 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKxDj-00041E-No
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:12:01 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3dce16a3dso5272660a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 02:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733825518; x=1734430318; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vhTDro4r/f6mWZCKCYHmwwTGXttHbAv0M4/eIJv6VEA=;
 b=g1EOLFsTVhCTwdutv+cSYzxpJUlx36cBpOrny+uYuV/NBbSUtJv5SqgQNJD01b5Bxb
 gWJG4er7GmSfXd9GY40ZDTYgw+rhJkdooEq0qAA1So7mcxNCc973cda04QGoAre2+Xsl
 fSFVCN9tSDzuElciJwZtzG++BgObvOpIxaHPYzLOEYaCxJOnJaF9Eq5/oY9uSsw6djk+
 XAB0FyFzi61Vh5JiUF0Voi7tTWrctIKEEgb0LDTUdIafZJVk2XJMjkh/5A9J1hSYULtT
 /TosGhvgQtcj/ET2wTM4yaybz/cicnDl/32QucvYNZVivEzWuPAFRpwG+v2YF/eMYeSy
 Q1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733825518; x=1734430318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vhTDro4r/f6mWZCKCYHmwwTGXttHbAv0M4/eIJv6VEA=;
 b=b7qN+WGl+tDHlhp9qB+O87O7n6UQBO3jF4nxNY480GUc7TMMXt5q5opwtRIh8odvKI
 WJd89PvyGUN650PRfoYksMce6sHMmBJj5l56aErWVeuQ/sqFCLa2xQ5ZLKNfPtERPegc
 5PDOlQEIXXv4+5BchwuibnOrC0YYYm94THTNFXW4rMMp61CCrK9WYY4cR3XGWNFbPvWd
 zWKktuC6tOZ5Ldti1ZFEdV9T7a0k7YnWAnbo/KK3lo3kQUm/mAJXKmUkOauuLpKQgKYl
 BfOOuKTMZKm8ok777hX6Yi0BiTy52DquhIqbx5lYxlTZGm75qGR62j1/ozgRSFcDYO3Q
 EJoA==
X-Gm-Message-State: AOJu0YzU5lhACdGnhGg9WROh/uOJh4N39ACbLIJ3r3PCM8cE/lWvWVc2
 FYO91xqeDaYhMBFlgWWf5Izsr/Y6iz7zl+yqACZG/q3AVqbIdqyi/zPhBwrhbQG9wmW8ek4APFA
 z1akaJ/bnSgyLslfuABAZIbojqzU8JKiGnNBr8g==
X-Gm-Gg: ASbGncsIm5RQmr6e9lzFR9BPK5PmqQnD9EiHAEuhZ9IB+JQMXWOoNTihFk3kqsWte4C
 3A2LQ7Yulz4mgOhd4SseFNuR1Y3ToXM7X88rr
X-Google-Smtp-Source: AGHT+IH49xwDSmdr4eOK8NR4OVNME2OfmAZFCSGzBTylBm3mfim2yjn7O3OmPfigUGM6FnIicGMZS1yHSp37BE6/osM=
X-Received: by 2002:a05:6402:13cc:b0:5d3:e99c:6bda with SMTP id
 4fb4d7f45d1cf-5d41e36d2b7mr2896350a12.16.1733825518149; Tue, 10 Dec 2024
 02:11:58 -0800 (PST)
MIME-Version: 1.0
References: <E1tJWbk-007BH4-OB@kylie.crudebyte.com> <4261493.soTQ3n66jb@silver>
In-Reply-To: <4261493.soTQ3n66jb@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 10:11:47 +0000
Message-ID: <CAFEAcA8dL=pRJf4DNjF_NPR7npfAhUJdNb0n3fyJq=b+oKnWrg@mail.gmail.com>
Subject: Re: [PATCH] 9pfs: fix regression regarding CVE-2023-2861
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Dirk Herrendorfer <d.herrendoerfer@de.ibm.com>,
 Yanwu Shen <ywsPlz@gmail.com>, 
 Jietao Xiao <shawtao1125@gmail.com>, Jinku Li <jkli@xidian.edu.cn>, 
 Wenbo Shen <shenwenbo@zju.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 10 Dec 2024 at 09:57, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Friday, December 6, 2024 12:20:29 PM CET Christian Schoenebeck wrote:
> > The released fix for this CVE:
> >
> >   f6b0de53fb8 ("9pfs: prevent opening special files (CVE-2023-2861)")
> >
> > caused a regression with security_model=passthrough. When handling a
> > 'Tmknod' request there was a side effect that 'Tmknod' request could fail
> > as 9p server was trying to adjust permissions:
> >
> >   #6  close_if_special_file (fd=30) at ../hw/9pfs/9p-util.h:140
> >   #7  openat_file (mode=<optimized out>, flags=2228224,
> >       name=<optimized out>, dirfd=<optimized out>) at
> >       ../hw/9pfs/9p-util.h:181
> >   #8  fchmodat_nofollow (dirfd=dirfd@entry=31,
> >       name=name@entry=0x5555577ea6e0 "mysocket", mode=493) at
> >       ../hw/9pfs/9p-local.c:360
> >   #9  local_set_cred_passthrough (credp=0x7ffbbc4ace10, name=0x5555577ea6e0
> >       "mysocket", dirfd=31, fs_ctx=0x55555811f528) at
> >       ../hw/9pfs/9p-local.c:457
> >   #10 local_mknod (fs_ctx=0x55555811f528, dir_path=<optimized out>,
> >       name=0x5555577ea6e0 "mysocket", credp=0x7ffbbc4ace10) at
> >       ../hw/9pfs/9p-local.c:702
> >   #11 v9fs_co_mknod (pdu=pdu@entry=0x555558121140,
> >       fidp=fidp@entry=0x5555574c46c0, name=name@entry=0x7ffbbc4aced0,
> >       uid=1000, gid=1000, dev=<optimized out>, mode=49645,
> >       stbuf=0x7ffbbc4acef0) at ../hw/9pfs/cofs.c:205
> >   #12 v9fs_mknod (opaque=0x555558121140) at ../hw/9pfs/9p.c:3711
> >
> > That's because server was opening the special file to adjust permissions,
> > however it was using O_PATH and it would have not returned the file
> > descriptor to guest. So the call to close_if_special_file() on that branch
> > was incorrect.
> >
> > Let's lift the restriction introduced by f6b0de53fb8 such that it would
> > allow to open special files on host if O_PATH flag is supplied, not only
> > for 9p server's own operations as described above, but also for any client
> > 'Topen' request.
> >
> > It is safe to allow opening special files with O_PATH on host, because
> > O_PATH only allows path based operations on the resulting file descriptor
> > and prevents I/O such as read() and write() on that file descriptor.
> >
> > Fixes: f6b0de53fb8 ("9pfs: prevent opening special files (CVE-2023-2861)")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2337
> > Reported-by: Dirk Herrendorfer <d.herrendoerfer@de.ibm.com>
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  hw/9pfs/9p-util.h | 27 +++++++++++++++++----------
> >  1 file changed, 17 insertions(+), 10 deletions(-)
>
> Queued on 9p.next:
> https://github.com/cschoenebeck/qemu/commits/9p.next
>
> Let's see if we can still land this in 9.2.

9.2 is due to be released today, so this would need to be:
 * a fix for a critical bug
 * the bug must be a regression since 9.1
 * with a clear justification attached for why it's important
   enough to delay the release

Commit f6b0de53fb8 was in 9.1, which suggests that this isn't
a regression since 9.1 ?

thanks
-- PMM

