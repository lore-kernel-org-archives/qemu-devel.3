Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136E5C87FCD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 08:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufDtl-0006Io-OM; Fri, 25 Jul 2025 04:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufDtV-0005wS-8P
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:35:10 -0400
Received: from p-west3-cluster2-host8-snip4-2.eps.apple.com ([57.103.74.35]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufDtT-0003TA-FH
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:35:08 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-2 (Postfix) with ESMTPS id
 E90501800303; Fri, 25 Jul 2025 08:35:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=cEp+5SNb7OEsXQ14HiaE7C8WyWAj0nHhP97faFYP8HQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=M4KvO3Y5WdrUDnOAo5zcRP0j9CGl+2SG8P4MYLV3GG20xK61Q/BKh60P+HELQLT/7G0KSzOLFTrxWEFa2DOx76iXIDx+20ZwolOtqao0/F6u0/QA0yaYXPd+a/nxszIivKgC4uiOoZp9Dn2VS4eGRrGzcr+f9f4Kni6ZlziEiYMT+Vkf6rDyiiGMFc0Kys34lD3AqfL1MErlI16sni0V5i6Ftqq47aPEc9sFMLvigUAoAmnkGKgwkS4NXgkKY1RrQwnz/6AcS6NXiTbSnQFF9wvcUeXqIcJ0foFxdAa5y8tnlcMMWqhGB7eGL6bwCFFA6xCRJjIx9dYZ9aZw5HiI/w==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (ms-asmtp-me-k8s.p00.prod.me.com
 [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-2 (Postfix) with ESMTPSA id
 33E7C1800094; Fri, 25 Jul 2025 08:35:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 9/9] target/arm: hvf: use LOG_UNIMP for
 CNTP_CVAL_EL0/SYSREG_CNTP_CTL_EL0
Date: Fri, 25 Jul 2025 10:34:31 +0200
Message-Id: <20250725083431.91450-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725083431.91450-1-mohamed@unpredictable.fr>
References: <20250725083431.91450-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bolRX9Jkd-65ju6gEr8XFbV6I1Dwhx_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3MiBTYWx0ZWRfXy2X+KQ8GVntm
 fckf2EpbTjhMCST4JLlzZKEdfK4c5VJDI/2jC9GV04XiiMoXo28Pd2rYwdEkiSp0SYEIkb7rEhP
 cMjFGfMx1Y+JY2gIHS3TZqPV6A0Wbvl5K4e98iRDDOQEEPoNLjY3dVu0UcafNWiVUzXQIog0LQZ
 +qj+5VHwpwDHyzvgcBw9WHD91j9xivmG+nCXscZMFcs2bI+8AzwdWZ4mn5CxsLaR2UjLsxbLDZ+
 LfVtdQ5RyWdS4TY9h4g+n+qZV8tmyU0BfBWToJz+xtz0JxkBqzZzwSZoW7p+Gtu+xJMHtJvFU=
X-Proofpoint-ORIG-GUID: bolRX9Jkd-65ju6gEr8XFbV6I1Dwhx_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 clxscore=1030 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=618 spamscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507250072
Received-SPF: pass client-ip=57.103.74.35;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


