Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6697EEC1431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxO8k-0005DU-Rt; Tue, 03 Mar 2026 06:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8S-00050r-T0
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:41:58 -0500
Received: from p-west1-cluster6-host9-snip4-4.eps.apple.com ([57.103.67.87]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8R-0001Z7-Bl
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:41:56 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPS id
 694BB180018F; Tue,  3 Mar 2026 11:41:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772538109; x=1775130109;
 bh=3JX8beg0C2Np1egU4bEnkRFyLgIrgwrt1tvpx/K3/Vk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=A9y7u7fqSsQD5a4HrS9Qq0eSBCxs9B1QTgNzwtIfd7ObAvg3Ye8HlkLv2N6kWD5weY0QskHfDvtEeZXOqz9lTB9P2hePmmqDVlxboymWtvZPgADkfbG4dCCluPlH6lh040W61hvfNSxIv9SRLdaAWkPSa/SSPGhxwBWHqH7aVlGPv3jo2U224+F9IHZTQBGsRSa/6qvLaAbaYRkPcwy/9R/IdU4hW7WEyh5199GGlseFMjG7RGzYv+8P5OndmHzEwvAixoYaI1ertTQJAdQY5O6IjcVvA5+eNwtfgKgmHFmJlkBDXv0WyReczzQdxmrADQi+Dbmg2iVNFUkYje+AQw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPSA id
 2AF0518003A9; Tue,  3 Mar 2026 11:41:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 3/6] whpx: i386: enable some more enlightenments
Date: Tue,  3 Mar 2026 12:41:32 +0100
Message-ID: <20260303114135.15390-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303114135.15390-1-mohamed@unpredictable.fr>
References: <20260303114135.15390-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5MSBTYWx0ZWRfXzWNVSaQK93mK
 goltIb+ROX3mRrlDPEEqsNgtSk959lS/y8Re2kGUFjvrn/LFFWbTBI08TIE4e+80dJvlo+HeRSh
 38zvILIEAqxtzKmOtZwi/vaPBQRwmfD/EBlxDkdK/DbHEmPsHtSixGNDL7G7T9rqY3PIk6GASV1
 rRcgWk3Alc/JDMMdB5iXnsefBl92OrlO2+qMQGftTgglpZs0PH3jnbr5pSCEPx4GfMETUUaWPw2
 +X4y4URC9T6xBHAgHYQAWpRpA8ivhEnyCe0g0jj2TV/V/dmjNvF+NkFG57bcE+CZlJcyiK09lGo
 dRKA6Fbk1GWL7gOR3d032nnoKAz+E2Ui8PEUkG8vEeYy5ZltBcb1nVZXl/HsNM=
X-Proofpoint-GUID: 993l56XztUMv8Xathikgf_1mwdfQ0HWF
X-Authority-Info-Out: v=2.4 cv=Q6ffIo2a c=1 sm=1 tr=0 ts=69a6c8fb
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=lWQTlSF5RC17BzGQrLAA:9
X-Proofpoint-ORIG-GUID: 993l56XztUMv8Xathikgf_1mwdfQ0HWF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=756 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030091
X-JNJ: AAAAAAABpuECg+Od4x+29rOT0IHa9D/U0YNijVQaFjpgNd729uMpYEYe7hVgpJqP/6IVFtOHNIn4mYzQ6jnUmZgPkiIiLTAqNvxxDOkyuQH4FFpgUQV7mgbmvbhzpYwCnO7uDsnncrUj9mi5Ft3KhLDIBhVmczeB2gkQz+A8FdhB86KlmCdR+mNc+6+xDa9cn7+f8Q4DUwxP8uN0jwc1tv2/GAnUKAxr/5N5yEL5uPGECGh0ucEVybul9HyXgGebYVIyPFF/f+pPDIhSP2A8ptSB6Ds65OdLhwPJJZ09Z8x+xuLVAEDHiR1LpOog8apuBKaMgZ2iYvDPgj0R9/Jder4q2ZTA1nUkzvRPf6W4t4TnR3vCb2O5ICK0xJTrTnOa03K//KgE5IOl2VRfjmlEqqA/FgsjZ2czvlhThDIO/Lg473jFZ61EqpFbVvSNwYTp+IMo2dwPzj3WNQkwl2zT2nziz/8KzIHOBDKaZo5LkZI/LqUeHf26ZDvl978dZ5jcw3jmpK+go5HvK3+AeiH4r/Qlw5+nQdT4KAKc2v1HUnhynSIP0Oe/soUojXx6beZEop3WDKSBv3qCDhGBlOY7kMACmx+bPtocoYxWJ5qFufKyGQP8y2SpbioM+2VJnvJZcTFYYikBMcsUwxUioKaoqtjCs9jDw0CPmnzaU3TEe79qPL7+Lr95dBjo/594NEnfJuHWx+W6RofiAZoZ1MHiSTSnu9vuaWg=
Received-SPF: pass client-ip=57.103.67.87;
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
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4afcbbae25..915d79152e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2201,9 +2201,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     synthetic_features.Bank0.HypervisorPresent = 1;
     synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.AccessVpRunTimeReg = 1;
     synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
+    synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.TbFlushHypercalls = 1;
-- 
2.50.1 (Apple Git-155)


