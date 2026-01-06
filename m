Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8593CCEFD01
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 20:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdDH4-0007Op-PV; Tue, 06 Jan 2026 15:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdDH3-0007Ml-FS
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:03:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdDH0-00082L-Pt
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767729801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Tr3Itbay5CNkSJrflt3NWi/9kjWFQPrmrTW87LXHfY=;
 b=Z2/fWn3MLuQZ4pUTxxiHIfgPvNUxXo7JXm/xrjhWej9PRkjtsO/Pd49pio4TK/vaaDkoo5
 A+ZcWojomqOkyvrQnlnwaAy0hS4WumR5e3MYCSgyPf6fOQxprjKpdGFa6ymH/k+dke9Jco
 Utk1kywCngARmBabUT6zW0K3Umllz6o=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-OLg8lCMIOcO19NxksL8CpQ-1; Tue, 06 Jan 2026 15:03:19 -0500
X-MC-Unique: OLg8lCMIOcO19NxksL8CpQ-1
X-Mimecast-MFC-AGG-ID: OLg8lCMIOcO19NxksL8CpQ_1767729799
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ae29a21e7eso118179eec.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 12:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767729798; x=1768334598; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2Tr3Itbay5CNkSJrflt3NWi/9kjWFQPrmrTW87LXHfY=;
 b=MOxIX3hULnoS/RmNclU8j3mg3JmiqIdGSTJD7wTcqUYqQnyBf/Mk55rYJQpkxuVBi5
 7v2yseYQGMhEFXUbQaFHQbDghGtQyvZfpou2bsfOvu2QxmlPUqtnaSJGf2e4Ka7FdgBx
 tltJHXdXA8LqUtk5qY5ZSus2G0U9nkZ9xPOSVS0LjDUJtmgzHhX8QwVdU66Rp/Y3MfLH
 WSmhsCQZEFHr3dHr/YW77wCG+rSBCfpyF/JGpLrkdWjEjCj857T+qiAEpRJDwqQ1nqZH
 Mt9XLYDmmgq9ZyqBizeqWOxHcbq2A2rxhNBZx4jTbgYdKYIXDzwaNOVTZdU8oDVfvizg
 9kuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767729798; x=1768334598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Tr3Itbay5CNkSJrflt3NWi/9kjWFQPrmrTW87LXHfY=;
 b=mB9cMyiEg53Gaguzob0BsBhxr8EAi2uQaXbwvBZqvpxNkq2padXU0Bt0nX4Mw/MxTi
 L40tzyhpoX+FmpUKmW/STd7VVXqq6rASXA4OW2tjzsmrKk+SWK+MFzHzuay/RCrHXvUe
 zENByIJzjlRM8H+OuTDYa2V3U5r5IXuYJYIHHP2wo7M0D5fBuVusEI93GdWiez5ZEytC
 rrQB/v/CUvLiLNfnvKK0hnV0D1rtpDGxSI6Zx5YDE/CNf6922eAdQW3W2R2zdkzSHMil
 FC5Nt9PuQybXcdUrejH0KjGXbgvLW9G0tQkZGj2c8pGt1LAlCJ5+4OMU4kxlzUCccstv
 GwkA==
X-Gm-Message-State: AOJu0YwKQTwVOJ0uIcZvMyDxUtzTgMlMoHtuvqEWX0JcluOestLhX6eM
 vhX8i3aoQXCKfHL4VkWlqo8dBxNV/ybWZM+7xd6+vPcVywa5unBKN4JBWPswUCBChamyfnZZcWT
 AQZqKwtWif5Au5uponsRcYBGgRe7B+H4RX/uAq/pxmrqjkiitnLxHiJ3C
