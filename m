Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB14E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRUF-0002c9-48; Mon, 23 Feb 2026 03:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSr-0001FU-SY
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:52 -0500
Received: from p-east2-cluster3-host6-snip4-9.eps.apple.com ([57.103.77.210]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSq-0002Ll-HR
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:49 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 1E74E1800218; Mon, 23 Feb 2026 08:38:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835925; x=1774427925;
 bh=gtU6O9Cu9XkEyzJz8skz8NQEIEN6lbh5ZiIRw855Hxw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=R4r1c8j/VV84602et/9Me8tlcqjg/eh5b/W5UbmI8TX0qS44Vbd9pWtjindwYKoqdBx7V+ulLgS6VyzWr87617D6Nc3WZXMlwu/5KXYPWSx445sLpRw2Q8Jy7GlirG1x6Avch+f2h8d/LrA3elhzc5PPzFcZji3B5o/VcUbRhx9CHD6cwZQrQvqbP8thtCYDgkRfg8GTAdismw9GsNeG62/8se3HbzLoavOGiJ5PrxHJqJ8q7nlAeWmGjvk5mEMpmlwWrSDf/qFl9U7o10LFlEPKADffuvWVeVsWwRsWLq5AM8TYW2t7PASSgmrZD5rIXOD3f5gO3mDuf6b+lRuHWg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 5C797180016F; Mon, 23 Feb 2026 08:38:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 26/27] whpx: i386: bump to x2apic
Date: Mon, 23 Feb 2026 09:37:32 +0100
Message-ID: <20260223083734.48533-27-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EQSJ8WjNMv4QG4SsGCaUsE_1G8FgDknX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfX59VQbMukm3Lh
 5N1FTHgdqPrVBCVDqSf/oBzEoTqrIcMknQW8U3unIYMbkugMIqu1yD+HVcAfGoCNfEiuE3TGMvK
 swYQJ5zuZsvDjuSdVA0ZLYY191dA+nkXfm5Go06swPlZlkkK4u4S0kNhOsKKyKHsYX2REwmhB98
 cOJ57G5nwhU3bGrmQm8+T1zow62wgbZSH3UYsYuoqB4NBXyKNN+sNz9B4tm4uOtYZFVncvdNC9d
 dcc51120VtMiWjDiBo9tt5FrlLYSkTatV9WQJikSeeAZApye06m/OYUn1YfGz0VnfpSWB5mhuAU
 pAIW1uKQYxixPg/lEuv9dwtAZB6gD7vD+0r4Sa6xAaHdtD2hFQyU8H7wPVpwBM=
X-Authority-Info-Out: v=2.4 cv=fPw0HJae c=1 sm=1 tr=0 ts=699c1213
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=wF7mTIv5wlbhAN2AGiYA:9
X-Proofpoint-ORIG-GUID: EQSJ8WjNMv4QG4SsGCaUsE_1G8FgDknX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1030
 suspectscore=0 mlxlogscore=740 adultscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABAmpfQmiPKm6+TrZChPQW81bGeOIiauJn3qYGPhcjOqGKwcfdpcmPEc9Pa+eSqpgOqk8ksoWBvGMEoydEgPgwsm4GbSBm9ovHfP/S2PU4ahDEJOm5hZqt+ZC/fYv2i2Rk5rwz+iwELc16bbo3h70t3h7ZQwSRrSqj8nGEKhxjhxi/FEmVcFR4HGvYTkZMEyvORNV0NwzCTEF71ZaYWxywUpY+ueQuN7oY0h6oFRBj9iZglOps4oNlH1qDfZd40q5JLnAB3DSICC9C+7Bc2OsqmX85aZdTdC5QTnBrX2bhqFHvtb0N7iBsx8M9DQ9bxx3LZRrm0RVh2kLUakLDly0NFilyTOjDESIv+bJTRdG8o7WE98jswn6cIS38F0oJ8cKkDnv5AtHgA5NpVfca4WHkEChlkvUdD+OlCMIJh06DgXYtfW11M2Ez72jWTW2ETSSv5HeTOoipehnDOUoQFubfQckJcwmR0nB964T73EKjnwHNuJyaxXYn9nHjjU/yIC5+iJNw+iYS7SPBSdURmnqSLrL69tpT5XghVLnIRJxkWD5VeUUwPonbNU+NWtf7ZLLL8m1t3bK0H4rUMwg6qZmg/mAGzL6Iv5inFJbFvxD7RWR8D/4vNIkCQZ5XiXCdESPY77tXuc/TZc+nJbN+Eiyg2T7+FIurKhIL2kt5eV358kJ0X5s30tx8pR33dLVPQ/Qyg4TzTaSb+3aZjFNthZMy6DswYjDm/yBp4kk16LPMMguPQgTlUaKgdwQSGdZIFV0m1Oyw9M+1VMBoKNLfT3aAVz3CMavj0S06WJTOXtGWpZ+X
Received-SPF: pass client-ip=57.103.77.210;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0259782a82..d98619face 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2088,7 +2088,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     if (whpx->kernel_irqchip_allowed && features.LocalApicEmulation &&
         whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
         WHV_X64_LOCAL_APIC_EMULATION_MODE mode =
-            WHvX64LocalApicEmulationModeXApic;
+            WHvX64LocalApicEmulationModeX2Apic;
         hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
             WHvPartitionPropertyCodeLocalApicEmulationMode,
-- 
2.50.1 (Apple Git-155)


