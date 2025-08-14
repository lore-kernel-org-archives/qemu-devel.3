Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0666DCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 14:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umYtO-0004ty-MN; Thu, 14 Aug 2025 10:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umYtM-0004sq-2d
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 10:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umYtH-0003Z6-MJ
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 10:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755181511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UDSDRm1UexMF94Ja0vgLmh7MMNKJ/RyCPpnDbGwUEjo=;
 b=Iq/JIEaQ4xljXfXsZcBeufS0K9R3Q7aortODa7f9j9nG+ejWalBpkJrFSiJ66qOZtYw7Mj
 cjKG3xW2iIc3Gz/TRDV3JuK4wk5rtBcafk2baVmyebnXshRqN7aty4V7sPWefo9bP/7FiW
 +SKNPyrKDbtD+V6JbNUd6ONWJ2NNbQw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-m45Ame8NPKqEmzYjSrMVwA-1; Thu, 14 Aug 2025 10:25:10 -0400
X-MC-Unique: m45Ame8NPKqEmzYjSrMVwA-1
X-Mimecast-MFC-AGG-ID: m45Ame8NPKqEmzYjSrMVwA_1755181510
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-70a9f5b3601so23923596d6.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 07:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755181510; x=1755786310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDSDRm1UexMF94Ja0vgLmh7MMNKJ/RyCPpnDbGwUEjo=;
 b=O8YI6l/42rK+ccC9NfkrVq10x4UhcDLbXxM1mdQKA1GQKE/mqhvAeCNNi2XmZwUIxG
 P6XdHGE9FekZhoi6yeMz23wp5fs/fe5+uIEOt269I/zYXBHsz3iBKSbzaATXkM1OQFeS
 apRQRiNJOpBds+bICwY9U8Mt5kPPSrs8juVWhejYyH3VQXkBp5GqJ7RrBPpKYsofL1yj
 gml5WgJs1Z24SM6we8m7DKI1yhO9WLjQHuV03OvzKut5zDke5kJ3jX87bcteaZ2Enef1
 dxWglkz52Rk9lqcEkEJdd69S1EFpJmd87HohVtka8wYch03iUfwIvuqIyT0kHvkrAEs/
 EH7A==
X-Gm-Message-State: AOJu0YzLg5wqUuaoYtQMQFmcswXRabEjkvNlwzE8byXYdzJ8loO+G1Kb
 Lc9Va6exnGc/GOfxoW6L+7QfOJOG/Dc50tbAfv4tz4BrkhZXFxx6fxsHgC+ZsNCL6MMDVtILgXr
 LHMvrM5ept8u+nzv92/mbrr+5Hw3eEFwIZGFlj+ZswwOSRavR803Pb8Jx
X-Gm-Gg: ASbGncsHRG1Cw1moLiSXq7fsiq6Et3VyxL/E4mDMGZ2DbVbiKuo87hACZ76KIH8c9yt
 R7fuH+FL5YZ4dWlAR0BudGR2zacEWPIL5ButT9XNXzcUtJrQiQ2A9lsqVAJdVQ+LXUCEyW5NTjA
 xULmhjO9sWNLxbBrB7DbcQ6VdMWLuWK/ugawrbQliHC4Aqj4JGdOMopTU703iFYY4hoOMSY01tW
 HVTMvz9v4R6Yqj1z9bmWQbuXm2gRhnY2BSGsnmswxOzHtd8Qa4wz1E4NOUCrAJyBbG5GD3KiTN1
 WroGNsmMV+5TPkARbgUltpViCkYy/2Ev
X-Received: by 2002:a05:622a:1f13:b0:4b0:7e8c:64cd with SMTP id
 d75a77b69052e-4b10a9583f1mr50444231cf.4.1755181509585; 
 Thu, 14 Aug 2025 07:25:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAm+h5iCpUc/72TT88nT4wiPP2Z18aOolmygn9QLhjnuFP1tZz+N2xRUiDT6Q7n5IkWp/auw==
