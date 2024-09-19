Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A75ACF3960
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 16:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srJfr-0000On-Sy; Thu, 19 Sep 2024 12:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1srJf8-0000N5-V3
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 12:05:48 -0400
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1srJf6-00069w-B2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 12:05:46 -0400
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MwwqB-1s3cLr1aHr-00vNsU; Thu, 19 Sep 2024 18:05:36 +0200
Message-ID: <6a3e5c86-b722-4336-bd58-2c0fa72bf8df@vivier.eu>
Date: Thu, 19 Sep 2024 18:05:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] linux-user: add openat2 support in linux-user
To: Michael Vogt <michael.vogt@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Vogt <mvogt@redhat.com>
References: <cover.1725607795.git.mvogt@redhat.com>
 <50c1b34064efe7e2901802e260f629ccdde7524b.1725607795.git.mvogt@redhat.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <50c1b34064efe7e2901802e260f629ccdde7524b.1725607795.git.mvogt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yWyfzl0n5SH/dNlAqF67OITsUgfHhe5zzCDTQkNrHb3F+OadBu6
 XYIYQnHxFfravsdIRtG2qinebFNc9LspB2FR1m8w2sPK8Hd2Z0Ea+Jk1/5N92wNHWZ05HUj
 4SKE8ziK/qvK0a6QSEi+NXuEw+c/+SOyX0ooPXxkAl2QTHOhDdkIVZnNvYwg7/R3shbF8SO
 znOamV0idFIb7MGLsajMQ==
UI-OutboundReport: notjunk:1;M01:P0:BgnN2+QEfrQ=;24LJgQRvnPiQTPkYeXB2BJ3Ve+O
 JciUPa9qdVmwNilGIuhKBevU4ehlj9sfD+qsODbZ4gy2XnjtBEkhXTijUQpJjniQ1kBQsM5jv
 01ORCfQAmXgNkVtAW7aEI6t2HPsSSvfSBtm8guUaVtYPI3NS6CTlwM5ALAJBNB4w5Uv4TSigV
 GO8whvmoIl8rYVIw6fMLxmxtoAUzkKbEWcIk9wVEajlDpxN1jrwTlahiplNg0HU6Y9QNXqCnX
 1rn00iJgGbHWt+tYv1noRjj3LtP4L0H5S0qwzpd/jl1vHNawyaHFVZpXFgNJwqwaJKUF6KrRK
 D8s7EqYzBeXdLncmKZxXpxfno+ch+lTwPmkOI6FNia84L9RqdF4JaB5gsthpAwkGBgyF0Wlms
 9bHP3trN3kPx6uznAW42XvaFpzacvgal8obn+kfofKDZ8NYgf3qAwSjPoNGr3GKB8AZW6tfKw
 m3BADqlJV+8lmdYg3mToeno5TiuL+Mz4COSvOFlH/hcyT+3V3FFTdwYct4LDSWDN15fVQrOAD
 AaDg2N/9ok+vJcc05w9UXeCqIkJuMg/kReXsis12/zaPObqwtDCCbcO33OaGsviIoaUK1Z+PY
 is/psCyeTqbIa1ahsDkkIml/bkY9P2XIa012Vgvkabvw99jfbCcKIGzyNwkVd5oSPF5dpYhx8
 fqma8GPzkodC2ttT4I9O4Ea9h1siHryzigU7QVX7eFvLYF4k6TIyKeHF7882PMqH2qSWlE0y3
 ho350oCrotnhEFYe0Xf3/Wck8dusYR00A==
