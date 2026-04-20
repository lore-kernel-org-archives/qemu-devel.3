Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFDAF5580D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm6h-0007bm-NJ; Mon, 20 Apr 2026 06:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6d-0007Ll-R2
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:55 -0400
Received: from p-west3-cluster6-host7-snip4-1.eps.apple.com ([57.103.75.44]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6c-0000gd-BR
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:55 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 4AC8E1800153; Mon, 20 Apr 2026 10:43:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681833; x=1779273833;
 bh=Sw+c1/Szq2U+GFUwZJhzpKe2Oxhd+T8qz2/AUdFCjpA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=B+pp0bXZBdoi9Tun0jHDKvLCzgiRbAviydrZ0/fwZ3GFLunizE0eh8VkQL0GAcsTsJUtEcr/uOC8CfChhDiHHGz05h5qf9k89DzNYqe8PUai3cdxXtF2mLRR5HoiH/ZFhRaETmvVlnYF5NoO/120vb+oZKAEmhqpl9wh29LIMSw0i2Hhgv2OYljhSSPJvc4svrFkA/fQT0GHJDkxXOreLsKkkKNeKjk+H5kmrSrQItGZLg2N5s73fSnImFg3+b15IF8UcP/Wp1Hd2Z1cWkHeqfnsDguVZyjabE5nPw5v8qVMcQlzCOI/fPCHs8qGyrR3BTP3bDrEZ/q9TR+AgESE7A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 A2D631800EC1; Mon, 20 Apr 2026 10:43:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 23/38] whpx: i386: one more CPUID
Date: Mon, 20 Apr 2026 12:42:33 +0200
Message-ID: <20260420104248.86702-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TB9HfKJq5B6oZnLys3hsxi-hPRL35pjp
X-Proofpoint-GUID: TB9HfKJq5B6oZnLys3hsxi-hPRL35pjp
X-Authority-Info-Out: v=2.4 cv=d7D4CBjE c=1 sm=1 tr=0 ts=69e60367
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=zJD0qBlfmizEQV4F3ZsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX+vkFGbyzu0Xz
 4yweAC2jiJUJpco9tegdk2kkdrI/AZ/UzzPD7cRPvFtFnlzOYBTyYWa3PsXTfQGyFUIl+AbRRjg
 Fi4BPxaCp+qGHRfMGzt0sg5wCIOZ1SsK8yq7HlISeaYVUpylzappXHoY8jxFZBxGlA4E97fDej4
 evnXUwZutDJlzfJw9LIJ6ZRgK/zTy9W9eClUdqF8XvjB9RM8/M1WthTf1nNQnbpGQbYgPivMmcs
 ft7dskEgXn7pSLBjYboe/Oinq5hfdeX5HlYh8dEQB2LbDW+6rgQgulh64Qwag0QHKwkRzs9hHCN
 DPwZvbDqg5Uoo6g7mCAMsoZcrhs5MgO7rCJ44DTzL8j5uZBK9JCnhm+s+JUe+Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=821
 adultscore=0 clxscore=1030 suspectscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.75.44;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Trap cpuid_0xb as it has x2APIC topology information.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4dc4030d87..5c2a9bb8ad 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2527,7 +2527,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
 
-    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0x14, 0x24, 0x29, 0x1E,
+    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0xb, 0x14, 0x24, 0x29, 0x1E,
         0x40000000, 0x40000001, 0x40000010, 0x80000000, 0x80000001,
         0x80000002, 0x80000003, 0x80000004, 0x80000007, 0x80000008,
         0x8000000A, 0x80000021, 0x80000022, 0xC0000000, 0xC0000001};
-- 
2.50.1 (Apple Git-155)


