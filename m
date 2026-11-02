Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12235606A32C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 01:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=faVH0eW6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNhFZ-00041F-JB; Sun, 01 Nov 2026 20:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangjinqian1@huawei.com>)
 id 1xNhFX-00040Y-Jj; Sun, 01 Nov 2026 20:54:15 -0500
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangjinqian1@huawei.com>)
 id 1xNhFT-0000c9-3c; Sun, 01 Nov 2026 20:54:15 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=hA9WFk5dT08Xh5s5QzSEiH7gBPsEOCExXhSK0TLdeL4=;
 b=faVH0eW6vA7ZNJCziwhWGWQl18cUtLrUwRHaiE6qCYIVHfAQQXo8dFAjKkLm+WFpeo2lwmGoE
 gR0khtxiuaPURVizzE2Fo8R0mP7BVc+1ejb2vbYbRkTgVC4DeYMz6TAtY8ElayypQt3wQMKy8HX
 V9JDi4vvLIa4Oi5iIcjC7Ts=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jHvr71xTMzRhTp;
 Mon,  2 Nov 2026 09:53:43 +0800 (CST)
Received: from kwepemk300013.china.huawei.com (unknown [7.202.194.231])
 by mail.maildlp.com (Postfix) with ESMTPS id 258574056E;
 Mon,  2 Nov 2026 09:53:48 +0800 (CST)
Received: from [10.67.121.183] (10.67.121.183) by
 kwepemk300013.china.huawei.com (7.202.194.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 2 Nov 2026 09:53:47 +0800
Message-ID: <02488dd0-ba2e-4dd4-8141-99189e926125@huawei.com>
Date: Mon, 2 Nov 2026 09:53:45 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] hw/arm/virt: Add support for Target
 Implementation CPUs
To: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <cohuck@redhat.com>, <sebott@redhat.com>,
 <berrange@redhat.com>, <peter.maydell@linaro.org>,
 <khushit.shah@nutanix.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <wangzhou1@hisilicon.com>, <maz@kernel.org>,
 <oliver.upton@linux.dev>
References: <20260911152754.706518-1-skolothumtho@nvidia.com>
From: Jinqian Yang <yangjinqian1@huawei.com>
In-Reply-To: <20260911152754.706518-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk300013.china.huawei.com (7.202.194.231)
Received-SPF: pass client-ip=113.46.200.221;
 envelope-from=yangjinqian1@huawei.com; helo=canpmsgout06.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Shameer,

We tested this series on HIP09 and HIP12, with the mainline kernel
side support (host and guest both v7.3-rc7).

Both ends of the migration run QEMU from Eric's v8 branch plus this
series, with the same target implementation CPU list:

```
./qemu-system-aarch64 -machine virt,gic-version=3 \
-enable-kvm -bios QEMU_EFI.fd -m 4G -smp cpus=4,maxcpus=4 \
-cpu host,pauth=off,pmu=off,sve=off,\
SYSREG_ID_AA64ISAR1_EL1_LS64=0x0,\
SYSREG_ID_AA64ISAR1_EL1_XS=0x0,\
SYSREG_ID_AA64ISAR1_EL1_LRCPC=0x2,\
SYSREG_ID_AA64ISAR2_EL1_RPRFM=0x0,\
SYSREG_ID_AA64ISAR2_EL1_CLRBHB=0x0,\
SYSREG_ID_AA64ISAR2_EL1_PAC_frac=0x0,\
SYSREG_ID_AA64ISAR2_EL1_BC=0x0,\
SYSREG_ID_AA64ISAR2_EL1_RPRES=0x0,\
SYSREG_ID_AA64ISAR2_EL1_WFxT=0x0,\
SYSREG_ID_AA64MMFR0_EL1_FGT=0x0,\
SYSREG_ID_AA64MMFR0_EL1_BigEnd=0x0,\
SYSREG_ID_AA64MMFR1_EL1_ECBHB=0x0,\
SYSREG_ID_AA64MMFR1_EL1_CMOW=0x0,\
SYSREG_ID_AA64MMFR1_EL1_TIDCP1=0x0,\
SYSREG_ID_AA64MMFR1_EL1_nTLBPA=0x0,\
SYSREG_ID_AA64MMFR1_EL1_AFP=0x0,\
SYSREG_ID_AA64MMFR1_EL1_HCX=0x0,\
SYSREG_ID_AA64MMFR1_EL1_ETS=0x0,\
SYSREG_ID_AA64MMFR1_EL1_PAN=0x2,\
SYSREG_ID_AA64MMFR1_EL1_HAFDBS=0x2,\
SYSREG_ID_AA64MMFR2_EL1_CnP=0x0,\
SYSREG_ID_AA64MMFR3_EL1_TCRX=0x0,\
SYSREG_ID_AA64DFR0_EL1_DebugVer=0x9,\
SYSREG_ID_AA64DFR0_EL1_DoubleLock=0xf,\
SYSREG_ID_AA64ZFR0_EL1_F64MM=0x0,\
SYSREG_ID_AA64ZFR0_EL1_F32MM=0x0,\
SYSREG_ID_AA64ZFR0_EL1_SM4=0x0,\
SYSREG_ID_AA64ZFR0_EL1_SHA3=0x0,\
SYSREG_ID_AA64ZFR0_EL1_BitPerm=0x0,\
SYSREG_ID_AA64ZFR0_EL1_AES=0x0,\
SYSREG_ID_AA64ZFR0_EL1_SVEver=0x0,\
SYSREG_CTR_EL0_L1Ip=0x2 \
-M impl-cpu.0.midr=0x480fd030,impl-cpu.0.revidr=0,impl-cpu.0.aidr=0x1550,\
impl-cpu.1.midr=0x480fd060,impl-cpu.1.revidr=0,impl-cpu.1.aidr=0x51500 \
-kernel Image -initrd minifs.cpio.gz \
-append "rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000 kpti=off" 
-net none -nographic
[-incoming tcp:150.0.207.41:6666]
```

