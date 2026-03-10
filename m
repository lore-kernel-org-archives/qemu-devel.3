Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD07FD4F0E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 17:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w016V-0007QU-G8; Tue, 10 Mar 2026 13:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w016R-0007Pw-PJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w016M-0001kt-Fb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773164556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QkJms+jkt1r2HLisz3Yg77iS2M4K5qJuw2urXR+TPTI=;
 b=JUnMKrKyLXyRmmWwndgvAKkkFj/n+r7ECTC4+hEYsXiBGGXzIQUkE8wlpBRcxVKNaYlYPE
 uFHqkcc3qvZw0vXRWHsKhmm/QWWHbTytXvHpWnyDLYmPyuqCfU6MJtwPdO0pplQHYxzsuw
 XzV+dwtNlufgLIj9yYCFrJNJUvFO+6k=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-EBkNIe1SM3i7fqYatGEjEQ-1; Tue, 10 Mar 2026 13:42:34 -0400
X-MC-Unique: EBkNIe1SM3i7fqYatGEjEQ-1
X-Mimecast-MFC-AGG-ID: EBkNIe1SM3i7fqYatGEjEQ_1773164553
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ae4a6bb316so98366325ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773164553; x=1773769353; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QkJms+jkt1r2HLisz3Yg77iS2M4K5qJuw2urXR+TPTI=;
 b=qWfrwfEuefHHUKFG5nqEZUfp0/z5RuaL6zg0Hhbx6A5eJd0RKkKFBkJNY/HwE9uJ5i
 2mUeTLRXDNi4r8+jAEvffGasrXuB9+EFjzp1ppgrjDSoiLs1k2lZ9mEjBhSyQGv/HKEB
 UlvdIg7ZB3KnUvDbmYQoHN4xBwXy/QgwFhVjmuXh5tZWyKFZc1F2rDSq/ElpEXApyDi2
 U4giPaegKHfCCaZ/kHkl0OY2LQMq6Kgc8ELpaKs3th3hhCH75QoljkC4Dtq8i4VP33Qu
 U5+CCbOelrfxt9hy2lzppHhTDzeGMF+gr947zGrlB6CfJvO/rMt2CxzWZx0WKLuGX81i
 Nigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773164553; x=1773769353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QkJms+jkt1r2HLisz3Yg77iS2M4K5qJuw2urXR+TPTI=;
 b=WzFRXCcsxXVlttmJ6P1Tv+9PSxQhAx9uO+zkc29n8uIXRbGMoeMtdOrt66wXzCJrp5
 zD90qwDGSvTU3JFMAgyF+y/R0Pw3/HWGexxys9nTvwjB845hqA2UwMzfthRGhzZwYeUm
 Rf4Ij4DqYNFmeVJryYV1yhyLbHZtWowj6WDihT2/GoCf62/6cRcelw5NVmDa4WVfJtnc
 nyMcQ7iC85WtjK/BEVIry0RLeRu8zY3JeGQ5ojPN8MILG8ytUd0EgY7xnWLyYVyD3Gnh
 xu01xrwE0psKlRqip3ZzqBaMeKOWWBkOC4dQoCL0CYf5SzkhLDTiux1UCJqSg7Qq96sp
 Zy3Q==
X-Gm-Message-State: AOJu0YyLTj1qyJ1ykyN411Vu/7rczUCheXHRo5MR9ia1x7pMvs3h6A4y
 4PMvg8e+11wt7ArApoGL2rD4LRgc17M3ghRgwU+RBpZI8VVNxV3KpSXVsyTRAPsoLNe/I+2t6hj
 2YrKh5QTV8Hf7xt2Z4mf/ikDNOfeyzOELNl/0wSNP6AYLITiYbiVuc+yi
X-Gm-Gg: ATEYQzxebVYoLvkuYtNPPx+9AQAgTdT27BF6UPOY0rkERkhMSomh2e91023fobaUFR/
 vmgDutQhpRAPexMG0mkP5PECb6a2Se3P41ICx4kwpTUHrZOG5vuJirE7npjP2iJVfuquUntfs8m
 bQvFVYpto+IaZ1PUbe96kBxVttra2bVjKeEGZF+ePPfsi+3c4ng6wwoooI8HERiYXKRuSNnd3UA
 QN4tUyy1VSmbuv8M+bxKy7OgecefKB+sp3qvutpiZiALhVeDIOciXSorVzR5JREFML9ulpy3rFJ
 +eoRAS0c9SS3qYpwZB7gWUUTFm2bW43uqla3Z7CrkaY+W9CNjr54StcOdey6c/wWMQo2dU0arQ7
 9NBEhM/8NYBOo
X-Received: by 2002:a17:902:f543:b0:2ae:66c7:db95 with SMTP id
 d9443c01a7336-2ae82443a23mr150763585ad.16.1773164553118; 
 Tue, 10 Mar 2026 10:42:33 -0700 (PDT)
X-Received: by 2002:a17:902:f543:b0:2ae:66c7:db95 with SMTP id
 d9443c01a7336-2ae82443a23mr150763405ad.16.1773164552457; 
 Tue, 10 Mar 2026 10:42:32 -0700 (PDT)
Received: from fedora ([49.36.106.210]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83e7c58asm166979735ad.25.2026.03.10.10.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 10:42:31 -0700 (PDT)
Date: Tue, 10 Mar 2026 23:12:25 +0530
From: Arun Menon <armenon@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v11 13/21] migration-test: Add COLO migration unit test
Message-ID: <abBYAVLFQ9YDIKpr@fedora>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
 <20260302-colo_unit_test_multifd-v11-13-d653fb3b1d80@web.de>
 <abAvHRJJewZOz-BW@fedora> <20260310162954.61da59f1@penguin>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wi2Xq99njKX6UUna"
Content-Disposition: inline
In-Reply-To: <20260310162954.61da59f1@penguin>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--wi2Xq99njKX6UUna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lukas,

