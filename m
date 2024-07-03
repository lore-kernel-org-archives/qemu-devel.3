Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AED3C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8wL-0007oJ-Cg; Wed, 03 Jul 2024 18:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8wJ-0007nD-S4
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8wF-0001wL-Qr
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=brHSGsqrcLMqSJxNNitPv2WvhUun9R7fdVCQLQot1KY=;
 b=Ljbj+0Ny3SWT3XVXsAIJL8TMzZ/yf6Vh0M9hfFTKaOoW2Ewv0cM4jM2QWpKBF1OZVntdie
 7UdlhVnjuf7JZ5jz6YpGBel8Mv2JweakJrvnD41wuS+eeiL5YicVLqTBlOfZC34G5N7LCF
 HX7uhwb6WOR2X4nC/R5knVxNp/UfEH4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-xmsqSu7VMhi4zkHrBOcSPA-1; Wed, 03 Jul 2024 18:58:57 -0400
X-MC-Unique: xmsqSu7VMhi4zkHrBOcSPA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-58d24cad85aso4288a12.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047536; x=1720652336;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=brHSGsqrcLMqSJxNNitPv2WvhUun9R7fdVCQLQot1KY=;
 b=t5FbiRdPJOeAJENrKbWu0z8Fc2gApIU5bz9ohg6khfCS1/QZISWajWgB4r/RGql2+M
 VET8DuFaI0kyDG8wAV3An8tJBZur0PyPU1YEYzaK9e35qWFigb97lZcVp733DGWqnnkC
 5TKOac3M9TO9E2z1ddT3nSA/1DPFaaXarUY1UNcjx/maf1Yzp4BJXARGgWQ11WTWKD3+
 Qx7zCAZrKrUOkv5NFM7HLJ2eEVdXqdnvimK2PWRpz7/GDvGqLK7BP3XDheK4UtQcsH9A
 CMm3RaCwocv/m2lNmf/tJviLEZl3APdW+0qtQS3BjqUh4wwahvo5kAlEFgXdoWciTARK
 H31A==
X-Gm-Message-State: AOJu0Yz2gU/Js70GlMBL6EM75ERY0Hqk5T/DvvW4/O6i0aaSbGvdE5ci
 MehU2junWHYOzoVdkZKPUcoBTdLG9DSyv0bQIEPzFk/DYgQs2QCZ0AD+c1Y9085Klx8tz30320Q
 YEV3JDSiD85DsO2J6PpUXlB8tSD+T1hiZ5/89XDjdUNFIvMeM8jac
X-Received: by 2002:a05:6402:354c:b0:579:ca97:da1b with SMTP id
 4fb4d7f45d1cf-5879ece9247mr9496349a12.6.1720047536050; 
 Wed, 03 Jul 2024 15:58:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVbBLAggWsGv8AvIQXEOFiIzgekmJelyRWbXuEITrYhZdDJZZguWbGMpghptKB+lER86HZyA==
X-Received: by 2002:a05:6402:354c:b0:579:ca97:da1b with SMTP id
 4fb4d7f45d1cf-5879ece9247mr9496302a12.6.1720047535251; 
 Wed, 03 Jul 2024 15:58:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58613159103sm7644927a12.24.2024.07.03.15.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:58:54 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:58:43 -0400
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
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com
Subject: Re: [PATCH V13 0/8] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <20240703185812-mutt-send-email-mst@kernel.org>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607115649.214622-1-salil.mehta@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 07, 2024 at 12:56:41PM +0100, Salil Mehta wrote:
> Virtual CPU hotplug support is being added across various architectures[1][3].
> This series adds various code bits common across all architectures:
> 
> 1. vCPU creation and Parking code refactor [Patch 1]
> 2. Update ACPI GED framework to support vCPU Hotplug [Patch 2,3]
> 3. ACPI CPUs AML code change [Patch 4,5]
> 4. Helper functions to support unrealization of CPU objects [Patch 6,7]
> 5. Docs [Patch 8]

Igor - it's been a while. Looks ok to me superficially. Do you plan to review?

