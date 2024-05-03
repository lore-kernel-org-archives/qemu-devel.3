Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5623FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 16:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2w4Z-00033m-76; Fri, 03 May 2024 12:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2w4X-00033G-JK
 for qemu-devel@nongnu.org; Fri, 03 May 2024 12:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2w4V-0000Go-PL
 for qemu-devel@nongnu.org; Fri, 03 May 2024 12:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714754862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8ocLndKNrtu4onlcXVBlN95FxwVyB1sS5qCzhdPgjMA=;
 b=QLRlmYodXf/5EPBkNIxHL5i5FKhLp2yJY8SisKjVuELS0oxS4RP941BekTmWc4Q0R/FBx2
 IbBoSgg/DfhG9qcXiGuOnAa4y3xbhVap53F8PFxbvOfr/uFX8A0s4z9G9fc4HkcTy6HK91
 vx6o2J+WBmWRQTx8V/tnj8Vr8RHBgng=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-41m5sL2HMEuRBQlxqkW0Bw-1; Fri, 03 May 2024 12:47:40 -0400
X-MC-Unique: 41m5sL2HMEuRBQlxqkW0Bw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6a0eff9efc1so5729216d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 09:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714754860; x=1715359660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ocLndKNrtu4onlcXVBlN95FxwVyB1sS5qCzhdPgjMA=;
 b=ZgAFfiyIAlsuZH9ZrzNlDFef6YlkUr014TMXbB6xAYL7dxvcLV9tiuk2VJDeLrtUzH
 /ZdjMXdG/xtoETy9rkDMiI8M3+MsEwYhcEhQQu8MkfwtNobqA+8jP8cmTq3K/E+prjJh
 NAPBdiqS5aNcupRS6zDI7INiptg8VS0ujxOv7Ta+K6tQ/GoRx99AS9L6d65wO1XUDEqX
 WRez+Fpv89P0dRj1rGRhFyUsNcPd0qJgRBKj0GvcKg9lK0vlsYzk+hbcv9VuDrMf0fVW
 /yojmpGEPyu6fjAPOPkyW0gaTHiW4t56rCKd92PH3U8lvKkpfZeOfOHDkGC92Ks7UemV
 CwJA==
X-Gm-Message-State: AOJu0Yxgmc9dg+yYPbce65EW6svBxE+eQnmDHkXhga96FsMSaWj1wS0u
 0ABqIFkpMsCZBB3qJTVS2nn63j5eqf1aSu2PWx/vRbd32ajFeKrs8slXvdgWT/6ShVI4NWVy+WW
 t7QZ82Nei4Wx4RKn35kiFlaJwEM0AoAA3Fyo1tjOgiWdcIO6AREqh
X-Received: by 2002:a05:6214:501d:b0:696:b235:f39 with SMTP id
 jo29-20020a056214501d00b00696b2350f39mr3181027qvb.6.1714754860052; 
 Fri, 03 May 2024 09:47:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6pFxAZJaahTiPUks25IfqTAPFcl/MmwI2Sa82sOgY5RnaAtjeoi1WpmvzoCbI5UFfbUsD7Q==
X-Received: by 2002:a05:6214:501d:b0:696:b235:f39 with SMTP id
 jo29-20020a056214501d00b00696b2350f39mr3180996qvb.6.1714754859385; 
 Fri, 03 May 2024 09:47:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 n9-20020ad444a9000000b006a0fe3cdc2csm1345989qvt.81.2024.05.03.09.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 09:47:38 -0700 (PDT)
