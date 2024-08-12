Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35E0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 10:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdRsw-000067-Ra; Mon, 12 Aug 2024 06:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sdRss-00005Z-Pu
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:02:38 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sdRsp-0008BK-W7
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:02:38 -0400
X-ASG-Debug-ID: 1723456936-086e2376103a660001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx1.zhaoxin.com with ESMTP id KphAdjHuA9wcJy6n (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 12 Aug 2024 18:02:16 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 12 Aug
 2024 18:02:16 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e]) by
 ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e%7]) with mapi id
 15.01.2507.039; Mon, 12 Aug 2024 18:02:16 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from [10.28.66.62] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 Aug
 2024 18:01:34 +0800
Message-ID: <5a64a2ce-fc47-4295-a239-e899574aa857@zhaoxin.com>
Date: Mon, 12 Aug 2024 06:01:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: Re: [PATCH v3 4/4] target/i386: Mask CMPLegacy bit in
 CPUID[0x80000001].ECX for Zhaoxin CPUs
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH v3 4/4] target/i386: Mask CMPLegacy bit in
 CPUID[0x80000001].ECX for Zhaoxin CPUs
CC: <pbonzini@redhat.com>, <xiaoyao.li@intel.com>, <qemu-devel@nongnu.org>,
 <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>, <rockcui@zhaoxin.com>,
 <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>, <frankzhu@zhaoxin.com>
References: <20240809094259.119221-1-ewanhai-oc@zhaoxin.com>
 <20240809094259.119221-5-ewanhai-oc@zhaoxin.com> <ZrnbZBwATjGBHzWY@intel.com>
Content-Language: en-US
In-Reply-To: <ZrnbZBwATjGBHzWY@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 8/12/2024 6:02:15 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1723456936
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2263
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.128930
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thank you for your review!, I will udpate the commit message according
to your suggestions to ensure it provides the most accurate information.

On 8/12/24 05:52, Zhao Liu wrote:
> On Fri, Aug 09, 2024 at 05:42:59AM -0400, EwanHai wrote:
>> Date: Fri, 9 Aug 2024 05:42:59 -0400
>> From: EwanHai<ewanhai-oc@zhaoxin.com>
>> Subject: [PATCH v3 4/4] target/i386: Mask CMPLegacy bit in
>>   CPUID[0x80000001].ECX for Zhaoxin CPUs
>> X-Mailer: git-send-email 2.34.1
>>
>> Zhaoxin CPUs (including vendors "Shanghai" and "Centaurhauls") handle the
>> CMPLegacy bit similarly to Intel CPUs. Therefore, this commit masks the
>> CMPLegacy bit in CPUID[0x80000001].ECX for Zhaoxin CPUs, just as it is done
>> for Intel CPUs.
>>
>> AMD uses the CMPLegacy bit (CPUID[0x80000001].ECX.bit1) along with other CPUID
>> information to enumerate platform topology (e.g., the number of logical
>> processors per package). However, for Intel and other CPUs that follow Intel's
>> behavior, CPUID[0x80000001].ECX.bit1 is reserved.
>>
>> - Impact on Intel and similar CPUs:
>> This change has no effect on Intel and similar CPUs, as the goal is to
>> accurately emulate CPU CPUID information.
>>
>> - Impact on Linux Guests running on Intel (and similar) vCPUs:
>> During boot, Linux checks if the CPU supports Hyper-Threading.
>> If it detects
> Maybe "For the kernel before v6.9, if it detects"? About this change,
> see the below comment...
>
>> X86_FEATURE_CMP_LEGACY, it assumes Hyper-Threading is not supported. For Intel
>> and similar vCPUs, if the CMPLegacy bit is not masked in CPUID[0x80000001].ECX,
>> Linux will incorrectly assume that Hyper-Threading is not supported, even if
>> the vCPU does support it.
> ...It seems this issue exists in the kernel before v6.9. Thomas'
> topology refactoring has fixed this behavior:
> * commit 22d63660c35e ("x86/cpu: Use common topology code for Intel")
> * commit 598e719c40d6 ("x86/cpu: Use common topology code for Centaur
>    and Zhaoxin")
>
>> Signed-off-by: EwanHai<ewanhai-oc@zhaoxin.com>
>> ---
>>   target/i386/cpu.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
> Just the above nit. Otherwise, LGTM,
>
> Reviewed-by: Zhao Liu<zhao1.liu@intel.com>
>
>


