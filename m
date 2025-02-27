Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB74CC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngz8-0005Ow-9G; Thu, 27 Feb 2025 11:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tngz1-0004w9-3w
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tngyv-0007Iy-G2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740674607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQNCbBxi7eD7idYstTcVVTcDcXqJ3+FMvik+jAH6Dos=;
 b=Q6fPEnZx8nLEFQPAzBX7CCyKjB0JIFhgqsLYEMbMBhX8iq9ds9berfAbIIavAvAV9OlMHT
 dOkvXaoyGN1BCwy4K+YgLRYQtxbv7i0/B7bK9izLbf/u9Bw1tXxJPRfaKuuX2QiAbYOeNo
 Gq/7EZ3SLkqZsV4G0WLkRG/TISrqt70=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-lAM1-2ydOESlMs3Np5diaA-1; Thu, 27 Feb 2025 11:43:26 -0500
X-MC-Unique: lAM1-2ydOESlMs3Np5diaA-1
X-Mimecast-MFC-AGG-ID: lAM1-2ydOESlMs3Np5diaA_1740674605
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-439a5c4dfb2so5949025e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740674605; x=1741279405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TQNCbBxi7eD7idYstTcVVTcDcXqJ3+FMvik+jAH6Dos=;
 b=s65YcS6TVD5qIoqwBrnI1YyiG/Xbw9rDiBXfEySdgCY26VPXRqOdgHhMnjFujS7gub
 n2doXZ8Fw0U1LKGyfGNDKd9c9gxT9WjZV94g2BTh4+N9d7tkYMxZ034wBlpSA5LJ5fAA
 xbHIJRO3OkcIdnyMBWQ+61dbNV2Da0kZSK/bD3t1KY3TH1L2Dxho0RK0phwS4JkVrcWc
 jaIv9EZDZ6FyOqeYAEOTObgz+WBUAHsCnBx/Hi9MmBF94ancJHT+6DCOmtvWeL2XgB0+
 TAvf5jcsK1h29b7g+FyGnOPUkv5jvh6uCr3V5r1VGGbhORbIWY4Gpm7zJ6wxydC3E/JU
 /vEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV//WdI1MrBV5OlTxfeTJCS2esV8ISkRw+zreyaeAigMUwlsMFjf+IbFNqwtQNIcwwKunO04n+8ZH0H@nongnu.org
X-Gm-Message-State: AOJu0Yzy07V6p9L6R/46by/+DfIuv6A6NzwdXFDX6x4hyR0j0mold40P
 7nE2kfs6fnYXNg19Y+QpoxIxXZtD9u3JbRUi16afADSdjhFy0kBhVtqgHwH6OPbvkq/vzWAg2e0
 +bArjT1Yv5nUX/iolYmuhZLuQmnRC5aN4xEN0SDL88nqtwIeoD51+
X-Gm-Gg: ASbGncsJ47NvowZp5gleV5Jfg91kNqrgiGJQlcjhSXjoD8Bk2SMYPphb2X78kBDSW9W
 GhSftcgut6AgiSD5vEzgaEwBpezhvEmfugWYuSNr/4UwNdaT9Ff1EAviOWEzmAY7wGHbXVqmphd
 7b1NRou8UTlfbTC4oOuY5VwRuGxCEDmrxd+cDNxvPB2iWN/5zRHVwddmHoYx/4KA2kMi6z9d+rz
 8vDyqdcU9RpvyKyCFSuw1wBHPgPkTXwmlyV+v8NB9ERqUioUaAWwA3ZQAwxppLUUQlLo5LK3utI
 bX5sWDBrhp9ZBrcqbkVwH2mYtM5EMNWkue2+ATqBJCmXC8g40MrSO4GcDJwAEpA=
X-Received: by 2002:a05:600c:3c83:b0:439:82de:9166 with SMTP id
 5b1f17b1804b1-43ab8fd1e8dmr64031035e9.1.1740674605044; 
 Thu, 27 Feb 2025 08:43:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrTKA/tq7v3HDQicW7l4zuzGDkJqwkvaaj/r610R8fS1dVqhjB9P9yfyCOg58tOjH/0/jlEQ==
X-Received: by 2002:a05:600c:3c83:b0:439:82de:9166 with SMTP id
 5b1f17b1804b1-43ab8fd1e8dmr64030785e9.1.1740674604620; 
 Thu, 27 Feb 2025 08:43:24 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b737074d8sm29172345e9.16.2025.02.27.08.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:43:24 -0800 (PST)
