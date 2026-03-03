Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ABCEC1431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxO8l-0005EJ-9B; Tue, 03 Mar 2026 06:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8R-00050l-L5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:41:58 -0500
Received: from p-west1-cluster6-host3-snip4-10.eps.apple.com ([57.103.67.53]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8N-0001Sx-K1
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:41:53 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPS id
 597BD18001AF; Tue,  3 Mar 2026 11:41:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772538105; x=1775130105;
 bh=mLmxlRPFcwMxrG9myQtY85BdAdnRcI/En8EyLObKCOE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bRrtO0yxF0zqrSM+j/OxOqcFDTpUvIe2ewUZ/jDRcQDow8NN86NKyNazdv9yKsfdhh93R/QAsuQU5BZnNuE0DTJvDx4xWNzrkmZYRSMEXjPxC9Ek8fbRg/HC2S6hYH8hLtgtN5AHbNKHK0gaxc9+DVNxDAIayZ/yog5mdM8L4i0vs0azBuB3o7piaE94lmQXckd6mZC5K/PQD6O3TPkimn8y9GZBL63SX5EdTd/RDg4xEg7Ebpz2Xpin6reYsMwnxUWXTkvkS9NPgVo8MrSbKVRrxb8Kt9+xT+1sYNsPDyH5msRYEB1x/SA6drcPjsz0T6I35mAaybyA1UwctjHO6w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPSA id
 C2186180018D; Tue,  3 Mar 2026 11:41:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/6] whpx: i386: do not enable nested virt when
 kernel-irqchip=off
Date: Tue,  3 Mar 2026 12:41:30 +0100
Message-ID: <20260303114135.15390-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303114135.15390-1-mohamed@unpredictable.fr>
References: <20260303114135.15390-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5MSBTYWx0ZWRfXzN7DCCl7iJc2
 L/udpOQnvnEIIsmXqtK0wfzKXnFuJQ1YDfwEiVYtHf1LpU42IVy5jI+m26y6IyQTJD+joPBOTEi
 LdOU5CznzjCnW3DBfZlYWa7fMcRGmzHCDG9BggjdEOfdDziuY5jEFidn94rEDgDz/EpfaHo5SEq
 PZNaGQ7dh5VcXEU5fVj6UzUpAT9Je+PVAUTHhdaUQWk25cIDTGdYeriRANh7cygOhFebI4AhQYg
 9g2HddYWH5JcxKHciTlTyfxeTjPdO/gG+b+x09Pp628tFS9kOtKXlkxjFpw98pT1ZfuTCr4jNUC
 Xv/qjrlTZboW4Mzqp+VQJmL80bJ5QUsCbzH5qvvXs+lOFV6ZNyZWd+DcyWIamk=
X-Proofpoint-ORIG-GUID: IxBslaViKlEyzMM3C9kKMzsyxd8QfLSY
X-Authority-Info-Out: v=2.4 cv=XbKEDY55 c=1 sm=1 tr=0 ts=69a6c8f8
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=eKpLbWQDCUPTAuIwU-0A:9
X-Proofpoint-GUID: IxBslaViKlEyzMM3C9kKMzsyxd8QfLSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 clxscore=1030 suspectscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=830 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030091
X-JNJ: AAAAAAABz/yotMZviZkIPitPqt+/rwxZzumJ5SQQTwzPDzY3a+Z+Q4QlZDznI1IE5qQ97ev/erctLG/Ma5/IWdTw70hblg3pjfhpp8V/IyjQjVlB0lWDHg8LmF05e7ymZu2mOpzpUNmtNqLlDh0k45i+qxsBXENyRXDcIyISOEq5AHHQCFm5jSMx4TcEU5ckf/X7vp7I102vjfpmya1h1NXj5xpfLaqfhGFeLiuHWJHrkBVPdxCSZGBG8sxuh2Eso5Q+MfBoFFtUn7Z6EzaXIuSfjFxUca5gzpLKdFyY9xHKQl7ZkFfXinuxk0ZUCYU3c2N8rsvoXfF7jSnR/oYJh7JysLIRqFjgi1FOznQkcZqowm+Nm5lUbClOXDLdr0IfyV3BVyHXNL9tBRJqM7ezNuKJRllTESTDOIszUMBoYq0ShgNdpAPj/K36E0peh2tMOcp1MQm0JmOhfxMuGWazibzjAkVN6S/PXXx1lgLk4O8Qnn93qthtqBWIFZUgWxzjDye0T8paRxx1G8jN4zPmK3vVEksRl47DFAP+cvEnUQvqOXWHsccYMFA2J3/b89yvBoNqE96dBeVdd2MCN2hmfyj07Q/KBEKvqVg9d3++7eqBcTSN6GfO7+3mpJMNAPZBRpt4WOiX6mwV+UaMIup0tj35s6hV73MxblZlfYIYmmhpObs6xsp4rZvYtlfAcnkGQgqpXrQkvUgbNoOJUnabF7n5Em9MbJecFPHp3WXEDQ==
Received-SPF: pass client-ip=57.103.67.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

This combination is not allowed as of build 26300.7939 and results in:

qemu-system-x86_64.exe: WHPX: Failed to setup partition, hr=c0350005
qemu-system-x86_64.exe: failed to initialize whpx: Invalid argument

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8dd6f68ff9..4afcbbae25 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2147,7 +2147,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (processor_features.Bank1.NestedVirtSupport) {
+    if (whpx_irqchip_in_kernel() && processor_features.Bank1.NestedVirtSupport) {
         memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
         prop.NestedVirtualization = 1;
         hr = whp_dispatch.WHvSetPartitionProperty(
-- 
2.50.1 (Apple Git-155)


