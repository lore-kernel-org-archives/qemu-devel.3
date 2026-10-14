Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB8DCC6B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvLW-0002Eu-1i; Wed, 14 Oct 2026 05:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvLS-0002EW-OJ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:32:22 -0400
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvLP-0000KB-HN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:32:22 -0400
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-154e9d2d979so563363c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970338; x=1792575138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rSqKSRhEqnstEH7SJXTfujA+NHTWwnjZ9T7JL0yO7Dk=;
 b=cbh2zRGNuE97IHFiDeTfDxakb8gs8WMtfdoKP3fI2zHZ3pPNP9p6hqna6fmCq3ZLed
 7PGsK3kBHQai9I0F0Yh/pWGExUwUhE8giVaoC0ncIgbvyW/M362gO8wQiboNsF02A7zr
 iPby/q78GC/T3GXp2qEurgFSgfJpgxfibSzoj9RysXG9BprOfw4UHNy2Q73Meityl+Sk
 DmifPqbzRcFJmPOWJUOL4kpaEQOtLKMvquBpyeuo5cmpLqlXkhFvBoliO9Y+QtQMui4O
 I9hKZPWGFt4OzAZRWM0dDeChrp6G0kIBukhjudxv0vqYMsZVdFVc5gVnKnUdDQX859GR
 BXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970338; x=1792575138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rSqKSRhEqnstEH7SJXTfujA+NHTWwnjZ9T7JL0yO7Dk=;
 b=EZCNVpQZlprlZXwwLuYiGXPMpPmdlcMtwPYxBkujGUYZeYLlHNMOgkX6+g1qRqkt9Z
 LYlFuvjZpvPmlWGQYa817KTPe0+27+X3M4NhHWgO6zxTbQ1A4XtIhS1QQuiAcWu/5LlT
 y3MMDK5CFqte3QxYdU0Eesx1dPVxhxezLOtjea+6yzZYZkUinAnUAKB8b5hyiTgVsGP7
 vcjy6EenQB6tpzCfzzU+V+bqIpOuJb6YdODmJrHZ1NG+WCHlSWs7Huy6g8rxLzxaUIu7
 XZhqG+XjXXbnEiiHEnybw2awipbrtGOX50pDc1YsZzsQRo81s3tyOKoR5qMyFcFJTrf0
 PRZA==
X-Gm-Message-State: AFq9FYJt6E8cB2gi15qYuAF9OgeZiC8Iw1fkp7CRzaSan/H1hLwYmde6
 nw956APgGhH2L/std8TNgBhgfBAbUdR+NCBSm3DMwYoezGjLOL6sljukAxT2vniwVH8=
X-Gm-Gg: AYBFou3m2yjlrFUnKljyUwD7pkg1tZTu7NFYlf12/6RMADus5pmimOWazZmgje5AQgI
 AakpVQbZHKAynq/x0W1sFVTpRhuoX9ifcbJ45ME/LtDkKM3l8ioIqocn5dN8hbIgdKVf/e0S4mD
 ujNN2NxuUv/cAC9HvtQtqGSSDA+xog07egWwJKlUHR+fjJEaB4YWygo7i6O4at2DAuNBAv1VmO4
 Jcs5rty+GoXogymyKrbWRMKFIUwWP7twnqPglGBIn6UOZy1xQpKahdoNjoel0Zhspd5q8HQ+Y+f
 G2GBfcPT0V24XiYKBsjmdEQA2zOr5BbWNhiZd6MyQ4b8gbgjYMonaruOhZpgdGyB353hFqwZ1Sf
 ywagt+iQZsxaUGGk8kOWF+AmisJxmGEl9f/76jzjVXd2i9mOSPrZtb1aqSTO2cetBa4cDaU8cGo
 8zUIYDWe6rJH1XyGGA9SZAmZqAWNFh1yPp7M+GpDlmPExVv/+ROmj2LsmKdWa6Qj4Dd6dt63REN
 s/McEJ5/30+p/m4+Oh5NIm+NFSi
X-Received: by 2002:a05:7022:7e8c:b0:143:1bb1:b3c3 with SMTP id
 a92af1059eb24-16a5ce94210mr21692046c88.14.1791970337648; 
 Wed, 14 Oct 2026 02:32:17 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm48769303c88.0.2026.10.14.02.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:32:16 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 01/34] qemu/base-arch-defs: extract QEMU_ARCH_BIT for
 QEMU_ARCH_* enums
Date: Wed, 14 Oct 2026 17:31:11 +0800
Message-ID: <20261014093152.834-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014093152.834-1-luoyonggang@gmail.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1232.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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


