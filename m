Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41948EB105A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyOh-0005i5-Q2; Tue, 10 Mar 2026 10:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vzyOc-0005fe-9Z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vzyOZ-00078S-IF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773154153;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hjj0hwvQflqa+v1qL88cEiLc7Q9UOQxWsllgVR4K6j8=;
 b=JycNnQS/bb64ZxCuJpzeid3xbxqDqV4g1AbUGZAKLJJtkRDzrdunX3KoSq9lY1kuHgj3Rk
 2jrWUU080ymUTjvd56V2PRpyJBEreIg11DetoTvoYXfT0cdjvIqeF/zwcvlcj4Swhe8atQ
 QjyPhuFf2x4MLcwIjO8x7+H239KhUxA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-v_fq7FjWNGy-TpbOuD2YyA-1; Tue, 10 Mar 2026 10:48:05 -0400
X-MC-Unique: v_fq7FjWNGy-TpbOuD2YyA-1
X-Mimecast-MFC-AGG-ID: v_fq7FjWNGy-TpbOuD2YyA_1773154084
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c7396634bb4so18038255a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773154084; x=1773758884; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjj0hwvQflqa+v1qL88cEiLc7Q9UOQxWsllgVR4K6j8=;
 b=QPq0YkewMN/fZ1uwTH0PYR7Lr2t2WvFnpoFsGx6c6MfwhZc6AVFNm26OLvoP1or55K
 p2r/IvDBhU1rKBPgyXh8cObrVsl/VCPZEHsc+xJ8Ud/djLk9J7j0l7w1CA89yxGE9c6K
 DQqhZbMwRqaq70NovUbM+RESoQ/5XUa959jSk1+xE6Lq0i8fZ0R+6/1AliZbTPQ3ZKuh
 MOYBZoPmAkxisCJGOGy47X8ZhxEu/8ViRQWdwqp07vmuNk3jR4EueCMyRLkSXO1xqd45
 /WHLsdrwPbNGRbtGFCCfvLpNxh6rvHIwXYfr3qOwhd6xtyLn400vhcjF40o+3yVxYFnS
 oKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773154084; x=1773758884;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hjj0hwvQflqa+v1qL88cEiLc7Q9UOQxWsllgVR4K6j8=;
 b=TDHcJFEDunX5mlfJ0i3qEtN91SXsLB3VEKjJlOD75eAe+ZnYUcbMGOaoZsUzsuFYtP
 VWuxfikUu3UtCcGTXjCv2wJ5TL0eqxLIDYso36t3BPaRNK3BTL9gbrtIbJ6qGuE/xgBu
 244XdEL3g2ztYq9bigb0y4yuNz+A35sbo3BCnkEHNF39Fq3085oFcxYC4PT8gHlpfi3k
 kLbP7spRASxAYYh8xj0AqBuKNDr0iKQwakFd5LYrhndhHxw8XJsBX043/7dhj1TxdfQr
 ZQLCgPGzuKjfXEWgSxYhBDLq+MS/a/UQ30zWtHKddI5kryh62+XfkH7BhFQ+JeZIb5Kg
 Bgdw==
X-Gm-Message-State: AOJu0YzsZbQf1HnH4b6BObawdyljZbm8U8X4Pb6YW9B6C1fZcG8Ko5Ja
 zJ8eTUWqVIKsWHtcboGxUO8WSbo/iYhI7g0yEO0/M4O7kMipoKQ7JsgTdH0YWRm0AchwD+L57uQ
 8xHPx/dloSzcGe+4TgTOD6R70gGg9xrn3MQNZXMGZCaV8rWWqpXD8v5Ze
X-Gm-Gg: ATEYQzyjt92KP9dL91kpHsDx0UspSsE0LToiTK5uYFgaN97Gq73Vtz4Cm9uSeoTmbpI
 2AEqNDfOYOnwt7TH7eFV4u7AinyLzNhnUOEsuEuRFeW+WXBN0JmkcSz1IzYXgNC4ZywcQvwzJyg
 Yrlt94jV8bxiIY213+1dVdyc0ixPeeOQsVPTgc17fXhEPIV+lHkMT0b7FoGSr18hyCiJBUvk4Wi
 pavm2aUeYvNJI7Gc8Z6u22StZ5BrLOKGwGQzP0K8DnuaocZIkSBkSszaZqJMfS4QH3b7ENQ1xw9
 r5bx5yJtUOYQsgUhMeOJ/FnwZQNDNue45Y5CQ+BC7OETKqR4TVVbU4HuSQz7AuSZXrhZLrKV1Ur
 R1UMBINu5MvjK
