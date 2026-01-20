Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F80CA5FB9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viFS3-0000qM-4X; Tue, 20 Jan 2026 12:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFS1-0000ou-83
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:23:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFRy-00036d-D5
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768929805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h/P80vud/+G4QI24gmwh40KwjX6ZYFw+KHteMlbFOV8=;
 b=AdTF/GwjXAtYr+cLf7UoyrlKWZsmn9ySWoZpjgcxu+ba1Gf5IJMxQbZBbqM4UBOBh8dGBv
 LOpVtXgaPTsJwhaNIQ4KfHoJS1zP50VrTANltPmO0jgijBUTxqD0bkidktUgseKlrx3euD
 m1HqD4YA0CpuNXT3Juz+4YSDg+w6tWw=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-fMLo7sr1PxS2s_PjaSUe7w-1; Tue, 20 Jan 2026 12:23:23 -0500
X-MC-Unique: fMLo7sr1PxS2s_PjaSUe7w-1
X-Mimecast-MFC-AGG-ID: fMLo7sr1PxS2s_PjaSUe7w_1768929802
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ac39bd5501so5023292eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 09:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768929802; x=1769534602; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h/P80vud/+G4QI24gmwh40KwjX6ZYFw+KHteMlbFOV8=;
 b=DudactZ9rHgf4rq37h5qBy5duGWuONmXem99EIEakRjmfFjaqpGwstCs/VASKNDlvq
 JKpg9S0lXn20MS+vyEiJcwV1P6M4DLZc21TWgxKKG6eKrFbYc3eE4YRHgkPO18ZWHtbN
 j5H+dm8HVkPhaKGcbX4VZj6sVAKvmLcT7NBVY8CwRc3D1hxwQmVvpXQRfuZw2lk07ZNh
 BmbyZ1EDYmHn7vOQeWPxuRD0KCsDYBdNKTKFhhc5V/bTrZCh7FKzkRVo9qWjb0qkUBNH
 MQNSDPUN9FyT9rNL/riCRsfAIDEOUPoRV8B3O3yM7zBFmjpKVNcXBnGxRaKG39WyKF6+
 VDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768929802; x=1769534602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/P80vud/+G4QI24gmwh40KwjX6ZYFw+KHteMlbFOV8=;
 b=Dnae538AVf5NxQLTt8ncH9MFZ/qhqqJijGGrqVz2YGQlqaOvxOfWdvLSYyFEfpOubt
 pkWjlvZqyWiivsPhy9iL05BNdFty8XSFATDn6T/iPrF7RtgxsCZkeuM4Th2GYxrT1JgK
 GrtdMKn1UQ3AjmHG6yiA52SiSC1/KArYLPRg2J75mJ/JsyZJe64XdVOAKD8k3/fTXUbk
 qNvS8nhJ7PgXQ8dbTOWZ2k+wA9kpeRCtfGmVT1aDac8NK9J6cy2hFwwKLdwsr13ZXSpq
 AnowIqB3H3OQNwyl+fVMhZ8sks10jkfbYUnhfxBYXOWG1UDj+QoaEwi32oNfMm18PZST
 lHTw==
X-Gm-Message-State: AOJu0Yww4BHpo9DXeCv3uO0K1BqtzAw5bk0/hn3rLEASnOIj51ksSAW+
 SW5FI/UkCeWDAbuRhEDagwyOrYMTOqSyig4j+1vWddOm1H0k3CzGwEbvT6Emy/Mc3h3WEXDcDhY
 mJtMYHDWoEIOE0m0uKXSiVbnB9IfjdKe5LEUFfzKiTPdV+wJineU3yx92
X-Gm-Gg: AZuq6aJ9j/oS/pN1s9ewv5iui8affoH/LR/hrDQPkyxciX4/2K8yyeE5OqDWYHEm5bX
 EAHLNRWf5KUi4XYRViVLDP4SRS9uycqeZ83JRjVwn+09GzbI9OkOeOkx7LzaynrDqbIfMpDBCLt
 8/di+DME3sze8wsyou4WIf8zjNPwIo3TXs011c7Re3JeeVsAnrnU5ejL1xT4b5IZ7CfZWXLgvjW
 c612SIK6vdlWD7HvxrjY4sfo8hLtV3gMR6UqupYO3bZktAEegXQcrsCx1RmacuK9eFqm52h/rVe
 OtqEP24rje6UPlPSTIbNiJOrmQGmL78w1usR/UQRSMP6aHWeJMumf3RBp+nOQ5/B/nA7ruUlaYD
 M93o=
X-Received: by 2002:a05:7300:572a:b0:2ae:566b:1213 with SMTP id
 5a478bee46e88-2b6fd78e006mr1484879eec.28.1768929800737; 
 Tue, 20 Jan 2026 09:23:20 -0800 (PST)
