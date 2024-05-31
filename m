Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149F3C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 13:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD2Oc-0007kF-SH; Fri, 31 May 2024 09:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sD2Ob-0007k4-71
 for qemu-devel@nongnu.org; Fri, 31 May 2024 09:34:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sD2OZ-0004aJ-8Q
 for qemu-devel@nongnu.org; Fri, 31 May 2024 09:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717162450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SO4l/aW2tdmnT4dg9lQ8rnqcO/wykQZIem4HoV2LAxg=;
 b=dlVZf/nf6/xcg5/41Lh9ziUjNvqHwZo9/0P+eXfqj67T6iqd4kwoZQKotqndAGUM6hxQi3
 DBhfBVdbK3pv70IIvAhZ5HT0W0Gm459+4/9+OYeW5kxmXPDVRJ5luzwAppM9n2lCjNZQFg
 iaFiXmWXueSzqtHj7mEXf+XKnm3CDUs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-VlIP6U_PNdeu7S1SJ5mC4g-1; Fri, 31 May 2024 09:34:08 -0400
X-MC-Unique: VlIP6U_PNdeu7S1SJ5mC4g-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6f8e6666396so56300a34.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 06:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717162448; x=1717767248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SO4l/aW2tdmnT4dg9lQ8rnqcO/wykQZIem4HoV2LAxg=;
 b=U70dTUKdMkxQMTqlehl/NSkT2v7pTqeVrIVRbgi4vn5c4vOCSITOZ+nakcuKhkD/09
 DIoF8lWVqGKDboVeJr0YAgLHXWXsVlZwZiI0ZqK1iD7s95venJirROxCqd+Wk271lrQq
 C6CNZiSjwu2cqtD9IOx5SGT/PsKQDieUFNj7bmOpPCHEr4QdSs0V5Pix/ZjfsfjB8szK
 PL/t8oJKhrA3f3669QMCEreEff5VDFm7DOrEp4CtQZDLQ6u57PMbJm0KIhfoUOILzUrf
 oWuWqGLNtv//0ByFSusPUKLZBpp3PN8cIHwihc78J9Q1AOFpPStCDr9aaXFvqTjsb7Co
 Aa6A==
X-Gm-Message-State: AOJu0YyKQu7X2svTWgJ3TyJ6Yzbegfh+8xanfqHm+rC3SxA8xW4UImR8
 HpznFKYFuuQGEgLlJ9Kc8IFvCL5WXNEuQzmf2nz7JFgYFeITnPsEKxGwQBP1tJtqBqlcoJrxt3y
 5qall2svcLvYD0diTOTdCxqH3Diqvmis/WmAcpN7+EQvQim/KuVyt
X-Received: by 2002:a05:6808:1a0b:b0:3d1:d475:35f8 with SMTP id
 5614622812f47-3d1e3486b9fmr1918647b6e.2.1717162446983; 
 Fri, 31 May 2024 06:34:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2Dc2PiCmR0/hERHLlGsYfwIfDwF/UYDR5GG5ZlCGyhu8dCks6qD8ba4UxNEHAEhs58kxcTw==
X-Received: by 2002:a05:6808:1a0b:b0:3d1:d475:35f8 with SMTP id
 5614622812f47-3d1e3486b9fmr1918593b6e.2.1717162446173; 
 Fri, 31 May 2024 06:34:06 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4b40692bsm6480756d6.92.2024.05.31.06.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 06:34:05 -0700 (PDT)
Date: Fri, 31 May 2024 09:34:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/4] tests/qtest/migration-test: Add a postcopy
 memfile test
Message-ID: <ZlnRy0PS17qa2aqb@x1n>
References: <20240530095408.31608-1-npiggin@gmail.com>
 <20240530095408.31608-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530095408.31608-5-npiggin@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, May 30, 2024 at 07:54:07PM +1000, Nicholas Piggin wrote:
> Postcopy requires userfaultfd support, which requires tmpfs if a memory
> file is used.
> 
> This adds back support for /dev/shm memory files, but adds preallocation
> to skip environments where that mount is limited in size.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Thanks for doing this regardless.

