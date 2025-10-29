Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2771CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA5X-0003bN-G7; Wed, 29 Oct 2025 13:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5U-0003Z1-9l
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:56 -0400
Received: from p-east2-cluster1-host1-snip4-7.eps.apple.com ([57.103.76.30]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5E-0003KO-Ro
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:55 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 1E1A11800339; Wed, 29 Oct 2025 17:35:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=zNv66cYWOjcoM4iD8mPZ0d3N5D4+2q07Wwy2NtrQNPs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Sd627H1z6/EVY8ZIzWRmzrX2z6DKO848m3l8jvYquTghaXKRipBA0M790pnQfQxqETKQ1tn09awwkfRxp5lSDAAzrhN1CMpcDKV8Zld9SgXcODiFfmzeAR8zwiNf8xaFD/igdfPI3OqawlOYcb8seU12cqvhjL8bmc8W8fIF4NRAHddjG/PIcByPaQ3bcPo9HnhrBU69Mqw6X3ysLBHVLnsssf+NS70fbNnBX5fCBpfcYeo9acTgXPGjkpZbvqzeRS06VrB+/CuZjR73FVNrwgZUIzr3a4aM9VccFopNad/u3k6TEAuCMLDJtkiaPGfYN0qh67FZTIJaNvNew8KYKQ==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 44496184693B; Wed, 29 Oct 2025 16:55:32 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v10 09/28] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Wed, 29 Oct 2025 17:54:51 +0100
Message-ID: <20251029165510.45824-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX0AKDS7xy1BSL
 nwMzUk3HCkhA4GR6wIfZxVD/zqG9pJjZgHMSohYIKL2e2ZiLteLogwvL/wwuUsZJYrVxa3yCnZb
 EVH7VpNaPtgEQMfkh3/QVcdjixYuAE7H8NiSuVaJmQ0rs42MeIRXn95xLru2FYJzyUB/UtTkm/X
 eqx1wMybdQXbz5p3suSM4ENXbsUWVNEfkNwJz5yMoJAjRwZtOavjTQO2uqSjjjTLOHP8sQ8Fglq
 irP2ElC1B1SQYpU8vF/yybiIwmafSEAVK616TtkyIziNuswF4uXO/VeYIWTswsPvKSx+Uek68=
X-Proofpoint-ORIG-GUID: SFysRDlZm7-icfbEARPK_IHz7sLy92qL
X-Proofpoint-GUID: SFysRDlZm7-icfbEARPK_IHz7sLy92qL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 clxscore=1030 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0
 mlxlogscore=853 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAAB+jQ8o1t2AZTAebtGvkUN5Y5zRkdXn+9Kfe3swu+d39kKbEs/Vl0gI8ZUU70qJSa6zrWG/KEMiJPZ0ahK8YVMo8FuUeGHmdQHsK5QHMZjSbfnhv/Jm6pyZ4qNV9vcQRNdVFBLa68a98Zajy4KbFg8rsoTVnKdvcvWRYvBCZxRcuL3zzRY4t5vVK0NL9wbdy6aGxgAjK7eJhs1wnr28xChDez4cfeaB78kV93wjmppB+CrPKn7b8lEHvJPIBnp+MllWtZRHIcHGgixgnH0YM6pA90YSxBnApZ47rJkZdWrYRX+lx5UAqRZeAsfRSt3bfiqux4zmqLtLBJmi/936LyydQFgjFy9QEatwEh/5xqQkS9l9pPF177SW+mOepQqZuO+5Nvl5nL70oB+I5RHMvTArMJMnWe1zLBtp87+ISoq2FnnqvJ+UMhuUt5r1ZbFepF0HF53F+g0eoJDS9ykOZFZHtXEje2O4fa8m8p4zBvll5+BxAfMD8HJ9/gcD00cpH5RmiH4ClIhOouKyyF+Vved9nyGRUbCqWdfIrOxYYkx4MB+fxFaVol8lAXhw9WuleNcdrEaEsSoYTf3KjrNUjzhIpu2Wp5Rr+jLD7rmgB6JcaMJ4szP2SEtgwo+ZO66Ki+FHvlXSOSnPJhYmuF3O+S5SKOQcSvrupHY/MNTCeyS5yKBw0/wxCqtIa3LDO+grWffGKq+vD3Ui7kLqi7C4Kx+6Hk8Wt90v3JVsz1YotwE0EdZNq5kR2gwVTkgwpcurhsYBFetFqYm145OJf3KVyZOxOQiabNofBdE2UbfMS+R
Received-SPF: pass client-ip=57.103.76.30;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


