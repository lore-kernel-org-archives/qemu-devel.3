Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CC6C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbu-000195-9D; Fri, 21 Feb 2025 09:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWt-0006W3-MP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:03 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWs-00015M-1m
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:03 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 176EE205367C; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 176EE205367C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126990;
 bh=tNGPiKMnv4PpzJ0l8l0eY3vzGPXS+PFwnhEpXOSgZos=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D2XkyGYf8SAXe5p2elN7gcw72qohFHbP2c7QIKaGxINMpSu3oUs3bQKbF7gZhu2xW
 sjEj9wwuDINi1xF5PmKYOMGLs8SYfgqSdlwFFNPutCxKOX/xW13S7eFrKHcfSnpgRc
 QcJ7630hqiYV1HL56R60S7gPMa08yQw0Qj0H1Lzw=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 16/19] target/i386/hvf: rename some include guards
Date: Fri, 21 Feb 2025 00:36:24 -0800
Message-Id: <1740126987-8483-17-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:01:04 -0500
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

These headers will be moved out to its own component.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/x86.h        | 4 ++--
 target/i386/hvf/x86_decode.h | 4 ++--
 target/i386/hvf/x86_flags.h  | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 063cd0b83e..73edccfba0 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -16,8 +16,8 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef HVF_X86_H
-#define HVF_X86_H
+#ifndef X86_EMU_DEFS_H
+#define X86_EMU_DEFS_H
 
 typedef struct x86_register {
     union {
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
index a2d7a2a27b..930d965164 100644
--- a/target/i386/hvf/x86_decode.h
+++ b/target/i386/hvf/x86_decode.h
@@ -15,8 +15,8 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef HVF_X86_DECODE_H
-#define HVF_X86_DECODE_H
+#ifndef X86_EMU_DECODE_H
+#define X86_EMU_DECODE_H
 
 #include "cpu.h"
 #include "x86.h"
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/hvf/x86_flags.h
index 75c2a7feab..6c175007b5 100644
--- a/target/i386/hvf/x86_flags.h
+++ b/target/i386/hvf/x86_flags.h
@@ -21,8 +21,8 @@
  * x86 eflags functions
  */
 
-#ifndef X86_FLAGS_H
-#define X86_FLAGS_H
+#ifndef X86_EMU_FLAGS_H
+#define X86_EMU_FLAGS_H
 
 #include "cpu.h"
 void lflags_to_rflags(CPUX86State *env);
@@ -78,4 +78,4 @@ void SET_FLAGS_OSZAPC_LOGIC16(CPUX86State *env, uint16_t v1, uint16_t v2,
 void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t v1, uint8_t v2,
                              uint8_t diff);
 
-#endif /* X86_FLAGS_H */
+#endif /* X86_EMU_FLAGS_H */
-- 
2.39.5 (Apple Git-154)


