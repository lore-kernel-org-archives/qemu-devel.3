Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3647BC369B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 01:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4VOF-0006WW-OY; Mon, 14 Apr 2025 21:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1u4VOC-0006V2-Gc
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 21:47:04 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1u4VO9-0008B5-U4
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 21:47:04 -0400
X-ASG-Debug-ID: 1744681612-086e2365bac0e70001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx1.zhaoxin.com with ESMTP id R7uXYrkH2TYINYEr (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 15 Apr 2025 09:46:52 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 15 Apr
 2025 09:46:52 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Tue, 15 Apr 2025 09:46:52 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 15 Apr
 2025 09:44:20 +0800
Message-ID: <d2d8c2d1-0e71-4cae-aebc-63b36e4f6165@zhaoxin.com>
Date: Tue, 15 Apr 2025 09:44:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/i386: Fix model number of Zhaoxin YongFeng vCPU
 template
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH v3] target/i386: Fix model number of Zhaoxin
 YongFeng vCPU template
CC: <pbonzini@redhat.com>, <xiaoyao.li@intel.com>, <ewanhai@zhaoxin.com>,
 <cobechen@zhaoxin.com>, <qemu-devel@nongnu.org>
References: <20250414075342.411626-1-ewanhai-oc@zhaoxin.com>
 <Z/0kMumrF4XCo/C/@intel.com>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <Z/0kMumrF4XCo/C/@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 4/15/2025 9:46:50 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1744681612
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1520
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.139976
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



On 4/14/25 11:05 PM, Zhao Liu wrote:
>=20
> On Mon, Apr 14, 2025 at 03:53:42AM -0400, Ewan Hai wrote:
>> Date: Mon, 14 Apr 2025 03:53:42 -0400
>> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
>> Subject: [PATCH v3] target/i386: Fix model number of Zhaoxin YongFeng vC=
PU
>>   template
>> X-Mailer: git-send-email 2.34.1
>>
>> The model number was mistakenly set to 0x0b (11) in commit ff04bc1ac4.
>> The correct value is 0x5b. This mistake occurred because the extended
>> model bits in cpuid[eax=3D0x1].eax were overlooked, and only the base
>> model was used.
>>
>> Using the wrong model number can affect guest behavior. One known issue
>> is that vPMU (which relies on the model number) may fail to operate
>> correctly.
>>
>> This patch corrects the model field by introducing a new vCPU version.
>>
>> Fixes: ff04bc1ac4 ("target/i386: Introduce Zhaoxin Yongfeng CPU model")
>> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
>> ---
>>   target/i386/cpu.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>=20
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>=20
> BTW, if you want to add more notes or explaination to strongly ask users
> to use v2, you can add a section "Preferred CPU models for Zhaoxin x86
> hosts" in docs/system/cpu-models-x86.rst.inc.

Thanks for the reminder and the review, Zhao. I'll send a v4 patch that inc=
ludes=20
a new section titled =E2=80=9CPreferred CPU models for Zhaoxin x86 hosts=E2=
=80=9D in=20
docs/system/cpu-models-x86.rst.inc to strongly recommend using v2.


