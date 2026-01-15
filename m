Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120DBD3CC8B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB2t-0000k1-AO; Wed, 14 Jan 2026 19:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB2q-0000OC-6z
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:17:01 -0500
Received: from p-west3-cluster5-host10-snip4-6.eps.apple.com ([57.103.72.99]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB2o-00026K-6b
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:16:59 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 76FFA1800429; Thu, 15 Jan 2026 00:16:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=l9p5jVYclwL2K7rHpkywk2BNDTimX+u9/pjnya/K+yM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Vdtum5jiQPJHmZO4yyf8XQjQ70WdTcmGWWvp8MSWJPUWYFqKof9po2eXjhzmUyseRxnWYVjjDcQ1TtqctL/hLV09EVbhNsj2l2sTbc3CMeHF9RUyQ/5kMk08iSLwbqjhzbe5iX8zhG4O0YLdZV9rhpnT2pN1B+WWTNfflnFcZ/vgPJbBqozN8lFA6oyHMU5In1FCvj9B73sjSdKR0MwpRy45zY51lvX6AbQUuV04jCbjAD0K3p26Q9jsib2EpSwmnUbNqSKiGmyWFwHd8eBaod+VbrpC0rxr1+9MdDj75cnMUGlm5kRM3Ebv7Mv7BYTdHlW5bZmxH/LgT1gwetNjLA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 6350C1800447; Thu, 15 Jan 2026 00:16:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v15 17/26] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Thu, 15 Jan 2026 01:14:56 +0100
Message-ID: <20260115001505.57237-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7uLCjEdlW-tQ8j1jMdLrdQlRiLP4gdz-
X-Proofpoint-GUID: 7uLCjEdlW-tQ8j1jMdLrdQlRiLP4gdz-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfX2b60yp6BuQfQ
 LvuvIJZCmyNeIMa/b+UnFcqcmBdOqkSdLD0jnCXd3j414VPdWkkknr9UL8zWtzSot1occj1f74Q
 rwxFBlYQDwJFLGYzvL9neCmIOfuisGsT+88HgWJEEaN/gkfI9nUL96AAs/mYUatFiO1kp+4Arwu
 ttMceKShsyCycCh840yEA5+s5Kl8DkNfTL9LSrfWz+iAR2b0EU1kW+2U5M9KP6oyngKtbkZjovQ
 fNZj+XRzQP7OiVxI2v3oH4btQs1m3gZyCDUnbiGZvMpB9AImyZfd785tBbp02/brB6/rst/dVT9
 KbDu65Xqv1Q/7EloQjs
X-Authority-Info: v=2.4 cv=RvvI7SmK c=1 sm=1 tr=0 ts=696831f9
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=GfoCO2L6IEBdUbzNuv4A:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxlogscore=944 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601150000
X-JNJ: AAAAAAAB6N2uYWQ/UUcJLKRGI9fKiDtdCHmYA7UGUnfcOHUZlRV38/iKUcbYonRJ03ans5BhMGb9FW+EXDPDCYNlZRYR8Jp6wOWTbpipHVQMnNahMxH2J2Vu8avlWwDo+TKAi+IbcXpwXgMHQqhWpTz9QZRwWTEI5+/lNDOuWZQONL2Fs6CeXlOemOeYrL6wDx0vHWFUPPC8vtrklBnRMNSbGsfScJgoRTKR88+eYB0XoGZNKtp3D6U+41gkRr6ZB0+EIeyedos4vC/UXBFIMyS/m6NwpOnQDkTy942vEkVL4FFzHrWlm/1FWDLmcCMcY6EhKMNN9nhZyF3ebW0mMY4GKFsEvZPzPVja0G9aXk4rTLXDH2UsF5mt5hcy2kjeMxOrk8gokxx6bMrOn0HD/3EAb7XDNkKpmrqm47gJoxdkXZvioPPH6Clp6CkJ4mdt1tdE/0fHeJbEX7v0lieTjmAAPs30zrqS99ZswBm9PFr4O/3bgCPy3gqPys8A5g3xyzNmkPvl8CILV7FHhSYzvsAHXjX+F9mpzAoA4rmmw945iAKjhJJpnphZN7NCMVs0AWsq8C6sB1UxRWIYMdj8eVKBZwpvmWgeFLLSiZBF3ledyzq3nxDye2L3uduYJv7F6jbyCooZI5iDSoBtDGiBFWhAVv5MeqhMuy8qQEXoX3/3BnhjsEVbi+WdmQptcuAMycTp60orAfBqlaT3lp6OCRM/ODz2QzXIPtKCBtYUP3vxmFcuQkEemq5j7aUT6AX8GGKbuGxuIMhemtD8jYx2yZrQfP/any1+CvuEVCPsQ/Y/F9o1cROgU7+RBpROFDeWotSupfofK5dMCrMigTgIkkZ0ovugyker+UGEYnVxUxeFTsEUQejOMxeYqUXuuwGJgHAkF0U2p0UJV0tl7nLqn67obMPklXfpqH9XmJ74eLLwMAgyKsdTBcex83xfei0viGcvANXj9gRHKQ4VvTJcknpbTG4ORQA
 Lp+IH7flQ5g==
Received-SPF: pass client-ip=57.103.72.99;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


