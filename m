Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB85C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnIlW-0002Ct-4G; Wed, 26 Feb 2025 09:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnIlO-0002BT-Qf
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:51:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnIlL-0004jj-5P
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740581510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjDcNMS3m2KvFYfCArjaQPKsyojcR0O9nS1Ii1LdD30=;
 b=VQ2z5qo8MpAHDiYnZvcwzxH/uguOzDLS+uXrVwGYdc8g8+BaCTQBrqQiUn2aScozsh+rmB
 HCLUkLfRUuLKZyIVoOH14Hfe3iXo4ae8paOtXlge1GbgssTK60EbylGRRehFlKKpufef/d
 8Gu7AxVNXL1MhCB3KTv/XymYymZ2hzQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-mxQ0nN8DMEybGY3fH3CClw-1; Wed, 26 Feb 2025 09:51:46 -0500
X-MC-Unique: mxQ0nN8DMEybGY3fH3CClw-1
X-Mimecast-MFC-AGG-ID: mxQ0nN8DMEybGY3fH3CClw_1740581506
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43998ec3733so35107415e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740581505; x=1741186305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjDcNMS3m2KvFYfCArjaQPKsyojcR0O9nS1Ii1LdD30=;
 b=rTPpNOUIUHk6kSnlwifVkPYeVYdY8iIkg45zXvMFKd2rlILeMNjKTwfhzs8cRnbjES
 NEGbU347h+N9qpmZxrILQH6ysLenMQinnM64SiwKkcKDUT2tmAJFMn7fa+KOkw9rZgkf
 NlgJGnZBV3rSBjlb9WpC7aYsO0rupON03cyusU/Zx8QoYEyzSLMXndWSVPR57XUwCBzO
 glm1xApH4XyOayakIGwezZ72XRwpQWiK494fMFORxUh7jdMR0oE+G8hgCou5liR30ELF
 lk9g/PeqvBQ8cOxSKTYJ752qDxI1rZ3VAvwTvyxztHUd94503qlCNxq0v9eBIbuL+i0C
 puXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkVNnAxHR4lDkXrT+byNGJjYp6dXRp2I68sgsELyduaa/riV/t9AHPfsmziuqJrYszBDZCo5PdTAFl@nongnu.org
X-Gm-Message-State: AOJu0Yyx3YJA9v7LGJqaFyTKlTSlRIsrcl9qYszkQH6/7w2hXEuD+VVF
 92j6jPjqj26IwgAog8nSFP+vKcgzL9/igv4YkqEkY85/lPxlSLcMRlPj6y8pRk6v4Hm25TObrJg
 h0L80eiWto7ZewrL/u7KYXSRSlshLfFqLN9cFlx2Xsa6X6rzBy8Rt
X-Gm-Gg: ASbGncvhr7qLM9rXLRAtywJViQcm1pe0L3OPcP81n4dty4mPSsJSEjuOshTrsJlzYe6
 aaFMBavIaCl+CqXKOiHm+mZkp4lWYTLuNd+oWn3G7nAhHfRAUTvjG/yNJHAi5TuTwvdBrZ6aZBZ
 yIFk5bJunZV5Hxd4F8d2OD7uOGANLYNZa1vsN+xonmmXzhBekvme6T0pn+2tjazkNBqbouux9/r
 XIA6V/gpa1l/mfGV/a186oMraQvPYpe+MQ1vnldLmv8YEm17e8lz258XbYzE6qNCkh6meeLOOrC
 drVpTS9Gmr3jIqDkkWzvG/MYI6aC9A8el0JlmBFBiL+uq/yXaz5NL/cPAUGfeiY=
X-Received: by 2002:a05:600c:4588:b0:439:88bb:d020 with SMTP id
 5b1f17b1804b1-43ab0f2dcb1mr60884625e9.8.1740581505541; 
 Wed, 26 Feb 2025 06:51:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKa94atTc56+cD/Ww+Jgaq2nnB0Xu5jKGJ9ryPYaz3eiHumwOvBEgn93E/1uEp4aCSOrKpVQ==
X-Received: by 2002:a05:600c:4588:b0:439:88bb:d020 with SMTP id
 5b1f17b1804b1-43ab0f2dcb1mr60884275e9.8.1740581505080; 
 Wed, 26 Feb 2025 06:51:45 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8e71c0sm5790989f8f.78.2025.02.26.06.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:51:44 -0800 (PST)
Date: Wed, 26 Feb 2025 15:51:43 +0100
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
Message-ID: <20250226155143.0e4a05f8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250226153913.27255b1e@sal.lan>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <20250226151656.10665bc9@imammedo.users.ipa.redhat.com>
 <20250226153913.27255b1e@sal.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

