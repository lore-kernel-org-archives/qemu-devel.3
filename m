Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CCB606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=DiBZVR+q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVDVA-00044E-6r; Sun, 22 Nov 2026 14:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xVDV7-00043x-70
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 14:45:25 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xVDV3-0007uA-Ck
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 14:45:24 -0500
DKIM2-Signature: i=1; m=1; t=1795376719; mf=PGRlbGxlckBnbXguZGU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=; d=gmx.de;
 s=s31663417:rsa-sha256:hxNWtaSdsUsMQ9wUP23tl1h48lBC
 Xdc7f+Jq/buoHQ10yDsx8Y3xUKRW8p9ZlraB4JhvMfOtuZlSwb/J42PK3YXTV8po2OoWi6r+r1V
 VeV3WK95wg/5zpLmyyOQzoB93SW7K6QOUcyE5TQrXhpAnAlmLQxqI2EMuhMw2BqmMXroXMiyRzb
 LJW3WeRAzsemNIZBVjaoXkvs03BFkr8P/nKnIA+FVwuOGVefV8NdrYTfmU0hAd7rKotUoM1XNoB
 RV+f53JBq1p2dWGVnb60aqLrAe88KPUh6Gi8UG5ef0AVkUDwYfYtI/5N4XVAGWIopmEsH5zmRzB
 k2fueMfNBsC/xA==;
Message-Instance: m=1; h=sha256: B8izXZVOET6JP2+KmVk2//cr9tWJDaECNgTiMhMYIHU=:
 qhLuqG/XV1qpy0A94NNBTKZw4CjbJAd3edHQXwSIhz0=, sha512:
 cdzv3Oitra1oWktPKiPc4gQq7KkHCeKUyNihKFnKeXPlYtqF2EPhD5rFjYwyS/xkkOoqB0C3mKj4yS3l0ilxYQ==:
 iAUHZ1GRCKz9dKd5dwO7Lw1FTCVlR25hvzh1XWwRGzi1lQ3QkTT+nYTeLMqOeH7WwsrjH6pyErtKNBle4mavIw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795376719; x=1795981519; i=deller@gmx.de;
 bh=FySLXq7HtdPgeu/wjTifdDmBPskatsMkgWpohHsJLGI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DiBZVR+qldpQorLYGGPeCVr5D6FizB686gtGQirY+RTnYSLk3kXNFafdSvTy2jwA
 334NNN6XwQiyGmuaJyIxzGSeMUQy1pK2kd7dKMSBBywLtuCk4cwcLVvsIbm8qUgu6
 xdIgHfsqd9M+n2JNrAHc2FX/Cg6wjHSPAy0ZYOQNQlGRa8PFlkaKPQlUnWI2ykS1L
 3dwVjGiPrDZ9mHgw/EiQ6TaXXyfC+grIN7KgO9MOgmKwdQ6QTb6INURSOw2titAdc
 Gfp5I+i+R80dIAmHVl29VphJs9A6SLdfu4TWBzBJtDup70+g8J2rasaGzquHFz6zJ
 /wjhJcArlvzeoMWnrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw7V-1yCYo93pGF-00orKT; Sun, 22
 Nov 2026 20:45:19 +0100
Message-ID: <73b97fa5-9536-456b-8ef3-20c05efc8a65@gmx.de>
Date: Sun, 22 Nov 2026 20:45:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: honor dirfd for synthetic proc opens
To: Artemii Mashanov <ralerrdirsardx@gmail.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261025131700.34930-1-ralerrdirsardx@gmail.com>
 <20261025152314.49954-1-ralerrdirsardx@gmail.com>
 <CAGHp__YOsuwOR+2NdwPmV2qp5az96EbsmhiFgjQmVMvC4DT+LA@mail.gmail.com>
 <9ed93ce9-7443-4f3d-a977-fdcbcb5e97cc@gmx.de>
 <CAGHp__aoZLhk_++MGPGYZPy_zWQtrnwnjgd4jmPCaWC8UkvnVQ@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAGHp__aoZLhk_++MGPGYZPy_zWQtrnwnjgd4jmPCaWC8UkvnVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oKHoJZyLMP+dsk60GVCREkjgqWP7h4mU+Nzz735lFWfHX8ZPXG8
 +GrpvaEZrw5iUxvq6626jLmMvOvL3SPqsjYcJd1Se0xIzIoWWAv5vZ6WmXnOkXZ86bGd5QX
 tPT2nZ3AvKRusa0YfWOLjJm0sp6FINIzur/R8Y0v8Ug8X4+DqN6iKKTb/RDi+sRme8Oc4tg
 FWYFHmEuW/GV8hHgzX4BA==
