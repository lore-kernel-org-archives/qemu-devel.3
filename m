Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC948C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylHM-0002qe-3C; Tue, 25 Aug 2026 03:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylHJ-0002ZU-39; Tue, 25 Aug 2026 03:09:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylHH-0006H9-6A; Tue, 25 Aug 2026 03:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=rbu2vL/fF+DyfC6Wec7TxjKGDNnEQ1sNZUklNT7j2rY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tEzQ32U9HB5GZ+DuLpYqKtvr7Vx1Ygs9lv82nkExJsjqY2AYAsWUeFOTM98Z86iau
 0EiTY1Fv9yj8p080JyBegjVFlqarYTHAzMduQ9gsL6XXpVPWmVH34LD9PLC/Ar+fTE
 jnb7tUT7XnxuMlJqRctpE8v+RzDZDZMtlrGUglDrSAwRLXd86kFeiCavo7cZqk5L3i
 keppiaoViHft+QQ0QQAKU7YX1q8L3G0WbiG3IHWc+F5czdg/9da7rJYS7FtZl9clkT
 RMX+9kAkWuLuMtDDUZU0DzLWXOIkB4jOltDzuzynWfmDqAZMVW06ppmWixI1qqubZ+
 w7X0MzajILHfA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 617341CE227;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 26256415FA2;
 Tue, 25 Aug 2026 10:07:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A94113242E; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 66/91] whpx: i386: synchronise PAT too
Date: Tue, 25 Aug 2026 10:05:38 +0300
Message-ID: <20260825070619.174584-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

https://github.com/cmspam/winq-emu hints that this might be wanted for
some use-cases and it's a step towards full state sync:

> Linux uses PAT to mark virtio-gpu / Venus shared memory as
> Write-Combining. Previously the partition's PAT was not
> synchronised with the guest, so the guest's MTRR/PAT cache-type
> computation could fall back to UC for memory that should be WC.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260812082814.27217-5-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 7b0516912e44e73ba0859e91aed848d5be26f05e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 1800ba8eb19..2739a80da36 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -115,7 +115,7 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
 #ifdef TARGET_X86_64
     WHvX64RegisterKernelGsBase,
 #endif
-    /* WHvX64RegisterPat, */
+    WHvX64RegisterPat,
     WHvX64RegisterSysenterCs,
     WHvX64RegisterSysenterEip,
     WHvX64RegisterSysenterEsp,
@@ -624,9 +624,8 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         assert(whpx_register_names[idx] == WHvX64RegisterKernelGsBase);
         vcxt.values[idx++].Reg64 = env->kernelgsbase;
 #endif
-
-        /* WHvX64RegisterPat - Skipped */
-
+        assert(whpx_register_names[idx] == WHvX64RegisterPat);
+        vcxt.values[idx++].Reg64 = env->pat;
         assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
         vcxt.values[idx++].Reg64 = env->sysenter_cs;
         assert(whpx_register_names[idx] == WHvX64RegisterSysenterEip);
@@ -962,9 +961,8 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     assert(whpx_register_names[idx] == WHvX64RegisterKernelGsBase);
     env->kernelgsbase = vcxt.values[idx++].Reg64;
 #endif
-
-    /* WHvX64RegisterPat - Skipped */
-
+    assert(whpx_register_names[idx] == WHvX64RegisterPat);
+    env->pat = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
     env->sysenter_cs = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterSysenterEip);
-- 
2.47.3


