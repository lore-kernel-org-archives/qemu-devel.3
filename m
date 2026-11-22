Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429E0606A320
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=b6epee7I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVA5x-0007Hy-QI; Sun, 22 Nov 2026 11:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xVA5u-0007Hi-SM
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:07:11 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xVA5r-0002Eb-8b
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:07:10 -0500
DKIM2-Signature: i=1; m=1; t=1795363625; mf=PGRlbGxlckBnbXguZGU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=; d=gmx.de;
 s=s31663417:rsa-sha256:p2Z61IIZmuHh/lo+PAwrHjZLu/Bl
 IrJXQVeilefCB7aZA7NNWq9hRGMm8dzKqfUlLqvr2rFB3gZfih4Uh45vKkeaJlCdH5UyM9NjOMZ
 2ulixURQtbDmMD043KawaBRmjWHck0BhUoYD4cKbbEbN4gjwVTDDhHg8HpritxCOFvH8hGvr5Ve
 1zHXKSXvk78CWp0OwXXxTLCOnXbNAfE9gUFo51unLExIrC8rcNb/0yKgIZFLURUtJTCTjtZVJo8
 4cV9P7PP213gMZskXHJFpRPmNOHW7Gwic0/dpxEWtQrZpcY9hY7WQrHRI2fHpjTExOBfIPjh/CG
 jUzTJNxpn4U6hA==;
Message-Instance: m=1; h=sha256: kx82iLA4m7X/jTGEE0iJSPz2xgbDZVDB2yKOzb3zJTg=:
 GRY3g+rSmjtwIshvXvFG6RATsRZBzV7gD79/JJAvD3g=, sha512:
 GzLZYvbMVWspml/7FbWMkUgoZ9p3cwdhtkAD1mwxB19b4GG00iRl+NDFSwQ6KysQ0eGGkHUzZsjfXxsCTuG8rg==:
 fqgMDKDEfyKuuI7TbOcttuafgV9KUdzS68Y45Nd4lczkwizeBINoB9kmeBJpIwkgR7BDmn/XgQTym68kC8RA+g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795363621; x=1795968421; i=deller@gmx.de;
 bh=2YmlMG0+NPRPmhXjniG9ecB8WmWMA3BNzV1gmMtwZOg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=b6epee7Ijp1/aqwloZ1XW5wNncEvRuoEy6JBEuJpfpH3IvjbThFcdX90n3xByTmh
 1LdvXZqQj59ec6NuBnmP4K+4/0GUYUoGWWfqx4ivyh95IgStYKLsbtSHRTJ7dc6Bo
 jQyp8EcEGCnoBTIPtd29KhREeop++sWZLOGYVjZKY2QCuWQN6phvKNx0kHYGGkrPA
 WmnaH5E4SsT7RsCuxbxeIYcC9Vg5XBd7GI3zP5Gg61YAWh92q+uJB6RYO0Z8pWuzH
 7y9lYdewzsNxNuHv/kb4cIPoK+zNqHkzzzXDFAwA6uBOiFK9ln6LO0f5NXj5jqze3
 B+IIv5ukWLHkmt8ilw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGe1-1xupqJ3uZX-00Z0FB; Sun, 22
 Nov 2026 17:07:01 +0100
Message-ID: <9ed93ce9-7443-4f3d-a977-fdcbcb5e97cc@gmx.de>
Date: Sun, 22 Nov 2026 17:06:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: honor dirfd for synthetic proc opens
To: Artemii Mashanov <ralerrdirsardx@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261025131700.34930-1-ralerrdirsardx@gmail.com>
 <20261025152314.49954-1-ralerrdirsardx@gmail.com>
 <CAGHp__YOsuwOR+2NdwPmV2qp5az96EbsmhiFgjQmVMvC4DT+LA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAGHp__YOsuwOR+2NdwPmV2qp5az96EbsmhiFgjQmVMvC4DT+LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EmTSzAXwlE/N1FmSuKULutxlTX0L3tRZNImwRnHOm5kLKCAVJb1
 cEIWjgykLKfHgMdiEKp3jcIEavV8E/NsARFqwYoxJY1Yr9kXD4JT7qhIwX2SI3EtdBgLsfs
 Hzx7hWEYpRHPKNr5tsZYMIF1auYBggiaMb9IjgJ3jxEMAGpi6NrML9+Hv96rQ1n6wos9q/7
 MwjQVU0zm/QvNEOemx1mA==
