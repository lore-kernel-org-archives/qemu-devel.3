Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201FFC3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPG1W-0004eX-6t; Thu, 04 Jul 2024 02:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sPG1R-0004V3-SA
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 02:32:49 -0400
Received: from mx2.zhaoxin.com ([203.110.167.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sPG1P-0006hI-BX
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 02:32:49 -0400
X-ASG-Debug-ID: 1720074756-1eb14e2e5eca320001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx2.zhaoxin.com with ESMTP id iaHVNq9yAXwgUEex (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 04 Jul 2024 14:32:36 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 14:32:36 +0800
Received: from [10.28.66.62] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 14:32:35 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <3bb68fee-5406-497e-bf2d-85434994e349@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.28.66.62
Date: Thu, 4 Jul 2024 02:32:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/i386: Update CMPLegacy handling for Zhaoxin
 and VIA CPUs
To: Xiaoyao Li <xiaoyao.li@intel.com>, <pbonzini@redhat.com>
X-ASG-Orig-Subj: Re: [PATCH 4/4] target/i386: Update CMPLegacy handling for
 Zhaoxin and VIA CPUs
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>
References: <20240625091905.1325205-1-ewanhai-oc@zhaoxin.com>
 <20240625091905.1325205-5-ewanhai-oc@zhaoxin.com>
 <81ee1a67-e70f-4437-ab28-6c4d4f741d8b@intel.com>
 <7a988f9e-fc63-4a6d-b3b1-d416dfc7e982@zhaoxin.com>
 <3f0c171e-b956-4b90-8a84-a0ce297053f3@intel.com>
Content-Language: en-US
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <3f0c171e-b956-4b90-8a84-a0ce297053f3@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1720074756
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2431
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.127144
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=203.110.167.99;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/3/24 23:19, Xiaoyao Li wrote:
> On 7/4/2024 11:14 AM, Ewan Hai wrote:
>> On 7/3/24 10:49, Xiaoyao Li wrote:
>>> On 6/25/2024 5:19 PM, EwanHai wrote:
>>>> Zhaoxin and VIA CPUs handle the CMPLegacy bit in the same way
>>>> as Intel CPUs. This patch simplifies the existing logic by
>>>> using the IS_XXX_CPU macro and includes checks for Zhaoxin
>>>> and VIA vendors to align their behavior with Intel.
>>>>
>>>> Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
>>>> ---
>>>>   target/i386/cpu.c | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>> index 50edff077e..0836416617 100644
>>>> --- a/target/i386/cpu.c
>>>> +++ b/target/i386/cpu.c
>>>> @@ -6945,9 +6945,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t
>>>> index, uint32_t count,
>>>>            * So don't set it here for Intel to make Linux guests 
>>>> happy.
>>>>            */
>>>>           if (threads_per_pkg > 1) {
>>>> -            if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
>>>> -                env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
>>>> -                env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
>>>> +            if (!IS_INTEL_CPU(env) &&
>>>> +                !IS_ZHAOXIN_CPU(env) &&
>>>> +                !IS_VIA_CPU(env)) {
>>>
>>> it seems you added ! by mistake.
>>>
>>>>                   *ecx |= 1 << 1; /* CmpLegacy bit */
>>>>               }
>>>>           }
>>>
>> For CPUID leaf 0x80000001 ECX bit 1, Intel defines it as "Bits 04-01:
>> Reserved,"
>> whereas AMD defines it as "CmpLegacy, Core multi-processing legacy
>> mode." For Intel
>> CPUs and those following Intel's behavior, this bit should not be set to
>> 1. Therefore,
>> I believe the "!" here is correct.
>>
>
> Sorry, I misread the original code.
>
> I think maybe we can just use is_AMD_CPU(). But I'm not sure if any
> magic use case with customized VENDOR ID relies on it. So you code looks
> good to me.
Ok, thanks. Additionally, in this patch series, I used some VIA terms, which
might cause confusion. I will remove all VIA references in the description
of the next version of the patch.
Currently, the “Centaurhauls” Vendor ID belongs to Zhaoxin CPUs.