By migrating back and forth between HIP09 and HIP12, it can be observed
that guest has enabled ARM64_WORKAROUND_HISILICON_ERRATUM_162100125,
which is an erratum required only in the HIP09 implementation. This
proves that the migration of the erratum was successful.

Tested-by: Jinqian Yang <yangjinqian1@huawei.com>

Thanks,
Jinqian


On 2026/9/11 23:27, Shameer Kolothum wrote:
> Hi,
> 
> Changes from RFC v1:
> https://lore.kernel.org/qemu-devel/20250801074730.28329-1-shameerkolothum@gmail.com/
> 
>   -Rebased on top of Connie/Eric's "customizable aarch64 KVM host" series v8[0]
>   -Addressed feedback on v1.
> 
> One item from v1 is still open: What should actually set the
> implementation ID registers(Sebastian raised this on v1).
> 
> As it stands, this series enables KVM_CAP_ARM_WRITABLE_IMP_ID_REGS
> but never writes MIDR/REVIDR/AIDR. impl-cpu feeds the hypercall only,
> so a guest that reads MIDR_EL1 directly still sees the host value, while
> DISCOVER_IMPL_CPUS reports the configured list. Sebastian suggested
> using target_impl_cpus[0].*, which would make the guest-visible CPU
> identity a configuration value rather than an artefact of whichever host
> the VM first booted on.
> 
> Please take a look and let me know.
> 
> Thanks,
> Shameer
> 
> [0] https://lore.kernel.org/qemu-devel/20260826093747.1670077-1-eric.auger@redhat.com/
> 
>  From v1:
> 
> On ARM64 platforms, many errata workarounds are based on CPU identification
> registers, particularly MIDR_EL1 and REVIDR_EL1. Some of these errata
> require corresponding fixes in the guest kernel as well. This becomes a
> challenge during guest migration between hosts with different MIDR/REVIDR
> values, even when the VMM provides a common baseline feature set using
> the recently introduced writable ID register support.
> 
> To address this, the Linux kernel now provides:
> 
>   -A mechanism to expose implementation CPU data to guests via KVM
>    hypercalls:
> 
>    ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_VER_FUNC_ID
>    ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_CPUS_FUNC_ID
> 
>   -A way to override implementation ID registers (MIDR, REVIDR, AIDR),
>    which were previously treated as invariant.
> 
> What this RFC does:
> 
> This RFC enables the virt machine to specify Target Implementation CPUs
> via QEMU command-line, exposing them to the guest via KVM hypercalls.
> 
> Example use case (hosts with differing MIDRs):
> 
> ./qemu-system-aarch64 -machine virt,gic-version=3 \
>    -enable-kvm \
>    -bios QEMU_EFI.fd \
>    -m 1G -smp cpus=4,maxcpus=4 \
>    -cpu host \
>    -M impl-cpu.0.midr=0x481fd010,impl-cpu.0.revidr=0,impl-cpu.0.aidr=0x551,\
>     impl-cpu.1.midr=0x481fd011,impl-cpu.1.revidr=0,impl-cpu.1.aidr=0x551 \
>    -kernel Image-6.16-rc2 \
>    -initrd rootfs-iperf.cpio \
>    -append "rdinit=init console=ttyAMA0 root=/dev/vda rw earlycon=pl011,0x9000000 kpti=off" \
>    -net none \
>    -nographic
> 
> Shameer Kolothum (5):
>    target/arm/kvm-consts.h: Add SMCCC vendor hypercall definitions
>    target/arm/kvm: Introduce helper to check target impl CPU support
>    target/arm/kvm: Add QAPI struct ArmTargetImplCPU
>    target/arm/kvm: Handle KVM Target Imp CPU hypercalls
>    hw/arm/virt: Add Target Implementation CPU support
> 
>   docs/system/arm/virt.rst |  22 +++++
>   qapi/misc-arm.json       |  36 ++++++++
>   include/hw/arm/virt.h    |   2 +
>   target/arm/kvm-consts.h  |  48 ++++++++++
>   target/arm/kvm_arm.h     |  18 ++++
>   hw/arm/virt.c            |  48 ++++++++++
>   target/arm/kvm-stub.c    |  10 ++
>   target/arm/kvm.c         | 194 +++++++++++++++++++++++++++++++++++++++
>   8 files changed, 378 insertions(+)
> 


