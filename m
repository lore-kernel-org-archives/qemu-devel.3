Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD07AC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 11:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2q4N-0004Wm-O4; Thu, 10 Apr 2025 07:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u2q4L-0004WM-GO; Thu, 10 Apr 2025 07:27:41 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u2q4I-0001A4-RT; Thu, 10 Apr 2025 07:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=bqRCx/Y012Cn2fRNmp67eIyBgyBRV81tOmdZjdIetiY=; b=U/Ri2rGWUEOsEneRH01REGKGIx
 C55h3D7Or5BWc2JmdGN3RMpSdyddNBxLR1Xyf2lNxrbd8br3QT+GhWUZjy9N5unyKG4dhABBLN9O8
 7p23SBfGJwBQsqBZ+ELrtP50wTfa8x9sHTVP7yekHlNTXcv8gB0fP8w320Pl3qbrSrG7s9Gj3oyh1
 5W+tecztrbUldD2CQDFqpXv3iREL62hbghnirdriFKfWh1x5Ia1ZJ6bS96sWL9JZzBytqkdVEhauJ
 i4YMlmqZBJqK/LFScX0t5YcM5HAGmaqCCeVwV6pfcH878AEZUk89j+XqE6u1r+toALgOllxwt7pZL
 H2aWclkpvnLfQBeM4UkYg8qWEcK/GU4TyPT+YjP+NquG7S8HVmopexZovn6MLXWLYhc4C6/dyJalZ
 ZZoPSFaSdHUl6+o8nctqsgfMweBaUibSIdQOAbfxbKazyFWCR9xWIP/5ZLQzGzHpfURWkWkBba1zV
 VTp9MTQv5To9CBlgBb4zzBdAPIBtpWJz48BeB7xVmurJVJeHk6Vu5kVzj0fNjqzB+XKk9oTRnofNg
 U1tG+XsTULrewEAELQvVyB3Xsc25VoOfigDly6ZB2moygTtkDhHlZkwTmsN1JOHimyZNe4i5JvDUt
 Q8c871suHMrXz6/UzFBUMPrHh1m30DQ6rP+egMBEc=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Greg Kurz <groug@kaod.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?ISO-8859-1?Q?Marc=2DAndr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel P =?ISO-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH 08/10] hw/9pfs: Allow using hw/9pfs with emscripten
Date: Thu, 10 Apr 2025 13:27:19 +0200
Message-ID: <2533109.DitPQcejgS@silver>
In-Reply-To: <16376e4b63fad6f847ceadb39b8f9780fc288198.1744032780.git.ktokunaga.mail@gmail.com>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <16376e4b63fad6f847ceadb39b8f9780fc288198.1744032780.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Monday, April 7, 2025 4:45:59 PM CEST Kohei Tokunaga wrote:
> Emscripten's fiber does not support submitting coroutines to other
> threads. So this commit modifies hw/9pfs/coth.h to disable this behavior
> when compiled with Emscripten.

The lack of being able to dispatch a coroutine to a worker thread is one
thing, however it would probably still make sense to use fibers in 9pfs as
replacement of its coroutines mechanism.

In 9pfs coroutines are used to dispatch blocking fs I/O syscalls from main
thread to worker thread(s):

https://wiki.qemu.org/Documentation/9p#Control_Flow

If you just remove the coroutine code entirely, 9p server might hang for good,
and with it QEMU's main thread.

By using fibers instead, it would not hang, as it seems as if I/O syscalls are
emulated in Emscripten, right?

> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>  fsdev/file-op-9p.h     |  3 +++
>  fsdev/meson.build      |  2 +-
>  hw/9pfs/9p-util-stub.c | 43 ++++++++++++++++++++++++++++++++++++++++++
>  hw/9pfs/9p-util.h      | 18 ++++++++++++++++++
>  hw/9pfs/9p.c           |  3 +++
>  hw/9pfs/coth.h         | 12 ++++++++++++
>  hw/9pfs/meson.build    |  2 ++
>  meson.build            |  6 +++---
>  8 files changed, 85 insertions(+), 4 deletions(-)
>  create mode 100644 hw/9pfs/9p-util-stub.c
> 
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index 4997677460..b7ca2640ce 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -26,6 +26,9 @@
>  # include <sys/param.h>
>  # include <sys/mount.h>
>  #endif
> +#ifdef EMSCRIPTEN
> +#include <sys/vfs.h>
> +#endif
>  
>  #define SM_LOCAL_MODE_BITS    0600
>  #define SM_LOCAL_DIR_MODE_BITS    0700
> diff --git a/fsdev/meson.build b/fsdev/meson.build
> index c751d8cb62..c3e92a29d7 100644
> --- a/fsdev/meson.build
> +++ b/fsdev/meson.build
> @@ -5,6 +5,6 @@ fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
>    '9p-marshal.c',
>    'qemu-fsdev.c',
>  ), if_false: files('qemu-fsdev-dummy.c'))
> -if host_os in ['linux', 'darwin']
> +if host_os in ['linux', 'darwin', 'emscripten']
>    system_ss.add_all(fsdev_ss)
>  endif
> diff --git a/hw/9pfs/9p-util-stub.c b/hw/9pfs/9p-util-stub.c
> new file mode 100644
> index 0000000000..57c89902ab
> --- /dev/null
> +++ b/hw/9pfs/9p-util-stub.c
> @@ -0,0 +1,43 @@
> +/*
> + * 9p utilities stub functions
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "9p-util.h"
> +
> +ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
> +                             void *value, size_t size)
> +{
> +    return -1;
> +}
> +
> +ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
> +                              char *list, size_t size)
> +{
> +    return -1;
> +}
> +
> +ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
> +                                const char *name)
> +{
> +    return -1;
> +}
> +
> +int fsetxattrat_nofollow(int dirfd, const char *path, const char *name,
> +                         void *value, size_t size, int flags)
> +{
> +    return -1;
> +
> +}
> +
> +int qemu_mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
> +{
> +    return -1;
> +}
> +
> +ssize_t fgetxattr(int fd, const char *name, void *value, size_t size)
> +{
> +    return -1;
> +}

Missing

    errno = ENOTSUP;

> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index 7bc4ec8e85..8c5006fcdc 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -84,6 +84,24 @@ static inline int errno_to_dotl(int err) {
>      } else if (err == EOPNOTSUPP) {
>          err = 95; /* ==EOPNOTSUPP on Linux */
>      }
> +#elif defined(EMSCRIPTEN)
> +    /*
> +     * FIXME: Only most important errnos translated here yet, this should be
> +     * extended to as many errnos being translated as possible in future.
> +     */
> +    if (err == ENAMETOOLONG) {
> +        err = 36; /* ==ENAMETOOLONG on Linux */
> +    } else if (err == ENOTEMPTY) {
> +        err = 39; /* ==ENOTEMPTY on Linux */
> +    } else if (err == ELOOP) {
> +        err = 40; /* ==ELOOP on Linux */
> +    } else if (err == ENODATA) {
> +        err = 61; /* ==ENODATA on Linux */
> +    } else if (err == ENOTSUP) {
> +        err = 95; /* ==EOPNOTSUPP on Linux */
> +    } else if (err == EOPNOTSUPP) {
> +        err = 95; /* ==EOPNOTSUPP on Linux */
> +    }

