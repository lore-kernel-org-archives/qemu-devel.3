Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475FFCCFA03
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwVi-0002Km-U0; Fri, 31 Oct 2025 17:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwVe-0002JP-3B
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:18:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwVY-00027z-KI
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:18:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-475d9de970eso18534245e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761945480; x=1762550280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vCOjpg0DOKIUCVHS8v6pFpe29I6DY9EE5LpTUoRlcOc=;
 b=Dvcxln/cKzkaAgCaAn3075idmupSFA5h/pWmxwyxFUvBViAS76b2Lqm/0qOlpcxsWY
 9cWKnnizqaZkgNV7ezK5dXnIiE+WrS2Y/Rxrc6fVjL/guZT9yxHOYS/ci/WxNnjfZPsS
 DGozuRJi00QfDGSGp/Heu/fHv/HqQK1CiKsK/RNP7pfFE1dIDPOkcAde/XVetoAeGQRQ
 Cm2Qv1GiRzkqEh8+Vd+Kcu4zvKWUaEUITOqOfjQ0DSCHMPAU3R64dxVGH4XtAeCl7QE5
 fGz+ugJju7jKrHpm0Fce0nYd1/hJBL8/dstkdXnfqJAbOT6q0nDQV08SjbqFifNQQhF1
 8bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945480; x=1762550280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCOjpg0DOKIUCVHS8v6pFpe29I6DY9EE5LpTUoRlcOc=;
 b=o/7M0FCYH/KjQM1IWX4rWbBoAAmhHZO7EKFbAVM1OXjD6trrCQn+oBaKmkkfuFaWFt
 dwEnafsnlM6Ir1NyWUOsyJWX9lUy3jCTGLVp10wnhbuCjoHq55m/+zfnqNFUUXIUNs9U
 ED/cWVTr7uR7f+dCO3VP6JB4RQHDgW95MPZwE0MzmYGU2zKZHIIXkc52G4KNS8IjW+ja
 j+4o6s0Th18fxU2fqV8G3TOxvyPYv2BMc9nWkyPUFf7SgyLZmJTfSA7/Qv3EneXmH/zo
 UmwPffFaVUi5IIM3igco6Hs/RfZeaKpmlJYkVyh0k9+bR84lp3T7+4SOsSIsVaxomwZ3
 R8Sw==
X-Gm-Message-State: AOJu0YzakL3msrE6AguU25zUXkMKJirPas3yvsN+vOH2Z+9I9tf76thU
 7gfhq81CtizpXvdYxhHzqXer9r7UFwFsnctpn2kvdpKyXCR9izLlm3Yy1CNkoCW1SxyUHsP/G5p
 PmBvGXuz2PQ==
X-Gm-Gg: ASbGncuS8O3sD3Ags3/oKusYGffMzNCAz5YNZfuTJkP0dHV5wMgYjW4rFWkJJDCf7YP
 bYZqJwDIYRj+bXUKK17/j1SSwI5VJOppCAmL/d5/cMFhYYazOTlA8Nd1B80bR3oXKlz9gwRGC8Z
 G/YdksO5Fw1HUygvBqRnRELWGvxhljCXcQvLJy+S/kC6b7Og/xx+kZV3mcpxwQL1jGOuv7VErOO
 1SYsRZ2WX+hZtsGt2UVFOQJGrPN2/IGTfohk+HnEuySQ0aE3OqLhXp3ddflg2D2h1KxYkIwA9mD
 hXzjP6VQKG1ThgkiWjYlyEKaUJyHP2dfGJOZM19Y9j3gMptajRSoNoN7uxdxv4VAy4oFWouVBnt
 phmuBpOCG/jBExSz1TUm36MQxhy4ISwXFnBePgH1fX7Z0kWmsbTr9POIujQskrgs3pkqTgAAKh1
 p53htJ6GcqENu/+l7+dNgJSAyTqZ5tvXVlDTxpwPkhrGKQYOXBlkVDfA==
X-Google-Smtp-Source: AGHT+IFUMGrys4WZX0Cz6In/7zIxMT/BTWXw9zZT3rl1ELFWpiJg7FQOTcPD415BVMjupgzxPcZd6A==
X-Received: by 2002:a05:600c:468e:b0:475:dd59:d8d8 with SMTP id
 5b1f17b1804b1-47730793c2amr57133855e9.8.1761945480089; 
 Fri, 31 Oct 2025 14:18:00 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c10ff4f6sm6402485f8f.4.2025.10.31.14.17.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 14:17:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] exec/cpu: Declare cpu_memory_rw_debug() in 'hw/core/cpu.h'
 and document
Date: Fri, 31 Oct 2025 22:15:14 +0100
Message-ID: <20251031211518.38503-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031211518.38503-1-philmd@linaro.org>
References: <20251031211518.38503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

cpu_memory_rw_debug() dispatches to CPUClass::memory_rw_debug(),
move its declaration closer to the CPU API. Document.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20251001150529.14122-22-philmd@linaro.org>
---
 include/exec/cpu-common.h |  4 ----
 include/hw/core/cpu.h     | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 67e15c8e507..e0be4ee2b8f 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -150,10 +150,6 @@ typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
 
-/* Returns: 0 on success, -1 on error */
-int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
-                        void *ptr, size_t len, bool is_write);
-
 /* vl.c */
 void list_cpus(void);
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e79e8e0a8ee..9615051774d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -688,6 +688,26 @@ int cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cpu,
 int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                              void *opaque);
 
+/**
+ * cpu_memory_rw_debug:
+ * @cpu: The CPU whose memory is to be accessed
+ * @addr: guest virtual address
+ * @ptr: buffer with the data transferred
+ * @len: the number of bytes to read or write
+ * @is_write: indicates the transfer direction
+ *
+ * Take a virtual address, convert it to a physical address via
+ * an MMU lookup using the current settings of the specified CPU,
+ * and then perform the access (using address_space_rw() for
+ * reads or address_space_write_rom() for writes).
+ *
+ * This function is intended for use by the GDB stub and similar code.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
+                        void *ptr, size_t len, bool is_write);
+
 /**
  * cpu_get_crash_info:
  * @cpu: The CPU to get crash information for
-- 
2.51.0


