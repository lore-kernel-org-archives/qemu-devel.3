Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042AACD6E68
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 06:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV1Hj-0004nM-Fb; Thu, 04 Jun 2026 02:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangjinqian1@huawei.com>)
 id 1wV1Hh-0004kD-So; Thu, 04 Jun 2026 02:10:29 -0400
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangjinqian1@huawei.com>)
 id 1wV1Hb-0004Cq-Pz; Thu, 04 Jun 2026 02:10:29 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=G2ogEE7br8ED7Qmrisn6OXLsUPDmpl5FGndwtTDAUUY=;
 b=Qa+rXIoAVlJ1EcBkKYwriYXrD+KDkcpWxvX0DFAggmEiGd3SDeaaCPfOUZ3wH0nr6BIkPNHbT
 v2bbTQ7Ip2HPoSNJxOBWiSH9oi1U977xl8y45I5CZoQHYTXr6YK0NKGGRw9yKf2zcuEW90bOwUa
 Kx+kWbcbIh7vvadXhvhl050=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gWDT35bwwz1prNP;
 Thu,  4 Jun 2026 14:00:55 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
 by mail.maildlp.com (Postfix) with ESMTPS id C0EF140571;
 Thu,  4 Jun 2026 14:08:48 +0800 (CST)
Received: from [10.67.121.183] (10.67.121.183) by
 dggpemf500013.china.huawei.com (7.185.36.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 14:08:47 +0800
Message-ID: <5a533932-06fe-4401-abfe-66546c15c4ec@huawei.com>
Date: Thu, 4 Jun 2026 14:08:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/18] kvm/arm: Introduce a customizable aarch64 KVM
 host model
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <kvmarm@lists.linux.dev>,
 <peter.maydell@linaro.org>, <shaju.abraham@nutanix.com>,
 <khushit.shah@nutanix.com>, <cohuck@redhat.com>,
 <richard.henderson@linaro.org>, <sebott@redhat.com>,
 <skolothumtho@nvidia.com>, <philmd@linaro.org>
CC: <maz@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <armbru@redhat.com>, <berrange@redhat.com>, <abologna@redhat.com>,
 <jdenemar@redhat.com>, <linuxarm@huawei.com>, liuyonglong
 <liuyonglong@huawei.com>, Zhou Wang <wangzhou1@hisilicon.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
From: Jinqian Yang <yangjinqian1@huawei.com>
In-Reply-To: <20260519132905.145643-1-eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.183]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500013.china.huawei.com (7.185.36.188)
Received-SPF: pass client-ip=113.46.200.219;
 envelope-from=yangjinqian1@huawei.com; helo=canpmsgout04.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2026/5/19 21:27, Eric Auger wrote:
