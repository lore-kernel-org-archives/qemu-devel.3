Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FB0C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 13:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBwzL-0006Aa-DP; Tue, 28 May 2024 09:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBwzG-00066y-C6
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBwzC-0001M8-Kk
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716903328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XHTwl1j72NAkzvkKkeEcIS/ZNwyXsb66H1nUXqHI/CM=;
 b=c4lZUyj23wNWtP4LNvJBodfFlSTVzEXOsVYeZNHEBTQ5PW86zzAvVWJ+VyVlfKazkmx1Ld
 pW8v9F9fkC+8AudvJsheSPJmO3uMfilxGdgJtEZK5RGbvSpx+ucWNN6iMW8x7FJeyYA0Cl
 MB8mnKmSK0DdF8YG1/iKsxQsbN6TpxE=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-9jDzqfoSNjOZv7gLfbYR6g-1; Tue, 28 May 2024 09:35:27 -0400
X-MC-Unique: 9jDzqfoSNjOZv7gLfbYR6g-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3d06610c256so102668b6e.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 06:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716903326; x=1717508126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHTwl1j72NAkzvkKkeEcIS/ZNwyXsb66H1nUXqHI/CM=;
 b=Z6xJ6J38fdBw6+nOituRUQQPOXi/0dVKiV508Ywwe0sTh4cIqryV0sX1IIJPjIsfVa
 9oJefqC+rJaao4wQ5KFmdoLW7NIdsv7CU5+EBQYvDJo4WV91ZeotvhRqvB5mPi1hpw8v
 VTM/jfksC3/jB//HynKhUwb8V1CZMzA+/ZVv1lcqMiQn/C4Hz6lsGRtiiY3+AFlTvo/i
 40xxai2NYzU23qUoHRFamTIPlvetu+PFovhULihypIZcPU1j096WpShFlNDMEWQS/v97
 xcoWbhSGQBGEoFANKWzXQ4EyYabvOu/jXpB/Z6/SbSHKRzV7wltRe4NO9gO10En0dpH2
 VtSA==
X-Gm-Message-State: AOJu0YxVIDmZLC+AvquyOgi2iOPbULVJ9SC9ljXXqgiBdrc+fVKZlMVo
 sRIrYkQ1IvUIWgxUsI0tsZyAYUukfjzvtegNJo8IRqqpqRpI+QzEPDUd76PIi9HbTPpLi28WY9F
 p4jQAUpa6UNMAkwfp1uRaLoU/i1jcnWv5Wnjt4rihQiK8ewQm9cQz
X-Received: by 2002:a05:6808:180a:b0:3c8:54ca:511d with SMTP id
 5614622812f47-3d1a538e5d0mr14420993b6e.1.1716903325558; 
 Tue, 28 May 2024 06:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeVTTEMvqS06xTpPcR7x2mhbOTVUPvhdp54YcYQTggvrQAjMwtKdj/C5g3EYv92kOltEZ14g==
X-Received: by 2002:a05:6808:180a:b0:3c8:54ca:511d with SMTP id
 5614622812f47-3d1a538e5d0mr14420941b6e.1.1716903324916; 
 Tue, 28 May 2024 06:35:24 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18c1268sm42768891cf.87.2024.05.28.06.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 06:35:24 -0700 (PDT)
Date: Tue, 28 May 2024 09:35:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH] tests/qtest/migrate-test: Use regular file file for
 shared-memory tests
Message-ID: <ZlXdmi7PqKJdv3fP@x1n>
References: <20240528042758.621589-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240528042758.621589-1-npiggin@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 28, 2024 at 02:27:57PM +1000, Nicholas Piggin wrote:
> There is no need to use /dev/shm for file-backed memory devices, and
> it is too small to be usable in gitlab CI. Switch to using a regular
> file in /tmp/ which will usually have more space available.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Am I missing something? AFAIKS there is not even any point using
> /dev/shm aka tmpfs anyway, there is not much special about it as a
> filesystem. This applies on top of the series just sent, and passes
> gitlab CI qtests including aarch64.

I think it's just that /dev/shm guarantees shmem usage, while the var
"tmpfs" implies g_dir_make_tmp() which may be another non-ram based file
system, while that'll be slightly different comparing to what a real user
would use - we don't suggest user to put guest RAM on things like btrfs.

One real implication is if we add a postcopy test it'll fail with
g_dir_make_tmp() when it is not pointing to a shmem mount, as
UFFDIO_REGISTER will fail there.  But that test doesn't yet exist as the
QEMU paths should be the same even if Linux will trigger different paths
when different types of mem is used (anonymous v.s. shmem).