X-Received: by 2002:a05:622a:1f13:b0:4b0:7e8c:64cd with SMTP id
 d75a77b69052e-4b10a9583f1mr50443621cf.4.1755181509030; 
 Thu, 14 Aug 2025 07:25:09 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b07e8ccb6asm137830621cf.24.2025.08.14.07.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 07:25:08 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:24:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 24/24] tests/qtest/migration: Pass the migration
 config to file tests
Message-ID: <aJ3xuGRnd0mHSlxp@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-25-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-25-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 30, 2025 at 04:59:13PM -0300, Fabiano Rosas wrote:
> Use the existing file tests to test the new way of passing parameters
> to the migration via the config argument to qmp_migrate*.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/file-tests.c    | 68 +++++++++++----------------
>  tests/qtest/migration/framework.c     |  9 ++--
>  tests/qtest/migration/precopy-tests.c |  1 +
>  3 files changed, 34 insertions(+), 44 deletions(-)
> 
> diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
> index 4d78ce0855..656d6527e8 100644
> --- a/tests/qtest/migration/file-tests.c
> +++ b/tests/qtest/migration/file-tests.c
> @@ -27,6 +27,7 @@ static void test_precopy_file(void)
>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> +        .start.config = qdict_new(),
>      };
>  
>      test_file_common(&args, true);
> @@ -74,6 +75,7 @@ static void test_precopy_file_offset_fdset(void)
>          .connect_uri = uri,
>          .listen_uri = "defer",
>          .start_hook = migrate_hook_start_file_offset_fdset,
> +        .start.config = qdict_new(),
>      };
>  
>      test_file_common(&args, false);
> @@ -88,6 +90,7 @@ static void test_precopy_file_offset(void)
>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> +        .start.config = qdict_new(),
>      };
>  
>      test_file_common(&args, false);
> @@ -102,6 +105,7 @@ static void test_precopy_file_offset_bad(void)
>          .connect_uri = uri,
>          .listen_uri = "defer",
>          .result = MIG_TEST_QMP_ERROR,
> +        .start.config = qdict_new(),
>      };
>  
>      test_file_common(&args, false);
> @@ -114,11 +118,10 @@ static void test_precopy_file_mapped_ram_live(void)
>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> -        .start = {
> -            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> -        },
> +        .start.config = qdict_new(),
>      };
>  
> +    qdict_put_bool(args.start.config, "mapped-ram", true);
>      test_file_common(&args, false);
>  }
>  
> @@ -129,11 +132,9 @@ static void test_precopy_file_mapped_ram(void)
>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> -        .start = {
> -            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> -        },
> +        .start.config = qdict_new(),
>      };
> -
> +    qdict_put_bool(args.start.config, "mapped-ram", true);
>      test_file_common(&args, true);
>  }
>  
> @@ -144,12 +145,11 @@ static void test_multifd_file_mapped_ram_live(void)
>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> -        .start = {
> -            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> -            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> -        },
> +        .start.config = qdict_new(),
>      };
>  
> +    qdict_put_bool(args.start.config, "mapped-ram", true);
> +    qdict_put_bool(args.start.config, "multifd", true);
>      test_file_common(&args, false);
>  }
>  
> @@ -160,24 +160,13 @@ static void test_multifd_file_mapped_ram(void)
>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> -        .start = {
> -            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> -            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> -        },
> +        .start.config = qdict_new(),
>      };
> -
> +    qdict_put_bool(args.start.config, "mapped-ram", true);
> +    qdict_put_bool(args.start.config, "multifd", true);
>      test_file_common(&args, true);
>  }
>  
> -static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
> -                                                       QTestState *to)
> -{
> -    migrate_set_parameter_bool(from, "direct-io", true);
> -    migrate_set_parameter_bool(to, "direct-io", true);
> -
> -    return NULL;
> -}
> -
>  static void test_multifd_file_mapped_ram_dio(void)
>  {
>      g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> @@ -185,13 +174,13 @@ static void test_multifd_file_mapped_ram_dio(void)
>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> -        .start_hook = migrate_hook_start_multifd_mapped_ram_dio,
> -        .start = {
> -            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> -            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> -        },
> +        .start.config = qdict_new(),
>      };
>  
> +    qdict_put_bool(args.start.config, "direct-io", true);

