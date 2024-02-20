Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D00C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 06:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcJE6-0006db-Iy; Tue, 20 Feb 2024 01:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJE5-0006dA-Cc
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:03:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJE3-0005lK-76
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708409010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D26DCE78Jhukj+jd/ue1kKvpOtc6can1gn7HRty1ZkI=;
 b=Z/J+nU49JIxy6DiV1aZL4+ps10wzUZz6poihbu279+rxgfzF9b7dfEeUvShHP9W1XqGCWm
 3sT+w4CJf2BUnSza1be0a2TaTh+O8bMAgANF2zizpnzyTkJkdXjdS4QQQexg4J8tUAicjQ
 amD7/P58bdz+OoZ/nAWSPpMhi8qsgrE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-2an7eYKTP3mZC_s-B7Sn0Q-1; Tue, 20 Feb 2024 01:03:28 -0500
X-MC-Unique: 2an7eYKTP3mZC_s-B7Sn0Q-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6dbd919aba8so1045143b3a.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 22:03:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708409007; x=1709013807;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D26DCE78Jhukj+jd/ue1kKvpOtc6can1gn7HRty1ZkI=;
 b=BUzGu133dmVwUgIxdYI0w6B6twtOPphLHE/wAqvRYVlddWczbLITJvrsA8lQYfnNHQ
 pJRngp1D114CFFXnQVgeGqAZvLRsiw8Ih+6k1fhXMtvbZwKLPfi55Jeucyr9aHP0RbGL
 15YYcwQYx1PFbuO+EeUIXMzJUFT4Hj6jjMxKZNnqh5KPUJTSiwyFY99L4+ketZIEq+pC
 6x0+ZZBAkHlw38Y+up0sgzrTsExKl7407MjVDRFDVc/czI+vObZOtU5Ds/PkqlHJFwWI
 /ILQdKrMH4DXFde+IsCKx127xrGUIB0Fh6w9b3VCpGkwrYEeWupeT6QunQ6Dzcif3L1Q
 W4mw==
X-Gm-Message-State: AOJu0YzUlUv1p2l33mkREvO6jm5psxCu8RSouVVPnAh2E7webyASJFNF
 FuEqBPcHQiLamzUG/q48x4wL7jO25NnoYexJxbuBPvU7fMd4a9FrAzeIgwpeX7SK8kl7mUJeeTv
 DE+HA4gc/eYzb05l9+xYXaBhwBiWzIotU3a9raEW/Vz/paZLRIjAo
X-Received: by 2002:a05:6a20:8e0b:b0:1a0:71e7:9448 with SMTP id
 y11-20020a056a208e0b00b001a071e79448mr16599654pzj.6.1708409006926; 
 Mon, 19 Feb 2024 22:03:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKyUzoHFNQ9sgcq7Pokc7yYkQFFJ9jozHDaO/saXTbOnPSxxeyy5e47quEIBPVY5BbfIWw0w==
X-Received: by 2002:a05:6a20:8e0b:b0:1a0:71e7:9448 with SMTP id
 y11-20020a056a208e0b00b001a071e79448mr16599641pzj.6.1708409006531; 
 Mon, 19 Feb 2024 22:03:26 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 v184-20020a6389c1000000b005bdbe9a597fsm5774409pgd.57.2024.02.19.22.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 22:03:26 -0800 (PST)
Date: Tue, 20 Feb 2024 14:03:15 +0800
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 farosas@suse.de
Subject: Re: [PATCH 1/3] qtest: migration: Enhance qtest migration functions
 to support 'channels' argument
Message-ID: <ZdRAo3XJ9xvs6Z4Q@x1n>
References: <20240216090624.75445-1-het.gala@nutanix.com>
 <20240216090624.75445-2-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216090624.75445-2-het.gala@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

