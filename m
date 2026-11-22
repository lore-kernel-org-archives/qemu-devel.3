Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD6606A32A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ct+K/Ukl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVCoK-0004GD-B5; Sun, 22 Nov 2026 14:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xVCo2-0004Fn-QM
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 14:00:55 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xVCny-0006py-SR
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 14:00:54 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6798eb0d190so2105964d50.3
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 11:00:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795374049; cv=none;
 d=google.com; s=arc-20260327;
 b=eMXUPQhTnOP0Av+zTL6NQKivCqTDX2NEw6PsMgTQ+qOwEv0LqAXAluJByupfAay9sY
 MS2oDV1vXDbcehGZZfSx4x44xe/G963tcFPNupd4ZGhCgDTO/gOzhP5j3VVK39a0a2W0
 jR11XXux3YiYhkTPWoPu0dAAyau++yreV8qlSIwlgDp3IL7XJQxSXirac2OhIK2BvjA3
 qmyLmQkDQgXJOpEKNqN3vTYgLxGsb6Aolm1UmuePvYdqQRLn3zmuVSo5tUNFUQzFOzoG
 PT9rhpqJFPRVfe5lXxOpH3YtCIuCIG401Iy//SEn+Tzflz0WxJVd1OPl4e0ITfVjvUk6
 fKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sf6eII80TLBwiAOLlgBaBFRmSHzu6haclFH74tOKVl8=;
 fh=S0xZDyzG7m6urn+4/d1LFZSq7dP0PRL81vPPzbAWPGY=;
 b=WcdJDDjo/a0VqZ2V1D2tEaeGEoDbuuVLUknXzctNhMB4XwFn6H3rslV5YBEUjOkOfU
 23fCa7vTZZ8Pg/YsjvlCc7zgxnCRwaffdarRhCKtjPWGugBIe5nkHMdZZ1Wjn88Td/f+
 EIsjHWR2sF9dWmYPV4jaPZ7AakxosV5yYKGxaMsQR7EOTZBPV7HTO4wa+rDiLhVh57y8
 S2bWvklyKNdxFQ4jFu9filVtbvCTgIVAu3nLKgjozMWsyKAv6SatQ5WRJdiatyvFjHNG
 g9uLR0KiZuAZzM5glzr9iy2B1CpYD6Gl17LjMDIrQUSrBPVc0Wov/mnEy0HNksWOCElm
 0c+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795374049; x=1795978849; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sf6eII80TLBwiAOLlgBaBFRmSHzu6haclFH74tOKVl8=;
 b=Ct+K/UklOBMYloJfhSmhVEJ5z5NjrSDFC9BhKM6ODUDRIbYWNwuSLFcF1r5fsJFApY
 bBwbNtpyvDWZO0EKHa4FFwitgXkCV/eT7M+wYdwu73pRvwkHf5xnRWmJc+gePegnDbGA
 3Bt2xcQeo9XEZ8rHF4tEAeQixE5CjaLK2lKCYy+AUWJ/vfdvmL9NZ38oRodPLanfGsWT
 ESw3V6vBE5MshPRg0RrJSSFM2raGvVPOnjYAB8+YGt4X7MnKr2/sTm1badiQmHSl+SV9
 fddGpR2aG+Y6h3v4c+/ZUSggEK7DZ7hTCHv1xqaJyx5WVOoDXzLcF6kIYGKcmIhbFjVu
 PE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795374049; x=1795978849;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sf6eII80TLBwiAOLlgBaBFRmSHzu6haclFH74tOKVl8=;
 b=t8rhC94q7CZrzIBi+cRWr18UX0Ze5wTAAUjH+Pwisor+Ylv/6P4IGDvc3LpCtKL9tE
 jIqiMW06hFKU5IW42Oo2FYKWmxNweExsRzZvcP9+ShVu6SuxpsRBDrdnFnmfHIx5joxY
 DdMxHD6PWdQcBzsh7AzZU7EaRxEzOLlej5pugvkl2pMoQiYmQs/Osw4+1xUsb+LXBYHB
 Vepmm3O9Wou8ZcJDQPuS3mUKB8V+gFtSs59SmCre5vWwuKCNiUPnmW3q+D2vzNEM1GQ4
 1+VkRRMvE0QIUKt5hpmgUSRAoSfAO2UflqIs2ThbxyArEMPjEie+juthXWENjxvJsSz9
 WzwA==
X-Gm-Message-State: APuU4Z/ZYqvSMIk11K5IDS099Tx4tbe+n2yzOn44MpMHjOEb1uR9eGHf
 M/4jlQ0BdyhN1Q65SmilD38lZZvPiTTNwTORNLGmqAo+38JO1MWLzwCTRTCHISdDU08repzKcpg
 +bZo+Y0q98/wBizYZf4ucY6tP23jqDMU=