X-Gm-Gg: AY/fxX4nnlAMNmpgf0VhhRC8w9wAQtZUiTzomYjYAtjA3KkKYvUzn7rjIuZPrb4lFWF
 b3pBIGPifqLJjdPbwXQyT1VdBWYQD4vZMmB+B568YCnbI4dOv9oW2gQL4eMTJ+mGn+DoEndtHKC
 GEEGHfzvgkWXgH3bMfdMDunZuU+HJJNst2821DqDfRLmjOrMPimV8tYg1sqv4CXh20uc/5EHqKt
 z0maEDLYQf/7NfA/Wt6ok/VYz20EVbCjE0H0fTNhGb0uOJf2bqS/iT3iO4Rg8UKVQzBjgwoZk3r
 qNJAJcK1fwwGqVICnZF+fbCdv63XgzvSAX4Y90BsD52iRXNEnCaIm8sb+DecEQ+VtblDd6n2E+m
 gtJ8=
X-Received: by 2002:a05:7301:2989:b0:2a4:3593:cca7 with SMTP id
 5a478bee46e88-2b16fd7c7e9mr2310926eec.4.1767729797908; 
 Tue, 06 Jan 2026 12:03:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoX3O1pkDK1aaklzduHqfKlIMkpyTf5nMwGSC/aonNHKn9Pe59VGnEcy5ZUd0vsrdQRrr2/w==
X-Received: by 2002:a05:7301:2989:b0:2a4:3593:cca7 with SMTP id
 5a478bee46e88-2b16fd7c7e9mr2310910eec.4.1767729797326; 
 Tue, 06 Jan 2026 12:03:17 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b1707b16e4sm4805756eec.26.2026.01.06.12.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 12:03:16 -0800 (PST)
Date: Tue, 6 Jan 2026 15:03:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Subject: Re: [PATCH 3/3] migration-test: Add COLO migration unit test
Message-ID: <aV1qf5uDYYiGrqR_@x1.local>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
 <20251230-colo_unit_test_multifd-v1-3-f9734bc74c71@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251230-colo_unit_test_multifd-v1-3-f9734bc74c71@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Dec 30, 2025 at 03:05:46PM +0100, Lukas Straub wrote:
