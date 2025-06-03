Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F28C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 12:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQbi-0000o5-2T; Tue, 03 Jun 2025 08:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMQbg-0000nd-AI
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMQbd-0003n4-GB
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748953137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eb0iVseY34ZQu1KucxpS4ti1Op2BFBWowNjVgENOwk=;
 b=LNHZ1S2WtDkDWFJ9j69rtmUvlwzMy3iWUEnakfRE53OQ5B9cjv42YadW0fNSKNO7+NM18m
 yihpLQRXQU1+oj/fZAFkEffexUG9F6IuAdDVs2SyAPvF1hFbmbdRtzl3EJ2mSgPL1OQLGs
 7G863y+cQcWaMh8ielShp0mbIxVvIwg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-op-LOp4wPUq8SWzH7m7MeA-1; Tue, 03 Jun 2025 08:18:54 -0400
X-MC-Unique: op-LOp4wPUq8SWzH7m7MeA-1
X-Mimecast-MFC-AGG-ID: op-LOp4wPUq8SWzH7m7MeA_1748953133
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so38476065e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 05:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748953133; x=1749557933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5eb0iVseY34ZQu1KucxpS4ti1Op2BFBWowNjVgENOwk=;
 b=ER22xqvWwN8LKkJuC2q0/KUJdy18WCZBzoUcsLE89NDN2vRxKyiN4PaG1x14qdZqRD
 hA3M/yVyQnASUJAKWynhmNkdMa4pTBKCTNYjPJCsHWhdNwzJFjdfU/6LQnefVm4BnCP+
 C68n9W1LUPwsKnP0MLDDcG7bzk1z1/4MigsaVGO8YHxjtZ7hOdeTZ0gSbrNujvTsvJe0
 z9SOCsNXqihgzVC031dwNMJ8KHijTJzxuA2ytd8XwosHSOxNRvFEXWxH/yeUrenysvCd
 hIZKLzKxMx2fL3K9sDUFPxpKwl98nvpb9zNJQFucQUgyF1Yx6etdiWxDGcewMpHPrLoN
 ViaQ==
X-Gm-Message-State: AOJu0Yxr0ljp08p7FsmdhmSXKEn7LYGTXYqcV6lGv3+g0dJNSh8Y7JSQ
 E5c88NqrMvekdzzWF1AtocYXg7zYw95hHKtvlPsyOBW39e3mNyDedIhgJ1fOzbYLtFRpZyP+scK
 g6qRNWrb0yEm667Y+iHb/ZBylDL96DZx2Vp4JxDS6VCZ3l1uJcMDvPTZl
X-Gm-Gg: ASbGncvEm3FMxn34dZ1+dNi3KWtX7UafDwm//Tv0PZ7R3EpMIJya/cICG2MBCSuIA32
 Ef8yD/GCV0gwLjw+PIDmeSz3LCSpXdKJMcHGk7Yn6GmuXCJvPxLbs0qVZ4iEoN9I+FTQbo9xJsf
 hnx4HhxSAkvhXpDw5aWl+Dd7SPYOaL5u3ozV5GlvHXcV//yXr1yguSYkFiC+6eSp+z1WKeJv/is
 ICL9tx6VpEIYIX7ypnk7TZU0w3JIn02RFR80g8HvFIipE/ixltrCEd7+2YMO98x4D42Y3QcymyZ
 zgIoGUVc20uxApGKWfF3p1Mbp7/4RaM6
X-Received: by 2002:a05:600c:548c:b0:43c:fe5e:f03b with SMTP id
 5b1f17b1804b1-45126572d16mr126938095e9.30.1748953132491; 
 Tue, 03 Jun 2025 05:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjntnnbE+lGxhKk091dsgk8E7AwEHY5e9DHXtpHv84aiOzgKPEmJUOtAvboZLN0aPxAA8bGQ==
X-Received: by 2002:a05:600c:548c:b0:43c:fe5e:f03b with SMTP id
 5b1f17b1804b1-45126572d16mr126937795e9.30.1748953132073; 
 Tue, 03 Jun 2025 05:18:52 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a1678sm18214147f8f.99.2025.06.03.05.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 05:18:51 -0700 (PDT)
Date: Tue, 3 Jun 2025 14:18:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Annie Li <annie.li@oracle.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
Subject: Re: [PATCH 00/13] Support ACPI Control Method Sleep button
Message-ID: <20250603141850.27d2daf0@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250528163545.2143-1-annie.li@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 28 May 2025 12:35:45 -0400
Annie Li <annie.li@oracle.com> wrote:

> The ACPI sleep button can be implemented as a fixed hardware button
> or Control Method Sleep button.
> 
> The patch of implementing a fixed hardware sleep button was posted
> here 1). More discussions can be found here 2). Essentially, the
> discussion mainly focuses on whether the sleep button is implemented
> as a fixed hardware button or Control Method Sleep button. The latter
> benefits various architectures since the code can be shared among
> them.
> 
> This patch set implements Control Method Sleep button for both x86
> and microvm. The RFC V1 patch set was posted previously here 3). We
> rebase all the patches on QEMU9.1.0 and re-post RFC V2 here 4). The
> RFC V3 patch is based on QEMU 10.0.0-rc3 at 5). This patch set here
> is rebased on QEMU 10.0.1. The sleep button support for microvm is
> added, however, its support for ARM platform in V2 is removed due to
> lower interests of it and more efforts in the firmware.

here we probably need a pointer to these efforts, or some kind of description
about what's wrong with ARM/firmare

