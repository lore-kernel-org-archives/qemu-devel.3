Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642CC606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gtr8MTh6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaSu-0006j4-M4; Tue, 27 Oct 2026 02:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLaSt-0006iM-Cr
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:15:19 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLaSr-0007IJ-JZ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:15:18 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-36a17a332ecso143354eec.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793081715; x=1793686515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rSqKSRhEqnstEH7SJXTfujA+NHTWwnjZ9T7JL0yO7Dk=;
 b=gtr8MTh6bwYamV+EapYAsVVlSOFTPU/tET6ftWmLHP5QAKd6srLGMs32p6PqN7Azw8
 28AdINFcXnY66UQg/NhWTnbpSw23wX44fY7133Gm4XpR9CL+46/xuwQzyS6fYWcSKzJu
 nZ+eWEL8WF+TvngBgCUdQozSSBewIPYPdynMl/J5KmB/sSvq1V6ydnuGLhWb5ZrPpxGD
 P/UBOz2VwkLy9rWf5+I+oXszbAuN9kTH/RvOo1XKJxXR1hYC+DTsQwCbiKD8FJmPXU/6
 lGVQo0iw0hvayY1C/veYSe0phne+MGZCKWJSUjBqt3UhK0U/IyW5sSrbTZ++bj92C99v
 SRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793081715; x=1793686515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rSqKSRhEqnstEH7SJXTfujA+NHTWwnjZ9T7JL0yO7Dk=;
 b=y/Y4+wU4ANjz0zxK/9lIvJxAw2y+UJF15z4bfLDD5LXviy0Dxdjeqtuc/Bz5+Iu/v3
 M2jRciTz3VqKkdwNro8E1g7fmEKg8a0FHydxo5FSz0OdX3XdVYk+fX1b859UUKzBwBKC
 9kME8b3+4lzy4sKNiZuJIsvEwPJYsyItrZSQGsyCQOgs1yV7g4IISYjgBh5HselX5nzC
 MbcjMtmYrma9lPLz/+6g/gYhh/dnMQwK6u9XM8CUiAXMui++gRaiO3s3ANcucmod7SKp
 fY6Oe1Z+cWzpfjiRFG6TL+TxF1hyy9E6U39aIrcBAItqCrC1QJ59AlHMzCuO3F0g07vW
 TnOg==
X-Gm-Message-State: AFq9FYKx4vyd5RcgJOvZ613ZiFzz/BNkFH4K3I/DdlXHCyHUMsdjOcPR
 D+4jonKTmi0xJCLkDveyiB3MmGz0F66RgZM0+PoV7E8q8wm8XWrPkuANYtOvex92
X-Gm-Gg: AYBFou3v5kQ08QSq7uihgL+pwQhGAr2iHn3mDVGbrmRLtIYX49K8jOTLX+QPSiGabCo
 NNel5d9kffeER51ax+zc6WJD9OTEwop24KsRX8RlUBJCEmqc+DYXvmIcAHOY3KY2SoMzPkePZav
 w2LMjfdbe0zBYXNEV8yYn3R4EJ5jDb2KWwrM/cvKDC/sTz150sDPOwGpHFJzNtRrvwq/k1UOpeR
 drcm0YofjYYmEGhRuY9ZllWspLqTtZmAYCwaIeILUeZMA38v4QTd8Ldh4os45EJ1x34d+M6wPoy
 co+4S6uWS9aRGMmaexdrvGsk7v3H4k/iliPyR8fK+9RzEoU5LaP4qE8O/e9i3oqkTTj8rSr1JvL
 p3DKikGxCM8LyobJUWonXm4RpZ5JOctv9G24O1F+JC6LLoI45WOg4ps0VYKt2GmQ7pQDfT3D4U6
 xqbSluQrJ7KNqwW0PTfhslebg7fy1RbHWtuvhmSVNbStWNqdrsWJHvZKj+6Sax6RkG5r9cre/Wf
 PH9AgFkC8tnSbFvBJGGAS0ebGvmoJzZExOmXTI9TkggHDzAUnNIHozvwTK+QgCy6pezNLJyMGO7
 +TYkU1JvGEkD9Rwsj5L7
X-Received: by 2002:a05:693c:4195:20b0:34e:c001:1486 with SMTP id
 5a478bee46e88-369e84daa95mr14737352eec.8.1793081714954; 
 Mon, 26 Oct 2026 23:15:14 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-369e8ec864fsm37346980eec.24.2026.10.26.23.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:15:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/3] qemu/base-arch-defs: extract QEMU_ARCH_BIT for
 QEMU_ARCH_* enums
Date: Tue, 27 Oct 2026 14:15:01 +0800
Message-ID: <20261027061504.2213-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261027061504.2213-1-luoyonggang@gmail.com>
References: <20261027061504.2213-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UPPERCASE_75_100,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/base-arch-defs.h | 60 ++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/include/qemu/base-arch-defs.h b/include/qemu/base-arch-defs.h
index f33465738c9..806ad8094a4 100644
--- a/include/qemu/base-arch-defs.h
+++ b/include/qemu/base-arch-defs.h
@@ -9,36 +9,38 @@
 
 #include "qapi/qapi-types-machine.h"
 
