Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAFCC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 01:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcyGV-0004oj-MA; Wed, 21 Feb 2024 20:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcyGT-0004fq-W1; Wed, 21 Feb 2024 20:52:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcyGR-0007pY-JD; Wed, 21 Feb 2024 20:52:45 -0500
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TgGHQ1g5fz1FKns;
 Thu, 22 Feb 2024 09:47:46 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 9C2D9140383;
 Thu, 22 Feb 2024 09:52:38 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 09:52:37 +0800
Message-ID: <531a573e-fab3-930c-6cf6-cc69846817a8@huawei.com>
Date: Thu, 22 Feb 2024 09:52:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v2 01/22] target/arm: Add FEAT_NMI to max
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-2-ruanjinjie@huawei.com>
 <c6271668-1bee-4ff4-9a9c-5fe6acee4937@linaro.org>
In-Reply-To: <c6271668-1bee-4ff4-9a9c-5fe6acee4937@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=ruanjinjie@huawei.com; helo=szxga05-in.huawei.com
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



On 2024/2/22 5:22, Richard Henderson wrote:
> On 2/21/24 03:08, Jinjie Ruan via wrote:
>> Enable FEAT_NMI on the 'max' CPU.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   docs/system/arm/emulation.rst | 1 +
>>   target/arm/tcg/cpu64.c        | 1 +
>>   2 files changed, 2 insertions(+)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> However, this patch must be sorted last, after all support for FEAT_NMI
> is present.

Good suggestion! Placed it last is more reasonable.

> 
> 
> r~
> 
>>
>> diff --git a/docs/system/arm/emulation.rst
>> b/docs/system/arm/emulation.rst
>> index f67aea2d83..91baf7ad69 100644
>> --- a/docs/system/arm/emulation.rst
>> +++ b/docs/system/arm/emulation.rst
>> @@ -63,6 +63,7 @@ the following architecture extensions:
>>   - FEAT_MTE (Memory Tagging Extension)
>>   - FEAT_MTE2 (Memory Tagging Extension)
>>   - FEAT_MTE3 (MTE Asymmetric Fault Handling)
>> +- FEAT_NMI (Non-maskable Interrupt)
>>   - FEAT_NV (Nested Virtualization)
>>   - FEAT_NV2 (Enhanced nested virtualization support)
>>   - FEAT_PACIMP (Pointer authentication - IMPLEMENTATION DEFINED
>> algorithm)
>> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
>> index 5fba2c0f04..60f0dcd799 100644
>> --- a/target/arm/tcg/cpu64.c
>> +++ b/target/arm/tcg/cpu64.c
>> @@ -1175,6 +1175,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>>       t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 +
>> FEAT_DoubleFault */
>>       t = FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
>>       t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_2 */
>> +    t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
>>       cpu->isar.id_aa64pfr1 = t;
>>         t = cpu->isar.id_aa64mmfr0;
> 

