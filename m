Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6D6C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 21:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s309E-0000mu-Ue; Fri, 03 May 2024 17:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s309B-0000ly-AH
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s3099-0003dK-F9
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714770526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIAghM6vcD0wv2ZSbxeh2JSuDWi+gIXoS5r8+1PTAc8=;
 b=L2f0CvvPRKUMnX4Ao9WOQPi7/48P68yCP5qvVvjBKSpr+lbbE8SNrX490XNc/HdBa0WyRZ
 cZ+uzHicJ27EcEs0xu2Ip6ayKH3kLoFQ9TpYTig9vfsFfjpusN2Ays1Z9wBvrXzbyuH84C
 txSnJjh9pNwLApwcwLfKWPD6lKKhsH0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-OwQtt-PDOXGrnTkVlxSXWw-1; Fri, 03 May 2024 17:08:45 -0400
X-MC-Unique: OwQtt-PDOXGrnTkVlxSXWw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1ec7cb6942cso210465ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 14:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714770524; x=1715375324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MIAghM6vcD0wv2ZSbxeh2JSuDWi+gIXoS5r8+1PTAc8=;
 b=l3QTH6/vq2SPNuxmGwiSJNR3kBL5F8TTsYAfeUulvb3JZONlWLMqBsiEdQ5Q/3+SvE
 uHcqHmDkAbS1u5Pe5B8cPWVrGTEtS2VKgtqmH8mKXuDaPQYoteYbqwMkcjLTPaXbSdlk
 KhYElQu7FKUeaFdpzx45pZYvalYR2eSlEWCKqzLhInKaoYdw6uHW2OBNiYLFm8xnInzg
 gsS+ZflaguZIdZxbxQDntAsXP32f+5uYc+n/A5gCug+Qt5iHzs8xl4peExYZsBfUxNap
 JGMogVGZZzBiCwpGCDGRT3Tt6svBsLYcv0mXdeocZdkxAOTkxMh+4PQRTM8J6IkNMVIc
 t/fA==
X-Gm-Message-State: AOJu0YxRp87Lo6K4LAnHJBX9FTSge4GYIxWW52emvwlPW5gURuhZDHpS
 n0UkFbo1YsbQipoKXHSm0JLhjL3f3DdcaWlpu2vLMXpOGZyUs0wkYnGlGc1yEWFsihgQmTxW3OU
 rnl7SAGlBFybpYpCVLgareSIi+tc8fs44oRH8CtYkfJV0c4UWhKNS
X-Received: by 2002:a05:6a20:5530:b0:1af:66a6:d37d with SMTP id
 ko48-20020a056a20553000b001af66a6d37dmr3689380pzb.1.1714770523980; 
 Fri, 03 May 2024 14:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZvDgbGCfvlx+hBvmm/2pkzeg3NQgZAN2jE2r7655SZAQREXGbxgfiUxGRmrEMvFefqcfb2w==
X-Received: by 2002:a05:6a20:5530:b0:1af:66a6:d37d with SMTP id
 ko48-20020a056a20553000b001af66a6d37dmr3689361pzb.1.1714770523230; 
 Fri, 03 May 2024 14:08:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 e14-20020a62ee0e000000b006e724ccdc3esm3498257pfi.55.2024.05.03.14.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 14:08:42 -0700 (PDT)
Date: Fri, 3 May 2024 17:08:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/9] tests/qtest/migration: Fix file migration offset check
Message-ID: <ZjVSV5Xy6yQSMaSr@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-4-farosas@suse.de> <ZjUVKEJq7LBU57Rf@x1n>
 <874jbeocno.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874jbeocno.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On Fri, May 03, 2024 at 05:36:59PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Apr 26, 2024 at 11:20:36AM -0300, Fabiano Rosas wrote:
> >> When doing file migration, QEMU accepts an offset that should be
> >> skipped when writing the migration stream to the file. The purpose of
> >> the offset is to allow the management layer to put its own metadata at
> >> the start of the file.
> >> 
> >> We have tests for this in migration-test, but only testing that the
> >> migration stream starts at the correct offset and not that it actually
> >> leaves the data intact. Unsurprisingly, there's been a bug in that
> >> area that the tests didn't catch.
> >> 
> >> Fix the tests to write some data to the offset region and check that
> >> it's actually there after the migration.
> >> 
> >> Fixes: 3dc35470c8 ("tests/qtest: migration-test: Add tests for file-based migration")
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  tests/qtest/migration-test.c | 70 +++++++++++++++++++++++++++++++++---
> >>  1 file changed, 65 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> >> index 5d6d8cd634..7b177686b4 100644
> >> --- a/tests/qtest/migration-test.c
> >> +++ b/tests/qtest/migration-test.c
> >> @@ -2081,6 +2081,63 @@ static void test_precopy_file(void)
> >>      test_file_common(&args, true);
> >>  }
> >>  
> >> +#ifndef _WIN32
> >> +static void file_dirty_offset_region(void)
> >> +{
> >> +#if defined(__linux__)
> >
> > Hmm, what's the case to cover when !_WIN32 && __linux__?  Can we remove one
> > layer of ifdef?
> >
> > I'm also wondering why it can't work on win32?  I thought win32 has all
> > these stuff we used here, but I may miss something.
> >
> 
> __linux__ is because of mmap, !_WIN32 is because of the passing of
> fds. We might be able to keep !_WIN32 only, I'll check.

Thanks, or simply use __linux__; we don't lose that much if test less on
very special hosts.  Just feel a bit over-engineer to use two ifdefs for
one such test.

> 
> >> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
> >> +    size_t size = FILE_TEST_OFFSET;
> >> +    uintptr_t *addr, *p;
> >> +    int fd;
> >> +
> >> +    fd = open(path, O_CREAT | O_RDWR, 0660);
> >> +    g_assert(fd != -1);
> >> +
> >> +    g_assert(!ftruncate(fd, size));
> >> +
> >> +    addr = mmap(NULL, size, PROT_WRITE, MAP_SHARED, fd, 0);
> >> +    g_assert(addr != MAP_FAILED);
> >> +
> >> +    /* ensure the skipped offset contains some data */
> >> +    p = addr;
> >> +    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
> >> +        *p = (unsigned long) FILE_TEST_FILENAME;
> >
> > This is fine, but not as clear what is assigned..  I think here we assigned
> > is the pointer pointing to the binary's RO section (rather than the chars).
> 
> Haha you're right, I was assigning the FILE_TEST_OFFSET previously and
> just switched to the FILENAME without thinking. I'll fix it up.

:)

