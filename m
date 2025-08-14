Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A356DCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 19:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umdtG-0004Fb-8M; Thu, 14 Aug 2025 15:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umdtE-0004FT-Ud
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 15:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umdtB-0004GL-S2
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 15:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755200726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SnTT0nA75EVP9VpV0XHR7um59ojRdJub7KbGoLuxAR4=;
 b=KB2c5RVJzpQgBT8SU4eKtxYOMEqpic0gDsQ93DzcBhDhBJ4lNM4+w27wZ0MkMgYqKuGZ/K
 p5JDfys1I25RujLQBSr7HUL8ofd+Gu9kqYX4eHTqgSBKKj1gqCqwHai5mcEo0mPmy/Nk5v
 Xsxa8hddcoXFzq1tFlNfKsBcyawAhRo=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-GTmjRWAIONCFlSXMZKOSbw-1; Thu, 14 Aug 2025 15:45:24 -0400
X-MC-Unique: GTmjRWAIONCFlSXMZKOSbw-1
X-Mimecast-MFC-AGG-ID: GTmjRWAIONCFlSXMZKOSbw_1755200724
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e932cbe5410so352466276.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 12:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755200724; x=1755805524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnTT0nA75EVP9VpV0XHR7um59ojRdJub7KbGoLuxAR4=;
 b=qne0papR7My210JorSA/NvskqumWHGpQ5mAQPZaw2/A9toWPXmhORuGTzPZs4uO9eN
 EZmgN7aiM+MvJJBvmNXz4uwOYeAyaywbGBhGT3/TYX9FthaZ93HyvgCLH6B4droMfF9G
 IC+EtmcLLKDeM2ueZGiqBuBZQxQ6N6qctO9dGX9CAlWnh8BAoHfJvyfiKkMccVBWGkbX
 MwYCAtg29EFz5nk91Yoz2TdnVnk/Sel7SRRhYr3N4rEKt1C0ojKptfJJ/ciBKkw0pvz5
 XaKZkzpgPmXSrySussFJoUCQQOckXGTmouY2JWtqOSrh6vCF9+Mejnu+dzHfRElFsl7W
 vKMA==
X-Gm-Message-State: AOJu0Yxz+zkH3XCuZfU5VNOimn254nbJPKgTxKbUDd2o+Kd/SDylCeyC
 Tkn0CxQlmhwlU2Is6uka4nfgDo+/yA+4+SN9Uti3QVoOJKzkdsFn87Nx4mDiQUntWugQsuXcpff
 QXYPNO9tM/xs0efNI7lyEcd1kGe7xA1x60UMCidVns0JB5Hh1LHURmyny
X-Gm-Gg: ASbGncvnrNeXlrOLIl1JlT2waci4DlMWj+lE4X9VaW1mEC+BVwx3NFiJ/Pa+mcrolt6
 52sNLaMJ/FDstozO3cLriap/SJf0L2YZKCn7DtfsIdJTzVxHV+Y2K3kuGncA692SY6OfRynxfEF
 1dFqTIhvZqlWuK+NNJfwcd+CsbyiHoviBHVWbkxUt1v1OT1tLyOtcdCYSt7qc2Mbfthg6odW7NL
 l6qvusPclX7l26F00CDnSgL1I/z7ro49gbRdC4hg3BNP7jr5FYwxyEb7BG6pXJfdnKEfEt/gzDP
 GbdhPIToaTdMqQEv2bvVplo00gmdA2h1WocBa2onyTGHijgHaajiKrlKLt4PQ5redOqOpm/aCy1
 k2rw9VStcR1+AfSkKDJxKzg==
X-Received: by 2002:a05:6902:6c02:b0:e90:58b3:640c with SMTP id
 3f1490d57ef6-e931e14cc85mr4756601276.11.1755200724022; 
 Thu, 14 Aug 2025 12:45:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXJlXUrpjtoZUR5GexO271ZHMR/xFdyPvucUVnVdCKV4h1292UmAhwulkR3m0ZA84MchAR/g==
X-Received: by 2002:a05:6902:6c02:b0:e90:58b3:640c with SMTP id
 3f1490d57ef6-e931e14cc85mr4756577276.11.1755200723613; 
 Thu, 14 Aug 2025 12:45:23 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e931d41e903sm866622276.7.2025.08.14.12.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 12:45:22 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:45:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 24/24] tests/qtest/migration: Pass the migration
 config to file tests
Message-ID: <aJ48ygDqoxFImt_M@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-25-farosas@suse.de>
 <aJ3xuGRnd0mHSlxp@x1.local> <87tt29zzt3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tt29zzt3.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Aug 14, 2025 at 12:30:00PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jun 30, 2025 at 04:59:13PM -0300, Fabiano Rosas wrote:
