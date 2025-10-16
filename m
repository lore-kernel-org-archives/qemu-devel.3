Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02A7CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RxT-0007Vj-R7; Thu, 16 Oct 2025 13:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RxA-0007HT-CN
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:39:54 -0400
Received: from p-east2-cluster1-host9-snip4-10.eps.apple.com ([57.103.76.113]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Rwu-0007oF-M4
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:39:50 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 384401800123; Thu, 16 Oct 2025 17:38:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=AZVyyBW9yXgsaeulA1YXhH/G5izca99gWRDYt1AsjCw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Cpuhjmku4d2ceQ80ChsagXV14Mk6eP6F4WBUSUkxcyPjjE1jpK5nZAYgmf02TwkjWzCZqEIFrtDp/wWT3xi4gTmCTIwY+4nkHinHlw5kDJ3DIuvWWASf5YCBwYscrPi0khE6HX3yl+ENrDtLGtMbSQNRiWcS+Y8KnkhPVIYBuv/270lW3uJFG7VPzf36gDBoLVtZgTGLMODazkk4YXziUOcrGuYGDFTGL0c/PupfP63Y+1wHYI+X26Ib0f+nb+LGJfHkPUUW25IjJu5JXX8PXvgKnGm0vOSLB5F0VHIv++9y1G92vYYkkzeuMmt+IDkQygYbFbZNAi/k6Yt9uvtWeg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 DFE99180013D; Thu, 16 Oct 2025 17:38:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 14/24] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Thu, 16 Oct 2025 19:37:53 +0200
Message-ID: <20251016173803.65764-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016173803.65764-1-mohamed@unpredictable.fr>
References: <20251016173803.65764-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YNK3D3ZMU2McfWiKpE9jPwVige6xlmmj
X-Proofpoint-ORIG-GUID: YNK3D3ZMU2McfWiKpE9jPwVige6xlmmj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyOCBTYWx0ZWRfX5JMq3QodC8CX
 SSCGmIQt/Hxr5M27KkGtM3tF/7dDZ/Pvd1PsMPFaXGjaiGYp+PHebGthCDfGoiHNka6IEWAfrHN
 oUe+0YzoK2JM/Oawv+bSql2ZG1m6Q1aSJamFa89nGBLDrJtGA4OixkNgmoq9UShBYunQzEVgZyn
 nljTfgGtZwK6BPYwsWfnPWLAbX2M1gRQbY7/C/rJFgIRhd0ll9RrRr4kohaGVYoQ5PWXejKmpZ0
 Xm0Ten7TGMcLyTRFZYtwRR1FPlICde4xOsmTR+V61CsjGeETxx74Qupu/hD1PjI8O4NFhYJaM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1030 suspectscore=0
 mlxscore=0 mlxlogscore=906 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160128
X-JNJ: AAAAAAABhG60gSdudW0A3koar0/yqyNUrwvEHNsUBZQR9qmiWlX5Sq+mFmWAJzl0oWQZFafEzwFjZ5clFoeTAjOsiRPp/mZdtSv7Ieqyx57u+Z4I2vaFXdCAK0REKGriY9YheXP+Qg7by5+TxNk2zhLZ2H/t7QMt4BuRcaiuI3pjRYlvIsDYsV5/E1D/KUHvkTyZi5H+uYp04id68uODP6pRoBrFVp+3XysUFyhlMlSeQAifWDPWBky//p/Xmez446o3L6uYq3YKGKGpmWX2NL4lfkAx5uZX0oUJYhs0aOlXE4z9959TD4evGoMBm7m+Bxp+yqzDzO6TIj70aORx9y8Sgm+38Dbh8Zz6RMikt1RSfeXsFDA/xNhNTyMTZJhFnkwVt+bu9WIw5kOoDX1pUU+Ky4UMJ7CbsEgT9/RqUV3MqFeTTzsHOwF3HP6IXrti4VFsGs6zoRmEZFVjOgSjR3hnMBZNMyfAKxGRdY2oGdfWJzbpxfDF+Dj8tMFcdwnkw8P3wA9WNT4JI3YtzDZNkPm1Q9FHeZf+7eZSr+ilzOa5wVVCRk1K2ihd2PjaYFEzb6b+l8wQLnfoubzipzFGYThb4WCm7fHgIHCn4T3OW2ACG8VnqwABXIEgosxUVAaFPIDR3FM3oBUFtvMSJbjQ2GqJJFNxbCCaNuT84ObhUDESCbnG4/aok2KvLbjPIFj/u5Y6Y2Eu5MdhEXTDgv/V1qzYZdX7i4HnoiV6bQFIckj8h+PfxZDAXdJeiE9KbkV6oKyN3TzEplyZp4CxqOdiY09vhCfiHKfxjTowO5TfkGixhPCXHdryNRr/gKO7oJzB16X/tZsMkcNSicDMGU2kLmzcEsoL/xQYTgV7wue9Kw8VyuPe13ZTxg0uX9sr7ouetuMIjv1n01Cp+5AOlOgw9OkkdxK/nhL6CEITR2eG9NcMdc69Q78NIVtHLMO3f2k=
Received-SPF: pass client-ip=57.103.76.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3b556f1404..bf25b3580e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "system/whpx.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1140,6 +1141,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled() || hvf_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
+    } else if (whpx_enabled()) {
+        cpu->psci_version = QEMU_PSCI_VERSION_1_3;
     }
 }
 
-- 
2.50.1 (Apple Git-155)


