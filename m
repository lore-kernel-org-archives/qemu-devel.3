Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622BFCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6E94-0004nN-6z; Tue, 07 Oct 2025 16:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6E93-0004n5-3S
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:18:49 -0400
Received: from p-east2-cluster4-host6-snip4-4.eps.apple.com ([57.103.78.205]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6E91-0007Nx-Cg
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:18:48 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 7419C1800648; Tue,  7 Oct 2025 20:18:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=J8OhuCjv+2oy4nktuLDKnA5ap+1pgvyd7eCHpQ6L08c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LJjHiIbGK1RS3eCgg9d78IW3rgoJ9+pQVMJDbTL7quKzEIsgmugzjzbLjiaamx7dKXj49fSW3Cgiie74ux4SqE2PTgThp9oFuuqltOmM0M8fs/kJCrKAe/X4lojyCwsnWlrJHn5LiOe5HMbuIMZv4fpS5KzwSQ8wqqfryBuwUYSYON3o2H8hL8vUkJUef1K+PuqDo4lvk+cK4oipsywRJBss9jQTU5GuAYqZamJSDVs6e+QE6jKsOG2toBUBIjBYHYHnxoM/Dfr7WP/p7nW/naISnjzbn4hA/4WrTIFe8qj0Kmr6GCJUlUHQ93wa+tl8+Rns6JA8ns/BUw7tdVo06g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 F3EA41800167; Tue,  7 Oct 2025 20:18:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC 1/4] hw: vmapple: include missing headers
Date: Tue,  7 Oct 2025 22:18:34 +0200
Message-ID: <20251007201837.28992-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251007201837.28992-1-mohamed@unpredictable.fr>
References: <20251007201837.28992-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: t196mkgq5HBnmgvjlWp7hGIllFPZz1TH
X-Proofpoint-GUID: t196mkgq5HBnmgvjlWp7hGIllFPZz1TH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE1OSBTYWx0ZWRfX8dSzDUtr5OV3
 keAKX/1BR9Gve1Izv7op/MyFHVnFpz1zP1oQpwpfFn05RNgq5JUcS0tKfW9Grz04KOaij+IQnoW
 wZX5OHVkXN82LWE0GNtIDjFJnu62FnQp01m70KR3Cirtx2UX+f91vTqKXMeBtq11AiuBfNNrqYv
 ueDeSuT8fOzWwzlwEVuZ0XqCdCiXMUw/IC25sh+hjQd+1jcJufTfM8jEHH5zsnqs3rflU2fUbrm
 Kr/nScAFxOzs8P/tx5QTZslzTVsuqZnxc4n9eBgwMIoWqRmnxrYYKY1px0rPToVYMgvAN2T5A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 clxscore=1030 bulkscore=0 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510070159
Received-SPF: pass client-ip=57.103.78.205;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Disablement by default led to:

../hw/vmapple/vmapple.c:276:39: error: use of undeclared identifier 'GTIMER_VIRT'
  276 |         qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
      |                                       ^
../hw/vmapple/vmapple.c:479:54: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_HVC'
  479 |         object_property_set_int(cpu, "psci-conduit", QEMU_PSCI_CONDUIT_HVC,
      |                                                      ^
../hw/vmapple/vmapple.c:556:13: error: call to undeclared function 'arm_build_mp_affinity'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  556 |             arm_build_mp_affinity(n, GICV3_TARGETLIST_BITS);
      |             ^
3 errors generated.

pretty quickly.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/vmapple/vmapple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 16e6110b68..5928df4411 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -51,6 +51,8 @@
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/system.h"
+#include "gtimer.h"
+#include "cpu.h"
 
 struct VMAppleMachineState {
     MachineState parent;
-- 
2.50.1 (Apple Git-155)