> >> Use the existing file tests to test the new way of passing parameters
> >> to the migration via the config argument to qmp_migrate*.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  tests/qtest/migration/file-tests.c    | 68 +++++++++++----------------
> >>  tests/qtest/migration/framework.c     |  9 ++--
> >>  tests/qtest/migration/precopy-tests.c |  1 +
> >>  3 files changed, 34 insertions(+), 44 deletions(-)
> >> 
> >> diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
> >> index 4d78ce0855..656d6527e8 100644
> >> --- a/tests/qtest/migration/file-tests.c
> >> +++ b/tests/qtest/migration/file-tests.c
> >> @@ -27,6 +27,7 @@ static void test_precopy_file(void)
> >>      MigrateCommon args = {
> >>          .connect_uri = uri,
> >>          .listen_uri = "defer",
> >> +        .start.config = qdict_new(),
> >>      };
> >>  
> >>      test_file_common(&args, true);
> >> @@ -74,6 +75,7 @@ static void test_precopy_file_offset_fdset(void)
> >>          .connect_uri = uri,
> >>          .listen_uri = "defer",
> >>          .start_hook = migrate_hook_start_file_offset_fdset,
> >> +        .start.config = qdict_new(),
> >>      };
> >>  
> >>      test_file_common(&args, false);
> >> @@ -88,6 +90,7 @@ static void test_precopy_file_offset(void)
> >>      MigrateCommon args = {
> >>          .connect_uri = uri,
> >>          .listen_uri = "defer",
> >> +        .start.config = qdict_new(),
> >>      };
> >>  
> >>      test_file_common(&args, false);
> >> @@ -102,6 +105,7 @@ static void test_precopy_file_offset_bad(void)
> >>          .connect_uri = uri,
> >>          .listen_uri = "defer",
> >>          .result = MIG_TEST_QMP_ERROR,
> >> +        .start.config = qdict_new(),
> >>      };
> >>  
> >>      test_file_common(&args, false);
> >> @@ -114,11 +118,10 @@ static void test_precopy_file_mapped_ram_live(void)
> >>      MigrateCommon args = {
> >>          .connect_uri = uri,
> >>          .listen_uri = "defer",
> >> -        .start = {
> >> -            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> >> -        },
> >> +        .start.config = qdict_new(),
> >>      };
> >>  
> >> +    qdict_put_bool(args.start.config, "mapped-ram", true);
> >>      test_file_common(&args, false);
> >>  }
> >>  
> >> @@ -129,11 +132,9 @@ static void test_precopy_file_mapped_ram(void)
> >>      MigrateCommon args = {
> >>          .connect_uri = uri,
> >>          .listen_uri = "defer",
> >> -        .start = {
> >> -            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> >> -        },
> >> +        .start.config = qdict_new(),
> >>      };
> >> -
> >> +    qdict_put_bool(args.start.config, "mapped-ram", true);
> >>      test_file_common(&args, true);
> >>  }
> >>  
> >> @@ -144,12 +145,11 @@ static void test_multifd_file_mapped_ram_live(void)
> >>      MigrateCommon args = {
> >>          .connect_uri = uri,
> >>          .listen_uri = "defer",
> >> -        .start = {
> >> -            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> >> -            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> >> -        },
> >> +        .start.config = qdict_new(),
> >>      };
> >>  
> >> +    qdict_put_bool(args.start.config, "mapped-ram", true);
> >> +    qdict_put_bool(args.start.config, "multifd", true);
> >>      test_file_common(&args, false);
> >>  }
> >>  
> >> @@ -160,24 +160,13 @@ static void test_multifd_file_mapped_ram(void)
> >>      MigrateCommon args = {
> >>          .connect_uri = uri,
> >>          .listen_uri = "defer",
> >> -        .start = {
> >> -            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> >> -            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> >> -        },
> >> +        .start.config = qdict_new(),
> >>      };
> >> -
> >> +    qdict_put_bool(args.start.config, "mapped-ram", true);
> >> +    qdict_put_bool(args.start.config, "multifd", true);
> >>      test_file_common(&args, true);
> >>  }
> >>  
> >> -static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
> >> -                                                       QTestState *to)
> >> -{
> >> -    migrate_set_parameter_bool(from, "direct-io", true);
> >> -    migrate_set_parameter_bool(to, "direct-io", true);
> >> -
> >> -    return NULL;
> >> -}
> >> -
> >>  static void test_multifd_file_mapped_ram_dio(void)
> >>  {
> >>      g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> >> @@ -185,13 +174,13 @@ static void test_multifd_file_mapped_ram_dio(void)
> >>      MigrateCommon args = {
> >>          .connect_uri = uri,
> >>          .listen_uri = "defer",
> >> -        .start_hook = migrate_hook_start_multifd_mapped_ram_dio,
> >> -        .start = {
> >> -            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> >> -            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> >> -        },
> >> +        .start.config = qdict_new(),
> >>      };
> >>  
> >> +    qdict_put_bool(args.start.config, "direct-io", true);
> >
> > So the start_hook doesn't take args so we need to duplicate all these
> > direct-io setups in each test.. I assume not a big deal so it's fine, but
> > this is slightly going backward for sure..
> >
> 
> I'm not sure it is. Having to go follow the hooks is confusing,
> specially when hook names start to get similar. Having the test provide
> everything it needs right here is clearer. Also, maintenance of the
> hooks is a pain when it comes to code conflicts. I'd like to see less
> hooks overall.

IMHO it depends.  If a hook can greatly dedup code, then I'll go for it.

This one only contains a dio setup, definitely not a huge deal.

> 
> > What's your plan in mind on the tests?  Looks like you want to keep both
> > ways in tests/, only use it in some tests to cover both paths (and you
> > chose file-tests to start testing config)?  Or is this only an example and
> > you plan to convert more?
> >
> 
> Yes the idea is to cover both paths and I chose file-tests for config
> arbitrarily.

But then file-tests lose the old coverage on using migrate-set-*.

IMHO, we could choose one that will be the officially suggested way, then
let all tests to use it.  With that, we can duplicate one or a few tests to
cover the not-suggested way.

So if "config" is the suggested way, we could make all tests moving over to
"config", then add only one or a few tests to cover migrate-set-parameters?

-- 
Peter Xu


