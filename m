Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEE2C52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 09:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbzO7-0000d3-E2; Thu, 08 Aug 2024 05:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sbzO4-0000cJ-Sc
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 05:24:48 -0400
Received: from mx2.zhaoxin.com ([203.110.167.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sbzO2-0004Bg-C4
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 05:24:48 -0400
X-ASG-Debug-ID: 1723109069-1eb14e31a620ce0001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx2.zhaoxin.com with ESMTP id Zfo5ly8gUmSXnvQH (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 08 Aug 2024 17:24:29 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 8 Aug
 2024 17:24:29 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e]) by
 ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e%7]) with mapi id
 15.01.2507.039; Thu, 8 Aug 2024 17:24:29 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from [10.28.66.62] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 17:23:01 +0800
Message-ID: <9a5094dd-119c-406a-8d42-0290dc9ce129@zhaoxin.com>
Date: Thu, 8 Aug 2024 05:23:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add support for Zhaoxin Yongfeng CPU model and
 other improvements
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
X-ASG-Orig-Subj: Re: [PATCH v2 0/4] Add support for Zhaoxin Yongfeng CPU model
 and other improvements
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <xiaoyao.li@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>
References: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
Content-Language: en-US
In-Reply-To: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 8/8/2024 5:24:28 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1723109069
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1747
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.128741
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

Dear Maintainers,

 =C2=A0=C2=A0=C2=A0 Could you please review the current patchset and let me=
 know if you=20
have any concerns?


On 7/4/24 07:25, EwanHai wrote:
> ### Summary of changes
>
> EwanHai (4):
>    target/i386: Add support for Zhaoxin CPU vendor identification
>    target/i386: Add CPUID leaf 0xC000_0001 EDX definitions
>    target/i386: Introduce Zhaoxin Yongfeng CPU model
>    target/i386: Update CMPLegacy handling for Zhaoxin CPUs
>
>   target/i386/cpu.c | 128 ++++++++++++++++++++++++++++++++++++++++++++--
>   target/i386/cpu.h |  41 ++++++++++++++-
>   2 files changed, 165 insertions(+), 4 deletions(-)
>
> ### Changes since v1
> 1. Removed VIA-related information from the patch description to avoid
> misunderstanding.
> 2. Replaced CPUID_VENDOR_VIA with CPUID_VENDOR_ZHAOXIN1 because the
> "Centaurhauls" vendor ID now belongs to Zhaoxin.The previous CPUID_VENDOR=
_VIA
> macro was only defined but never used in QEMU, making this change
> straightforward.
>
> v1 link: https://lore.kernel.org/qemu-devel/20240625091905.1325205-1-ewan=
hai-
> oc@zhaoxin.com/
>
> ### Known Issues
> 1. Issue with VMX Preemption Timer Rate on Yongfeng CPU:
>     - Description: On Yongfeng CPUs, the VMX preemption timer rate is 128=
,
>       meaning that bits 4:0 of MSR_IA32_VMX_MISC_CTLS should be set to 7.
>       However, due to Intel's rate being 5, the Linux kernel has hardcode=
d
>       this value as 5: `#define VMX_MISC_EMULATED_PREEMPTION_TIMER_RATE 5=
`.
>     - Impact: This discrepancy can cause incorrect behavior in the VMX
>       preemption timer on Yongfeng CPUs.
>     - Workaround: A patch to correct this issue in the Linux kernel is
>       currently being prepared and will be submitted soon.


