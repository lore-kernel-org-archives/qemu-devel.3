Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5289CC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 05:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfv07-0003yl-TE; Mon, 19 Aug 2024 01:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sfuzo-0002XE-Al
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 01:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sfuzm-00056Y-MS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 01:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724045517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RH0ysvCwiDD6BUVvceG6WstRkYD2wwJ9b+IfnvkifDM=;
 b=FH1/iWQMHFZ8wqWA/dz7JJCYELe4JzY+AVR6kEqwy8VX+4yTfi5hf5UjjMvV9w0vxjOcXy
 yZCLzlyg1MsamOf7I8tABnr2PzNaJHNjbv/a5os/5kljmB2qH0jOeFue5Lgtnv6dR10s/s
 LWVW8mOjnG/CrkyERSxhZGws3nfrivc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-IQsXP67UNYqSOBvonq375w-1; Mon, 19 Aug 2024 01:31:55 -0400
X-MC-Unique: IQsXP67UNYqSOBvonq375w-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2d3c0ca91f8so3318175a91.3
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 22:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724045514; x=1724650314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RH0ysvCwiDD6BUVvceG6WstRkYD2wwJ9b+IfnvkifDM=;
 b=ICwXB5NCk5PxhDV2oCxn6SwvK4lNvN3kq7c/B+aRn/OLSlwqfk5z/K/E7AVUpIvQBh
 luHtRfCJTKssINOaXtS6py1AIoweGqZ7ilvmDncu7Q3hbKTu/yOEw94yV1BuVaIWdLaq
 Fy9dAHKzqD5WptcdI39sLXAOY8m9aG2SjY/Wsr5lhFSNCrjlbPeLPf+GuhlR1NqBziNY
 yfA7+jj1pKcpzj84LY7hEeg77isL4DS6Wv887zMtFvlxvtOnCl1qNhvjQXRNxsXv63Rn
 D53c5FRMKgGYrTnrSJLGnRHPFdX7gqA07bW/+z6EIVp75CY2S8sfGBQjPVmFmtYmRSH/
 OVbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXMUJuaExAyJ9jRd44cWBFMOKfWwY+7i0uX0zn3NWbcukEBUcA3uQGM3GcUdkLbladJ/kjB0Tohis3eur0yqU/fVaqi9g=
X-Gm-Message-State: AOJu0YwhKUACMlkQwD/BTHUe/TRbUhVbE3i6JThgajVyoIcSmFdEaFqk
 VdVC57NNyCBn6MRKOnb4ZMLG0Hfa8JqMXlaFuYvwO7/H3eFOOU97WeYEte12nJxUV+x1loknVXk
 HVY8+9iIFRnBFgZTGCb+FCt55IZk5jzdEWtRufWNEolBS5V5ymOxH
X-Received: by 2002:a17:90a:8c11:b0:2d3:c05c:c51 with SMTP id
 98e67ed59e1d1-2d3dfacb1eemr8581382a91.0.1724045514183; 
 Sun, 18 Aug 2024 22:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwFRyVVzsVTza0X12yGP+l3lP4fNF7SDArfLHBmeVCTzvyIPzLh0yEiYpm4qnk+wtdsntazQ==
X-Received: by 2002:a17:90a:8c11:b0:2d3:c05c:c51 with SMTP id
 98e67ed59e1d1-2d3dfacb1eemr8581366a91.0.1724045513697; 
 Sun, 18 Aug 2024 22:31:53 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7dcfc7sm10154019a91.14.2024.08.18.22.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 22:31:53 -0700 (PDT)
Message-ID: <28f3107f-0267-4112-b0ca-da59df2968ae@redhat.com>
Date: Mon, 19 Aug 2024 15:31:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 06/29] arm/virt,kvm: Pre-create disabled possible
 vCPUs @machine init
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com,
 zhao1.liu@intel.com, linuxarm@huawei.com
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-7-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240613233639.202896-7-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/14/24 9:36 AM, Salil Mehta wrote:
> In the ARMv8 architecture, the GIC must know all the CPUs it is connected to
> during its initialization, and this cannot change afterward. This must be
> ensured during the initialization of the VGIC as well in KVM, which requires all
> vCPUs to be created and present during its initialization. This is necessary
> because:
> 
> 1. The association between GICC and MPIDR must be fixed at VM initialization
>     time. This is represented by the register `GIC_TYPER(mp_affinity, proc_num)`.
> 2. GICC (CPU interfaces), GICR (redistributors), etc., must all be initialized
>     at boot time.
> 3. Memory regions associated with GICR, etc., cannot be changed (added, deleted,
>     or modified) after the VM has been initialized.
> 
> This patch adds support to pre-create all possible vCPUs within the host using
> the KVM interface as part of the virtual machine initialization. These vCPUs can
> later be attached to QOM/ACPI when they are actually hot-plugged and made
> present.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reported-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> [VP: Identified CPU stall issue & suggested probable fix]
> ---
>   hw/arm/virt.c         | 56 +++++++++++++++++++++++++++++++++++--------
>   include/hw/core/cpu.h |  1 +
>   target/arm/cpu64.c    |  1 +
>   target/arm/kvm.c      | 41 ++++++++++++++++++++++++++++++-
>   target/arm/kvm_arm.h  | 11 +++++++++
>   5 files changed, 99 insertions(+), 11 deletions(-)
> 

The vCPU file descriptor is associated with a feature bitmap when the file descriptor
is initialized by ioctl(vm_fd, KVM_ARM_VCPU_INIT, &init). The feature bitmap is sorted
out based on the vCPU properties. The vCPU properties can be different when the vCPU
file descriptor is initialized for the first time when the vCPU is instantiated, and
re-initialized when the vCPU is hot added.

It can lead to system crash as below. We probably need a mechanism to disallow passing
extra properties when vCPU is hot added to avoid the conflicts to the global properties
from the command line "-cpu host,pmu=on". Some of the properties like "id", "socket-id"
are still needed.

/home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                  \
-accel kvm -machine virt,gic-version=host,nvdimm=on                      \
-cpu host -smp maxcpus=2,cpus=1,sockets=2,clusters=1,cores=1,threads=1   \
-m 4096M,slots=16,maxmem=128G                                            \
-object memory-backend-ram,id=mem0,size=2048M                            \
-object memory-backend-ram,id=mem1,size=2048M                            \
-numa node,nodeid=0,memdev=mem0,cpus=0-0                                 \
-numa node,nodeid=1,memdev=mem1,cpus=1-1                                 \
-L /home/gavin/sandbox/qemu.main/build/pc-bios                           \
-monitor none -serial mon:stdio -nographic                               \
-gdb tcp::6666 -qmp tcp:localhost:5555,server,wait=off                   \
-bios /home/gavin/sandbox/qemu.main/build/pc-bios/edk2-aarch64-code.fd   \
-kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image            \
-initrd /home/gavin/sandbox/images/rootfs.cpio.xz                        \
-append memhp_default_state=online_movable                               \
     :
(qemu) device_add host-arm-cpu,id=cpu1,socket-id=1,pmu=off
kvm_arch_init_vcpu: Error -22 from kvm_arm_vcpu_init()
qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (1): Invalid argument

Thanks,
Gavin


