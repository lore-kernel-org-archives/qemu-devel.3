Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF5DD65C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 17:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVus4-0000RY-G7; Wed, 17 Dec 2025 11:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVuro-0000Pz-Nb
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 11:59:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVurg-0001Yx-08
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 11:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765990740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JtnffbRcE3rVRpv3UpQHKArvVowjPkrE3mk2NdTqvXI=;
 b=fusVuf/kr5r2eRWLus/ojrZB2c1Q1WIyjY4weQUUYR3vDMxbVmj/jvcRcShUvSyFwF2ICD
 ajBKO5H+L0//KuWEEHRx3dTEXm9ZyR4yl5hw5Pa4wwkFAMABuOb3hfU448NBimKTJ3CmHh
 Jm2FE8B90MtRP1LRygvp3beFUAHvMng=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-2BhyxofOOi24AS6dawBHTw-1; Wed, 17 Dec 2025 11:58:59 -0500
X-MC-Unique: 2BhyxofOOi24AS6dawBHTw-1
X-Mimecast-MFC-AGG-ID: 2BhyxofOOi24AS6dawBHTw_1765990738
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7b9321b9312so11966753b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 08:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765990738; x=1766595538; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JtnffbRcE3rVRpv3UpQHKArvVowjPkrE3mk2NdTqvXI=;
 b=Yo5ke+gOILxw8T5Pch1LxY/jeBRHXMl2EDfx/J3SJo7908RGqzvToF7WofL0ihHGx2
 RtMI/6pE2cBajR0wF8Qhf7KYirBsYbIByFjyLJSsz8F1Kfnpuzzb+e/XWp1IdId+Xwby
 67oCUUAYV3nRQLs3PHiymNfpY+1gA/pV5VtDP+CpW6NhlweVQ/ZoXQUNnJOQ6Aw1BRMw
 5OYPXmShufxC0dGYHZhCh6MeS8yf+bX+etTeaV10zcd+Dp2em6AqPzLvGFGa5nF/RKcs
 G1f5IE2LEHxdNZwkHMqcuXtHfiOy390fE5DU9aM8J68eWtQ8k9mPa/0xyycl/QcOAHeF
 3Lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765990738; x=1766595538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtnffbRcE3rVRpv3UpQHKArvVowjPkrE3mk2NdTqvXI=;
 b=WLW3nGxi0E8EwecjQzJjn7MEBknbYmhgkPE5ddx2pkr2O0SO5JSbhIpI3YWWIJSatI
 bn6OV7v/eNs+UlQDM2/cEQjYqcVHKW/xaij5Sr75ZQ67hsBv66a/LoGOnic10zPLwaDC
 mRoxBkm6tRbtoT0u0N3HG9R3ITLN8fncXYc7+v0WSjhYajLgxTLNKZrK0HxKzCixSn4J
 90gS8VDUuYGZLqpWoDBh+bxBeOHYr/bvN7I5H1pU3la6JVzlIrPqLIJc/+ivyFrJHegs
 ShbVR4agulIhLfDpdLN06u6f/LcjGqH6VYDq1OI3+3pWOgtN5fgnS3iNvhtkIyKJUKzg
 qJLA==
X-Gm-Message-State: AOJu0Yw/Hf5GdKbmRxqufFyGRaRbv6PR0owIYgAsS8uqaRU4Efu/807k
 G5bQFCvB7Df09jWP/0oIFFUUm6h/iM8RJI/UOsgCZeMAIjzb2B780HqI3W/70YgwODxfxe8Nbvo
 4RBxDro1AUIR/i4esBHW1Z1Q5Nu4ggOmrJxCDnMIS4Gm0TQyxRBLyAQ1k
X-Gm-Gg: AY/fxX6cYgApOL35ClxHOr27/qK6sSYg9p8BQQg1czwY3NC7cEBvI/Mo85JziKc23/t
 R9BonnH2qPnnQoA92pF5BlrTdPSejJHXs+3LaJYPs81iyvU/GulPKSiG0kG4IK+VdN4pVhLHQy4
 zuzClMGpontwsBUrwGPJCQPSp/cMlzNBVBXaecFgsTr4LDbTVJGnv8f7MGeUxDOO1WSWHkpAjHc
 5Ws0EBM1jH/JE6DdKObHHj9/tFxbXmFe12VhXaMjyGV6dfZtn9Y/AWfsTJEBDZ20Sxacy1l1QHa
 Hktav26sjVxavzAxvxk3tWrz6SB/uR9RwUmuffK/oS4uYO5tFL2IykHvUTvSX2rSFEOrVpSaD0R
 LZ9w=
X-Received: by 2002:a05:6a00:340b:b0:7f1:4:66b with SMTP id
 d2e1a72fcca58-7f6692aae7cmr16558404b3a.44.1765990737804; 
 Wed, 17 Dec 2025 08:58:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERUFr1qz7nZfxHzLPB/D/jiXxFU4N1I0ouIi42E5VglrlxvM3DPFW3fnuB+8X2EsrE6Vf3aw==
X-Received: by 2002:a05:6a00:340b:b0:7f1:4:66b with SMTP id
 d2e1a72fcca58-7f6692aae7cmr16558387b3a.44.1765990737394; 
 Wed, 17 Dec 2025 08:58:57 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fe12316e60sm7313b3a.30.2025.12.17.08.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 08:58:56 -0800 (PST)
