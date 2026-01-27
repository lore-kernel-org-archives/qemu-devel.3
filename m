Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C61D2FEDB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknrJ-0000j8-Bu; Tue, 27 Jan 2026 13:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknoi-00027j-7S
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:38 -0500
Received: from p-west2-cluster5-host12-snip4-1.eps.apple.com ([57.103.71.14]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknof-0003jh-Vu
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:31 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 74CF618001F3; Tue, 27 Jan 2026 18:29:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538569; x=1772130569;
 bh=0JMxBdejtyNGNNsrlyDp+frLA+zrF8bgZozsFerjTiI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Ai5a5bLjOrDtWDWidVBYXEp3RviT8T5i8viRFo++3hMRAdsAcDqoJBUJob+RXeHe0t060KjhZaDwoLkJ3OgpJHCP8WDniS+sBALeOz+W6xNdR059WVHOmqichYYZtHVLhJe0cnul2rNlgXTrWh6DkZlyAesC30dTFe36ihm52Fd2gj1lPQeVzNQhAa5OciNzyV2zVNC9paZmVQhuT4yzpRA3XbDSyVN5Ok/kd9A6wlSUZJ9ci4DWI99B0El4rl9QPRl70YT1XQu+A9bWLpKs2j7iBBUHNogHIRfQ4UNsIegBbrssqE9o/upzNDuzLVfA5K9lF/EmHnDidsvtoy137g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 EC16F1800253; Tue, 27 Jan 2026 18:29:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v18 16/22] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Tue, 27 Jan 2026 19:27:56 +0100
Message-ID: <20260127182805.73212-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfXyfSKfQdRZ4rl
 wNik2mJyWDaBspjQXdERrSpbpRnnyjEl0zSkL2l+1HWUn79EbzlC196eWau+QD0WagYMDdlKwJy
 KfBjC96XhpSURB/vs/z9XPlEDwBGm+I8u07/J1zMKYzEH4xyWnyBR+9Z4k9EWBMpleJ33hyHmTZ
 heh4gschctH5N60SDf0x7UUF2pCf6ePjdhwEPBYMGV8eEa9jfunf/uPU6cwmq1k93Ia777zOin2
 mX7iUEsWVXVAWhbvVTNX3VOe9qfVjcFmsOEEK8fav2/DBvdSXWvN7K/YjfDtnMttRuC8tQwULTc
 inaZ13oBkNws6heHLbm
X-Authority-Info-Out: v=2.4 cv=Ip4Tsb/g c=1 sm=1 tr=0 ts=69790408
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=emIkxkYSJqCgyAM8kcYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: edtKmxvSa9X9PZ5F668JCCAxMvzE16Be
X-Proofpoint-ORIG-GUID: edtKmxvSa9X9PZ5F668JCCAxMvzE16Be
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1030 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601270150
X-JNJ: AAAAAAABWVYCEWy7fbN/QDJ/JhOQOcmKy0QedLKHq4pHCCousYj5p6drEqu5hMEDmbRCdwKh0aLuBdixw5MvZzUBfwAuZ1gEnacjrVScdl+IiGC1aRW2ib8wITxRdqQir9v9RadyFfk5h+eeshODTre/WWBjH/JD5TP2/p5sJVzdfoDQTP30UB3g8scQEEMmljwdZQb66JNFZl31/s4W+TkmtXDboodN09R9RxJlpR09lSfFXQ5AFM4lwmj69LdAbjJWlw+58MsuZnFDPiXffQLuU2iKrJ2eO6pcPnPtoX6uWzg65/KU1Ft9srk9foicGNF7VnOG/gpIOvShlE6d+K88J2YT6gU+aOgvUdbndqnPzSIiT1M/80qKJG4qPK/0WqqOsmO+DqTASFX7TcsPdNkgayRTlf7eRgnqCWqtVWzHKbguJZQviPPjWdU8PJ9aldREWzsOlBrA4eTqM0lowCFezEiGadmhXa565UzdsYcKMBTMH9mjnh4pttctc73XcYPspovkoqWSAfdM0HisAxHZ3tdmVk0Yn5o/nwRmCIRH93/Be320De1ZyuBpLkWsbzE5XJ5x7xhLPxLEn1WtN2b9gLNOi3fLRchGXw89Ap5Z42i6D3A11erFttS7BNoAmAF8l1hzksygHq1iLocT+bH/8WaiBhl50oBxRPTEmobxWbviZhF1Zkvh6tx8uL3DwQbifcAco1uXePlRUc6+Y7HL5ouE1yfeLOE9vrn/ptFldcFmitKgWDCavDPszChBtAxw2/arNKf+tGobxM4/ycTWVmFEuMrfd70vcAtZ6ql5eUAhouaXmR9TIZzayDrkKDet9t+zx+MF8vuU4550LLKmPR073oh6sCHgnpYfm7Yzb271qfur03lnUuxOokRE21PA9GAEWAHoCMQxCoC6eaYC05V8MFVTgcQUaRCiZYOwHkHdMmmGYvmepU2W3uR0JfORYJ7e0uF/sYTi2V4Wgg==
Received-SPF: pass client-ip=57.103.71.14;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6e1cbf3d61..7bfc3ecd2e 100644
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
@@ -1143,6 +1144,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled() || hvf_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
+    } else if (whpx_enabled()) {
+        cpu->psci_version = QEMU_PSCI_VERSION_1_3;
     }
 }
 
-- 
2.50.1 (Apple Git-155)


