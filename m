Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43A5CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 05:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDG6z-000625-4i; Mon, 27 Oct 2025 01:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vDG6w-00061Q-J0
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 01:49:42 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vDG6t-0001p0-S5
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 01:49:42 -0400
X-ASG-Debug-ID: 1761544163-1eb14e3d885fb30001-jgbH7p
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by
 mx2.zhaoxin.com with ESMTP id zYJZQ2sHxRe4C4td (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 27 Oct 2025 13:49:23 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 27 Oct
 2025 13:49:23 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Mon, 27 Oct 2025 13:49:23 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [192.168.31.91] (10.28.24.130) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 27 Oct
 2025 11:44:12 +0800
Message-ID: <53c9af0b-49e2-4ec3-8846-01d44b2a9745@zhaoxin.com>
Date: Mon, 27 Oct 2025 11:42:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/i386: Introduce Zhaoxin Shijidadao-Server CPU
 model
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH 3/3] target/i386: Introduce Zhaoxin
 Shijidadao-Server CPU model
CC: <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>,
 <cobechen@zhaoxin.com>
References: <20250923021133.190725-1-ewanhai-oc@zhaoxin.com>
 <20250923021133.190725-4-ewanhai-oc@zhaoxin.com> <aPsnqxDZR4KxgcdN@intel.com>
Content-Language: en-US
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <aPsnqxDZR4KxgcdN@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.24.130]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 10/27/2025 1:49:21 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1761544163
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1249
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.149244
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

On 10/24/25 3:15 PM, Zhao Liu wrote:
> 
> 
> On Mon, Sep 22, 2025 at 10:11:33PM -0400, Ewan Hai wrote:
>> Date: Mon, 22 Sep 2025 22:11:33 -0400
>> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
>> Subject: [PATCH 3/3] target/i386: Introduce Zhaoxin Shijidadao-Server CPU
>>  model
>> X-Mailer: git-send-email 2.34.1
>>
>> Shijidadao-Server hardware enables IA32_CORE_CAPABILITIES and relies on
>> the SPLIT_LOCK_DETECT feature. When the kernel has not yet virtualized
>> this MSR, KVM filters the capability and QEMU emits a warning.
>>
>> This patch retains the core-capability bit in the CPU model so it will
>> take effect once KVM support becomes available.
>>
>> In QEMU, vCPU models default to '.version = 1'. Since there is currently
>> no '.features[index]' mapping for the "x-force-cpuid-0x1f" property, this
>> patch adds that property to the v1 version of the model.
> 
> I'm preparing the CPU model for Diamond Rapids, and also meet this
> issue.
> 
> Well, I happen to have a patch for this and I think you could give it
> a try. :)

That's good news. I'll test your patch and update mine accordingly.
When I send out v2, should I note in the cover letter that my patches are based
on your "0x1f option" patch?


