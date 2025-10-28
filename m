Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58010CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtR7-0001zq-Jc; Tue, 28 Oct 2025 19:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtR5-0001yx-Tp
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:08 -0400
Received: from p-east1-cluster5-host4-snip4-10.eps.apple.com ([57.103.89.171]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQj-0004lv-5o
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:07 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 E56D118034C8; Tue, 28 Oct 2025 23:48:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=zNv66cYWOjcoM4iD8mPZ0d3N5D4+2q07Wwy2NtrQNPs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=aQKX8HlxuiAM6SQlWVk3dzgxCxj49N3v30EptfPMIOmOKcQRpuxk24NpMoY6TZ2z9SdHreztOWCzwHbDczvragSwxBu7zr3EdaB3ZUEj6rTwwu0yGHJGMo0KF4JDcn6sxLE5WOTsV5A8eZm2jx8W4cLTL6tyMyxve2V1zq0w80UMo4PSiOKurJnfpR9Mu2qol7xu+bJ1G4I8/nBYMg3lO5EDHWkscMI0KW0AIygGCQmznP0PKZi6Yok+Z7XeY7Tlzp2drQAHdKWlYY01XErF44G79oIgWuFOmSFqj5Z2xerJMc4wnky/X/cet9LiTEFGokAixCvK96GN+oMUEYiLEw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 ABF9518034D6; Tue, 28 Oct 2025 23:48:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 09/27] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Wed, 29 Oct 2025 00:47:39 +0100
Message-ID: <20251028234757.39609-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9YRC5qeC_QC401wNuq1_yCpdXYOKgHe1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfXxZLBDPlFEhqw
 Ct00Cqim3xmOcbBIkvWAAqWrcqQ/gdkmWnH1+JsJLZ4NAmZ6TK7+23m1W9PfSmtdaCe9scO5cFg
 zlyxoz7slz8XCcuNMn0YKjN2PB4E6Iz32AYBftvPaCz+H+DyqqyrqhUPIRWpJNZCSrxXHq+WxYW
 mwD+g5KlNHzJSrHhRrAv89b9fccq4r4nH6A1Zfgwifno/e0JNFPwiQRl8X3w64hL2Iu5sHsf9lQ
 iHTnj6JIm+WkFjoLY+BXGwjGv7tj9UG/90CnbrI8E7lXnALbcSN3ih9ht/NPE/zZSSE9BHoZ8=
X-Proofpoint-ORIG-GUID: 9YRC5qeC_QC401wNuq1_yCpdXYOKgHe1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=988
 mlxscore=0 adultscore=0 spamscore=0 clxscore=1030
 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABPaJ408jAepxkUz0uKq2fKuPc2Kae1aO65/6oocTdQXB1F/sYKS/4dl+4X0JkvCrZOY5K0Mx+gFQAoJctKYMEiBpr4L0D+6isnO+MreAZucHw8lGhYR6EW4OCwyw6RgwQkGXIo73jG8rK3kYhcMn2xhQPqPE787Kx6qUpX3MkRG+GypfNycn84I1VLhfPPSDCpKnJwSRuxPuz+bumS144zw7tlC0DlG4f80nX6EYXo/I+/YzTWpCuCrbdI/e2PQfKzO6XUff2lJfZZbGLCD7Vszs2MHNRTEVHvOLGNiUWWupG7vJbp4JIJnP83EIpMGzaBsMoa+HNGBbxseLBI4pIqZE65Q2UyB46mxjIzRTfKMOEnHWT/Fu1iZ6ovkUGW3rGjzP4gmF2m4PLHf+f20JjDsUQMbvfQpn5XE+FsqToI8SbQvvVxRgIKb6Ngn2HSrwKiH2/nBPWLgIP3rGkOEG/vZH3QY8dPGesf+M7rno5T5KzD4waf5DaoBNWTar67cIpUlO+56v3OrfjHFOTFZqw0/UhcPeohVc9SmJyfVqRRy07BBEgvuPa4KPMK/vV9R5xCW8byww35yCTlFPA0cj+Q6GzvcDOCMrqcqpMuUL3SDEyopIvhMYGXn982GZohstfcUJvsGFnLcpn8ZT3NUCfU2l3EnvDaeFdkArKr5FcyKG9/akiLjlpBxOVvQ/GdeZeHaTT3jqzhSPTLFvznMd+lqBBmB0GHuaJoCWLzOzTjqALiO7D6qIDVFI=
Received-SPF: pass client-ip=57.103.89.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 95664a1df7..c0ff6cacb8 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -123,7 +123,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 7a7c607e0a..73b9f7c119 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.50.1 (Apple Git-155)


