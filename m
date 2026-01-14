Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860F2D37E39
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg19Q-00019I-I1; Wed, 14 Jan 2026 08:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19O-0000z4-Jx
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:06 -0500
Received: from p-east2-cluster5-host7-snip4-10.eps.apple.com ([57.103.79.33]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19M-00088J-I4
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:06 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 C18991800749; Wed, 14 Jan 2026 13:42:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=l9p5jVYclwL2K7rHpkywk2BNDTimX+u9/pjnya/K+yM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Oxv03jkcf0YQ/8v0x4T858KLX6jau2XAIzW8ary74Ek53XyTdX6aSQ8kHYdOZYdFRef+ELWh57scAqltMRga9y9p81MW0D240aC000YhnIsOapC774LGRTdU31Z//N28IhF15+zvfq3+JnRQQH/KJcKQLINQGQ6deNh/sTnyQvva9GY2cRphf7ZolFRB/kjeKFwRM3DPmGFs5/YKlDekvo7VaBZgtuf74Q/mGrAVNjncYArMFZoqa6bdtn6gxnflejRh/S20Tn+RPtqX4K1mnMf2OcpZ60ZpmFP7HJH4UwgNMNVNFRjMEC8zOq88UZRRKZuNwmj8RsaINXI7y5jQQw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 87EBF18004A5; Wed, 14 Jan 2026 13:42:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 17/26] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Wed, 14 Jan 2026 14:41:34 +0100
Message-ID: <20260114134143.26198-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MEwFPDvbD-49v0SQW7Lo8ki19Xwr8Eje
X-Authority-Info: v=2.4 cv=RI++3oi+ c=1 sm=1 tr=0 ts=69679d65
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=GfoCO2L6IEBdUbzNuv4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MEwFPDvbD-49v0SQW7Lo8ki19Xwr8Eje
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX0OXzZWq2PrLA
 xARuD1KzZD9a+aP9he/ZjsiSkb6HGKJmqb8FmQlftlmrgbAvAU/+SbUTIh0OrhpzU2JjvCrhf1E
 VOqzs6hpbgT5Nf+fSff5vVGXGeQTTgHmYz/2eBu7NvkQJyUq8onwOPY5Cgtit20fiCyRFtSG4o6
 ZxKX+0XF6l8N6J3bT/0vLcVWtf7g106sVJMWFgFMuU5wz2bRiMTOHO3tcKTRNNaQhgZPzN14+yG
 7IgXGjRaTEeJuIFq0o9Z9BLwPFBS/8IMdMCeL9dkz274Q8KdRNj8HGUZ6CWHZkgYkYMKh26932w
 INioSOgtvhxC5OwFjLX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=944 malwarescore=0 clxscore=1030 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAAB5XELhFFnPYHUkSUEg9gLI9d/cZQwW5FCD7fJ3N0AMFmM4lOnL/lNrjQj1StracZj9jDddGmROMORNywRv6SWWWKX4Db6wR4xXMOQLErCv2J/WbJt6g2yu9sJaJuwa7heCSDfJUAv+87TckL8BnEOTKKrjyJszW7LzK/wOGGat5ZDdu3X4QZGGH92ZCTt1eCCAIuwT0SSV7w62Ma5vB3AcfwgKR+l0vhElyWiR2hS2/1l+NDn/P2QZFLeeS6UZDSPzroqtHxfjDQHQlC4tqYoVSDgkJLAT6vpaDW3yh6A/5FuLImCTYUxSPuIQyMZzVKTynXf0Xe6HlPzqKtI73WjZj4wiSIX+lOvUPl93EK3rXUJIo4VM5/u2G8LtTMtk+s78MHwiUo1oHCaHP1sxsF9fOIqSBzuf+igFGEA+VoLc5YYHO51m0HyMOvEjv6m7gHdFGXoFTxuhXV2K2s9Q/mvTZJLidXt1zybIE9XY97L5nfm5jwQWrECTp6wcOR3kz9TyuLfGbhRVHruCiQ+sCMkMjRTzPqsgXd0IPli/RO5W7H9Y52mkT60Jw2Tg/GYxT4+KBujoSQFd0LDHK3VzRr1H1GtrMhrCerGWY4owg+zHwB/iFDkH2ISZFIVS8PgMu7fOZtsRuyedPZgGFf/CqYnz6aLP8TbpmDtzb9qGGO/l3OF+dUZ8fBQKjln6hS0QS7MVOoXCDDC3ZQWDVHnVNkw2D3qgEZIy5Mh9ezE8uRbZ4jd7cs0EZXRjIzwxdY+AES390bGPwuz5BWvFrkU80Vb2aUXz62HovbJw3Nqr8PH8dwlFotQ9L5dXxHfVADQcjItTBA9I8Iwvw6QMuKKz0I1B0U6QiDYB23rLkR/msPHXcEGnydWnKTpS1O4DSD0AJc9XzXpO11t4aPxiZtI6EXpblefoa3k+Sko0WgnX+Bj5lRLolta9HFYzp5bQGOBZOedCZbb
Received-SPF: pass client-ip=57.103.79.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index caf7980b1f..70f0bebd19 100644
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


