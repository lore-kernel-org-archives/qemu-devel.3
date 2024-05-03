Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D8AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 18:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2xno-0001Oo-FH; Fri, 03 May 2024 14:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2xnm-0001OW-J1
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2xni-0004co-2l
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714761508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbZ6WvD8etaFKnnMaqSBt4yScQoq8an2RbBWZacXSSM=;
 b=X9mvfrUw6gH45SCVx744ORC9JMgRX6g18TtAtxSpRgnktWQbp++eKt32NFDeqkqPbnx4tC
 QtGoZbc/7Szu9JNrYB7G+gNrHJfoXzGecJS9IHodyFneYSS1wFOG+7bQJ6B8PN8vfk5qEA
 HYyinrm5JEPePUYETn8XZXVWmV2yAQo=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-2HS7tXQBM7OQH81szgV1lA-1; Fri, 03 May 2024 14:38:26 -0400
X-MC-Unique: 2HS7tXQBM7OQH81szgV1lA-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5aa35f3393bso941eaf.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 11:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714761506; x=1715366306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbZ6WvD8etaFKnnMaqSBt4yScQoq8an2RbBWZacXSSM=;
 b=avL7KtYEuilffa4gWY+gTY1Qi1fD7GwRw6G03ONKl2GpQ/CrgQUV9gWNKSAX1brgtC
 SKsFLGueHU9VfmgsrzrRphtHvqC6jxOpGg4D97khqU4uD6RDawzukdwCkQzyL5CsXeaZ
 XGVoBhP4sVf/KtA7gpyeW+7dU6sWvYR3zLfHF3a/QN9qjjx2/KEDhkBX8bRsFADwRbZq
 rg6akb7T3IChIxElnHxGLIT5OIfkeMpWdT4/oG70LAPKMoReCNbC0y00aL6q8m3m0on/
 /0UIseEf32W0sN6axgy9f/ZfCNZ+0eIAtez2hH7ml/8pcZ1vLRRZeWItKwh+An24q8tB
 OM+Q==
X-Gm-Message-State: AOJu0Yy/c5c+fxRGCJ5v3lctgO7huyeS6C0ab8bp03BRYlulJSfuNJe6
 EonuyOm0dVMtSmHHQq4vAezK7v+WXfhQ9PXcgiNwEtHv64WL+AUUWzdzN724BFjczDWmLkd0xxk
 IqNsG/11KsWzikgRHrYLp8/L8RC+c+WvQKvc4DwS1dQ1FkH0JqzjG
X-Received: by 2002:a05:6820:b8d:b0:5aa:14ff:4128 with SMTP id
 eg13-20020a0568200b8d00b005aa14ff4128mr3760245oob.1.1714761505612; 
 Fri, 03 May 2024 11:38:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1AjqrOJ+IB10gFXDG6KnLZiWpDy/s7Z8aFbnM1lqHFSpehH6qMxnwqksnPlJ+nXQfgLS86A==
X-Received: by 2002:a05:6820:b8d:b0:5aa:14ff:4128 with SMTP id
 eg13-20020a0568200b8d00b005aa14ff4128mr3760174oob.1.1714761504097; 
 Fri, 03 May 2024 11:38:24 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 fy5-20020a05622a5a0500b00437a6e5b3fdsm1819656qtb.66.2024.05.03.11.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 11:38:23 -0700 (PDT)
Date: Fri, 3 May 2024 14:38:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/9] tests/qtest/migration: Add tests for file migration
 with direct-io
Message-ID: <ZjUvHjBOicENBbva@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426142042.14573-7-farosas@suse.de>
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

On Fri, Apr 26, 2024 at 11:20:39AM -0300, Fabiano Rosas wrote:
> The tests are only allowed to run in systems that know about the
> O_DIRECT flag and in filesystems which support it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Mostly:

Reviewed-by: Peter Xu <peterx@redhat.com>

Two trivial comments below.

