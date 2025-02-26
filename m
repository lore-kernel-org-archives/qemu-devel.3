Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5D1C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 16:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJqK-00072G-H9; Wed, 26 Feb 2025 11:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJq6-0006wc-JU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:00:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJq0-0005f0-TZ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740585644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqa5gQlqS9US5GtfUQPHzeFlJi9ebohvbqbVThoHRcI=;
 b=JY1kwkxOq4CQ6DEbruVnNN53V5dFc41+36/eDPymt9ossYdz75WGzQM1aWxZ6VgslH/iax
 SBLMHE8FJXTOV4aL1xPE1LU3eofUHvjoNNo30n6hQa44bUDIq2VcdGxmXzpAbEzSGyBiRf
 Js4sWLPQmg8aeob1P/M5gbcmrPaLvxQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-OicjLq0MM0qcmkJTZBM1Qw-1; Wed, 26 Feb 2025 11:00:42 -0500
X-MC-Unique: OicjLq0MM0qcmkJTZBM1Qw-1
X-Mimecast-MFC-AGG-ID: OicjLq0MM0qcmkJTZBM1Qw_1740585641
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ab456333aso15938735e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 08:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740585641; x=1741190441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqa5gQlqS9US5GtfUQPHzeFlJi9ebohvbqbVThoHRcI=;
 b=H3efvU8CRxudYzPwz/bi0q4MYo/GH+EbvrVeboqEyZhjSueA3VJvc8Ho1JgLkW30LJ
 5NQ2uxIqz+chfdlwq2CwgAfXBf8AwQK9VxawXlIiKdO9Uzh7vnDk7YIE1h0UeWuOvAQ2
 hUzZsXrnNjxyUt+VEzYhEXWa1rawWdVdArPnA2Ny2ABH0zvXsQT4UXjkNgSmGhsZlWtG
 581ul1/LjZzak7XulNOnMuC+qX1rYqW0tKG4Yu219MG/Qbo4jQbfKdYtL8eMjaRCpgZN
 J+2fxIa25wTu2+R7a9xBGdieqh4DHxsHhJe4J5GnMHDPTFm0ZTJ0yvpNe0/g4KA4cyJB
 eLoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKhm+Uk3MWrwhQNZbH4l7UJAW3E9IwdON6MEPCrMiy2fiHWDa7rNXRgFXYPgH08mtsv1fGmNRetW19@nongnu.org
X-Gm-Message-State: AOJu0Yx1KUaC01GRsTOq4Guw3/J28jWMlGdzcyez6qMXyQNWGwCcCTgj
 owntwwywVO1Atl6VbqmIi0Np/aE8tt3MDnXTgKtawHTicr/p04JzldlemXuXR0POW4U0qhFKqTC
 hjfEKMEbJVgVNGzJqpp6Y++3Q5FU+fvqIfeak6tuji/7y0HBw7ASU
X-Gm-Gg: ASbGncsHZD4fjk/UUzIEBpq5KnIqAblMr8dvy6jGc8tyJCl0wgaPSgvia13Mfn5IT0x
 dTHCIMQozsAFaTKgMO0C8vyLvZwTOGXYzNRKh1lNPJavlbVmvYjYN76l3q32KZ0QUNmirw0Gz1C
 9z8fz6QjBkXkfMBFAgZL5ZhVn1N4H4Gy/pEGQ3KfsNeJfR6lol/FBo0vewr7ke8239s72UMsFsl
 12WR0CYquEcIuwiS+Ww77DMgCLURTL4KrcOZtP4O2MxXxew6BMZ7EiBEMlsVKywEct8F3htja5A
 /tccPYFFeoUz4APJRO/PCAmK5crlPkR0KDOZ0Q6wAG2YYlu5PL6ut4Q6cly/0dM=
X-Received: by 2002:a05:600c:1c86:b0:439:8b05:66a6 with SMTP id
 5b1f17b1804b1-43ab0f64425mr75173695e9.22.1740585639388; 
 Wed, 26 Feb 2025 08:00:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGOJUxfNkJ47dOepAoS3DkNdGuo0CohyHyhD/GA0TMRONmh8zeK9C4FdbnePVZ6SIE8cqCJg==
X-Received: by 2002:a05:600c:1c86:b0:439:8b05:66a6 with SMTP id
 5b1f17b1804b1-43ab0f64425mr75170455e9.22.1740585637323; 
 Wed, 26 Feb 2025 08:00:37 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5393e5sm26113765e9.20.2025.02.26.08.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 08:00:36 -0800 (PST)
Date: Wed, 26 Feb 2025 17:00:33 +0100
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
Subject: Re: [PATCH v4 00/14] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250226170033.5c4687dd@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250226155143.0e4a05f8@imammedo.users.ipa.redhat.com>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <20250226151656.10665bc9@imammedo.users.ipa.redhat.com>
 <20250226153913.27255b1e@sal.lan>
 <20250226155143.0e4a05f8@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

