Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626F6F531CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 20:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCOGr-0007U9-MY; Mon, 13 Apr 2026 16:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGo-0007SS-Ru
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:34 -0400
Received: from ci-2007b-snip4-2.eps.apple.com ([57.103.88.15]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGn-0007wQ-Ii
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:34 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 2C5A718000A7; Mon, 13 Apr 2026 20:52:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776113552; x=1778705552;
 bh=zcmYD8sBYnUVL4imQw8BkyvhG03VGFAjf3wzcMF8rtM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=E3Ei+eHN/PQRV9i6AIzAuY0ubvDQYKAnbBuPGPI/umXMbM65g20EUAoR1JbZEqL4/Vp90zGvUbLiaKvk9vdXIbO+u51lRh8AJ/cTDPS0Wc5leY00K70ZlJwp8n9vNCY0cxAQ8LtV1xtPXYGE2ZAYRZTqA3oBJ0WQ3DQiUdk7RV+2XCk1uDs6P2q9523TNhSVZy1ESQDHurdXzsa75YTZ70E5FhNkgxWh8Avynm3RxLyA6iNJol1cmB7arS34KPVHDKl0tbjcXgKaFA4us/z0mvcV+d2Vz8W41hM3FKrPgQnpSi1w6tu5mI7f324H0eRYqGaUgR+lmHX1rOntFLIosQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 487C4180020D; Mon, 13 Apr 2026 20:52:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v12 12/15] whpx: i386: disable enlightenments and LAPIC for
 isapc
Date: Mon, 13 Apr 2026 22:52:04 +0200
Message-ID: <20260413205208.50643-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413205208.50643-1-mohamed@unpredictable.fr>
References: <20260413205208.50643-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIwNSBTYWx0ZWRfX3YpmqBYtqwnU
 rhxwaC7bpQImC/qRL++4QoiNkO3ibeFqUmmJYNjAg4EOFiFy9FaBZmPQzZFXF94Wm1H4v2onqu6
 kXqTVYPF+WcER2qtBd34pj3YGDbdJV2iRwGDTisWXUBvwIRJBUF7tUJa1PD8C4fcRs5fX8Xwyel
 cJOhPbogaUtbQCqNnU7RQXu2Wf3psT9EKFnsPV4yV4DD6jSgLVtkkBuUEypu6HDgQSIWwukpqNT
 1BLlEq39lamqb5JTAB6SdAdzCJv3F4DeV1QaqC/3OZwhlRenjwbpEZJP6U1g3hZ/bt9mWLGplgW
 tOl/i87hgUCxfNgmW48Fkz3ab6Ee4xaSSx4UpFf29S/cFYyZdXzj78zmuXr9+M=
X-Authority-Info-Out: v=2.4 cv=HMrO14tv c=1 sm=1 tr=0 ts=69dd5790
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kaNVauZA35-AGszze7oA:9
X-Proofpoint-GUID: 2c1Kx3gmVl8zu5KFrkzTs4ZRu8kMSX7M
X-Proofpoint-ORIG-GUID: 2c1Kx3gmVl8zu5KFrkzTs4ZRu8kMSX7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1030
 mlxlogscore=817 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130205
Received-SPF: pass client-ip=57.103.88.15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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

The isapc machine doesn't have an APIC. And Hyper-V enlightenments
don't sound too useful to have there so disable those.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 61aec98e66..7a31dc6427 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2470,6 +2470,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* for isapc, disable Hyper-V enlightenments and LAPIC */
+    if (!strcmp(MACHINE_GET_CLASS(ms)->name, "isapc")) {
+        whpx->kernel_irqchip_allowed = false;
+        whpx->kernel_irqchip_required = false;
+        whpx->hyperv_enlightenments_allowed = false;
+        whpx->hyperv_enlightenments_required = false;
+    }
+
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
-- 
2.50.1 (Apple Git-155)