> ---
>  tests/qtest/migration-test.c | 77 ++++++++++++++++++++++++++++++++----
>  1 file changed, 69 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 86eace354e..5078033ded 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  
>  #include "libqtest.h"
>  #include "qapi/qmp/qdict.h"
> @@ -553,6 +554,7 @@ typedef struct {
>       */
>      bool hide_stderr;
>      bool use_memfile;
> +    bool use_shm_memfile;

Nitpick: when having both, it's slightly confusing on the name, e.g. not
clear whether use_memfile needs to be set to true too if use_shm_memfile=true.

Maybe "use_tmpfs_memfile" and "use_shm_memfile"?

>      /* only launch the target process */
>      bool only_target;
>      /* Use dirty ring if true; dirty logging otherwise */
> @@ -739,7 +741,62 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          ignore_stderr = "";
>      }
>  
> -    if (args->use_memfile) {
> +    if (!qtest_has_machine(machine_alias)) {
> +        g_autofree char *msg = g_strdup_printf("machine %s not supported",
> +                                               machine_alias);
> +        g_test_skip(msg);
> +        return -1;
> +    }
> +
> +    if (args->use_shm_memfile) {
> +#if defined(__NR_userfaultfd) && defined(__linux__)

IIUC we only need defined(__linux__) as there's nothing to do with uffd yet?

> +        int fd;
> +        uint64_t size;
> +
> +        if (getenv("GITLAB_CI")) {
> +            /*
> +             * Gitlab runners are limited to 64MB shm size and despite
> +             * pre-allocation there is concern that concurrent tests
> +             * could result in nondeterministic failures. Until all shm
> +             * usage in all CI tests is found to fail gracefully on
> +             * ENOSPC, it is safer to avoid large allocations for now.
> +             *
> +             * https://lore.kernel.org/qemu-devel/875xuwg4mx.fsf@suse.de/
> +             */
> +            g_test_skip("shm tests are not supported in Gitlab CI environment");
> +            return -1;
> +        }

I'm not sure whether this is Fabiano's intention.  I'm wondering whether we
can drop this and just let it still run there.

Other tests not detecting avaiablility of shmem looks like a separate issue
to be fixed to me, regardless of this.

My wild guess is since we're doing memory_size+64K below then if test won't
fail others won't either, as normally the shmem quota should normally be
power of 2 anyway.. then it should always fit another few MBs if this one.
While this test is ready to fail gracefully now.

> +
> +        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> +            g_test_skip("/dev/shm does not exist or is not a directory");
> +            return -1;
> +        }
> +
> +        /*
> +         * Pre-create and allocate the file here, because /dev/shm/
> +         * is known to be limited in size in some places (e.g., Gitlab CI).
> +         */
> +        memfile_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
> +        fd = open(memfile_path, O_WRONLY | O_CREAT | O_EXCL, S_IRUSR | S_IWUSR);
> +        if (fd == -1) {
> +            g_test_skip("/dev/shm file could not be created");
> +            return -1;
> +        }
> +
> +        g_assert(qemu_strtosz(memory_size, NULL, &size) == 0);
> +        size += 64*1024; /* QEMU may map a bit more memory for a guard page */
> +
> +        if (fallocate(fd, 0, 0, size) == -1) {
> +            unlink(memfile_path);
> +            perror("could not alloc"); exit(1);
> +            g_test_skip("Could not allocate machine memory in /dev/shm");
> +            return -1;
> +        }
> +        close(fd);
> +#else
> +        g_test_skip("userfaultfd is not supported");

"/dev/shm not available" instead?

> +#endif
> +    } else if (args->use_memfile) {
>          memfile_path = g_strdup_printf("/%s/qemu-%d", tmpfs, getpid());
>          memfile_opts = g_strdup_printf(
>              "-object memory-backend-file,id=mem0,size=%s"
> @@ -751,12 +808,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          kvm_opts = ",dirty-ring-size=4096";
>      }
>  
> -    if (!qtest_has_machine(machine_alias)) {
> -        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
> -        g_test_skip(msg);
> -        return -1;
> -    }
> -
>      machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
>                                        QEMU_ENV_DST);
>  
> @@ -807,7 +858,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>       * Remove shmem file immediately to avoid memory leak in test failed case.
>       * It's valid because QEMU has already opened this file
>       */
> -    if (args->use_memfile) {
> +    if (args->use_memfile || args->use_shm_memfile) {
>          unlink(memfile_path);
>      }
>  
> @@ -1275,6 +1326,15 @@ static void test_postcopy(void)
>      test_postcopy_common(&args);
>  }
>  
> +static void test_postcopy_memfile(void)
> +{

IMHO the defined(__NR_userfaultfd) should be here to guard if needed.

Or rather, we don't need to care about uffd yet? As what we already do with
test_postcopy().

I'm guessing the test just doesn't run on !linux, while compilation always
works with/without that.

Thanks,

> +    MigrateCommon args = {
> +        .start.use_shm_memfile = true,
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
>  static void test_postcopy_suspend(void)
>  {
>      MigrateCommon args = {
> @@ -3441,6 +3501,7 @@ int main(int argc, char **argv)
>  
>      if (has_uffd) {
>          migration_test_add("/migration/postcopy/plain", test_postcopy);
> +        migration_test_add("/migration/postcopy/memfile", test_postcopy_memfile);
>          migration_test_add("/migration/postcopy/recovery/plain",
>                             test_postcopy_recovery);
>          migration_test_add("/migration/postcopy/preempt/plain",
> -- 
> 2.43.0
> 

-- 
Peter Xu


