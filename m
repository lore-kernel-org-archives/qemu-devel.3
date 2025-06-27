Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060C1C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 09:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5Z4-0005pl-BA; Fri, 27 Jun 2025 05:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uV5Z1-0005mU-Bp
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:40:07 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uV5Yy-0001LJ-P3
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:40:07 -0400
X-ASG-Debug-ID: 1751017194-1eb14e1c3a1fa40001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx2.zhaoxin.com with ESMTP id hjHWuGLffw1Dhp5h (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 27 Jun 2025 17:39:54 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Fri, 27 Jun
 2025 17:39:54 +0800
Received: from ZXSHMBX1.zhaoxin.com ([::1]) by ZXSHMBX1.zhaoxin.com
 ([fe80::2c07:394e:4919:4dc1%7]) with mapi id 15.01.2507.044; Fri, 27 Jun 2025
 17:39:54 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Fri, 27 Jun
 2025 13:52:35 +0800
Message-ID: <d16b665f-8d37-4c20-b578-4bb8f87b120e@zhaoxin.com>
Date: Fri, 27 Jun 2025 13:52:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: Re: [PATCH 3/4] i386/cpu: Mark ECX/EDX in CPUID 0x80000008 leaf as
 reserved for Intel
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>
X-ASG-Orig-Subj: Re: [PATCH 3/4] i386/cpu: Mark ECX/EDX in CPUID 0x80000008
 leaf as reserved for Intel
CC: Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>, Yi Lai
 <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 <qemu-devel@nongnu.org>
References: <20250627035129.2755537-1-zhao1.liu@intel.com>
 <20250627035129.2755537-4-zhao1.liu@intel.com>
In-Reply-To: <20250627035129.2755537-4-zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 6/27/2025 5:39:53 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1751017194
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1470
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.143463
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=61.152.208.219;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/27/25 11:51 AM, Zhao Liu wrote:
> 
> 
> Per SDM,
> 
> 80000008H EAX Linear/Physical Address size.
>                Bits 07-00: #Physical Address Bits*.
>                Bits 15-08: #Linear Address Bits.
>                Bits 31-16: Reserved = 0.
>            EBX Bits 08-00: Reserved = 0.
>                Bit 09: WBNOINVD is available if 1.
>                Bits 31-10: Reserved = 0.
>            ECX Reserved = 0.
>            EDX Reserved = 0.
> 
> ECX/EDX in CPUID 0x80000008 leaf are reserved. Encode these 2 registers
> as 0 for Intel.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/cpu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 6d590a9af389..5d5a227d4c8a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8391,6 +8391,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                *eax |= (cpu->guest_phys_bits << 16);
>           }
>           *ebx = env->features[FEAT_8000_0008_EBX];
> +
> +        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {

Please add IS_ZHAOXIN_CPU(env), Zhaoxin follow SDM's definition on cpuid leaf 
0x8000_0008.

> +            *ecx = *edx = 0;
> +            break;
> +        }
> +
>           if (threads_per_pkg > 1) {
>               /*
>                * Bits 15:12 is "The number of bits in the initial
> --
> 2.34.1
> 


