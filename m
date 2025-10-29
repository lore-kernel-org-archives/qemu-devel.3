Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDD8CCF9F1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA6C-00048Y-Kg; Wed, 29 Oct 2025 13:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5l-0003k2-IL
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:15 -0400
Received: from p-east2-cluster1-host9-snip4-7.eps.apple.com ([57.103.76.110]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5N-0003Pn-Km
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:12 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 9538A182449F; Wed, 29 Oct 2025 17:35:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=4aQelUdZ9m4SoQ1tmmqgdVsoa/ORFIMr7NbmJ7jciug=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VnlrXa5pebXRkSMg9bcR5I1O9LkCMAxLL43A8tK9JHbLCZa+Xd5iTgez697eU42ZAZoB3AB0TId6HBGsfGZeAHC4YcuEexNyx+ipIkcGvIXxraEVEWuk5w0NZaQmHQYKBmegH+g1gGh+dWBp5cS7JIzpqq7Sknha5P0Ci/VZ1inQ3Y1HbXOVI6/voeUIJENjRMsIm5webD9MOmJVlBCtHRKgvxjxDO1Jcy9H6pSpx5Xqm+7KcQoJLeSWU1eBZUCaFync3AzU1B4qIc7yVUvtx5fkAlIAk0affDFJsk3IceYZSOvadPOLdwHurwJxsybCI7DsGRt2laSQQwCzmig7Bg==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 EE7F6185FF7A; Wed, 29 Oct 2025 16:55:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v10 14/28] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Wed, 29 Oct 2025 17:54:56 +0100
Message-ID: <20251029165510.45824-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XVwXTaBgHgbtaUkLZl6OJbIZYnlkjLAl
X-Proofpoint-GUID: XVwXTaBgHgbtaUkLZl6OJbIZYnlkjLAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX628+cXcFydB2
 Ph0tNUABYNqG+oH31qafm6ixXDtW7Xc2bHRAYCNjW5KoEr2BgCuogjxoP3iF+VQc4aBDCZZamgH
 pSRn2AtddkozM6HO5VvNn7KM1IFn6wlcAS97JVwSSsSnKytvBgQRxIpBqIDwFmAsYv4Q80uhE1B
 mfl5QdYsYn5RWPE5jqk1q66HcvHa7b1PBn82eV5S7NUPcgsCzx6YsL7uwFfazYWL73wQvnbXMeW
 mEUsi6XPNHxzqFbCPiQJQ0RgJGTlQemILFaAAiroXkY58sr3YlGvo7TvKRMBavX+wFbXnNOVY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 clxscore=1030 malwarescore=0
 bulkscore=0 mlxlogscore=690 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAAB9ImGYfVemxyrS+w21SXu1jD1nU/XN21WB1Ow3Mhb9uAFUQHy0femL62Rzg9W2YiXlrbbVFR8xZUR8NYQl93gV9sPL2/3SZsRUnDJjN69qwFC4cZr3+G6GjnE0ru9b3iZwxhETL78QFMFCO6MZGyNPP0OQFbqylPU2VlZJugd/saNJAZR6HWhiPfYijy33LMkOnmQQCv5vR67KyllK5M0WR8iNHAno/yfqXPr9F0p6YQeBySGbXahLaTnZ+QBSZJzKxpOcunVB8b9MCLVHg6/qbfMLOkrYsOXboH9mCnlbx89qAyc5704s55JvlSim9xoDmZDCvmkvav13KaL75oc593/3oGTaVD8QWDTfvCRlqSn5ua1Uflex7cAkTj25QkA2WCZnztwU0Q7mA41zGpKwP1gsg8e3gLUpcWjmsUxVzX+EHL05iwQn/1F5KIlmiECHsMSb+8N6lsVVpz15goqtpQYszRYJtn0vI67qOZdQ6ksbJK6wAXQzJQ0imSdhxVGjQ3DaTbiHA/8WDXXgvQViQk8Hxz8QWI+GvMvZ4Us4XbDkod60lvZE3Z3ULWvhGy8qpsZaD4Vr4uQyscRTc7Z4WDDkiLC43BqcXnpZF/wEZJQ1BC84q69B2QHP0HHx8vYZOS+D7ccElXL7yFhN2ZBwUZzooks/bI1LosyHIrV3xs99QYB8Ramsw326u280BXB4pVfk6KY08k2aAMpnaPm3g5qEREWa0ImQZY7w5U1kNcS6NQfDls6vM+XJOJepELzx7BDHBuUCArls9w63x0uR25EstvsbtJF3KOqkZrWLg==
Received-SPF: pass client-ip=57.103.76.110;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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
index d2fc17eab6..854b46f40a 100644
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


