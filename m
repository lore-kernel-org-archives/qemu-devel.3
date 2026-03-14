Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED3D10854B6
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 22:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1XGu-00041t-Gk; Sat, 14 Mar 2026 18:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGs-00040N-KD
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:46 -0400
Received: from p-west1-cluster3-host1-snip4-10.eps.apple.com ([57.103.66.123]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGq-0001Wm-UL
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:46 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPS id
 15784180024E; Sat, 14 Mar 2026 22:15:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773526543; x=1776118543;
 bh=mLB2+DEFN0wtlDU1jYTROQnr06Gq3cpO51DgT0iosvg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=CX2yFR3hlAS8oLD9p0FHurX6N0I1V3GQ+bQz8r0hWHo8Cs6GfbPPhRTMKamOTN7/XMncd94YFurCgi1QHu5Q9rRsZlnaWjoTo8gNxGYN6qz7JNc3o3tjR0pq0PxBWf5P8GFQeB0rVIUVYU58LkL6Pwd/zD/49PcMhODdEs01kOPBb2uKdxyQWMeLBk4MiZoLf0jJRz9U5btxK0CKf2PaYxMZATscNYIPWGy1enGBZuPCbipCAfGCmEgi/3+PO7oSH8Rz9VfOK5chC5xnZPDoMRufjzIJbZexB1ZFCIlD/dI4rwnDAgD+nzSLM6uONqzjmMuPA2PKaqAepvt9mJlpdg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPSA id
 57CFD1800254; Sat, 14 Mar 2026 22:15:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 5/6] target/arm: cpu: alter error message for host CPU type
Date: Sat, 14 Mar 2026 23:15:28 +0100
Message-ID: <20260314221529.47841-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260314221529.47841-1-mohamed@unpredictable.fr>
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDE3NSBTYWx0ZWRfXyYzE9zWmvQ/n
 n4etfv2qqU/fSH8WDNQEqFoDpnLrMcwJ4ZQJqzCLagKBkK5QbXq4V407vk93l3J69uwW4ljZboq
 hYAU2rpNeyl4NbAIQn4Ic3pR3c+ufozbwjaJoQJDZgAAC4k05I6Ty6j70KVdHm+fIq19N2RGI/e
 tYIMYLgTO3QkWFdlu5gmfMWRvUCAIowJ4JQBRvXx27knrEHxE1YSVh9AfP6DHPSY4z7YQNgbsHP
 63BW4EHwBQ0Y44QJbnqmDKbSg9xvgKxiEqy2XKk0gdMpdpk4D1XF8Ul3faJbzPj+hTlZQ2bWmZ8
 ZORoYfHw3n5MNa6A6huQnA0yzqQzzzMMKkiiI2feHqBzVAtyrgfzo5yOW3Fx6c=
X-Proofpoint-GUID: aVpvNn8AYSb78SdD8B6pm0V5ht_kxdZf
X-Authority-Info-Out: v=2.4 cv=FdQ6BZ+6 c=1 sm=1 tr=0 ts=69b5de0e
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=OmOJV42uPoV0i9t4TcwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: aVpvNn8AYSb78SdD8B6pm0V5ht_kxdZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=650
 spamscore=0 clxscore=1030 mlxscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603140175
Received-SPF: pass client-ip=57.103.66.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7e3e84b4bb..e73d7eb4fc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1629,8 +1629,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * this is the first point where we can report it.
      */
     if (cpu->host_cpu_probe_failed) {
-        if (!kvm_enabled() && !hvf_enabled()) {
-            error_setg(errp, "The 'host' CPU type can only be used with KVM or HVF");
+        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled()) {
+            error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF or WHPX");
         } else {
             error_setg(errp, "Failed to retrieve host CPU features");
         }
-- 
2.50.1 (Apple Git-155)


