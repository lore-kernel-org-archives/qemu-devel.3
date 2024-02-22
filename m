Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D161C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5Lv-0006vY-MA; Thu, 22 Feb 2024 04:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rd5Ln-0006uX-E3; Thu, 22 Feb 2024 04:26:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rd5Lj-0002d7-HX; Thu, 22 Feb 2024 04:26:42 -0500
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TgSQJ6NqKz2BdJZ;
 Thu, 22 Feb 2024 17:24:24 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 90F54140411;
 Thu, 22 Feb 2024 17:26:34 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 17:26:33 +0800
Message-ID: <864e2313-ca3e-b704-ade0-f4ae7583c275@huawei.com>
Date: Thu, 22 Feb 2024 17:26:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v2 06/22] target/arm: Add support for Non-maskable
 Interrupt
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-7-ruanjinjie@huawei.com>
 <2e1ad5a4-b706-44a9-b686-6ddeb41722e2@linaro.org>
In-Reply-To: <2e1ad5a4-b706-44a9-b686-6ddeb41722e2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=ruanjinjie@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.297,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 2024/2/22 5:23, Richard Henderson wrote:
> On 2/21/24 03:08, Jinjie Ruan via wrote:
>> This only implements the external delivery method via the GICv3.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   target/arm/cpu-qom.h |  3 ++-
>>   target/arm/cpu.c     | 39 ++++++++++++++++++++++++++++++++++-----
>>   target/arm/cpu.h     |  2 ++
>>   target/arm/helper.c  |  1 +
>>   4 files changed, 39 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
>> index 8e032691db..66d555a605 100644
>> --- a/target/arm/cpu-qom.h
>> +++ b/target/arm/cpu-qom.h
>> @@ -36,11 +36,12 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
>>   #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
>>   #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
>>   -/* Meanings of the ARMCPU object's four inbound GPIO lines */
>> +/* Meanings of the ARMCPU object's five inbound GPIO lines */
>>   #define ARM_CPU_IRQ 0
>>   #define ARM_CPU_FIQ 1
>>   #define ARM_CPU_VIRQ 2
>>   #define ARM_CPU_VFIQ 3
>> +#define ARM_CPU_NMI 4
> 
> You need a 6th GPIO for vNMI.
Thank you! I'll fix it.
> 
> 
> r~

