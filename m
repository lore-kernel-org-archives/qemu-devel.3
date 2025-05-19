Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAB5C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 07:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGunm-00033p-Rf; Mon, 19 May 2025 03:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uGunf-00033W-7L
 for qemu-devel@nongnu.org; Mon, 19 May 2025 03:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uGunb-0003jY-JZ
 for qemu-devel@nongnu.org; Mon, 19 May 2025 03:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747639230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rU0ZCHKwCn6HgvepdVIGoKn7W1t77uEN/VIWfjCaf08=;
 b=R4bDp39SLHQgU5XflD4ntDHxNwpgBiOE/awiHgnONu5LHGr4YL0NtsNizwobsDn5KcoTEe
 315y/dRHEUpPIfak1PcxbdIJYeAGB6uhGj4oURwjaYUPz9VfnuqCeHJJkwz2ifojeizu7r
 JLf13TZQGbnDNI/zNUkmzN7Fuf7kSok=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-hZ4t4Z0cOKq9vwlS0z2wlA-1; Mon, 19 May 2025 03:20:29 -0400
X-MC-Unique: hZ4t4Z0cOKq9vwlS0z2wlA-1
X-Mimecast-MFC-AGG-ID: hZ4t4Z0cOKq9vwlS0z2wlA_1747639228
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so28470805e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 00:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747639227; x=1748244027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rU0ZCHKwCn6HgvepdVIGoKn7W1t77uEN/VIWfjCaf08=;
 b=YTi5p/ojpiJvt0LwWOURXqlOHXpEC9DtMRSlAYoJOJbDhns8wRhr6+l7GzdHu1g+UF
 27RTw0KxP5wfmF8sbAi3icQfwh1zAcVSsjaaXHi4AjbNKmcIRbequNWf9zlAAej13mSW
 pgo/gwtxfxlcXpQscq9VdUnXwa/X24Zd1aXS9WB9pm92jO2SHdHE6vrpqraqhPsDV7Cd
 ULHq7NuZXXpLHqbfxn+4VcpnWjFfwAmkInrisnNN0ka6LpamvdHHwAsv8IZ+Tz5XSQjD
 jk0ZRl7pHqSVPVi7QdbB/fRlEX/DToSJ9piuC73POLVXrooKFfKk22mK0+K9vPb0P3ir
 7dRg==
X-Gm-Message-State: AOJu0YyQ5Oo977iXmLKDngAEiQFzjxROfhYFcT0CNUZljjLraRFuoGdB
 hg3m/iSdYGgfOrD74LbTsLxr+QQo4uIe6gnpQxf+wD4p1x1m33Qq91JVWhR3HtSaIsQWaAi/Hb4
 3YXeNksfcRonDeLEI4xSYWx5Rn9SJzjRLj7ew+xmR3R7/iNfw3SO3btlk9frua9IoDEukXo0qy7
 v8Gn++m58aT4WvfG8cXrRvf71Pvps+Zs/ajHeCQWdNYQ==
X-Gm-Gg: ASbGncvlNvacPncLQQeNPwJBCI0P4l7M/aLI+nJy5xjCxFvBh/IGEUFWK2suxxp+oSa
 60dIfso6YUUE1FmBf7B8PgnOqnbHUSel/Hwy3CKetAbWPVVsI9gsTYoc8X4+p2fi+CWYPRiA=
X-Received: by 2002:a5d:5988:0:b0:3a3:6a77:3386 with SMTP id
 ffacd0b85a97d-3a36a773752mr3609125f8f.3.1747639227383; 
 Mon, 19 May 2025 00:20:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP6K0Gd5do7EDxTpEErJqixme99IrlxqQf/LQiVeyIb1VvtvItNSFsz0CRh6/pQh+0t9qs2SiSRt0eK7x5nUo=
X-Received: by 2002:a5d:5988:0:b0:3a3:6a77:3386 with SMTP id
 ffacd0b85a97d-3a36a773752mr3609098f8f.3.1747639226995; Mon, 19 May 2025
 00:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250512125124.147064-1-ppandit@redhat.com>
 <20250512125124.147064-4-ppandit@redhat.com>
In-Reply-To: <20250512125124.147064-4-ppandit@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 19 May 2025 12:50:10 +0530
X-Gm-Features: AX0GCFsbHqm1F_A51AIJ2TVWpq5KijRqcUMfgQfCdjCmxdFxM30kBMwKE1mfokU
Message-ID: <CAE8KmOyjgeMN=C3qTt4LUMPQz1if5UJnuQGbsowQ70P_XRbj+w@mail.gmail.com>
Subject: Re: [PATCH v11 3/3] tests/qtest/migration: add postcopy tests with
 multifd
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

