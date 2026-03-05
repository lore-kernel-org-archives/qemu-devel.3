Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788E6F47CD4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFg6-0006ZE-Ma; Thu, 05 Mar 2026 15:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg2-0006Y7-Ak
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:10 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg0-00066J-JK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:10 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-8cb40277a8bso887014985a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772743927; x=1773348727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4SC8zI77LVYBtxxNYz99rDPWHlviBrZcRQFsEBhS3Q=;
 b=t6dgy+onl2qAM1afPsYRd4JG/vIgeNDbncYWSacCVDFw5xLY5nXqAwXga9fFyK5F5n
 ftL3JxqlC9wHhRYupo4i7E+EWq+OncmBe70fFc4UdrnewGhx/Via7awJte8qHkhOkIjB
 I5SPBnTxp9ZbWwn1+Z7DbHWzgQA+AX4ZiGYiC25NBRSYH6x1yAVwqHeY3OIIb1kMYjXK
 iUf+FQpgS1Cl1c85FaoaPD21J+Sf8NuCWolVr+u5b3VfO2nfyO2r2GSWysH16+tdkQpS
 vN6oi4CUk/xj6Lldx2OTIZcHwqzfzhLNq6e/L9/JW/RX7i8XZ7fW3nx9f8CoPTzPinqE
 VovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772743927; x=1773348727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d4SC8zI77LVYBtxxNYz99rDPWHlviBrZcRQFsEBhS3Q=;
 b=hnZsalnQgqoBYnZN9kHwuk3VTe8tThnBVGPIEeMbGFbVi6kzseCqzMW+zph1l4BOZ4
 7L6XR72F2J/oEL9koIlYt43IFePeHu3aHd3NlRVxFZ0a3tHfYzrcj3TX35Ykaqsi92ug
 fNjN3TLQnOjqChZPXlwOekJHzq+OUZ4FMfobjQeU1kgORD7o+yortucxGB6JhhGRQPwF
 y2Rt8WaNgkbhY68460CObgzhdnLNeqXvXLkDy9xsSvM79dqym7R4tzku5fSPFyHzfDVi
 zLTauYRvlaCZp6VQb2av3pp4g2gEN5x/CBRYAMUEtcctKkracVCQrRW1gQ9faz+3saDt
 0yLw==
X-Gm-Message-State: AOJu0Yy9vleezBmNcYCwnlVPKYuxVusRAW8qW/J5NqhOhGICQbQiP8Sj
 CzQTfz3lN3vICOSSTq1XYZbLt8meA59rn/cYnNY3l6neWBTy7zTL1zNsJppTtMVB7XspRkUZTM2
 CX3w5
X-Gm-Gg: ATEYQzzTPgp+fMhckBF73mTDnXSPNpqpFlMh0cq7gP5wkZlt5RJ1aJLiwZlWTipcIhi
 lFtMwzWq788Qe8kIrTPrQ3W7ymZRVei3xsH9dmHJtVNLFJwkpVwveIkn9xKLWubONrVv7vB7Q05
 sSWESxZpF0sfneEjnhL8X4LeP+MBy8yc7u9HRy5uHJaMyGnFRLGuzEK9TVydOKTMuPO+ImMbm/1
 eTlzPkssxsLy7QeNoEyWGooG27lc1QJnNzYRrCkpTGxi2/n+PuAhKWr00ydi/xl1sBWzbeBftaI
 6beeLQkFUyVa/zu5/6cKftBshx4oEdmCorO/t07M1zevAd8k0qFRWDP6gHM9nDzZxBzXghZXdMb
 lHVMlArra01ppbLfiRyA70JArjQOyXadcsRjGhKsYFnaOtgRu/+FaYCX8ZMuuRfLgXfkltitGlB
 wdCA0F0XYtEo0aOcOA1aSwJd7HybIn0mSD2YIFOcxIri+QN2Qk5CwHiXCjr2cnY+/xS+vhzB3EJ
 7gW