If the goal here is to properly handle the case where tmpfs doesn't have
enough space, how about what I suggested in the other email?

https://lore.kernel.org/r/ZlSppKDE6wzjCF--@x1n

IOW, try populate the shmem region before starting the guest, skip if
population failed.  Would that work?

Thanks,

> 
> Thanks,
> Nick
> 
>  tests/qtest/migration-test.c | 41 ++++++++++++------------------------
>  1 file changed, 13 insertions(+), 28 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 45830eb213..86eace354e 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -552,7 +552,7 @@ typedef struct {
>       * unconditionally, because it means the user would like to be verbose.
>       */
>      bool hide_stderr;
> -    bool use_shmem;
> +    bool use_memfile;
>      /* only launch the target process */
>      bool only_target;
>      /* Use dirty ring if true; dirty logging otherwise */
> @@ -672,29 +672,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      g_autofree gchar *cmd_source = NULL;
>      g_autofree gchar *cmd_target = NULL;
>      const gchar *ignore_stderr;
> -    g_autofree char *shmem_opts = NULL;
> -    g_autofree char *shmem_path = NULL;
> +    g_autofree char *memfile_opts = NULL;
> +    g_autofree char *memfile_path = NULL;
>      const char *kvm_opts = NULL;
>      const char *arch = qtest_get_arch();
>      const char *memory_size;
>      const char *machine_alias, *machine_opts = "";
>      g_autofree char *machine = NULL;
>  
> -    if (args->use_shmem) {
> -        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> -            g_test_skip("/dev/shm is not supported");
> -            return -1;
> -        }
> -        if (getenv("GITLAB_CI")) {
> -            /*
> -             * Gitlab runners are limited to 64MB shm size. See:
> -             * https://lore.kernel.org/all/87ttq5fvh7.fsf@suse.de/
> -             */
> -            g_test_skip("/dev/shm is not supported in Gitlab CI environment");
> -            return -1;
> -        }
> -    }
> -
>      dst_state = (QTestMigrationState) { };
>      src_state = (QTestMigrationState) { };
>      bootfile_create(tmpfs, args->suspend_me);
> @@ -754,12 +739,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          ignore_stderr = "";
>      }
>  
> -    if (args->use_shmem) {
> -        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
> -        shmem_opts = g_strdup_printf(
> +    if (args->use_memfile) {
> +        memfile_path = g_strdup_printf("/%s/qemu-%d", tmpfs, getpid());
> +        memfile_opts = g_strdup_printf(
>              "-object memory-backend-file,id=mem0,size=%s"
>              ",mem-path=%s,share=on -numa node,memdev=mem0",
> -            memory_size, shmem_path);
> +            memory_size, memfile_path);
>      }
>  
>      if (args->use_dirty_ring) {
> @@ -788,7 +773,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   memory_size, tmpfs,
>                                   arch_opts ? arch_opts : "",
>                                   arch_source ? arch_source : "",
> -                                 shmem_opts ? shmem_opts : "",
> +                                 memfile_opts ? memfile_opts : "",
>                                   args->opts_source ? args->opts_source : "",
>                                   ignore_stderr);
>      if (!args->only_target) {
> @@ -810,7 +795,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   memory_size, tmpfs, uri,
>                                   arch_opts ? arch_opts : "",
>                                   arch_target ? arch_target : "",
> -                                 shmem_opts ? shmem_opts : "",
> +                                 memfile_opts ? memfile_opts : "",
>                                   args->opts_target ? args->opts_target : "",
>                                   ignore_stderr);
>      *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
> @@ -822,8 +807,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>       * Remove shmem file immediately to avoid memory leak in test failed case.
>       * It's valid because QEMU has already opened this file
>       */
> -    if (args->use_shmem) {
> -        unlink(shmem_path);
> +    if (args->use_memfile) {
> +        unlink(memfile_path);
>      }
>  
>      return 0;
> @@ -1875,7 +1860,7 @@ static void test_ignore_shared(void)
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
>      MigrateStart args = {
> -        .use_shmem = true,
> +        .use_memfile = true,
>      };
>  
>      if (test_migrate_start(&from, &to, uri, &args)) {
> @@ -2033,7 +2018,7 @@ static void test_mode_reboot(void)
>      g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
>                                             FILE_TEST_FILENAME);
>      MigrateCommon args = {
> -        .start.use_shmem = true,
> +        .start.use_memfile = true,
>          .connect_uri = uri,
>          .listen_uri = "defer",
>          .start_hook = test_mode_reboot_start
> -- 
> 2.43.0
> 

-- 
Peter Xu


