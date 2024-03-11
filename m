Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4EEC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 04:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjWrQ-0003ro-Gy; Mon, 11 Mar 2024 00:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rjWqk-0003nL-4l; Mon, 11 Mar 2024 00:01:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rjWqK-0007H9-T3; Mon, 11 Mar 2024 00:01:10 -0400
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TtNKQ4tz3z1h1sd;
 Mon, 11 Mar 2024 11:58:02 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id B8DEC1A016E;
 Mon, 11 Mar 2024 12:00:27 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 12:00:27 +0800
Message-ID: <c57f3338-0f38-1768-7c9f-d2b00a0cb158@huawei.com>
Date: Mon, 11 Mar 2024 12:00:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v7 00/23] target/arm: Implement FEAT_NMI and
 FEAT_GICv3_NMI
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240306035721.2333531-1-ruanjinjie@huawei.com>
 <fd515ea4-ca4b-4d54-9d9b-59683ccd683e@linaro.org>
In-Reply-To: <fd515ea4-ca4b-4d54-9d9b-59683ccd683e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=ruanjinjie@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.099,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ping.

On 2024/3/6 12:22, Richard Henderson wrote:
> On 3/5/24 17:56, Jinjie Ruan via wrote:
>> This patch set implements FEAT_NMI and FEAT_GICv3_NMI for armv8. These
>> introduce support for a new category of interrupts in the architecture
>> which we can use to provide NMI like functionality.
>>
>> There are two modes for using this FEAT_NMI. When PSTATE.ALLINT or
>> PSTATE.SP & SCTLR_ELx.SCTLR_SPINTMASK is set, any entry to ELx causes all
>> interrupts including those with superpriority to be masked on entry to
>> ELn
>> until the mask is explicitly removed by software or hardware.
>> PSTATE.ALLINT
>> can be managed by software using the new register control ALLINT.ALLINT.
>> Independent controls are provided for this feature at each EL, usage
>> at EL1
>> should not disrupt EL2 or EL3.
>>
>> I have tested it with the following linux patches which try to support
>> FEAT_NMI in linux kernel:
>>
>>     https://lore.kernel.org/linux-arm-kernel/Y4sH5qX5bK9xfEBp@lpieralisi/T/#mb4ba4a2c045bf72c10c2202c1dd1b82d3240dc88
>>
>> In the test, SGI, PPI and SPI interrupts can all be set to have super
>> priority
>> to be converted to a hardware NMI interrupt. The SGI is tested with
>> kernel
>> IPI as NMI framework, softlockup, hardlockup and kgdb test cases, and
>> the PPI
>> interrupt is tested with "perf top" command with hardware NMI enabled,
>> and
>> the SPI interrupt is tested with a custom test module, in which NMI
>> interrupts
>> can be received and sent normally.
> 
> As far as I can see, this patch set is good to go.  I'm fairly confident
> of the CPU side of the equation, but the GIC could use a second set of
> eyes.
> 
> 
> r~

