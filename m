Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A03310854B4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 22:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1XGo-0003xp-W4; Sat, 14 Mar 2026 18:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGm-0003wf-VR
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:40 -0400
Received: from p-west1-cluster6-host10-snip4-4.eps.apple.com ([57.103.67.97]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGl-0001V7-Fk
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:40 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPS id
 392AB180026F; Sat, 14 Mar 2026 22:15:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773526538; x=1776118538;
 bh=Od9Ivr5WsbuEkXj/SEEwzm5xKEx98NRFnFm5G4zs8BY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=G54AnILDNiMsx+b8KtzsHSrbttZTEDABaVPSD5UlgymtVakelEMQLRvuojgIpgED7H75puWQdTJnQo07EmtR0Cg1OmxD+d2j9OTG1W/ltP7KMIEwwVxBXoA/6dua1R+XTNhzVJJI6XtD+cQL5DkCHBTk/TmWVzvgUlPvUhJrUoKtwL+v2pgU3YAVcC80XnkvBJiZIpuFBIJXSdYGiMAaqRo+OEGbHB9dAtV44toinePz5ckxaQDf1lBrxaalTjaoRXGyIyv54pGtDSPdHz71pUGXYIZy1+IdROsPlluSHW7iYH1t5rCKfm+WT3mqf2fnaLjWOkqzbJF9L/6X2XvzJg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPSA id
 05877180024F; Sat, 14 Mar 2026 22:15:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/6] whpx: arm: fix -cpu host
Date: Sat, 14 Mar 2026 23:15:24 +0100
Message-ID: <20260314221529.47841-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260314221529.47841-1-mohamed@unpredictable.fr>
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=BM++bVQG c=1 sm=1 tr=0 ts=69b5de09
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=78r_p1vsk4CzcvezoV0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MHPtbrtrqt4-3HDXLwshijkjq9FpG5Kn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDE3NSBTYWx0ZWRfX1CcefQQGC/9H
 M1AQFmwmPM6E4IUtAi77eqCWIHqGuiCZVLaE/IPOxu01XgMF0/OucHbOVV4nZXF9QK2xAuQS9WX
 1WB07UfnRvhGSKVSzKLqOiMWILz/LvzQKtpl9P5A7n3iRqZzweyyPzLLEmHOguJCtjQqyc9wsGq
 JbLNYAJeTG09Du3PQtPGOXPyMLGCUOmDyUtXTaNcQIJ83bpIFC0L0aeEdbw0Eoxj4d5p6n4nUCw
 M09KwGO4hhXzzubAy/DcNWXwhTgWKom6Aj5mDtXevOuqCdKZ0mrwqlayTVwrmoc8ecWPbJ+3ZNA
 vKU3oSmgaFGqC4Puw87SwEY4uWAxuZM7PbHHGnaLsxzteq6SQH6T+vOLZmFe88=
X-Proofpoint-GUID: MHPtbrtrqt4-3HDXLwshijkjq9FpG5Kn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=855 clxscore=1030 mlxscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603140175
Received-SPF: pass client-ip=57.103.67.97;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

"hw/arm/virt: Register valid CPU types dynamically" went under my radar, so fix this for WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bced9f67f4..af3f03ced3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3477,7 +3477,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
     if (target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
-        if (kvm_enabled() || hvf_enabled()) {
+        if (kvm_enabled() || hvf_enabled() || whpx_enabled()) {
             g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
         }
     }
-- 
2.50.1 (Apple Git-155)


