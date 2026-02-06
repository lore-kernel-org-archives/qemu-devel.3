Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2286EEE6B6A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voThA-00024d-1G; Fri, 06 Feb 2026 16:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfm-00082N-Jx
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:40 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfi-0002m4-OC
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:28 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-4362d18bb65so715398f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414445; x=1771019245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5U5YnRpZtzep6rG1Rz5ZkUjCGOhyK2lDXh0XgoJd98=;
 b=WyRNdddstejomLK/LcLlemE06PS5M8J73q8FmfeKNZGJDjhJs1Bfzzzp6+K1jSbJa3
 FOcl+hZsALzEwneIVhTdsyXxFcifukI+K57y97FFKAFD2apuEgZr+6WB6hMhpJBD35rK
 rweNBD4wL6uYwxBQNHt1rhwGUu/OmC3Lak7MVOVlRjUTpZLnDLGK1mEgT/rM3jHSydC7
 PTQxD9y008ORiVJiVshRoOlAO/xewGWoc7olPpNPGwL35QcjkO2C+RKL3MpZzbZXY3yY
 qYmhNo+Z5dqen/ripjmpkhGcHHFwc5VEmY0vh1aHXJom0JfqVoMxTmOU55Q8cdKk2XGE
 h6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414445; x=1771019245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J5U5YnRpZtzep6rG1Rz5ZkUjCGOhyK2lDXh0XgoJd98=;
 b=L04TRJ+me0jiEufzwDfv9Ch6O3YJiSBbmX65cA/DvwVa/rkytzx6lpoYxuoq+obAwx
 THWjLKwk/Lh87hngJ9Q8xdBfLfBEVrgg1BgP3pd8lgx9g6He9oafwzpVToS1fqh4XzJD
 4gk7zbLFQfoGDoRC5+zk3B2vuorYN+b6eK8hfAPvHqatImyTHil5eBF3StwvIiDO6u/w
 mId+YIbGUXrxQ1JlM7ruLDjl9RRC5jypC+T3XEtXTtDKURnb5jUDp1ghrYvNaHP5O1jd
 dsw82bVW+x7jzT31Rc+FNyrtNjk/v85LYCLAhKTsXr6D0bMpSBTmKhI6PsQmS/mKLEm7
 WGfg==
X-Gm-Message-State: AOJu0YwcdupFkpk2JMlB1Ay1fwSaTf168RsAaxqywB+Tc/4OrVRdiQvK
 6qI22Gdv5NZ1OYPjkEJCdJk1Fvx13qn15wKzU7reWjmmNS1OmoEEOeDZaoemvlxXpSOr5dfOWWU
 ExFC5fx0=
X-Gm-Gg: AZuq6aKMIfMYMvrxE4hnlEVZeu5jGkUttF+Nu6Qun7ONYcxLidLZHou8fwHKQXT2Z85
 SNVvn6ktrL4B/NouIfeF/3r8DGiRM/pvc16iBQp2hJ2AcWU7LIxpP4TvfgXlMk6L4iHjKaUcAdo
 ryW3QsICBkPwsg5HByloiGrMHqmRDrFKO+YoD6GmGjZhMbk+ps56OrTMi9knwntVAWNrrN1iri/
 TY33r8LzRja3waZNRs72vO+iIV27clV3/SSDSlUHoVxR81TSQLNDbgqXdEnzxCCfsVb0eZXlBpn
 hlZiHK+5wU5nltMAMyJ0t04YeZpNoxlig8ezD2LuPA+ibF9TeBJX2S+tFFEBrv9NEH3b9Y+SSGk
 n3uVWAhZtpU2JCBqDhz54lRpkIBQWe7C+0t9bTOoSNekm2RTqxh80cafE/mfg3TdghUVLdSjX8a
 tbX7IoPyBHbHgY+iGR4V3VtttsHD29nkPOePiH4q2A28XFJwFWF6DwQtQ/uOAH
X-Received: by 2002:a05:6000:250f:b0:431:7a0:dbc2 with SMTP id
 ffacd0b85a97d-43629378686mr6155086f8f.31.1770414444725; 
 Fri, 06 Feb 2026 13:47:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fc1bsm8784731f8f.28.2026.02.06.13.47.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:47:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 23/30] include/hw/or1k: Rename from openrisc
Date: Fri,  6 Feb 2026 22:44:41 +0100
Message-ID: <20260206214448.22008-24-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stafford Horne <shorne@gmail.com>
Message-ID: <20260205030244.266447-3-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                          | 2 +-
 include/hw/{openrisc => or1k}/boot.h | 6 +++---
 hw/openrisc/boot.c                   | 2 +-
 hw/openrisc/openrisc_sim.c           | 2 +-
 hw/openrisc/virt.c                   | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename include/hw/{openrisc => or1k}/boot.h (93%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 08bcd8892ac..ea52060bfe7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -305,7 +305,7 @@ S: Odd Fixes
 F: docs/system/openrisc/cpu-features.rst
 F: target/or1k/
 F: hw/openrisc/
-F: include/hw/openrisc/
+F: include/hw/or1k/
 F: tests/functional/or1k/meson.build
 F: tests/tcg/openrisc/
 
diff --git a/include/hw/openrisc/boot.h b/include/hw/or1k/boot.h
similarity index 93%
rename from include/hw/openrisc/boot.h
rename to include/hw/or1k/boot.h
index 3c481bdea68..2e6131580c7 100644
--- a/include/hw/openrisc/boot.h
+++ b/include/hw/or1k/boot.h
@@ -16,8 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef OPENRISC_BOOT_H
-#define OPENRISC_BOOT_H
+#ifndef OR1K_BOOT_H
+#define OR1K_BOOT_H
 
 #include "exec/cpu-defs.h"
 #include "hw/core/boards.h"
@@ -32,4 +32,4 @@ hwaddr openrisc_load_initrd(void *fdt, const char *filename,
 uint32_t openrisc_load_fdt(MachineState *ms, void *fdt, hwaddr load_start,
                            uint64_t mem_size);
 
-#endif /* OPENRISC_BOOT_H */
+#endif /* OR1K_BOOT_H */
diff --git a/hw/openrisc/boot.c b/hw/openrisc/boot.c
index 6256babc42a..c18f4a6a9fc 100644
--- a/hw/openrisc/boot.c
+++ b/hw/openrisc/boot.c
@@ -12,7 +12,7 @@
 #include "exec/target_page.h"
 #include "elf.h"
 #include "hw/core/loader.h"
-#include "hw/openrisc/boot.h"
+#include "hw/or1k/boot.h"
 #include "system/device_tree.h"
 #include "system/qtest.h"
 #include "system/reset.h"
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 603d8ca0d99..f1b1f63274b 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -26,7 +26,7 @@
 #include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "net/net.h"
-#include "hw/openrisc/boot.h"
+#include "hw/or1k/boot.h"
 #include "hw/core/qdev-properties.h"
 #include "system/address-spaces.h"
 #include "system/device_tree.h"
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 54ce96666e5..39f54058ab3 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -16,7 +16,7 @@
 #include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "hw/core/split-irq.h"
-#include "hw/openrisc/boot.h"
+#include "hw/or1k/boot.h"
 #include "hw/misc/sifive_test.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
-- 
2.52.0