Date: Thu, 27 Feb 2025 17:43:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/19] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250227174321.0162a10f@imammedo.users.ipa.redhat.com>
In-Reply-To: <cover.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, 27 Feb 2025 17:00:38 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that the ghes preparation patches were merged, let's add support
> for error injection.
> 
> On this version, HEST table got added to ACPI tables testing for aarch64 virt.
> 
> There are also some patch reorder to help reviewers to check the changes.
> 
> The code itself is almost identical to v4, with just a few minor nits addressed.
checkpatch on my machine still complains

0007-acpi-ghes-Use-HEST-table-offsets-when-preparing-GHES.patch has no obvious style problems and is ready for submission.
Checking 0008-acpi-ghes-don-t-hard-code-the-number-of-sources-for-.patch...
WARNING: line over 80 characters
#170: FILE: hw/acpi/ghes.c:390:
+        build_ghes_v2_entry(table_data, linker, &notif_source[i], i, num_sources);

total: 0 errors, 1 warnings, 159 lines checked

0008-acpi-ghes-don-t-hard-code-the-number-of-sources-for-.patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking 0009-acpi-ghes-add-a-notifier-to-notify-when-error-data-i.patch...
total: 0 errors, 0 warnings, 26 lines checked

0009-acpi-ghes-add-a-notifier-to-notify-when-error-data-i.patch has no obvious style problems and is ready for submission.
Checking 0010-acpi-generic_event_device-Update-GHES-migration-to-c.patch...
total: 0 errors, 0 warnings, 41 lines checked

0010-acpi-generic_event_device-Update-GHES-migration-to-c.patch has no obvious style problems and is ready for submission.
Checking 0011-acpi-generic_event_device-add-logic-to-detect-if-HES.patch...
total: 0 errors, 0 warnings, 59 lines checked

0011-acpi-generic_event_device-add-logic-to-detect-if-HES.patch has no obvious style problems and is ready for submission.
Checking 0012-acpi-generic_event_device-add-an-APEI-error-device.patch...
total: 0 errors, 0 warnings, 72 lines checked

0012-acpi-generic_event_device-add-an-APEI-error-device.patch has no obvious style problems and is ready for submission.
Checking 0013-tests-acpi-virt-allow-acpi-table-changes-at-DSDT-and.patch...
total: 0 errors, 0 warnings, 7 lines checked

0013-tests-acpi-virt-allow-acpi-table-changes-at-DSDT-and.patch has no obvious style problems and is ready for submission.
Checking 0014-arm-virt-Wire-up-a-GED-error-device-for-ACPI-GHES.patch...
WARNING: line over 80 characters
#68: FILE: hw/arm/virt.c:1015:
+    VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);

total: 0 errors, 1 warnings, 44 lines checked

0014-arm-virt-Wire-up-a-GED-error-device-for-ACPI-GHES.patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking 0015-qapi-acpi-hest-add-an-interface-to-do-generic-CPER-e.patch...
total: 0 errors, 0 warnings, 178 lines checked



> ---
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
> 
> 
> Mauro Carvalho Chehab (19):
>   tests/acpi: virt: add an empty HEST file
>   tests/qtest/bios-tables-test: extend to also check HEST table
>   tests/acpi: virt: update HEST file with its current data
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
>  hw/acpi/ghes.c                                | 231 ++++--
>  hw/acpi/ghes_cper.c                           |  38 +
>  hw/acpi/ghes_cper_stub.c                      |  19 +
>  hw/acpi/meson.build                           |   2 +
>  hw/arm/virt-acpi-build.c                      |  35 +-
>  hw/arm/virt.c                                 |  19 +-
>  hw/core/machine.c                             |   2 +
>  include/hw/acpi/acpi_dev_interface.h          |   1 +
>  include/hw/acpi/aml-build.h                   |   2 +
>  include/hw/acpi/generic_event_device.h        |   1 +
>  include/hw/acpi/ghes.h                        |  51 +-
>  include/hw/arm/virt.h                         |   2 +
>  qapi/acpi-hest.json                           |  35 +
>  qapi/meson.build                              |   1 +
>  qapi/qapi-schema.json                         |   1 +
>  scripts/arm_processor_error.py                | 476 ++++++++++++
>  scripts/ghes_inject.py                        |  51 ++
>  scripts/qmp_helper.py                         | 703 ++++++++++++++++++
>  target/arm/kvm.c                              |   7 +-
>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5240 bytes
>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5326 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6601 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7723 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5442 bytes
>  tests/data/acpi/aarch64/virt/HEST             | Bin 0 -> 224 bytes
>  tests/qtest/bios-tables-test.c                |   2 +-
>  32 files changed, 1692 insertions(+), 91 deletions(-)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/acpi-hest.json
>  create mode 100644 scripts/arm_processor_error.py
>  create mode 100755 scripts/ghes_inject.py
>  create mode 100755 scripts/qmp_helper.py
>  create mode 100644 tests/data/acpi/aarch64/virt/HEST
> 