Date: Wed, 17 Dec 2025 11:58:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v3 00/51] migration: Unify capabilities and parameters
Message-ID: <aULhSxy3sm_k_43j@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Dec 15, 2025 at 06:59:46PM -0300, Fabiano Rosas wrote:
> Hi, the scope of this series is the same as the previous versions, but
> to be explicit, these are various parts of which it's comprised:
> 
> 1) Remove duplication of migration parameters documentation in
>    migration.json.
> 
> 2) Merge migration capabilities and parameters in MigrationState (as
>    visible internally in migration code).
> 
> 3) Deprecate migration capabilities QMP commands. Functionality
>    previously provided by "capabilities" commands are now provided by
>    "parameters" commands.
> 
> 4) Introduce new 'config' argument to migration commands taking the
>    entire set of options to use for a migration. Obsoletes the usage
>    of migrate-set-parameters, except for "runtime" options, which are
>    as of yet uncovered by this proposal.
> 
> 5) Adapt all migration-test(s) to use the new config API exclusively.
> 
> Notable changes in this v3:
> 
> - Added the setter for the new StrOrNull qdev property
> - Move the visitor code into a new QAPI_MERGE macro
> - Converted all tests to use config
>   - Unfortunate side-quest: rework the TLS test hooks to support
>     setting options before migrate_start.
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2216127826
> 
> v2:
> https://lore.kernel.org/r/20250630195913.28033-1-farosas@suse.de
> 
> v1:
> https://lore.kernel.org/r/20250603013810.4772-1-farosas@suse.de
> 
> RFC:
> https://lore.kernel.org/r/20250411191443.22565-1-farosas@suse.de
> 
> Fabiano Rosas (51):
>   migration: Fix leak of block_bitmap_mapping
>   migration: Fix leak of cpr_exec_command
>   migration: Add a qdev property for StrOrNull
>   tests/qtest/migration: Add a NULL parameters test for TLS
>   migration: Normalize tls arguments
>   migration: Remove MigrateSetParameters
>   qapi/migration: Don't document MigrationParameter
>   migration: Run a post update routine after setting parameters
>   migration: Add a flag to track block-bitmap-mapping input
>   migration: Remove checks for s->parameters has_* fields
>   migration: Do away with usage of QERR_INVALID_PARAMETER_VALUE
>   migration: Extract code to mark all parameters as present
>   migration: Use QAPI_CLONE_MEMBERS in query_migrate_parameters
>   migration: Use QAPI_CLONE_MEMBERS in migrate_params_test_apply
>   migration: Use QAPI_CLONE_MEMBERS in migrate_params_apply
>   qapi: Add QAPI_MERGE
>   migration: Use QAPI_MERGE in migrate_params_test_apply
>   migration: Cleanup hmp_info_migrate_parameters
>   migration: Add capabilities into MigrationParameters
>   migration: Remove s->capabilities
>   qapi/migration: Deprecate capabilities commands
>   migration: Store the initial values used for s->parameters
>   migration: Allow migrate commands to provide the migration config
>   migration: Allow incoming cmdline to take config
>   tests/qtest/migration: Pass MigrateCommon into test functions
>   tests/qtest/migration: Pass MigrateStart into cancel tests
>   tests/qtest/migration: Fix misuse of listen_uri
>   tests/qtest/migration: Stop invoking migrate_incoming from hooks
>   tests/qtest/migration: Add config QDict
>   tests/qtest/migration: Add temporary code to toggle usage of config
>   tests/qtest/migration: Add a function for default capabilities
>   tests/qtest/migration: Adapt convergence routines to config
>   tests/qtest/migration: Adapt the incoming cmdline for config passing
>   tests/qtest/migration: Use migrate_incoming_qmp where possible
>   tests/qtest/migration: Add a config parameter to migrate_qmp functions
>   tests/qtest/migration: Move tls hook data out of specific hooks
>   tests/qtest/migration: Add new hook with data
>   tests/qtest/migration: TLS x509: Refactor to use full hook
>   tests/qtest/migration: TLS x509: Add init/cleanup routines
>   tests/qtest/migration: TLS PSK: Refactor to use full hook
>   tests/qtest/migration: TLS PSK: Add init/cleanup routines
>   tests/qtest/migration: Remove multifd compression hook
>   tests/qtest/migration: Convert postcopy tests to use config
>   tests/qtest/migration: Convert TLS PSK tests to use config
>   tests/qtest/migration: Convert TLS x509 tests to use config
>   tests/qtest/migration: Convert compression tests to use config
>   tests/qtest/migration: Convert file tests to use config
>   tests/qtest/migration: Convert misc-tests to use config
>   tests/qtest/migration: Convert precopy tests to use config
>   tests/qtest/migration: Remove migrate_set_capabilities and code around
>     it
>   tests/qtest/migration: Further simplify TLS tests

I'll keep reviewing the rest test changes.. while I've queued patches
1-13,25,26 for the upcoming pull for qemu 11.0.  Please shoot if there's
any concerns.

Thanks,

-- 
Peter Xu