Received-SPF: pass client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Le 06/09/2024 à 09:39, Michael Vogt a écrit :
> This commit adds support for the `openat2()` syscall in the
> `linux-user` userspace emulator.
> 
> It is implemented by extracting a new helper `maybe_do_fake_open()`
> out of the exiting `do_guest_openat()` and share that with the
> new `do_guest_openat2()`. Unfortunately we cannot just make
> do_guest_openat2() a superset of do_guest_openat() because the
> openat2() syscall is stricter with the argument checking and
> will return an error for invalid flags or mode combinations (which
> open()/openat() will ignore).
> 
> The implementation is similar to SYSCALL_DEFINE(openat2), i.e.
> a new `copy_struct_from_user()` is used that works the same
> as the kernels version to support backwards-compatibility
> for struct syscall argument.
> 
> Instead of including openat2.h we create a copy of `open_how`
> as `open_how_ver0` to ensure that if the structure grows we
> can log a LOG_UNIMP warning.
> 
> Note that in this commit using openat2() for a "faked" file in
> /proc will ignore the "resolve" flags. This is not great but it
> seems similar to the exiting behavior when openat() is called
> with a dirfd to "/proc". Here too the fake file lookup may
> not catch the special file because "realpath()" is used to
> determine if the path is in /proc. Alternatively to ignoring
> we could simply fail with `-TARGET_ENOSYS` (or similar) if
> `resolve` flags are passed and we found something that looks
> like a file in /proc that needs faking.
> 
> Signed-off-by: Michael Vogt <mvogt@redhat.com>
> Buglink: https://github.com/osbuild/bootc-image-builder/issues/619
> ---
>   linux-user/syscall.c      | 116 ++++++++++++++++++++++++++++++++++++--
>   linux-user/syscall_defs.h |   7 +++
>   2 files changed, 119 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9d5415674d..83c944508b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -602,6 +602,34 @@ static int check_zeroed_user(abi_long addr, size_t ksize, size_t usize)
>       return 1;
>   }
>   
> +/*
> + * Copies a target struct to a host struct, in a way that guarantees
> + * backwards-compatibility for struct syscall arguments.
> + *
> + * Similar to kernels uaccess.h:copy_struct_from_user()
> + */
> +static int
> +copy_struct_from_user(void *dst, size_t ksize, abi_ptr src, size_t usize)
> +{
> +    size_t size = MIN(ksize, usize);
> +    size_t rest = MAX(ksize, usize) - size;
> +
> +    /* Deal with trailing bytes. */
> +    if (usize < ksize) {
> +        memset(dst + size, 0, rest);
> +    } else if (usize > ksize) {
> +        int ret = check_zeroed_user(src, ksize, usize);
> +        if (ret <= 0) {
> +            return ret ?: -TARGET_E2BIG;
> +        }
> +    }
> +    /* Copy the interoperable parts of the struct. */
> +    if (copy_from_user(dst, src, size)) {
> +        return -TARGET_EFAULT;
> +    }
> +    return 0;
> +}
> +
>   #define safe_syscall0(type, name) \
>   static type safe_##name(void) \
>   { \
> @@ -653,6 +681,15 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
>   safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
>   safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
>                 int, flags, mode_t, mode)
> +
> +struct open_how_ver0 {
> +    __u64 flags;
> +    __u64 mode;
> +    __u64 resolve;
> +};
> +safe_syscall4(int, openat2, int, dirfd, const char *, pathname, \
> +              const struct open_how_ver0 *, how, size_t, size)
> +
>   #if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
>   safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
>                 struct rusage *, rusage)
> @@ -8334,8 +8371,9 @@ static int open_net_route(CPUArchState *cpu_env, int fd)
>   }
>   #endif
>   
> -int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
> -                    int flags, mode_t mode, bool safe)
> +static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
> +                              const char *fname, int flags, mode_t mode,
> +                              bool safe, bool *use_returned_fd)
>   {
>       g_autofree char *proc_name = NULL;
>       const char *pathname;
> @@ -8362,6 +8400,7 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
>   #endif
>           { NULL, NULL, NULL }
>       };
> +    *use_returned_fd = true;
>   
>       /* if this is a file from /proc/ filesystem, expand full name */
>       proc_name = realpath(fname, NULL);
> @@ -8418,13 +8457,77 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
>           return fd;
>       }
>   
> +    *use_returned_fd = false;
> +    return -1;
> +}

