Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1B7E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0e2-0007s1-G9; Sun, 28 Dec 2025 18:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0dm-0006rJ-J0
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:57:39 -0500
Received: from p-west1-cluster1-host8-snip4-7.eps.apple.com ([57.103.64.40]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0dl-0007KO-2i
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:57:38 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 09B5C1800758; Sun, 28 Dec 2025 23:57:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=l9p5jVYclwL2K7rHpkywk2BNDTimX+u9/pjnya/K+yM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=SSYXRLwF4XP5DxIuNHbG6I5tdeE1dafeRf/G9JPbtz8BdOS/Iq0xnW5zBNouK40s9Go45+lDtt5PQiHfSeOKvuYTqZeHYgHcA82RWa1kLAqOf0+9sE+czZtmOkXqiTvPngcNrxUeayKSfp4hmcY5HjiUmw7j0SL8hTsbJsWxPXilf0Xwf3+GjGLDXo8zGQz1Qi1YZ/MyJzpjRF+qGNt/UxVAwTwAah8PmDr/abLFLfqJSpEktpH+c1UjYoyEqe/2EFWswJNIzmtVXTw00vPn0cuOPH+tLzGaR7z3+nCImoLLvhVPYNaJoedjja+ubQilcXOPwfaxA0Oh+1++2xmt2Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 43CEB1800760; Sun, 28 Dec 2025 23:57:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v12 18/28] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Mon, 29 Dec 2025 00:54:12 +0100
Message-ID: <20251228235422.30383-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BwVHizWFnWm1VBM6R3KOhjgWWI0doPd6
X-Proofpoint-ORIG-GUID: BwVHizWFnWm1VBM6R3KOhjgWWI0doPd6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfX0QvK3/9Hlz7w
 VcahPj0JP/ojrRJv30SdUwCiMmEjggezIRk3HU1MIMy4+EQ+KaaUFn1eqq18SIV3/GBbdttsL9Y
 GEqzzRxA7KLyjWNZCdvRaac6/GN34wG+nccWfiFaiQ3ZpwLqAnD4N1H7ucIIkmP+jZVR2vdJF4j
 PNoiz/9tIUEjbomeyKGhpZaZHMU303NyYSyAbYdGl8nEAU70/yfgEFjmNHGBxN6Lv441iUl1sVu
 65Ex5gZj5AA6A8LJgL67OUqMPE4Piy+HQ72W59J2yVgwdACeAjbV44xJJ5uQWC4dzq+1TI1YQbs
 mxNQt7pywSJAU/AcVV/
X-Authority-Info: v=2.4 cv=JNo2csKb c=1 sm=1 tr=0 ts=6951c3ef cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=GfoCO2L6IEBdUbzNuv4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=836 adultscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAABxRQk+tUnd2d70/KUJLWB6ghqRJjyYrYIG/5aI6Wn6o5UHJeuXqWp24GiIgDPWMweAYmKzHTBBG+dPtnarlFFBjF22S0oyjYlZajywsFywUPLxO3yxUxjj/RoGrfNQgoKUlf5I0UC56+nDQSZ1u+E1nu4q6EaV1p7+qpWxoimNqmjEipBuf0svZ8KRBpSPTsSmII+d/YjArsHzsXSeww+rQApXChBpTNjHvI2BRo2hi86sCcmahvC78CkF1/31j+j8Z6JU07E4BkgGAFHz+fYAXCWG8JANGuE2/2atsY1YMNQaAvmSEPyw/7tp6pAUPZLpO5JY1puDDydctMs79xzXMzlGYW/Rqa+B6uwihjOlSnzH4hi8OmM8TSxqQnlqozIbKv4jxt/eB/DmsOpvGN58fnoSfsRdBR9jxcAKxLJ7Slv2DplCT+zR1j5bBxfq3NpPy5YFvqbvtrdwm9auTsU580JbPmLB/Er+qmAZpKG7H9BrPvy7N5Zwdr9ut8QPkw7EAJw4z0200Ru0g9A7z5PHCIzk8kooL/tffdQSzcb9H9lFPUfXiAqP8saeN5bXuSJzLu8Ho+7+wjbCE4+yWeDrzp9qwed9+jdC2fkKZjW48AQRXPY6um+xTcB18YRmBQWcxell9n0M0vDKmStczDANkHW6wEZKxnfD7q3d0E0FKQTth7PZw5w/J9vFmSArtpGOkDpSVBHF3GcPmQ+r7BoTaj1kivdf9fzepcMB6n4ChKmWEq3m49w7QfGArYheLVuaO5SfVZSf378Ty/y7AshqW431UUjAP07Sasbvxe2N5O5RSN5npvXWE5gpjuyrH62l1WaJJ22ENtg4V5nJO2NaH+QyblSVbS+ejxkjOCnlt3je6CCI1l9rzAMe/8b0BXDG/Ac4VS4XiqF5pVPpfQea31def9csNA6yFj+u7M8919vpqDKMm71uW2BXtWANjRjRS8ZRtUl91yUtXM6IW/wLth
 yWz2EZqul/V2U5YVD8fG6
Received-SPF: pass client-ip=57.103.64.40;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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