> 
> For x86, a sleep button GPE event handler is implemented, so a GPE
> event is triggered to indicate the OSPM the sleep button is pressed.
> Tests have been done for Linux guest, and Windows Server guest,
> this sleep button works as expected.
> 
> For microvm, a GED event is triggered to notify the OSPM. This GED
> event is also applicable for ARM platform, as mentioned earlier, the
> implementation for ARM platform has been removed since RFC V3 patch
> set. Tests have been run for Linux microvm guests.


> System_wakeup doesn't work for microvm for now due to the missing
> support of it. This patch set only covers system_sleep, not the
> wakeup part.

ditto (aka what's wrong with wakeup)

> 
> 1) https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06478.html
> 2) https://lore.kernel.org/all/20210920095316.2dd133be@redhat.com/T/#mfe24f89778020deeacfe45083f3eea3cf9f55961
> 3) https://lore.kernel.org/all/20231205002143.562-1-annie.li@oracle.com/T/
> 4) https://patchwork.kernel.org/project/qemu-devel/cover/20240927183906.1248-1-annie.li@oracle.com/
> 5) https://lore.kernel.org/all/20250411201912.2872-1-annie.li@oracle.com/
> 
> ----Changes from RFC V3----
> Improve source code and comment based on comments on RFC V3
> ---------------------------
> 
> Annie Li (12):
>   acpi: Implement control method sleep button
>   test/acpi: allow DSDT table changes for x86 platform
>   acpi: Support Control Method sleep button for x86
>   tests/qtest/bios-table-tests: Update ACPI table binaries for x86
>   acpi: Send the GPE event of sleep for x86
>   test/acpi: allow DSDT table changes for microvm
>   microvm: Add ACPI Control Method Sleep Button
>   microvm: enable sleep GED event
>   tests/qtest/bios-table-tests: Update ACPI table binaries for microvm
>   microvm: suspend the system as requested
>   microvm: enable suspend
>   acpi: hmp/qmp: Add hmp/qmp support for system_sleep
> 
> Miguel Luis (1):
>   hw/acpi: Add ACPI GED support for the sleep event
> 
>  hmp-commands.hx                               |  14 +++++++
>  hw/acpi/control_method_device.c               |  38 ++++++++++++++++++
>  hw/acpi/core.c                                |  12 ++++++
>  hw/acpi/generic_event_device.c                |  12 ++++++
>  hw/acpi/meson.build                           |   1 +
>  hw/core/machine-hmp-cmds.c                    |   5 +++
>  hw/core/machine-qmp-cmds.c                    |  11 +++++
>  hw/i386/acpi-build.c                          |  24 ++++++++++-
>  hw/i386/acpi-microvm.c                        |  13 +++++-
>  hw/i386/microvm.c                             |   4 +-
>  include/hw/acpi/acpi.h                        |   1 +
>  include/hw/acpi/acpi_dev_interface.h          |   1 +
>  include/hw/acpi/control_method_device.h       |  21 ++++++++++
>  include/hw/acpi/generic_event_device.h        |   2 +
>  include/monitor/hmp.h                         |   1 +
>  qapi/machine.json                             |  20 +++++++++
>  qapi/pragma.json                              |   1 +
>  tests/data/acpi/x86/microvm/DSDT              | Bin 365 -> 442 bytes
>  tests/data/acpi/x86/microvm/DSDT.ioapic2      | Bin 365 -> 442 bytes
>  tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 3100 bytes
>  tests/data/acpi/x86/microvm/DSDT.rtc          | Bin 404 -> 481 bytes
>  tests/data/acpi/x86/microvm/DSDT.usb          | Bin 414 -> 491 bytes
>  tests/data/acpi/x86/pc/DSDT                   | Bin 8611 -> 8721 bytes
>  tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8522 -> 8632 bytes
>  tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9936 -> 10046 bytes
>  tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15482 -> 15592 bytes
>  tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9075 -> 9185 bytes
>  tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10265 -> 10375 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8562 -> 8672 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5100 -> 5210 bytes
>  tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8683 -> 8793 bytes
>  tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9970 -> 10080 bytes
>  tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8469 -> 8579 bytes
>  tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8617 -> 8727 bytes
>  tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12404 -> 12514 bytes
>  tests/data/acpi/x86/q35/DSDT                  | Bin 8440 -> 8550 bytes
>  tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8457 -> 8567 bytes
>  tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9765 -> 9875 bytes
>  .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12650 -> 12760 bytes
>  .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8719 -> 8829 bytes
>  tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8486 -> 8596 bytes
>  tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12053 -> 12163 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12998 -> 13108 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33855 -> 33965 bytes
>  tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8904 -> 9014 bytes
>  tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13231 -> 13341 bytes
>  tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10094 -> 10204 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8515 -> 8625 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8528 -> 8638 bytes
>  tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8457 -> 8567 bytes
>  tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9799 -> 9909 bytes
>  tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9570 -> 9680 bytes
>  tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13293 -> 13403 bytes
>  tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8302 -> 8412 bytes
>  tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8298 -> 8408 bytes
>  tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8446 -> 8556 bytes
>  tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8541 -> 8651 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12998 -> 13108 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33855 -> 33965 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9046 -> 9156 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9072 -> 9182 bytes
>  tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18674 -> 18784 bytes
>  tests/data/acpi/x86/q35/DSDT.viot             | Bin 14697 -> 14807 bytes
>  tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35803 -> 35913 bytes
>  64 files changed, 178 insertions(+), 3 deletions(-)
>  create mode 100644 hw/acpi/control_method_device.c
>  create mode 100644 include/hw/acpi/control_method_device.h
> 


