Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF149C4453B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 14:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYjq-0000Nd-1W; Wed, 21 Jan 2026 08:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjO-00005N-2W
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:52 -0500
Received: from p-west3-cluster6-host9-snip4-1.eps.apple.com ([57.103.75.84]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjL-0007Js-R4
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:45 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPS id
 EDA95180104F; Wed, 21 Jan 2026 13:58:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769003922; x=1771595922;
 bh=Qd6/75shv6/WpONnraus19LHiRydPggJM1rFQ1SSim8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=eIT3ocFbPUlQ/kERhUNKr77KPAAwa69tjoXSBkv16oqYbhihb2YcvXx8Spx82RBOSh0WvxWhXZBDCJLJFXSXGzG8i6QOZ+BPBs41y/fVU1NkkNSQWkq9uz5icRJnX2hdOgyW3kQ5Nalg0stDsnH7o/TFIu9UNjRNbx1EkwvyKrD7FweEO2VnW23vQjOahJwxKuesT4lST79nGIhJ6cLBnIJ9rmhO9H6riASq1CkyL6WuHATqMCLWRa/DQeSN8sOh14HahrBlQ/wo76jWbwaDM+ZAjORAfEMClpcD962Mkoukeyp5+W3GZnlKnNTtMnTi+ybMEsfXBWgoZ6D8rCENTQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPSA id
 8D9291801C48; Wed, 21 Jan 2026 13:58:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v8 09/11] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Wed, 21 Jan 2026 14:58:14 +0100
Message-ID: <20260121135816.21258-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121135816.21258-1-mohamed@unpredictable.fr>
References: <20260121135816.21258-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExOCBTYWx0ZWRfX7I52cBdg5Ddj
 PiMrUT5/fwVbk8yhPWgJIfQOSZ7V0RiW7qMJd8U+WhXWUfhYnSpcMzjRFUmBHbWrjpR2MP6PqDs
 NBEdHnmQHrj0rQOjFQ2AbS/MNjxUzIbc94WkJ0y34lqiKgclt53l2/S13UjpQN0+796VyAELINT
 YUz1XI3xYHsb+wz50ngAHLoEBM2qRCRiYEb5PAsLkyo13P+w3AehTrAh6KPwogUgiP50/UFL67y
 j6gl/X1h/WsXFE76x0htZl0Dc46Y6r4+ar46GXKqudW6RS+9qfvV/qyv8apVIIRK9myba8ZHGJi
 QOTYDiMnWpOqC1PvTy0
X-Proofpoint-ORIG-GUID: n5ijdTMHI549SsdSTDK4v0nQwr2qWUyn
X-Authority-Info-Out: v=2.4 cv=Ot1CCi/t c=1 sm=1 tr=0 ts=6970db92
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=vbFX7M0ab_H1AmF9bzsA:9
X-Proofpoint-GUID: n5ijdTMHI549SsdSTDK4v0nQwr2qWUyn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=482 phishscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601210118
X-JNJ: AAAAAAABYLxAET74CPWG1l0JK2i7kIWf4Ore/pIHhz9X8WMhaiaz09Jf37XYYfvZSofxcGcUTp2V/z2ToIUsyZRvjDTTyUvbAqGKX00KmduqLViFqNK3LC10v7hjEOkDZvVlHOiRMMg2ARY8Rfkas6Fduq3BS5PtdL6XH4G4PLsVB+eNJGr9s/ZVGkGdBAtiML3Ho2SM7XA/V4VairjdMSK4IP9QEHbuSEWRbJZg7kPTkg+9dnixZvJUcOloqdRU1OicxoclMUebZEjylgbL5eozCXhtRh07gRBKZH8B7bQpu8RO1WuoHXdm+sFkG+BQJWUdWGSOAEG4x3155MnjMWxcl11N4z0v8E06g+9Lzci+npIZW4cghwp6nZ4LO+4DUyUVMesLfSK+AR5m3XIw8pqSp0jsTvJhDj1Br/jk1Y9PTu9eY2Dk04TbVrGNm4dWFPNBYDJuLnCXcq57EZisT7MEy9T8cqf8LnbbLqpuARR8ahCCW/tbUz+RBoV9wBgGBhF4SuZAzajSP6GeCv4IAIF5UUba2DGix0fPyRZzAbkiU1k9E5ofuaH96U/mzUvCYCGGUobDDgoqpvcXk14i/++9gWTzhIXEGxXu04pQGMzatWpeJzg/scpHizEJgY8MqHhMkqjcdCW5By35prIsIB0Xt2RuJgVTpUKzjVQO/8VcxNY/eLmtS6918esnSnDxVO2bb/K1LxeS/g==
Received-SPF: pass client-ip=57.103.75.84;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When using the vGIC, timers are directly handled by the platform.
No vmexits ought to happen in that case. Abort if reaching those code paths.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0e7b8f3431..32662a35f0 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1335,6 +1335,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1656,6 +1657,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2063,6 +2065,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.50.1 (Apple Git-155)