On Wed, 26 Feb 2025 15:39:13 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 26 Feb 2025 15:16:56 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Fri, 21 Feb 2025 15:35:09 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Now that the ghes preparation patches were merged, let's add support
> > > for error injection.
> > > 
> > > On this series, the first 6 patches chang to the math used to calculate offsets at HEST
> > > table and hardware_error firmware file, together with its migration code. Migration tested
> > > with both latest QEMU released kernel and upstream, on both directions.
> > > 
> > > The next patches add a new QAPI to allow injecting GHESv2 errors, and a script using such QAPI
> > >    to inject ARM Processor Error records.    
> > 
> > please, run ./scripts/checkpatch on patches before submitting them.
> > as it stands now series cannot be merged due to failing checkpatch  
> 
> Weird... checkpatch is at pre-commit hook, as recommended at QEMU 
> documentation. It is actually a little harder to manage this way, as it 
> sometimes cause troubles with binary files.
> 
> Anyway, I'll run it by hand before sending the next version.

I've just applied v4 => format-patch => checkpatch
maybe I did something wrong (don't see how) but it complains overhere


PS: do not respin until I've finish this review.
 
> >   
> > > 
> > > ---
> > > v4:
> > > - added an extra comment for AcpiGhesState structure;
> > > - patches reordered;
> > > - no functional changes, just code shift between the patches in this series.
> > > 
> > > v3:
> > > - addressed more nits;
> > > - hest_add_le now points to the beginning of HEST table;
> > > - removed HEST from tests/data/acpi;
> > > - added an extra patch to not use fw_cfg with virt-10.0 for hw_error_le
> > > 
> > > v2: 
> > > - address some nits;
> > > - improved ags cleanup patch and removed ags.present field;
> > > - added some missing le*_to_cpu() calls;
> > > - update date at copyright for new files to 2024-2025;
> > > - qmp command changed to: inject-ghes-v2-error ans since updated to 10.0;
> > > - added HEST and DSDT tables after the changes to make check target happy.
> > >   (two patches: first one whitelisting such tables; second one removing from
> > >    whitelist and updating/adding such tables to tests/data/acpi)
> > > 
> > > 
> > > 
> > > Mauro Carvalho Chehab (14):
> > >   acpi/ghes: prepare to change the way HEST offsets are calculated
> > >   acpi/ghes: add a firmware file with HEST address
> > >   acpi/ghes: Use HEST table offsets when preparing GHES records
> > >   acpi/ghes: don't hard-code the number of sources for HEST table
> > >   acpi/ghes: add a notifier to notify when error data is ready
> > >   acpi/ghes: create an ancillary acpi_ghes_get_state() function
> > >   acpi/generic_event_device: Update GHES migration to cover hest addr
> > >   acpi/generic_event_device: add logic to detect if HEST addr is
> > >     available
> > >   acpi/generic_event_device: add an APEI error device
> > >   tests/acpi: virt: allow acpi table changes for a new table: HEST
> > >   arm/virt: Wire up a GED error device for ACPI / GHES
> > >   tests/acpi: virt: add a HEST table to aarch64 virt and update DSDT
> > >   qapi/acpi-hest: add an interface to do generic CPER error injection
> > >   scripts/ghes_inject: add a script to generate GHES error inject
> > > 
> > >  MAINTAINERS                                   |  10 +
> > >  hw/acpi/Kconfig                               |   5 +
> > >  hw/acpi/aml-build.c                           |  10 +
> > >  hw/acpi/generic_event_device.c                |  43 ++
> > >  hw/acpi/ghes-stub.c                           |   7 +-
> > >  hw/acpi/ghes.c                                | 231 ++++--
> > >  hw/acpi/ghes_cper.c                           |  38 +
> > >  hw/acpi/ghes_cper_stub.c                      |  19 +
> > >  hw/acpi/meson.build                           |   2 +
> > >  hw/arm/virt-acpi-build.c                      |  37 +-
> > >  hw/arm/virt.c                                 |  19 +-
> > >  hw/core/machine.c                             |   2 +
> > >  include/hw/acpi/acpi_dev_interface.h          |   1 +
> > >  include/hw/acpi/aml-build.h                   |   2 +
> > >  include/hw/acpi/generic_event_device.h        |   1 +
> > >  include/hw/acpi/ghes.h                        |  54 +-
> > >  include/hw/arm/virt.h                         |   2 +
> > >  qapi/acpi-hest.json                           |  35 +
> > >  qapi/meson.build                              |   1 +
> > >  qapi/qapi-schema.json                         |   1 +
> > >  scripts/arm_processor_error.py                | 476 ++++++++++++
> > >  scripts/ghes_inject.py                        |  51 ++
> > >  scripts/qmp_helper.py                         | 702 ++++++++++++++++++
> > >  target/arm/kvm.c                              |   7 +-
> > >  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5240 bytes
> > >  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5326 bytes
> > >  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6601 bytes
> > >  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7723 bytes
> > >  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5442 bytes
> > >  29 files changed, 1677 insertions(+), 79 deletions(-)
> > >  create mode 100644 hw/acpi/ghes_cper.c
> > >  create mode 100644 hw/acpi/ghes_cper_stub.c
> > >  create mode 100644 qapi/acpi-hest.json
> > >  create mode 100644 scripts/arm_processor_error.py
> > >  create mode 100755 scripts/ghes_inject.py
> > >  create mode 100755 scripts/qmp_helper.py
> > >     
> >   
> 