> 
> > Maybe using some random numbers would be more straightforward, but no
> > strong opinions.
> >
> >> +        p++;
> >> +    }
> >> +
> >> +    munmap(addr, size);
> >> +    fsync(fd);
> >> +    close(fd);
> >> +#endif
> >> +}
> >> +
> >> +static void *file_offset_start_hook(QTestState *from, QTestState *to)
> >> +{
> >> +    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
> >> +    int src_flags = O_WRONLY;
> >> +    int dst_flags = O_RDONLY;
> >> +    int fds[2];
> >> +
> >> +    file_dirty_offset_region();
> >> +
> >> +    fds[0] = open(file, src_flags, 0660);
> >> +    assert(fds[0] != -1);
> >> +
> >> +    fds[1] = open(file, dst_flags, 0660);
> >> +    assert(fds[1] != -1);
> >> +
> >> +    qtest_qmp_fds_assert_success(from, &fds[0], 1, "{'execute': 'add-fd', "
> >> +                                 "'arguments': {'fdset-id': 1}}");
> >> +
> >> +    qtest_qmp_fds_assert_success(to, &fds[1], 1, "{'execute': 'add-fd', "
> >> +                                 "'arguments': {'fdset-id': 1}}");
> >> +
> >> +    close(fds[0]);
> >> +    close(fds[1]);
> >> +
> >> +    return NULL;
> >> +}
> >> +
> >>  static void file_offset_finish_hook(QTestState *from, QTestState *to,
> >>                                      void *opaque)
> >>  {
> >> @@ -2096,12 +2153,12 @@ static void file_offset_finish_hook(QTestState *from, QTestState *to,
> >>      g_assert(addr != MAP_FAILED);
> >>  
> >>      /*
> >> -     * Ensure the skipped offset contains zeros and the migration
> >> -     * stream starts at the right place.
> >> +     * Ensure the skipped offset region's data has not been touched
> >> +     * and the migration stream starts at the right place.
> >>       */
> >>      p = addr;
> >>      while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
> >> -        g_assert(*p == 0);
> >> +        g_assert_cmpstr((char *) *p, ==, FILE_TEST_FILENAME);
> >>          p++;
> >>      }
> >>      g_assert_cmpint(cpu_to_be64(*p) >> 32, ==, QEMU_VM_FILE_MAGIC);
> >> @@ -2113,17 +2170,18 @@ static void file_offset_finish_hook(QTestState *from, QTestState *to,
> >>  
> >>  static void test_precopy_file_offset(void)
> >>  {
> >> -    g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=%d", tmpfs,
> >> -                                           FILE_TEST_FILENAME,
> >> +    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
> >>                                             FILE_TEST_OFFSET);
> >
> > Do we want to keep both tests to cover both normal file and fdsets?
> >
> 
> I think the fdset + offset is the most complex in terms of requirements,
> so I don't think we need to test the other one.

They will still cover different qemu code paths, right?  Even if only
slightly different.

> 
> I'm actually already a bit concerned about the amount of tests we
> have. I was even thinking of starting playing with some code coverage
> tools and prune some of the tests if possible.

IMHO we don't need to drop any test, but if / when we find it runs too
slow, we either:

  - try to speed it up - I never tried, but I _feel_ like I can make it
    faster in some way, just like when Dan used to do with reducing
    migration-test runtimes, perhaps from different angles, or

  - mark more tests optional to run by default, then we use getenv() to
    select those.

Said that, what you're exploring sounds interesting irrelevant.

> 
> >>      MigrateCommon args = {
> >>          .connect_uri = uri,
> >>          .listen_uri = "defer",
> >> +        .start_hook = file_offset_start_hook,
> >>          .finish_hook = file_offset_finish_hook,
> >>      };
> >>  
> >>      test_file_common(&args, false);
> >>  }
> >> +#endif
> >>  
> >>  static void test_precopy_file_offset_bad(void)
> >>  {
> >> @@ -3636,8 +3694,10 @@ int main(int argc, char **argv)
> >>  
> >>      migration_test_add("/migration/precopy/file",
> >>                         test_precopy_file);
> >> +#ifndef _WIN32
> >>      migration_test_add("/migration/precopy/file/offset",
> >>                         test_precopy_file_offset);
> >> +#endif
> >>      migration_test_add("/migration/precopy/file/offset/bad",
> >>                         test_precopy_file_offset_bad);
> >>  
> >> -- 
> >> 2.35.3
> >> 
> 

-- 
Peter Xu