> ---
>  tests/qtest/migration-helpers.c | 42 +++++++++++++++++++++++++++++++++
>  tests/qtest/migration-helpers.h |  1 +
>  tests/qtest/migration-test.c    | 42 +++++++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index ce6d6615b5..356cd4fa8c 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -473,3 +473,45 @@ void migration_test_add(const char *path, void (*fn)(void))
>      qtest_add_data_func_full(path, test, migration_test_wrapper,
>                               migration_test_destroy);
>  }
> +
> +#ifdef O_DIRECT
> +/*
> + * Probe for O_DIRECT support on the filesystem. Since this is used
> + * for tests, be conservative, if anything fails, assume it's
> + * unsupported.
> + */
> +bool probe_o_direct_support(const char *tmpfs)
> +{
> +    g_autofree char *filename = g_strdup_printf("%s/probe-o-direct", tmpfs);
> +    int fd, flags = O_CREAT | O_RDWR | O_TRUNC | O_DIRECT;
> +    void *buf;
> +    ssize_t ret, len;
> +    uint64_t offset;
> +
> +    fd = open(filename, flags, 0660);
> +    if (fd < 0) {
> +        unlink(filename);
> +        return false;
> +    }
> +
> +    /*
> +     * Assuming 4k should be enough to satisfy O_DIRECT alignment
> +     * requirements. The migration code uses 1M to be conservative.
> +     */
> +    len = 0x100000;
> +    offset = 0x100000;
> +
> +    buf = aligned_alloc(len, len);

This is the first usage of aligned_alloc() in qemu.  IIUC it's just a newer
posix_memalign(), which QEMU has one use of, and it's protected with:

#if defined(CONFIG_POSIX_MEMALIGN)
    int ret;
    ret = posix_memalign(&ptr, alignment, size);
    ...
#endif

Didn't check deeper.  Just keep this in mind if you see any compilation
issues in future CIs, or simply switch to similar pattern.

> +    g_assert(buf);
> +
> +    ret = pwrite(fd, buf, len, offset);
> +    unlink(filename);
> +    g_free(buf);
> +
> +    if (ret < 0) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +#endif
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 1339835698..d827e16145 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -54,5 +54,6 @@ char *find_common_machine_version(const char *mtype, const char *var1,
>                                    const char *var2);
>  char *resolve_machine_version(const char *alias, const char *var1,
>                                const char *var2);
> +bool probe_o_direct_support(const char *tmpfs);
>  void migration_test_add(const char *path, void (*fn)(void));
>  #endif /* MIGRATION_HELPERS_H */
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 7b177686b4..512b7ede8b 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2295,6 +2295,43 @@ static void test_multifd_file_mapped_ram(void)
>      test_file_common(&args, true);
>  }
>  
> +#ifdef O_DIRECT
> +static void *migrate_mapped_ram_dio_start(QTestState *from,
> +                                                 QTestState *to)
> +{
> +    migrate_mapped_ram_start(from, to);

This line seems redundant, migrate_multifd_mapped_ram_start() should cover that.

> +    migrate_set_parameter_bool(from, "direct-io", true);
> +    migrate_set_parameter_bool(to, "direct-io", true);
> +
> +    return NULL;
> +}
> +
> +static void *migrate_multifd_mapped_ram_dio_start(QTestState *from,
> +                                                 QTestState *to)
> +{
> +    migrate_multifd_mapped_ram_start(from, to);
> +    return migrate_mapped_ram_dio_start(from, to);
> +}
> +
> +static void test_multifd_file_mapped_ram_dio(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> +                                           FILE_TEST_FILENAME);
> +    MigrateCommon args = {
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +        .start_hook = migrate_multifd_mapped_ram_dio_start,
> +    };
> +
> +    if (!probe_o_direct_support(tmpfs)) {
> +        g_test_skip("Filesystem does not support O_DIRECT");
> +        return;
> +    }
> +
> +    test_file_common(&args, true);
> +}
> +
> +#endif /* O_DIRECT */
>  
>  static void test_precopy_tcp_plain(void)
>  {
> @@ -3719,6 +3756,11 @@ int main(int argc, char **argv)
>      migration_test_add("/migration/multifd/file/mapped-ram/live",
>                         test_multifd_file_mapped_ram_live);
>  
> +#ifdef O_DIRECT
> +    migration_test_add("/migration/multifd/file/mapped-ram/dio",
> +                       test_multifd_file_mapped_ram_dio);
> +#endif
> +
>  #ifdef CONFIG_GNUTLS
>      migration_test_add("/migration/precopy/unix/tls/psk",
>                         test_precopy_unix_tls_psk);
> -- 
> 2.35.3
> 

-- 
Peter Xu