X-Gm-Gg: AZFdTZe4Vhshl2+Al/+J4fxw6E0Opta4wCqZwYAVvaz92w0+ptmycams5KH2i87M6JR
 dUmmeGC7gUAtAHoO27CLr+sPUjtLmtitGZAsJj0TIlfmkcycM6Xyyo8eAjyxQ3tisGPbLKEDvC6
 d6u9VlcAX/aPJK2m8gOGL8InsxDI9wz8vabgtn7zuu8n/lO2rc9JXCy2hUs1SvBeIzaQyEeWoCN
 XO63473em/mLsFLlCsdnsoYr8W0xBVQ5V+DKE/huwr8xzDj/e2nzx482VnxCum/S/GeKI8MILjC
 2G8zAWPHxtT7KYu+bfA1t67vL5umnaUeV9wsIM388ow3zyBNWJzJhftP+marm5xh0wXO2qQqNk4
 GoKvCs8QHTmJDc0HOl++hsbbyglDfv2UWCA6KhmFvZjrNFmApAvG45OQ4DbXdIATSdrzzloHidy
 VVnh7Q9Y2LWP87iMjfpElTcRXQPJ1jwFUwzdQPs/uj3dzrbNom6A==
X-Received: by 2002:a05:690e:4002:b0:67c:1aab:4e90 with SMTP id
 956f58d0204a3-67df44aa3camr3854977d50.107.1795374048752; Sun, 22 Nov 2026
 11:00:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025131700.34930-1-ralerrdirsardx@gmail.com>
 <20261025152314.49954-1-ralerrdirsardx@gmail.com>
 <CAGHp__YOsuwOR+2NdwPmV2qp5az96EbsmhiFgjQmVMvC4DT+LA@mail.gmail.com>
 <9ed93ce9-7443-4f3d-a977-fdcbcb5e97cc@gmx.de>
In-Reply-To: <9ed93ce9-7443-4f3d-a977-fdcbcb5e97cc@gmx.de>
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
Date: Sun, 22 Nov 2026 22:00:37 +0300
X-Gm-Features: Aa3M54oEJnAgVoCbDwo3o3JicYnaUVkicDQvhk8821W5Ud8KJzi9u97uY1kb8rQ
Message-ID: <CAGHp__aoZLhk_++MGPGYZPy_zWQtrnwnjgd4jmPCaWC8UkvnVQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: honor dirfd for synthetic proc opens
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=ralerrdirsardx@gmail.com; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Thanks for queuing the patch. It also fixes the HPPA case reported in
QEMU issue #2004.

On the parent commit (8f66cb79), the test from the issue returned the
x86 host's cpu info when opening cpuinfo relative to a directory fd
for /proc. Opening /proc/cpuinfo by its absolute path returned the
emulated PA-RISC cpu info.

With ea62db5e, both calls reported PA7300LC (PCX-L2). Their outputs
matched byte for byte in all five runs (1,332 bytes each).

https://gitlab.com/qemu-project/qemu/-/issues/2004
https://github.com/hdeller/qemu-hppa/commit/ea62db5e88bbfe2ea3de81d41aa29b0=
29962425f

Best,
Artemii

=D0=B2=D1=81, 22 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 19:0=
7, Helge Deller <deller@gmx.de>:
>
> On 11/17/26 09:31, Artemii Mashanov wrote:
> > Hi,
> >
> > Ping on this patch. Could someone please take a look when time permits?
> >
> > Please let me know if any changes or additional testing are needed.
>
> I've queued this patch up for qemu v12.0.
>
> Overall I'm not happy how we handle the relative paths when running
> outside of a chroot. I think this something we should take a closer
> look during the next release cycle.
>
> Thanks!
> Helge
> > Thanks,
> > Artemii
> >
> > =D0=B2=D1=81, 25 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 18:23,=
 Artemii Mashanov <ralerrdirsardx@gmail.com>:
