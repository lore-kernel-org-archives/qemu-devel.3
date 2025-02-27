Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF8CC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 13:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tndyS-0003RP-9v; Thu, 27 Feb 2025 08:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tndyJ-0003Qb-UY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:30:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tndyF-0002hz-Fa
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740663033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10kUSJV4EUd1FzHZvX0wjBLQDNiAVBrIFn/OMdDmjA4=;
 b=bCtOb9OgSGr3G3UV6Ua+x4wHs32tc2b4RXTV/bkuzKMiyYFTFHJ2LmlXtdptxZ8Mp/m6fN
 mnlod70VgHWqVbS29rxPC9Ys9B5zjyhUUloSyM0Ku+ea/N8JdSjhBm7jVQ7DWUikKpw1U3
 cFl2S/kzp/GZh0sFYqLiWEO6Zjy5PKs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-BW3zWVWgMKSkywDKlGxKdw-1; Thu, 27 Feb 2025 08:30:31 -0500
X-MC-Unique: BW3zWVWgMKSkywDKlGxKdw-1
X-Mimecast-MFC-AGG-ID: BW3zWVWgMKSkywDKlGxKdw_1740663030
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390ddebcbd1so547517f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 05:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740663030; x=1741267830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=10kUSJV4EUd1FzHZvX0wjBLQDNiAVBrIFn/OMdDmjA4=;
 b=h9Q/cg9r4o96TMJvVYcJAhEEp5Jn7BTFqjYjJES8PfO1kYckjBI52Jpb38J0eoFMKI
 kX10Q70qmcgG86Jyee+7QA11gh9cF9WM1VuG2kLZpSb+qerrE7XvrO/QxVNYg7qYo+N+
 OPbhznPv+O/Y4Skysi8qsWCtuHjd60iwgxI8rm1LSPzJjxUmdj3xP1lfv+/TUF++B8wV
 SkaF5ODC/FX1HJIZnXauFkhcOCTsFAAtI/TXc47OF9tRcZPzLnkcNmGfyTOiRjxDiJCK
 51KBiiFnV4eOv38uDgjMisVsLeulg6CDr2JGTtOmSElDtBkKaTU1VMKdKVyxuWKTZpS4
 yPOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4DCevpXe2VBStURDadCY8P8ZhnJvQveCNIPFxZT5f/zH+2uXHYuLoVZrmJTSczBEYFwIrzUM3Vt2N@nongnu.org
X-Gm-Message-State: AOJu0YwWGaAUputY6iIdCa42k2Oel5P2lO9a9qZBEdoX7C7RcdXha3cP
 4rLNuRSyqjt14F1lzpD9gZ1xFdlSdz3MxwU0w5OoYeIAOqaxWvVUjeZra0y7ctcAF5h65xGGLCy
 J9q2k7dHAqNS6gON4/9dt7ICTyERNFBhUj5z8fp5njol71NSBbUBn
X-Gm-Gg: ASbGncu5fNTMjb2NlYRDYUNaTRDnBNwQZhh+hO4QoSdiyZx+msQKXv1MI/wJDxgnnhv
 6mhfw7BnQ74ACg/WQZBEcxsfMiNADIRkOekCgtU9EVOgJAnG0RJgDuA3F3O7CbKcr0p7RdY5plA
 9/w8AII4j+Rk0dYebHn/TLAUDxbPr1RgzCAX2Y2R3lr07xmNNQ7XCFuhti2NTAuXQE5EPPNgRO9
 i14TqlT1OBmJlAuhv3EC7StDrrYW1xMwscfgZCMzv9pmo3UUpohtmUb/ZsMOEGTXo25/s94nVWS
 VmoDqEVTTBlhBQqoqsZC7w93NEK4PjazN8YJK2l4yo09yosdFqrpIdVmGAPw34o=
X-Received: by 2002:a05:6000:1a89:b0:390:e9e7:ca70 with SMTP id
 ffacd0b85a97d-390e9e7cc41mr530499f8f.30.1740663030083; 
 Thu, 27 Feb 2025 05:30:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDkqUxDVICIl2asaXKqIUXiaJsWHY1QefjUZLHDH5yJP2etyBSJVoWL14wXy6Wvs131BU7Sg==