On Tue, Mar 10, 2026 at 04:29:54PM +0100, Lukas Straub wrote:
> On Tue, 10 Mar 2026 20:17:57 +0530
> Arun Menon <armenon@redhat.com> wrote:
> 
> > Hi Lukas,
> > 
> > On Mon, Mar 02, 2026 at 12:45:28PM +0100, Lukas Straub wrote:
> > > Add a COLO migration test for COLO migration and failover.
> > > 
> > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > Tested-by: Fabiano Rosas <farosas@suse.de>
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > ---
> > >  MAINTAINERS                        |   1 +
> > >  tests/qtest/meson.build            |   7 +-
> > >  tests/qtest/migration-test.c       |   1 +
> > >  tests/qtest/migration/colo-tests.c | 198 +++++++++++++++++++++++++++++++++++++
> > >  tests/qtest/migration/framework.h  |   5 +
> > >  5 files changed, 211 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index d2a1f4cc08223cb944b61e32a6d89e25bf82eacb..1b0ae10750036be00571b7104ad8426c071bb54c 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3875,6 +3875,7 @@ F: migration/colo*
> > >  F: migration/multifd-colo.*
> > >  F: include/migration/colo.h
> > >  F: include/migration/failover.h
> > > +F: tests/qtest/migration/colo-tests.c
> > >  F: docs/COLO-FT.txt
> > >  
> > >  COLO Proxy
> > > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > > index 25fdbc798010b19e8ec9b6ab55e02d3fb5741398..6a46e2a767de12d978d910ddb6de175bce9810b8 100644
> > > --- a/tests/qtest/meson.build
> > > +++ b/tests/qtest/meson.build
> > > @@ -374,6 +374,11 @@ if gnutls.found()
> > >    endif
> > >  endif
> > >  
> > > +migration_colo_files = []
> > > +if get_option('replication').allowed()
> > > +  migration_colo_files = [files('migration/colo-tests.c')]
> > > +endif
> > > +
> > >  qtests = {
> > >    'aspeed_hace-test': files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),
> > >    'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
> > > @@ -385,7 +390,7 @@ qtests = {
> > >                               'migration/migration-util.c') + dbus_vmstate1,
> > >    'erst-test': files('erst-test.c'),
> > >    'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
> > > -  'migration-test': test_migration_files + migration_tls_files,
> > > +  'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
> > >    'pxe-test': files('boot-sector.c'),
> > >    'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
> > >                            'pnv-xive2-nvpg_bar.c'),
> > > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > > index 08936871741535c926eeac40a7d7c3f461c72fd0..e582f05c7dc2673dbd05a936df8feb6c964b5bbc 100644
> > > --- a/tests/qtest/migration-test.c
> > > +++ b/tests/qtest/migration-test.c
> > > @@ -55,6 +55,7 @@ int main(int argc, char **argv)
> > >      migration_test_add_precopy(env);
> > >      migration_test_add_cpr(env);
> > >      migration_test_add_misc(env);
> > > +    migration_test_add_colo(env);
> > >  
> > >      ret = g_test_run();
> > >  
> > > diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/colo-tests.c
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..598a1d3821ed0a90318732702027cebad47352fd
> > > --- /dev/null
> > > +++ b/tests/qtest/migration/colo-tests.c
> > > @@ -0,0 +1,198 @@
> > > +/*
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * QTest testcases for COLO migration
> > > + *
> > > + * Copyright (c) 2025 Lukas Straub <lukasstraub2@web.de>
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > > + * See the COPYING file in the top-level directory.
> > > + *
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "libqtest.h"
> > > +#include "migration/framework.h"
> > > +#include "migration/migration-qmp.h"
> > > +#include "migration/migration-util.h"
> > > +#include "qemu/module.h"
> > > +
> > > +static int test_colo_common(MigrateCommon *args,
> > > +                            bool failover_during_checkpoint,
> > > +                            bool primary_failover)
> > > +{
> > > +    QTestState *from, *to;
> > > +    void *data_hook = NULL;
> > > +
> > > +    /*
> > > +     * For the COLO test, both VMs will run in parallel. Thus both VMs want to
> > > +     * open the image read/write at the same time. Using read-only=on is not
> > > +     * possible here, because ide-hd does not support read-only backing image.
> > > +     *
> > > +     * So use -snapshot, where each qemu instance creates its own writable
> > > +     * snapshot internally while leaving the real image read-only.
> > > +     */
> > > +    args->start.opts_source = "-snapshot";
> > > +    args->start.opts_target = "-snapshot";
> > > +
> > > +    /*
> > > +     * COLO migration code logs many errors when the migration socket
> > > +     * is shut down, these are expected so we hide them here.
> > > +     */
> > > +    args->start.hide_stderr = true;
> > > +
> > > +    /*
> > > +     * Test with yank with out of band capability since that is how it is
> > > +     * used in production.
> > > +     */
> > > +    args->start.oob = true;
> > > +    args->start.caps[MIGRATION_CAPABILITY_X_COLO] = true;
> > > +
> > > +    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
> > > +        return -1;
> > > +    }
> > > +
> > > +    migrate_set_parameter_int(from, "x-checkpoint-delay", 300);
> > > +
> > > +    if (args->start_hook) {
> > > +        data_hook = args->start_hook(from, to);
> > > +    }
> > > +
> > > +    migrate_ensure_converge(from);
> > > +    wait_for_serial("src_serial");
> > > +
> > > +    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
> > > +
> > > +    wait_for_migration_status(from, "colo", NULL);
> > > +    wait_for_resume(to, get_dst());
> > > +
> > > +    wait_for_serial("src_serial");
> > > +    wait_for_serial("dest_serial");
> > > +
> > > +    /* wait for 3 checkpoints */
> > > +    for (int i = 0; i < 3; i++) {
> > > +        qtest_qmp_eventwait(to, "RESUME");
> > > +        wait_for_serial("src_serial");
> > > +        wait_for_serial("dest_serial");
> > > +    }
> > > +
> > > +    if (failover_during_checkpoint) {
> > > +        qtest_qmp_eventwait(to, "STOP");
> > > +    }
> > > +    if (primary_failover) {
> > > +        qtest_qmp_assert_success(from, "{'exec-oob': 'yank', 'id': 'yank-cmd', "
> > > +                                            "'arguments': {'instances':"
> > > +                                                "[{'type': 'migration'}]}}");
> > > +        qtest_qmp_assert_success(from, "{'execute': 'x-colo-lost-heartbeat'}");
> > > +        wait_for_serial("src_serial");
> > > +    } else {
> > > +        qtest_qmp_assert_success(to, "{'exec-oob': 'yank', 'id': 'yank-cmd', "
> > > +                                        "'arguments': {'instances':"
> > > +                                            "[{'type': 'migration'}]}}");
> > > +        qtest_qmp_assert_success(to, "{'execute': 'x-colo-lost-heartbeat'}");
> > > +        wait_for_serial("dest_serial");
> > > +    }
> > > +
> > > +    if (args->end_hook) {
> > > +        args->end_hook(from, to, data_hook);
> > > +    }
> > > +
> > > +    migrate_end(from, to, !primary_failover);
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static void test_colo_plain_common(MigrateCommon *args,
> > > +                                   bool failover_during_checkpoint,
> > > +                                   bool primary_failover)
> > > +{
> > > +    args->listen_uri = "tcp:127.0.0.1:0";
> > > +    test_colo_common(args, failover_during_checkpoint, primary_failover);
> > > +}
> > > +
> > > +static void *hook_start_multifd(QTestState *from, QTestState *to)
> > > +{
> > > +    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
> > > +}
> > > +
> > > +static void test_colo_multifd_common(MigrateCommon *args,
> > > +                                     bool failover_during_checkpoint,
> > > +                                     bool primary_failover)
> > > +{
> > > +    args->listen_uri = "defer";
> > > +    args->start_hook = hook_start_multifd;
> > > +    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> > > +    test_colo_common(args, failover_during_checkpoint, primary_failover);
> > > +}
> > > +
> > > +static void test_colo_plain_primary_failover(char *name, MigrateCommon *args)
> > > +{
> > > +    test_colo_plain_common(args, false, true);
> > > +}
> > > +
> > > +static void test_colo_plain_secondary_failover(char *name, MigrateCommon *args)
> > > +{
> > > +    test_colo_plain_common(args, false, false);
> > > +}
> > > +
> > > +static void test_colo_multifd_primary_failover(char *name, MigrateCommon *args)
> > > +{
> > > +    test_colo_multifd_common(args, false, true);
> > > +}
> > > +
> > > +static void test_colo_multifd_secondary_failover(char *name,
> > > +                                                 MigrateCommon *args)
> > > +{
> > > +    test_colo_multifd_common(args, false, false);
> > > +}
> > > +
> > > +static void test_colo_plain_primary_failover_checkpoint(char *name,
> > > +                                                        MigrateCommon *args)
> > > +{
> > > +    test_colo_plain_common(args, true, true);
> > > +}
> > > +
> > > +static void test_colo_plain_secondary_failover_checkpoint(char *name,
> > > +                                                          MigrateCommon *args)
> > > +{
> > > +    test_colo_plain_common(args, true, false);
> > > +}
> > > +
> > > +static void test_colo_multifd_primary_failover_checkpoint(char *name,
> > > +                                                          MigrateCommon *args)
> > > +{
> > > +    test_colo_multifd_common(args, true, true);
> > > +}
> > > +
> > > +static void test_colo_multifd_secondary_failover_checkpoint(char *name,
> > > +                                                            MigrateCommon *args)
> > > +{
> > > +    test_colo_multifd_common(args, true, false);
> > > +}
> > > +
> > > +void migration_test_add_colo(MigrationTestEnv *env)
> > > +{
> > > +    if (!env->full_set) {
> > > +        return;
> > > +    }
> > > +
> > > +    migration_test_add("/migration/colo/plain/primary_failover",
> > > +                       test_colo_plain_primary_failover);
> > > +    migration_test_add("/migration/colo/plain/secondary_failover",
> > > +                       test_colo_plain_secondary_failover);
> > > +
> > > +    migration_test_add("/migration/colo/multifd/primary_failover",
> > > +                       test_colo_multifd_primary_failover);
> > > +    migration_test_add("/migration/colo/multifd/secondary_failover",
> > > +                       test_colo_multifd_secondary_failover);
> > > +
> > > +    migration_test_add("/migration/colo/plain/primary_failover_checkpoint",
> > > +                       test_colo_plain_primary_failover_checkpoint);
> > > +    migration_test_add("/migration/colo/plain/secondary_failover_checkpoint",
> > > +                       test_colo_plain_secondary_failover_checkpoint);
> > > +
> > > +    migration_test_add("/migration/colo/multifd/primary_failover_checkpoint",
> > > +                       test_colo_multifd_primary_failover_checkpoint);
> > > +    migration_test_add("/migration/colo/multifd/secondary_failover_checkpoint",
> > > +                       test_colo_multifd_secondary_failover_checkpoint);
> > > +}
> > > diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> > > index 40984d04930da2d181326d9f6a742bde49018103..80eef758932ce9c301ed6c0f6383d18756144870 100644
> > > --- a/tests/qtest/migration/framework.h
> > > +++ b/tests/qtest/migration/framework.h
> > > @@ -264,5 +264,10 @@ void migration_test_add_file(MigrationTestEnv *env);
> > >  void migration_test_add_precopy(MigrationTestEnv *env);
> > >  void migration_test_add_cpr(MigrationTestEnv *env);
> > >  void migration_test_add_misc(MigrationTestEnv *env);
> > > +#ifdef CONFIG_REPLICATION
> > > +void migration_test_add_colo(MigrationTestEnv *env);
> > > +#else
> > > +static inline void migration_test_add_colo(MigrationTestEnv *env) {};
> > > +#endif
> > >  
> > >  #endif /* TEST_FRAMEWORK_H */
> > > 
> > > -- 
> > > 2.39.5
> > > 
> > >  
> > 
> > I was running the qtests locally, and I encountered a timeout error.
> > 
> > Command run: mkdir -p build ; cd build ; make check-qtest-x86_64;
> > 
> > Following is the output:
> > ======
> > 67/67 qtest+qtest-x86_64 - qemu:qtest-x86_64/migration-test                 TIMEOUT        480.05s   killed by signal 15 SIGTERM
> > >>> QTEST_QEMU_IMG=./qemu-img LD_LIBRARY_PATH=/home/arun/workdir/new/devel/upstream/qemu-priv/build/subprojects/slirp RUST_BACKTRACE=1 QTEST_QEMU_BINARY=./qemu-system-x86_64 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 G_TEST_DBUS_DAEMON=/home/arun/workdir/new/devel/upstream/qemu-priv/tests/dbus-vmstate-daemon.sh ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 PYTHON=/home/arun/workdir/new/devel/upstream/qemu-priv/build/pyvenv/bin/python3 MESON_TEST_ITERATION=1 MALLOC_PERTURB_=53 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 /home/arun/workdir/new/devel/upstream/qemu-priv/build/tests/qtest/migration-test --tap -k --full  
> > stderr:
> > 
> > TAP parsing error: Too few tests run (expected 52, got 47)
> > 
> > Summary of Failures:
> > 67/67 qtest+qtest-x86_64 - qemu:qtest-x86_64/migration-test         TIMEOUT        480.05s   killed by signal 15 SIGTERM
> > Ok:                64
> > Fail:              0
> > Skipped:           2
> > Timeout:           1
> > ======
> > 
> > It seems that the test runner is stuck waiting for some input.
> > Following is the stack trace
> > ======
> > > ps afx  
> >  127267 pts/0    S+     0:00  |       |   \_ make check-qtest-x86_64 -j8
> >  128245 pts/0    S+     0:01  |       |       \_ /home/arun/workdir/new/devel/upstream/qemu-priv/build/pyvenv/bin/python3 /home/arun/workdir
> >  128276 ?        Ssl    0:07  |       |           \_ /home/arun/workdir/new/devel/upstream/qemu-priv/build/tests/qtest/migration-test --tap
> >  134107 ?        Sl     0:20  |       |               \_ ./qemu-system-x86_64 -qtest unix:/tmp/qtest-128276.sock -qtest-log /dev/null -chard
> >  134115 ?        Sl     0:22  |       |               \_ ./qemu-system-x86_64 -qtest unix:/tmp/qtest-128276.sock -qtest-log /dev/null -chard
> >    5610 pts/2    Ss     0:01  |       \_ /usr/bin/bash
> > 
> > ======
> > gstack 128276
> > Thread 2 (Thread 0x7fdd090716c0 (LWP 128279) "call_rcu"):
> > #0  0x00007fdd0921434d in syscall () from /lib64/libc.so.6
> > #1  0x0000557fd604563a in qemu_futex_wait (f=0x557fd60a0190 <rcu_call_ready_event>, val=4294967295) at /home/arun/workdir/new/devel/upstream/qemu-priv/include/qemu/futex.h:47
> > #2  0x0000557fd604584e in qemu_event_wait (ev=0x557fd60a0190 <rcu_call_ready_event>) at ../util/event.c:162
> > #3  0x0000557fd6045fde in call_rcu_thread (opaque=0x0) at ../util/rcu.c:304
> > #4  0x0000557fd600e8fb in qemu_thread_start (args=0x557fd6beec70) at ../util/qemu-thread-posix.c:414
> > #5  0x00007fdd09193464 in start_thread () from /lib64/libc.so.6
> > #6  0x00007fdd092165ac in __clone3 () from /lib64/libc.so.6
> > 
> > Thread 1 (Thread 0x7fdd09073240 (LWP 128276) "migration-test"):
> > #0  0x00007fdd0919b982 in __syscall_cancel_arch () from /lib64/libc.so.6
> > #1  0x00007fdd0918fc3c in __internal_syscall_cancel () from /lib64/libc.so.6
> > #2  0x00007fdd091dfb62 in clock_nanosleep@GLIBC_2.2.5 () from /lib64/libc.so.6
> > #3  0x00007fdd091ebb37 in nanosleep () from /lib64/libc.so.6
> > #4  0x00007fdd0921613a in usleep () from /lib64/libc.so.6
> > #5  0x0000557fd5fd99cd in wait_for_serial (side=0x557fd6065f08 "dest_serial") at ../tests/qtest/migration/framework.c:82
> > #6  0x0000557fd5fe5865 in test_colo_common (args=0x557fd6bfdf50, failover_during_checkpoint=false, primary_failover=true) at ../tests/qtest/migration/colo-tests.c:66
> 
> 60    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
> 61
> 62    wait_for_migration_status(from, "colo", NULL);
> 63    wait_for_resume(to, get_dst());
> 64
> 65    wait_for_serial("src_serial");
> 66    wait_for_serial("dest_serial");
> 
> Interesting, so the secondary guest is stuck/crahsed after entering
> colo state despite having resumed.
> 
> It works fine here on master. And before the merge I have looped the
> colo tests for a whole day on my machine without any failures.
> 
> How often does this happen? What is the commit you are on, host, ASAN,
> MSAN, UBSAN, configure options? With kvm or without?