On Wed, 26 Feb 2025 15:51:43 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed, 26 Feb 2025 15:39:13 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
[...]
> 
> PS: do not respin until I've finish this review.

finished

>  
> > >     
> > > > 
> > > > ---
> > > > v4:
> > > > - added an extra comment for AcpiGhesState structure;
> > > > - patches reordered;
> > > > - no functional changes, just code shift between the patches in this series.
> > > > 
> > > > v3:
> > > > - addressed more nits;
> > > > - hest_add_le now points to the beginning of HEST table;
> > > > - removed HEST from tests/data/acpi;
> > > > - added an extra patch to not use fw_cfg with virt-10.0 for hw_error_le
> > > > 
> > > > v2: 
> > > > - address some nits;
> > > > - improved ags cleanup patch and removed ags.present field;
> > > > - added some missing le*_to_cpu() calls;
> > > > - update date at copyright for new files to 2024-2025;
> > > > - qmp command changed to: inject-ghes-v2-error ans since updated to 10.0;
> > > > - added HEST and DSDT tables after the changes to make check target happy.
> > > >   (two patches: first one whitelisting such tables; second one removing from
> > > >    whitelist and updating/adding such tables to tests/data/acpi)
> > > > 
> > > > 
> > > > 
> > > > Mauro Carvalho Chehab (14):
> > > >   acpi/ghes: prepare to change the way HEST offsets are calculated
> > > >   acpi/ghes: add a firmware file with HEST address
> > > >   acpi/ghes: Use HEST table offsets when preparing GHES records
> > > >   acpi/ghes: don't hard-code the number of sources for HEST table
> > > >   acpi/ghes: add a notifier to notify when error data is ready
> > > >   acpi/ghes: create an ancillary acpi_ghes_get_state() function
> > > >   acpi/generic_event_device: Update GHES migration to cover hest addr
> > > >   acpi/generic_event_device: add logic to detect if HEST addr is
> > > >     available
> > > >   acpi/generic_event_device: add an APEI error device
> > > >   tests/acpi: virt: allow acpi table changes for a new table: HEST
> > > >   arm/virt: Wire up a GED error device for ACPI / GHES
> > > >   tests/acpi: virt: add a HEST table to aarch64 virt and update DSDT
> > > >   qapi/acpi-hest: add an interface to do generic CPER error injection
> > > >   scripts/ghes_inject: add a script to generate GHES error inject
> > > > 
> > > >  MAINTAINERS                                   |  10 +
> > > >  hw/acpi/Kconfig                               |   5 +
> > > >  hw/acpi/aml-build.c                           |  10 +
> > > >  hw/acpi/generic_event_device.c                |  43 ++
> > > >  hw/acpi/ghes-stub.c                           |   7 +-
> > > >  hw/acpi/ghes.c                                | 231 ++++--
> > > >  hw/acpi/ghes_cper.c                           |  38 +
> > > >  hw/acpi/ghes_cper_stub.c                      |  19 +
> > > >  hw/acpi/meson.build                           |   2 +
> > > >  hw/arm/virt-acpi-build.c                      |  37 +-
> > > >  hw/arm/virt.c                                 |  19 +-
> > > >  hw/core/machine.c                             |   2 +
> > > >  include/hw/acpi/acpi_dev_interface.h          |   1 +
> > > >  include/hw/acpi/aml-build.h                   |   2 +
> > > >  include/hw/acpi/generic_event_device.h        |   1 +
> > > >  include/hw/acpi/ghes.h                        |  54 +-
> > > >  include/hw/arm/virt.h                         |   2 +
> > > >  qapi/acpi-hest.json                           |  35 +
> > > >  qapi/meson.build                              |   1 +
> > > >  qapi/qapi-schema.json                         |   1 +
> > > >  scripts/arm_processor_error.py                | 476 ++++++++++++
> > > >  scripts/ghes_inject.py                        |  51 ++
> > > >  scripts/qmp_helper.py                         | 702 ++++++++++++++++++
> > > >  target/arm/kvm.c                              |   7 +-
> > > >  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5240 bytes
> > > >  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5326 bytes
> > > >  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6601 bytes
> > > >  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7723 bytes
> > > >  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5442 bytes
> > > >  29 files changed, 1677 insertions(+), 79 deletions(-)
> > > >  create mode 100644 hw/acpi/ghes_cper.c
> > > >  create mode 100644 hw/acpi/ghes_cper_stub.c
> > > >  create mode 100644 qapi/acpi-hest.json
> > > >  create mode 100644 scripts/arm_processor_error.py
> > > >  create mode 100755 scripts/ghes_inject.py
> > > >  create mode 100755 scripts/qmp_helper.py
> > > >       
> > >     
> >   
> 


