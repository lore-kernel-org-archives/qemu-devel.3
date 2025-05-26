Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C82C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJWGT-0005o9-Kg; Mon, 26 May 2025 07:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uJWGJ-0005k8-Gx; Mon, 26 May 2025 07:45:00 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uJWGH-0004F7-2F; Mon, 26 May 2025 07:44:59 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 94DE744540;
 Mon, 26 May 2025 13:44:52 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net
Subject: [PATCH] target/i386/tcg/helper-tcg: fix file references in comments
Date: Mon, 26 May 2025 13:44:47 +0200
Message-Id: <20250526114447.1243840-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 32cad1ffb8 ("include: Rename sysemu/ -> system/") renamed
target/i386/tcg/sysemu => target/i386/tcg/system.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 target/i386/tcg/helper-tcg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 6b3f19855f..be011b06b7 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -97,7 +97,7 @@ static inline unsigned int compute_pf(uint8_t x)
 /* misc_helper.c */
 void cpu_load_eflags(CPUX86State *env, int eflags, int update_mask);
 
-/* sysemu/svm_helper.c */
+/* system/svm_helper.c */
 #ifndef CONFIG_USER_ONLY
 G_NORETURN void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code,
                            uint64_t exit_info_1, uintptr_t retaddr);
@@ -115,7 +115,7 @@ int exception_has_error_code(int intno);
 /* smm_helper.c */
 void do_smm_enter(X86CPU *cpu);
 
-/* sysemu/bpt_helper.c */
+/* system/bpt_helper.c */
 bool check_hw_breakpoints(CPUX86State *env, bool force_dr6_update);
 
 /*
-- 
2.39.5