I have started the run on a fedora-43 VM. I am on commit:
de61484ec39f418e5c0d4603017695f9ffb8fe24 master branch.

The configuration command I used was:
../configure --target-list=x86_64-softmmu --enable-debug --enable-trace-backends=log --enable-slirp

Targets and accelerators
  KVM support                     : YES

> 
> Can you try the following and show me the log:
> (cd build && QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-x86_64 QTEST_LOG=- tests/qtest/migration-test --full -p /x86_64/migration/colo/plain)
> 

I have attached the log file : qemu.log to this email. It is stuck at
the last line : 
{"timestamp": {"seconds": 1773164370, "microseconds": 609791}, "event": "RESUME"}

It should be some configuration miss from my end.
Thank you for looking into it.

> > #7  0x0000557fd5fe5a0f in test_colo_plain_common (args=0x557fd6bfdf50, failover_during_checkpoint=false, primary_failover=true) at ../tests/qtest/migration/colo-tests.c:106
> > #8  0x0000557fd5fe5ad7 in test_colo_plain_primary_failover (name=0x557fd6bfd050 "/migration/colo/plain/primary_failover", args=0x557fd6bfdf50) at ../tests/qtest/migration/colo-tests.c:126
> > #9  0x0000557fd5fdeff8 in migration_test_wrapper (data=0x557fd6bfd320) at ../tests/qtest/migration/migration-util.c:258
> > #10 0x00007fdd0947bf3e in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
> > #11 0x00007fdd0947beb3 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
> > #12 0x00007fdd0947beb3 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
> > #13 0x00007fdd0947beb3 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
> > #14 0x00007fdd0947beb3 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
> > #15 0x00007fdd0947c46a in g_test_run_suite () from /lib64/libglib-2.0.so.0
> > #16 0x00007fdd0947c500 in g_test_run () from /lib64/libglib-2.0.so.0
> > #17 0x0000557fd5fd9490 in main (argc=1, argv=0x7fff33b51908) at ../tests/qtest/migration-test.c:60
> > 
> > 
> > Is there something that I am missing? Can you please look into this? 
> > 
> > 
> > Regards,
> > Arun Menon
> > 
> 

