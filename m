Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAB8CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 01:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIceP-000781-Hj; Sun, 18 Oct 2026 21:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xIce9-00075u-R0; Sun, 18 Oct 2026 21:58:42 -0400
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xIce6-0007bq-4N; Sun, 18 Oct 2026 21:58:41 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JwGY3r1v5cG1PUwqtuk03i32AyWJXqANzH+KJKEIxlU=;
 b=ico/C3Y/Deh4Y7ijwJlUxk/VqGS5Bn+yz44mJvlqVYhl2b2fdAzPBcfAN6xpgVkei/kbJyNbg
 qLAABquOItY81g0dDhSa3IJimBj45TSRk8cFxQINbRFKQp25kFLhOJIOdyX98+UcblRvxU+Le6b
 klqvlxz1Bq5VJR7ArYd6Q4c=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4j7JZZ0FRdzcb3L;
 Mon, 19 Oct 2026 09:57:10 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id B1C2740537;
 Mon, 19 Oct 2026 09:57:15 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 09:57:14 +0800
Message-ID: <27040691-e4b6-44f3-b588-cbbbee13cde2@huawei.com>
Date: Mon, 19 Oct 2026 09:57:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] Add Arm MPAM emulation
To: Peter Maydell <peter.maydell@linaro.org>, Jinjie Ruan <2118537295@qq.com>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <eblake@redhat.com>,
 <imammedo@redhat.com>, <michael.roth@amd.com>, <mst@redhat.com>,
 <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
 <CAFEAcA8MyrqWC7=A5Bw0G5G-2J64iTLmfY33dNDLm0jvmRb+Eg@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAFEAcA8MyrqWC7=A5Bw0G5G-2J64iTLmfY33dNDLm0jvmRb+Eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.68]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
Received-SPF: pass client-ip=113.46.200.217;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout02.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



在 2026/10/16 18:20, Peter Maydell 写道:
> On Fri, 16 Oct 2026 at 10:47, Jinjie Ruan <2118537295@qq.com> wrote:
>>
>> From: Jinjie Ruan <ruanjinjie@huawei.com>
>>
>> MPAM (Memory System Resource Partitioning and Monitoring) is Arm's
>> architecture for partitioning and monitoring system memory resources
>> - Cache portions
>> - Capacity limits
>> - Memory bandwidth and priority
>>
>> And MPAM is the Arm counterpart of x86 RDT, which Linux exposes to user
>> space via resctrl.
>>
>> QEMU so far has no MPAM support at all: the CPU-side system registers
>> are missing (a guest kernel that probes FEAT_MPAM takes an UNDEFINED
>> exception), and there are no Memory System Components (MSCs), so a virt
>> guest cannot exercise resctrl on Arm.
>>
>> This series adds MPAM 1.1 emulation for the virt machine,
>> and the structure is as below:
> 
>> With this, a Linux guest booted with -M virt,mpam=on (plus NUMA nodes)
>> mounts resctrl with the full schemata set (L2/L3 CAT, capacity, MBA,
>> priority), and MBM bandwidth and L2/L3 occupancy counters track the
>> configured controls.
> 
> I guess my question here is "how much is this actually doing,
> and how much is it 'we provide enough software-facing interface
> to keep the guest happy'" ? My (rather shallow) understanding of
> MPAM is that it's essentially adding tags to memory transactions
> and then accounting how much bandwidth each tag is using. That
> seems obviously infeasible for emulation, but on the other hand

Hi Peter,

Yes, I agree with you.

Implementing MPAM bandwidth control and partitioning at the
performance-effect level in QEMU is neither feasible nor necessary, and
it is not in line with QEMU’s original purpose as a fast functional
emulator.

We only need to implement the functionality-related parts (i.e., the
register interfaces and control flow) to ensure that the software stack
can correctly recognize and configure MPAM, without simulating the real
performance impact produced by those configurations.

> this looks like it's rather larger than a minimal "we provide
> the register interface but it does nothing", so what are we doing?

By implementing MPAM-related register interfaces and control flow, as
well as the MSC hardware topology in QEMU, we can understand the resctrl
framework and interfaces in Linux, along with the related hardware
topology discovery process. This facilitates kernel debugging and
pre-silicon testing, and also allows us to debug and test test cases,
avoiding the complexity and slowness of testing on FPGA.

Through this series of QEMU implementations, I discovered many kernel
issues and test-case issues in advance before FPGA testing, accelerating
the development and testing of new kernel features (such as narrow PARTID).

Moreover, as far as I understand, many hardware vendors have not yet
implemented MPAM. Implementing it in QEMU helps enable MPAM on Linux,
and then understand, learn, test, and even develop some MPAM-related
features.

Link:
https://lore.kernel.org/all/20261012082337.822258-1-ruanjinjie@huawei.com/

> 
> thanks
> -- PMM

-- 
Best regards,
Jinjie