X-Received: by 2002:a05:6000:1a89:b0:390:e9e7:ca70 with SMTP id
 ffacd0b85a97d-390e9e7cc41mr530476f8f.30.1740663029647; 
 Thu, 27 Feb 2025 05:30:29 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7ddesm2094064f8f.57.2025.02.27.05.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 05:30:29 -0800 (PST)
Date: Thu, 27 Feb 2025 14:30:28 +0100
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
Subject: Re: [PATCH v5 00/21]Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250227143028.22372363@imammedo.users.ipa.redhat.com>
In-Reply-To: <cover.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 27 Feb 2025 12:03:30 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that the ghes preparation patches were merged, let's add support
> for error injection.
> 
> On this version, HEST table got added to ACPI tables testing for aarch64 virt.
> 
> There are also some patch reorder to help reviewers to check the changes.
> 
> The code itself is almost identical to v4, with just a few minor nits addressed.

series still has checkpatch errors 'line over 80' which are not false positive,
it needs to be fixed

> 
> ---
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
> Mauro Carvalho Chehab (21):
>   tests/acpi: virt: add an empty HEST file
>   tests/qtest/bios-tables-test: extend to also check HEST table
>   tests/acpi: virt: update HEST file with its current data
>   acpi/ghes: Cleanup the code which gets ghes ged state
>   acpi/ghes: prepare to change the way HEST offsets are calculated
>   acpi/ghes: add a firmware file with HEST address
>   acpi/ghes: Use HEST table offsets when preparing GHES records
>   acpi/ghes: don't hard-code the number of sources for HEST table
>   acpi/ghes: add a notifier to notify when error data is ready
>   acpi/ghes: create an ancillary acpi_ghes_get_state() function
>   acpi/generic_event_device: Update GHES migration to cover hest addr
>   acpi/generic_event_device: add logic to detect if HEST addr is
>     available
>   acpi/generic_event_device: add an APEI error device
>   tests/acpi: virt: allow acpi table changes at DSDT and HEST tables
>   arm/virt: Wire up a GED error device for ACPI / GHES
>   qapi/acpi-hest: add an interface to do generic CPER error injection
>   tests/acpi: virt: update HEST table to accept two sources
>   tests/acpi: virt: and update DSDT table to add the new GED device
>   docs: hest: add new "etc/acpi_table_hest_addr" and update workflow
>   acpi/generic_event_device.c: enable use_hest_addr for QEMU 10.x
>   scripts/ghes_inject: add a script to generate GHES error inject
> 
>  MAINTAINERS                                   |  10 +
>  docs/specs/acpi_hest_ghes.rst                 |  28 +-
>  hw/acpi/Kconfig                               |   5 +
>  hw/acpi/aml-build.c                           |  10 +
>  hw/acpi/generic_event_device.c                |  43 ++
>  hw/acpi/ghes-stub.c                           |   7 +-
>  hw/acpi/ghes.c                                | 231 ++++--
>  hw/acpi/ghes_cper.c                           |  38 +
>  hw/acpi/ghes_cper_stub.c                      |  19 +
>  hw/acpi/meson.build                           |   2 +
>  hw/arm/virt-acpi-build.c                      |  36 +-
>  hw/arm/virt.c                                 |  19 +-
>  hw/core/machine.c                             |   2 +
>  include/hw/acpi/acpi_dev_interface.h          |   1 +
>  include/hw/acpi/aml-build.h                   |   2 +
>  include/hw/acpi/generic_event_device.h        |   1 +
>  include/hw/acpi/ghes.h                        |  52 +-
>  include/hw/arm/virt.h                         |   2 +
>  qapi/acpi-hest.json                           |  35 +
>  qapi/meson.build                              |   1 +
>  qapi/qapi-schema.json                         |   1 +
>  scripts/arm_processor_error.py                | 476 ++++++++++++
>  scripts/ghes_inject.py                        |  51 ++
>  scripts/qmp_helper.py                         | 702 ++++++++++++++++++
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