Regards,
Arun Menon


--wi2Xq99njKX6UUna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=qemu.log
Content-Transfer-Encoding: quoted-printable

arun@fedora:~/workdir/new/devel/upstream/qemu-priv/build$ QTEST_QEMU_IMG=3D=
=2E/qemu-img QTEST_QEMU_BINARY=3D./qemu-system-x86_64 QTEST_LOG=3D- tests/q=
test/migration-test --full -p /x86_64/migration/colo/plain
TAP version 14
# random seed: R02S867993a6b1d4e9cff5bed399f88887cc
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-44479.soc=
k -qtest-log /dev/fd/2 -chardev socket,path=3D/tmp/qtest-44479.qmp,id=3Dcha=
r0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -run-with =
exit-with-parent=3Don -machine none -accel qtest
[I 0.000000] OPENED
[R +0.000934] endianness
[S +0.002373] OK little
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 10}, "packa=
ge": "v10.0.0-7472-gde61484ec3"}, "capabilities": ["oob"]}}
{"execute": "qmp_capabilities"}

{"return": {}}
{"execute": "qom-list-types", "arguments": {"abstract": false, "implements"=
: "accel"}}

{"return": [{"name": "qtest-accel", "parent": "accel"}, {"name": "tcg-accel=
", "parent": "accel"}, {"name": "mshv-accel", "parent": "accel"}, {"name": =
"nitro-accel", "parent": "accel"}, {"name": "kvm-accel", "parent": "accel"}=
]}
[I +0.016144] CLOSED
# Skipping test: userfaultfd not available
[I 0.000000] OPENED
[R +0.001125] endianness
[S +0.001197] OK little
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 10}, "packa=
ge": "v10.0.0-7472-gde61484ec3"}, "capabilities": ["oob"]}}
{"execute": "qmp_capabilities"}

{"return": {}}
{"execute": "query-machines"}