Date: Fri, 3 May 2024 12:47:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/9] tests/qtest/migration: Fix file migration offset check
Message-ID: <ZjUVKEJq7LBU57Rf@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426142042.14573-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 26, 2024 at 11:20:36AM -0300, Fabiano Rosas wrote:
> When doing file migration, QEMU accepts an offset that should be
> skipped when writing the migration stream to the file. The purpose of
> the offset is to allow the management layer to put its own metadata at
> the start of the file.
> 
> We have tests for this in migration-test, but only testing that the
> migration stream starts at the correct offset and not that it actually
> leaves the data intact. Unsurprisingly, there's been a bug in that
> area that the tests didn't catch.
> 
> Fix the tests to write some data to the offset region and check that
> it's actually there after the migration.
> 
> Fixes: 3dc35470c8 ("tests/qtest: migration-test: Add tests for file-based migration")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 70 +++++++++++++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 5d6d8cd634..7b177686b4 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2081,6 +2081,63 @@ static void test_precopy_file(void)
>      test_file_common(&args, true);
>  }
>  
> +#ifndef _WIN32
> +static void file_dirty_offset_region(void)
> +{
> +#if defined(__linux__)

Hmm, what's the case to cover when !_WIN32 && __linux__?  Can we remove one
layer of ifdef?

I'm also wondering why it can't work on win32?  I thought win32 has all
these stuff we used here, but I may miss something.

> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
> +    size_t size = FILE_TEST_OFFSET;
> +    uintptr_t *addr, *p;
> +    int fd;
> +
> +    fd = open(path, O_CREAT | O_RDWR, 0660);
> +    g_assert(fd != -1);
> +
> +    g_assert(!ftruncate(fd, size));
> +
> +    addr = mmap(NULL, size, PROT_WRITE, MAP_SHARED, fd, 0);
> +    g_assert(addr != MAP_FAILED);
> +
> +    /* ensure the skipped offset contains some data */
> +    p = addr;
> +    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
> +        *p = (unsigned long) FILE_TEST_FILENAME;

This is fine, but not as clear what is assigned..  I think here we assigned
is the pointer pointing to the binary's RO section (rather than the chars).
Maybe using some random numbers would be more straightforward, but no
strong opinions.

> +        p++;
> +    }
> +
> +    munmap(addr, size);
> +    fsync(fd);
> +    close(fd);
> +#endif
> +}
> +
> +static void *file_offset_start_hook(QTestState *from, QTestState *to)
> +{
> +    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
> +    int src_flags = O_WRONLY;
> +    int dst_flags = O_RDONLY;
> +    int fds[2];
> +
> +    file_dirty_offset_region();
> +
> +    fds[0] = open(file, src_flags, 0660);
> +    assert(fds[0] != -1);
> +
> +    fds[1] = open(file, dst_flags, 0660);
> +    assert(fds[1] != -1);
> +
> +    qtest_qmp_fds_assert_success(from, &fds[0], 1, "{'execute': 'add-fd', "
> +                                 "'arguments': {'fdset-id': 1}}");
> +
> +    qtest_qmp_fds_assert_success(to, &fds[1], 1, "{'execute': 'add-fd', "
> +                                 "'arguments': {'fdset-id': 1}}");
> +
> +    close(fds[0]);
> +    close(fds[1]);
> +
> +    return NULL;
> +}
> +
>  static void file_offset_finish_hook(QTestState *from, QTestState *to,
>                                      void *opaque)
>  {
> @@ -2096,12 +2153,12 @@ static void file_offset_finish_hook(QTestState *from, QTestState *to,
>      g_assert(addr != MAP_FAILED);
>  
>      /*
> -     * Ensure the skipped offset contains zeros and the migration
> -     * stream starts at the right place.
> +     * Ensure the skipped offset region's data has not been touched
> +     * and the migration stream starts at the right place.
>       */
>      p = addr;
>      while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
> -        g_assert(*p == 0);
> +        g_assert_cmpstr((char *) *p, ==, FILE_TEST_FILENAME);
>          p++;
>      }
>      g_assert_cmpint(cpu_to_be64(*p) >> 32, ==, QEMU_VM_FILE_MAGIC);
> @@ -2113,17 +2170,18 @@ static void file_offset_finish_hook(QTestState *from, QTestState *to,
>  
>  static void test_precopy_file_offset(void)
>  {
> -    g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=%d", tmpfs,
> -                                           FILE_TEST_FILENAME,
> +    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
>                                             FILE_TEST_OFFSET);

Do we want to keep both tests to cover both normal file and fdsets?

>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> +        .start_hook = file_offset_start_hook,
>          .finish_hook = file_offset_finish_hook,
>      };
>  
>      test_file_common(&args, false);
>  }
> +#endif
>  
>  static void test_precopy_file_offset_bad(void)
>  {
> @@ -3636,8 +3694,10 @@ int main(int argc, char **argv)
>  
>      migration_test_add("/migration/precopy/file",
>                         test_precopy_file);
> +#ifndef _WIN32
>      migration_test_add("/migration/precopy/file/offset",
>                         test_precopy_file_offset);
> +#endif
>      migration_test_add("/migration/precopy/file/offset/bad",
>                         test_precopy_file_offset_bad);
>  
> -- 
> 2.35.3
> 

-- 
Peter Xu