On Fri, Feb 16, 2024 at 09:06:22AM +0000, Het Gala wrote:
> Introduce support for adding a 'channels' argument to migrate_qmp_fail
> and migrate_qmp functions within the migration qtest framework, enabling
> enhanced control over migration scenarios.
> 
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  tests/qtest/dbus-vmstate-test.c |  2 +-
>  tests/qtest/migration-helpers.c | 93 ++++++++++++++++++++++++++++++---
>  tests/qtest/migration-helpers.h | 11 ++--
>  tests/qtest/migration-test.c    | 33 ++++++------
>  4 files changed, 112 insertions(+), 27 deletions(-)
> 
> diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
> index 6c990864e3..0ca572e29b 100644
> --- a/tests/qtest/dbus-vmstate-test.c
> +++ b/tests/qtest/dbus-vmstate-test.c
> @@ -229,7 +229,7 @@ test_dbus_vmstate(Test *test)
>  
>      thread = g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread, loop);
>  
> -    migrate_qmp(src_qemu, uri, "{}");
> +    migrate_qmp(src_qemu, uri, NULL, "{}");
>      test->src_qemu = src_qemu;
>      if (test->migrate_fail) {
>          wait_for_migration_fail(src_qemu, true);
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index e451dbdbed..d153677887 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/ctype.h"
>  #include "qapi/qmp/qjson.h"
> +#include "qapi/qmp/qlist.h"
>  
>  #include "migration-helpers.h"
>  
> @@ -43,7 +44,70 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
>      return false;
>  }
>  
> -void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
> +static char *socketAddressType_to_str(SocketAddressType type)
> +{
> +    switch (type) {
> +    case SOCKET_ADDRESS_TYPE_INET:
> +        return g_strdup("inet");
> +    case SOCKET_ADDRESS_TYPE_UNIX:
> +        return g_strdup("unix");
> +    case SOCKET_ADDRESS_TYPE_FD:
> +        return g_strdup("fd");
> +    case SOCKET_ADDRESS_TYPE_VSOCK:
> +        return g_strdup("vsock");
> +    default:
> +        return g_strdup("unknown address type");
> +    }
> +}

Use SocketAddressType_lookup?

