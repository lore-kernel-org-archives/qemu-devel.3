Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5577110854B5
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 22:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1XGq-0003yg-1H; Sat, 14 Mar 2026 18:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGo-0003xo-OL
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:42 -0400
Received: from p-west1-cluster3-host3-snip4-10.eps.apple.com ([57.103.66.73]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGn-0001Vk-Bl
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:42 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPS id
 E78A41800255; Sat, 14 Mar 2026 22:15:37 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773526540; x=1776118540;
 bh=4icJ72AU1OOM5tOrqHPkWr3ogIPSAmTNwYbIOrNfOTo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=JvVclcRSUIX1c1GCSZMsinDGoD1Tki+3i+gJTDwC+ycumXpbJraY73QBItm5+mDsapGORU585PIlCZ17axvj6Dev1u0l8o0jdkWpiDsIbi4kj4GDrWr6OuiWawt//E1HTfCVd+tINUWFaf/LHnUwkeocgUsyHVZZpyG8StdKbUq1p4ArM0H4SMM0wRUBneOa2iGWGY8hLpLOBjBbTlEznTEYwLs94757BLZb03/s9h7fAyYCfl/813jFukSU7n8rLE5RT+AItlCoLHUr3Lszz7HWjcG6YCHx6QbP852MBFHccS71QPO6QnMhVd9mvbYcUSJ44ngDnaHsG0Chr/ykLw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPSA id
 B513E180008E; Sat, 14 Mar 2026 22:15:35 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 2/6] whpx: arm: add EC_DATAABORT assert for
 WHvRunVpExitReasonGpaIntercept/UnmappedGpa
Date: Sat, 14 Mar 2026 23:15:25 +0100
Message-ID: <20260314221529.47841-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260314221529.47841-1-mohamed@unpredictable.fr>
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=BM++bVQG c=1 sm=1 tr=0 ts=69b5de0a
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=iF5FY4ceKisILDQj2E8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: voS4S5Ntgbz-7vlm17UeAzWz5fXQk98F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDE3NSBTYWx0ZWRfX/d2u2iCVjK9X
 t8VPsqklYhGnvA8wstXEaD+OmEawA3qUlmAM44Z2PN4VLVAPhfKxfja3NI1BIjE49/AJXjPT79A
 6ptW2xvKEfc/qo2Eyesbi8wNqjsPBHAC6pbgQuxAy9HR83kRRscAE9xBjHgw9XpYgilScjIFhwD
 Nws/N2vSAB+1YE7V8uRxqAMJRQqaGOuHHqmPp0qgvDg1wsKqTDOQux+v7uZyQxkiRDMeASeFfUt
 /oIeZaXV8pW7EdE0iFLyTHQMyWnEAqVaHe628suQNTmBi2tIqAPS5tGsTZgpQnB1Z3uXQJR0m8b
 HekiZ1zCIzZYfL2BxfA1gNsNEZBY/ShutP/CQ/hlYR0ht4C9CFZqRRXaZzp7ts=
X-Proofpoint-GUID: voS4S5Ntgbz-7vlm17UeAzWz5fXQk98F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=660 clxscore=1030 mlxscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603140175
Received-SPF: pass client-ip=57.103.66.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

If we get anything else from Hyper-V there's a problem, so enforce this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/whpx/whpx-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 513551bec1..3df60a950d 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -439,6 +439,7 @@ int whpx_vcpu_run(CPUState *cpu)
         switch (vcpu->exit_ctx.ExitReason) {
         case WHvRunVpExitReasonGpaIntercept:
         case WHvRunVpExitReasonUnmappedGpa:
+            assert(syn_get_ec(vcpu->exit_ctx.MemoryAccess.Syndrome) == EC_DATAABORT);
             advance_pc = true;
 
             if (vcpu->exit_ctx.MemoryAccess.Syndrome & BIT(8)) {
-- 
2.50.1 (Apple Git-155)


