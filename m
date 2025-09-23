Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825FECAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 07:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0xPC-0000hj-7L; Tue, 23 Sep 2025 03:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1v0xP9-0000gx-R9; Tue, 23 Sep 2025 03:25:39 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1v0xP5-0001wl-6B; Tue, 23 Sep 2025 03:25:39 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EE426024F;
 Tue, 23 Sep 2025 07:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D119CC4CEF5;
 Tue, 23 Sep 2025 07:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758612331;
 bh=ErA4ZnhIUPnLuQEf7eYx7WieikbzY8xi3ZdBJ5ztKn4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pvvuy0ldshjDS6WUE0Z9QTAE9UD8QQ4rvtdin13wYaAQkjH7tLtNeTUOj6KFygFny
 OW6G/v5btMGPBZYroxO375K9X1oQUm6vCWt7iobm6m33xLfCrprrBTFqpyp7DC4vq1
 PTQ2uv5Oj+wi7j69a6sLDEBAK7yJbeFVyPkz6F7TnrgRiN/o10Rz5nutc/XxjcEYzF
 5q2hEtzMJTji06KzZLaPbTVj3BLsqueg7dD6dtJeSqGoW9J6rgpqBhYvpYRXCp7b+h
 IRgIhBCzBLH670x2Tr+j7+Kdz+pDFniOkKeA0wpgBlDp2R63Jd7xZbOnQIDquva/X+
 hY1IYly9aBhUQ==
Date: Tue, 23 Sep 2025 09:25:27 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v12 00/17] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250923092527.3fd43e44@foz.lan>
In-Reply-To: <cover.1758610789.git.mchehab+huawei@kernel.org>
References: <cover.1758610789.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Em Tue, 23 Sep 2025 09:03:54 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Hi Michael,
> 
> This is v11 of the patch series, rebased to apply after release
> 10.1. Just like v1, the difference against v10 is a minor conflict
> resolution.
> 
> Please apply as soon as possible to avoid new conflicts.

Dah, I forgot to update this comments... this is v12, addressing
your review from v11 - and sent with my venerable mailbomb script
that doesn't mangle patches.

I rebased today in the top of current upstream. So far, no
conflicts, but as it touches DSDT table and backward-compatible
logic, it is still wise to have it applied earlier than later.

