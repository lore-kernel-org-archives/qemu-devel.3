Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA05C3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 02:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMIhP-00037m-Ih; Tue, 25 Jun 2024 22:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sMIhM-00034v-PI
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 22:47:52 -0400
Received: from mx2.zhaoxin.com ([203.110.167.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sMIhK-0002ZF-B4
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 22:47:52 -0400
X-ASG-Debug-ID: 1719370055-1eb14e2e5ebbd40001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx2.zhaoxin.com with ESMTP id uyWzLZiY1u5x9S5H (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Wed, 26 Jun 2024 10:47:35 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 10:47:35 +0800
Received: from [10.28.66.62] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 10:47:34 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <d4c0dae5-b9d5-4deb-b300-78492ab11ed8@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.28.66.62
Date: Tue, 25 Jun 2024 22:47:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add support for Zhaoxin Yongfeng CPU model and other
 improvements
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH 0/4] Add support for Zhaoxin Yongfeng CPU model
 and other improvements
CC: <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>,
 <cobechen@zhaoxin.com>, <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>
References: <20240625091905.1325205-1-ewanhai-oc@zhaoxin.com>
 <ZnrUt0/5CZ2Ww45e@intel.com>
Content-Language: en-US
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <ZnrUt0/5CZ2Ww45e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1719370055
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2975
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.126768
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

I’m sorry, but currently Zhaoxin has not released any specs or 
datasheets related
to the current patch. Zhaoxin CPUs are compatible with the x86 architecture,
particularly with Intel. For example, you can refer to the Intel SDM 
(Software
Developer’s Manual). Regarding the current patch, except for the 
features in the
EDX of CPUID leaf 0xC000_0001, all other features can be found in the 
general Intel
specs and are already well known. The Zhaoxin-specific features in CPUID 
leaf
0xC000_0001 were introduced to the Linux Kernel a long time ago. For 
example, the
FEAT_C000_0001_EDX feature word defined in QEMU comes from the Linux 
kernel’s
arch/x86/include/asm/cpufeatures.h. The CPU model is just a feature 
enumeration
function, which I believe does not require as deep an understanding of 
the features
as driver code does. These changes will only affect users attempting to 
emulate
Zhaoxin CPUs and will not impact other Vendor/Micro-Arch CPUs.

On 6/25/24 10:31, Zhao Liu wrote:
>
> [这封邮件来自外部发件人 谨防风险]
>
> Hi EwanHai,
>
> On Tue, Jun 25, 2024 at 05:19:01AM -0400, EwanHai wrote:
>> Date: Tue, 25 Jun 2024 05:19:01 -0400
>> From: EwanHai <ewanhai-oc@zhaoxin.com>
>> Subject: [PATCH 0/4] Add support for Zhaoxin Yongfeng CPU model and other
>>   improvements
>> X-Mailer: git-send-email 2.34.1
>>
>> This patch series introduces support for the Zhaoxin Yongfeng CPU model and includes
>> some improvements and updates related to Zhaoxin and VIA CPUs. The changes ensure that
>> QEMU can correctly identify and emulate Zhaoxin CPUs, providing accurate functionality
>> and performance characteristics.
>>
>>
>> ### Summary of Changes
>>
>> EwanHai (4):
>>    target/i386: Add support for Zhaoxin/VIA CPU vendor identification
>>    target/i386: Add CPUID leaf 0xC000_0001 EDX definitions
>>    target/i386: Introduce Zhaoxin Yongfeng CPU model
>>    target/i386: Update CMPLegacy handling for Zhaoxin and VIA CPUs
>>
>>   target/i386/cpu.c | 130 ++++++++++++++++++++++++++++++++++++++++++++--
>>   target/i386/cpu.h |  38 ++++++++++++++
>>   2 files changed, 165 insertions(+), 3 deletions(-)
>>
>> ### Known Bugs
>>
>> 1. Issue with VMX Preemption Timer Rate on Yongfeng CPU:
>>     - Description: On Yongfeng CPUs, the VMX preemption timer rate is 128, meaning that
>>       bits 4:0 of MSR_IA32_VMX_MISC_CTLS should be set to 7. However, due to Intel's rate
>>       being 5, the Linux kernel has hardcoded this value as 5:
>>       `#define VMX_MISC_EMULATED_PREEMPTION_TIMER_RATE 5`
>>     - Impact: This discrepancy can cause incorrect behavior in the VMX preemption timer on
>>       Yongfeng CPUs.
>>     - Workaround: A patch to correct this issue in the Linux kernel is currently being
>>       prepared and will be submitted soon.
>>
> Thanks for your patch. Is there some spec/datasheet link that people can
> refer to?
>
> Regards,
> Zhao
>


