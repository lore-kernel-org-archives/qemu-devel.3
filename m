Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC1FC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 05:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhLrT-0001pJ-Nv; Thu, 31 Jul 2025 01:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhLpv-0007gG-Ea
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 01:28:15 -0400
Received: from p-east3-cluster2-host5-snip4-10.eps.apple.com ([57.103.87.181]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhLpt-0005oU-Ma
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 01:28:15 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 DB026180018E; Thu, 31 Jul 2025 05:28:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=GKg3FYipdydvcj3OMrgW1X0DtxoFeKJoZZ4r3zuTG3k=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=WhDrf6xkfZPa3pqcXumg/0qSucXfQUXO9f+FyML61SA/2mARDTFNcbpI6ubd/yzIi9SNaOURdw1DyySRbm9UNXxb04MAtPxy8kXHQxh17kFJeLmMqJt+kGeGNNmAIu4c2g0C14d/aeu95sT+9sLUhKc33AdxKv6EgsfPU6dtApp4JXdhOKCCm+b5sTh6cqRrihoK3wo6idibeoM5yKBI+URks8UCzfVWboxcP8EJ6s3EjAkTThlPB+Vz/gGRECsHelUl788ltLYDu18DwSQpsCz0V3XrXzv2mDD7px+RdLdOD4Zm4vHJ0z7t+jOxJ2X02O8V+cGganiFzUNhJW1QQA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 C6E42180011E; Thu, 31 Jul 2025 05:28:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC 9/9] target/arm: cpu: mark WHPX as supporting PSCI 1.1
Date: Thu, 31 Jul 2025 07:27:53 +0200
Message-Id: <20250731052753.93255-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250731052753.93255-1-mohamed@unpredictable.fr>
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAzNSBTYWx0ZWRfX4+CHG4CxqPxb
 +sCAJm6CxUuBQEkX74izGCtWliEporQCHDpBhRyLyeIfoZOIHgR/tBy6ROTZ5Wylc++G/2RRfeG
 ERg6GSibYOCQtMiMTKX61DF+4v1CAV08TNr1QfeyEWY1yiCdVw69mzD3wziIxA6L7oW6Lp2+Ori
 bXSBiNut2Cuu0juTMA+PDMU7n+cmKshhMIcBlzlUJhLFnwujKSHg6Czhgz6qCJaMHNNbmRSrPkj
 w+0bmE84hsmkrHiYLkoGc/RB6j3U95uVkGk2MAlsA2k4xIke1yCvyoT11LxGz0Fs8LcSKkf60=
X-Proofpoint-ORIG-GUID: HZRh3hX0AmoQwMTIm_XEuhix1h5bjqhY
X-Proofpoint-GUID: HZRh3hX0AmoQwMTIm_XEuhix1h5bjqhY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=752 clxscore=1030 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507310035
Received-SPF: pass client-ip=57.103.87.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e2b2337399..3b69c9786a 100644
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
@@ -1496,7 +1497,7 @@ static void arm_cpu_initfn(Object *obj)
     cpu->psci_version = QEMU_PSCI_VERSION_0_1; /* By default assume PSCI v0.1 */
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
 
-    if (tcg_enabled() || hvf_enabled()) {
+    if (tcg_enabled() || hvf_enabled() || whpx_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
     }
-- 
2.39.5 (Apple Git-154)