+#define QEMU_ARCH_BIT(target) (1UL << (target))
+
 enum {
-    QEMU_ARCH_ALPHA =       (1UL << SYS_EMU_TARGET_ALPHA),
-    QEMU_ARCH_ARM =         (1UL << SYS_EMU_TARGET_ARM) |
-                            (1UL << SYS_EMU_TARGET_AARCH64),
-    QEMU_ARCH_I386 =        (1UL << SYS_EMU_TARGET_I386) |
-                            (1UL << SYS_EMU_TARGET_X86_64),
-    QEMU_ARCH_M68K =        (1UL << SYS_EMU_TARGET_M68K),
-    QEMU_ARCH_MICROBLAZE =  (1UL << SYS_EMU_TARGET_MICROBLAZE),
-    QEMU_ARCH_MIPS =        (1UL << SYS_EMU_TARGET_MIPS) |
-                            (1UL << SYS_EMU_TARGET_MIPSEL) |
-                            (1UL << SYS_EMU_TARGET_MIPS64) |
-                            (1UL << SYS_EMU_TARGET_MIPS64EL),
-    QEMU_ARCH_PPC =         (1UL << SYS_EMU_TARGET_PPC) |
-                            (1UL << SYS_EMU_TARGET_PPC64),
-    QEMU_ARCH_S390X =       (1UL << SYS_EMU_TARGET_S390X),
-    QEMU_ARCH_SH4 =         (1UL << SYS_EMU_TARGET_SH4) |
-                            (1UL << SYS_EMU_TARGET_SH4EB),
-    QEMU_ARCH_SPARC =       (1UL << SYS_EMU_TARGET_SPARC) |
-                            (1UL << SYS_EMU_TARGET_SPARC64),
-    QEMU_ARCH_XTENSA =      (1UL << SYS_EMU_TARGET_XTENSA) |
-                            (1UL << SYS_EMU_TARGET_XTENSAEB),
-    QEMU_ARCH_OR1K =        (1UL << SYS_EMU_TARGET_OR1K),
-    QEMU_ARCH_TRICORE =     (1UL << SYS_EMU_TARGET_TRICORE),
-    QEMU_ARCH_HPPA =        (1UL << SYS_EMU_TARGET_HPPA),
-    QEMU_ARCH_RISCV =       (1UL << SYS_EMU_TARGET_RISCV32) |
-                            (1UL << SYS_EMU_TARGET_RISCV64),
-    QEMU_ARCH_RX =          (1UL << SYS_EMU_TARGET_RX),
-    QEMU_ARCH_AVR =         (1UL << SYS_EMU_TARGET_AVR),
-    QEMU_ARCH_HEXAGON =     (1UL << SYS_EMU_TARGET_HEXAGON),
-    QEMU_ARCH_LOONGARCH =   (1UL << SYS_EMU_TARGET_LOONGARCH64),
+    QEMU_ARCH_ALPHA =       QEMU_ARCH_BIT(SYS_EMU_TARGET_ALPHA),
+    QEMU_ARCH_ARM =         QEMU_ARCH_BIT(SYS_EMU_TARGET_ARM) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64),
+    QEMU_ARCH_I386 =        QEMU_ARCH_BIT(SYS_EMU_TARGET_I386) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_X86_64),
+    QEMU_ARCH_M68K =        QEMU_ARCH_BIT(SYS_EMU_TARGET_M68K),
+    QEMU_ARCH_MICROBLAZE =  QEMU_ARCH_BIT(SYS_EMU_TARGET_MICROBLAZE),
+    QEMU_ARCH_MIPS =        QEMU_ARCH_BIT(SYS_EMU_TARGET_MIPS) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_MIPSEL) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_MIPS64) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_MIPS64EL),
+    QEMU_ARCH_PPC =         QEMU_ARCH_BIT(SYS_EMU_TARGET_PPC) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_PPC64),
+    QEMU_ARCH_S390X =       QEMU_ARCH_BIT(SYS_EMU_TARGET_S390X),
+    QEMU_ARCH_SH4 =         QEMU_ARCH_BIT(SYS_EMU_TARGET_SH4) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_SH4EB),
+    QEMU_ARCH_SPARC =       QEMU_ARCH_BIT(SYS_EMU_TARGET_SPARC) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_SPARC64),
+    QEMU_ARCH_XTENSA =      QEMU_ARCH_BIT(SYS_EMU_TARGET_XTENSA) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_XTENSAEB),
+    QEMU_ARCH_OR1K =        QEMU_ARCH_BIT(SYS_EMU_TARGET_OR1K),
+    QEMU_ARCH_TRICORE =     QEMU_ARCH_BIT(SYS_EMU_TARGET_TRICORE),
+    QEMU_ARCH_HPPA =        QEMU_ARCH_BIT(SYS_EMU_TARGET_HPPA),
+    QEMU_ARCH_RISCV =       QEMU_ARCH_BIT(SYS_EMU_TARGET_RISCV32) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_RISCV64),
+    QEMU_ARCH_RX =          QEMU_ARCH_BIT(SYS_EMU_TARGET_RX),
+    QEMU_ARCH_AVR =         QEMU_ARCH_BIT(SYS_EMU_TARGET_AVR),
+    QEMU_ARCH_HEXAGON =     QEMU_ARCH_BIT(SYS_EMU_TARGET_HEXAGON),
+    QEMU_ARCH_LOONGARCH =   QEMU_ARCH_BIT(SYS_EMU_TARGET_LOONGARCH64),
     QEMU_ARCH_ALL =         UINT32_MAX,
 };
 
-- 
2.55.0.windows.3


