Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722F4CFD364
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 09:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNoxt-0004cj-SE; Tue, 25 Nov 2025 04:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vNoxq-0004c7-Vh
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 04:03:58 -0500
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vNoxk-0001ey-Um
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 04:03:57 -0500
X-ASG-Debug-ID: 1764061412-1eb14e3d8aadfc0001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx2.zhaoxin.com with ESMTP id vlO8oehyXsPLlCT0 (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 25 Nov 2025 17:03:32 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 25 Nov
 2025 17:03:32 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Tue, 25 Nov 2025 17:03:32 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from [192.168.31.91] (10.28.24.130) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 25 Nov
 2025 16:57:49 +0800
Message-ID: <d20164c5-291c-4646-86cb-fddc69542599@zhaoxin.com>
Date: Tue, 25 Nov 2025 16:57:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] target/i386: Introduce Zhaoxin Shijidadao-Client
 CPU model
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH v2 3/4] target/i386: Introduce Zhaoxin
 Shijidadao-Client CPU model
CC: <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>,
 <cobechen@zhaoxin.com>, <TonyWWang@zhaoxin.com>
References: <20251027102139.270662-1-ewanhai-oc@zhaoxin.com>
 <20251027102139.270662-4-ewanhai-oc@zhaoxin.com> <aSVcOX5WvJYjIEbM@intel.com>
Content-Language: en-US
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <aSVcOX5WvJYjIEbM@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.24.130]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 11/25/2025 5:03:30 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1764061412
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4361
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.150634
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=61.152.208.219;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/25/25 3:35 PM, Zhao Liu wrote:
> 
> 
>> +        /*
>> +         * TODO: When the Linux kernel introduces other existing definitions
>> +         * for this leaf, remember to update the definitions here.
>> +         */
> 
> This TODO seems a bit vague; it's best to explicitly list the existing
> features that are currently missing. Otherwise, maintainers won't be
> able to understand or clean up this TODO either.
> 

I agree. The same problem also exists in the YongFeng vCPU model. For this
series, I can drop the vague TODO and instead add a more explicit comment that
documents which CPUID.C000_0001.EDX bits are intentionally missing today. In
addition, I can post a small follow-up cleanup patch to fix the YongFeng model
in the same way, so the two Zhaoxin models stay consistent. If you prefer, I can
also fold the YongFeng comment update into this series as an extra patch.

As background, current Zhaoxin CPUs implement several CPUID.(EAX=0xC0000001,
ECX=0):EDX feature bits that are not yet defined in the Linux kernel, for
example SM2/SM2_EN, SM3/SM4 and their enable bits, PARALLAX/PARALLAX_EN,
TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, and RSA/RSA_EN.

We previously tried to upstream all these extra feature bits in one
patch(https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxin.com/),
but the maintainer rejected it because there was no in-tree code using these
features yet. So our current plan is to add the CPUID bits together with real
kernel users step by step.

>> +        .features[FEAT_C000_0001_EDX] =
>> +            CPUID_C000_0001_EDX_PMM_EN | CPUID_C000_0001_EDX_PMM |
>> +            CPUID_C000_0001_EDX_PHE_EN | CPUID_C000_0001_EDX_PHE |
>> +            CPUID_C000_0001_EDX_ACE2 |
>> +            CPUID_C000_0001_EDX_XCRYPT_EN | CPUID_C000_0001_EDX_XCRYPT |
>> +            CPUID_C000_0001_EDX_XSTORE_EN | CPUID_C000_0001_EDX_XSTORE,
> 
> ...
> 
>> +        .model_id = "Zhaoxin Shijidadao-Client Processor",
>> +        .cache_info = &shijidadao_cache_info,
>> +        .versions = (X86CPUVersionDefinition[]) {
>> +            { .version = 1 },
>> +            {
>> +                .version = 2,
>> +                .note = "with more XSAVE features",
> 
> it's better to mention "without smap" as well.
>

Sure, I will update the note to say "with more XSAVE features but without SMAP".

> (Based on my personal experience, the absence of SMAP seems a bit
> odd. Could it be a hardware bug in a specific stepping?)
> 

This is not a stepping-specific silicon bug. For this product family, SMAP
support was intentionally not enabled in the final product because our internal
performance evaluation showed an unacceptable performance impact in certain
workloads. The v2 CPU model therefore keeps "smap" off to reflect the actual
shipped behavior, while the v1 definition with SMAP enabled is kept for
customers who need to model early v1 silicon where SMAP is still available.

>> +                .props = (PropValue[]) {
>> +                    { "xsavec", "on" },
>> +                    { "xgetbv1", "on" },
>> +                    { "xsaves", "on"},
>> +                    { "vmx-xsaves", "on"},
>> +                    { "smap", "off" },
>> +                    { /* end of list */ }
>> +                },
>> +            },
> 
> BTW, if the differences aren't too significant, is it possible to merge
> the server and client models? :)
> 

From the user point of view, I slightly prefer keeping separate
Shijidadao-Client and Shijidadao-Server models.

The main reason is that customers who want a "full-feature" vCPU that behaves
very close to a specific physical product can simply pick the corresponding
model name, without having to remember a set of extra "-cpu ..., +-feature"
overrides. If we merge everything into a single Shijidadao model that
corresponds to a more restricted baseline, users who want the full configuration
would need to explicitly enable multiple features (such as the additional XSAVE
bits) on the command line, which is easier to get wrong and less user-friendly.

This is also aligned with how QEMU models other vendors' micro-architectures
where client and server products have slightly different feature sets.

Thanks again for the review!

Best regards,
Ewan.