Looks like you just copied the macOS errno translation code. That probably
doesn't make sense.

/Christian

>  #else
>  #error Missing errno translation to Linux for this host system
>  #endif
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 7cad2bce62..4f45f0edd3 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -4013,6 +4013,9 @@ out_nofid:
>   * Linux guests.
>   */
>  #define P9_XATTR_SIZE_MAX 65536
> +#elif defined(EMSCRIPTEN)
> +/* No support for xattr */
> +#define P9_XATTR_SIZE_MAX 0
>  #else
>  #error Missing definition for P9_XATTR_SIZE_MAX for this host system
>  #endif
> diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
> index 2c54249b35..7b0d05ba1b 100644
> --- a/hw/9pfs/coth.h
> +++ b/hw/9pfs/coth.h
> @@ -19,6 +19,7 @@
>  #include "qemu/coroutine-core.h"
>  #include "9p.h"
>  
> +#ifndef EMSCRIPTEN
>  /*
>   * we want to use bottom half because we want to make sure the below
>   * sequence of events.
> @@ -57,6 +58,17 @@
>          /* re-enter back to qemu thread */                              \
>          qemu_coroutine_yield();                                         \
>      } while (0)
> +#else
> +/*
> + * FIXME: implement this on emscripten but emscripten's coroutine
> + * implementation (fiber) doesn't support submitting a coroutine to other
> + * threads.
> + */
> +#define v9fs_co_run_in_worker(code_block)                               \
> +    do {                                                                \
> +        code_block;                                                     \
> +    } while (0)
> +#endif
>  
>  void co_run_in_worker_bh(void *);
>  int coroutine_fn v9fs_co_readlink(V9fsPDU *, V9fsPath *, V9fsString *);
> diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
> index d35d4f44ff..04f85fb9e9 100644
> --- a/hw/9pfs/meson.build
> +++ b/hw/9pfs/meson.build
> @@ -17,6 +17,8 @@ if host_os == 'darwin'
>    fs_ss.add(files('9p-util-darwin.c'))
>  elif host_os == 'linux'
>    fs_ss.add(files('9p-util-linux.c'))
> +elif host_os == 'emscripten'
> +  fs_ss.add(files('9p-util-stub.c'))
>  endif
>  fs_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-9p-backend.c'))
>  system_ss.add_all(when: 'CONFIG_FSDEV_9P', if_true: fs_ss)
> diff --git a/meson.build b/meson.build
> index ab84820bc5..a3aadf8b59 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2356,11 +2356,11 @@ dbus_display = get_option('dbus_display') \
>    .allowed()
>  
>  have_virtfs = get_option('virtfs') \
> -    .require(host_os == 'linux' or host_os == 'darwin',
> +    .require(host_os == 'linux' or host_os == 'darwin' or host_os == 'emscripten',
>               error_message: 'virtio-9p (virtfs) requires Linux or macOS') \
> -    .require(host_os == 'linux' or cc.has_function('pthread_fchdir_np'),
> +    .require(host_os == 'linux' or host_os == 'emscripten' or cc.has_function('pthread_fchdir_np'),
>               error_message: 'virtio-9p (virtfs) on macOS requires the presence of pthread_fchdir_np') \
> -    .require(host_os == 'darwin' or libattr.found(),
> +    .require(host_os == 'darwin' or host_os == 'emscripten' or libattr.found(),
>               error_message: 'virtio-9p (virtfs) on Linux requires libattr-devel') \
>      .disable_auto_if(not have_tools and not have_system) \
>      .allowed()
>



