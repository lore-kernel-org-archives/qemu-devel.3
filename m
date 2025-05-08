Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E473C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 10:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCyWR-0000Uw-UD; Thu, 08 May 2025 06:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uCyWP-0000S4-JC
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:30:33 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uCyWM-0005q1-D6
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:30:33 -0400
X-ASG-Debug-ID: 1746700202-086e234ccf239f70001-jgbH7p
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by
 mx1.zhaoxin.com with ESMTP id 9ZLpbX4ztsD20uoG (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 08 May 2025 18:30:02 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 8 May
 2025 18:30:02 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Thu, 8 May 2025 18:30:02 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 8 May
 2025 17:45:15 +0800
Message-ID: <72e148fd-580c-4b63-8975-e71b7aabbf07@zhaoxin.com>
Date: Thu, 8 May 2025 17:45:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] QEMU TCG warnings after commit c6bd2dd63420 - HTT / CMP_LEG
 bits
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [Bug] QEMU TCG warnings after commit c6bd2dd63420 - HTT /
 CMP_LEG bits
CC: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <yeeli@zhaoxin.com>, <cobechen@zhaoxin.com>, <ewanhai@zhaoxin.com>,
 <MaryFeng@zhaoxin.com>, <Runaguo@zhaoxin.com>, <Xanderchen@zhaoxin.com>,
 <Alansong@zhaoxin.com>, <qemu-devel@nongnu.org>
References: <c111d9f9-2914-4b41-811a-b3a9ad0d83a9@zhaoxin.com>
 <006111a2-8406-46ed-a6bd-71d0c68edf4b@zhaoxin.com>
 <aBxzlUFqYj1Ltc+4@intel.com>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <aBxzlUFqYj1Ltc+4@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 5/8/2025 6:30:01 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1746700202
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1322
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.141087
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
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



On 5/8/25 5:04 PM, Zhao Liu wrote:
>=20
>>> [3] My colleague Alan noticed what appears to be a related problem: if
>>> we launch a guest with '-cpu <model>,-ht --enable-kvm', which means
>>> explicitly removing the ht flag, but the guest still reports HT(cat
>>> /proc/cpuinfo in linux guest) enabled. In other words, under KVM the ht
>>> bit seems to be forced on even when the user tries to disable it.
>>
>> XiaoYao reminded me that issue [3] stems from a different patch. Please
>> ignore it for now=E2=80=94I'll start a separate thread to discuss that o=
ne
>> independently.
>=20
> I haven't found any other thread :-).
>=20
Please refer to=20
https://lore.kernel.org/all/db6ae3bb-f4e5-4719-9beb-623fcff56af2@zhaoxin.co=
m/.

> By the way, just curious, in what cases do you need to disbale the HT
> flag? "-smp 4" means 4 cores with 1 thread per core, and is it not
> enough?
>=20
> As for the =E2=80=9C-ht=E2=80=9D behavior, I'm also unsure whether this s=
hould be fixed
> or not - one possible consideration is whether =E2=80=9C-ht=E2=80=9D woul=
d be useful.
>=20

I wasn't trying to target any specific use case, using "-ht" was simply a w=
ay to=20
check how the ht feature behaves under both KVM and TCG. There's no special=
=20
workload behind it; I just wanted to confirm that the flag is respected (or=
 not)=20
in each mode.





