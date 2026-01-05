Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CE0C47BC4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 08:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd2Gr-00080D-G9; Tue, 06 Jan 2026 03:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vd2Go-0007yY-OF
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 03:18:26 -0500
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vd2Gl-000087-Js
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 03:18:26 -0500
X-ASG-Debug-ID: 1767687486-086e2306f6032d0001-jgbH7p
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by
 mx1.zhaoxin.com with ESMTP id x3dK7Tvg07K7K5Ih (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 06 Jan 2026 16:18:06 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 6 Jan
 2026 16:18:06 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Tue, 6 Jan 2026 16:18:06 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ewan-server.zhaoxin.com (10.28.44.15) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 6 Jan
 2026 15:54:38 +0800
Received: from [10.28.44.6] (EwanHaiuntuMini.zhaoxin.com [10.28.44.6])
 by ewan-server.zhaoxin.com (Postfix) with ESMTP id A34382D02A1E;
 Mon,  5 Jan 2026 05:11:12 -0500 (EST)
Message-ID: <a8516d27-0ee9-4139-9d47-51eda832c219@zhaoxin.com>
Date: Mon, 5 Jan 2026 18:11:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: Re: [PATCH v2 3/4] target/i386: Introduce Zhaoxin Shijidadao-Client
 CPU model
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH v2 3/4] target/i386: Introduce Zhaoxin
 Shijidadao-Client CPU model
CC: <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>,
 <cobechen@zhaoxin.com>, <TonyWWang@zhaoxin.com>
References: <20251027102139.270662-1-ewanhai-oc@zhaoxin.com>
 <20251027102139.270662-4-ewanhai-oc@zhaoxin.com> <aSVcOX5WvJYjIEbM@intel.com>
 <d20164c5-291c-4646-86cb-fddc69542599@zhaoxin.com>
 <aT/O1u22C1o3p5sn@intel.com>
Content-Language: en-US
In-Reply-To: <aT/O1u22C1o3p5sn@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.44.15]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 1/6/2026 4:18:05 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1767687486
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://mx2.zhaoxin.com:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6693
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.21
X-Barracuda-Spam-Status: No,
 SCORE=-1.21 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_PAST_12_24,
 DATE_IN_PAST_12_24_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.152631
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.01 DATE_IN_PAST_12_24     Date: is 12 to 24 hours before Received: date
 0.80 DATE_IN_PAST_12_24_2   DATE_IN_PAST_12_24_2
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
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

On 12/15/25 5:03 PM, Zhao Liu wrote:
> 
> 
> On Tue, Nov 25, 2025 at 04:57:04PM +0800, Ewan Hai wrote:
>> Date: Tue, 25 Nov 2025 16:57:04 +0800
>> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
>> Subject: Re: [PATCH v2 3/4] target/i386: Introduce Zhaoxin
>>  Shijidadao-Client CPU model
>>
>> On 11/25/25 3:35 PM, Zhao Liu wrote:
>>>
>>>
>>>> +        /*
>>>> +         * TODO: When the Linux kernel introduces other existing definitions
>>>> +         * for this leaf, remember to update the definitions here.
>>>> +         */
>>>
>>> This TODO seems a bit vague; it's best to explicitly list the existing
>>> features that are currently missing. Otherwise, maintainers won't be
>>> able to understand or clean up this TODO either.
>>>
>>
>> I agree. The same problem also exists in the YongFeng vCPU model. For this
>> series, I can drop the vague TODO and instead add a more explicit comment that
>> documents which CPUID.C000_0001.EDX bits are intentionally missing today. In
>> addition, I can post a small follow-up cleanup patch to fix the YongFeng model
>> in the same way, so the two Zhaoxin models stay consistent. If you prefer, I can
>> also fold the YongFeng comment update into this series as an extra patch.
> 
> Yes, it's good to make everything clear and I think it's better to
> include your extra patch into this series to help maintainer review/pick
> in one goes.

Got it.

>> As background, current Zhaoxin CPUs implement several CPUID.(EAX=0xC0000001,
>> ECX=0):EDX feature bits that are not yet defined in the Linux kernel, for
>> example SM2/SM2_EN, SM3/SM4 and their enable bits, PARALLAX/PARALLAX_EN,
>> TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, and RSA/RSA_EN.
>>
>> We previously tried to upstream all these extra feature bits in one
>> patch(https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxin.com/),
>> but the maintainer rejected it because there was no in-tree code using these
>> features yet. So our current plan is to add the CPUID bits together with real
>> kernel users step by step.
> 
> I see. I think it's enough to document missing CPUIDs in comment.
> 

