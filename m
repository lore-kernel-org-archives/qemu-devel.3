Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEFEC77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 09:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5Z6-0005sJ-Ku; Fri, 27 Jun 2025 05:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uV5Z4-0005qn-EG
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:40:10 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uV5Z1-0001QM-FK
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:40:10 -0400
X-ASG-Debug-ID: 1751017201-086e2327865c9a0001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx1.zhaoxin.com with ESMTP id TkgOSeSHLjZogceG (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 27 Jun 2025 17:40:01 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Fri, 27 Jun
 2025 17:40:01 +0800
Received: from ZXSHMBX1.zhaoxin.com ([::1]) by ZXSHMBX1.zhaoxin.com
 ([fe80::2c07:394e:4919:4dc1%7]) with mapi id 15.01.2507.044; Fri, 27 Jun 2025
 17:40:01 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Fri, 27 Jun
 2025 13:52:38 +0800
Message-ID: <eba721c2-ca12-4ee3-a011-e011fecc31af@zhaoxin.com>
Date: Fri, 27 Jun 2025 13:52:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: Re: [PATCH 1/4] i386/cpu: Mark EBX/ECX/EDX in CPUID 0x80000000 leaf
 as reserved for Intel
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>
X-ASG-Orig-Subj: Re: [PATCH 1/4] i386/cpu: Mark EBX/ECX/EDX in CPUID
 0x80000000 leaf as reserved for Intel
CC: Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>, Yi Lai
 <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 <qemu-devel@nongnu.org>
References: <20250627035129.2755537-1-zhao1.liu@intel.com>
 <20250627035129.2755537-2-zhao1.liu@intel.com>
In-Reply-To: <20250627035129.2755537-2-zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 6/27/2025 5:40:00 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1751017201
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 426
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -0.94
X-Barracuda-Spam-Status: No,
 SCORE=-0.94 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_PAST_03_06,
 DATE_IN_PAST_03_06_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.143464
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.01 DATE_IN_PAST_03_06     Date: is 3 to 6 hours before Received: date
 1.08 DATE_IN_PAST_03_06_2   DATE_IN_PAST_03_06_2
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> +        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {

Please also add IS_ZHAOXIN_CPU(env), since Zhaoxin follows the SDM definition 
for CPUID leaf 0x80000000.

> +            *ebx = *ecx = *edx = 0;
> +        } else {
> +            *ebx = env->cpuid_vendor1;
> +            *edx = env->cpuid_vendor2;
> +            *ecx = env->cpuid_vendor3;
> +        }