> Add a COLO migration test for COLO migration and failover.
> 
> COLO does not support q35 machine at this time.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  tests/qtest/meson.build            |   7 ++-
>  tests/qtest/migration-test.c       |   1 +
>  tests/qtest/migration/colo-tests.c | 115 +++++++++++++++++++++++++++++++++++++
>  tests/qtest/migration/framework.c  |  65 ++++++++++++++++++++-
>  tests/qtest/migration/framework.h  |   9 +++
>  5 files changed, 195 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 08fba9695b9813dc0b6b6554ef8c40c9615918fa..e68ce6c193ce2a2c244fa072ebb24738380f844a 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -366,6 +366,11 @@ if gnutls.found()
>    endif
>  endif
>  
> +migration_colo_files = []
> +if get_option('replication').allowed()
> +  migration_colo_files = [files('migration/colo-tests.c')]
> +endif
> +
>  qtests = {
>    'aspeed_hace-test': files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),
>    'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
> @@ -377,7 +382,7 @@ qtests = {
>                               'migration/migration-util.c') + dbus_vmstate1,
>    'erst-test': files('erst-test.c'),
>    'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
> -  'migration-test': test_migration_files + migration_tls_files,
> +  'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
>    'pxe-test': files('boot-sector.c'),
>    'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
>                            'pnv-xive2-nvpg_bar.c'),
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 08936871741535c926eeac40a7d7c3f461c72fd0..e582f05c7dc2673dbd05a936df8feb6c964b5bbc 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -55,6 +55,7 @@ int main(int argc, char **argv)
>      migration_test_add_precopy(env);
>      migration_test_add_cpr(env);
>      migration_test_add_misc(env);
> +    migration_test_add_colo(env);
>  
>      ret = g_test_run();
>  
> diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/colo-tests.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..adec41c1c0473539d02e488b1d0baa663d7743b1
> --- /dev/null
> +++ b/tests/qtest/migration/colo-tests.c
> @@ -0,0 +1,115 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QTest testcases for COLO migration
> + *
> + * Copyright (c) 2025 Lukas Straub <lukasstraub2@web.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "migration/framework.h"
> +#include "migration/migration-qmp.h"
> +#include "migration/migration-util.h"
> +#include "qemu/module.h"
> +
> +static void test_colo_plain_primary_failover(char *name, MigrateCommon *args)
> +{
> +    args->listen_uri = "tcp:127.0.0.1:0";
> +    args->colo_primary_failover = true;
> +
> +    test_colo_common(args);
> +}
> +
> +static void test_colo_plain_secondary_failover(char *name, MigrateCommon *args)
> +{
> +    args->listen_uri = "tcp:127.0.0.1:0";
> +
> +    test_colo_common(args);
> +}
> +
> +static void *hook_start_multifd(QTestState *from, QTestState *to)
> +{
> +    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
> +}
> +
> +static void test_colo_multifd_primary_failover(char *name, MigrateCommon *args)
> +{
> +    args->listen_uri = "defer";
> +    args->start_hook = hook_start_multifd;
> +    args->colo_primary_failover = true;
> +    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> +
> +    test_colo_common(args);
> +}
> +
> +static void test_colo_multifd_secondary_failover(char *name,
> +                                                 MigrateCommon *args)
> +{
> +    args->listen_uri = "defer";
> +    args->start_hook = hook_start_multifd;
> +    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> +
> +    test_colo_common(args);
> +}
> +
> +static void test_colo_plain_primary_failover_checkpoint(char *name,
> +                                                        MigrateCommon *args)
> +{
> +    args->colo_failover_during_checkpoint = true;
> +    test_colo_plain_primary_failover(name, args);
> +}
> +
> +static void test_colo_plain_secondary_failover_checkpoint(char *name,
> +                                                          MigrateCommon *args)
> +{
> +    args->colo_failover_during_checkpoint = true;
> +    test_colo_plain_secondary_failover(name, args);
> +}
> +
> +static void test_colo_multifd_primary_failover_checkpoint(char *name,
> +                                                          MigrateCommon *args)
> +{
> +    args->colo_failover_during_checkpoint = true;
> +    test_colo_multifd_primary_failover(name, args);
> +}
> +
> +static void test_colo_multifd_secondary_failover_checkpoint(char *name,
> +                                                            MigrateCommon *args)
> +{
> +    args->colo_failover_during_checkpoint = true;
> +    test_colo_multifd_secondary_failover(name, args);
> +}
> +
> +void migration_test_add_colo(MigrationTestEnv *env)
> +{
> +    migration_test_add("/migration/colo/plain/secondary_failover",
> +                       test_colo_plain_secondary_failover);
> +
> +    migration_test_add("/migration/colo/multifd/secondary_failover",
> +                       test_colo_multifd_secondary_failover);
> +
> +    if (!env->full_set) {
> +        return;
> +    }

IMHO we can skip all COLO tests in full_set.  Don't worry, if it's merged
at least Fabiano and myself will always run it, making sure migration
patches will be smoked.

Here it's about whether we will run it in everyone's CI.

> +
> +    migration_test_add("/migration/colo/plain/primary_failover",
> +                       test_colo_plain_primary_failover);
> +
> +    migration_test_add("/migration/colo/multifd/primary_failover",
> +                       test_colo_multifd_primary_failover);
> +
> +    migration_test_add("/migration/colo/plain/primary_failover_checkpoint",
> +                       test_colo_plain_primary_failover_checkpoint);
> +    migration_test_add("/migration/colo/plain/secondary_failover_checkpoint",
> +                       test_colo_plain_secondary_failover_checkpoint);
> +
> +    migration_test_add("/migration/colo/multifd/primary_failover_checkpoint",
> +                       test_colo_multifd_primary_failover_checkpoint);
> +    migration_test_add("/migration/colo/multifd/secondary_failover_checkpoint",
> +                       test_colo_multifd_secondary_failover_checkpoint);
> +}
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 8c1fc6e009f16dc05a47e917167f62e0250ca992..08bca49a8980f9988be9447acf54b17acd56da94 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -315,7 +315,7 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          memory_size = "150M";
>  
> -        if (g_str_equal(arch, "i386")) {
> +        if (g_str_equal(arch, "i386") || args->is_colo) {

OK, one more reference..

I'm curious, why Q35 is not supported?

>              machine_alias = "pc";
>          } else {
>              machine_alias = "q35";
> @@ -1068,6 +1068,69 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
>      return NULL;
>  }
>  
> +int test_colo_common(MigrateCommon *args)
> +{
> +    QTestState *from, *to;
> +    void *data_hook = NULL;
> +
> +    args->start.oob = true;
> +    args->start.is_colo = true;
> +    args->start.caps[MIGRATION_CAPABILITY_X_COLO] = true;
> +
> +    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
> +        return -1;
> +    }
> +
> +    migrate_set_parameter_int(from, "x-checkpoint-delay", 300);
> +
> +    if (args->start_hook) {
> +        data_hook = args->start_hook(from, to);
> +    }
> +
> +    migrate_ensure_converge(from);
> +    wait_for_serial("src_serial");
> +
> +    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
> +
> +    wait_for_migration_status(from, "colo", NULL);
> +    wait_for_resume(to, &dst_state);
> +
> +    wait_for_serial("src_serial");
> +    wait_for_serial("dest_serial");
> +
> +    /* wait for 3 checkpoints */
> +    for (int i = 0; i < 3; i++) {
> +        qtest_qmp_eventwait(to, "RESUME");
> +        wait_for_serial("src_serial");
> +        wait_for_serial("dest_serial");
> +    }
> +
> +    if (args->colo_failover_during_checkpoint) {
> +        qtest_qmp_eventwait(to, "STOP");
> +    }
> +    if (args->colo_primary_failover) {
> +        qtest_qmp_assert_success(from, "{'exec-oob': 'yank', 'id': 'yank-cmd', "
> +                                            "'arguments': {'instances':"
> +                                                "[{'type': 'migration'}]}}");
> +        qtest_qmp_assert_success(from, "{'execute': 'x-colo-lost-heartbeat'}");
> +        wait_for_serial("src_serial");
> +    } else {
> +        qtest_qmp_assert_success(to, "{'exec-oob': 'yank', 'id': 'yank-cmd', "
> +                                        "'arguments': {'instances':"
> +                                            "[{'type': 'migration'}]}}");
> +        qtest_qmp_assert_success(to, "{'execute': 'x-colo-lost-heartbeat'}");
> +        wait_for_serial("dest_serial");
> +    }
> +
> +    if (args->end_hook) {
> +        args->end_hook(from, to, data_hook);
> +    }
> +
> +    migrate_end(from, to, !args->colo_primary_failover);
> +
> +    return 0;
> +}
> +
>  QTestMigrationState *get_src(void)
>  {
>      return &src_state;
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 2ea13e7758697550b5531737e66d6d939dd800d1..1da532569d8c5941c99d83ae7da88ccab2bdcbe2 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -230,6 +230,9 @@ typedef struct {
>       */
>      bool live;
>  
> +    bool colo_primary_failover;
> +    bool colo_failover_during_checkpoint;

Let's try to not add more per-feature fields here into the test framework
struct.  My bad to have started doing this for postcopy tests..  I'll
prepare patches to remove the postcopy ones.  These parameters can be
passed from the test callers, afaict.

Thanks,

> +
>      /* Postcopy specific fields */
>      void *postcopy_data;
>      PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
> @@ -248,6 +251,7 @@ void test_postcopy_common(MigrateCommon *args);
>  void test_postcopy_recovery_common(MigrateCommon *args);
>  int test_precopy_common(MigrateCommon *args);
>  void test_file_common(MigrateCommon *args, bool stop_src);
> +int test_colo_common(MigrateCommon *args);
>  void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
>                                                      QTestState *to,
>                                                      const char *method);
> @@ -267,5 +271,10 @@ void migration_test_add_file(MigrationTestEnv *env);
>  void migration_test_add_precopy(MigrationTestEnv *env);
>  void migration_test_add_cpr(MigrationTestEnv *env);
>  void migration_test_add_misc(MigrationTestEnv *env);
> +#ifdef CONFIG_REPLICATION
> +void migration_test_add_colo(MigrationTestEnv *env);
> +#else
> +static inline void migration_test_add_colo(MigrationTestEnv *env) {};
> +#endif
>  
>  #endif /* TEST_FRAMEWORK_H */
> 
> -- 
> 2.39.5
> 

-- 
Peter Xu


