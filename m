Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A44BCF6BE9
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 04:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdLPb-00014H-G1; Tue, 06 Jan 2026 23:44:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vdLPZ-00013K-I9
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 23:44:45 -0500
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vdLPW-0003Pa-Jz
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 23:44:45 -0500
X-ASG-Debug-ID: 1767761068-086e2306f805e50001-jgbH7p
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by
 mx1.zhaoxin.com with ESMTP id JMYcxbz2YPWb45vE (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Wed, 07 Jan 2026 12:44:28 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 7 Jan
 2026 12:44:27 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Wed, 7 Jan 2026 12:44:27 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ewan-server.zhaoxin.com (10.28.44.15) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 7 Jan
 2026 11:36:30 +0800
Received: from [10.28.44.6] (EwanHaiuntuMini.zhaoxin.com [10.28.44.6])
 by ewan-server.zhaoxin.com (Postfix) with ESMTP id 158112D02719;
 Tue,  6 Jan 2026 22:36:30 -0500 (EST)
Message-ID: <a7a26e68-5a90-49ac-90b9-6cc8dc96ef39@zhaoxin.com>
Date: Wed, 7 Jan 2026 11:36:29 +0800
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
 <d20164c5-291c-4646-86cb-fddc69542599@zhaoxin.com>
 <aT/O1u22C1o3p5sn@intel.com>
 <a8516d27-0ee9-4139-9d47-51eda832c219@zhaoxin.com>
 <aV3ZKFlCGFyeZ0wh@intel.com>
Content-Language: en-US
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <aV3ZKFlCGFyeZ0wh@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.44.15]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 1/7/2026 12:44:26 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1767761068
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://mx2.zhaoxin.com:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2443
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.152672
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
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

On 1/7/26 11:55 AM, Zhao Liu wrote:
> 
> 
>>>> As background, current Zhaoxin CPUs implement several CPUID.(EAX=0xC0000001,
>>>> ECX=0):EDX feature bits that are not yet defined in the Linux kernel, for
>>>> example SM2/SM2_EN, SM3/SM4 and their enable bits, PARALLAX/PARALLAX_EN,
>>>> TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, and RSA/RSA_EN.
>>>>
>>>> We previously tried to upstream all these extra feature bits in one
>>>> patch(https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxin.com/),
>>>> but the maintainer rejected it because there was no in-tree code using these
>>>> features yet. So our current plan is to add the CPUID bits together with real
>>>> kernel users step by step.
>>>
>>> I see. I think it's enough to document missing CPUIDs in comment.
>>>
>>
>> Would the following comment be acceptable?
>>
>> /*
>>  * missing: SM2/SM2_EN, CCS/CCS_EN, PARALLAX/PARALLAX_EN,
>>  * TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, RSA/RSA_EN
>>  */
> 
> Yes, look good to me.
> 
>> Do you think I should also include the lore link in the commit message/cover
>> letter for additional context?
> 
> Yes, mentioning the link in commit message is good. More information is
> helpful.
> 
>>> Could we make Shijidadao-Client as a v2 of Shijidadao-Server, and create an
>>> alias for this v2?
>>>
>>> .alias = "Shijidadao-Client"
>>>
>>> Then we could rename Shijidadao-Server to Shijidadao, and its v2 is for
>>> client.
>>>
>>>> This is also aligned with how QEMU models other vendors' micro-architectures
>>>> where client and server products have slightly different feature sets.
>>>
>>> The main use case for CPU models is to easy migration across mixed CPU
>>> clusters [*]. So, IMO, not all products require a model.
>>
>> For the CPU model naming/versioning, my plan is:
>> The current Shijidadao will be equivalent to the old Shijidadao-Client-v2, drop
>> the old Shijidadao-Client-v1 according to your advice, Shijidadao-v1 will have
>> the alias Shijidadao-Client, and Shijidadao-v2 will have the alias
>> Shijidadao-Server.
> 
> Migration should have more use cases for the server. Personally, I feel
> using the server version as the base model might be more convenient?
> Anyway, it's up to you. Overall, these are fine for me.

I hadn't considered that server-side migration is a more common use case, thanks
a lot. See you in v3.

Best wishes,
Ewan.



