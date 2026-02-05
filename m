Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86CFE8B39F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0Jv-0001MC-Ft; Thu, 05 Feb 2026 09:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Jh-00016R-5m
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:46 -0500
Received: from qs-2004l-snip4-2.eps.apple.com ([57.103.84.115]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Jc-00080G-RP
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:44 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 104A11800D86; Thu,  5 Feb 2026 14:26:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301599; x=1772893599;
 bh=s1GW0hnfqvPJUBalVotB8aEtoQcY7bM3WJxM9j7OEF4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=M4pioZbtOteknIQ/ipr21hR31wS527RvrGxa5SR1mM6ueUnueiTA9hkC2oF4y5bkbOutE9yKr2va202KOvLoMRuVUn++cju8v6IrVRR6PrA6Z0taNcem3VUIlF511kEshldZwpRpeMSiJXDa2168xcbwI3Xg2Yotvq9exNfQBbPtSJU9WhKVWsfnCHQ6g9UtVr2Vv9e7+Y6Mka1altQQZEVCHNHkp4BDtgBoQJwJ99ifG/6K9aaMjyCVvJDjPWXv2vlMbKVe8OBm34oO/9fPkrDct9NvUDH5hjOva728X5RPSSbW9iW6MV2rKXOlwPvZvJl7ejU0aNWxFUWaT2hhqQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 BB1A61800273; Thu,  5 Feb 2026 14:26:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v21 16/22] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Thu,  5 Feb 2026 15:25:34 +0100
Message-ID: <20260205142543.64818-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gMSDW8VMIkxx857R75ox0zylBBW_3CuD
X-Proofpoint-ORIG-GUID: gMSDW8VMIkxx857R75ox0zylBBW_3CuD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOCBTYWx0ZWRfX+pxxjlbkcLtE
 SdG9F31AhrISiRqmReof2o8U+f8A8jZf4/IPbABklN+ISSgde8KMR9tDVg8fgMBi0wu8ids/gk/
 PauNpxON+rGl05sZC8b5KCxBwffYk7H78JTEedzlsXXfk09exOinZqfigODUNO/x2s0D2nz7213
 av+m5usoFMKEV6pPrGRZ/E8KRAoNV12YceF4z0N1DWdY5G8Uo0HuHhHBDFOvqjmnLfd+sPzSvZh
 vZlC//XXxeLWFqHfPvqbpx9d0fOC/HPPPnddPdoiIalsA4fxi6eVi6idFOSwwxnaujSnhlZrhWV
 eW0ZnsklKKbKAZE/YqVNPRbyKviErttEi6m2YoV4df8CtUrYt5mstMLRhC/kG4=
X-Authority-Info-Out: v=2.4 cv=DtBbOW/+ c=1 sm=1 tr=0 ts=6984a89d
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=emIkxkYSJqCgyAM8kcYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 clxscore=1030 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602050108
X-JNJ: AAAAAAABnZ2nwFev4tJ/LDKeVTzmnyrpuzGo6Ma+v6Bpxof6641Un+mPJ0iluF/ODpy42dDfpuN+6Kz/qnWokQv0BGrbIT38b4gOpx4QcG4U2gbf8AO4bNUdGhUU/QqVM2c35CPGBKgqZOHV2MMxY8qpX642G5xLdzzNveWiokUerervliAU3xplOwCh7dW/riZS9rDmdVrwzlZtaMmwnaHGtA1HpS+AwvqCFC8nGIefsGt/d0a/0FzpNJkreMU2iJl/DLUp8XAqZtOlmMO5Q26sQW0PKOcme3b5xswe0Gc//4ZwJ4/DNTD8/GBInYfegRCW+jrAzoM2iek4Y7n3AhbX981i8Mi6g3qsC+AMFl2rj6MK/iImxUnj2/RjC7Ge1ZJlR0uaBIRMp1ZYwySqsYubnvtMYPsrWWNkExmrUtaJVzt7UXMoRP8fgqp96Rbf4uePIfrWf6gmd+zXnntJVJONIoo7p4v7h6fZiVKSzEI3yZ9IW9eFFUucgPgjbiocEtO5DT4PohuAuqCNK528NwNC3uPA9d170eDsSAhXjv+kMUhGsvt++CEpFnZNEzbgUsg+vk4vjUQ2A9QvRRGbOl8eiCb4f2LzDn4qxoujzoEjoY0RX2luwXkToVflsgoe5lg5YVNaeCCCqEMQ0PJz9hbI2t2F3IXoDPSHaukCIZKHdYlpFiWHEBxdgsXdlIh0y8I8ClrG+5ljV8Ar0xh5GXMq0A54Nc5p+iiMcDbOSazOn13ytTm/ZWhAxnWJo0OkLQ//oU6LJqIXVKvEZiw6zUiFpHJ+363wrE43BUjk8JwjeT3jiA8UgmiunvlUtS9SY0MAtWM7+uA4FBPCGoJExhc2nwf3CxZ2WmzC/UWTLlvlfpPGaehRIOabpsDvSW43FGUPZy+iYygRunK9t1bMTUV1nC48qOarukIYRRT/Zs8kTYr9yO/fKFMFZBMG/HrVVRX1X1UU3FYfo0u2uridn6czvdUqYaV
 A
Received-SPF: pass client-ip=57.103.84.115;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c535b292d9..077f1f9a74 100644
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
@@ -1143,6 +1144,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled() || hvf_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
+    } else if (whpx_enabled()) {
+        cpu->psci_version = QEMU_PSCI_VERSION_1_3;
     }
 }
 
-- 
2.50.1 (Apple Git-155)


