Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0582FC369D5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 03:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9bY5-0008R5-G5; Mon, 28 Apr 2025 23:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1u9bY2-0008QZ-PV
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 23:22:18 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1u9bXy-0002ai-OQ
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 23:22:18 -0400
X-ASG-Debug-ID: 1745896921-1eb14e386d24b20001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx2.zhaoxin.com with ESMTP id Ox1DhdvKIN2G4DQq (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 29 Apr 2025 11:22:01 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 29 Apr
 2025 11:22:00 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Tue, 29 Apr 2025 11:22:00 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 29 Apr
 2025 11:02:15 +0800
Message-ID: <c111d9f9-2914-4b41-811a-b3a9ad0d83a9@zhaoxin.com>
Date: Tue, 29 Apr 2025 11:02:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
CC: <yeeli@zhaoxin.com>, <cobechen@zhaoxin.com>, <ewanhai@zhaoxin.com>,
 <MaryFeng@zhaoxin.com>, <Runaguo@zhaoxin.com>, <Xanderchen@zhaoxin.com>,
 <Alansong@zhaoxin.com>, <qemu-devel@nongnu.org>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: [Bug] QEMU TCG warnings after commit c6bd2dd63420 - HTT / CMP_LEG bits
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ASG-Orig-Subj: [Bug] QEMU TCG warnings after commit c6bd2dd63420 - HTT /
 CMP_LEG bits
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 4/29/2025 11:21:59 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1745896921
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1818
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.140645
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

Hi Community,

This email contains 3 bugs appear to share the same root cause.

[1] We ran into the following warnings when running QEMU v10.0.0 in TCG mode:

qemu-system-x86_64 \
   -machine q35 \
   -m 4G -smp 4 \
   -kernel ./arch/x86/boot/bzImage \
   -bios /usr/share/ovmf/OVMF.fd \
   -drive file=~/kernel/rootfs.ext4,index=0,format=raw,media=disk \
   -drive file=~/kernel/swap.img,index=1,format=raw,media=disk \
   -nographic \
   -append 'root=/dev/sda rw resume=/dev/sdb console=ttyS0 nokaslr'

qemu-system-x86_64: warning: TCG doesn't support requested feature: 
CPUID.01H:EDX.ht [bit 28]
qemu-system-x86_64: warning: TCG doesn't support requested feature: 
CPUID.80000001H:ECX.cmp-legacy [bit 1]
(repeats 4 times, once per vCPU)

Tracing the history shows that commit c6bd2dd63420 "i386/cpu: Set up CPUID_HT in 
x86_cpu_expand_features() instead of cpu_x86_cpuid()" is what introduced the 
warnings.

Since that commit, TCG unconditionally advertises HTT (CPUID 1 EDX[28]) and 
CMP_LEG (CPUID 8000_0001 ECX[1]). Because TCG itself has no SMT support, these 
bits trigger the warnings above.

[2] Also, Zhao pointed me to a similar report on GitLab:
https://gitlab.com/qemu-project/qemu/-/issues/2894
The symptoms there look identical to what we're seeing.

By convention we file one issue per email, but these two appear to share the 
same root cause, so I'm describing them together here.

[3] My colleague Alan noticed what appears to be a related problem: if we launch 
a guest with '-cpu <model>,-ht --enable-kvm', which means explicitly removing 
the ht flag, but the guest still reports HT(cat /proc/cpuinfo in linux guest) 
enabled. In other words, under KVM the ht bit seems to be forced on even when 
the user tries to disable it.

Best regards,
Ewan

