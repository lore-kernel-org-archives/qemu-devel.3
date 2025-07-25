Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27350C87FCD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 08:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEE8-0008Ft-OQ; Fri, 25 Jul 2025 04:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufEE6-0008BY-Tk
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:56:26 -0400
Received: from p-west3-cluster4-host8-snip4-10.eps.apple.com ([57.103.74.151]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufEE4-0001zi-Sj
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:56:26 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPS id
 F155D18000B9; Fri, 25 Jul 2025 08:56:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=cEp+5SNb7OEsXQ14HiaE7C8WyWAj0nHhP97faFYP8HQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=R6FolhBaKLBHM1enNnEqsuJJ3btS/AhcQH41TAg18+GyVnfLBT1XSPzBaJwXcaJGWpO+GFEJ8OBX34mxuh22JpAlilgMHjeIQ2x/e7nl1/+3NHUmcrCXUXgBwmQPcwauyKehbGE1CxqyKmdNtigcLQBwrpPjk/W+DTADqhypNkeSHU9kgqzT70u8zcsAp7g0zTa4ozydnBpbj0aSWRwO0lFvYHHjjAe0nfZcCFsjz39G4B/0KXfWQJo7Nzf0Q63ycnljPlc5Ss7troeebyOuKDZjrID+hLqIdPwpwCLaD2HGNhAMuPFKbDATbMWwqHPsc5yAjSvQZJsf8P8+zhCdsA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (ms-asmtp-me-k8s.p00.prod.me.com
 [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPSA id
 314EC180022E; Fri, 25 Jul 2025 08:56:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 9/9] target/arm: hvf: use LOG_UNIMP for
 CNTP_CVAL_EL0/SYSREG_CNTP_CTL_EL0
Date: Fri, 25 Jul 2025 10:55:45 +0200
Message-Id: <20250725085545.93619-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725085545.93619-1-mohamed@unpredictable.fr>
References: <20250725085545.93619-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: blxyJ5mnHc4Vk5y2YgNK1RkpbSTs4ruQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3NSBTYWx0ZWRfXzBS+XVbc3L1J
 3J8iZLdF7TTzpvmLc8eDS8bXpSI+H4k9JvZhVZvzYsXo49Ky30hcQj+yHvFFIXrIGPPCZ4hZX2O
 2lo6bgGYonWGsd7mikLF0tLApHZggZrt2eL8fTA80EcO2xZ4BW+ABqrAxh6wB0rpkXV4M29US8h
 HZQvuMaBpCffwAHmw9/u7mIsGWbkKS3dehNjV1XLzaeyWMEnImx/a2UH0/vNAwLDG7DC/hWE9tq
 pnwJYn0VTzscJedRcmFFphA1pI2XTZFbZGrl6TCC7sgZdAlusGJxOXCRVNq42PiRk+Nl5scLY=
X-Proofpoint-ORIG-GUID: blxyJ5mnHc4Vk5y2YgNK1RkpbSTs4ruQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=618 phishscore=0 spamscore=0 malwarescore=0 clxscore=1030
 bulkscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250075
Received-SPF: pass client-ip=57.103.74.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Instead of considering reads there to be fatal, mark it as unimplemented.

This is to allow experimentation on using configurations other than the Apple vGIC.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5344e23db1..d01b9b4dcd 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -300,6 +300,7 @@ void hvf_arm_init_debug(void)
 /* EL2 registers */
 #define SYSREG_CNTHCTL_EL2    SYSREG(3, 4, 14, 1, 0)
 #define SYSREG_MDCCINT_EL1    SYSREG(2, 0, 0, 2, 0)
+#define SYSREG_CNTP_CVAL_EL0   SYSREG(3, 3, 14, 2, 2)
 
 #define WFX_IS_WFE (1 << 0)
 
@@ -1396,6 +1397,12 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_CNTHCTL_EL2:
         assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
         return 0;
+    case SYSREG_CNTP_CTL_EL0:
+        qemu_log_mask(LOG_UNIMP, "Unsupported read from CNTP_CTL_EL0\n");
+        return 0;
+    case SYSREG_CNTP_CVAL_EL0:
+        qemu_log_mask(LOG_UNIMP, "Unsupported read from CNTP_CVAL_EL0\n");
+        return 0;
     case SYSREG_MDCCINT_EL1:
         assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
         return 0;
@@ -1712,6 +1719,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
          */
         qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CTL_EL0\n");
         return 0;
+    case SYSREG_CNTP_CVAL_EL0:
+        qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CVAL_EL0\n");
+        return 0;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
-- 
2.39.5 (Apple Git-154)