> +
> +static QList *MigrationChannelList_to_QList(MigrationChannelList *channels)
> +{
> +    MigrationChannel *channel = NULL;
> +    MigrationAddress *addr = NULL;
> +    SocketAddress *saddr = NULL;
> +    g_autofree const char *addr_type = NULL;
> +    QList *channelList = qlist_new();
> +    QDict *channelDict = qdict_new();
> +    QDict *addrDict = qdict_new();
> +
> +    channel = channels->value;
> +    if (!channel || channel->channel_type == MIGRATION_CHANNEL_TYPE__MAX) {
> +        fprintf(stderr, "%s: Channel or its type is NULL\n",
> +                __func__);
> +    }
> +    g_assert(channel);
> +    if (channel->channel_type == MIGRATION_CHANNEL_TYPE_MAIN) {
> +        qdict_put_str(channelDict, "channel-type", g_strdup("main"));
> +    }
> +
> +    addr = channel->addr;
> +    if (!addr || addr->transport == MIGRATION_ADDRESS_TYPE__MAX) {
> +        fprintf(stderr, "%s: addr or its transport is NULL\n",
> +                __func__);
> +    }
> +    g_assert(addr);
> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> +        qdict_put_str(addrDict, "transport", g_strdup("socket"));
> +    }
> +
> +    saddr = &addr->u.socket;
> +    if (!saddr) {
> +        fprintf(stderr, "%s: saddr is NULL\n", __func__);
> +    }
> +    g_assert(saddr);
> +    addr_type = socketAddressType_to_str(saddr->type);
> +    qdict_put_str(addrDict, "type", addr_type);
> +    qdict_put_str(addrDict, "port", saddr->u.inet.port);
> +    qdict_put_str(addrDict, "host", saddr->u.inet.host);
> +
> +    qdict_put_obj(channelDict, "addr", QOBJECT(addrDict));
> +    qlist_append_obj(channelList, QOBJECT(channelDict));
> +
> +    return channelList;
> +}
> +
> +void migrate_qmp_fail(QTestState *who, const char *uri,
> +                      MigrationChannelList *channels, const char *fmt, ...)
>  {
>      va_list ap;
>      QDict *args, *err;
> @@ -52,8 +116,16 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
>      args = qdict_from_vjsonf_nofail(fmt, ap);
>      va_end(ap);
>  
> -    g_assert(!qdict_haskey(args, "uri"));
> -    qdict_put_str(args, "uri", uri);
> +    if (uri) {
> +        g_assert(!qdict_haskey(args, "uri"));

IMHO we don't need to assert here?

Rather than doing this, we can also have tests covering when both are set,
or when none are set, to make sure we fail properly in those wrong cases.

> +        qdict_put_str(args, "uri", uri);
> +    }
> +
> +    if (channels) {
> +        g_assert(!qdict_haskey(args, "channels"));
> +        QList *channelList = MigrationChannelList_to_QList(channels);
> +        qdict_put_obj(args, "channels", QOBJECT(channelList));
> +    }
>  
>      err = qtest_qmp_assert_failure_ref(
>          who, "{ 'execute': 'migrate', 'arguments': %p}", args);
> @@ -68,7 +140,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
>   * Arguments are built from @fmt... (formatted like
>   * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
>   */
> -void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
> +void migrate_qmp(QTestState *who, const char *uri,
> +                 MigrationChannelList *channels, const char *fmt, ...)
>  {
>      va_list ap;
>      QDict *args;
> @@ -77,8 +150,16 @@ void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
>      args = qdict_from_vjsonf_nofail(fmt, ap);
>      va_end(ap);
>  
> -    g_assert(!qdict_haskey(args, "uri"));
> -    qdict_put_str(args, "uri", uri);
> +    if (uri) {
> +        g_assert(!qdict_haskey(args, "uri"));
> +        qdict_put_str(args, "uri", uri);
> +    }
> +
> +    if (channels) {
> +        g_assert(!qdict_haskey(args, "channels"));
> +        QList *channelList = MigrationChannelList_to_QList(channels);
> +        qdict_put_obj(args, "channels", QOBJECT(channelList));
> +    }

Duplicated chunks; sign of adding some helper?

>  
>      qtest_qmp_assert_success(who,
>                               "{ 'execute': 'migrate', 'arguments': %p}", args);
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 3bf7ded1b9..52243bd2df 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -14,6 +14,7 @@
>  #define MIGRATION_HELPERS_H
>  
>  #include "libqtest.h"
> +#include "migration/migration.h"
>  
>  typedef struct QTestMigrationState {
>      bool stop_seen;
> @@ -25,15 +26,17 @@ typedef struct QTestMigrationState {
>  bool migrate_watch_for_events(QTestState *who, const char *name,
>                                QDict *event, void *opaque);
>  
> -G_GNUC_PRINTF(3, 4)
> -void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
> +G_GNUC_PRINTF(4, 5)
> +void migrate_qmp(QTestState *who, const char *uri,
> +                 MigrationChannelList *channels, const char *fmt, ...);
>  
>  G_GNUC_PRINTF(3, 4)
>  void migrate_incoming_qmp(QTestState *who, const char *uri,
>                            const char *fmt, ...);
>  
> -G_GNUC_PRINTF(3, 4)
> -void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...);
> +G_GNUC_PRINTF(4, 5)
> +void migrate_qmp_fail(QTestState *who, const char *uri,
> +                      MigrationChannelList *channels, const char *fmt, ...);
>  
>  void migrate_set_capability(QTestState *who, const char *capability,
>                              bool value);
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 8a5bb1752e..e7f2719dcf 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -18,6 +18,7 @@
>  #include "qemu/module.h"
>  #include "qemu/option.h"
>  #include "qemu/range.h"
> +#include "migration/migration.h"
>  #include "qemu/sockets.h"
>  #include "chardev/char.h"
>  #include "qapi/qapi-visit-sockets.h"
> @@ -1350,7 +1351,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>      wait_for_suspend(from, &src_state);
>  
>      g_autofree char *uri = migrate_get_socket_address(to, "socket-address");
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>  
>      migrate_wait_for_dirty_mem(from, to);
>  
> @@ -1500,7 +1501,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
>      g_assert_cmpint(ret, ==, 1);
>  
>      migrate_recover(to, "fd:fd-mig");
> -    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
> +    migrate_qmp(from, "fd:fd-mig", NULL, "{'resume': true}");
>  
>      /*
>       * Make sure both QEMU instances will go into RECOVER stage, then test
> @@ -1588,7 +1589,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
>       * Try to rebuild the migration channel using the resume flag and
>       * the newly created channel
>       */
> -    migrate_qmp(from, uri, "{'resume': true}");
> +    migrate_qmp(from, uri, NULL, "{'resume': true}");
>  
>      /* Restore the postcopy bandwidth to unlimited */
>      migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
> @@ -1669,7 +1670,7 @@ static void test_baddest(void)
>      if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
>          return;
>      }
> -    migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
> +    migrate_qmp(from, "tcp:127.0.0.1:0", NULL, "{}");
>      wait_for_migration_fail(from, false);
>      test_migrate_end(from, to, false);
>  }
> @@ -1708,7 +1709,7 @@ static void test_analyze_script(void)
>      uri = g_strdup_printf("exec:cat > %s", file);
>  
>      migrate_ensure_converge(from);
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>      wait_for_migration_complete(from);
>  
>      pid = fork();
> @@ -1773,11 +1774,11 @@ static void test_precopy_common(MigrateCommon *args)
>      }
>  
>      if (args->result == MIG_TEST_QMP_ERROR) {
> -        migrate_qmp_fail(from, connect_uri, "{}");
> +        migrate_qmp_fail(from, connect_uri, NULL, "{}");
>          goto finish;
>      }
>  
> -    migrate_qmp(from, connect_uri, "{}");
> +    migrate_qmp(from, connect_uri, NULL, "{}");
>  
>      if (args->result != MIG_TEST_SUCCEED) {
>          bool allow_active = args->result == MIG_TEST_FAIL;
> @@ -1869,11 +1870,11 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
>      }
>  
>      if (args->result == MIG_TEST_QMP_ERROR) {
> -        migrate_qmp_fail(from, connect_uri, "{}");
> +        migrate_qmp_fail(from, connect_uri, NULL, "{}");
>          goto finish;
>      }
>  
> -    migrate_qmp(from, connect_uri, "{}");
> +    migrate_qmp(from, connect_uri, NULL, "{}");
>      wait_for_migration_complete(from);
>  
>      /*
> @@ -2029,7 +2030,7 @@ static void test_ignore_shared(void)
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>  
>      migrate_wait_for_dirty_mem(from, to);
>  
> @@ -2455,7 +2456,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>  
>      if (should_fail) {
>          qtest_set_expected_status(to, EXIT_FAILURE);
> @@ -2558,7 +2559,7 @@ static void test_migrate_auto_converge(void)
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>  
>      /* Wait for throttling begins */
>      percentage = 0;
> @@ -2869,7 +2870,7 @@ static void test_multifd_tcp_cancel(void)
>  
>      uri = migrate_get_socket_address(to, "socket-address");
>  
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>  
>      migrate_wait_for_dirty_mem(from, to);
>  
> @@ -2901,7 +2902,7 @@ static void test_multifd_tcp_cancel(void)
>  
>      migrate_ensure_non_converge(from);
>  
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>  
>      migrate_wait_for_dirty_mem(from, to2);
>  
> @@ -3234,7 +3235,7 @@ static void test_migrate_dirty_limit(void)
>      migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
>  
>      /* Start migrate */
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>  
>      /* Wait for dirty limit throttle begin */
>      throttle_us_per_full = 0;
> @@ -3275,7 +3276,7 @@ static void test_migrate_dirty_limit(void)
>      }
>  
>      /* Start migrate */
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>  
>      /* Wait for dirty limit throttle begin */
>      throttle_us_per_full = 0;
> -- 
> 2.22.3
> 

-- 
Peter Xu