I don't think you need the flag, you can return -2 in this case.
  >= 0 we found a fake file, use the fd
-1 -> error
-2 -> no fake file, no error, use your own fd

> +
> +int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,

perhaps you can keep "pathname" for the parameter name rather than "fname" to have no change on the 
openat()/safe_openat() line (clearer diff?)?

> +                    int flags, mode_t mode, bool safe)
> +{
> +    bool use_returned_fd;
> +    int fd = maybe_do_fake_open(cpu_env, dirfd, fname, flags, mode, safe,
> +                                &use_returned_fd);
> +    if (use_returned_fd) {
> +        return fd;
> +    } > +
>       if (safe) {
> -        return safe_openat(dirfd, path(pathname), flags, mode);
> +        return safe_openat(dirfd, path(fname), flags, mode);
>       } else {
> -        return openat(dirfd, path(pathname), flags, mode);
> +        return openat(dirfd, path(fname), flags, mode);
>       }
>   }
>   
> +
> +static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
> +                      abi_ptr guest_pathname, abi_ptr guest_open_how,
> +                      abi_long guest_size)
> +{
> +    struct open_how_ver0 how = {0};
> +    int ret;
> +
> +    if (guest_size < sizeof(struct target_open_how_ver0)) {
> +        return -TARGET_EINVAL;
> +    }
> +    ret = copy_struct_from_user(&how, sizeof(how), guest_open_how, guest_size);
> +    if (ret) {
> +        if (ret == -TARGET_E2BIG) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "Unimplemented openat2 open_how size: %lu\n",
> +                          guest_size);
> +        }
> +        return ret;
> +    }
> +    char *pathname = lock_user_string(guest_pathname);
> +    if (!pathname) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    how.flags = target_to_host_bitmask(how.flags, fcntl_flags_tbl);
> +    how.mode = tswap64(how.mode);
> +    how.resolve = tswap64(how.resolve);
> +
> +    /*
> +     * Ideally we would pass "how->resolve" flags into this helper too but
> +     * the lookup for files that need faking is based on "realpath()" so
> +     * neither a dirfd for "proc" nor restrictions via "resolve" flags can
> +     * be honored right now.
> +     */
> +    bool use_returned_fd;

If I remember correctly QEMU coding style don't put declaration in the middle of the code.

> +    int fd = maybe_do_fake_open(cpu_env, dirfd, pathname, how.flags, how.mode,
> +                                true, &use_returned_fd);
> +    if (use_returned_fd) {
> +        return fd;

this need to be get_errno(fd).

> +    } else {
> +        ret = get_errno(safe_openat2(dirfd, pathname, &how,
> +                                     sizeof(struct open_how_ver0)));
> +    }
> +
> +    fd_trans_unregister(ret);
> +    unlock_user(pathname, guest_pathname, 0);
> +    return ret;
> +}
> +
>   ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
>   {
>       ssize_t ret;
> @@ -9197,6 +9300,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>           fd_trans_unregister(ret);
>           unlock_user(p, arg2, 0);
>           return ret;
> +#if defined(TARGET_NR_openat2)
> +    case TARGET_NR_openat2:
> +        ret = do_openat2(cpu_env, arg1, arg2, arg3, arg4);
> +        return ret;
> +#endif
>   #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
>       case TARGET_NR_name_to_handle_at:
>           ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index a00b617cae..74abcb4613 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2754,4 +2754,11 @@ struct target_sched_param {
>       abi_int sched_priority;
>   };
>   
> +/* from kernel's include/uapi/linux/openat2.h */
> +struct target_open_how_ver0 {
> +    abi_ullong flags;
> +    abi_ullong mode;
> +    abi_ullong resolve;
> +};
> +
>   #endif

The rest looks good.

Thanks,
Laurent