> This series enhances the current host KVM model with capability to
> set writable ID reg fields.
> 
> Since v6.7 kernel, KVM/arm allows the userspace to overwrite the values
> of a subset of ID regs. The list of writable fields continues to grow.
> The feature ID range is defined as the AArch64 System register space
> with op0==3, op1=={0, 1, 3}, CRn==0, CRm=={0-7}, op2=={0-7}.
> 
> The end goal is to get more flexibility when migrating guests
> between different host hardware.
> 
> QEMU retrieves the writable ID fields from KVM UAPI [1] and
> match them against a generated description of ID regs and their
> named fields that stem from AARCHMRS Registers.json file.
> Current description is based on latest 2026-03 edition.
> The content of the generated files was compared against kernel
> linux/arch/arm64/tools/sysreg file. It is not straightforward
> to have unit tests for python scripts as there are many cases for
> field extraction.
> 
> For each writable named field a uint64 property is created
> following the "SYSREG_<REG>_<FIELD>" naming convention. REG and
> FIELD names are those described in ARM ARM Reference manual.
> 
> The list of SYSREG_ID properties can be retrieved through the qmp
> monitor using query-cpu-model-expansion [2].
> 
> Connie & Eric
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/arm-cpu-model-v5
> 
> History:
> --------
> 
> v4 -> v5:
> - generate target/arm/cpu-idregs.h.inc that look similar to
>    the format used in [RFC PATCH v1 02/13] target/arm:
>    named_cpu_model: Add ID Register Fields without the
>    description of the value values nor safe policy/value.
>    I guess valid values could be generated from the Registers.json
>    file too. Safe policy/values cannot.
>    I reused one patch from the above series.
>    Let's see how both series can progress/coexist without any
>    anticipated bias.
> - Addressed all comments from Shameer on v4
> - Addressed 2 comments from v4 that were missed including the
>    issue of IDreg visibility affected by some other settings.
>    Unfortunately I was not able to test it.
> - Further look at overrides between low level id reg field
>    properties versus legacy CPU options. I have the feeling they
>    can coexist as long as we document the hierarchy between them:
>    host kvm default -> ID reg field props -> legacy CPU options
> - Noticed more writable fields that are RES0/RAZ
> - Improved commit messages in general
> 
> References:
> -----------
> 
> [1]
> KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES
> KVM_ARM_GET_REG_WRITABLE_MASKS
> Documentation/virt/kvm/api.rst
> 
> [2]
> qemu-system-aarch64 -qmp unix:/home/augere/TEST/QEMU/qmp-sock,server,nowait -M virt --enable-kvm -cpu custom
> sudo build/run qmp-shell /home/augere/TEST/QEMU/qmp-sock
> Welcome to the QMP low-level shell!
> Connected to QEMU 11.0.50
> (QEMU) query-cpu-model-expansion type=full model={"name":"host"}
> 
> 
> Cornelia Huck (3):
>    target/arm/kvm: Introduce kvm_get_writable_id_regs
>    arm-qmp-cmds: introspection for ID register props
>    arm/cpu-features: document ID reg properties
> 
> Eric Auger (14):
>    scripts: introduce scripts/update-aarch64-cpu-sysregs-header.py
>    target/arm/cpu-sysregs.h.inc: Sort by name alphabetical order
>    target/arm/cpu-sysregs.h.inc: Update with automatic generation
>    arm/cpu: Add infra to handle generated ID register definitions
>    scripts: Introduce scripts/aarch64_sysreg_helpers module
>    scripts: Introduce scripts/update-aarch64-cpu-sysreg-properties.py
>    target/arm/cpu-idregs.h.inc: generate with script
>    target/arm/cpu64: Retrieve writable ID reg map in
>      aarch64_host_initfn()
>    arm/kvm: Initialize all writable ID registers from host
>    arm/kvm: write back modified ID regs to KVM
>    target/arm/kvm: Introduce kvm_arm_expose_idreg_properties
>    target/arm/kvm: Special case REVIDR_EL1 and AIDR_EL1
>    target/arm/kvm: Ignore some writable bits that shouldn't be
>    target/arm/cpu: Expose writable ID reg field properties on the kvm
>      host vcpu model
> 
> Shaju Abraham (1):
>    target/arm/cpu_idregs: generate tables for Arm64 ID registers and
>      fields
> 
>   docs/system/arm/cpu-features.rst              | 106 ++-
>   scripts/aarch64_sysreg_helpers.py             | 109 ++++
>   .../update-aarch64-cpu-sysreg-properties.py   | 168 +++++
>   scripts/update-aarch64-cpu-sysregs-header.py  |  51 ++
>   target/arm/arm-qmp-cmds.c                     |  19 +
>   target/arm/cpu-idregs.c                       |  50 ++
>   target/arm/cpu-idregs.h                       |  33 +
>   target/arm/cpu-idregs.h.inc                   | 617 ++++++++++++++++++
>   target/arm/cpu-sysregs.h.inc                  |  57 +-
>   target/arm/cpu.h                              |   3 +
>   target/arm/cpu64.c                            |  14 +
>   target/arm/kvm-stub.c                         |   5 +
>   target/arm/kvm.c                              | 320 ++++++++-
>   target/arm/kvm_arm.h                          |  12 +
>   target/arm/meson.build                        |   1 +
>   target/arm/trace-events                       |   6 +
>   16 files changed, 1539 insertions(+), 32 deletions(-)
>   create mode 100644 scripts/aarch64_sysreg_helpers.py
>   create mode 100644 scripts/update-aarch64-cpu-sysreg-properties.py
>   create mode 100755 scripts/update-aarch64-cpu-sysregs-header.py
>   create mode 100644 target/arm/cpu-idregs.c
>   create mode 100644 target/arm/cpu-idregs.h
>   create mode 100644 target/arm/cpu-idregs.h.inc
> 

Thanks for the patch series. I tested it, and it works as expected.
After configuring the QEMU command, it was able to successfully migrate
on Hisilicon KunPeng HIP09 and HIP12 chips.

Tested-by: Jinqian Yang <yangjinqian1@huawei.com>

Thanks,
Shameer