> >>
> >> Opening "<pid>/cmdline" relative to a directory descriptor for /proc
> >> can return QEMU's command line instead of the guest's.
> >>
> >> Honor dirfd when selecting synthetic proc contents and add regression
> >> coverage for openat and openat2.
> >>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4458
> >> Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
> >> ---
> >>   linux-user/syscall.c                     | 321 +++++++++++++++++----=
--
> >>   tests/tcg/multiarch/linux/proc-openat.c  |  94 +++++++
> >>   tests/tcg/multiarch/linux/proc-openat2.c |  83 ++++++
> >>   tests/tcg/multiarch/meson.build          |   2 +
> >>   4 files changed, 418 insertions(+), 82 deletions(-)
> >>   create mode 100644 tests/tcg/multiarch/linux/proc-openat.c
> >>   create mode 100644 tests/tcg/multiarch/linux/proc-openat2.c
> >>
> >> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> >> index 0380691a8b..0583e7e19d 100644
> >> --- a/linux-user/syscall.c
> >> +++ b/linux-user/syscall.c
> >> @@ -8839,12 +8839,132 @@ static int open_net_route(CPUArchState *cpu_e=
nv, int fd)
> >>   }
> >>   #endif
> >>
> >> -static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
> >> -                              const char *fname, int flags, mode_t mo=
de,
> >> -                              int openat2_resolve, bool safe)
> >> +static char *proc_entry_path(int dirfd, const char *name)
> >> +{
> >> +    g_autofree char *base =3D NULL;
> >> +    g_autofree char *absolute =3D NULL;
> >> +    g_autofree char *parent =3D NULL;
> >> +    g_autofree char *resolved =3D NULL;
> >> +    g_autofree char *entry =3D NULL;
> >> +    char fd_path[64];
> >> +
> >> +    if (!name[0]) {
> >> +        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", dirfd)=
;
> >> +        return g_file_read_link(fd_path, NULL);
> >> +    }
> >> +    if (name[0] =3D=3D '/') {
> >> +        absolute =3D g_strdup(name);
> >> +    } else {
> >> +        if (dirfd =3D=3D AT_FDCWD) {
> >> +            base =3D getcwd(NULL, 0);
> >> +        } else {
> >> +            snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", di=
rfd);
> >> +            base =3D g_file_read_link(fd_path, NULL);
> >> +        }
> >> +        if (!base) {
> >> +            return NULL;
> >> +        }
> >> +        absolute =3D g_build_filename(base, name, NULL);
> >> +    }
> >> +    parent =3D g_path_get_dirname(absolute);
> >> +    resolved =3D realpath(parent, NULL);
> >> +    if (!resolved) {
> >> +        return NULL;
> >> +    }
> >> +    entry =3D g_path_get_basename(absolute);
> >> +    return g_build_filename(resolved, entry, NULL);
> >> +}
> >> +
> >> +static int fake_open_contents(CPUArchState *cpu_env,
> >> +                              int (*fill)(CPUArchState *, int),
> >> +                              int status_flags, bool safe)
> >> +{
> >> +    g_autofree char *filename =3D NULL;
> >> +    const char *tmpdir =3D g_get_tmp_dir();
> >> +    const char *reader_path;
> >> +    char fd_path[64];
> >> +    bool named =3D status_flags & O_NOFOLLOW;
> >> +    int fd, reader =3D -1, result =3D -1, saved_errno;
> >> +
> >> +retry:
> >> +    if (named) {
> >> +        g_free(filename);
> >> +        filename =3D g_build_filename(tmpdir, "qemu-open.XXXXXX", NUL=
L);
> >> +        fd =3D g_mkstemp_full(filename, O_RDWR | O_CLOEXEC, 0600);
> >> +        if (fd < 0 && strcmp(tmpdir, P_tmpdir) &&
> >> +            errno !=3D EMFILE && errno !=3D ENFILE &&
> >> +            errno !=3D ENOMEM && errno !=3D EINTR) {
> >> +            tmpdir =3D P_tmpdir;
> >> +            goto retry;
> >> +        }
> >> +    } else {
> >> +        fd =3D memfd_create("qemu-open", MFD_CLOEXEC);
> >> +    }
> >> +    if (fd < 0) {
> >> +        if (!named && (errno =3D=3D ENOSYS || errno =3D=3D EPERM)) {
> >> +            named =3D true;
> >> +            goto retry;
> >> +        }
> >> +        return -1;
> >> +    }
> >> +    if (fill(cpu_env, fd)) {
> >> +        goto out;
> >> +    }
> >> +    if (named) {
> >> +        int closed =3D close(fd);
> >> +
> >> +        fd =3D -1;
> >> +        if (closed < 0) {
> >> +            goto out;
> >> +        }
> >> +        reader_path =3D filename;
> >> +    } else {
> >> +        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", fd);
> >> +        reader_path =3D fd_path;
> >> +    }
> >> +    reader =3D safe ? safe_openat(AT_FDCWD, reader_path, status_flags=
, 0) :
> >> +                    openat(AT_FDCWD, reader_path, status_flags, 0);
> >> +    if (reader < 0) {
> >> +        if (!named && errno =3D=3D EMFILE) {
> >> +            close(fd);
> >> +            named =3D true;
> >> +            goto retry;
> >> +        }
> >> +        goto out;
> >> +    }
> >> +    result =3D named ? reader : dup3(reader, fd, status_flags & O_CLO=
EXEC);
> >> +    if (result >=3D 0) {
> >> +        if (named) {
> >> +            reader =3D -1;
> >> +        } else {
> >> +            fd =3D -1;
> >> +        }
> >> +    }
> >> +out:
> >> +    saved_errno =3D errno;
> >> +    if (reader >=3D 0) {
> >> +        close(reader);
> >> +    }
> >> +    if (fd >=3D 0) {
> >> +        close(fd);
> >> +    }
> >> +    if (named) {
> >> +        unlink(filename);
> >> +    }
> >> +    errno =3D saved_errno;
> >> +    return result;
> >> +}
> >> +
> >> +static int maybe_do_fake_open(CPUArchState *cpu_env, int opened_fd, i=
nt dirfd,
> >> +                              const char *fname,
> >> +                              const struct open_how_ver0 *how,
> >> +                              bool safe)
> >>   {
> >>       g_autofree char *proc_name =3D NULL;
> >> +    char fd_path[64];
> >>       const char *pathname;
> >> +    int flags =3D how->flags;
> >> +    int original_errno =3D errno;
> >>       struct fake_open {
> >>           const char *filename;
> >>           int (*fill)(CPUArchState *cpu_env, int fd);
> >> @@ -8869,26 +8989,70 @@ static int maybe_do_fake_open(CPUArchState *cp=
u_env, int dirfd,
> >>           { NULL, NULL, NULL }
> >>       };
> >>
> >> -    /* if this is a file from /proc/ filesystem, expand full name */
> >> -    proc_name =3D realpath(fname, NULL);
> >> -    if (proc_name && strncmp(proc_name, "/proc/", 6) =3D=3D 0) {
> >> -        pathname =3D proc_name;
> >> -    } else {
> >> -        pathname =3D fname;
> >> +    if (opened_fd >=3D 0 &&
> >> +        ((flags & (O_PATH | O_NOFOLLOW)) =3D=3D (O_PATH | O_NOFOLLOW)=
)) {
> >> +        return opened_fd;
> >> +    }
> >> +    if (opened_fd < 0 && original_errno !=3D ENOENT) {
> >> +        return opened_fd;
> >>       }
> >>
> >> -    if (is_proc_myself(pathname, "exe")) {
> >> -        /* Honor openat2 resolve flags */
> >> -        if ((openat2_resolve & RESOLVE_NO_MAGICLINKS) ||
> >> -            (openat2_resolve & RESOLVE_NO_SYMLINKS)) {
> >> -            errno =3D ELOOP;
> >> -            return -1;
> >> +    if (opened_fd >=3D 0 && !(flags & O_NOFOLLOW) &&
> >> +        !(how->resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH |
> >> +                           RESOLVE_NO_SYMLINKS | RESOLVE_NO_MAGICLINK=
S))) {
> >> +        struct stat opened, executable;
> >> +
> >> +        if (fstat(opened_fd, &opened) =3D=3D 0 &&
> >> +            stat("/proc/self/exe", &executable) =3D=3D 0 &&
> >> +            opened.st_dev =3D=3D executable.st_dev &&
> >> +            opened.st_ino =3D=3D executable.st_ino) {
> >> +            g_autofree char *entry =3D proc_entry_path(dirfd, fname);
> >> +
> >> +            if (entry && is_proc_myself(entry, "exe")) {
> >> +                close(opened_fd);
> >> +                if (how->resolve) {
> >> +                    return safe_openat2(AT_FDCWD, real_exec_path,
> >> +                                        how, sizeof(*how));
> >> +                }
> >> +                return safe ? safe_openat(AT_FDCWD, real_exec_path,
> >> +                                          flags, how->mode) :
> >> +                       openat(AT_FDCWD, real_exec_path, flags, how->m=
ode);
> >> +            }
> >>           }
> >> -        if (safe) {
> >> -            return safe_openat(dirfd, real_exec_path, flags, mode);
> >> -        } else {
> >> -            return openat(dirfd, real_exec_path, flags, mode);
> >> +    }
> >> +
> >> +    if (opened_fd < 0) {
> >> +        g_autofree char *parent =3D g_path_get_dirname(fname);
> >> +        g_autofree char *entry =3D g_path_get_basename(fname);
> >> +        g_autofree char *directory =3D NULL;
> >> +        struct open_how_ver0 parent_how =3D {
> >> +            .flags =3D O_PATH | O_DIRECTORY | O_CLOEXEC,
> >> +            .resolve =3D how->resolve,
> >> +        };
> >> +        int fd;
> >> +
> >> +        fd =3D how->resolve ?
> >> +             safe_openat2(dirfd, parent, &parent_how, sizeof(parent_h=
ow)) :
> >> +             safe ? safe_openat(dirfd, parent, parent_how.flags, 0) :
> >> +                    openat(dirfd, parent, parent_how.flags, 0);
> >> +        if (fd >=3D 0) {
> >> +            snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", fd=
);
> >> +            directory =3D g_file_read_link(fd_path, NULL);
> >> +            close(fd);
> >> +            if (directory) {
> >> +                proc_name =3D g_build_filename(directory, entry, NULL=
);
> >> +            }
> >>           }
> >> +    } else {
> >> +        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", opened=
_fd);
> >> +        proc_name =3D g_file_read_link(fd_path, NULL);
> >> +    }
> >> +    pathname =3D proc_name;
> >> +
> >> +    if ((opened_fd >=3D 0 && (flags & O_PATH)) ||
> >> +        !pathname || strncmp(pathname, "/proc/", 6)) {
> >> +        errno =3D original_errno;
> >> +        return opened_fd;
> >>       }
> >>
> >>       for (fake_open =3D fakes; fake_open->filename; fake_open++) {
> >> @@ -8898,60 +9062,52 @@ static int maybe_do_fake_open(CPUArchState *cp=
u_env, int dirfd,
> >>       }
> >>
> >>       if (fake_open->filename) {
> >> -        const char *tmpdir;
> >> -        char filename[PATH_MAX];
> >> -        int fd, r;
> >> -
> >> -        fd =3D memfd_create("qemu-open", 0);
> >> -        if (fd < 0) {
> >> -            if (errno !=3D ENOSYS) {
> >> -                return fd;
> >> -            }
> >> -            /* create temporary file to map stat to */
> >> -            tmpdir =3D getenv("TMPDIR");
> >> -            if (!tmpdir)
> >> -                tmpdir =3D "/tmp";
> >> -            snprintf(filename, sizeof(filename), "%s/qemu-open.XXXXXX=
", tmpdir);
> >> -            fd =3D mkstemp(filename);
> >> -            if (fd < 0) {
> >> -                return fd;
> >> -            }
> >> -            unlink(filename);
> >> -        }
> >> -
> >> -        if ((r =3D fake_open->fill(cpu_env, fd))) {
> >> -            int e =3D errno;
> >> -            close(fd);
> >> -            errno =3D e;
> >> -            return r;
> >> +        int saved_errno, status_flags;
> >> +
> >> +        status_flags =3D flags & ~(O_CREAT | O_EXCL | O_TRUNC);
> >> +        if (opened_fd >=3D 0) {
> >> +            status_flags =3D fcntl(opened_fd, F_GETFL);
> >> +            saved_errno =3D errno;
> >> +            close(opened_fd);
> >> +            if (status_flags < 0) {
> >> +                errno =3D saved_errno;
> >> +                return -1;
> >> +            }
> >> +        } else if (flags & O_DIRECTORY) {
> >> +            errno =3D ENOTDIR;
> >> +            return -1;
> >> +        } else if ((flags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_E=
XCL)) {
> >> +            errno =3D EEXIST;
> >> +            return -1;
> >>           }
> >> -        lseek(fd, 0, SEEK_SET);
> >>
> >> -        return fd;
> >> +        status_flags |=3D flags & O_CLOEXEC;
> >> +        return fake_open_contents(cpu_env, fake_open->fill, status_fl=
ags, safe);
> >>       }
> >>
> >> -    return -2;
> >> +    errno =3D original_errno;
> >> +    return opened_fd;
> >>   }
> >>
> >>   int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pa=
thname,
> >>                       int flags, mode_t mode, bool safe)
> >>   {
> >> -    int fd =3D maybe_do_fake_open(cpu_env, dirfd, pathname, flags, mo=
de, 0, safe);
> >> -    if (fd > -2) {
> >> -        return fd;
> >> -    }
> >> +    struct open_how_ver0 how =3D { .flags =3D flags, .mode =3D mode }=
;
> >> +    const char *host_name =3D path(pathname);
> >> +    int fd;
> >>
> >>       if (safe) {
> >> -        return safe_openat(dirfd, path(pathname), flags, mode);
> >> +        fd =3D safe_openat(dirfd, host_name, flags, mode);
> >>       } else {
> >> -        return openat(dirfd, path(pathname), flags, mode);
> >> +        fd =3D openat(dirfd, host_name, flags, mode);
> >>       }
> >> +    return maybe_do_fake_open(cpu_env, fd, dirfd, host_name, &how,
> >> +                              safe);
> >>   }
> >>
> >> -
> >>   static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
> >> -                      abi_ptr guest_pathname, abi_ptr guest_open_how,
> >> -                      abi_ulong guest_size)
> >> +                     abi_ptr guest_pathname, abi_ptr guest_open_how,
> >> +                     abi_ulong guest_size)
> >>   {
> >>       struct open_how_ver0 how =3D {0};
> >>       char *pathname;
> >> @@ -8981,23 +9137,19 @@ static int do_openat2(CPUArchState *cpu_env, a=
bi_long dirfd,
> >>       how.flags =3D target_to_host_bitmask(tswap64(how.flags), fcntl_f=
lags_tbl);
> >>       how.mode =3D tswap64(how.mode);
> >>       how.resolve =3D tswap64(how.resolve);
> >> -    int fd =3D maybe_do_fake_open(cpu_env, dirfd, pathname, how.flags=
, how.mode,
> >> -                                how.resolve, true);
> >> -    if (fd > -2) {
> >> -        ret =3D get_errno(fd);
> >> -    } else {
> >> -        const char *host_pathname =3D pathname;
> >> -        if (pathname[0] =3D=3D '/' &&
> >> -            !(how.resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH))) {
> >> -            /*
> >> -             * RESOLVE_BENEATH rejects absolute paths; RESOLVE_IN_ROO=
T
> >> -             * resolves them relative to dirfd.
> >> -             */
> >> -            host_pathname =3D path(pathname);
> >> -        }
> >> -        ret =3D get_errno(safe_openat2(dirfd, host_pathname, &how,
> >> -                                     sizeof(struct open_how_ver0)));
> >> +    const char *host_pathname =3D pathname;
> >> +    if (pathname[0] =3D=3D '/' &&
> >> +        !(how.resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH))) {
> >> +        /*
> >> +         * RESOLVE_BENEATH rejects absolute paths; RESOLVE_IN_ROOT
> >> +         * resolves them relative to dirfd.
> >> +         */
> >> +        host_pathname =3D path(pathname);
> >>       }
> >> +    int fd =3D safe_openat2(dirfd, host_pathname, &how,
> >> +                         sizeof(struct open_how_ver0));
> >> +    ret =3D get_errno(maybe_do_fake_open(cpu_env, fd, dirfd, host_pat=
hname, &how,
> >> +                                      true));
> >>
> >>       fd_trans_unregister(ret);
> >>       unlock_user(pathname, guest_pathname, 0);
> >> @@ -9034,6 +9186,19 @@ ssize_t do_guest_readlink(const char *pathname,=
 char *buf, size_t bufsiz)
> >>       return ret;
> >>   }
> >>
> >> +static ssize_t do_guest_readlinkat(int dirfd, const char *pathname,
> >> +                                  char *buf, size_t bufsiz)
> >> +{
> >> +    const char *host_name =3D path(pathname);
> >> +    g_autofree char *entry_path =3D proc_entry_path(dirfd, host_name)=
;
> >> +    ssize_t ret =3D readlinkat(dirfd, host_name, buf, bufsiz);
> >> +
> >> +    if (ret >=3D 0 && entry_path && is_proc_myself(entry_path, "exe")=
) {
> >> +        return do_guest_readlink(entry_path, buf, bufsiz);
> >> +    }
> >> +    return ret;
> >> +}
> >> +
> >>   static int do_execv(CPUArchState *cpu_env, int dirfd,
> >>                       abi_long pathname, abi_long guest_argp,
> >>                       abi_long guest_envp, int flags, bool is_execveat=
)
> >> @@ -11143,16 +11308,8 @@ static abi_long do_syscall1(CPUArchState *cpu=
_env, int num, abi_long arg1,
> >>               } else if (!arg4) {
> >>                   /* Short circuit this for the magic exe check. */
> >>                   ret =3D -TARGET_EINVAL;
> >> -            } else if (is_proc_myself((const char *)p, "exe")) {
> >> -                /*
> >> -                 * Don't worry about sign mismatch as earlier mapping
> >> -                 * logic would have thrown a bad address error.
> >> -                 */
> >> -                ret =3D MIN(strlen(real_exec_path), arg4);
> >> -                /* We cannot NUL terminate the string. */
> >> -                memcpy(p2, real_exec_path, ret);
> >>               } else {
> >> -                ret =3D get_errno(readlinkat(arg1, path(p), p2, arg4)=
);
> >> +                ret =3D get_errno(do_guest_readlinkat(arg1, p, p2, ar=
g4));
> >>               }
> >>               unlock_user(p2, arg3, ret);
> >>               unlock_user(p, arg2, 0);
> >> diff --git a/tests/tcg/multiarch/linux/proc-openat.c b/tests/tcg/multi=
arch/linux/proc-openat.c
> >> new file mode 100644
> >> index 0000000000..4af2fde113
> >> --- /dev/null
> >> +++ b/tests/tcg/multiarch/linux/proc-openat.c
> >> @@ -0,0 +1,94 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +#define _GNU_SOURCE
> >> +#include <assert.h>
> >> +#include <errno.h>
> >> +#include <fcntl.h>
> >> +#include <stdlib.h>
> >> +#include <string.h>
> >> +#include <sys/resource.h>
> >> +#include <unistd.h>
> >> +
> >> +static char expected[16384];
> >> +static size_t expected_size;
> >> +
> >> +static void check(int dirfd, const char *name, int flags, int expecte=
d_errno)
> >> +{
> >> +    char actual[sizeof(expected)];
> >> +    size_t size =3D 0;
> >> +    int fd =3D openat(dirfd, name, flags);
> >> +
> >> +    if (expected_errno) {
> >> +        assert(fd =3D=3D -1 && errno =3D=3D expected_errno);
> >> +        return;
> >> +    }
> >> +    assert(fd >=3D 0);
> >> +    assert((fcntl(fd, F_GETFD) & FD_CLOEXEC) =3D=3D
> >> +           ((flags & O_CLOEXEC) ? FD_CLOEXEC : 0));
> >> +    assert((fcntl(fd, F_GETFL) & (O_PATH | O_NOFOLLOW | O_ACCMODE)) =
=3D=3D
> >> +           (flags & (O_PATH | O_NOFOLLOW | O_ACCMODE)));
> >> +    if (flags & O_PATH) {
> >> +        assert(read(fd, actual, 1) =3D=3D -1 && errno =3D=3D EBADF);
> >> +    } else {
> >> +        for (;;) {
> >> +            ssize_t n =3D read(fd, actual + size, sizeof(actual) - si=
ze);
> >> +
> >> +            if (n < 0 && errno =3D=3D EINTR) {
> >> +                continue;
> >> +            }
> >> +            assert(n >=3D 0);
> >> +            if (!n) {
> >> +                break;
> >> +            }
> >> +            size +=3D n;
> >> +            assert(size < sizeof(actual));
> >> +        }
> >> +        assert(size =3D=3D expected_size && !memcmp(actual, expected,=
 size));
> >> +        assert(write(fd, "x", 1) =3D=3D -1 && errno =3D=3D EBADF);
> >> +    }
> >> +    assert(close(fd) =3D=3D 0);
> >> +}
> >> +
> >> +int main(int argc, char **argv)
> >> +{
> >> +    struct rlimit saved, limit;
> >> +    int cwd =3D open(".", O_PATH | O_DIRECTORY | O_CLOEXEC);
> >> +    int proc =3D open("/proc", O_PATH | O_DIRECTORY | O_CLOEXEC);
> >> +    int self =3D open("/proc/self", O_PATH | O_DIRECTORY | O_CLOEXEC)=
;
> >> +    int flags =3D O_RDONLY | O_CLOEXEC;
> >> +
> >> +    assert(cwd >=3D 0 && proc >=3D 0 && self >=3D 0);
> >> +    for (int i =3D 0; i < argc; i++) {
> >> +        size_t size =3D strlen(argv[i]) + 1;
> >> +
> >> +        assert(size <=3D sizeof(expected) - expected_size);
> >> +        memcpy(expected + expected_size, argv[i], size);
> >> +        expected_size +=3D size;
> >> +    }
> >> +    check(AT_FDCWD, "/proc/self/cmdline", flags, 0);
> >> +    check(-1, "/proc/self/cmdline", flags, 0);
> >> +    check(proc, "self/cmdline", flags, 0);
> >> +    check(proc, "./self/cmdline", flags, 0);
> >> +    check(self, "cmdline", flags, 0);
> >> +    check(self, "cmdline", flags | O_NOFOLLOW, 0);
> >> +    check(self, "cmdline", O_PATH | O_CLOEXEC, 0);
> >> +    check(self, "cmdline", flags | O_DIRECTORY, ENOTDIR);
> >> +    assert(chdir("/proc") =3D=3D 0);
> >> +    check(AT_FDCWD, "self/cmdline", flags, 0);
> >> +    check(-1, "self/cmdline", flags, EBADF);
> >> +    assert(fchdir(cwd) =3D=3D 0);
> >> +    assert(close(self) =3D=3D 0);
> >> +    assert(close(proc) =3D=3D 0);
> >> +    assert(close(cwd) =3D=3D 0);
> >> +    assert(getrlimit(RLIMIT_NOFILE, &saved) =3D=3D 0);
> >> +    int next =3D open("/dev/null", O_RDONLY | O_CLOEXEC);
> >> +
> >> +    assert(next >=3D 0);
> >> +    limit =3D saved;
> >> +    limit.rlim_cur =3D next + 1;
> >> +    assert(setrlimit(RLIMIT_NOFILE, &limit) =3D=3D 0);
> >> +    assert(close(next) =3D=3D 0);
> >> +    check(AT_FDCWD, "/proc/self/cmdline", flags, 0);
> >> +    check(AT_FDCWD, "/proc/self/cmdline", flags | O_NOFOLLOW, 0);
> >> +    assert(setrlimit(RLIMIT_NOFILE, &saved) =3D=3D 0);
> >> +    return EXIT_SUCCESS;
> >> +}
> >> diff --git a/tests/tcg/multiarch/linux/proc-openat2.c b/tests/tcg/mult=
iarch/linux/proc-openat2.c
> >> new file mode 100644
> >> index 0000000000..7641bbe634
> >> --- /dev/null
> >> +++ b/tests/tcg/multiarch/linux/proc-openat2.c
> >> @@ -0,0 +1,83 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +#define _GNU_SOURCE
> >> +#include <assert.h>
> >> +#include <errno.h>
> >> +#include <fcntl.h>
> >> +#include <stdint.h>
> >> +#include <stdlib.h>
> >> +#include <sys/syscall.h>
> >> +#include <unistd.h>
> >> +
> >> +#ifdef SYS_openat2
> >> +#include <linux/openat2.h>
> >> +
> >> +static int cmdline_argc;
> >> +static char **cmdline_argv;
> >> +
> >> +static void check(int dirfd, const char *name, uint64_t flags,
> >> +                  uint64_t resolve, int expected_errno)
> >> +{
> >> +    struct open_how how =3D { .flags =3D flags, .resolve =3D resolve =
};
> >> +    char byte;
> >> +    int fd =3D syscall(SYS_openat2, dirfd, name, &how, sizeof(how));
> >> +
> >> +    if (expected_errno) {
> >> +        assert(fd =3D=3D -1 && errno =3D=3D expected_errno);
> >> +        return;
> >> +    }
> >> +    assert(fd >=3D 0);
> >> +    assert(fcntl(fd, F_GETFD) =3D=3D FD_CLOEXEC);
> >> +    if (flags & O_PATH) {
> >> +        assert(fcntl(fd, F_GETFL) & O_PATH);
> >> +        assert(read(fd, &byte, 1) =3D=3D -1 && errno =3D=3D EBADF);
> >> +    } else {
> >> +        for (int i =3D 0; i < cmdline_argc; i++) {
> >> +            const char *p =3D cmdline_argv[i];
> >> +
> >> +            do {
> >> +                assert(read(fd, &byte, 1) =3D=3D 1 && byte =3D=3D *p)=
;
> >> +            } while (*p++);
> >> +        }
> >> +        assert(read(fd, &byte, 1) =3D=3D 0);
> >> +        assert(write(fd, "x", 1) =3D=3D -1 && errno =3D=3D EBADF);
> >> +    }
> >> +    assert(close(fd) =3D=3D 0);
> >> +}
> >> +#endif
> >> +
> >> +int main(int argc, char **argv)
> >> +{
> >> +#ifdef SYS_openat2
> >> +    struct open_how how =3D { .flags =3D O_RDONLY | O_CLOEXEC };
> >> +    int fd =3D syscall(SYS_openat2, AT_FDCWD, "/proc/self/cmdline",
> >> +                     &how, sizeof(how));
> >> +    int proc, self, root, flags =3D O_RDONLY | O_CLOEXEC;
> >> +
> >> +    cmdline_argc =3D argc;
> >> +    cmdline_argv =3D argv;
> >> +    if (fd < 0 && errno =3D=3D ENOSYS) {
> >> +        return EXIT_SUCCESS;
> >> +    }
> >> +    assert(fd >=3D 0 && close(fd) =3D=3D 0);
> >> +    proc =3D open("/proc", O_PATH | O_DIRECTORY | O_CLOEXEC);
> >> +    self =3D open("/proc/self", O_PATH | O_DIRECTORY | O_CLOEXEC);
> >> +    root =3D open("/", O_PATH | O_DIRECTORY | O_CLOEXEC);
> >> +    assert(proc >=3D 0 && self >=3D 0 && root >=3D 0);
> >> +    check(-1, "/proc/self/cmdline", flags, 0, 0);
> >> +    check(AT_FDCWD, "/proc/self/cmdline", flags,
> >> +          RESOLVE_NO_SYMLINKS, ELOOP);
> >> +    check(proc, "self/cmdline", flags, 0, 0);
> >> +    check(proc, "self/cmdline", flags, RESOLVE_NO_SYMLINKS, ELOOP);
> >> +    check(proc, "self/root/proc/self/cmdline", flags,
> >> +          RESOLVE_NO_MAGICLINKS, ELOOP);
> >> +    check(self, "../self/cmdline", flags, RESOLVE_BENEATH, EXDEV);
> >> +    check(self, "../self/cmdline", flags, RESOLVE_IN_ROOT, ENOENT);
> >> +    check(root, "proc/self/cmdline", flags, RESOLVE_NO_XDEV, EXDEV);
> >> +    check(proc, "self/cmdline", flags, UINT64_C(1) << 63, EINVAL);
> >> +    check(self, "cmdline", O_PATH | O_CLOEXEC, 0, 0);
> >> +    assert(close(root) =3D=3D 0);
> >> +    assert(close(self) =3D=3D 0);
> >> +    assert(close(proc) =3D=3D 0);
> >> +#endif
> >> +    return EXIT_SUCCESS;
> >> +}
> >> diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/mes=
on.build
> >> index e60a052700..337dda729a 100644
> >> --- a/tests/tcg/multiarch/meson.build
> >> +++ b/tests/tcg/multiarch/meson.build
> >> @@ -61,6 +61,8 @@ tests +=3D {
> >>     multiarch/'linux/linux-shmat-null.c': {},
> >>     multiarch/'linux/linux-sigrtminmax.c': {},
> >>     multiarch/'linux/linux-test.c': {},
> >> +  multiarch/'linux/proc-openat.c': {},
> >> +  multiarch/'linux/proc-openat2.c': {},
> >>     multiarch/'linux/test-vma.c': {},
> >>   }
> >>
> >> --
> >> 2.55.0
> >>
>

