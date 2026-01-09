Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880F9D232CE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 02:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve21L-00015r-37; Thu, 08 Jan 2026 21:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1ve21J-00014h-2v
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 21:14:33 -0500
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1ve21H-0002Nv-By
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 21:14:32 -0500
X-ASG-Debug-ID: 1767924867-1eb14e7c0108680001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx2.zhaoxin.com with ESMTP id dFcf6jxUhmEhEyCN (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 09 Jan 2026 10:14:27 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 9 Jan
 2026 10:14:27 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Fri, 9 Jan 2026 10:14:27 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ewan-server.zhaoxin.com (10.28.44.15) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 9 Jan
 2026 10:10:28 +0800
Received: by ewan-server.zhaoxin.com (Postfix, from userid 1000)
 id 223862D0005D; Thu,  8 Jan 2026 21:10:28 -0500 (EST)
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>
Subject: [PATCH v3 3/3] target/i386: Fix FEAT_C000_0001_EDX comment in
 Yongfeng model
Date: Thu, 8 Jan 2026 21:10:28 -0500
X-ASG-Orig-Subj: [PATCH v3 3/3] target/i386: Fix FEAT_C000_0001_EDX comment in
 Yongfeng model
Message-ID: <20260109021028.83985-4-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109021028.83985-1-ewanhai-oc@zhaoxin.com>
References: <20260109021028.83985-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.44.15]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 1/9/2026 10:14:26 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1767924867
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1874
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.152762
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

Update the comment for FEAT_C000_0001_EDX in YongFeng CPU model to
accurately list the missing features instead of the generic TODO message.

As background, current Zhaoxin CPUs implement several CPUID.(EAX=3D0xC00000=
01,
ECX=3D0):EDX feature bits that are not yet defined in the Linux kernel, for
example SM2/SM2_EN, SM3/SM4 and their enable bits, PARALLAX/PARALLAX_EN,
TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, and RSA/RSA_EN.

We previously tried to upstream all these extra feature bits in one patch
(https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxin.com=
/),
but the maintainer rejected it because there was no in-tree code using thes=
e
features yet. So our current plan is to add the CPUID bits together with re=
al
kernel users step by step, Once full or partial in-tree implementations of
these features are merged, we will update these definitions accordingly and
potentially introduce corresponding support in QEMU.

Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 34e3e66344..10603eeb31 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6958,8 +6958,8 @@ static const X86CPUDefinition builtin_x86_defs[] =3D =
{
             CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM=
,
         .features[FEAT_8000_0007_EDX] =3D CPUID_APM_INVTSC,
         /*
-         * TODO: When the Linux kernel introduces other existing definitio=
ns
-         * for this leaf, remember to update the definitions here.
+         * missing: SM2/SM2_EN, CCS/CCS_EN, PARALLAX/PARALLAX_EN,
+         * TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, RSA/RSA_EN
          */
         .features[FEAT_C000_0001_EDX] =3D
             CPUID_C000_0001_EDX_PMM_EN | CPUID_C000_0001_EDX_PMM |
--=20
2.34.1


