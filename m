Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EC9EC1EB5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzAg-0008Jx-NR; Thu, 05 Feb 2026 08:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzAf-0008Gh-E4
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:13:21 -0500
Received: from p-west2-cluster3-host2-snip4-3.eps.apple.com ([57.103.69.116]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzAc-0001fS-Pm
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:13:21 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 2F95118001C1; Thu,  5 Feb 2026 13:13:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297197; x=1772889197;
 bh=s1GW0hnfqvPJUBalVotB8aEtoQcY7bM3WJxM9j7OEF4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Bjf6LX5ZBiieZ9Uq8HKBzIfnkw9hDyf7iErVklChqQA9YGNFJ58tKQ7gnyqS/mFhBMD4x7P0DMxU+QoKMs0DVs8AJCm8PHHhUAp0U0aRcwRlwbWd4+1kLzetRsvvejjCsTvLuQy4QlHj80ywSnZTtACvz0WKGmafmNAgbcLgV8eSFyauw2Y7G2NfGPeE1L9UUWpoD8GnKCM5oS3w8qFoMboGvWxs85tvnKTI9eTD37SpRR/PmxichAtmEFhGLE3VJxBsRvPL2dptizlkJ51FVYShV0xsGPYhTmEKo+HwAiI/9YHxmKxtfwoQZ4JB5gpDGOw9Zc6BhkT2OANmpGOcvw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 96CDA18013AD; Thu,  5 Feb 2026 13:13:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v20 16/22] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Thu,  5 Feb 2026 14:11:45 +0100
Message-ID: <20260205131155.22780-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=6984976d
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=emIkxkYSJqCgyAM8kcYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: G7iOS0h8Vi4CawVlX8iBNxJDZVHMB_JM
X-Proofpoint-GUID: G7iOS0h8Vi4CawVlX8iBNxJDZVHMB_JM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX1anKua8IhIAl
 428l9+FpCi8sO3rahZFBLls692HGH0TfPhyKA/NK7BwaLApszK0Lx3HVQmEw2uYZjcDR53PFTip
 B7NBKkFl9UhQhug21dNi/GOaBa9L4mSQQoR9WcDoUvQ9J4Vw36uPuYJv1Wu7LCF6y5o2zGAXkXX
 Bvzwp7OXFlyalVZx/zG1v/lPzUOxkpJDq5qjV+Hk8gAxqpkv69N0d50PhYcJ2gwzVtu39Ci7MwT
 jNt8ya1ZcN0xGFB48Qelez2clS2GzpZgIYbqwxIpueU0dHiVLoFMhy+PFyg9lH/HhuD5Tb2Z7qR
 +NGm0VIsrPzE0YaEZkK5bC9k9WHbMRyANBieqiv1MYmTOyiVUNwIvT7YVCVuzM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 clxscore=1030 spamscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050098
X-JNJ: AAAAAAABv4xlfWie0Qm2ySmND0p2SzU2S73GQD3IHFtdPCAkj3/doZraEi9APyDDNfeZk5BCGc2BxZ31QfJd49toDNYx/uf4HwuXONSNXAwMvW1BtjTeS0ugeFq4ikbMwPJX6fQfwj7aCIIqamBh6MF/fyd+1GsJapytmi4WepaWtQIAjmcKQFlVeUG+NH+37m/HZHoKL/74VoaQSDKz6OK4a7+smPAXgmOWR/1qjuDWuw9DIcJ2gYBFPuSZAiHKGJOPAkC2IoMjQw9QVO5gfwFE5D7LHXYYSba+mpzj59UgR4Y/8gu9S+MQ23+BLuZHChwr9K8Et+aapiCh5op62C8GgjJmmCRSX/X0b60BubgCGG18yafaZ93mjGn06Dtjd9dIpTwxxRVOuNhER1WnKIZNgAokFFEkh7pa7EDK+fm9V0VA9DW0GRmATlrKXVq6o4EXi7qduKlLhIERtE0utmC8tBHhuBOPTsJCflA9Ey0Rrtg8Yj8wmNLMjmv6JR0EZOS5ZW0hpTi4bs5POjFdWGDO4jtsK6h0Bsq0Z/dX0BqNKMwkFC1wkbS3kgtFDnpxePNubSLadc+ZqBB0y+7GWbY+TiPCvTSp5liFBC+mBgwiRkFaUqXl8eKEYn6dXXP2whCwvAZ0ssuWoRhvsx0GMOPh5txDxSG2G+WShTJztfzzlxu6lC9qBhLR2EhqxgBZ65yfr436sIJVKz4r4eGl1B8mC0Wv1B83MSPDNz7TpIl/GnPinOT25YEW7TrrhDcLRt8EpcVhondKYEpcifH+QofC6IWVzb4m8ARCRe0Svyv0aSR5LbASrTpI7OR2d6BN7jfm0CPbCFqbVpXtIfIMu50B0eCBwDsDdaM8L1UEkfL+zMnmCvzhNsUyK/qcrbIxS5ui2x8hLb3iVs4uhQyeWKJ7ijWBtFTW7mCMwY4ZeTSJ1u6Omon47Dd5HnAsZ39JChZHcvsjqwuvLjYNtsr4/4Z6LHfnWIm
 8
Received-SPF: pass client-ip=57.103.69.116;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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