Would the following comment be acceptable?

/*
 * missing: SM2/SM2_EN, CCS/CCS_EN, PARALLAX/PARALLAX_EN,
 * TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, RSA/RSA_EN
 */

Do you think I should also include the lore link in the commit message/cover
letter for additional context?

> ...
> 
>>> (Based on my personal experience, the absence of SMAP seems a bit
>>> odd. Could it be a hardware bug in a specific stepping?)
>>>
>>
>> This is not a stepping-specific silicon bug. For this product family, SMAP
>> support was intentionally not enabled in the final product because our internal
>> performance evaluation showed an unacceptable performance impact in certain
>> workloads. The v2 CPU model therefore keeps "smap" off to reflect the actual
>> shipped behavior, while the v1 definition with SMAP enabled is kept for
>> customers who need to model early v1 silicon where SMAP is still available.
> 
> v1 is not the final product, then I think it's not necessary to upstream
> it. For example, these Intel CPU models are basically all targeted at
> the final products. But unluckily, engineering samples may have bugs so
> we have to add or remove features based on what the final products
> support. So if the final product is clear from the beginning, there's no
> need to take intermediate steps.
> 
> BTW, even with v2, user can still enable smap by +smap.
> 
>>>> +                .props = (PropValue[]) {
>>>> +                    { "xsavec", "on" },
>>>> +                    { "xgetbv1", "on" },
>>>> +                    { "xsaves", "on"},
>>>> +                    { "vmx-xsaves", "on"},
>>>> +                    { "smap", "off" },
>>>> +                    { /* end of list */ }
>>>> +                },
>>>> +            },
>>>
>>> BTW, if the differences aren't too significant, is it possible to merge
>>> the server and client models? :)
>>>
>>
>> From the user point of view, I slightly prefer keeping separate
>> Shijidadao-Client and Shijidadao-Server models.
>>
>> The main reason is that customers who want a "full-feature" vCPU that behaves
>> very close to a specific physical product can simply pick the corresponding
>> model name, without having to remember a set of extra "-cpu ..., +-feature"
>> overrides. If we merge everything into a single Shijidadao model that
>> corresponds to a more restricted baseline, users who want the full configuration
>> would need to explicitly enable multiple features (such as the additional XSAVE
>> bits) on the command line, which is easier to get wrong and less user-friendly.
> 
> Could we make Shijidadao-Client as a v2 of Shijidadao-Server, and create an
> alias for this v2?
> 
> .alias = "Shijidadao-Client"
> 
> Then we could rename Shijidadao-Server to Shijidadao, and its v2 is for
> client.
> 
>> This is also aligned with how QEMU models other vendors' micro-architectures
>> where client and server products have slightly different feature sets.
> 
> The main use case for CPU models is to easy migration across mixed CPU
> clusters [*]. So, IMO, not all products require a model.

For the CPU model naming/versioning, my plan is:
The current Shijidadao will be equivalent to the old Shijidadao-Client-v2, drop
the old Shijidadao-Client-v1 according to your advice, Shijidadao-v1 will have
the alias Shijidadao-Client, and Shijidadao-v2 will have the alias
Shijidadao-Server.

A key code sketch would look like:

    {
        .name = "Shijidadao",
        .level = 0x1f,
        .vendor = CPUID_VENDOR_ZHAOXIN1,
        .family = 7,
        .model = 0x6b,
        .stepping = 1,
...

        .model_id = "Zhaoxin Shijidadao-Client Processor",
        .cache_info = &shijidadao_cache_info,
        .versions = (X86CPUVersionDefinition[]) {
            { .version = 1, .alias = "Shijidadao-Client" },
            {
                .version = 2,
                .alias = "Shijidadao-Server",
                .note = "server variant",
                .props = (PropValue[]) {
                    { "model", "0x7b" },
                    { "stepping", "0" },
                    { "core-capability", "on" },
                    { "split-lock-detect", "on" },
                    { "model-id",
                      "Zhaoxin Shijidadao-Server Processor" },
                    { /* end of list */ }
                },
            },
            { /* end of list */ }
        }
    },

Does this mapping look acceptable to you?


Best wishes,
Ewan.


