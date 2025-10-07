Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059B4CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ELu-0001Fg-HI; Tue, 07 Oct 2025 16:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6ELs-0001Eo-DC
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:32:04 -0400
Received: from npq-east2-cluster1-host5-snip4-1.eps.apple.com ([57.103.77.84]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6ELq-00019u-Ng
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:32:04 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 F3FEF1801714; Tue,  7 Oct 2025 20:31:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=J8OhuCjv+2oy4nktuLDKnA5ap+1pgvyd7eCHpQ6L08c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RPaG4cUFjo/ASTpsA67kHPhmHSwgqOiqI1ZsrEyvbhSh12DAtCUyGydeWQB3H+datKhuvRsEDX3AcoM9T55iKffWDFoaLELSAnOs0UyjmfgRQDcKUagVo+NCoth16V0QmiWLdDcAufajufb06gFPPXjyBtyB03yYRHwyHaC9OcwQsADHc+MDa6yASvF6I7cr4Rs6jfcEHHxm+Fl0wuVbcM5bqkjfkcjoxNZsxoMww/+U1mO9u9FC8XJNzQxuXvJ87m0zwpqp/lHjryZG7xM3uu76WueIT/HqTew1OHmUhU9F0slenatin2gBRk5dlXz29XN5kcoWuEeNNv7lr0vzzg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 E64C2180016A; Tue,  7 Oct 2025 20:31:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC v2 1/4] hw: vmapple: include missing headers
Date: Tue,  7 Oct 2025 22:31:50 +0200
Message-ID: <20251007203153.30136-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251007203153.30136-1-mohamed@unpredictable.fr>
References: <20251007203153.30136-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE1OSBTYWx0ZWRfX5G5/h04z7jWU
 XfBGXLWryoXDY/diA6roWsmGihtJH33ZwkJsnQxWng9lr4GAVo0U2+lm7ar1zPWpki+lH//PrUc
 J3vmuxk8H+nn+vwpTGASmdwjG4WelZKgDWtyUnYeVjJg3gTzJEkUwGcqV7Dm0PuK08ufy4Oni7N
 NESv5Abk7ztvB1IgnFM4NxM2kb+nf/PC7evMu4IAdFSQbmS+f9pap74clwVz6D9PCuwtqTZIB/B
 7D4tBdKGGaEXodzm35IbuLgMzxnGvtZRlhJ9kO1AdsbfV39/uFinCZO7hfJxZQOElRqETvWsU=
X-Proofpoint-ORIG-GUID: e8RpWn3S0oOR-TMGdFS5nSXneFLuSYYD
X-Proofpoint-GUID: e8RpWn3S0oOR-TMGdFS5nSXneFLuSYYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1030 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510070159
Received-SPF: pass client-ip=57.103.77.84;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