UI-OutboundReport: notjunk:1;M01:P0:QFKiKIRU2+Q=;lNys8WRhSOWpsEO2n4zoVFaSd9A
 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
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 09:31, Artemii Mashanov wrote:
> Hi,
>=20
> Ping on this patch. Could someone please take a look when time permits?
>=20
> Please let me know if any changes or additional testing are needed.

I've queued this patch up for qemu v12.0.

Overall I'm not happy how we handle the relative paths when running
outside of a chroot. I think this something we should take a closer
look during the next release cycle.

Thanks!
Helge=20
> Thanks,
> Artemii
>=20
> =D0=B2=D1=81, 25 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 18:23, =
Artemii Mashanov <ralerrdirsardx@gmail.com>:
>>
>> Opening "<pid>/cmdline" relative to a directory descriptor for /proc
>> can return QEMU's command line instead of the guest's.
>>
>> Honor dirfd when selecting synthetic proc contents and add regression
>> coverage for openat and openat2.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4458
>> Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
>> ---
>>   linux-user/syscall.c                     | 321 +++++++++++++++++-----=
-
>>   tests/tcg/multiarch/linux/proc-openat.c  |  94 +++++++
>>   tests/tcg/multiarch/linux/proc-openat2.c |  83 ++++++
>>   tests/tcg/multiarch/meson.build          |   2 +
>>   4 files changed, 418 insertions(+), 82 deletions(-)
>>   create mode 100644 tests/tcg/multiarch/linux/proc-openat.c
>>   create mode 100644 tests/tcg/multiarch/linux/proc-openat2.c
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 0380691a8b..0583e7e19d 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -8839,12 +8839,132 @@ static int open_net_route(CPUArchState *cpu_en=
v, int fd)
>>   }
>>   #endif
>>
>> -static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
>> -                              const char *fname, int flags, mode_t mod=
e,
>> -                              int openat2_resolve, bool safe)
>> +static char *proc_entry_path(int dirfd, const char *name)
>> +{
>> +    g_autofree char *base =3D NULL;
>> +    g_autofree char *absolute =3D NULL;
>> +    g_autofree char *parent =3D NULL;
>> +    g_autofree char *resolved =3D NULL;
>> +    g_autofree char *entry =3D NULL;
>> +    char fd_path[64];
>> +
>> +    if (!name[0]) {
>> +        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", dirfd);
>> +        return g_file_read_link(fd_path, NULL);
>> +    }
>> +    if (name[0] =3D=3D '/') {
>> +        absolute =3D g_strdup(name);
>> +    } else {
>> +        if (dirfd =3D=3D AT_FDCWD) {
>> +            base =3D getcwd(NULL, 0);
>> +        } else {
>> +            snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", dir=
fd);
>> +            base =3D g_file_read_link(fd_path, NULL);
>> +        }
>> +        if (!base) {
>> +            return NULL;
>> +        }
>> +        absolute =3D g_build_filename(base, name, NULL);
>> +    }
>> +    parent =3D g_path_get_dirname(absolute);
>> +    resolved =3D realpath(parent, NULL);
>> +    if (!resolved) {
>> +        return NULL;
>> +    }
>> +    entry =3D g_path_get_basename(absolute);
>> +    return g_build_filename(resolved, entry, NULL);
>> +}
>> +
>> +static int fake_open_contents(CPUArchState *cpu_env,
>> +                              int (*fill)(CPUArchState *, int),
>> +                              int status_flags, bool safe)
>> +{
>> +    g_autofree char *filename =3D NULL;
>> +    const char *tmpdir =3D g_get_tmp_dir();
>> +    const char *reader_path;
>> +    char fd_path[64];
>> +    bool named =3D status_flags & O_NOFOLLOW;
>> +    int fd, reader =3D -1, result =3D -1, saved_errno;
>> +
>> +retry:
>> +    if (named) {
>> +        g_free(filename);
>> +        filename =3D g_build_filename(tmpdir, "qemu-open.XXXXXX", NULL=
);
>> +        fd =3D g_mkstemp_full(filename, O_RDWR | O_CLOEXEC, 0600);
>> +        if (fd < 0 && strcmp(tmpdir, P_tmpdir) &&
>> +            errno !=3D EMFILE && errno !=3D ENFILE &&
>> +            errno !=3D ENOMEM && errno !=3D EINTR) {
>> +            tmpdir =3D P_tmpdir;
>> +            goto retry;
>> +        }
>> +    } else {
>> +        fd =3D memfd_create("qemu-open", MFD_CLOEXEC);
>> +    }
>> +    if (fd < 0) {
>> +        if (!named && (errno =3D=3D ENOSYS || errno =3D=3D EPERM)) {
>> +            named =3D true;
>> +            goto retry;
>> +        }
>> +        return -1;
>> +    }
>> +    if (fill(cpu_env, fd)) {
>> +        goto out;
>> +    }
>> +    if (named) {
>> +        int closed =3D close(fd);
>> +
>> +        fd =3D -1;
>> +        if (closed < 0) {
>> +            goto out;
>> +        }
>> +        reader_path =3D filename;
>> +    } else {
>> +        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", fd);
>> +        reader_path =3D fd_path;
>> +    }
>> +    reader =3D safe ? safe_openat(AT_FDCWD, reader_path, status_flags,=
 0) :
>> +                    openat(AT_FDCWD, reader_path, status_flags, 0);
>> +    if (reader < 0) {
>> +        if (!named && errno =3D=3D EMFILE) {
>> +            close(fd);
>> +            named =3D true;
>> +            goto retry;
>> +        }
>> +        goto out;
>> +    }
>> +    result =3D named ? reader : dup3(reader, fd, status_flags & O_CLOE=
XEC);
>> +    if (result >=3D 0) {
>> +        if (named) {
>> +            reader =3D -1;
>> +        } else {
>> +            fd =3D -1;
>> +        }
>> +    }
>> +out:
>> +    saved_errno =3D errno;
>> +    if (reader >=3D 0) {
>> +        close(reader);
>> +    }
>> +    if (fd >=3D 0) {
>> +        close(fd);
>> +    }
>> +    if (named) {
>> +        unlink(filename);
>> +    }
>> +    errno =3D saved_errno;
>> +    return result;
>> +}
>> +
>> +static int maybe_do_fake_open(CPUArchState *cpu_env, int opened_fd, in=
t dirfd,
>> +                              const char *fname,
>> +                              const struct open_how_ver0 *how,
>> +                              bool safe)
>>   {
>>       g_autofree char *proc_name =3D NULL;
>> +    char fd_path[64];
>>       const char *pathname;
>> +    int flags =3D how->flags;
>> +    int original_errno =3D errno;
>>       struct fake_open {
>>           const char *filename;
>>           int (*fill)(CPUArchState *cpu_env, int fd);
>> @@ -8869,26 +8989,70 @@ static int maybe_do_fake_open(CPUArchState *cpu=
_env, int dirfd,
>>           { NULL, NULL, NULL }
>>       };
>>
>> -    /* if this is a file from /proc/ filesystem, expand full name */
>> -    proc_name =3D realpath(fname, NULL);
>> -    if (proc_name && strncmp(proc_name, "/proc/", 6) =3D=3D 0) {
>> -        pathname =3D proc_name;
>> -    } else {
>> -        pathname =3D fname;
>> +    if (opened_fd >=3D 0 &&
>> +        ((flags & (O_PATH | O_NOFOLLOW)) =3D=3D (O_PATH | O_NOFOLLOW))=
) {
>> +        return opened_fd;
>> +    }
>> +    if (opened_fd < 0 && original_errno !=3D ENOENT) {
>> +        return opened_fd;
>>       }
>>
>> -    if (is_proc_myself(pathname, "exe")) {
>> -        /* Honor openat2 resolve flags */
>> -        if ((openat2_resolve & RESOLVE_NO_MAGICLINKS) ||
>> -            (openat2_resolve & RESOLVE_NO_SYMLINKS)) {
>> -            errno =3D ELOOP;
>> -            return -1;
>> +    if (opened_fd >=3D 0 && !(flags & O_NOFOLLOW) &&
>> +        !(how->resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH |
>> +                           RESOLVE_NO_SYMLINKS | RESOLVE_NO_MAGICLINKS=
))) {
>> +        struct stat opened, executable;
>> +
>> +        if (fstat(opened_fd, &opened) =3D=3D 0 &&
>> +            stat("/proc/self/exe", &executable) =3D=3D 0 &&
>> +            opened.st_dev =3D=3D executable.st_dev &&
>> +            opened.st_ino =3D=3D executable.st_ino) {
>> +            g_autofree char *entry =3D proc_entry_path(dirfd, fname);
>> +
>> +            if (entry && is_proc_myself(entry, "exe")) {
>> +                close(opened_fd);
>> +                if (how->resolve) {
>> +                    return safe_openat2(AT_FDCWD, real_exec_path,
>> +                                        how, sizeof(*how));
>> +                }
>> +                return safe ? safe_openat(AT_FDCWD, real_exec_path,
>> +                                          flags, how->mode) :
>> +                       openat(AT_FDCWD, real_exec_path, flags, how->mo=
de);
>> +            }
>>           }
>> -        if (safe) {
>> -            return safe_openat(dirfd, real_exec_path, flags, mode);
>> -        } else {
>> -            return openat(dirfd, real_exec_path, flags, mode);
>> +    }
>> +
>> +    if (opened_fd < 0) {
>> +        g_autofree char *parent =3D g_path_get_dirname(fname);
>> +        g_autofree char *entry =3D g_path_get_basename(fname);
>> +        g_autofree char *directory =3D NULL;
>> +        struct open_how_ver0 parent_how =3D {
>> +            .flags =3D O_PATH | O_DIRECTORY | O_CLOEXEC,
>> +            .resolve =3D how->resolve,
>> +        };
>> +        int fd;
>> +
>> +        fd =3D how->resolve ?
>> +             safe_openat2(dirfd, parent, &parent_how, sizeof(parent_ho=
w)) :
>> +             safe ? safe_openat(dirfd, parent, parent_how.flags, 0) :
>> +                    openat(dirfd, parent, parent_how.flags, 0);
>> +        if (fd >=3D 0) {
>> +            snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", fd)=
;
>> +            directory =3D g_file_read_link(fd_path, NULL);
>> +            close(fd);
>> +            if (directory) {
>> +                proc_name =3D g_build_filename(directory, entry, NULL)=
;
>> +            }
>>           }
>> +    } else {
>> +        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", opened_=
fd);
>> +        proc_name =3D g_file_read_link(fd_path, NULL);
>> +    }
>> +    pathname =3D proc_name;
>> +
>> +    if ((opened_fd >=3D 0 && (flags & O_PATH)) ||
>> +        !pathname || strncmp(pathname, "/proc/", 6)) {
>> +        errno =3D original_errno;
>> +        return opened_fd;
>>       }
>>
>>       for (fake_open =3D fakes; fake_open->filename; fake_open++) {
>> @@ -8898,60 +9062,52 @@ static int maybe_do_fake_open(CPUArchState *cpu=
_env, int dirfd,
>>       }
>>
>>       if (fake_open->filename) {
>> -        const char *tmpdir;
>> -        char filename[PATH_MAX];
>> -        int fd, r;
>> -
>> -        fd =3D memfd_create("qemu-open", 0);
>> -        if (fd < 0) {
>> -            if (errno !=3D ENOSYS) {
>> -                return fd;
>> -            }
>> -            /* create temporary file to map stat to */
>> -            tmpdir =3D getenv("TMPDIR");
>> -            if (!tmpdir)
>> -                tmpdir =3D "/tmp";
>> -            snprintf(filename, sizeof(filename), "%s/qemu-open.XXXXXX"=
, tmpdir);
>> -            fd =3D mkstemp(filename);
>> -            if (fd < 0) {
>> -                return fd;
>> -            }
>> -            unlink(filename);
>> -        }
>> -
>> -        if ((r =3D fake_open->fill(cpu_env, fd))) {
>> -            int e =3D errno;
>> -            close(fd);
>> -            errno =3D e;
>> -            return r;
>> +        int saved_errno, status_flags;
>> +
>> +        status_flags =3D flags & ~(O_CREAT | O_EXCL | O_TRUNC);
>> +        if (opened_fd >=3D 0) {
>> +            status_flags =3D fcntl(opened_fd, F_GETFL);
>> +            saved_errno =3D errno;
>> +            close(opened_fd);
>> +            if (status_flags < 0) {
>> +                errno =3D saved_errno;
>> +                return -1;
>> +            }
>> +        } else if (flags & O_DIRECTORY) {
>> +            errno =3D ENOTDIR;
>> +            return -1;
>> +        } else if ((flags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EX=
CL)) {
>> +            errno =3D EEXIST;
>> +            return -1;
>>           }
>> -        lseek(fd, 0, SEEK_SET);
>>
>> -        return fd;
>> +        status_flags |=3D flags & O_CLOEXEC;
>> +        return fake_open_contents(cpu_env, fake_open->fill, status_fla=
gs, safe);
>>       }
>>
>> -    return -2;
>> +    errno =3D original_errno;
>> +    return opened_fd;
>>   }
>>
>>   int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pat=
hname,
>>                       int flags, mode_t mode, bool safe)
>>   {
>> -    int fd =3D maybe_do_fake_open(cpu_env, dirfd, pathname, flags, mod=
e, 0, safe);
>> -    if (fd > -2) {
>> -        return fd;
>> -    }
>> +    struct open_how_ver0 how =3D { .flags =3D flags, .mode =3D mode };
>> +    const char *host_name =3D path(pathname);
>> +    int fd;
>>
>>       if (safe) {
>> -        return safe_openat(dirfd, path(pathname), flags, mode);
>> +        fd =3D safe_openat(dirfd, host_name, flags, mode);
>>       } else {
>> -        return openat(dirfd, path(pathname), flags, mode);
>> +        fd =3D openat(dirfd, host_name, flags, mode);
>>       }
>> +    return maybe_do_fake_open(cpu_env, fd, dirfd, host_name, &how,
>> +                              safe);
>>   }
>>
>> -
>>   static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
>> -                      abi_ptr guest_pathname, abi_ptr guest_open_how,
>> -                      abi_ulong guest_size)
>> +                     abi_ptr guest_pathname, abi_ptr guest_open_how,
>> +                     abi_ulong guest_size)
>>   {
>>       struct open_how_ver0 how =3D {0};
>>       char *pathname;
>> @@ -8981,23 +9137,19 @@ static int do_openat2(CPUArchState *cpu_env, ab=
i_long dirfd,
>>       how.flags =3D target_to_host_bitmask(tswap64(how.flags), fcntl_fl=
ags_tbl);
>>       how.mode =3D tswap64(how.mode);
>>       how.resolve =3D tswap64(how.resolve);
>> -    int fd =3D maybe_do_fake_open(cpu_env, dirfd, pathname, how.flags,=
 how.mode,
>> -                                how.resolve, true);
>> -    if (fd > -2) {
>> -        ret =3D get_errno(fd);
>> -    } else {
>> -        const char *host_pathname =3D pathname;
>> -        if (pathname[0] =3D=3D '/' &&
>> -            !(how.resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH))) {
>> -            /*
>> -             * RESOLVE_BENEATH rejects absolute paths; RESOLVE_IN_ROOT
>> -             * resolves them relative to dirfd.
>> -             */
>> -            host_pathname =3D path(pathname);
>> -        }
>> -        ret =3D get_errno(safe_openat2(dirfd, host_pathname, &how,
>> -                                     sizeof(struct open_how_ver0)));
>> +    const char *host_pathname =3D pathname;
>> +    if (pathname[0] =3D=3D '/' &&
>> +        !(how.resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH))) {
>> +        /*
>> +         * RESOLVE_BENEATH rejects absolute paths; RESOLVE_IN_ROOT
>> +         * resolves them relative to dirfd.
>> +         */
>> +        host_pathname =3D path(pathname);
>>       }
>> +    int fd =3D safe_openat2(dirfd, host_pathname, &how,
>> +                         sizeof(struct open_how_ver0));
>> +    ret =3D get_errno(maybe_do_fake_open(cpu_env, fd, dirfd, host_path=
name, &how,
>> +                                      true));
>>
>>       fd_trans_unregister(ret);
>>       unlock_user(pathname, guest_pathname, 0);
>> @@ -9034,6 +9186,19 @@ ssize_t do_guest_readlink(const char *pathname, =
char *buf, size_t bufsiz)
>>       return ret;
>>   }
>>
>> +static ssize_t do_guest_readlinkat(int dirfd, const char *pathname,
>> +                                  char *buf, size_t bufsiz)
>> +{
>> +    const char *host_name =3D path(pathname);
>> +    g_autofree char *entry_path =3D proc_entry_path(dirfd, host_name);
>> +    ssize_t ret =3D readlinkat(dirfd, host_name, buf, bufsiz);
>> +
>> +    if (ret >=3D 0 && entry_path && is_proc_myself(entry_path, "exe"))=
 {
>> +        return do_guest_readlink(entry_path, buf, bufsiz);
>> +    }
>> +    return ret;
>> +}
>> +
>>   static int do_execv(CPUArchState *cpu_env, int dirfd,
>>                       abi_long pathname, abi_long guest_argp,
>>                       abi_long guest_envp, int flags, bool is_execveat)
>> @@ -11143,16 +11308,8 @@ static abi_long do_syscall1(CPUArchState *cpu_=
env, int num, abi_long arg1,
>>               } else if (!arg4) {
>>                   /* Short circuit this for the magic exe check. */
>>                   ret =3D -TARGET_EINVAL;
>> -            } else if (is_proc_myself((const char *)p, "exe")) {
>> -                /*
>> -                 * Don't worry about sign mismatch as earlier mapping
>> -                 * logic would have thrown a bad address error.
>> -                 */
>> -                ret =3D MIN(strlen(real_exec_path), arg4);
>> -                /* We cannot NUL terminate the string. */
>> -                memcpy(p2, real_exec_path, ret);
>>               } else {
>> -                ret =3D get_errno(readlinkat(arg1, path(p), p2, arg4))=
;
>> +                ret =3D get_errno(do_guest_readlinkat(arg1, p, p2, arg=
4));
>>               }
>>               unlock_user(p2, arg3, ret);
>>               unlock_user(p, arg2, 0);
>> diff --git a/tests/tcg/multiarch/linux/proc-openat.c b/tests/tcg/multia=
rch/linux/proc-openat.c
>> new file mode 100644
>> index 0000000000..4af2fde113
>> --- /dev/null
>> +++ b/tests/tcg/multiarch/linux/proc-openat.c
>> @@ -0,0 +1,94 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#define _GNU_SOURCE
>> +#include <assert.h>
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <sys/resource.h>
>> +#include <unistd.h>
>> +
>> +static char expected[16384];
>> +static size_t expected_size;
>> +
>> +static void check(int dirfd, const char *name, int flags, int expected=
_errno)
>> +{
>> +    char actual[sizeof(expected)];
>> +    size_t size =3D 0;
>> +    int fd =3D openat(dirfd, name, flags);
>> +
>> +    if (expected_errno) {
>> +        assert(fd =3D=3D -1 && errno =3D=3D expected_errno);
>> +        return;
>> +    }
>> +    assert(fd >=3D 0);
>> +    assert((fcntl(fd, F_GETFD) & FD_CLOEXEC) =3D=3D
>> +           ((flags & O_CLOEXEC) ? FD_CLOEXEC : 0));
>> +    assert((fcntl(fd, F_GETFL) & (O_PATH | O_NOFOLLOW | O_ACCMODE)) =
=3D=3D
>> +           (flags & (O_PATH | O_NOFOLLOW | O_ACCMODE)));
>> +    if (flags & O_PATH) {
>> +        assert(read(fd, actual, 1) =3D=3D -1 && errno =3D=3D EBADF);
>> +    } else {
>> +        for (;;) {
>> +            ssize_t n =3D read(fd, actual + size, sizeof(actual) - siz=
e);
>> +
>> +            if (n < 0 && errno =3D=3D EINTR) {
>> +                continue;
>> +            }
>> +            assert(n >=3D 0);
>> +            if (!n) {
>> +                break;
>> +            }
>> +            size +=3D n;
>> +            assert(size < sizeof(actual));
>> +        }
>> +        assert(size =3D=3D expected_size && !memcmp(actual, expected, =
size));
>> +        assert(write(fd, "x", 1) =3D=3D -1 && errno =3D=3D EBADF);
>> +    }
>> +    assert(close(fd) =3D=3D 0);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    struct rlimit saved, limit;
>> +    int cwd =3D open(".", O_PATH | O_DIRECTORY | O_CLOEXEC);
>> +    int proc =3D open("/proc", O_PATH | O_DIRECTORY | O_CLOEXEC);
>> +    int self =3D open("/proc/self", O_PATH | O_DIRECTORY | O_CLOEXEC);
>> +    int flags =3D O_RDONLY | O_CLOEXEC;
>> +
>> +    assert(cwd >=3D 0 && proc >=3D 0 && self >=3D 0);
>> +    for (int i =3D 0; i < argc; i++) {
>> +        size_t size =3D strlen(argv[i]) + 1;
>> +
>> +        assert(size <=3D sizeof(expected) - expected_size);
>> +        memcpy(expected + expected_size, argv[i], size);
>> +        expected_size +=3D size;
>> +    }
>> +    check(AT_FDCWD, "/proc/self/cmdline", flags, 0);
>> +    check(-1, "/proc/self/cmdline", flags, 0);
>> +    check(proc, "self/cmdline", flags, 0);
>> +    check(proc, "./self/cmdline", flags, 0);
>> +    check(self, "cmdline", flags, 0);
>> +    check(self, "cmdline", flags | O_NOFOLLOW, 0);
>> +    check(self, "cmdline", O_PATH | O_CLOEXEC, 0);
>> +    check(self, "cmdline", flags | O_DIRECTORY, ENOTDIR);
>> +    assert(chdir("/proc") =3D=3D 0);
>> +    check(AT_FDCWD, "self/cmdline", flags, 0);
>> +    check(-1, "self/cmdline", flags, EBADF);
>> +    assert(fchdir(cwd) =3D=3D 0);
>> +    assert(close(self) =3D=3D 0);
>> +    assert(close(proc) =3D=3D 0);
>> +    assert(close(cwd) =3D=3D 0);
>> +    assert(getrlimit(RLIMIT_NOFILE, &saved) =3D=3D 0);
>> +    int next =3D open("/dev/null", O_RDONLY | O_CLOEXEC);
>> +
>> +    assert(next >=3D 0);
>> +    limit =3D saved;
>> +    limit.rlim_cur =3D next + 1;
>> +    assert(setrlimit(RLIMIT_NOFILE, &limit) =3D=3D 0);
>> +    assert(close(next) =3D=3D 0);
>> +    check(AT_FDCWD, "/proc/self/cmdline", flags, 0);
>> +    check(AT_FDCWD, "/proc/self/cmdline", flags | O_NOFOLLOW, 0);
>> +    assert(setrlimit(RLIMIT_NOFILE, &saved) =3D=3D 0);
>> +    return EXIT_SUCCESS;
>> +}
>> diff --git a/tests/tcg/multiarch/linux/proc-openat2.c b/tests/tcg/multi=
arch/linux/proc-openat2.c
>> new file mode 100644
>> index 0000000000..7641bbe634
>> --- /dev/null
>> +++ b/tests/tcg/multiarch/linux/proc-openat2.c
>> @@ -0,0 +1,83 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#define _GNU_SOURCE
>> +#include <assert.h>
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <stdint.h>
>> +#include <stdlib.h>
>> +#include <sys/syscall.h>
>> +#include <unistd.h>
>> +
>> +#ifdef SYS_openat2
>> +#include <linux/openat2.h>
>> +
>> +static int cmdline_argc;
>> +static char **cmdline_argv;
>> +
>> +static void check(int dirfd, const char *name, uint64_t flags,
>> +                  uint64_t resolve, int expected_errno)
>> +{
>> +    struct open_how how =3D { .flags =3D flags, .resolve =3D resolve }=
;
>> +    char byte;
>> +    int fd =3D syscall(SYS_openat2, dirfd, name, &how, sizeof(how));
>> +
>> +    if (expected_errno) {
>> +        assert(fd =3D=3D -1 && errno =3D=3D expected_errno);
>> +        return;
>> +    }
>> +    assert(fd >=3D 0);
>> +    assert(fcntl(fd, F_GETFD) =3D=3D FD_CLOEXEC);
>> +    if (flags & O_PATH) {
>> +        assert(fcntl(fd, F_GETFL) & O_PATH);
>> +        assert(read(fd, &byte, 1) =3D=3D -1 && errno =3D=3D EBADF);
>> +    } else {
>> +        for (int i =3D 0; i < cmdline_argc; i++) {
>> +            const char *p =3D cmdline_argv[i];
>> +
>> +            do {
>> +                assert(read(fd, &byte, 1) =3D=3D 1 && byte =3D=3D *p);
>> +            } while (*p++);
>> +        }
>> +        assert(read(fd, &byte, 1) =3D=3D 0);
>> +        assert(write(fd, "x", 1) =3D=3D -1 && errno =3D=3D EBADF);
>> +    }
>> +    assert(close(fd) =3D=3D 0);
>> +}
>> +#endif
>> +
>> +int main(int argc, char **argv)
>> +{
>> +#ifdef SYS_openat2
>> +    struct open_how how =3D { .flags =3D O_RDONLY | O_CLOEXEC };
>> +    int fd =3D syscall(SYS_openat2, AT_FDCWD, "/proc/self/cmdline",
>> +                     &how, sizeof(how));
>> +    int proc, self, root, flags =3D O_RDONLY | O_CLOEXEC;
>> +
>> +    cmdline_argc =3D argc;
>> +    cmdline_argv =3D argv;
>> +    if (fd < 0 && errno =3D=3D ENOSYS) {
>> +        return EXIT_SUCCESS;
>> +    }
>> +    assert(fd >=3D 0 && close(fd) =3D=3D 0);
>> +    proc =3D open("/proc", O_PATH | O_DIRECTORY | O_CLOEXEC);
>> +    self =3D open("/proc/self", O_PATH | O_DIRECTORY | O_CLOEXEC);
>> +    root =3D open("/", O_PATH | O_DIRECTORY | O_CLOEXEC);
>> +    assert(proc >=3D 0 && self >=3D 0 && root >=3D 0);
>> +    check(-1, "/proc/self/cmdline", flags, 0, 0);
>> +    check(AT_FDCWD, "/proc/self/cmdline", flags,
>> +          RESOLVE_NO_SYMLINKS, ELOOP);
>> +    check(proc, "self/cmdline", flags, 0, 0);
>> +    check(proc, "self/cmdline", flags, RESOLVE_NO_SYMLINKS, ELOOP);
>> +    check(proc, "self/root/proc/self/cmdline", flags,
>> +          RESOLVE_NO_MAGICLINKS, ELOOP);
>> +    check(self, "../self/cmdline", flags, RESOLVE_BENEATH, EXDEV);
>> +    check(self, "../self/cmdline", flags, RESOLVE_IN_ROOT, ENOENT);
>> +    check(root, "proc/self/cmdline", flags, RESOLVE_NO_XDEV, EXDEV);
>> +    check(proc, "self/cmdline", flags, UINT64_C(1) << 63, EINVAL);
>> +    check(self, "cmdline", O_PATH | O_CLOEXEC, 0, 0);
>> +    assert(close(root) =3D=3D 0);
>> +    assert(close(self) =3D=3D 0);
>> +    assert(close(proc) =3D=3D 0);
>> +#endif
>> +    return EXIT_SUCCESS;
>> +}
>> diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meso=
n.build
>> index e60a052700..337dda729a 100644
>> --- a/tests/tcg/multiarch/meson.build
>> +++ b/tests/tcg/multiarch/meson.build
>> @@ -61,6 +61,8 @@ tests +=3D {
>>     multiarch/'linux/linux-shmat-null.c': {},
>>     multiarch/'linux/linux-sigrtminmax.c': {},
>>     multiarch/'linux/linux-test.c': {},
>> +  multiarch/'linux/proc-openat.c': {},
>> +  multiarch/'linux/proc-openat2.c': {},
>>     multiarch/'linux/test-vma.c': {},
>>   }
>>
>> --
>> 2.55.0
>>


