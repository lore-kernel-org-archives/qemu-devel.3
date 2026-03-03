Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA561EDEBF1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWiu-0001SV-S3; Tue, 03 Mar 2026 15:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWim-0000aj-0i
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:52:00 -0500
Received: from p-east2-cluster3-host8-snip4-10.eps.apple.com ([57.103.77.251]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWij-0001Z4-I8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:59 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 30E611800155; Tue,  3 Mar 2026 20:51:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571116; x=1775163116;
 bh=OW8S3KLD8zFsAuvhuwhxPEOWPDp1M7oc2dpZI+SomHI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=H8gnSy9JAVhaX4kwL6c/oej3m60o4nZgThsBksKIcZUNqwBv9sXEEibtujyUQnTJcBNqKuED2DfOYCGGcQ5FjoXtTDLQgJHRrLMmR2MIQusuiEo71zbfU1FdJG6tOdQ+11Nop/LJXWKfyl9QMUAJiOamvA0A5yRpcxtGeqkrNZug0MXkFCmQEX+pOTxHJ1tQ69ySKnpT9kPUqvyThCw/RzjFwTEikoWH754zy5uCIF26cYp/tkkrnx3uvQxh5LQDHO5zZLGKXYRfDHA9PCacrP/TNzpsHDIHvvqft+M2LAazA1qqp6Y1gLkvk2SNBesVwJG2Ffj8/dOxyLn/1xaM4A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 1FD3D18000BF; Tue,  3 Mar 2026 20:51:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v4 6/7] whpx: arm64: enable enlightenments if asked for
Date: Tue,  3 Mar 2026 21:51:37 +0100
Message-ID: <20260303205138.32450-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303205138.32450-1-mohamed@unpredictable.fr>
References: <20260303205138.32450-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfX8Ab4EquRAdeQ
 lMThy272Fm5pSYE5DRZAktcxZtNGIlwUanKRkJ+vjueY2JQBj/AVduTL8dDTmImVdMcU9OVNgMH
 YL8i4q2RrkDGY2uROWp+A0HAy525lZaDe26loDliw/Jd5Pf+YiXwcx+7laVdWclSPWaFGca5qWC
 W/hyjaU+x5o3WeZ8viLJFkp5XPo+JqK2GK9LjWUjjkFyTkpxTV06KLyR0WCwg0I7n23hGasIm6v
 ZFfArtWZ95ckPPU08Sks9WmgKtH5632mp4ySHBID/F2FZ/Ho7ozwanHn1Nt0BSWKq4YBC1QL9Ac
 JpQl7Forxrknly/7FJ64pGm9DloDM9NOg8QSUJ9WIFGt1dla+Pv+caz9tN9qLs=
X-Authority-Info-Out: v=2.4 cv=HoR72kTS c=1 sm=1 tr=0 ts=69a749eb
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rOdoSoqhRWX9tc6y9DEA:9
X-Proofpoint-GUID: kmdXcisEPhQx0014821iECwDuD3jUyCE
X-Proofpoint-ORIG-GUID: kmdXcisEPhQx0014821iECwDuD3jUyCE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 phishscore=0 mlxlogscore=800 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABxNRVY+kqZi3Qme/fDrWPtv+FLN7Qhag+H6BisE3I8/nCtYj5noNImXmjoB4I2QFJxvF7sSZvnO/eiR4kAh4g65CwVNAcPEGok0NJTae+h3ze/n35ccYy+TGSSALHnEIKuqQCqJmBC8mlXW9fPEFnaKfm1Ekq/IfbWWAoaV7jn0+plOXAVbkqtuVU4XrrCz6sKQbLGvC5ajE3WV66asAE01+5Ek8sthRYpFpkrJu9donhIeqvzP57naCclHltY94z3QiU+QUwRM5HqlCHez/ULD3q8cY8H4P1Pgqjmh3GuBvq8CYeL74EgU6J20Jhp3l4xMEz9yPNmw79BQssOCQDrKYlLkFh9kOngCAq8NsvhgdpfxD7v9G2ckiTbqhKwFASGnI56j93jhhib0qxKr5wbo7RRGUBJpETg/jpU4THq3jnRfnyC3VUsWgoKTWlVG3g93Xhcr/THn0xY4Ta/gjbgamAtpKcN+6DsCELwodjAgWk3F703rIkn1rY7IoSrH4QWoVYz4g9rSuu7Ba9FwBzeniNM1yoa3qRlkJJR3LTAivUQG2k+jKKI5V4xo8u3imFPcvROQAzEuFMhgsNseJ0S/lPQfow5PYUadI5Sm/HwPEbTu2REAW11d4dZIB+RoBEliBIYA9mMUrbbjkzseazcEuEUZt+aC/548T1F+iF9DBasaU1UiZbe6P2YaVDObJZxqfvhwKCqxeQbmDsTUrTTXuLcc0PPOzGA9DEegr2983X4mp0+/BZdw4vw+aS
Received-SPF: pass client-ip=57.103.77.251;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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