X-Received: by 2002:a05:620a:4102:b0:8cb:9975:cba8 with SMTP id
 af79cd13be357-8cd6b029bf3mr191898385a.62.1772743927082; 
 Thu, 05 Mar 2026 12:52:07 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0e31b035sm65559396d6.17.2026.03.05.12.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:52:06 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 04/12] plugins: add PC diversion API function
Date: Thu,  5 Mar 2026 12:51:44 -0800
Message-ID: <20260305205152.2121854-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
References: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x733.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Florian Hofhammer <florian.hofhammer@epfl.ch>

This patch adds a plugin API function that allows diverting the program
counter during execution. A potential use case for this functionality is
to skip over parts of the code, e.g., by hooking into a specific
instruction and setting the PC to the next instruction in the callback.

Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
Link: https://lore.kernel.org/qemu-devel/20260305-setpc-v5-v7-4-4c3adba52403@epfl.ch
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/plugins/qemu-plugin.h  | 13 +++++++++++++
 plugins/api.c                  | 11 +++++++++++
 scripts/qemu-plugin-symbols.py |  9 +++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index a6ec8e275d8..7b9cd6a9717 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -76,6 +76,7 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 6:
  * - changed return value of qemu_plugin_{read,write}_register from int to bool
+ * - added qemu_plugin_set_pc
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
@@ -1042,6 +1043,18 @@ QEMU_PLUGIN_API
 bool qemu_plugin_write_register(struct qemu_plugin_register *handle,
                                 GByteArray *buf);
 
+/**
+ * qemu_plugin_set_pc() - set the program counter for the current vCPU
+ *
+ * @vaddr: the new virtual (guest) address for the program counter
+ *
+ * This function sets the program counter for the current vCPU to @vaddr and
+ * resumes execution at that address. This function does not return.
+ */
+QEMU_PLUGIN_API
+__attribute__((__noreturn__))
+void qemu_plugin_set_pc(uint64_t vaddr);
+
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
  *
diff --git a/plugins/api.c b/plugins/api.c
index 32eb086300d..23c291f6444 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -41,6 +41,7 @@
 #include "qemu/log.h"
 #include "system/memory.h"
 #include "tcg/tcg.h"
+#include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
@@ -467,6 +468,16 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
     return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
 }
 
+void qemu_plugin_set_pc(uint64_t vaddr)
+{
+    g_assert(current_cpu);
+
+    g_assert(qemu_plugin_get_cb_flags() == QEMU_PLUGIN_CB_RW_REGS_PC);
+
+    cpu_set_pc(current_cpu, vaddr);
+    cpu_loop_exit(current_cpu);
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
diff --git a/scripts/qemu-plugin-symbols.py b/scripts/qemu-plugin-symbols.py
index 69644979c19..ce99796ce2a 100644
--- a/scripts/qemu-plugin-symbols.py
+++ b/scripts/qemu-plugin-symbols.py
@@ -20,9 +20,14 @@ def extract_symbols(plugin_header):
     # Remove QEMU_PLUGIN_API macro definition.
     content = content.replace('#define QEMU_PLUGIN_API', '')
     expected = content.count('QEMU_PLUGIN_API')
-    # Find last word between QEMU_PLUGIN_API and (, matching on several lines.
+    # Find last word between QEMU_PLUGIN_API and ( to get the function name,
+    # matching on several lines. Discard attributes, if any.
     # We use *? non-greedy quantifier.
-    syms = re.findall(r'QEMU_PLUGIN_API.*?(\w+)\s*\(', content, re.DOTALL)
+    syms = re.findall(
+        r'QEMU_PLUGIN_API\s+(?:__attribute__\(\(\S+\)\))?.*?(\w+)\s*\(',
+        content,
+        re.DOTALL,
+    )
     syms.sort()
     # Ensure we found as many symbols as API markers.
     assert len(syms) == expected
-- 
2.47.3


