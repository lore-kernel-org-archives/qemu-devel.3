Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900BCC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk6Qe-0001f3-2P; Tue, 12 Mar 2024 14:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk6QK-0001b2-M0
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk6QH-0002o4-AC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710266417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SO0EPgm7BqsnG8vdVPs/h99HjcNJP0V+y7vUnzFvtdU=;
 b=PYcVjlH9Y8bdZhZco7A4HWlvNYiQCnGLheydYesxDR5FTQSIGoEKbyoI6IU0WVzCyr5WkE
 swpwEYgj+jlY80yH9hHdQT164ai4YDUQl3EDUyusOSwa0t04mtgqGZWQuqFN3xlk0Um1eM
 rfBbNuPjIapC2/or407iQ0/7pQXlWBA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-0URBOYqgNpuc_SGFX0JG1g-1; Tue, 12 Mar 2024 14:00:14 -0400
X-MC-Unique: 0URBOYqgNpuc_SGFX0JG1g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412fb99c892so1008625e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710266413; x=1710871213;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SO0EPgm7BqsnG8vdVPs/h99HjcNJP0V+y7vUnzFvtdU=;
 b=OT3/udllsvAGizBynxZSlxjak5NbP+crp2/Ph+MXGAB/fkl6oKis3sqfzkFrYLhr3A
 0bGODPce0Zy7rM9Vyhrf4QcN2fCKYK1QAF6m7bimzl5WFC9Hgazk5XsNPtZRvEB722ug
 2Q3BgnCnyqhJzxU3WkMRnpJjU9RHhc8szVh+UglgL39TdtmzDGmgRVxWnBWXiRVk7k9B
 gDS6EEPws0eqA/OEzVnuT/mE9jcSGKs5FcSd+kQt2ahHRbF18r6HX3LkqgRz2VZkMcRK
 8x5FSmzkpaOZLeak0w60HhbMJeqXqXLdBIqHkYbpY4hNI2ojTuTkt3KISmhUM/ArSfRc
 nb9A==
X-Gm-Message-State: AOJu0Yy3TTF7WrJPnC2zqNlkx4FygoFDe/sIfeTrMbVv3c95/0lDLylR
 PNb5sUW2/fhjbVn0P27Y0Cf0W5SdZ/+54q+l3Ac8R9MnyMCTY8mnZSFyoGP+GKxw3O5oequjqiw
 +ozwRH/GBGLu7wdwUYZVqhgZsseAWoCTktyNBvFTkmX6ogzqSuPU2
X-Received: by 2002:a05:600c:4f09:b0:413:1dae:dcdd with SMTP id
 l9-20020a05600c4f0900b004131daedcddmr700845wmq.6.1710266412766; 
 Tue, 12 Mar 2024 11:00:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHenfbcrL4F39Xr0c8AcnFTnNoML5e+nuBrQba39mLX6tlrOXamE8ijLL8NE71pUMR1LW/C8g==
X-Received: by 2002:a05:600c:4f09:b0:413:1dae:dcdd with SMTP id
 l9-20020a05600c4f0900b004131daedcddmr700785wmq.6.1710266412041; 
 Tue, 12 Mar 2024 11:00:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm17546130wmo.0.2024.03.12.11.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:00:11 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:00:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, linuxarm@huawei.com
Subject: Re: [PATCH V8 0/8] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <20240312135802-mutt-send-email-mst@kernel.org>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312020000.12992-1-salil.mehta@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 12, 2024 at 01:59:52AM +0000, Salil Mehta wrote:
> Virtual CPU hotplug support is being added across various architectures[1][3].
> This series adds various code bits common across all architectures:
> 
> 1. vCPU creation and Parking code refactor [Patch 1]
> 2. Update ACPI GED framework to support vCPU Hotplug [Patch 2,3]
> 3. ACPI CPUs AML code change [Patch 4,5]
> 4. Helper functions to support unrealization of CPU objects [Patch 6,7]
> 5. Docs [Patch 8]


I replied separately: patch 1 needs ack from KVM maintainers.

I suspect I could pick some bits I have no way to know
whether they were tested separately.
In any way looks like something best left to next release ...

