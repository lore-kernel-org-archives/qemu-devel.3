Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D79C636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnc-0000Ho-E6; Sun, 22 Feb 2026 13:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDna-0000CF-8m
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:18 -0500
Received: from qs-2007k-snip4-5.eps.apple.com ([57.103.84.236]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnY-0000W3-Ss
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:18 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 420981800516; Sun, 22 Feb 2026 18:03:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783396; x=1774375396;
 bh=YKGmjTwasOTKHJc2TN0N83W04DQ/70JvOkGojdqvAPY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=GXnGl0AtSpih9aMZsol0+rAb/UTG1YrmuBwraQd3C1THxvUujTd+f8UQ59GG/KGvuui9Lnyv4yMDLYfT2FbIJiaDcahtWsMC982bzbREFxCEr/6PBc81o8A4QPGs5Th5+RN6HuO1I6V5e4Kx6GB0/bXgZ9hSazA74QUKvYZpwgHWOCnL525WLMPglXihHr2iI+P4TE+c/mzTWmhd49FrA04xVSufXt+3l6vzCkbNcWXEZ5tY7L4g8dltnwpIa/VgHOFsCYUjqmk2tjj8bDjEhLrfvLdaUF4gpHcqlS3U0ojaOL8LoAA0Cf17X6ruGbRKOQEEyMuyBLBBcMknWKMZcw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 87BA118004FE; Sun, 22 Feb 2026 18:03:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v4 13/16] whpx: i386: remove messages
Date: Sun, 22 Feb 2026 19:02:37 +0100
Message-ID: <20260222180241.14621-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfX+qOqOCO1lObB
 hzVpEGiFekWT6hIWN9+A3qLm56jtNne2EKOhlyry9G1nbpsYbhodxKnxlL4psuQGQFMm4T1ZJXc
 9Z7+f817Woe2WRov5Sa9o+G8IXzl/ssYjOxESEB/iMGjjP8X0N51rZkGpg/AqLMR0grg8rNCakn
 qQKcA7AkcMa9iYJGFopSb0sCTB7vxGIN0jeexU74CtMKyc32bhldkazWaLFRgcpQTkI1w0pYIE4
 VRLTjk7qaI/w4EGlmJD4GAA5lMTCJpN+SmsgeRQPmZ4YSXR+DD6Qj7k6SGlAbUbT0KYXreqjnf0
 zapK0v445VsrEqmDpQ4XpLR+x8uHLmZsMfms5TZbVTHWob3hSF9L38m5c3CN8o=
X-Authority-Info-Out: v=2.4 cv=Lq2fC3dc c=1 sm=1 tr=0 ts=699b44e2
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=tHCKdM3VofH7q6B9RbgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: f_5bW3C0e8sJ19i-eTN_J81-zWgG8r-F
X-Proofpoint-GUID: f_5bW3C0e8sJ19i-eTN_J81-zWgG8r-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0
 clxscore=1030 lowpriorityscore=0 mlxlogscore=999 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABLABppNvYHGOD4W1mbDuZ14kSsL+hJ/dlMpJZeYEdPWg47Ve4RkOheQRIC9tbQi5VhXoiyzJKIZmH132grmNmFVuzsRB6l3oKuZ6JxNYlmtj3FNX6/f5jH9PuTX4PNk9hrekavH0Gaqax0u9NQFfk6fAwm1TOY8xc4itxclIGpbCcadCa3aP4RSDgQfv6lq0Spm40gmCO5x4bfQv2DCUH8wjK71SJhfRzv/p1SF+KIAr61/PYg91vwpGvuaBhav49l7PUHInl97QqNmJLsaMTobQ2K7e2vheP/cgVa676YU9RG2evS6zXhvouoB6F9lmQLwCEEnAuvtyYfDb2hv8o4xi+0NUN7yx3VHCzANPvSkEOrd8YvfUFTFveMZEEEv2pkf0H7qwB3Sa/A21pZ9/VfqEMK4FrPVaPCZlFeVM08UcNqnPPQGSs5O6d/Xz3c41MycDKrGj1a1kQXIVGmH3DkRMKiUo0teby0PlXBXKRXbDnFSGqhk45OSztIp/IwEyQ307ZExkrOzSx+0jdtF6kwPXGVlZ1H1nAX7UqD/RZQOC2CHrSkeEEB1rhbZFE19kMsfY6V4MqJChyEoftAOCyksJAKOeeXBX1r/il/bnyLffQIU+JcwG42Aw9hs7/GRAZMPOOrLT06tQmEWvHvAqcKogt8ni+2m7in4dTyk33jrcFwlHu17g4AwHcm/CESgLEmbRtyw3Qt1wBNMBhYZ3pG+WG10b3s/2xr4WP3zaKT9Wqv19aYJcZfCZCkKHqJc/e9o6N4jMhVGgGMR+kwyi5Iwq1pkTGmhNuMm/tXEY=
Received-SPF: pass client-ip=57.103.84.236;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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

Remove some messages printed by the WHPX backend that don't
have an equivalent elsewhere and don't convey an error.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0524885053..2f2c613eda 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2163,7 +2163,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
         WHV_X64_LOCAL_APIC_EMULATION_MODE mode =
             WHvX64LocalApicEmulationModeXApic;
-        printf("WHPX: setting APIC emulation mode in the hypervisor\n");
         hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
             WHvPartitionPropertyCodeLocalApicEmulationMode,
@@ -2237,7 +2236,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     whpx_memory_init();
     whpx_init_emu();
 
-    printf("Windows Hypervisor Platform accelerator is operational\n");
     return 0;
 
 error:
-- 
2.50.1 (Apple Git-155)


