Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE45F5580E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm7I-0000nZ-MX; Mon, 20 Apr 2026 06:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm7G-0000a8-LJ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:34 -0400
Received: from p-west3-cluster4-host12-snip4-10.eps.apple.com ([57.103.74.231]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm7E-0000r8-T8
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:34 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 94429180014D; Mon, 20 Apr 2026 10:44:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681871; x=1779273871;
 bh=aRSWuZJ+0O4EI30ImauiiaFewa0d6ZTDxWu6Xb9/aUo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bBR1Tk3wovzThNLzZejOST9s2HHaLcMZsFhOjpc2pij77JYr/aZ0GlQnhhBO6ch0KCM/MmHmGWwLCi/IiIVULN6/31qAMsoRapU6scCqwrCRF899LOceVznS6zUo89LvA7qZEcfsF7JDeVAovPYf9jmLIqMfJyU93qA2ufAzydKK34M+rMRG/zuE9xcVAU5me/gg158O3S8jcITQ5D/D5D85Ojz8evgA3wIThzLlul9hKLPUqyJjdzRSQCOo8G+IBW/SbzeBR/frBJVgfY0wcB9wz4uSMJlYH6ZMmoKqBR/qc/KEp0/T1/1KEUWa1DMOv8Eo+r0drEfSbjgY6SJwng==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 B0FCE1800151; Mon, 20 Apr 2026 10:44:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 38/38] whpx: i386: documentation update
Date: Mon, 20 Apr 2026 12:42:48 +0200
Message-ID: <20260420104248.86702-39-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: K6H8eRIvVlEItfTGK27ckSJegMdQQonL
X-Authority-Info-Out: v=2.4 cv=QJVlhwLL c=1 sm=1 tr=0 ts=69e6038e
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w2p0zGFWpCDavkAFAbUA:9
X-Proofpoint-ORIG-GUID: K6H8eRIvVlEItfTGK27ckSJegMdQQonL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX0JuxT9pQ6Def
 ELEfCojMXbmuukJBg6lx7/erIvqqQfF1NXw7lFt+0/HVNRGkUFqppTAiWJVpM9Nkq5R2qnP4j9C
 syIEBVctNzpY4oAYvoX1kqLG2m7R/8u41gSRyZImuCfXuG5TQhr3irQ4/s3NG38deBSMyQgFc2/
 rEWDCQDYFKTlIynPT6cIQZZyTyh2TCu6rHkrAztysGZJrvDW0SOMIlNLvzJISXxgFS6A00S39Sq
 +qtKnqW2P3gneYRUnX5bY9pBoBewrj7ciMDy05+etD0/PtqkQT3ME+WjGB4whek0GjlyQhQa7gQ
 /gQluy2tnMfQxxUdMGXEi/FYSXi6gzuiPsRmCK9dTIZ29GqEHa0su8qYCWwChU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 clxscore=1030 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=690 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.74.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 3e1979028c..b7006f6c2e 100644
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


