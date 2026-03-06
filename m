Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DD2F0180C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQ5g-0008GD-A0; Fri, 06 Mar 2026 02:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ5O-0007oY-Ai
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:59:03 -0500
Received: from p-west2-cluster1-host2-snip4-6.eps.apple.com ([57.103.68.19]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ5K-0006Gv-H2
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:59:01 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 08F85180019D; Fri,  6 Mar 2026 07:58:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772783925; x=1775375925;
 bh=ijV/TFHDkMx/sDtjnbI4Tcf5/3qsWHHZ7tvtB+wJk+k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=S3DpDN3z96ZN2tj0Z2FLSkOhJzRj4t37bkhSnrfvccVISsRSK8SAI8TiPRHBqH33UDxPAYsG3grvwyP5Qoxzb1QL+Q6tONpWQ6lZTG6BKGKsr67KYlD8Y4XBmWbvCdR+F6jMPrzBkxFjFaXpkNTW6TZgu3J9dnOpVjfRyOn6e3OYevrR+O/9Mg62sdlqxPQn5lvW+jL+8yxEqG2NbNMe/vkuzO+K3SBh69uv36aSPwPIDYeotOYvrWUTLJhFJqyKCBE6ryxZdPVQYflVUKKUX2IG8G3UyyVKLKVdU4pA8PVdxDwipipTmC0ZAGL54huJ5RqsI5OfQRmLl5bQYL3beQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 AA6FD180010C; Fri,  6 Mar 2026 07:58:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v13 17/17] hvf: enable nested virtualisation support
Date: Fri,  6 Mar 2026 08:57:56 +0100
Message-ID: <20260306075756.88922-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306075756.88922-1-mohamed@unpredictable.fr>
References: <20260306075756.88922-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3NSBTYWx0ZWRfXwIuxkq5C0aoU
 g5l1dJlFvWAyfdz87qnYHkWWyPBiq2T39A0KDK/4BfmEGg0pJuehHgv8xaXxESvuwdU7nn4I08O
 ME9feFk3/o+yKsUDg3GmJ3eaNOXZIMpvavRylyNaeAsnVJFyxOMtm2QL/Nc4zfER4D/KXdHnYzf
 yj/fMOiUKmvTaHUEIyTLe5C8tCRYc6KyNoTvcBC9zjfO9QwUGbqFcaqK1kGDJ9Y+jN8Eb+66Y66
 J5i+dY6hBuChRzQH2vXtR2u9Ip/KzV6vwCIrLJ5cN2muPh8r6veFr6q+ckOGkxy5Ub5I+r/Nw0W
 8Me/7c+NBXQ4N1tAed5fQdXilSlz9lr+tVO8BBhDY+4T5Ow6IP5lv5MYT7bXfc=
X-Authority-Info-Out: v=2.4 cv=BKW+bVQG c=1 sm=1 tr=0 ts=69aa8935
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=5Chse3eIq3h0lgOaJ4gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: y3i71M5AG_WV_5a1fu6LuxFO7pwPVvIr
X-Proofpoint-GUID: y3i71M5AG_WV_5a1fu6LuxFO7pwPVvIr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=995 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 clxscore=1030 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060075
X-JNJ: AAAAAAABqIK7Ls47NluHvZ2xqFhuml/qIWZqmO5Wv0hB2rEPMjY+cc5whHNyibVDrEpxeD9DkEmtFFS8aL3SWKfpColIyExUCoLs7BmWEyFoZ/6ereQX/FNm+8k6rdDf92Jm/BmKjpDBPdQd4ToCFw3Dhj2dPEATMseHBqXB6gDu2969lh0IXcgHkmm1rtvdRoaf5LGlf6mn6FDcIV4Z+dzkUczTWlUPjSaXLglblAK8DzRi/XZa7IJdKyyMysGKJ+25fAKF8gCAInj5HbOXBIJLKM6FyTSIltW+XGAstLMnmKicDUwgKTTLs1dOmYfogvSEtZGe9TSvINOk0NWoe5/bOjWB/jaSQ7PBj6/4EMw4F55JTZ9g6Dv935sVasuvCiCP8dhcGGqwXgFb0HMGxXErPqjS44Kp8BvcHnPUGpATEeyH54aTeEZIe99OGkblwSOn0mX9G95PgGUc3oPt24oF9px6zCGbdIg02VYd2COeOFeDmmsP2mgDZthKX+/kivi5GMa7muzV9I6UCgxSDltx7C4TsEzojiyAE8hSIvClHI7gTGKghA0LwexyFk7SccYisiJ59/m2CV7BnSJdIJPpckXaZ3Or5hi0lUqPXcsTt6skmQc19Hd5sJinrQAgb/F/PabHOF9fQCowUvOC32d0Wczc3wlAEVdHXS69yUTvDmc3nw7Y3MIXItt0XC0etl2aWIiW9hq9rm3Z5yArkiunBGVsx0ulNsM9hLwjJEHeP5vKIA51nPkZTe8=
Received-SPF: pass client-ip=57.103.68.19;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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
 hw/arm/virt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 90769936d0..bced9f67f4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2393,13 +2393,20 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && !kvm_enabled() && !tcg_enabled()
+       && !hvf_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
         exit(1);
     }
 
+    if (vms->virt && hvf_enabled() && !hvf_irqchip_in_kernel()) {
+        error_report("mach-virt: For HVF and Virtualization extensions "
+                     "only kernel-irqchip=on is currently supported");
+        exit(1);
+    }
+
     if (vms->mte && hvf_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "MTE to the guest CPU",
-- 
2.50.1 (Apple Git-155)