On Mon, 12 May 2025 at 18:22, Prasad Pandit <ppandit@redhat.com> wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
>
> Add new qtests to run postcopy migration with multifd
> channels enabled.
>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  tests/qtest/migration/compression-tests.c | 18 ++++++++
>  tests/qtest/migration/postcopy-tests.c    | 27 ++++++++++++
>  tests/qtest/migration/precopy-tests.c     | 28 ++++++++++++-
>  tests/qtest/migration/tls-tests.c         | 50 +++++++++++++++++++++++
>  4 files changed, 121 insertions(+), 2 deletions(-)
>
> v11:
> - pass 'postcopy_ram' variable as a function argument
>
> v10:
> - https://lore.kernel.org/qemu-devel/20250508122849.207213-2-ppandit@redhat.com/T/#t
>
> diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
> index 41e79f031b..b827665b8e 100644
> --- a/tests/qtest/migration/compression-tests.c
> +++ b/tests/qtest/migration/compression-tests.c
> @@ -42,6 +42,20 @@ static void test_multifd_tcp_zstd(void)
>      };
>      test_precopy_common(&args);
>  }
> +
> +static void test_multifd_postcopy_tcp_zstd(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "defer",
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +            .caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true,
> +        },
> +        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
> +    };
> +
> +    test_precopy_common(&args);
> +}
>  #endif /* CONFIG_ZSTD */
>
>  #ifdef CONFIG_QATZIP
> @@ -184,6 +198,10 @@ void migration_test_add_compression(MigrationTestEnv *env)
>  #ifdef CONFIG_ZSTD
>      migration_test_add("/migration/multifd/tcp/plain/zstd",
>                         test_multifd_tcp_zstd);
> +    if (env->has_uffd) {
> +        migration_test_add("/migration/multifd+postcopy/tcp/plain/zstd",
> +                           test_multifd_postcopy_tcp_zstd);
> +    }
>  #endif
>
>  #ifdef CONFIG_QATZIP
> diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
> index 483e3ff99f..eb637f94f7 100644
> --- a/tests/qtest/migration/postcopy-tests.c
> +++ b/tests/qtest/migration/postcopy-tests.c
> @@ -94,6 +94,29 @@ static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
>      }
>  }
>
> +static void test_multifd_postcopy(void)
> +{
> +    MigrateCommon args = {
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +        },
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
> +static void test_multifd_postcopy_preempt(void)
> +{
> +    MigrateCommon args = {
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
> +        },
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
>  void migration_test_add_postcopy(MigrationTestEnv *env)
>  {
>      migration_test_add_postcopy_smoke(env);
> @@ -114,6 +137,10 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
>              "/migration/postcopy/recovery/double-failures/reconnect",
>              test_postcopy_recovery_fail_reconnect);
>
> +        migration_test_add("/migration/postcopy/multifd/plain",
> +                           test_multifd_postcopy);
> +        migration_test_add("/migration/postcopy/multifd/preempt/plain",
> +                           test_multifd_postcopy_preempt);
>          if (env->is_x86) {
>              migration_test_add("/migration/postcopy/suspend",
>                                 test_postcopy_suspend);
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index 87b0a7e8ef..441a65bcf5 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -524,7 +524,7 @@ static void test_multifd_tcp_channels_none(void)
>   *
>   *  And see that it works
>   */
> -static void test_multifd_tcp_cancel(void)
> +static void test_multifd_tcp_cancel(bool postcopy_ram)
>  {
>      MigrateStart args = {
>          .hide_stderr = true,
> @@ -538,6 +538,11 @@ static void test_multifd_tcp_cancel(void)
>      migrate_ensure_non_converge(from);
>      migrate_prepare_for_dirty_mem(from);
>
> +    if (postcopy_ram) {
> +        migrate_set_capability(from, "postcopy-ram", true);
> +        migrate_set_capability(to, "postcopy-ram", true);
> +    }
> +
>      migrate_set_parameter_int(from, "multifd-channels", 16);
>      migrate_set_parameter_int(to, "multifd-channels", 16);
>
> @@ -579,6 +584,10 @@ static void test_multifd_tcp_cancel(void)
>          return;
>      }
>
> +    if (postcopy_ram) {
> +        migrate_set_capability(to2, "postcopy-ram", true);
> +    }
> +
>      migrate_set_parameter_int(to2, "multifd-channels", 16);
>
>      migrate_set_capability(to2, "multifd", true);
> @@ -602,6 +611,16 @@ static void test_multifd_tcp_cancel(void)
>      migrate_end(from, to2, true);
>  }
>
> +static void test_multifd_precopy_tcp_cancel(void)
> +{
> +    test_multifd_tcp_cancel(false);
> +}
> +
> +static void test_multifd_postcopy_tcp_cancel(void)
> +{
> +    test_multifd_tcp_cancel(true);
> +}
> +
>  static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
>                                           const char *uri, const char *phase)
>  {
> @@ -1188,7 +1207,12 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
>      migration_test_add("/migration/multifd/tcp/uri/plain/none",
>                         test_multifd_tcp_uri_none);
>      migration_test_add("/migration/multifd/tcp/plain/cancel",
> -                       test_multifd_tcp_cancel);
> +                       test_multifd_precopy_tcp_cancel);
> +    if (env->has_uffd) {
> +        migration_test_add("/migration/multifd+postcopy/tcp/plain/cancel",
> +                           test_multifd_postcopy_tcp_cancel);
> +    }
> +
>  #ifdef CONFIG_RDMA
>      migration_test_add("/migration/precopy/rdma/plain",
>                         test_precopy_rdma_plain);
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> index 72f44defbb..50a07a1c0f 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -395,6 +395,19 @@ static void test_postcopy_recovery_tls_psk(void)
>      test_postcopy_recovery_common(&args);
>  }
>
> +static void test_multifd_postcopy_recovery_tls_psk(void)
> +{
> +    MigrateCommon args = {
> +        .start_hook = migrate_hook_start_tls_psk_match,
> +        .end_hook = migrate_hook_end_tls_psk,
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +        },
> +    };
> +
> +    test_postcopy_recovery_common(&args);
> +}
> +
>  /* This contains preempt+recovery+tls test altogether */
>  static void test_postcopy_preempt_all(void)
>  {
> @@ -409,6 +422,20 @@ static void test_postcopy_preempt_all(void)
>      test_postcopy_recovery_common(&args);
>  }
>
> +static void test_multifd_postcopy_preempt_recovery_tls_psk(void)
> +{
> +    MigrateCommon args = {
> +        .start_hook = migrate_hook_start_tls_psk_match,
> +        .end_hook = migrate_hook_end_tls_psk,
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
> +        },
> +    };
> +
> +    test_postcopy_recovery_common(&args);
> +}
> +
>  static void test_precopy_unix_tls_psk(void)
>  {
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> @@ -657,6 +684,21 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
>      test_precopy_common(&args);
>  }
>
> +static void test_multifd_postcopy_tcp_tls_psk_match(void)
> +{
> +    MigrateCommon args = {
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +            .caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true,
> +        },
> +        .listen_uri = "defer",
> +        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
> +        .end_hook = migrate_hook_end_tls_psk,
> +    };
> +
> +    test_precopy_common(&args);
> +}
> +
>  #ifdef CONFIG_TASN1
>  static void test_multifd_tcp_tls_x509_default_host(void)
>  {
> @@ -774,6 +816,10 @@ void migration_test_add_tls(MigrationTestEnv *env)
>                             test_postcopy_preempt_tls_psk);
>          migration_test_add("/migration/postcopy/preempt/recovery/tls/psk",
>                             test_postcopy_preempt_all);
> +        migration_test_add("/migration/postcopy/multifd/recovery/tls/psk",
> +                           test_multifd_postcopy_recovery_tls_psk);
> +        migration_test_add("/migration/postcopy/multifd/preempt/recovery/tls/psk",
> +                           test_multifd_postcopy_preempt_recovery_tls_psk);
>      }
>  #ifdef CONFIG_TASN1
>      migration_test_add("/migration/precopy/unix/tls/x509/default-host",
> @@ -805,6 +851,10 @@ void migration_test_add_tls(MigrationTestEnv *env)
>                         test_multifd_tcp_tls_psk_match);
>      migration_test_add("/migration/multifd/tcp/tls/psk/mismatch",
>                         test_multifd_tcp_tls_psk_mismatch);
> +    if (env->has_uffd) {
> +        migration_test_add("/migration/multifd+postcopy/tcp/tls/psk/match",
> +                           test_multifd_postcopy_tcp_tls_psk_match);
> +    }
>  #ifdef CONFIG_TASN1
>      migration_test_add("/migration/multifd/tcp/tls/x509/default-host",
>                         test_multifd_tcp_tls_x509_default_host);
> --
> 2.49.0


* Ping...(this one needs an ack if all okay)

Thank you.
---
  - Prasad


