Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681E4FEC118
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w58h8-0000wV-RZ; Tue, 24 Mar 2026 16:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58h0-0000qS-0j
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:39 -0400
Received: from p-west2-cluster5-host3-snip4-10.eps.apple.com ([57.103.71.93]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58gv-0004f6-6F
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:35 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPS id
 5B12F1800477; Tue, 24 Mar 2026 20:49:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774385372; x=1776977372;
 bh=nm6wNACUc6oJfXfhk2HnxauS/oa1dPEthQQE43aZl7o=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=eCWV0XB+EItLd6eFJ1j1VJ3WfArualCmA4SEGZH/qoVKLs/NKMAlUJkNCq/0pqKnX3YgcohspE9yRDq8KSVdgxnA9HjAM70MuynKW6YTv1INN6JJ6QdMnp9SFWqUdKPT1KP+27j1l/VFlb1aHx5bPwnSOcmO+5QRXBXBFSsZaLm/ojOFbQ/aNVsJD15aoYvz95en6d5Nx69hDK7VwwdqEtv//6Mf3wQF2jw9H0g4JOiPfM7IM+wsEUjwZabxxUVj+eGt4KG5CXJDXH7J4H2y9tAviDyt/LH67nKIqrQJKKTRLNfpXMuIwj3FpPI9GW6P/Xdm3LEnAizoVSZc13XRjg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPSA id
 C109C18000A6; Tue, 24 Mar 2026 20:49:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC PATCH v7 3/7] vmapple: declare it as an AArch64-compatible
 machine
Date: Tue, 24 Mar 2026 21:48:51 +0100
Message-ID: <20260324204855.29759-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324204855.29759-1-mohamed@unpredictable.fr>
References: <20260324204855.29759-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FBQT9ZHTJr76LgLkspfcXGFi5XQu-PXB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2MSBTYWx0ZWRfXxztmnqdwDQnJ
 i+7QCGe8A2iITisYsdy5YiTrlVzIAL1IZjJUbm6UPBIB29HKm78aRo0Fp2laytAEJ5u8ayZOtdx
 X8Uao3lbWql1P+eX+oQpFLGUKrKgVnKyNyvpBpU0U6wYjR0dhkOUer9qCijsYBiNq7+LoPn98Sa
 j1h2nR6fDU0dFREkPyQqmxtU88rb2x6Y+/wl32FIDsfyrOkX96Ti4VEzTAl6/Tzpq+oRdz3z6Vg
 SqHgzp/YxXkA1961jAiZQlc22+roWLVMlzI4c6SIr5/OktItOG94u6NQ6mdDYdjoKS3ncrf9gRi
 Wbo22ryT3ykbVbVVrQkUcg1fj9RN7k/zA+zeXfmvpQFczcB8DseNDDdaZpAH/k=
X-Proofpoint-GUID: FBQT9ZHTJr76LgLkspfcXGFi5XQu-PXB
X-Authority-Info-Out: v=2.4 cv=A8th/qWG c=1 sm=1 tr=0 ts=69c2f8da
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bL7GquhI8jtPFrN7dBAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=872
 phishscore=0 clxscore=1030 spamscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240161
Received-SPF: pass client-ip=57.103.71.93;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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

.interfaces = aarch64_machine_interfaces is expected for
AArch64 machines now. Consider vmapple as an AArch64-only
machine

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/vmapple/vmapple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index b1379eafef..48d1ebc7d1 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -32,6 +32,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/usb/usb.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/arm/primecell.h"
 #include "hw/char/pl011.h"
 #include "hw/intc/arm_gic.h"
@@ -610,6 +611,7 @@ static const TypeInfo vmapple_machine_info = {
     .instance_size = sizeof(VMAppleMachineState),
     .class_init    = vmapple_machine_class_init,
     .instance_init = vmapple_instance_init,
+    .interfaces    = aarch64_machine_interfaces
 };
 
 static void machvmapple_machine_init(void)
-- 
2.50.1 (Apple Git-155)


