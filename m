Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4E0CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RIX-000162-Uy; Thu, 16 Oct 2025 12:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIW-00015P-JP
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:52 -0400
Received: from p-east2-cluster1-host1-snip4-7.eps.apple.com ([57.103.76.30]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RI6-0001cI-9F
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:52 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 EF672180075F; Thu, 16 Oct 2025 16:57:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=AZVyyBW9yXgsaeulA1YXhH/G5izca99gWRDYt1AsjCw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LJxk1oU/PhdViyEgTOpI+H6Q6yhgQvte58YjngC0iV9JGb3b9f3KoBf4UtITIn8kJIkqoT7r3M2HKfq6qLHty8OvyG4eofaTnUY/4FXQx+vb8LsCZ4Rdm0c9Bq6WTtgDjTTng+hYzd3Wfah4NdlQX9Un5yKD0ja5loqkaUbGg0v7USVGg4CuR8PkiLiDCvjHhexhWOGqzDLmhSaZjZdNts2ftXs52q4ZnqBVMWnjh1KVWIBB/u+65qwXShfeWE5qDlmJJ08rF/VvoJPh43AwLiRnL5VqpprOdXXowQZyxxdiApIRLs1iVca81VpScTfneF1a2y1c/Z2kcSAtf18ymQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 02D7118000A3; Thu, 16 Oct 2025 16:56:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 14/24] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Thu, 16 Oct 2025 18:55:10 +0200
Message-ID: <20251016165520.62532-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JsCEOPQOJ2dsSIDOxlHrsbL5OsLuv_dQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfX92gxmSv9O7po
 C31ioFjC667O407rDAP+I7esduqWKOQeqt4r/HF1vflt5nnHtAha1jNxXz8zux2fqzkt3Ns338Z
 Ij3oZV1di3pfaBXOqCLreV/sTAsK/ft4QW+HBg4Thzo5iDP7Gu5nZ3n+kaOe520JwiYhf42SA+9
 9Ipr5n48NSu5gESRATmkDFudtl6ToFJ0afQhHMrgNZ30j2931jzSg1LU7sfDjbetvrZxT7Jr46C
 wCzmig9EXFd7sA2y1ufVLu3IxbTpMPLydSBDADnWX+z4vFZzKHdmo4rlh9DeVsRW6Cour6n1g=
X-Proofpoint-GUID: JsCEOPQOJ2dsSIDOxlHrsbL5OsLuv_dQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=906 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAABiyYFN1ylLz9x2kQJNEPRbUP3xlqwEVogXRXR2ZOOevjA+VJdwIaZ9iGcCDVM5Vc2oHYBKP+ZFCLIEMpbmtDSPhtW5ml/A/715zWSn1yLhgvg2vWw67NhoDXOuWeHdSd8CzSyqearBtLfqxeX/VpHSQwQI8CvTT4/sSAtcZZCyUARmProdzfBj5iq51c8uVCz7ugM/nzlLNNPORH6CH/TBwI06KA+syC0D6D9phEsVNpH8uV9acqg+FOQYrNewslELwyprxF+370b4odbLc1To8piL9ppJS7fHBBccT7mxpj2+qNFyCRpoudFaMtOQ9jRfMgLRbzgeivuotc7kvVnerjgd/D8J7B8TLMx5RAmQAUqOvQZkCKXjSpMHZrm0PU3H91/jf5ek7uSgOZVAujRQ2lAieMh6TULbwZrG1KguYI2l0KcpVaKwJuNNwFSsPZHomXub2R8yu2Pe7ambQ+zkOf86f/c6vHGwnNMqZwPlYsZ7suy0NWJh2sF2Y+e19CyK0vXzgMojU7xN5Mwj38ZLbgOsFOGstZaozB9qyc7j2epK6ijJwL7qunQWjR6LIhhwfrgu95lFoR+/aJjolZSkr3QHHlxU4YLx8NxQhOAr/NwnO0Bft4dXic1MQ7H8CnduPme1FFXlGR7TRKfTbGK6LjFahqZCZsCko7Ib5XdcR+3wzXfKm4ikUJw3c8Az2v+dBa4CDY+TPpQB4VC5E1dZDDl5uQKPZ5IS5ndv2kqCGgMmKLk4z1eW4syWB9S52H9kJlxJbD48HDYux31b8QA+T7tprYxmeRnA6d8mxeHFWKETH01icXv6hNeE+yFfwl85K5BhBavLa/kpLw8SRAyAGyjpC9U4OjDqOqb04k9RmeuXIpoeseRDaxvMAlNp25psLqXjXcdnXTArcARzPR0ud6rsLB/EXMdkA3VYsXGHinUaZW9gRY/8Vc=
Received-SPF: pass client-ip=57.103.76.30;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3b556f1404..bf25b3580e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "system/whpx.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1140,6 +1141,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled() || hvf_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
+    } else if (whpx_enabled()) {
+        cpu->psci_version = QEMU_PSCI_VERSION_1_3;
     }
 }
 
-- 
2.50.1 (Apple Git-155)


