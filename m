Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BB6C3601E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 00:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u32bU-0002HD-Eu; Thu, 10 Apr 2025 20:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1u32bO-0002Gq-Mg
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 20:50:40 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1u32bM-0001hp-BW
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 20:50:38 -0400
X-ASG-Debug-ID: 1744332625-1eb14e119b12d20001-jgbH7p
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by
 mx2.zhaoxin.com with ESMTP id 5kUWY0mSwI0HvyD2 (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 11 Apr 2025 08:50:25 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Fri, 11 Apr
 2025 08:50:25 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Fri, 11 Apr 2025 08:50:25 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 10 Apr
 2025 22:07:16 +0800
Message-ID: <a8750eb8-63ad-4ed8-a80d-f4568c4bc778@zhaoxin.com>
Date: Thu, 10 Apr 2025 22:07:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/i386: Fix model number of Zhaoxin YongFeng vCPU
 template
To: Paolo Bonzini <pbonzini@redhat.com>, <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH v2] target/i386: Fix model number of Zhaoxin
 YongFeng vCPU template
CC: <qemu-devel@nongnu.org>
References: <20250407020704.2580294-1-ewanhai-oc@zhaoxin.com>
 <a0ca7d33-5551-41a7-be18-7fdb3b32a36a@redhat.com>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <a0ca7d33-5551-41a7-be18-7fdb3b32a36a@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 4/11/2025 8:50:23 AM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1744332625
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1398
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.139784
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

On 4/10/25 8:22 PM, Paolo Bonzini wrote:
>=20
> On 4/7/25 04:07, Ewan Hai wrote:
>> The model number was mistakenly set to 0x0b (11) in commit ff04bc1ac4.
>> The correct value is 0x5b. This mistake occurred because the extended
>> model bits in cpuid[eax=3D0x1].eax were overlooked, and only the base
>> model was used.
>>
>> This patch corrects the model field.
>=20
> Hi, please follow commit e0013791b9326945ccd09b5b602437beb322cab8 to
> define a new version of the CPU.

I=E2=80=99ve noticed that in the QEMU repository at commit=20
e0013791b9326945ccd09b5b602437beb322cab8 (as HEAD), the following patches I=
=20
previously submitted (which the Zhaoxin YongFeng vCPU model depends on) are=
 not=20
included:
- 5d20aa540b6991c0dbeef933d2055e5372f52e0e: "target/i386: Add support for=20
Zhaoxin CPU vendor identification"
- c0799e8b003713e07b546faba600363eccd179ee: "target/i386: Add CPUID leaf=20
0xC000_0001 EDX definitions"
- ff04bc1ac478656e5d6a255bf4069edb3f55bc58: "target/i386: Introduce Zhaoxin=
=20
Yongfeng CPU model" (this is the main patch that needs to be fixed)
- a4e749780bd20593c0c386612a51bf4d64a80132: "target/i386: Mask CMPLegacy bi=
t in=20
CPUID[0x80000001].ECX for Zhaoxin CPUs"

Should I resend the entire patchset, or would it be sufficient to just send=
 a=20
revised version of the =E2=80=9Ctarget/i386: Introduce Zhaoxin Yongfeng CPU=
 model=E2=80=9D patch?

Thank you for your guidance.