> 
> Repository:
> 
> [*] https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v3.arch.agnostic.v13
> 
> NOTE: This series is meant to work in conjunction with Architecture specific patch-set.
> For ARM, a combined patch-set (arch agnostic + specific) was earlier pushed as RFC V2[1].
> A ARM architecture specific patch-set (subset of RFC V2) is being finalized and shall
> be floated soon as RFC-V3. Please find a version of it compatible with this patch-set at
> the below location. (TCG support is broken in below and is being fixed)
> 
> [*] https://github.com/salil-mehta/qemu/tree/virt-cpuhp-armv8/rfc-v3-rc2
> 
> 
> Revision History:
> 
> Patch-set  V12 -> V13
> 1. Added Reviewed-by Tag of Harsh Prateek Bora's (IBM) [PATCH V12 1/8]
> 2. Moved the kvm_{create,park,unpark}_vcpu prototypes from accel/kvm/kvm-cpus.h
>    to include/sysemu/kvm.h. These can later be exported through AccelOps.
> Link: https://lore.kernel.org/qemu-devel/62f55169-1796-4d8e-a35d-7f003a172750@linux.ibm.com/
> 
> Patch-set  V11 -> V12
> 1. Addressed Harsh Prateek Bora's (IBM) comment
>    - Changed @cpu to @vcpu_id in the kvm_unpark_vcpu protoype header/
> 2. Added Zhao Liu's (Intel) Tested-by for whole series
>    - Qtest does not breaks on Intel platforms now.
> 3. Added Zhao Liu's (Intel) Reviewed-by for [PATCH V11 {1/8 - 3/8}]
> Link: https://lore.kernel.org/qemu-devel/ZlRSPuJGBgyEUW6w@intel.com/
> Link: https://lore.kernel.org/qemu-devel/a5f3d78e-cfed-441f-9c56-e3e78fa5edee@linux.ibm.com/
> 
> Patch-set  V10 -> V11
> 1. Addressed Nicholas Piggin's (IBM) comment
>    - moved the traces in kvm_unpark_vcpu and kvm_create_vcpu at the end
>    - Added the Reviewed-by Tag for [PATCH V10 1/8]
> 2.  Addressed Alex Bennée's (Linaro) comments
>    - Added a note explaining dependency of the [PATCH V10 7/8] on Arch specific patch-set
> Link: https://lore.kernel.org/qemu-devel/D1FS5GOOFWWK.2PNRIVL0V6DBL@gmail.com/ 
> Link: https://lore.kernel.org/qemu-devel/87frubi402.fsf@draig.linaro.org/
> 
> Patch-set  V9 -> V10
> 1. Addressed Nicholas Piggin's (IBM) & Philippe Mathieu-Daudé (Linaro) comments
>    - carved out kvm_unpark_vcpu and added its trace
>    - Widened the scope of the kvm_unpark_vcpu so that it can be used by generic framework
>      being thought out
> Link: https://lore.kernel.org/qemu-devel/20240519210620.228342-1-salil.mehta@huawei.com/
> Link: https://lore.kernel.org/qemu-devel/e94b0e14-efee-4050-9c9f-08382a36b63a@linaro.org/
> 
> Patch-set  V8 -> V9
> 1. Addressed Vishnu Pajjuri's (Ampere) comments
>    - Added kvm_fd to trace in kvm_create_vcpu
>    - Some clean ups: arch vcpu-id and sbd variable
>    - Added the missed initialization of cpu->gdb_num_regs
> 2. Addressed the commnet from Zhao Liu (Intel)
>    - Make initialization of CPU Hotplug state conditional (possible_cpu_arch_ids!=NULL)
> Link: https://lore.kernel.org/qemu-devel/20240312020000.12992-1-salil.mehta@huawei.com/
> 
> Patch-set V7 -> V8
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
>  accel/kvm/kvm-all.c                    | 95 +++++++++++++++++---------
>  accel/kvm/kvm-cpus.h                   |  1 -
>  accel/kvm/trace-events                 |  5 +-
>  docs/specs/acpi_hw_reduced_hotplug.rst |  3 +-
>  gdbstub/gdbstub.c                      | 13 ++++
>  hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++
>  hw/acpi/cpu.c                          | 33 ++++++---
>  hw/acpi/generic_event_device.c         | 21 ++++++
>  hw/core/cpu-common.c                   |  1 -
>  hw/i386/acpi-build.c                   |  3 +-
>  include/exec/cpu-common.h              |  8 +++
>  include/exec/gdbstub.h                 |  6 ++
>  include/hw/acpi/cpu.h                  |  5 +-
>  include/hw/acpi/cpu_hotplug.h          |  4 ++
>  include/hw/acpi/generic_event_device.h |  4 ++
>  include/hw/core/cpu.h                  |  1 +
>  include/sysemu/kvm.h                   | 25 +++++++
>  system/physmem.c                       | 29 ++++++++
>  18 files changed, 214 insertions(+), 49 deletions(-)
> 
> -- 
> 2.34.1


