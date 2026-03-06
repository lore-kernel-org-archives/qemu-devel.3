Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6E8FCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXqL-0004Kz-AZ; Fri, 06 Mar 2026 11:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXqI-0004JY-9X
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:58 -0500
Received: from p-west3-cluster3-host8-snip4-8.eps.apple.com ([57.103.72.209]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXqG-0007Cx-II
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:58 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 25E3B18007BD; Fri,  6 Mar 2026 16:15:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813755; x=1775405755;
 bh=d2eYFvkazVi+pdiwcmm5jeFsF+hENCAavYE5AM82wmE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=cde+nM0kxCt/APSIaiSwgWiEptTMBN172nREvuq3BUejT10/enqJWJ7Gf7OLaJDUs5hY2wZAf9/oUXju8/3J988Mpoovd+XQvYc+aKvIVDV7s3wHSjudJdRWP1i2XWqpZM4jdW3X0YXsB/fyZFghOE4z5v1J/s6V9e7ZEncsz1VpFuLG4NIJTX7UHXxzhUl9Am+XSe53Mb7Yumovzy1V4PtwJI56pMAdMgkJ851ak17akTSLFtDC0PbjGoZZLc7b0+EiIR1pv6OM8Snv60qUdgowheZXxpjyqXDcSAjaTdzpJlTAc1vfX4e322X8JuD44ga+BTeX9P+zXaGGZXShJQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 50CE018007B4; Fri,  6 Mar 2026 16:15:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v16 15/17] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Fri,  6 Mar 2026 17:15:07 +0100
Message-ID: <20260306161509.79712-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306161509.79712-1-mohamed@unpredictable.fr>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=aZhsXBot c=1 sm=1 tr=0 ts=69aafdbb
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=L1bH-B2CdzmaWMF7168A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: lNNrm7DquGQhVGQcgPhpRazsVfYDlfgQ
X-Proofpoint-ORIG-GUID: lNNrm7DquGQhVGQcgPhpRazsVfYDlfgQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfXySCGlVaYc4vE
 +CaI7hgH1Go5JnnR5F7Qb3uCxTDeAjG6A7V6sXG8MUg+Ycq1RQ5tD6aorahw9CtWO/XtWmGW1wu
 hpdRNGRacmCEBF6hbM8N5LOOcvxRL/v7uRH1q2AQCCXOV/Nj2uUpI0sAed0qI1otGpB5ghgibUa
 ZKNjZnbRv+P9HKFh0F17rCM+4PvFhMX9u1C0ovPAO2COSy96U/DMZeUtLWW8+dMh3YfD2XCs+7C
 xL4WuHztoqToFZY2e2bB6pO3a8fBIGqpbntZgVcIPbyObbbv2zz1T90CU5QWj/I7jmAxKsxKZyN
 iZBWn+v64ctDc1N0Ce6czOaStrmOOSO0N1P+S6pn7Hsw9HaoCr7DYtfWrXFfM8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=648 phishscore=0
 suspectscore=0 malwarescore=0 clxscore=1030 bulkscore=0 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603060154
X-JNJ: AAAAAAABaFTlSBvAWulahyuKzm/ClmBTmIcp74uGyAX0TlvLvpHUWmv7aWPm9uxxXvRNclRuvb78uVKuHlB+H8LWIXpG6S2DnLTJ88GT7G88ZPDRSpZEAv58sVyzF1fiagWLQ9TGsg+PdkxlAkGKkdt1OVYnkMXAlJBooyazVf7hDw89NFCHXv6pakrM5OwdyhvAJ6+oqcyYE5HemOEwdXOWOBzazhcWxcZ7CmQRcfPNgNK8lAKFDi43+gLDrFcHSblKdN9tPSpXice3obs5IEJkB4nYSa1Trx+3N4xrwSthyNx3IS15iX0lfwTDbb9tjTaTgDGx6mtIFSttYY3z/Fspc3fDKtVt4auic56yqRRiF4UzzTXToOrsdTGylK+uOpUSBuM/XnUuy14dpRdcfdDqtF4Ws9WAx0GR61t3fdYi/elZCnydOiLS0k4Zdk0u/YnaGJsKCdzVmaS/TLWfBYAnlmYFdj1zRehOceThKu2AE6ubDEmRbGtSpwKwxmvIyUJEbxegChRckjl4dRxqrh2v0rn2iJtpzmyS2Lp92Nr5X0oFxY2JCrp5xIXE0jriy5imjEbX51Xr3Rm5PhRiP0ySm/LU8j8Kz1R9mfk1EwoFX3P/gIWkrkCoax5jWG/gbLVyNRlerwUd+oWqiFJJSewejW5XuoffQqV2+LI2n0A+EAf5hPKXscOCfjY9zH0wvOAREioMkieRkkyyN+oFhRoJRusyizDnwysP8oM8OyJZ1kG0d+nJ2ZDfYL3GkuT0CNxj/oXWH2o0mCMkwU4D6sSQrlCpOmo=
Received-SPF: pass client-ip=57.103.72.209;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

HVF traps accesses to CNTHCTL_EL2. For nested guests, HVF traps accesses to MDCCINT_EL1.
Pass through those accesses to the Hypervisor.framework library.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index df82bdad6b..fd5d248e20 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -296,6 +296,10 @@ void hvf_arm_init_debug(void)
 #define SYSREG_DBGWVR15_EL1   SYSREG(2, 0, 0, 15, 6)
 #define SYSREG_DBGWCR15_EL1   SYSREG(2, 0, 0, 15, 7)
 
+/* EL2 registers */
+#define SYSREG_CNTHCTL_EL2    SYSREG(3, 4, 14, 1, 0)
+#define SYSREG_MDCCINT_EL1    SYSREG(2, 0, 0, 2, 0)
+
 #define WFX_IS_WFE (1 << 0)
 
 #define TMR_CTL_ENABLE  (1 << 0)
@@ -1701,6 +1705,14 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTHCTL_EL2:
+        if (__builtin_available(macOS 15.0, *)) {
+            assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
+        }
+        return 0;
+    case SYSREG_MDCCINT_EL1:
+        assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
@@ -1989,6 +2001,14 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTHCTL_EL2:
+        if (__builtin_available(macOS 15.0, *)) {
+            assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
+        }
+        return 0;
+    case SYSREG_MDCCINT_EL1:
+        assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
+        return 0;
     case SYSREG_LORC_EL1:
         /* Dummy register */
         return 0;
-- 
2.50.1 (Apple Git-155)


