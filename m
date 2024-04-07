Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9028ECD11C2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 06:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtM7p-0005Ht-U5; Sun, 07 Apr 2024 02:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rtM7n-0005HE-Ng; Sun, 07 Apr 2024 02:35:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rtM7k-0002pY-Hg; Sun, 07 Apr 2024 02:35:31 -0400
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VC2Sz5hnWzXkvG;
 Sun,  7 Apr 2024 14:32:19 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 3CDAE1403D1;
 Sun,  7 Apr 2024 14:35:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 14:35:22 +0800
Message-ID: <49a77851-5f08-b0e2-0233-42d8a7b27786@huawei.com>
Date: Sun, 7 Apr 2024 14:35:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v12 23/23] hw/arm/virt: Add FEAT_GICv3_NMI feature support
 in virt GIC
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
CC: <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, 
 <wangyanan55@huawei.com>, <richard.henderson@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-24-ruanjinjie@huawei.com>
 <CAFEAcA87CCLyk6=XzQANoqywfnSXSMcEkezAdH8bH-pO6AXKaw@mail.gmail.com>
In-Reply-To: <CAFEAcA87CCLyk6=XzQANoqywfnSXSMcEkezAdH8bH-pO6AXKaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=ruanjinjie@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -76
X-Spam_score: -7.7
X-Spam_bar: -------
X-Spam_report: (-7.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.458,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2024/4/5 21:48, Peter Maydell wrote:
> On Wed, 3 Apr 2024 at 11:18, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> A PE that implements FEAT_NMI and FEAT_GICv3 also implements
>> FEAT_GICv3_NMI. A PE that does not implement FEAT_NMI, does not implement
>> FEAT_GICv3_NMI
> 
> This is true but not really relevant here -- FEAT_GICv3_NMI
> is not "NMI support in the GIC", it's "does the CPU interface
> support NMIs". (And so I'm wondering if the code in arm_gicv3_cpuif.c
> should be checking cpu_isar_feature(aa64_nmi, cpu) rather than
> cs->gic->nmi_support; but I need to think through the consequences
> of that first.)

In "1.1.2 GIC architecture extensions", it said:

FEAT_GICv3_NMI introduces GIC support for non-maskable interrupts (NMIs).

So in my opinion, it is relevant here.

> 
> The justification for "enable NMIs in the GIC device if the
> CPU has FEAT_NMI" is that (a) it's only OK to have a GIC with
> NMI support if the CPU also has NMI support and (b) if we
> can turn on NMI support in the GIC we should, so that we can
> provide the feature to the guest.
> 
>> So included support FEAT_GICv3_NMI feature as part of virt platform
>> GIC initialization if FEAT_NMI and FEAT_GICv3 supported.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v4:
>> - Add Reviewed-by.
>> v3:
>> - Adjust to be the last after add FEAT_NMI to max.
>> - Check whether support FEAT_NMI and FEAT_GICv3 for FEAT_GICv3_NMI.
>> ---
>>  hw/arm/virt.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index ef2e6c2c4d..63d9f5b553 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -729,6 +729,19 @@ static void create_v2m(VirtMachineState *vms)
>>      vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
>>  }
>>
>> +/*
>> + * A PE that implements FEAT_NMI and FEAT_GICv3 also implements
>> + * FEAT_GICv3_NMI. A PE that does not implement FEAT_NMI, does not implement
>> + * FEAT_GICv3_NMI.
>> + */
>> +static bool gicv3_nmi_present(VirtMachineState *vms)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(qemu_get_cpu(0));
>> +
>> +    return cpu_isar_feature(aa64_nmi, cpu) &&
>> +           (vms->gic_version != VIRT_GIC_VERSION_2);
> 
> I think we should add tcg_enabled() to this condition:
> neither KVM nor hvf support FEAT_NMI yet. Defaulting QEMU to
> not trying to enable NMI in the GIC device is the safe
> option. As and when those accelerators get NMI support, we
> can add the handling to QEMU and update this code in the virt board.
> 
> thanks
> -- PMM