X-Received: by 2002:a05:7300:572a:b0:2ae:566b:1213 with SMTP id
 5a478bee46e88-2b6fd78e006mr1484799eec.28.1768929798622; 
 Tue, 20 Jan 2026 09:23:18 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b70d4324f5sm437712eec.8.2026.01.20.09.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 09:23:15 -0800 (PST)
Date: Tue, 20 Jan 2026 12:23:08 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 5/8] migration-test: Add COLO migration unit test
Message-ID: <aW-5_BtdDDLw3ZJH@x1.local>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-5-ab521777fa51@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260117-colo_unit_test_multifd-v2-5-ab521777fa51@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Jan 17, 2026 at 03:09:12PM +0100, Lukas Straub wrote:
> Add a COLO migration test for COLO migration and failover.
> 
> COLO does not support q35 machine at this time.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  MAINTAINERS                        |   1 +
>  tests/qtest/meson.build            |   7 ++-
>  tests/qtest/migration-test.c       |   1 +
>  tests/qtest/migration/colo-tests.c | 113 +++++++++++++++++++++++++++++++++++++
>  tests/qtest/migration/framework.c  |  87 +++++++++++++++++++++++++++-
>  tests/qtest/migration/framework.h  |  10 ++++
>  6 files changed, 217 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dbb217255c2cf35dc0ce971c2021b130fac5469b..92ca20c9d4186a08519d15bfe8cbd583ab061a8b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3840,6 +3840,7 @@ F: migration/colo*
>  F: migration/multifd-colo.*
>  F: include/migration/colo.h
>  F: include/migration/failover.h
> +F: tests/qtest/migration/colo-tests.c
>  F: docs/COLO-FT.txt
>  
>  COLO Proxy
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 0f053fb56de5806d3c213e3a26c0b19998ae151a..d0129af4431bb08a94a918a1e40a8f657059d764 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -367,6 +367,11 @@ if gnutls.found()
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
> @@ -378,7 +383,7 @@ qtests = {
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
> index 0000000000000000000000000000000000000000..5004f581e4d9e4e6f54eee6d70a9307b7fd123be
> --- /dev/null
> +++ b/tests/qtest/migration/colo-tests.c
> @@ -0,0 +1,113 @@
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
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 57d3b9b7c5a269d31659971e308367bd916d28f6..fe34e7cc7a1a4eeb8d5219f54733bbd8446b0e4e 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -315,7 +315,7 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          memory_size = "150M";
>  
> -        if (g_str_equal(arch, "i386")) {
> +        if (g_str_equal(arch, "i386") || args->force_pc_machine) {

The naming is better, thanks.  Said that, force_pc_machine is unwanted
either.. if we can drop it.  I asked this in v1:

https://lore.kernel.org/qemu-devel/aWltRH6Nra-Tji7w@x1.local/

Can we explore that possibility?

>              machine_alias = "pc";
>          } else {
>              machine_alias = "q35";
> @@ -1066,6 +1066,91 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
>      return NULL;
>  }
>  
> +int test_colo_common(MigrateCommon *args, bool failover_during_checkpoint,
> +                     bool primary_failover)
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
> +     * COLO currently does not work with Q35 machine
> +     */
> +    args->start.force_pc_machine = true;
> +
> +    args->start.oob = true;

Just curious: is OOB required in COLO for some reason?  I understand yank
you used below uses OOB, so the question is behind that, on what can be
blocked in main thread, and special in COLO.

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

We can move this whole function into colo-tests.c.  Here you may want to
use get_dst() instead.

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
>  QTestMigrationState *get_src(void)
>  {
>      return &src_state;
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 2ef0f57962605c9e3bc7b7de48e52351e5389138..75088c5fb098a0f95acb1e23585d3b6e8307451e 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -139,6 +139,9 @@ typedef struct {
>      /* Do not connect to target monitor and qtest sockets in qtest_init */
>      bool defer_target_connect;
>  
> +    /* Use pc machine for x86_64 */
> +    bool force_pc_machine;
> +
>      /*
>       * Migration capabilities to be set in both source and
>       * destination. For unilateral capabilities, use
> @@ -248,6 +251,8 @@ void test_postcopy_common(MigrateCommon *args);
>  void test_postcopy_recovery_common(MigrateCommon *args);
>  int test_precopy_common(MigrateCommon *args);
>  void test_file_common(MigrateCommon *args, bool stop_src);
> +int test_colo_common(MigrateCommon *args, bool failover_during_checkpoint,
> +                     bool colo_primary_failover);
>  void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
>                                                      QTestState *to,
>                                                      const char *method);
> @@ -267,5 +272,10 @@ void migration_test_add_file(MigrationTestEnv *env);
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


