Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B79BFCB61E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXpy-00047L-Dq; Fri, 06 Mar 2026 11:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXpp-00044K-E2
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:29 -0500
Received: from p-west3-cluster3-host9-snip4-1.eps.apple.com ([57.103.72.232]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXpo-00075p-1Q
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:29 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 A1238180011B; Fri,  6 Mar 2026 16:15:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813726; x=1775405726;
 bh=IzVSt1aVpyTkgRI+sV6HgtQSQ/A0iOy/FaOFV8C9G40=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cQqhIHQfibx3xU/hymfWocKcNgX1fIOvu3fVCH7TRh9QpnpdOj1B5o+juumo3oxNfVcl5WBoyjfQ7fDT7vV7Pb/rBYUqmWPJZCEsqnDiurOvTVqQiaJcFsWT9GR7Tq+tFO6eH/vfL/U3W9CtZunU4FtBvMu3zkHSDaz7FcQ+4K85MTod+H1tVcU3TaH8OtY8abnj6MArf5bD1bi8QY+ZitJoCErk1HupTMPJ1Rw0ErZYVhu5URirFbtCy0c2VFolMXorjNRXystcz1lhlNOo8IB+aM6kUg2Tjzv3ccWlE8MCn4ROUNdrUP49iYaPzrLEQKU6T9qu4c4THvNZJLB4Mg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 E92B7180013A; Fri,  6 Mar 2026 16:15:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v16 04/17] hvf: hvf-all: stop including hvf_arm.h
Date: Fri,  6 Mar 2026 17:14:56 +0100
Message-ID: <20260306161509.79712-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306161509.79712-1-mohamed@unpredictable.fr>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rwMDNeTmymxBSJKsoiQrNXdGM0BpUgyG
X-Proofpoint-ORIG-GUID: rwMDNeTmymxBSJKsoiQrNXdGM0BpUgyG
X-Authority-Info-Out: v=2.4 cv=TZObdBQh c=1 sm=1 tr=0 ts=69aafd9e
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=uNs1HyugXjh6PdyaFdwA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfXx8qLeGzW7H2w
 LmsEnMqod2Pea+yWGtCjNrPbiJBqHBPeBpsGLxtnL547D7j1VucyJDdQPTcqX18VXM248hdw+0K
 s+k8xwSVbkHH8JtHgEglCaneNckVGnEewQpqM7XIX7CiqbmbLbmbe8PeAzZu6h/9+UPQh0qd4b7
 TVKBO+YdwP+II3SeV+wQ625pxdDpIiB7q6KL7eTKUoqmARdw5/fWa2sJrpfyiONuL40LOihzmi8
 3fUz62QJVIEhfO4YXCErHvwvm7c4ZL/AgBHZyVjKkrsKHamRVoGL8gH8u7YAFmDhR8EOdlZMq3q
 7rcTKqix8Hk98xuL5Q2gHqXD3NmabTe+caop+4eCTLsm31Huf7emTDKZOcyWK4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=660 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060154
X-JNJ: AAAAAAAB2ubFuceEpBhTfP5Qsdy3PqUfrwjSahhyCAutZ77y6O3Qq/BkctSGjpRzM9kMXTqx4+Sc2umhwMxDTqNDECeyfhC48j71JFu7lkkRZJ1p/lt6JQ6gRgIuQZTL3ZPc28Vv4fodieb7CYEnBQD+Nq0XHvxxTzHIaPw+OyTMTtsMq3I14vlZCr1ftXoTrYmsYSRvQPQC/no0q1ZUPBgB7jG4KPSD809WgcI738NZyhspTebWZyzW0ZkK0VUKw9cGml9Gt5SWoDl8lbjq9/Y2UB3FQgruBrohhh6CPiHDG1YFOwCbHoKytUNznxdrUnXr/fCW1mO8kYivcX+cwNJdE82GQDThaFqIUt6ZWKHe21ByHGC2GYuG+r2uIaPJnTHoh/cB9Ii+YAjzuec/1lk2LzxtpDyIaAIsTj4AOr7x49ZbUN3deyk7pQlIrnnrIO8ZCuVEjVEUb/Z4TuYgK0JeMoAd/99gSWntGT+flCYWad1KKLsfBzkp2ytZLXQCbUOo2TeX6gIov9fyVtW4+sMxdYp3ZIYB5JynZFN+L2aKqeAdN1McfVPyYuDxIpc8+K3IXdmaWeHx6as9P8RUdIFhygGph9Fk/QWcLRBs8Y8f40jWpAmcCB/dPPwp1eOTdkOktUREaacAPFqLPdvJM/r53rNKjXdt++RH+pYrJE5b8BrTEstwq7xM9/+3Y2SqTx3IllUou97pMG2NdmNd//BotNAcHqzE1nzBcAI5boxwSDwMxXssxNQ5KpSlcPW2UHwHtEU/zOekV+w=
Received-SPF: pass client-ip=57.103.72.232;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/hvf/hvf-all.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 033c677b6f..5f357c6d19 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -18,7 +18,6 @@
 #include "system/hvf_int.h"
 #include "hw/core/cpu.h"
 #include "hw/core/boards.h"
-#include "target/arm/hvf_arm.h"
 #include "trace.h"
 
 bool hvf_allowed;
-- 
2.50.1 (Apple Git-155)