{"return": [{"hotpluggable-cpus": true, "name": "pc-q35-5.2", "numa-mem-sup=
ported": false, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cpu=
-max": 288, "deprecated": true, "default-ram-id": "pc.ram"}, {"hotpluggable=
-cpus": true, "name": "pc-i440fx-10.2", "numa-mem-supported": false, "defau=
lt-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 255, "deprecate=
d": false, "default-ram-id": "pc.ram"}, {"hotpluggable-cpus": true, "name":=
 "pc-i440fx-6.2", "numa-mem-supported": false, "default-cpu-type": "qemu64-=
x86_64-cpu", "acpi": true, "cpu-max": 255, "deprecated": true, "default-ram=
-id": "pc.ram"}, {"hotpluggable-cpus": true, "name": "pc-i440fx-5.2", "numa=
-mem-supported": false, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": tr=
ue, "cpu-max": 255, "deprecated": true, "default-ram-id": "pc.ram"}, {"hotp=
luggable-cpus": true, "name": "pc-q35-9.1", "numa-mem-supported": false, "d=
efault-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 4096, "depr=
ecated": false, "default-ram-id": "pc.ram"}, {"hotpluggable-cpus": true, "n=
ame": "pc-q35-7.1", "numa-mem-supported": false, "default-cpu-type": "qemu6=
4-x86_64-cpu", "acpi": true, "cpu-max": 288, "deprecated": true, "default-r=
am-id": "pc.ram"}, {"hotpluggable-cpus": true, "name": "pc-q35-8.1", "numa-=
mem-supported": false, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": tru=
e, "cpu-max": 1024, "deprecated": false, "default-ram-id": "pc.ram"}, {"hot=
pluggable-cpus": false, "name": "none", "numa-mem-supported": false, "acpi"=
: false, "cpu-max": 1, "deprecated": false, "default-ram-id": "ram"}, {"hot=
pluggable-cpus": true, "name": "pc-q35-11.0", "numa-mem-supported": false, =
"default-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 4096, "de=
precated": false, "default-ram-id": "pc.ram", "alias": "q35"}, {"hotpluggab=
le-cpus": true, "name": "pc-i440fx-8.1", "numa-mem-supported": false, "defa=
ult-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 255, "deprecat=
ed": false, "default-ram-id": "pc.ram"}, {"hotpluggable-cpus": true, "name"=
: "pc-q35-6.1", "numa-mem-supported": false, "default-cpu-type": "qemu64-x8=
6_64-cpu", "acpi": true, "cpu-max": 288, "deprecated": true, "default-ram-i=
d": "pc.ram"}, {"hotpluggable-cpus": false, "name": "nitro", "numa-mem-supp=
orted": false, "acpi": false, "cpu-max": 4096, "deprecated": false, "defaul=
t-ram-id": "ram"}, {"hotpluggable-cpus": true, "name": "pc-i440fx-9.1", "nu=
ma-mem-supported": false, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": =
true, "cpu-max": 255, "deprecated": false, "default-ram-id": "pc.ram"}, {"h=
otpluggable-cpus": true, "name": "pc-q35-10.0", "numa-mem-supported": false=
, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 4096, "=
deprecated": false, "default-ram-id": "pc.ram"}, {"hotpluggable-cpus": true=
, "name": "pc-i440fx-7.1", "numa-mem-supported": false, "default-cpu-type":=
 "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 255, "deprecated": true, "de=
fault-ram-id": "pc.ram"}, {"hotpluggable-cpus": false, "name": "x-remote", =
"numa-mem-supported": false, "acpi": false, "cpu-max": 1, "deprecated": fal=
se}, {"hotpluggable-cpus": true, "name": "pc-i440fx-10.1", "numa-mem-suppor=
ted": false, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cpu-ma=
x": 255, "deprecated": false, "default-ram-id": "pc.ram"}, {"hotpluggable-c=
pus": true, "name": "pc-q35-5.1", "numa-mem-supported": false, "default-cpu=
-type": "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 288, "deprecated": tr=
ue, "default-ram-id": "pc.ram"}, {"hotpluggable-cpus": true, "name": "pc-i4=
40fx-6.1", "numa-mem-supported": false, "default-cpu-type": "qemu64-x86_64-=
cpu", "acpi": true, "cpu-max": 255, "deprecated": true, "default-ram-id": "=
pc.ram"}, {"hotpluggable-cpus": true, "name": "pc-i440fx-5.1", "numa-mem-su=
pported": false, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cp=
u-max": 255, "deprecated": true, "default-ram-id": "pc.ram"}, {"hotpluggabl=
e-cpus": true, "name": "isapc", "numa-mem-supported": false, "default-cpu-t=
ype": "486-x86_64-cpu", "acpi": true, "cpu-max": 1, "deprecated": false, "d=
efault-ram-id": "pc.ram"}, {"hotpluggable-cpus": true, "name": "pc-q35-9.0"=
, "numa-mem-supported": false, "default-cpu-type": "qemu64-x86_64-cpu", "ac=
pi": true, "cpu-max": 4096, "deprecated": false, "default-ram-id": "pc.ram"=
}, {"hotpluggable-cpus": true, "name": "pc-q35-10.2", "numa-mem-supported":=
 false, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 4=
096, "deprecated": false, "default-ram-id": "pc.ram"}, {"hotpluggable-cpus"=
: true, "name": "pc-q35-7.0", "numa-mem-supported": false, "default-cpu-typ=
e": "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 288, "deprecated": true, =
"default-ram-id": "pc.ram"}, {"hotpluggable-cpus": true, "name": "pc-q35-8.=
0", "numa-mem-supported": false, "default-cpu-type": "qemu64-x86_64-cpu", "=
acpi": true, "cpu-max": 288, "deprecated": true, "default-ram-id": "pc.ram"=
}, {"hotpluggable-cpus": true, "name": "pc-i440fx-8.0", "numa-mem-supported=
": false, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cpu-max":=
 255, "deprecated": true, "default-ram-id": "pc.ram"}, {"hotpluggable-cpus"=
: true, "name": "pc-q35-6.0", "numa-mem-supported": false, "default-cpu-typ=
e": "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 288, "deprecated": true, =
"default-ram-id": "pc.ram"}, {"hotpluggable-cpus": true, "name": "pc-i440fx=
-9.0", "numa-mem-supported": false, "default-cpu-type": "qemu64-x86_64-cpu"=
, "acpi": true, "cpu-max": 255, "deprecated": false, "default-ram-id": "pc.=
ram"}, {"hotpluggable-cpus": true, "name": "pc-i440fx-11.0", "numa-mem-supp=
orted": false, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "is-d=
efault": true, "cpu-max": 255, "deprecated": false, "default-ram-id": "pc.r=
am", "alias": "pc"}, {"hotpluggable-cpus": true, "name": "pc-i440fx-7.0", "=
numa-mem-supported": false, "default-cpu-type": "qemu64-x86_64-cpu", "acpi"=
: true, "cpu-max": 255, "deprecated": true, "default-ram-id": "pc.ram"}, {"=
hotpluggable-cpus": true, "name": "pc-i440fx-10.0", "numa-mem-supported": f=
alse, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 255=
, "deprecated": false, "default-ram-id": "pc.ram"}, {"hotpluggable-cpus": t=
rue, "name": "pc-q35-9.2", "numa-mem-supported": false, "default-cpu-type":=
 "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 4096, "deprecated": false, "=
default-ram-id": "pc.ram"}, {"hotpluggable-cpus": true, "name": "pc-q35-7.2=
", "numa-mem-supported": false, "default-cpu-type": "qemu64-x86_64-cpu", "a=
cpi": true, "cpu-max": 288, "deprecated": true, "default-ram-id": "pc.ram"}=
, {"hotpluggable-cpus": true, "name": "pc-i440fx-6.0", "numa-mem-supported"=
: false, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cpu-max": =
255, "deprecated": true, "default-ram-id": "pc.ram"}, {"hotpluggable-cpus":=
 false, "name": "microvm", "numa-mem-supported": false, "default-cpu-type":=
 "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 288, "deprecated": false, "d=
efault-ram-id": "microvm.ram"}, {"hotpluggable-cpus": true, "name": "pc-q35=
-8.2", "numa-mem-supported": false, "default-cpu-type": "qemu64-x86_64-cpu"=
, "acpi": true, "cpu-max": 1024, "deprecated": false, "default-ram-id": "pc=
=2Eram"}, {"hotpluggable-cpus": true, "name": "pc-i440fx-8.2", "numa-mem-su=
pported": false, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cp=
u-max": 255, "deprecated": false, "default-ram-id": "pc.ram"}, {"hotpluggab=
le-cpus": true, "name": "pc-q35-6.2", "numa-mem-supported": false, "default=
-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 288, "deprecated"=
: true, "default-ram-id": "pc.ram"}, {"hotpluggable-cpus": true, "name": "p=
c-i440fx-9.2", "numa-mem-supported": false, "default-cpu-type": "qemu64-x86=
_64-cpu", "acpi": true, "cpu-max": 255, "deprecated": false, "default-ram-i=
d": "pc.ram"}, {"hotpluggable-cpus": true, "name": "pc-q35-10.1", "numa-mem=
-supported": false, "default-cpu-type": "qemu64-x86_64-cpu", "acpi": true, =
"cpu-max": 4096, "deprecated": false, "default-ram-id": "pc.ram"}, {"hotplu=
ggable-cpus": true, "name": "pc-i440fx-7.2", "numa-mem-supported": false, "=
default-cpu-type": "qemu64-x86_64-cpu", "acpi": true, "cpu-max": 255, "depr=
ecated": true, "default-ram-id": "pc.ram"}]}
[I +0.175507] CLOSED
# Start of x86_64 tests
# Start of migration tests
# Start of colo tests
# Start of plain tests
# Running /x86_64/migration/colo/plain/primary_failover
# Using machine type: pc-q35-11.0
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-44479.soc=
k -qtest-log /dev/fd/2 -chardev socket,path=3D/tmp/qtest-44479.qmp,id=3Dcha=
r0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -run-with =
exit-with-parent=3Don -accel kvm -accel tcg -machine pc-q35-11.0, -name sou=
rce,debug-threads=3Don -machine memory-backend=3Dmig.mem -object memory-bac=
kend-ram,id=3Dmig.mem,size=3D150M,share=3Doff -serial file:/tmp/migration-t=
est-WV15L3/src_serial -drive if=3Dnone,id=3Dd0,file=3D/tmp/migration-test-W=
V15L3/bootsect,format=3Draw -device ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,hea=
ds=3D1 -snapshot  -accel qtest
[I 0.000001] OPENED
[R +0.059029] endianness
[S +0.059071] OK little
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 10}, "packa=
ge": "v10.0.0-7472-gde61484ec3"}, "capabilities": ["oob"]}}
{"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}

{"return": {}}
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-44479.soc=
k -qtest-log /dev/fd/2 -chardev socket,path=3D/tmp/qtest-44479.qmp,id=3Dcha=
r0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -run-with =
exit-with-parent=3Don -accel kvm -accel tcg -machine pc-q35-11.0, -name tar=
get,debug-threads=3Don -machine memory-backend=3Dmig.mem -object memory-bac=
kend-ram,id=3Dmig.mem,size=3D150M,share=3Doff -serial file:/tmp/migration-t=
est-WV15L3/dest_serial -incoming tcp:127.0.0.1:0  -drive if=3Dnone,id=3Dd0,=
file=3D/tmp/migration-test-WV15L3/bootsect,format=3Draw -device ide-hd,driv=
e=3Dd0,secs=3D1,cyls=3D1,heads=3D1 -snapshot  -accel qtest
[I 0.000001] OPENED
[R +0.045500] endianness
[S +0.045546] OK little
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 10}, "packa=
ge": "v10.0.0-7472-gde61484ec3"}, "capabilities": ["oob"]}}
{"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}

{"return": {}}
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"st=
ate": true, "capability": "return-path"}]}}

{"return": {}}
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"st=
ate": true, "capability": "return-path"}]}}

{"return": {}}
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"st=
ate": true, "capability": "x-colo"}]}}

{"return": {}}
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"st=
ate": true, "capability": "x-colo"}]}}

{"return": {}}
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"st=
ate": true, "capability": "return-path"}]}}

{"return": {}}
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"st=
ate": true, "capability": "return-path"}]}}

{"return": {}}
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"st=
ate": true, "capability": "events"}]}}

{"return": {}}
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"st=
ate": true, "capability": "events"}]}}

{"return": {}}
{"execute": "migrate-set-parameters", "arguments": {"x-checkpoint-delay": 3=
00}}

{"return": {}}
{"execute": "query-migrate-parameters"}

{"return": {"cpu-throttle-tailslow": false, "xbzrle-cache-size": 67108864, =
"cpu-throttle-initial": 20, "announce-max": 550, "direct-io": false, "avail=
-switchover-bandwidth": 0, "zero-page-detection": "multifd", "multifd-qatzi=
p-level": 1, "multifd-channels": 2, "mode": "normal", "multifd-zstd-level":=
 1, "announce-initial": 50, "downtime-limit": 300, "tls-authz": "", "cpr-ex=
ec-command": [], "vcpu-dirty-limit": 1, "multifd-compression": "none", "ann=
ounce-rounds": 5, "announce-step": 100, "tls-creds": "", "x-vcpu-dirty-limi=
t-period": 1000, "multifd-zlib-level": 1, "max-cpu-throttle": 99, "max-post=
copy-bandwidth": 0, "tls-hostname": "", "throttle-trigger-threshold": 50, "=
max-bandwidth": 134217728, "x-checkpoint-delay": 300, "cpu-throttle-increme=
nt": 10}}
{"execute": "migrate-set-parameters", "arguments": {"max-bandwidth": 100000=
0000}}

{"return": {}}
{"execute": "query-migrate-parameters"}

{"return": {"cpu-throttle-tailslow": false, "xbzrle-cache-size": 67108864, =
"cpu-throttle-initial": 20, "announce-max": 550, "direct-io": false, "avail=
-switchover-bandwidth": 0, "zero-page-detection": "multifd", "multifd-qatzi=
p-level": 1, "multifd-channels": 2, "mode": "normal", "multifd-zstd-level":=
 1, "announce-initial": 50, "downtime-limit": 300, "tls-authz": "", "cpr-ex=
ec-command": [], "vcpu-dirty-limit": 1, "multifd-compression": "none", "ann=
ounce-rounds": 5, "announce-step": 100, "tls-creds": "", "x-vcpu-dirty-limi=
t-period": 1000, "multifd-zlib-level": 1, "max-cpu-throttle": 99, "max-post=
copy-bandwidth": 0, "tls-hostname": "", "throttle-trigger-threshold": 50, "=
max-bandwidth": 1000000000, "x-checkpoint-delay": 300, "cpu-throttle-increm=
ent": 10}}
{"execute": "migrate-set-parameters", "arguments": {"downtime-limit": 30000=
}}

{"return": {}}
{"execute": "query-migrate-parameters"}

{"return": {"cpu-throttle-tailslow": false, "xbzrle-cache-size": 67108864, =
"cpu-throttle-initial": 20, "announce-max": 550, "direct-io": false, "avail=
-switchover-bandwidth": 0, "zero-page-detection": "multifd", "multifd-qatzi=
p-level": 1, "multifd-channels": 2, "mode": "normal", "multifd-zstd-level":=
 1, "announce-initial": 50, "downtime-limit": 30000, "tls-authz": "", "cpr-=
exec-command": [], "vcpu-dirty-limit": 1, "multifd-compression": "none", "a=
nnounce-rounds": 5, "announce-step": 100, "tls-creds": "", "x-vcpu-dirty-li=
mit-period": 1000, "multifd-zlib-level": 1, "max-cpu-throttle": 99, "max-po=
stcopy-bandwidth": 0, "tls-hostname": "", "throttle-trigger-threshold": 50,=
 "max-bandwidth": 1000000000, "x-checkpoint-delay": 300, "cpu-throttle-incr=
ement": 10}}
{"execute": "query-migrate"}

{"return": {"status": "setup", "socket-address": [{"port": "45981", "ipv4":=
 true, "host": "127.0.0.1", "type": "inet"}]}}
{"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.1:45981"}}

{"timestamp": {"seconds": 1773164234, "microseconds": 337705}, "event": "MI=
GRATION", "data": {"status": "setup"}}

{"return": {}}
{"execute": "query-migrate"}

{"timestamp": {"seconds": 1773164234, "microseconds": 342267}, "event": "MI=
GRATION_PASS", "data": {"pass": 1}}

{"timestamp": {"seconds": 1773164234, "microseconds": 342442}, "event": "MI=
GRATION", "data": {"status": "active"}}

{"return": {"expected-downtime": 30000, "status": "active", "setup-time": 3=
, "total-time": 5, "ram": {"total": 174923776, "postcopy-requests": 0, "dir=
ty-sync-count": 1, "multifd-bytes": 0, "pages-per-second": 0, "downtime-byt=
es": 0, "page-size": 4096, "remaining": 174923776, "postcopy-bytes": 0, "mb=
ps": 0, "transferred": 295, "dirty-sync-missed-zero-copy": 0, "precopy-byte=
s": 0, "duplicate": 0, "dirty-pages-rate": 0, "normal-bytes": 0, "normal": =
0}}}
{"execute": "query-migrate"}

{"return": {"expected-downtime": 30000, "status": "active", "setup-time": 3=
, "total-time": 21, "ram": {"total": 174923776, "postcopy-requests": 0, "di=
rty-sync-count": 1, "multifd-bytes": 0, "pages-per-second": 0, "downtime-by=
tes": 0, "page-size": 4096, "remaining": 169865216, "postcopy-bytes": 0, "m=
bps": 0, "transferred": 4073380, "dirty-sync-missed-zero-copy": 0, "precopy=
-bytes": 4200307, "duplicate": 211, "dirty-pages-rate": 0, "normal-bytes": =
4190208, "normal": 1023}}}
{"execute": "query-migrate"}

{"return": {"expected-downtime": 30000, "status": "active", "setup-time": 3=
, "total-time": 28, "ram": {"total": 174923776, "postcopy-requests": 0, "di=
rty-sync-count": 1, "multifd-bytes": 0, "pages-per-second": 0, "downtime-by=
tes": 0, "page-size": 4096, "remaining": 166457344, "postcopy-bytes": 0, "m=
bps": 0, "transferred": 7487908, "dirty-sync-missed-zero-copy": 0, "precopy=
-bytes": 7614835, "duplicate": 211, "dirty-pages-rate": 0, "normal-bytes": =
7598080, "normal": 1855}}}
{"execute": "query-migrate"}

{"return": {"expected-downtime": 30000, "status": "active", "setup-time": 3=
, "total-time": 37, "ram": {"total": 174923776, "postcopy-requests": 0, "di=
rty-sync-count": 1, "multifd-bytes": 0, "pages-per-second": 0, "downtime-by=
tes": 0, "page-size": 4096, "remaining": 162131968, "postcopy-bytes": 0, "m=
bps": 0, "transferred": 11821732, "dirty-sync-missed-zero-copy": 0, "precop=
y-bytes": 11948659, "duplicate": 211, "dirty-pages-rate": 0, "normal-bytes"=
: 11923456, "normal": 2911}}}
{"execute": "query-migrate"}

{"return": {"expected-downtime": 30000, "status": "active", "setup-time": 3=
, "total-time": 48, "ram": {"total": 174923776, "postcopy-requests": 0, "di=
rty-sync-count": 1, "multifd-bytes": 0, "pages-per-second": 0, "downtime-by=
tes": 0, "page-size": 4096, "remaining": 158724096, "postcopy-bytes": 0, "m=
bps": 0, "transferred": 15236260, "dirty-sync-missed-zero-copy": 0, "precop=
y-bytes": 15363187, "duplicate": 211, "dirty-pages-rate": 0, "normal-bytes"=
: 15331328, "normal": 3743}}}
{"execute": "query-migrate"}

{"return": {"expected-downtime": 30000, "status": "active", "setup-time": 3=
, "total-time": 58, "ram": {"total": 174923776, "postcopy-requests": 0, "di=
rty-sync-count": 1, "multifd-bytes": 0, "pages-per-second": 0, "downtime-by=
tes": 0, "page-size": 4096, "remaining": 155840512, "postcopy-bytes": 0, "m=
bps": 0, "transferred": 18125476, "dirty-sync-missed-zero-copy": 0, "precop=
y-bytes": 18252403, "duplicate": 211, "dirty-pages-rate": 0, "normal-bytes"=
: 18214912, "normal": 4447}}}
{"execute": "query-migrate"}

{"return": {"expected-downtime": 30000, "status": "active", "setup-time": 3=
, "total-time": 72, "ram": {"total": 174923776, "postcopy-requests": 0, "di=
rty-sync-count": 1, "multifd-bytes": 0, "pages-per-second": 0, "downtime-by=
tes": 0, "page-size": 4096, "remaining": 151588864, "postcopy-bytes": 0, "m=
bps": 0, "transferred": 22385446, "dirty-sync-missed-zero-copy": 0, "precop=
y-bytes": 22512363, "duplicate": 211, "dirty-pages-rate": 0, "normal-bytes"=
: 22466560, "normal": 5485}}}
{"execute": "query-migrate"}

{"return": {"expected-downtime": 30000, "status": "active", "setup-time": 3=
, "total-time": 81, "ram": {"total": 174923776, "postcopy-requests": 0, "di=
rty-sync-count": 1, "multifd-bytes": 0, "pages-per-second": 0, "downtime-by=
tes": 0, "page-size": 4096, "remaining": 148049920, "postcopy-bytes": 0, "m=
bps": 0, "transferred": 25931302, "dirty-sync-missed-zero-copy": 0, "precop=
y-bytes": 26058219, "duplicate": 211, "dirty-pages-rate": 0, "normal-bytes"=
: 26005504, "normal": 6349}}}
{"execute": "query-migrate"}

{"return": {"expected-downtime": 30000, "status": "active", "setup-time": 3=
, "total-time": 94, "ram": {"total": 174923776, "postcopy-requests": 0, "di=
rty-sync-count": 1, "multifd-bytes": 0, "pages-per-second": 0, "downtime-by=
tes": 0, "page-size": 4096, "remaining": 143593472, "postcopy-bytes": 0, "m=
bps": 0, "transferred": 30396454, "dirty-sync-missed-zero-copy": 0, "precop=
y-bytes": 30523371, "duplicate": 211, "dirty-pages-rate": 0, "normal-bytes"=
: 30461952, "normal": 7437}}}
{"execute": "query-migrate"}

{"return": {"expected-downtime": 30000, "status": "active", "setup-time": 3=
, "total-time": 103, "ram": {"total": 174923776, "postcopy-requests": 0, "d=
irty-sync-count": 1, "multifd-bytes": 0, "pages-per-second": 0, "downtime-b=
ytes": 0, "page-size": 4096, "remaining": 139530240, "postcopy-bytes": 0, "=
mbps": 0, "transferred": 34467622, "dirty-sync-missed-zero-copy": 0, "preco=
py-bytes": 34594539, "duplicate": 211, "dirty-pages-rate": 0, "normal-bytes=
": 34525184, "normal": 8429}}}
{"execute": "query-migrate"}

{"timestamp": {"seconds": 1773164234, "microseconds": 447993}, "event": "MI=
GRATION_PASS", "data": {"pass": 2}}

{"timestamp": {"seconds": 1773164234, "microseconds": 448402}, "event": "ST=
OP"}

{"timestamp": {"seconds": 1773164234, "microseconds": 448539}, "event": "MI=
GRATION", "data": {"status": "device"}}

{"timestamp": {"seconds": 1773164234, "microseconds": 448700}, "event": "MI=
GRATION_PASS", "data": {"pass": 3}}

{"return": {"expected-downtime": 30000, "status": "device", "setup-time": 3=
, "total-time": 385, "ram": {"total": 174923776, "postcopy-requests": 0, "d=
irty-sync-count": 3, "multifd-bytes": 0, "pages-per-second": 83981, "downti=
me-bytes": 75268133, "page-size": 4096, "remaining": 0, "postcopy-bytes": 0=
, "mbps": 2693.8943119266055, "transferred": 111972466, "dirty-sync-missed-=
zero-copy": 0, "precopy-bytes": 36703995, "duplicate": 17152, "dirty-pages-=
rate": 0, "normal-bytes": 111599616, "normal": 27246}}}
{"execute": "query-migrate"}

{"return": {"expected-downtime": 30000, "status": "device", "setup-time": 3=
, "total-time": 398, "ram": {"total": 174923776, "postcopy-requests": 0, "d=
irty-sync-count": 3, "multifd-bytes": 0, "pages-per-second": 83981, "downti=
me-bytes": 75268133, "page-size": 4096, "remaining": 0, "postcopy-bytes": 0=
, "mbps": 2693.8943119266055, "transferred": 112195530, "dirty-sync-missed-=
zero-copy": 0, "precopy-bytes": 36703995, "duplicate": 17152, "dirty-pages-=
rate": 0, "normal-bytes": 111599616, "normal": 27246}}}
{"execute": "query-migrate"}

{"return": {"expected-downtime": 30000, "status": "device", "setup-time": 3=
, "total-time": 406, "ram": {"total": 174923776, "postcopy-requests": 0, "d=
irty-sync-count": 3, "multifd-bytes": 0, "pages-per-second": 83981, "downti=
me-bytes": 75268133, "page-size": 4096, "remaining": 0, "postcopy-bytes": 0=
, "mbps": 2693.8943119266055, "transferred": 112195530, "dirty-sync-missed-=
zero-copy": 0, "precopy-bytes": 36703995, "duplicate": 17152, "dirty-pages-=
rate": 0, "normal-bytes": 111599616, "normal": 27246}}}
{"execute": "query-migrate"}

{"return": {"expected-downtime": 30000, "status": "device", "setup-time": 3=
, "total-time": 415, "ram": {"total": 174923776, "postcopy-requests": 0, "d=
irty-sync-count": 3, "multifd-bytes": 0, "pages-per-second": 83981, "downti=
me-bytes": 75268133, "page-size": 4096, "remaining": 0, "postcopy-bytes": 0=
, "mbps": 2693.8943119266055, "transferred": 112195530, "dirty-sync-missed-=
zero-copy": 0, "precopy-bytes": 36703995, "duplicate": 17152, "dirty-pages-=
rate": 0, "normal-bytes": 111599616, "normal": 27246}}}
{"execute": "query-migrate"}

{"timestamp": {"seconds": 1773164234, "microseconds": 759236}, "event": "MI=
GRATION", "data": {"status": "colo"}}

{"return": {"status": "colo"}}

{"timestamp": {"seconds": 1773164234, "microseconds": 340283}, "event": "MI=
GRATION", "data": {"status": "active"}}

{"timestamp": {"seconds": 1773164234, "microseconds": 755141}, "event": "MI=
GRATION", "data": {"status": "colo"}}

{"timestamp": {"seconds": 1773164234, "microseconds": 760176}, "event": "RE=
SUME"}


--wi2Xq99njKX6UUna--