X-Received: by 2002:a05:6a21:7701:b0:398:92a5:b16f with SMTP id
 adf61e73a8af0-39892a5b9aemr7264941637.39.1773154084280; 
 Tue, 10 Mar 2026 07:48:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:7701:b0:398:92a5:b16f with SMTP id
 adf61e73a8af0-39892a5b9aemr7264918637.39.1773154083698; 
 Tue, 10 Mar 2026 07:48:03 -0700 (PDT)
Received: from fedora ([49.36.106.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c739e170ee4sm12787325a12.21.2026.03.10.07.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 07:48:02 -0700 (PDT)
Date: Tue, 10 Mar 2026 20:17:57 +0530
From: Arun Menon <armenon@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v11 13/21] migration-test: Add COLO migration unit test
Message-ID: <abAvHRJJewZOz-BW@fedora>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
 <20260302-colo_unit_test_multifd-v11-13-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-colo_unit_test_multifd-v11-13-d653fb3b1d80@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Lukas,

On Mon, Mar 02, 2026 at 12:45:28PM +0100, Lukas Straub wrote:
> Add a COLO migration test for COLO migration and failover.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Tested-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  MAINTAINERS                        |   1 +
>  tests/qtest/meson.build            |   7 +-
>  tests/qtest/migration-test.c       |   1 +
>  tests/qtest/migration/colo-tests.c | 198 +++++++++++++++++++++++++++++++++++++
>  tests/qtest/migration/framework.h  |   5 +
>  5 files changed, 211 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d2a1f4cc08223cb944b61e32a6d89e25bf82eacb..1b0ae10750036be00571b7104ad8426c071bb54c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3875,6 +3875,7 @@ F: migration/colo*
>  F: migration/multifd-colo.*
>  F: include/migration/colo.h
>  F: include/migration/failover.h
> +F: tests/qtest/migration/colo-tests.c
>  F: docs/COLO-FT.txt
>  
>  COLO Proxy
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 25fdbc798010b19e8ec9b6ab55e02d3fb5741398..6a46e2a767de12d978d910ddb6de175bce9810b8 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -374,6 +374,11 @@ if gnutls.found()
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
> @@ -385,7 +390,7 @@ qtests = {
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
> index 0000000000000000000000000000000000000000..598a1d3821ed0a90318732702027cebad47352fd
> --- /dev/null
> +++ b/tests/qtest/migration/colo-tests.c
> @@ -0,0 +1,198 @@
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
> +static int test_colo_common(MigrateCommon *args,
> +                            bool failover_during_checkpoint,
> +                            bool primary_failover)
> +{
> +    QTestState *from, *to;
> +    void *data_hook = NULL;
> +
> +    /*
> +     * For the COLO test, both VMs will run in parallel. Thus both VMs want to
> +     * open the image read/write at the same time. Using read-only=on is not
> +     * possible here, because ide-hd does not support read-only backing image.
> +     *
> +     * So use -snapshot, where each qemu instance creates its own writable
> +     * snapshot internally while leaving the real image read-only.
> +     */
> +    args->start.opts_source = "-snapshot";
> +    args->start.opts_target = "-snapshot";
> +
> +    /*
> +     * COLO migration code logs many errors when the migration socket
> +     * is shut down, these are expected so we hide them here.
> +     */
> +    args->start.hide_stderr = true;
> +
> +    /*
> +     * Test with yank with out of band capability since that is how it is
> +     * used in production.
> +     */
> +    args->start.oob = true;
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
> +    wait_for_resume(to, get_dst());
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
> +    if (failover_during_checkpoint) {
> +        qtest_qmp_eventwait(to, "STOP");
> +    }
> +    if (primary_failover) {
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
> +    migrate_end(from, to, !primary_failover);
> +
> +    return 0;
> +}
> +
> +static void test_colo_plain_common(MigrateCommon *args,
> +                                   bool failover_during_checkpoint,
> +                                   bool primary_failover)
> +{
> +    args->listen_uri = "tcp:127.0.0.1:0";
> +    test_colo_common(args, failover_during_checkpoint, primary_failover);
> +}
> +
> +static void *hook_start_multifd(QTestState *from, QTestState *to)
> +{
> +    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
> +}
> +
> +static void test_colo_multifd_common(MigrateCommon *args,
> +                                     bool failover_during_checkpoint,
> +                                     bool primary_failover)
> +{
> +    args->listen_uri = "defer";
> +    args->start_hook = hook_start_multifd;
> +    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> +    test_colo_common(args, failover_during_checkpoint, primary_failover);
> +}
> +
> +static void test_colo_plain_primary_failover(char *name, MigrateCommon *args)
> +{
> +    test_colo_plain_common(args, false, true);
> +}
> +
> +static void test_colo_plain_secondary_failover(char *name, MigrateCommon *args)
> +{
> +    test_colo_plain_common(args, false, false);
> +}
> +
> +static void test_colo_multifd_primary_failover(char *name, MigrateCommon *args)
> +{
> +    test_colo_multifd_common(args, false, true);
> +}
> +
> +static void test_colo_multifd_secondary_failover(char *name,
> +                                                 MigrateCommon *args)
> +{
> +    test_colo_multifd_common(args, false, false);
> +}
> +
> +static void test_colo_plain_primary_failover_checkpoint(char *name,
> +                                                        MigrateCommon *args)
> +{
> +    test_colo_plain_common(args, true, true);
> +}
> +
> +static void test_colo_plain_secondary_failover_checkpoint(char *name,
> +                                                          MigrateCommon *args)
> +{
> +    test_colo_plain_common(args, true, false);
> +}
> +
> +static void test_colo_multifd_primary_failover_checkpoint(char *name,
> +                                                          MigrateCommon *args)
> +{
> +    test_colo_multifd_common(args, true, true);
> +}
> +
> +static void test_colo_multifd_secondary_failover_checkpoint(char *name,
> +                                                            MigrateCommon *args)
> +{
> +    test_colo_multifd_common(args, true, false);
> +}
> +
> +void migration_test_add_colo(MigrationTestEnv *env)
> +{
> +    if (!env->full_set) {
> +        return;
> +    }
> +
> +    migration_test_add("/migration/colo/plain/primary_failover",
> +                       test_colo_plain_primary_failover);
> +    migration_test_add("/migration/colo/plain/secondary_failover",
> +                       test_colo_plain_secondary_failover);
> +
> +    migration_test_add("/migration/colo/multifd/primary_failover",
> +                       test_colo_multifd_primary_failover);
> +    migration_test_add("/migration/colo/multifd/secondary_failover",
> +                       test_colo_multifd_secondary_failover);
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
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 40984d04930da2d181326d9f6a742bde49018103..80eef758932ce9c301ed6c0f6383d18756144870 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -264,5 +264,10 @@ void migration_test_add_file(MigrationTestEnv *env);
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
>

I was running the qtests locally, and I encountered a timeout error.

Command run: mkdir -p build ; cd build ; make check-qtest-x86_64;

Following is the output:
======
67/67 qtest+qtest-x86_64 - qemu:qtest-x86_64/migration-test                 TIMEOUT        480.05s   killed by signal 15 SIGTERM
>>> QTEST_QEMU_IMG=./qemu-img LD_LIBRARY_PATH=/home/arun/workdir/new/devel/upstream/qemu-priv/build/subprojects/slirp RUST_BACKTRACE=1 QTEST_QEMU_BINARY=./qemu-system-x86_64 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 G_TEST_DBUS_DAEMON=/home/arun/workdir/new/devel/upstream/qemu-priv/tests/dbus-vmstate-daemon.sh ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 PYTHON=/home/arun/workdir/new/devel/upstream/qemu-priv/build/pyvenv/bin/python3 MESON_TEST_ITERATION=1 MALLOC_PERTURB_=53 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 /home/arun/workdir/new/devel/upstream/qemu-priv/build/tests/qtest/migration-test --tap -k --full
stderr:

TAP parsing error: Too few tests run (expected 52, got 47)

Summary of Failures:
67/67 qtest+qtest-x86_64 - qemu:qtest-x86_64/migration-test         TIMEOUT        480.05s   killed by signal 15 SIGTERM
Ok:                64
Fail:              0
Skipped:           2
Timeout:           1
======

It seems that the test runner is stuck waiting for some input.
Following is the stack trace
======
> ps afx
 127267 pts/0    S+     0:00  |       |   \_ make check-qtest-x86_64 -j8
 128245 pts/0    S+     0:01  |       |       \_ /home/arun/workdir/new/devel/upstream/qemu-priv/build/pyvenv/bin/python3 /home/arun/workdir
 128276 ?        Ssl    0:07  |       |           \_ /home/arun/workdir/new/devel/upstream/qemu-priv/build/tests/qtest/migration-test --tap
 134107 ?        Sl     0:20  |       |               \_ ./qemu-system-x86_64 -qtest unix:/tmp/qtest-128276.sock -qtest-log /dev/null -chard
 134115 ?        Sl     0:22  |       |               \_ ./qemu-system-x86_64 -qtest unix:/tmp/qtest-128276.sock -qtest-log /dev/null -chard
   5610 pts/2    Ss     0:01  |       \_ /usr/bin/bash

======
gstack 128276
Thread 2 (Thread 0x7fdd090716c0 (LWP 128279) "call_rcu"):
#0  0x00007fdd0921434d in syscall () from /lib64/libc.so.6
#1  0x0000557fd604563a in qemu_futex_wait (f=0x557fd60a0190 <rcu_call_ready_event>, val=4294967295) at /home/arun/workdir/new/devel/upstream/qemu-priv/include/qemu/futex.h:47
#2  0x0000557fd604584e in qemu_event_wait (ev=0x557fd60a0190 <rcu_call_ready_event>) at ../util/event.c:162
#3  0x0000557fd6045fde in call_rcu_thread (opaque=0x0) at ../util/rcu.c:304
#4  0x0000557fd600e8fb in qemu_thread_start (args=0x557fd6beec70) at ../util/qemu-thread-posix.c:414
#5  0x00007fdd09193464 in start_thread () from /lib64/libc.so.6
#6  0x00007fdd092165ac in __clone3 () from /lib64/libc.so.6

Thread 1 (Thread 0x7fdd09073240 (LWP 128276) "migration-test"):
#0  0x00007fdd0919b982 in __syscall_cancel_arch () from /lib64/libc.so.6
#1  0x00007fdd0918fc3c in __internal_syscall_cancel () from /lib64/libc.so.6
#2  0x00007fdd091dfb62 in clock_nanosleep@GLIBC_2.2.5 () from /lib64/libc.so.6
#3  0x00007fdd091ebb37 in nanosleep () from /lib64/libc.so.6
#4  0x00007fdd0921613a in usleep () from /lib64/libc.so.6
#5  0x0000557fd5fd99cd in wait_for_serial (side=0x557fd6065f08 "dest_serial") at ../tests/qtest/migration/framework.c:82
#6  0x0000557fd5fe5865 in test_colo_common (args=0x557fd6bfdf50, failover_during_checkpoint=false, primary_failover=true) at ../tests/qtest/migration/colo-tests.c:66
#7  0x0000557fd5fe5a0f in test_colo_plain_common (args=0x557fd6bfdf50, failover_during_checkpoint=false, primary_failover=true) at ../tests/qtest/migration/colo-tests.c:106
#8  0x0000557fd5fe5ad7 in test_colo_plain_primary_failover (name=0x557fd6bfd050 "/migration/colo/plain/primary_failover", args=0x557fd6bfdf50) at ../tests/qtest/migration/colo-tests.c:126
#9  0x0000557fd5fdeff8 in migration_test_wrapper (data=0x557fd6bfd320) at ../tests/qtest/migration/migration-util.c:258
#10 0x00007fdd0947bf3e in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
#11 0x00007fdd0947beb3 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
#12 0x00007fdd0947beb3 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
#13 0x00007fdd0947beb3 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
#14 0x00007fdd0947beb3 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
#15 0x00007fdd0947c46a in g_test_run_suite () from /lib64/libglib-2.0.so.0
#16 0x00007fdd0947c500 in g_test_run () from /lib64/libglib-2.0.so.0
#17 0x0000557fd5fd9490 in main (argc=1, argv=0x7fff33b51908) at ../tests/qtest/migration-test.c:60


Is there something that I am missing? Can you please look into this? 


Regards,
Arun Menon


