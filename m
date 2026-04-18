Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E34CF99C9C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFN-0008CI-0B; Sat, 18 Apr 2026 18:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEFJ-0007u3-HM
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:37 -0400
Received: from p-east2-cluster1-host9-snip4-10.eps.apple.com ([57.103.76.113]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEFH-0005F6-Sf
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:37 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 7C6EB18000B2; Sat, 18 Apr 2026 22:34:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551675; x=1779143675;
 bh=807zz0/7sYSsB/HXM1SaVwEK4Bcpla9/VhldGOyRpbY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TVEtyC2jzYjMIdwyCFdVcCztJ+Z5H8DU2TodVSORS6yCevdHpxg/I16eBmWlM/k5HUwSz7OO/FdxZrMuOQR60yzu5jF4ZCKIUOZS+h30lCcIZkXvvn2Dg2bNo92swURFA2g95i/01UdERvZdZyVkZgqzm6y9zGDr63l8cK64mkHX9C5JzCz3YQjY5cxstXFBKlTFZWvqs85rFewH+/xKPJ7Wc8o6CYDYQtywlLtyQeDOhRlpxr0C5U4l7sMs3KpMLFsxWNJw7mk6FmCouJnBHN+QFDrvvplrztiX8G5En3+hcgWcM73tJkKhXo7/p/LUEXbiIaMGKaxFKKAc4np73Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 9CF8F18000B4; Sat, 18 Apr 2026 22:34:32 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 38/38] whpx: i386: documentation update
Date: Sun, 19 Apr 2026 00:33:20 +0200
Message-ID: <20260418223320.51330-39-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOSBTYWx0ZWRfXzM5660FGPlj9
 ibFjL9TqC2pLSTtBvXdLENeT2+XQKkhuxQeP4asQLQovBJM+OIVSIbKt4Rq/4BvbuJexkPtkTI7
 WfOYo4FLGLYgo/X0qA59iDXmceVzSxq9Tdzp38Fstc6ekIr5TG85cWasYjY2k+nmf9USjZe2/Zt
 KmsJsj1kCPILKAkOfqmLseMRVhymiKXCjcsUZrJ36grUrfbzAo7PhWd2V2wdrOfk0hwaWSb6Fcf
 4AeRZ7/MHWd3Nxs9AIReDqQ0pXxkbBMvgeemeWpG5ehBceUpBg9qQdFp5gl+/VEgDcuPVyeEKOX
 J+w5K1Q1u5CzW5nmZoXfTbYVIogv+RLFfK5hTkNPH0voifTQX3U9g3DJN91+j8=
X-Proofpoint-ORIG-GUID: pxljc2Geb056nBLqDszJi9NQoVgEbJ0o
X-Authority-Info-Out: v=2.4 cv=YvwChoYX c=1 sm=1 tr=0 ts=69e406fa
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w2p0zGFWpCDavkAFAbUA:9
X-Proofpoint-GUID: pxljc2Geb056nBLqDszJi9NQoVgEbJ0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0
 mlxlogscore=690 suspectscore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180229
Received-SPF: pass client-ip=57.103.76.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 docs/system/whpx.rst | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/docs/system/whpx.rst b/docs/system/whpx.rst
index 3e1979028c..8c9fea883e 100644
--- a/docs/system/whpx.rst
+++ b/docs/system/whpx.rst
@@ -96,38 +96,18 @@ MMX, SSE or AVX instructions for access to MMIO memory ranges.
 Attempts to run such guests will result in an ``Unimplemented handler``
 warning for MMX and a failure to decode for newer instructions.
 
-``-M isapc``
-^^^^^^^^^^^^
-
-``-M isapc`` doesn't disable the Hyper-V LAPIC on its own yet. To
-be able to use that machine, use ``-accel whpx,hyperv=off,kernel-irqchip=off``.
-
-However, in QEMU 11.0, the guest will still be a 64-bit x86
-ISA machine with all the corresponding CPUID leaves exposed.
-
-gdbstub
-^^^^^^^
-
-As save/restore of xsave state is not currently present, state
-exposed through GDB will be incomplete.
-
-The same also applies to ``info registers``.
-
-``-cpu type`` ignored
-^^^^^^^^^^^^^^^^^^^^^
-
-In this release, -cpu is an ignored argument. 
-
 PIC interrupts on Windows 10
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 On Windows 10, a legacy PIC interrupt injected does not wake the guest
 from an HLT when using the Hyper-V provided interrupt controller.
 
-This has been addressed in QEMU 11.0 on Windows 11 platforms but
-functionality to make it available on Windows 10 isn't present.
+As such, on Windows 10, using the Hyper-V interrupt controller is 
+disabled by default. You can enable it via ``-M q35,pic=off`` which
+disables the PIC. In that configuration, using a UEFI is recommended.
 
-Workaround: for affected use cases, use ``-M kernel-irqchip=off``.
+On this release, ``-M kernel-irqchip=`` is not expected to be manually
+set during normal operation. It remains as a debugging option.
 
 Known issues on Windows 11
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.50.1 (Apple Git-155)


