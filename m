Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B3FEC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxO8d-000586-DM; Tue, 03 Mar 2026 06:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8T-000511-57
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:41:58 -0500
Received: from p-west1-cluster6-host12-snip4-7.eps.apple.com ([57.103.67.20]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8R-0001Zu-GL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:41:56 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPS id
 F3CA01800394; Tue,  3 Mar 2026 11:41:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772538113; x=1775130113;
 bh=OW8S3KLD8zFsAuvhuwhxPEOWPDp1M7oc2dpZI+SomHI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=dZukHbEl/NKiaddu2CmgMLKZT320rwPc5aUuyiN6gvX0kSjF5bY7hZysTNX3Tya364Imx2XGzLS2G6meT2ggZQKjhx+3sEIp/nZwYZCFWDwUv5YWZ1TbbAgV3b3JoFuPEWU3cmWUFY2BvCd6GRvRcwcI1fBJLCFE+Qj2mp9b4RRQZZVglAOstXXKmFG6CmCxg/7EpZQ/feXR3A/BWwksi0EB7zw/21ux56AzDaYUJf59C2evDDeocsZ60tYTR+58vUT5B/4OkCCOZnvTng+qbDqfG/FIIY6Lxvng+t5r2PfDauCEIzdUfBzMRKkYoPDt7X1BmHnoRjcVt2ypVJfYow==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPSA id
 9689E18001A4; Tue,  3 Mar 2026 11:41:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 5/6] whpx: arm64: enable enlightenments if asked for
Date: Tue,  3 Mar 2026 12:41:34 +0100
Message-ID: <20260303114135.15390-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303114135.15390-1-mohamed@unpredictable.fr>
References: <20260303114135.15390-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sR0TYWbTkNr5mkpU_bIqLVMMw57vtP6T
X-Authority-Info-Out: v=2.4 cv=cbXfb3DM c=1 sm=1 tr=0 ts=69a6c900
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=rOdoSoqhRWX9tc6y9DEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5MSBTYWx0ZWRfXxbv1S8RniUI3
 vA4mVG1WZGmIR3eHCxwra9fN9hQPzTa9VNogtAv4pe/ZveD8xch9Jj03CIzMW7Kb4rs2CsXuzWg
 hUnjCK2ni6baS7+10j+kdE07Dlq8lvXfA0CVl2FlLRbbgFezrw+Do830Y+mUSm1If5xVMlbAKLL
 djqfPHwfLErHZwoyL+V7n++lmRMrmYEcUPTwqychc3rdKwRe/goN8lRfEgMxUX1e3U13J+h85n1
 vCGtB2huxxvkNU4hG8pnYXtMbnjAV2Y1fO5amtL2iXh8XklhqK1NCZCQY4M+IlOFsmG7FGsHmKE
 s87/qQQr2WUtYDJLACBsx8giyiLfRIO5v7p9S7Uu0FcY5lBgog9Oloxo1fN92w=
X-Proofpoint-GUID: sR0TYWbTkNr5mkpU_bIqLVMMw57vtP6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0
 mlxlogscore=685 mlxscore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030091
X-JNJ: AAAAAAABkacgR1d09a4ToUGSnuHbZs1Qu6KEk87AEaAikjGWvbs/AJag9stJKunSNKoiDQOQbKbJQYQMnZKZUQT2pQFE7SJQe6v5cJ9lj3XVIZHXuhXWWmJEyWXgU3dXR9m/bhsVreVOMNcVTqTfocQjkd52AB+NGfsGOz1ZS+i/YchR9MCAtuR7sOkRdhC/RvIzh6+GLPeruF/VuSug2sOJb9vYB53ejBDcCUuxw8dJnbdFqFIYJAWF7qA1TesNHQZk0iMXJaeB2PNsqzQ1oQor26iRZL4uqThPfegJTHuzO46g5TTguATNJQgHAFTWya7UR1mrQQ3YwMlTkrR97VRmFokiS1ZyTppuR7U1O4zbFHPEt1x6a4wNmBDR6/w1LoCDNakJrPGtkvUkgS0Z/n+44LzvJzpN/Gro2+gb8uMgPLeIu5iAKeek9E31KRqfI9taJ/ZqliuhOmRrX+pO/f3M+YTJZTHY8lccfsOWBtSh/bVMfG/bCHarIdPozXQsdWUZOQgyfPYtRoy+zED8nDvgaK1FUVs1TJJHMmUMB6IYWUyyTL20Fpi3J+M8C4NCDUlDfRC1qAsuxFwY18OXFQWOIakg9ruu1Q5bvqbdGvlG9OYerAGmzw1qRXOd+BCLZAGWly3Lswi2XEM5q0thnUa5EaB9Cio4hcjB8NHxwtd2LUFokTYbHQr5JyVUstI0Von2XQPBWJFVE8ua1wvo4KMYM8Tr
Received-SPF: pass client-ip=57.103.67.20;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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
---
 target/arm/whpx/whpx-all.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index bb94eac7bf..9983d59a38 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -947,6 +947,43 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* Enable synthetic processor features */
+    WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
+    memset(&synthetic_features, 0, sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
+    synthetic_features.BanksCount = 1;
+
+    synthetic_features.Bank0.HypervisorPresent = 1;
+    synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.AccessVpRunTimeReg = 1;
+    synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
+    synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
+    synthetic_features.Bank0.AccessVpIndex = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
+    synthetic_features.Bank0.TbFlushHypercalls = 1;
+    synthetic_features.Bank0.AccessSynicRegs = 1;
+    synthetic_features.Bank0.AccessSyntheticTimerRegs = 1;
+    synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
+    synthetic_features.Bank0.SyntheticClusterIpi = 1;
+    synthetic_features.Bank0.DirectSyntheticTimers = 1;
+
+    /*
+     * On ARM64, have enlightenments off by default 
+     * as they're not needed for performance.
+     */
+    if (whpx->hyperv_enlightenments_required) {
+        hr = whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
+                &synthetic_features,
+                sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set synthetic features, hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
+        }
+    }
+
     hr = whp_dispatch.WHvSetupPartition(whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
-- 
2.50.1 (Apple Git-155)