> 
> Thanks!
> 
> -
> 
> As ghes_record_cper_errors() was written since the beginning
> to be public and used by ghes-cper.c. It ended being meged
> earlier because the error-injection series become too big,
> so it was decided last year to split in two to make easier for
> reviewers and maintainers to discuss.
> 
> This series change the way HEST table offsets are calculated,
> making them identical to what an OSPM would do and allowing
> multiple HEST entries without causing migration issues. It open
> space to add HEST support for non-arm architectures, as now
> the number and type of HEST notification entries are not
> hardcoded at ghes.c. Instead, they're passed as a parameter
> from the arch-dependent init code.
> 
> With such issue addressed, it adds a new notification type and
> add support to inject errors via a Python script. The script
> itself is at the final patch.
> 
> ---
> v12:
> - some descriptions changed verbal tense to imperative;
> - since updated at acpi-hest.json;
> - added a g_free at qmp_inject_ghes_v2_error() and fixed coding style;
> - fixed NOTIFIER_LIST_INITIALIZER() parameter;
> - changed a patch description with a diff on it to avoid issues with
>   git am.
> 
> v11:
> - rebased on the top of current upstream:
>   baa79455fa92 ("Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging")
> - backward-compatibility logic moved to version 10.1;
> - BIOS test tables re-generated, as DSDT tables changed on 10.0;
> - added a missing SPDX tag on a new file.
> 
> 
> v10:
> - rebased on the top of current upstream:
>   d9ce74873a6a ("Merge tag 'pull-vfio-20250611' of https://github.com/legoater/qemu into staging")
> - solved a minor conflict
> 
> v9:
> - backward compatibility logic moved to version 10.0;
> - fixed a compilation issue with target/arm/kvm.c (probably
>   caused by some rebase - funny enough, incremental 
>   compilation was fine here);
> - added two missing SPDX comments.
> 
> v8:
>   - added a patch to revert recently-added changeset causing a
>     conflict with these. All remaining patches are identical.
> 
> v7:
>   - minor editorial change at the patch updating HEST doc spec
>    with the new workflow
> 
> v6:
> - some minor nits addressed:
>    - use GPA instead of offset;
>    - merged two patches;
>    - fixed a couple of long line coding style issues;
>    - the HEST/DSDT diff inside a patch was changed to avoid troubles
>      applying it.
> 
> v5:
> - make checkpatch happier;
> - HEST table is now tested;
> - some changes at HEST spec documentation to align with code changes;
> - extra care was taken with regards to git bisectability.
> 
> v4:
> - added an extra comment for AcpiGhesState structure;
> - patches reordered;
> - no functional changes, just code shift between the patches in this series.
> 
> v3:
> - addressed more nits;
> - hest_add_le now points to the beginning of HEST table;
> - removed HEST from tests/data/acpi;
> - added an extra patch to not use fw_cfg with virt-10.0 for hw_error_le
> 
> v2:
> - address some nits;
> - improved ags cleanup patch and removed ags.present field;
> - added some missing le*_to_cpu() calls;
> - update date at copyright for new files to 2024-2025;
> - qmp command changed to: inject-ghes-v2-error ans since updated to 10.0;
> - added HEST and DSDT tables after the changes to make check target happy.
>   (two patches: first one whitelisting such tables; second one removing from
>    whitelist and updating/adding such tables to tests/data/acpi)
> 
> Mauro Carvalho Chehab (17):
>   Revert "hw/acpi/ghes: Make ghes_record_cper_errors() static"
>   acpi/ghes: Cleanup the code which gets ghes ged state
>   acpi/ghes: prepare to change the way HEST offsets are calculated
>   acpi/ghes: add a firmware file with HEST address
>   acpi/ghes: Use HEST table offsets when preparing GHES records
>   acpi/ghes: don't hard-code the number of sources for HEST table
>   acpi/ghes: add a notifier to notify when error data is ready
>   acpi/generic_event_device: Update GHES migration to cover hest addr
>   acpi/generic_event_device: add logic to detect if HEST addr is
>     available
>   acpi/generic_event_device: add an APEI error device
>   tests/acpi: virt: allow acpi table changes at DSDT and HEST tables
>   arm/virt: Wire up a GED error device for ACPI / GHES
>   qapi/acpi-hest: add an interface to do generic CPER error injection
>   acpi/generic_event_device.c: enable use_hest_addr for QEMU 10.x
>   tests/acpi: virt: update HEST and DSDT tables
>   docs: hest: add new "etc/acpi_table_hest_addr" and update workflow
>   scripts/ghes_inject: add a script to generate GHES error inject
> 
>  MAINTAINERS                                   |  10 +
>  docs/specs/acpi_hest_ghes.rst                 |  28 +-
>  hw/acpi/Kconfig                               |   5 +
>  hw/acpi/aml-build.c                           |  10 +
>  hw/acpi/generic_event_device.c                |  44 ++
>  hw/acpi/ghes-stub.c                           |   7 +-
>  hw/acpi/ghes.c                                | 233 ++++--
>  hw/acpi/ghes_cper.c                           |  40 +
>  hw/acpi/ghes_cper_stub.c                      |  20 +
>  hw/acpi/meson.build                           |   2 +
>  hw/arm/virt-acpi-build.c                      |  35 +-
>  hw/arm/virt.c                                 |  19 +-
>  hw/core/machine.c                             |   5 +-
>  include/hw/acpi/acpi_dev_interface.h          |   1 +
>  include/hw/acpi/aml-build.h                   |   2 +
>  include/hw/acpi/generic_event_device.h        |   1 +
>  include/hw/acpi/ghes.h                        |  51 +-
>  include/hw/arm/virt.h                         |   2 +
>  qapi/acpi-hest.json                           |  36 +
>  qapi/meson.build                              |   1 +
>  qapi/qapi-schema.json                         |   1 +
>  scripts/arm_processor_error.py                | 476 ++++++++++++
>  scripts/ghes_inject.py                        |  51 ++
>  scripts/qmp_helper.py                         | 703 ++++++++++++++++++
>  target/arm/kvm.c                              |   7 +-
>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5293 -> 5337 bytes
>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5379 -> 5423 bytes
>  tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 6202 -> 6246 bytes
>  .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 5347 -> 5391 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6654 -> 6698 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7768 -> 7812 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5495 -> 5539 bytes
>  tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 5310 -> 5354 bytes
>  tests/data/acpi/aarch64/virt/HEST             | Bin 132 -> 224 bytes
>  34 files changed, 1700 insertions(+), 90 deletions(-)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/acpi-hest.json
>  create mode 100644 scripts/arm_processor_error.py
>  create mode 100755 scripts/ghes_inject.py
>  create mode 100755 scripts/qmp_helper.py
> 



Thanks,
Mauro

