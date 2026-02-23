Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD2FEEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXP-0006sa-Cd; Mon, 23 Feb 2026 18:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXN-0006qO-W1
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:26 -0500
Received: from qs-2002g-snip4-11.eps.apple.com ([57.103.87.201]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXM-0004Pe-9t
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:25 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 D2D241800149; Mon, 23 Feb 2026 23:40:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890023; x=1774482023;
 bh=YKGmjTwasOTKHJc2TN0N83W04DQ/70JvOkGojdqvAPY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Y+sSkGCkYME7ufx0sLh0ZMf0khE6HKebyvwo4Myb7PEwQG2EuvxjsHGJCunW1nCBKW1KTsxrsnSHusDAtSyD+3VdA5ecpeCaAJVclegl4YcwvESQoRRsg9GQmPQ5w01flBC9QeitacJSPCS3tpSqAJ1Mtqd2VWkBM1D0sItjmplUCmM4+eHg0nk3IHP2lEJwt2sfU96U3Y0POfCgrLRqFlBVU1ZtC4CdzY4OJKYh6qAkByop9QpoEDK7vNrE3zwamumaVrpmR1MrUAaE+NEM33sgaxjex7ipzQM+DoL1gZGrk05wc8kjSTOW9QUCEKLH1YCh5l6oy4zl1xJgqXy+UQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 85BD018003B0; Mon, 23 Feb 2026 23:40:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 13/28] whpx: i386: remove messages
Date: Tue, 24 Feb 2026 00:39:35 +0100
Message-ID: <20260223233950.96076-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX7Um6A/7c47+A
 LC+YsK30Zz42UMVoMg+H7d8GuiWfgopSVAHh5tYZupD9HBSjlYS7O+pgvgxvjAwvntuAPKcJhld
 yGnoWtwJYFxjXnGorsZNzMlXevMwBTVNqcm4xmKHL9xEvjLE2mE7iGlHkCziVMxotc5DS10Mfdi
 THxtfkB4S+fRpN4xVKkiiwuoXwQe2MMZp08OQwr6mVv3FhEBJXPcN3NXysTAFSKYLVryqmiKJ93
 qj+BagsSYpxSUUTkAy2L3lZDuWuG5DJi09wexK7iCztewSisOorTgpAezbSvFEkPwdfsBEolICa
 t6pja+7b4psi3neT0+X9TU4YuYUful8Y1XZ2gewpGdtpJyfYzWPZnZG/dUCdTY=
X-Proofpoint-GUID: vE74Hp7M4ml8bJyZFVqb4ASENjoi4-OM
X-Authority-Info-Out: v=2.4 cv=C5jkCAP+ c=1 sm=1 tr=0 ts=699ce565
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=tHCKdM3VofH7q6B9RbgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vE74Hp7M4ml8bJyZFVqb4ASENjoi4-OM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1030 mlxscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABuvNoQw0Fi2JIXRjC1rbquUDsEgaU+tisX0Mj3pI5WAAHBphKfn4gVIh1YKQ2DSvCBKKUqDY13K0Rtd0ALUD39hRcPQx97ZEUoU2hrwUH7mgUm6nlk5Dthd0UA+lTeY9GIOhWHGU667gWT8xxIdZqGofK21DoK7ehpDlZB1SIGuIXe4qandEXZ/ukLt9Okd2thlUi5Na/ATrrHsBV07BB44bEIpSr5+UIiVmTwCBMMv9v6er/WtMs30sLH+uWY9WWylcXtIrhG6PjAgi0R3tk0LkyGjwayXhvFFGHweTrg7JQUMl3iuC7OgYsJmgESx49iKOI7s29G4i4WtvCckjuWCkcbCowdSoLIqPQ602AB01F1HakHag1Y1EX6CDRyi0NzSvuEZlLBha6MXOJho5bifoIlsHcSRN6evyXM1oI8TPUQWMPGuUCvYK6RuERn6DpH7yfICYkc4nnEyBoyjpUG2nxUp3KxtTvUgWB7ywGoNAUhWkAx2UkzyYgXMuN/SF/79/159st0NM83CLa1MDYwl5QJxl7bhEn9GI0tpHkBKa9HmPVJBvUx7eXN2T7CeBwHZIoTy6S+FvXzVsVsUGqPzrO/s6+2ryByoutnrrhyisBCvFVwMR39NC72LGgAu8BIeMG4QyAF/BcJy5CsMya0wrUueox8r5VtbyNFGH4ZwGf8Saj2AgSLmauh9RHYPxb4rM2uunAMiXruuIJMGt3+TpEK49lcFjjExY6Ba9f+6n3i1OobUaCbkTEwfZev/1zLiG783BJHEI10Gl6NDQ4p/HSt4oxoLZpA5M=
Received-SPF: pass client-ip=57.103.87.201;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Remove some messages printed by the WHPX backend that don't
have an equivalent elsewhere and don't convey an error.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0524885053..2f2c613eda 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2163,7 +2163,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
         WHV_X64_LOCAL_APIC_EMULATION_MODE mode =
             WHvX64LocalApicEmulationModeXApic;
-        printf("WHPX: setting APIC emulation mode in the hypervisor\n");
         hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
             WHvPartitionPropertyCodeLocalApicEmulationMode,
@@ -2237,7 +2236,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     whpx_memory_init();
     whpx_init_emu();
 
-    printf("Windows Hypervisor Platform accelerator is operational\n");
     return 0;
 
 error:
-- 
2.50.1 (Apple Git-155)


