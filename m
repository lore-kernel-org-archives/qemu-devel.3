Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5466C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 09:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmsa3-000213-06; Wed, 20 Mar 2024 05:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rmsZv-0001zb-DP; Wed, 20 Mar 2024 05:49:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rmsZp-0000MF-Rv; Wed, 20 Mar 2024 05:49:45 -0400
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V03dy3Bbcz1h39r;
 Wed, 20 Mar 2024 17:47:02 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 9A59F1A0172;
 Wed, 20 Mar 2024 17:49:35 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 17:49:34 +0800
Message-ID: <b26cbc2d-c048-354e-2c19-43dadef7b44a@huawei.com>
Date: Wed, 20 Mar 2024 17:49:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v8 06/23] target/arm: Add support for Non-maskable
 Interrupt
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
CC: <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, 
 <wangyanan55@huawei.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240318093546.2786144-1-ruanjinjie@huawei.com>
 <20240318093546.2786144-7-ruanjinjie@huawei.com>
 <CAFEAcA_xSHAJnn0_O9=zGo9u8omzhuB_WvuMo9gf7wKt8OVDmw@mail.gmail.com>
 <cb5d981a-6db4-479c-9eaa-bca49c40bc72@linaro.org>
 <CAFEAcA9bKcu0FrfqRGg6bbtNX1kYR04_oian_5YXaduq_a3W3Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9bKcu0FrfqRGg6bbtNX1kYR04_oian_5YXaduq_a3W3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=ruanjinjie@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.417,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 2024/3/20 3:26, Peter Maydell wrote:
> On Tue, 19 Mar 2024 at 18:51, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 3/19/24 07:28, Peter Maydell wrote:
>>>>       switch (excp_idx) {
>>>> +    case EXCP_NMI:
>>>> +        pstate_unmasked = !allIntMask;
>>>> +        break;
>>>> +
>>>> +    case EXCP_VNMI:
>>>> +        if ((!(hcr_el2 & HCR_IMO) && !(hcr_el2 & HCR_FMO)) ||
>>>> +             (hcr_el2 & HCR_TGE)) {
>>>> +            /* VNMIs(VIRQs or VFIQs) are only taken when hypervized.  */
>>>> +            return false;
>>>> +        }
>>>
>>> VINMI and VFNMI aren't the same thing: do we definitely want to
>>> merge them into one EXCP_VNMI ?
>>
>> We do not, which is why VFNMI is going through EXCP_VFIQ.  A previous version did, and I
>> see the comment did not change to match the new implementation.
> 
> Why do we put VFNMI through VFIQ, though? They're not
> the same thing either... I think I would find this less
> confusing if we implemented what the spec says and distinguished
> all of (IRQ, FIQ, IRQ-with-superpriority and FIQ-with-superpriority).

Should there be separate VNMI lines and exceptions for the
IRQ-with-superpriority and FIQ-with-superpriority ?

> 
>>> The use of the _eff() versions of the functions here is
>>> correct but it introduces a new case where we need to
>>> reevaluate the status of the VNMI etc interrupt status:
>>> when we change from Secure to NonSecure or when we change
>>> SCR_EL3.EEL2 or SCR_EL3.HXEN. We either need to make sure
>>> we reevaluate when we drop from EL3 to EL2 (which would be
>>> OK since VINMI and VFNMI can't be taken at EL3 and none of
>>> these bits can change except at EL3) or else make the calls
>>> to reevaluate them when we write to SCR_EL3. At least, I don't
>>> think we currently reevaluate these bits on an EL change.
>>
>> We re-evaluate these bits on EL change via gicv3_cpuif_el_change_hook.
> 
> Only if the GIC is connected to the VIRQ and VFIQ interrupt lines,
> which it doesn't in theory have to be (though in practice it
> usually will be). Plus it feels a bit fragile against
> somebody deciding to put in a "this line hasn't changed state
> so don't bother calling the handler again" optimization in the
> future.
> 
> thanks
> -- PMM

