Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A10C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 13:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNuFX-0001pC-Pr; Sun, 30 Jun 2024 09:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sNuFF-0001dV-AQ
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 09:05:29 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sNuFD-0001RS-Fz
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 09:05:28 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ebe785b234so20666251fa.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 06:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719752723; x=1720357523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gy5d4VUG3S8RkYYMDPIsNSyoTOz3cAQeT+yHpyAGU/U=;
 b=j2WzyCCTZRnV0K5zYbfeDhbQgByCIIS92uxGxRYwiN4aPdWS+uwUYAq/XcNB1Ahb/T
 t7ae85H9hNMLgvfPWOlr+B6HNV6fr2grH74+6x0iW1K8vaXoz4/+vhWpE8+cPKbOtix6
 ZhU/HBw8NUzqgkeDwI3c+y/DYuz4pE2KpzsR8TweKt9SpkjKH+2zQ1zVqTPXyMS5d5qN
 pYG0Y4ZK9VIO/5mc+C6ZcG0q62VjNsp6au1UHGEbz3DJRCgtoyjrvjEp3bdfxcy3wzBJ
 +NVPE96wtgic2ZG+AH5qoifdLWknzsHQcke6/UM5rNYQ/YIJAWbEFRGzv1oE3wt6OOWa
 i1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719752723; x=1720357523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gy5d4VUG3S8RkYYMDPIsNSyoTOz3cAQeT+yHpyAGU/U=;
 b=O/ZsgwY0Ws4PGV9BP6G2VIA3qKoRhyypSE4LTyMHbH2Zar7eLLAmMpZ6Jk8Utky7+K
 TAREVkPsatZF05oUI30efgMPZMeTG8IX5apJb20tadN29XONQvD3VRI9daQOlaioR/f5
 yV9HtQ+cF+DaqQmHZrBkYaxbSA0yFG8un9UuEXFTbuDp7rR770c7eUQj7KVfEpAI9vQs
 qWcXSHyoFTikn6kCjzW4DJG4FZWZ4jWnmt+pNYXHn/dwW0o1gUh/YYVtR0/vv9BOVfX5
 b8usOyWJZSAv278dIGuikdol+yFLnK83bxrBRIjI6c7b165e00Fif2et7//NhbTc47+m
 Zuvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1+WwvR/OoH73IXUC/B/o1XOOldYpO/5NK8q2Fc85ZPvy3M+C0jBh8V3/i+zzBcDZlNfNKeRUPN1zO8vOwreQ7+h44u/s=
X-Gm-Message-State: AOJu0YyR9wNKn9d/PX6laKeEl2T7sqOhb9mLqhx4gyCus6rno0s2BocO
 64kUNmFOHkRpJLgY6UctZQiviS5ES6Ce7foET0Tvwr//GPqVFpM=
X-Google-Smtp-Source: AGHT+IGfWJhSgJiDSaD7ks9TS4TzToEEMpWgkl+w6k6rFaFxytFQtj3W+oKoPzUCpU5l+tuOrJ2yqA==
X-Received: by 2002:a2e:9e98:0:b0:2eb:eb7c:ec1b with SMTP id
 38308e7fff4ca-2ee5e4c3824mr19148161fa.25.1719752722824; 
 Sun, 30 Jun 2024 06:05:22 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9b1dsm7458264f8f.42.2024.06.30.06.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 06:05:22 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Zheyu Ma <zheyuma97@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/display/tcx: Fix out-of-bounds access in tcx_blit_writel
Date: Sun, 30 Jun 2024 15:04:26 +0200
Message-Id: <20240630130426.2966539-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=zheyuma97@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch addresses a potential out-of-bounds memory access issue in the
tcx_blit_writel function. It adds bounds checking to ensure that memory
accesses do not exceed the allocated VRAM size. If an out-of-bounds access
is detected, an error is logged using qemu_log_mask.

ASAN log:
==2960379==ERROR: AddressSanitizer: SEGV on unknown address 0x7f524752fd01 (pc 0x7f525c2c4881 bp 0x7ffdaf87bfd0 sp 0x7ffdaf87b788 T0)
==2960379==The signal is caused by a READ memory access.
    #0 0x7f525c2c4881 in memcpy string/../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:222
    #1 0x55aa782bd5b1 in __asan_memcpy llvm/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cpp:22:3
    #2 0x55aa7854dedd in tcx_blit_writel hw/display/tcx.c:590:13

Reproducer:
cat << EOF | qemu-system-sparc -display none \
-machine accel=qtest, -m 512M -machine LX -m 256 -qtest stdio
writel 0x562e98c4 0x3d92fd01
EOF

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/display/tcx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 99507e7638..af43bea7f2 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -33,6 +33,7 @@
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 #include "qom/object.h"
 
 #define TCX_ROM_FILE "QEMU,tcx.bin"
@@ -577,6 +578,14 @@ static void tcx_blit_writel(void *opaque, hwaddr addr,
         addr = (addr >> 3) & 0xfffff;
         adsr = val & 0xffffff;
         len = ((val >> 24) & 0x1f) + 1;
+
+        if (addr + len > s->vram_size || adsr + len > s->vram_size) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: VRAM access out of bounds. addr: 0x%lx, adsr: 0x%x, len: %u\n",
+                          __func__, addr, adsr, len);
+            return;
+        }
+
         if (adsr == 0xffffff) {
             memset(&s->vram[addr], s->tmpblit, len);
             if (s->depth == 24) {
-- 
2.34.1