UI-OutboundReport: notjunk:1;M01:P0:/fbCCwBK1LU=;Y8H8HCP6mnxenfUKdDNm7p1brqA
 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
 Ad3l6joVfNowwdnVn/qNKnrzXleQUspvCD
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 11/22/26 20:00, Artemii Mashanov wrote:
> Hi,
>=20
> Thanks for queuing the patch. It also fixes the HPPA case reported in
> QEMU issue #2004.

Thanks!
I added a new resolves tag for thus issue to the patch.

Helge=20
> On the parent commit (8f66cb79), the test from the issue returned the
> x86 host's cpu info when opening cpuinfo relative to a directory fd
> for /proc. Opening /proc/cpuinfo by its absolute path returned the
> emulated PA-RISC cpu info.
>=20
> With ea62db5e, both calls reported PA7300LC (PCX-L2). Their outputs
> matched byte for byte in all five runs (1,332 bytes each).
>=20
> https://gitlab.com/qemu-project/qemu/-/issues/2004
> https://github.com/hdeller/qemu-hppa/commit/ea62db5e88bbfe2ea3de81d41aa2=
9b029962425f
>=20
> Best,
> Artemii
>=20
> =D0=B2=D1=81, 22 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 1=
9:07, Helge Deller <deller@gmx.de>:
>>
>> On 11/17/26 09:31, Artemii Mashanov wrote:
>>> Hi,
>>>
>>> Ping on this patch. Could someone please take a look when time permits=
?
>>>
>>> Please let me know if any changes or additional testing are needed.
>>
>> I've queued this patch up for qemu v12.0.
>>
>> Overall I'm not happy how we handle the relative paths when running
>> outside of a chroot. I think this something we should take a closer
>> look during the next release cycle.
>>
>> Thanks!
>> Helge
>>> Thanks,
>>> Artemii
>>>
>>> =D0=B2=D1=81, 25 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 18:23=
, Artemii Mashanov <ralerrdirsardx@gmail.com>:
>>>>
>>>> Opening "<pid>/cmdline" relative to a directory descriptor for /proc
>>>> can return QEMU's command line instead of the guest's.
>>>>
>>>> Honor dirfd when selecting synthetic proc contents and add regression
>>>> coverage for openat and openat2.
>>>>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4458
>>>> Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
>>>> ---
>>>>    linux-user/syscall.c                     | 321 +++++++++++++++++--=
=2D---
>>>>    tests/tcg/multiarch/linux/proc-openat.c  |  94 +++++++
>>>>    tests/tcg/multiarch/linux/proc-openat2.c |  83 ++++++
>>>>    tests/tcg/multiarch/meson.build          |   2 +
>>>>    4 files changed, 418 insertions(+), 82 deletions(-)
>>>>    create mode 100644 tests/tcg/multiarch/linux/proc-openat.c
>>>>    create mode 100644 tests/tcg/multiarch/linux/proc-openat2.c
>>>>
>>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>>> index 0380691a8b..0583e7e19d 100644
>>>> --- a/linux-user/syscall.c
>>>> +++ b/linux-user/syscall.c
>>>> @@ -8839,12 +8839,132 @@ static int open_net_route(CPUArchState *cpu_=
env, int fd)
>>>>    }
>>>>    #endif
>>>>
>>>> -static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
>>>> -                              const char *fname, int flags, mode_t m=
ode,
>>>> -                              int openat2_resolve, bool safe)
>>>> +static char *proc_entry_path(int dirfd, const char *name)
>>>> +{
>>>> +    g_autofree char *base =3D NULL;
>>>> +    g_autofree char *absolute =3D NULL;
>>>> +    g_autofree char *parent =3D NULL;
>>>> +    g_autofree char *resolved =3D NULL;
>>>> +    g_autofree char *entry =3D NULL;
>>>> +    char fd_path[64];
>>>> +
>>>> +    if (!name[0]) {
>>>> +        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", dirfd=
);
>>>> +        return g_file_read_link(fd_path, NULL);
>>>> +    }
>>>> +    if (name[0] =3D=3D '/') {
>>>> +        absolute =3D g_strdup(name);
>>>> +    } else {
>>>> +        if (dirfd =3D=3D AT_FDCWD) {
>>>> +            base =3D getcwd(NULL, 0);
>>>> +        } else {
>>>> +            snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", d=
irfd);
>>>> +            base =3D g_file_read_link(fd_path, NULL);
>>>> +        }
>>>> +        if (!base) {
>>>> +            return NULL;
>>>> +        }
>>>> +        absolute =3D g_build_filename(base, name, NULL);
>>>> +    }
>>>> +    parent =3D g_path_get_dirname(absolute);
>>>> +    resolved =3D realpath(parent, NULL);
>>>> +    if (!resolved) {
>>>> +        return NULL;
>>>> +    }
>>>> +    entry =3D g_path_get_basename(absolute);
>>>> +    return g_build_filename(resolved, entry, NULL);
>>>> +}
>>>> +
>>>> +static int fake_open_contents(CPUArchState *cpu_env,
>>>> +                              int (*fill)(CPUArchState *, int),
>>>> +                              int status_flags, bool safe)
>>>> +{
>>>> +    g_autofree char *filename =3D NULL;
>>>> +    const char *tmpdir =3D g_get_tmp_dir();
>>>> +    const char *reader_path;
>>>> +    char fd_path[64];
>>>> +    bool named =3D status_flags & O_NOFOLLOW;
>>>> +    int fd, reader =3D -1, result =3D -1, saved_errno;
>>>> +
>>>> +retry:
>>>> +    if (named) {
>>>> +        g_free(filename);
>>>> +        filename =3D g_build_filename(tmpdir, "qemu-open.XXXXXX", NU=
LL);
>>>> +        fd =3D g_mkstemp_full(filename, O_RDWR | O_CLOEXEC, 0600);
>>>> +        if (fd < 0 && strcmp(tmpdir, P_tmpdir) &&
>>>> +            errno !=3D EMFILE && errno !=3D ENFILE &&
>>>> +            errno !=3D ENOMEM && errno !=3D EINTR) {
>>>> +            tmpdir =3D P_tmpdir;
>>>> +            goto retry;
>>>> +        }
>>>> +    } else {
>>>> +        fd =3D memfd_create("qemu-open", MFD_CLOEXEC);
>>>> +    }
>>>> +    if (fd < 0) {
>>>> +        if (!named && (errno =3D=3D ENOSYS || errno =3D=3D EPERM)) {
>>>> +            named =3D true;
>>>> +            goto retry;
>>>> +        }
>>>> +        return -1;
>>>> +    }
>>>> +    if (fill(cpu_env, fd)) {
>>>> +        goto out;
>>>> +    }
>>>> +    if (named) {
>>>> +        int closed =3D close(fd);
>>>> +
>>>> +        fd =3D -1;
>>>> +        if (closed < 0) {
>>>> +            goto out;
>>>> +        }
>>>> +        reader_path =3D filename;
>>>> +    } else {
>>>> +        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", fd);
>>>> +        reader_path =3D fd_path;
>>>> +    }
>>>> +    reader =3D safe ? safe_openat(AT_FDCWD, reader_path, status_flag=
s, 0) :
>>>> +                    openat(AT_FDCWD, reader_path, status_flags, 0);
>>>> +    if (reader < 0) {
>>>> +        if (!named && errno =3D=3D EMFILE) {
>>>> +            close(fd);
>>>> +            named =3D true;
>>>> +            goto retry;
>>>> +        }
>>>> +        goto out;
>>>> +    }
>>>> +    result =3D named ? reader : dup3(reader, fd, status_flags & O_CL=
OEXEC);
>>>> +    if (result >=3D 0) {
>>>> +        if (named) {
>>>> +            reader =3D -1;
>>>> +        } else {
>>>> +            fd =3D -1;
>>>> +        }
>>>> +    }
>>>> +out:
>>>> +    saved_errno =3D errno;
>>>> +    if (reader >=3D 0) {
>>>> +        close(reader);
>>>> +    }
>>>> +    if (fd >=3D 0) {
>>>> +        close(fd);
>>>> +    }
>>>> +    if (named) {
>>>> +        unlink(filename);
>>>> +    }
>>>> +    errno =3D saved_errno;
>>>> +    return result;
>>>> +}
>>>> +
>>>> +static int maybe_do_fake_open(CPUArchState *cpu_env, int opened_fd, =
int dirfd,
>>>> +                              const char *fname,
>>>> +                              const struct open_how_ver0 *how,
>>>> +                              bool safe)
>>>>    {
>>>>        g_autofree char *proc_name =3D NULL;
>>>> +    char fd_path[64];
>>>>        const char *pathname;
>>>> +    int flags =3D how->flags;
>>>> +    int original_errno =3D errno;
>>>>        struct fake_open {
>>>>            const char *filename;
>>>>            int (*fill)(CPUArchState *cpu_env, int fd);
>>>> @@ -8869,26 +8989,70 @@ static int maybe_do_fake_open(CPUArchState *c=
pu_env, int dirfd,
>>>>            { NULL, NULL, NULL }
>>>>        };
>>>>
>>>> -    /* if this is a file from /proc/ filesystem, expand full name */
>>>> -    proc_name =3D realpath(fname, NULL);
>>>> -    if (proc_name && strncmp(proc_name, "/proc/", 6) =3D=3D 0) {
>>>> -        pathname =3D proc_name;
>>>> -    } else {
>>>> -        pathname =3D fname;
>>>> +    if (opened_fd >=3D 0 &&
>>>> +        ((flags & (O_PATH | O_NOFOLLOW)) =3D=3D (O_PATH | O_NOFOLLOW=
))) {
>>>> +        return opened_fd;
>>>> +    }
>>>> +    if (opened_fd < 0 && original_errno !=3D ENOENT) {
>>>> +        return opened_fd;
>>>>        }
>>>>
>>>> -    if (is_proc_myself(pathname, "exe")) {
>>>> -        /* Honor openat2 resolve flags */
>>>> -        if ((openat2_resolve & RESOLVE_NO_MAGICLINKS) ||
>>>> -            (openat2_resolve & RESOLVE_NO_SYMLINKS)) {
>>>> -            errno =3D ELOOP;
>>>> -            return -1;
>>>> +    if (opened_fd >=3D 0 && !(flags & O_NOFOLLOW) &&
>>>> +        !(how->resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH |
>>>> +                           RESOLVE_NO_SYMLINKS | RESOLVE_NO_MAGICLIN=
KS))) {
>>>> +        struct stat opened, executable;
>>>> +
>>>> +        if (fstat(opened_fd, &opened) =3D=3D 0 &&
>>>> +            stat("/proc/self/exe", &executable) =3D=3D 0 &&
>>>> +            opened.st_dev =3D=3D executable.st_dev &&
>>>> +            opened.st_ino =3D=3D executable.st_ino) {
>>>> +            g_autofree char *entry =3D proc_entry_path(dirfd, fname)=
;
>>>> +
>>>> +            if (entry && is_proc_myself(entry, "exe")) {
>>>> +                close(opened_fd);
>>>> +                if (how->resolve) {
>>>> +                    return safe_openat2(AT_FDCWD, real_exec_path,
>>>> +                                        how, sizeof(*how));
>>>> +                }
>>>> +                return safe ? safe_openat(AT_FDCWD, real_exec_path,
>>>> +                                          flags, how->mode) :
>>>> +                       openat(AT_FDCWD, real_exec_path, flags, how->=
mode);
>>>> +            }
>>>>            }
>>>> -        if (safe) {
>>>> -            return safe_openat(dirfd, real_exec_path, flags, mode);
>>>> -        } else {
>>>> -            return openat(dirfd, real_exec_path, flags, mode);
>>>> +    }
>>>> +
>>>> +    if (opened_fd < 0) {
>>>> +        g_autofree char *parent =3D g_path_get_dirname(fname);
>>>> +        g_autofree char *entry =3D g_path_get_basename(fname);
>>>> +        g_autofree char *directory =3D NULL;
>>>> +        struct open_how_ver0 parent_how =3D {
>>>> +            .flags =3D O_PATH | O_DIRECTORY | O_CLOEXEC,
>>>> +            .resolve =3D how->resolve,
>>>> +        };
>>>> +        int fd;
>>>> +
>>>> +        fd =3D how->resolve ?
>>>> +             safe_openat2(dirfd, parent, &parent_how, sizeof(parent_=
how)) :
>>>> +             safe ? safe_openat(dirfd, parent, parent_how.flags, 0) =
:
>>>> +                    openat(dirfd, parent, parent_how.flags, 0);
>>>> +        if (fd >=3D 0) {
>>>> +            snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", f=
d);
>>>> +            directory =3D g_file_read_link(fd_path, NULL);
>>>> +            close(fd);
>>>> +            if (directory) {
>>>> +                proc_name =3D g_build_filename(directory, entry, NUL=
L);
>>>> +            }
>>>>            }
>>>> +    } else {
>>>> +        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", opene=
d_fd);
>>>> +        proc_name =3D g_file_read_link(fd_path, NULL);
>>>> +    }
>>>> +    pathname =3D proc_name;
>>>> +
>>>> +    if ((opened_fd >=3D 0 && (flags & O_PATH)) ||
>>>> +        !pathname || strncmp(pathname, "/proc/", 6)) {
>>>> +        errno =3D original_errno;
>>>> +        return opened_fd;
>>>>        }
>>>>
>>>>        for (fake_open =3D fakes; fake_open->filename; fake_open++) {
>>>> @@ -8898,60 +9062,52 @@ static int maybe_do_fake_open(CPUArchState *c=
pu_env, int dirfd,
>>>>        }
>>>>
>>>>        if (fake_open->filename) {
>>>> -        const char *tmpdir;
>>>> -        char filename[PATH_MAX];
>>>> -        int fd, r;
>>>> -
>>>> -        fd =3D memfd_create("qemu-open", 0);
>>>> -        if (fd < 0) {
>>>> -            if (errno !=3D ENOSYS) {
>>>> -                return fd;
>>>> -            }
>>>> -            /* create temporary file to map stat to */
>>>> -            tmpdir =3D getenv("TMPDIR");
>>>> -            if (!tmpdir)
>>>> -                tmpdir =3D "/tmp";
>>>> -            snprintf(filename, sizeof(filename), "%s/qemu-open.XXXXX=
X", tmpdir);
>>>> -            fd =3D mkstemp(filename);
>>>> -            if (fd < 0) {
>>>> -                return fd;
>>>> -            }
>>>> -            unlink(filename);
>>>> -        }
>>>> -
>>>> -        if ((r =3D fake_open->fill(cpu_env, fd))) {
>>>> -            int e =3D errno;
>>>> -            close(fd);
>>>> -            errno =3D e;
>>>> -            return r;
>>>> +        int saved_errno, status_flags;
>>>> +
>>>> +        status_flags =3D flags & ~(O_CREAT | O_EXCL | O_TRUNC);
>>>> +        if (opened_fd >=3D 0) {
>>>> +            status_flags =3D fcntl(opened_fd, F_GETFL);
>>>> +            saved_errno =3D errno;
>>>> +            close(opened_fd);
>>>> +            if (status_flags < 0) {
>>>> +                errno =3D saved_errno;
>>>> +                return -1;
>>>> +            }
>>>> +        } else if (flags & O_DIRECTORY) {
>>>> +            errno =3D ENOTDIR;
>>>> +            return -1;
>>>> +        } else if ((flags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_=
EXCL)) {
>>>> +            errno =3D EEXIST;
>>>> +            return -1;
>>>>            }
>>>> -        lseek(fd, 0, SEEK_SET);
>>>>
>>>> -        return fd;
>>>> +        status_flags |=3D flags & O_CLOEXEC;
>>>> +        return fake_open_contents(cpu_env, fake_open->fill, status_f=
lags, safe);
>>>>        }
>>>>
>>>> -    return -2;
>>>> +    errno =3D original_errno;
>>>> +    return opened_fd;
>>>>    }
>>>>
>>>>    int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *=
pathname,
>>>>                        int flags, mode_t mode, bool safe)
>>>>    {
>>>> -    int fd =3D maybe_do_fake_open(cpu_env, dirfd, pathname, flags, m=
ode, 0, safe);
>>>> -    if (fd > -2) {
>>>> -        return fd;
>>>> -    }
>>>> +    struct open_how_ver0 how =3D { .flags =3D flags, .mode =3D mode =
};
>>>> +    const char *host_name =3D path(pathname);
>>>> +    int fd;
>>>>
>>>>        if (safe) {
>>>> -        return safe_openat(dirfd, path(pathname), flags, mode);
>>>> +        fd =3D safe_openat(dirfd, host_name, flags, mode);
>>>>        } else {
>>>> -        return openat(dirfd, path(pathname), flags, mode);
>>>> +        fd =3D openat(dirfd, host_name, flags, mode);
>>>>        }
>>>> +    return maybe_do_fake_open(cpu_env, fd, dirfd, host_name, &how,
>>>> +                              safe);
>>>>    }
>>>>
>>>> -
>>>>    static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
>>>> -                      abi_ptr guest_pathname, abi_ptr guest_open_how=
,
>>>> -                      abi_ulong guest_size)
>>>> +                     abi_ptr guest_pathname, abi_ptr guest_open_how,
>>>> +                     abi_ulong guest_size)
>>>>    {
>>>>        struct open_how_ver0 how =3D {0};
>>>>        char *pathname;
>>>> @@ -8981,23 +9137,19 @@ static int do_openat2(CPUArchState *cpu_env, =
abi_long dirfd,
>>>>        how.flags =3D target_to_host_bitmask(tswap64(how.flags), fcntl=
_flags_tbl);
>>>>        how.mode =3D tswap64(how.mode);
>>>>        how.resolve =3D tswap64(how.resolve);
>>>> -    int fd =3D maybe_do_fake_open(cpu_env, dirfd, pathname, how.flag=
s, how.mode,
>>>> -                                how.resolve, true);
>>>> -    if (fd > -2) {
>>>> -        ret =3D get_errno(fd);
>>>> -    } else {
>>>> -        const char *host_pathname =3D pathname;
>>>> -        if (pathname[0] =3D=3D '/' &&
>>>> -            !(how.resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH))) {
>>>> -            /*
>>>> -             * RESOLVE_BENEATH rejects absolute paths; RESOLVE_IN_RO=
OT
>>>> -             * resolves them relative to dirfd.
>>>> -             */
>>>> -            host_pathname =3D path(pathname);
>>>> -        }
>>>> -        ret =3D get_errno(safe_openat2(dirfd, host_pathname, &how,
>>>> -                                     sizeof(struct open_how_ver0)));
>>>> +    const char *host_pathname =3D pathname;
>>>> +    if (pathname[0] =3D=3D '/' &&
>>>> +        !(how.resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH))) {
>>>> +        /*
>>>> +         * RESOLVE_BENEATH rejects absolute paths; RESOLVE_IN_ROOT
>>>> +         * resolves them relative to dirfd.
>>>> +         */
>>>> +        host_pathname =3D path(pathname);
>>>>        }
>>>> +    int fd =3D safe_openat2(dirfd, host_pathname, &how,
>>>> +                         sizeof(struct open_how_ver0));
>>>> +    ret =3D get_errno(maybe_do_fake_open(cpu_env, fd, dirfd, host_pa=
thname, &how,
>>>> +                                      true));
>>>>
>>>>        fd_trans_unregister(ret);
>>>>        unlock_user(pathname, guest_pathname, 0);
>>>> @@ -9034,6 +9186,19 @@ ssize_t do_guest_readlink(const char *pathname=
, char *buf, size_t bufsiz)
>>>>        return ret;
>>>>    }
>>>>
>>>> +static ssize_t do_guest_readlinkat(int dirfd, const char *pathname,
>>>> +                                  char *buf, size_t bufsiz)
>>>> +{
>>>> +    const char *host_name =3D path(pathname);
>>>> +    g_autofree char *entry_path =3D proc_entry_path(dirfd, host_name=
);
>>>> +    ssize_t ret =3D readlinkat(dirfd, host_name, buf, bufsiz);
>>>> +
>>>> +    if (ret >=3D 0 && entry_path && is_proc_myself(entry_path, "exe"=
)) {
>>>> +        return do_guest_readlink(entry_path, buf, bufsiz);
>>>> +    }
>>>> +    return ret;
>>>> +}
>>>> +
>>>>    static int do_execv(CPUArchState *cpu_env, int dirfd,
>>>>                        abi_long pathname, abi_long guest_argp,
>>>>                        abi_long guest_envp, int flags, bool is_execve=
at)
>>>> @@ -11143,16 +11308,8 @@ static abi_long do_syscall1(CPUArchState *cp=
u_env, int num, abi_long arg1,
>>>>                } else if (!arg4) {
>>>>                    /* Short circuit this for the magic exe check. */
>>>>                    ret =3D -TARGET_EINVAL;
>>>> -            } else if (is_proc_myself((const char *)p, "exe")) {
>>>> -                /*
>>>> -                 * Don't worry about sign mismatch as earlier mappin=
g
>>>> -                 * logic would have thrown a bad address error.
>>>> -                 */
>>>> -                ret =3D MIN(strlen(real_exec_path), arg4);
>>>> -                /* We cannot NUL terminate the string. */
>>>> -                memcpy(p2, real_exec_path, ret);
>>>>                } else {
>>>> -                ret =3D get_errno(readlinkat(arg1, path(p), p2, arg4=
));
>>>> +                ret =3D get_errno(do_guest_readlinkat(arg1, p, p2, a=
rg4));
>>>>                }
>>>>                unlock_user(p2, arg3, ret);
>>>>                unlock_user(p, arg2, 0);
>>>> diff --git a/tests/tcg/multiarch/linux/proc-openat.c b/tests/tcg/mult=
iarch/linux/proc-openat.c
>>>> new file mode 100644
>>>> index 0000000000..4af2fde113
>>>> --- /dev/null
>>>> +++ b/tests/tcg/multiarch/linux/proc-openat.c
>>>> @@ -0,0 +1,94 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> +#define _GNU_SOURCE
>>>> +#include <assert.h>
>>>> +#include <errno.h>
>>>> +#include <fcntl.h>
>>>> +#include <stdlib.h>
>>>> +#include <string.h>
>>>> +#include <sys/resource.h>
>>>> +#include <unistd.h>
>>>> +
>>>> +static char expected[16384];
>>>> +static size_t expected_size;
>>>> +
>>>> +static void check(int dirfd, const char *name, int flags, int expect=
ed_errno)
>>>> +{
>>>> +    char actual[sizeof(expected)];
>>>> +    size_t size =3D 0;
>>>> +    int fd =3D openat(dirfd, name, flags);
>>>> +
>>>> +    if (expected_errno) {
>>>> +        assert(fd =3D=3D -1 && errno =3D=3D expected_errno);
>>>> +        return;
>>>> +    }
>>>> +    assert(fd >=3D 0);
>>>> +    assert((fcntl(fd, F_GETFD) & FD_CLOEXEC) =3D=3D
>>>> +           ((flags & O_CLOEXEC) ? FD_CLOEXEC : 0));
>>>> +    assert((fcntl(fd, F_GETFL) & (O_PATH | O_NOFOLLOW | O_ACCMODE)) =
=3D=3D
>>>> +           (flags & (O_PATH | O_NOFOLLOW | O_ACCMODE)));
>>>> +    if (flags & O_PATH) {
>>>> +        assert(read(fd, actual, 1) =3D=3D -1 && errno =3D=3D EBADF);
>>>> +    } else {
>>>> +        for (;;) {
>>>> +            ssize_t n =3D read(fd, actual + size, sizeof(actual) - s=
ize);
>>>> +
>>>> +            if (n < 0 && errno =3D=3D EINTR) {
>>>> +                continue;
>>>> +            }
>>>> +            assert(n >=3D 0);
>>>> +            if (!n) {
>>>> +                break;
>>>> +            }
>>>> +            size +=3D n;
>>>> +            assert(size < sizeof(actual));
>>>> +        }
>>>> +        assert(size =3D=3D expected_size && !memcmp(actual, expected=
, size));
>>>> +        assert(write(fd, "x", 1) =3D=3D -1 && errno =3D=3D EBADF);
>>>> +    }
>>>> +    assert(close(fd) =3D=3D 0);
>>>> +}
>>>> +
>>>> +int main(int argc, char **argv)
>>>> +{
>>>> +    struct rlimit saved, limit;
>>>> +    int cwd =3D open(".", O_PATH | O_DIRECTORY | O_CLOEXEC);
>>>> +    int proc =3D open("/proc", O_PATH | O_DIRECTORY | O_CLOEXEC);
>>>> +    int self =3D open("/proc/self", O_PATH | O_DIRECTORY | O_CLOEXEC=
);
>>>> +    int flags =3D O_RDONLY | O_CLOEXEC;
>>>> +
>>>> +    assert(cwd >=3D 0 && proc >=3D 0 && self >=3D 0);
>>>> +    for (int i =3D 0; i < argc; i++) {
>>>> +        size_t size =3D strlen(argv[i]) + 1;
>>>> +
>>>> +        assert(size <=3D sizeof(expected) - expected_size);
>>>> +        memcpy(expected + expected_size, argv[i], size);
>>>> +        expected_size +=3D size;
>>>> +    }
>>>> +    check(AT_FDCWD, "/proc/self/cmdline", flags, 0);
>>>> +    check(-1, "/proc/self/cmdline", flags, 0);
>>>> +    check(proc, "self/cmdline", flags, 0);
>>>> +    check(proc, "./self/cmdline", flags, 0);
>>>> +    check(self, "cmdline", flags, 0);
>>>> +    check(self, "cmdline", flags | O_NOFOLLOW, 0);
>>>> +    check(self, "cmdline", O_PATH | O_CLOEXEC, 0);
>>>> +    check(self, "cmdline", flags | O_DIRECTORY, ENOTDIR);
>>>> +    assert(chdir("/proc") =3D=3D 0);
>>>> +    check(AT_FDCWD, "self/cmdline", flags, 0);
>>>> +    check(-1, "self/cmdline", flags, EBADF);
>>>> +    assert(fchdir(cwd) =3D=3D 0);
>>>> +    assert(close(self) =3D=3D 0);
>>>> +    assert(close(proc) =3D=3D 0);
>>>> +    assert(close(cwd) =3D=3D 0);
>>>> +    assert(getrlimit(RLIMIT_NOFILE, &saved) =3D=3D 0);
>>>> +    int next =3D open("/dev/null", O_RDONLY | O_CLOEXEC);
>>>> +
>>>> +    assert(next >=3D 0);
>>>> +    limit =3D saved;
>>>> +    limit.rlim_cur =3D next + 1;
>>>> +    assert(setrlimit(RLIMIT_NOFILE, &limit) =3D=3D 0);
>>>> +    assert(close(next) =3D=3D 0);
>>>> +    check(AT_FDCWD, "/proc/self/cmdline", flags, 0);
>>>> +    check(AT_FDCWD, "/proc/self/cmdline", flags | O_NOFOLLOW, 0);
>>>> +    assert(setrlimit(RLIMIT_NOFILE, &saved) =3D=3D 0);
>>>> +    return EXIT_SUCCESS;
>>>> +}
>>>> diff --git a/tests/tcg/multiarch/linux/proc-openat2.c b/tests/tcg/mul=
tiarch/linux/proc-openat2.c
>>>> new file mode 100644
>>>> index 0000000000..7641bbe634
>>>> --- /dev/null
>>>> +++ b/tests/tcg/multiarch/linux/proc-openat2.c
>>>> @@ -0,0 +1,83 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> +#define _GNU_SOURCE
>>>> +#include <assert.h>
>>>> +#include <errno.h>
>>>> +#include <fcntl.h>
>>>> +#include <stdint.h>
>>>> +#include <stdlib.h>
>>>> +#include <sys/syscall.h>
>>>> +#include <unistd.h>
>>>> +
>>>> +#ifdef SYS_openat2
>>>> +#include <linux/openat2.h>
>>>> +
>>>> +static int cmdline_argc;
>>>> +static char **cmdline_argv;
>>>> +
>>>> +static void check(int dirfd, const char *name, uint64_t flags,
>>>> +                  uint64_t resolve, int expected_errno)
>>>> +{
>>>> +    struct open_how how =3D { .flags =3D flags, .resolve =3D resolve=
 };
>>>> +    char byte;
>>>> +    int fd =3D syscall(SYS_openat2, dirfd, name, &how, sizeof(how));
>>>> +
>>>> +    if (expected_errno) {
>>>> +        assert(fd =3D=3D -1 && errno =3D=3D expected_errno);
>>>> +        return;
>>>> +    }
>>>> +    assert(fd >=3D 0);
>>>> +    assert(fcntl(fd, F_GETFD) =3D=3D FD_CLOEXEC);
>>>> +    if (flags & O_PATH) {
>>>> +        assert(fcntl(fd, F_GETFL) & O_PATH);
>>>> +        assert(read(fd, &byte, 1) =3D=3D -1 && errno =3D=3D EBADF);
>>>> +    } else {
>>>> +        for (int i =3D 0; i < cmdline_argc; i++) {
>>>> +            const char *p =3D cmdline_argv[i];
>>>> +
>>>> +            do {
>>>> +                assert(read(fd, &byte, 1) =3D=3D 1 && byte =3D=3D *p=
);
>>>> +            } while (*p++);
>>>> +        }
>>>> +        assert(read(fd, &byte, 1) =3D=3D 0);
>>>> +        assert(write(fd, "x", 1) =3D=3D -1 && errno =3D=3D EBADF);
>>>> +    }
>>>> +    assert(close(fd) =3D=3D 0);
>>>> +}
>>>> +#endif
>>>> +
>>>> +int main(int argc, char **argv)
>>>> +{
>>>> +#ifdef SYS_openat2
>>>> +    struct open_how how =3D { .flags =3D O_RDONLY | O_CLOEXEC };
>>>> +    int fd =3D syscall(SYS_openat2, AT_FDCWD, "/proc/self/cmdline",
>>>> +                     &how, sizeof(how));
>>>> +    int proc, self, root, flags =3D O_RDONLY | O_CLOEXEC;
>>>> +
>>>> +    cmdline_argc =3D argc;
>>>> +    cmdline_argv =3D argv;
>>>> +    if (fd < 0 && errno =3D=3D ENOSYS) {
>>>> +        return EXIT_SUCCESS;
>>>> +    }
>>>> +    assert(fd >=3D 0 && close(fd) =3D=3D 0);
>>>> +    proc =3D open("/proc", O_PATH | O_DIRECTORY | O_CLOEXEC);
>>>> +    self =3D open("/proc/self", O_PATH | O_DIRECTORY | O_CLOEXEC);
>>>> +    root =3D open("/", O_PATH | O_DIRECTORY | O_CLOEXEC);
>>>> +    assert(proc >=3D 0 && self >=3D 0 && root >=3D 0);
>>>> +    check(-1, "/proc/self/cmdline", flags, 0, 0);
>>>> +    check(AT_FDCWD, "/proc/self/cmdline", flags,
>>>> +          RESOLVE_NO_SYMLINKS, ELOOP);
>>>> +    check(proc, "self/cmdline", flags, 0, 0);
>>>> +    check(proc, "self/cmdline", flags, RESOLVE_NO_SYMLINKS, ELOOP);
>>>> +    check(proc, "self/root/proc/self/cmdline", flags,
>>>> +          RESOLVE_NO_MAGICLINKS, ELOOP);
>>>> +    check(self, "../self/cmdline", flags, RESOLVE_BENEATH, EXDEV);
>>>> +    check(self, "../self/cmdline", flags, RESOLVE_IN_ROOT, ENOENT);
>>>> +    check(root, "proc/self/cmdline", flags, RESOLVE_NO_XDEV, EXDEV);
>>>> +    check(proc, "self/cmdline", flags, UINT64_C(1) << 63, EINVAL);
>>>> +    check(self, "cmdline", O_PATH | O_CLOEXEC, 0, 0);
>>>> +    assert(close(root) =3D=3D 0);
>>>> +    assert(close(self) =3D=3D 0);
>>>> +    assert(close(proc) =3D=3D 0);
>>>> +#endif
>>>> +    return EXIT_SUCCESS;
>>>> +}
>>>> diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/me=
son.build
>>>> index e60a052700..337dda729a 100644
>>>> --- a/tests/tcg/multiarch/meson.build
>>>> +++ b/tests/tcg/multiarch/meson.build
>>>> @@ -61,6 +61,8 @@ tests +=3D {
>>>>      multiarch/'linux/linux-shmat-null.c': {},
>>>>      multiarch/'linux/linux-sigrtminmax.c': {},
>>>>      multiarch/'linux/linux-test.c': {},
>>>> +  multiarch/'linux/proc-openat.c': {},
>>>> +  multiarch/'linux/proc-openat2.c': {},
>>>>      multiarch/'linux/test-vma.c': {},
>>>>    }
>>>>
>>>> --
>>>> 2.55.0
>>>>
>>


