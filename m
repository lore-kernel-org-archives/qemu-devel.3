Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51375C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 02:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scFLr-0002nn-KV; Thu, 08 Aug 2024 22:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1scFLo-0002nG-S9
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 22:27:33 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1scFLl-0006So-Lq
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 22:27:32 -0400
X-ASG-Debug-ID: 1723170438-086e2376122ded0001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx1.zhaoxin.com with ESMTP id mt9AVoUnV0t3kJxX (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 09 Aug 2024 10:27:18 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 9 Aug
 2024 10:27:17 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e]) by
 ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e%7]) with mapi id
 15.01.2507.039; Fri, 9 Aug 2024 10:27:17 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from [10.28.66.62] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 09:44:19 +0800
Message-ID: <236c8032-6e17-4002-86e1-4483b55977f7@zhaoxin.com>
Date: Thu, 8 Aug 2024 21:44:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] target/i386: Update CMPLegacy handling for Zhaoxin
 CPUs
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH v2 4/4] target/i386: Update CMPLegacy handling for
 Zhaoxin CPUs
CC: <pbonzini@redhat.com>, <xiaoyao.li@intel.com>, <qemu-devel@nongnu.org>,
 <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>, <rockcui@zhaoxin.com>,
 <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>, <frankzhu@zhaoxin.com>
References: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
 <20240704112511.184257-5-ewanhai-oc@zhaoxin.com> <ZrSeMfpBm8NrXRWK@intel.com>
Content-Language: en-US
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <ZrSeMfpBm8NrXRWK@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 8/9/2024 10:27:16 AM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1723170438
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2431
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.128773
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
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


Hi Zhao Liu,

Thank you for your feedback.

On 8/8/24 06:30, Zhao Liu wrote:
> Hi EwanHai,
>
> On Thu, Jul 04, 2024 at 07:25:11AM -0400, EwanHai wrote:
>> Date: Thu, 4 Jul 2024 07:25:11 -0400
>> From: EwanHai <ewanhai-oc@zhaoxin.com>
>> Subject: [PATCH v2 4/4] target/i386: Update CMPLegacy handling for Zhaox=
in
>>   CPUs
>> X-Mailer: git-send-email 2.34.1
>>
>> Zhaoxin CPUs handle the CMPLegacy bit in the same way
>> as Intel CPUs. This patch simplifies the existing logic by
>> using the IS_XXX_CPU macro and includes checks for Zhaoxin
>> vendor to align their behavior with Intel.
>>
>> Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
>> ---
>>   target/i386/cpu.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index a3747fc487..c52a4cf3ba 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6945,9 +6945,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t inde=
x, uint32_t count,
>>            * So don't set it here for Intel to make Linux guests happy.
>>            */
>>           if (threads_per_pkg > 1) {
>> -            if (env->cpuid_vendor1 !=3D CPUID_VENDOR_INTEL_1 ||
>> -                env->cpuid_vendor2 !=3D CPUID_VENDOR_INTEL_2 ||
>> -                env->cpuid_vendor3 !=3D CPUID_VENDOR_INTEL_3) {
>> +            if (!IS_INTEL_CPU(env) && !IS_ZHAOXIN_CPU(env)) {
> This change implicitly changes the behavior of existing VIA CPU.
>
> Is this a bug for the original VIA? If so, I suggest a separate patch to
> fix it and explain the effect on the VIA (Zhaoxin1) CPU.
>
> Regards,
> Zhao
The reason for this change is not due to a discovered bug, but rather
because both Centaurhauls and Shanghai CPUs follow Intel=E2=80=99s behavior
regarding the CMPLegacy bit. Specifically, AMD CPUs enumerate the
threads per package information in the CPUID leaf 0x80000001 output
ECX register, while Intel (and **other processors following Intel=E2=80=99s
behavior**) do not. Therefore, this modification is simply intended to
logically supplement the existing code.

Given this, do you think it would be appropriate for me to submit
a separate patch to explain this behavior and its effect on
VIA (Zhaoxin1) CPUs? If so, I will submmit this change in a separate
patch.
>>                   *ecx |=3D 1 << 1;    /* CmpLegacy bit */
>>               }
>>           }
>> --
>> 2.34.1
>>