So the start_hook doesn't take args so we need to duplicate all these
direct-io setups in each test.. I assume not a big deal so it's fine, but
this is slightly going backward for sure..

What's your plan in mind on the tests?  Looks like you want to keep both
ways in tests/, only use it in some tests to cover both paths (and you
chose file-tests to start testing config)?  Or is this only an example and
you plan to convert more?

> +    qdict_put_bool(args.start.config, "mapped-ram", true);
> +    qdict_put_bool(args.start.config, "multifd", true);
> +
>      if (!probe_o_direct_support(tmpfs)) {
>          g_test_skip("Filesystem does not support O_DIRECT");
>          return;
> @@ -235,9 +224,6 @@ static void *migrate_hook_start_multifd_mapped_ram_fdset_dio(QTestState *from,
>      fdset_add_fds(from, file, O_WRONLY, 2, true);
>      fdset_add_fds(to, file, O_RDONLY, 2, true);
>  
> -    migrate_set_parameter_bool(from, "direct-io", true);
> -    migrate_set_parameter_bool(to, "direct-io", true);
> -
>      return NULL;
>  }
>  
> @@ -261,12 +247,11 @@ static void test_multifd_file_mapped_ram_fdset(void)
>          .listen_uri = "defer",
>          .start_hook = migrate_hook_start_multifd_mapped_ram_fdset,
>          .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
> -        .start = {
> -            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> -            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> -        },
> +        .start.config = qdict_new(),
>      };
>  
> +    qdict_put_bool(args.start.config, "mapped-ram", true);
> +    qdict_put_bool(args.start.config, "multifd", true);
>      test_file_common(&args, true);
>  }
>  
> @@ -279,12 +264,13 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
>          .listen_uri = "defer",
>          .start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio,
>          .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
> -        .start = {
> -            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> -            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> -        },
> +        .start.config = qdict_new(),
>      };
>  
> +    qdict_put_bool(args.start.config, "direct-io", true);
> +    qdict_put_bool(args.start.config, "mapped-ram", true);
> +    qdict_put_bool(args.start.config, "multifd", true);
> +
>      if (!probe_o_direct_support(tmpfs)) {
>          g_test_skip("Filesystem does not support O_DIRECT");
>          return;
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 5025299d6a..37c5c884af 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -974,18 +974,21 @@ void test_file_common(MigrateCommon *args, bool stop_src)
>      }
>  
>      if (args->result == MIG_TEST_QMP_ERROR) {
> -        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
> +        migrate_qmp_fail(from, args->connect_uri, NULL, "{ 'config': %p }",
> +                         args->start.config);
>          goto finish;
>      }
>  
> -    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
> +    migrate_qmp(from, to, args->connect_uri, NULL, "{ 'config': %p }",
> +                args->start.config);
>      wait_for_migration_complete(from);
>  
>      /*
>       * We need to wait for the source to finish before starting the
>       * destination.
>       */
> -    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
> +    migrate_incoming_qmp(to, args->connect_uri, NULL, "{ 'config': %p }",
> +                         args->start.config);
>      wait_for_migration_complete(to);
>  
>      if (stop_src) {
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index 35d4274c69..9606dc1d02 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -338,6 +338,7 @@ static void test_precopy_fd_file(void)
>          .connect_uri = "fd:fd-mig",
>          .start_hook = migrate_hook_start_precopy_fd_file,
>          .end_hook = migrate_hook_end_fd,
> +        .start.config = qdict_new(),
>      };
>      test_file_common(&args, true);
>  }
> -- 
> 2.35.3
> 

-- 
Peter Xu


