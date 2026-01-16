Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90946C79FBE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkHJ-0004h8-JD; Fri, 16 Jan 2026 08:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGZ-0003Sy-LR
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:36 -0500
Received: from ci-2004k-snip4-11.eps.apple.com ([57.103.89.113]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGV-0002Fq-33
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:28 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 01C3E180F914; Fri, 16 Jan 2026 13:53:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=wKVePVvWDgW0hRHNH/Kje+Z2OVAlIW4rCnZoh1gdDUc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KolvY+QSqg+mYQklwG+f+XpdAcqtULzbTO2QgAsI7nLLxRvHtJ7RIPvkFVm3Zgh5BDlalfE6K0dEMDCYsNCA4g1nqas6jBFpGbwCWVfnctB/GuJPiokOG3h1szx2jzdtrekEgxqxHN3N6omy5r7NLvXO5seIwzImAuCVtPgEZCTqpmppHSEQujL5dNaxY8rROBQ1qmK+zVHeiUFYTS8cPeq73+fTCQ0IzXGOPv8wZ6vxcTiks+c04T0CM0hKy9dkXM5ZnpOXFiOVp1kkdN9PgVSGWYchMvY/xQ3HioYUGLaSuAZmJ9itHtYa3dEKyMl5LhdEbJPcMttjBZ1+ele6Ww==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 316E3180F909; Fri, 16 Jan 2026 13:53:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 17/26] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Fri, 16 Jan 2026 14:52:26 +0100
Message-ID: <20260116135235.38092-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eQfJHBnYPLo5gpXieNQdXxf9tA9k_ojf
X-Authority-Info: v=2.4 cv=VLvQXtPX c=1 sm=1 tr=0 ts=696a42d3
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=GfoCO2L6IEBdUbzNuv4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: eQfJHBnYPLo5gpXieNQdXxf9tA9k_ojf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX4wTJy7kptKXP
 1AFyloMqb+Xqms2PTcR3CayOe07Em3kChjHYVr2MPFJwMsx1tlVKWe8phefgjYl41WjDSX3JcSB
 vZ+79Mi87QBo6ET60zy0iilBszuayJ1VHRgchLl59qlYsjTYSGG2uwnJMwQs1TIWcGKhP25rHoq
 w8ciNQQjLCURQ6HZ7ul1yQPvl0fTinL1yl2wAemBidcZ09qHr/ssjQPe9NkcmqXa2alEow0Fir5
 16BBpWlbleR6zQw+0xcvfB1/HLWCJKbZy2FqZTfHIkKlMeJbklTjk7AKgtIYhXNCb2quq2k5I7y
 j+ClzWNgNq3duXBeJDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxscore=0
 clxscore=1030 mlxlogscore=833 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABvHsnH4wEqw+ytKt2orghkzDjZ227L0UKUJqdRG0n/g/A2J39/MyAIfBPID4mClTQiTcSGmimgU18dZWOjA2JMYX1bF1lr1K9NjiNIMC73j0vNUVp6DEIkzPTy29JFZTy3h4aTK6INpp8yevJjKmeJvh9p908aoiTLM/iW0+ac/NcsIZs3tVhO7Blhp8+y1oI+Epk9F9cM44XVrhhFK9+pFwpKLnCKfsOiEkadLssmHEqEpqaXUg8Jg4sZC2OJ6xSMSRgNdjx2uKTkJQFZhIkoI07La9bNYiPdysIsD6ulGxZ+zu8DGbpBhxzCBFhxaZdWZ7R+DCncHtqK/aedYolUU/e5rH4Ae2Lo6hHPFl/N6u6Dp1my9fJHbrLkp9tmyF9PhAFz/oKGTy8wNYcEO1KfJCJCHp9VimyU8Nl4pdKAK0K6VrEZ4/dTGDGIp41lPGgA9JdguIY/yZL1j/qW7NlBMew16t88tWrOeaa0QFn2IcoJdInK4K4LiaC+Icwqov98+j8y5cFMHTxlmNJI/P5x/XXSqdfvR+gukzrFuan/VSEbGi2K1gNthVT5HoAns0ilcSbaCvPTLm32P3BqpP6okqry2A2/MvDCGiY9j6ut6mxwM2Bplfp0AjZtGUOptM/qmfGiEZYh8hpNu2eeKBr2u4AWlLS4f1xd+I2JBv5M5wE6csj7RpQxIQJ7UAbLoHOhv5K9awMTk3FfMs45i2ZsAMAVopLTsaE/DeMEgtE6RurKAKcau0J8Zd2YIS+w/qtNhPKKkxgTRNRBtcfi3jDMKGgvSZAgJHg556Ywb4QTyBNxRVaHEaIvgerewY792WQlxrYx3P698QBgw==
Received-SPF: pass client-ip=57.103.89.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 05fa3339b1..fd1e3197ad 100644
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