> 
> Repository:
> 
> [*] https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2.common.v8
> 
> 
> Revision History:
> 
> Patch-set V7 -> V8
> 
> 1. Rebased and Fixed the conflicts
> 
> Patch-set  V6 -> V7
> 1. Addressed Alex Bennée's comments
>    - Updated the docs
> 2. Addressed Igor Mammedov's comments
>    - Merged patches [Patch V6 3/9] & [Patch V6 7/9] with [Patch V6 4/9]
>    - Updated commit-log of [Patch V6 1/9] and [Patch V6 5/9]     
> 3. Added Shaoqin Huang's Reviewed-by tags for whole series.
> Link: https://lore.kernel.org/qemu-devel/20231013105129.25648-1-salil.mehta@huawei.com/
> 
> Patch-set  V5 -> V6
> 1. Addressed Gavin Shan's comments
>    - Fixed the assert() ranges of address spaces
>    - Rebased the patch-set to latest changes in the qemu.git
>    - Added Reviewed-by tags for patches {8,9}
> 2. Addressed Jonathan Cameron's comments
>    - Updated commit-log for [Patch V5 1/9] with mention of trace events
>    - Added Reviewed-by tags for patches {1,5}
> 3. Added Tested-by tags from Xianglai Li
> 4. Fixed checkpatch.pl error "Qemu -> QEMU" in [Patch V5 1/9] 
> Link: https://lore.kernel.org/qemu-devel/20231011194355.15628-1-salil.mehta@huawei.com/
> 
> Patch-set  V4 -> V5
> 1. Addressed Gavin Shan's comments
>    - Fixed the trace events print string for kvm_{create,get,park,destroy}_vcpu
>    - Added Reviewed-by tag for patch {1}
> 2. Added Shaoqin Huang's Reviewed-by tags for Patches {2,3}
> 3. Added Tested-by Tag from Vishnu Pajjuri to the patch-set
> 4. Dropped the ARM specific [Patch V4 10/10]
> Link: https://lore.kernel.org/qemu-devel/20231009203601.17584-1-salil.mehta@huawei.com/
> 
> Patch-set  V3 -> V4
> 1. Addressed David Hilderbrand's comments
>    - Fixed the wrong doc comment of kvm_park_vcpu API prototype
>    - Added Reviewed-by tags for patches {2,4}
> Link: https://lore.kernel.org/qemu-devel/20231009112812.10612-1-salil.mehta@huawei.com/
> 
> Patch-set  V2 -> V3
> 1. Addressed Jonathan Cameron's comments
>    - Fixed 'vcpu-id' type wrongly changed from 'unsigned long' to 'integer'
>    - Removed unnecessary use of variable 'vcpu_id' in kvm_park_vcpu
>    - Updated [Patch V2 3/10] commit-log with details of ACPI_CPU_SCAN_METHOD macro
>    - Updated [Patch V2 5/10] commit-log with details of conditional event handler method
>    - Added Reviewed-by tags for patches {2,3,4,6,7}
> 2. Addressed Gavin Shan's comments
>    - Remove unnecessary use of variable 'vcpu_id' in kvm_par_vcpu
>    - Fixed return value in kvm_get_vcpu from -1 to -ENOENT
>    - Reset the value of 'gdb_num_g_regs' in gdb_unregister_coprocessor_all
>    - Fixed the kvm_{create,park}_vcpu prototypes docs
>    - Added Reviewed-by tags for patches {2,3,4,5,6,7,9,10}
> 3. Addressed one earlier missed comment by Alex Bennée in RFC V1
>    - Added traces instead of DPRINTF in the newly added and some existing functions
> Link: https://lore.kernel.org/qemu-devel/20230930001933.2660-1-salil.mehta@huawei.com/
> 
> Patch-set V1 -> V2
> 1. Addressed Alex Bennée's comments
>    - Refactored the kvm_create_vcpu logic to get rid of goto
>    - Added the docs for kvm_{create,park}_vcpu prototypes
>    - Splitted the gdbstub and AddressSpace destruction change into separate patches
>    - Added Reviewed-by tags for patches {2,10}
> Link: https://lore.kernel.org/qemu-devel/20230929124304.13672-1-salil.mehta@huawei.com/
> 
> References:
> 
> [1] https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/
> [2] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> [3] https://lore.kernel.org/qemu-devel/cover.1695697701.git.lixianglai@loongson.cn/
> 
> 
> 
> Salil Mehta (8):
>   accel/kvm: Extract common KVM vCPU {creation,parking} code
>   hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header file
>   hw/acpi: Update ACPI GED framework to support vCPU Hotplug
>   hw/acpi: Update GED _EVT method AML with CPU scan
>   hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
>   physmem: Add helper function to destroy CPU AddressSpace
>   gdbstub: Add helper function to unregister GDB register space
>   docs/specs/acpi_hw_reduced_hotplug: Add the CPU Hotplug Event Bit
> 
>  accel/kvm/kvm-all.c                    | 64 ++++++++++++++++++++------
>  accel/kvm/trace-events                 |  5 +-
>  docs/specs/acpi_hw_reduced_hotplug.rst |  3 +-
>  gdbstub/gdbstub.c                      | 12 +++++
>  hw/acpi/acpi-cpu-hotplug-stub.c        |  6 +++
>  hw/acpi/cpu.c                          | 27 +++++++----
>  hw/acpi/generic_event_device.c         | 21 +++++++++
>  hw/i386/acpi-build.c                   |  3 +-
>  include/exec/cpu-common.h              |  8 ++++
>  include/exec/gdbstub.h                 |  6 +++
>  include/hw/acpi/cpu.h                  |  5 +-
>  include/hw/acpi/cpu_hotplug.h          |  4 ++
>  include/hw/acpi/generic_event_device.h |  4 ++
>  include/hw/core/cpu.h                  |  1 +
>  include/sysemu/kvm.h                   | 16 +++++++
>  system/physmem.c                       | 29 ++++++++++++
>  16 files changed, 185 insertions(+), 29 deletions(-)
> 
> -- 
> 2.34.1


