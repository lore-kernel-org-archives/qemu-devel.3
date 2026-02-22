Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3EEE68179
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIXd-0001r1-Hd; Sun, 22 Feb 2026 18:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIXc-0001q0-AE
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:08 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIXa-0005x9-AA
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:07 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so33379315e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801624; x=1772406424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WNDBjylFNuXpzrPIF3jnKY2VcMM3yBA2p0uoFcpRvJk=;
 b=jfat0mirLhM9ZRME/Jvgap+nJWTvN0kGbTZzRh/L7pCGIVIo+tyNaUz5PfzT1j7xMc
 qA0mP/l4rI39PdK8nEuszBj9FQuwMz+2UyXES3ObQxjSHCGGDSMQrAgUAqfpdtIDTzdU
 sSCPkANBz8jKrGPN9tNBBjVFTw1G18yb0q2u5nNYB2bBPxqXKcDzpa8CZ1i5U+6K00wE
 I9uwd5a9dchD4thkKCXBV1fA4ehIqrLglK59vVu7I7C850KSv1zKIAo8oR5w6jXPvmAx
 9L9BFUwcCsU+4+CMskmSmB9F8pVlA4TPhIkFA9DQSDhBu8YUZM/CNcu06RXj/MZols52
 QxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801624; x=1772406424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WNDBjylFNuXpzrPIF3jnKY2VcMM3yBA2p0uoFcpRvJk=;
 b=hg1tCDB4KuSQpQ4Rda0vM7TpK24zqMeu8E5OofaAI4SASCYxdPLoeyilJBJ1N14gZc
 ccdMAJUc3+v4RQHZVzRloazl/l2d2juu37AuTpcOl9bLINHpTlA9bw7e94iEn5CXf0vA
 2hAQFFWHl34mPBkIbntq/ATEkFAKxk+dHmjAnyyr9sx3AO23/ogH1XOd/Cno4hbXQ23t
 fm+ixQZ8f0Vcf1ivEPAmuzFuieXbb23E9b2ME9Z9HqS3m1+u+nIAdYZ8IXNu++l7vQ6S
 6930UTiswOCbmMR9iPrjcdCfQl97GP1oFQSoSz/yueM0YKQWwWK7DZZTuyfRM2VvJ713
 dtFw==
X-Gm-Message-State: AOJu0YwpOoTdLZPRM5YUzfTzrHIpzEcLJTNzesbwklLRSGijXqlOQjfC
 +FArCCmuHtxP4fIh1dkxGlRzhxmn5LTzRRZ4ExCQ4YrgV4W922COS5lhj8XgaLHm7OfPlozeux1
 UvWOfSig=
X-Gm-Gg: AZuq6aJi76MzdQAnWvTqUDNbACGx2Uh9GaeXtHwGBDoRATKKA7hNy39FIG/iiu+wmcu
 0V6nmpPNTMCDODF4O11XRmEsDWppJzHm7qrznLCZJaAX6hE0iHyj3jquZdzkp1hf2FWX9fk/aXc
 ub/oxSuVSQiLyfmaJV98fWQmGH7knBYHhMDOiZUcIs6BhA63whFF/rEleWgpTx+MElv3fXCqDNO
 4IR+Rqx2hXG0bbZjFd8EV0etTWKEX0gz8aXG+L79Q+HLhUELEWObha6W/UkUD+jD2vhhEGwwzDH
 Act+SdeDtTah11GNHUUrIXvEEwW06iHC8XtUSVR9cAphtWqoryhDJUAEqn8CwxyUtdwTDH0nfeh
 6oPXG625Hq/1i53qnZr+VKDKzfUTQTEMUs94C2PKe2BaKA9bUKGD5ryB7dHdjnd4+S7TvNv+ZTc
 RbaqWH8VsTxvohQlsLb5m15K8j+vC/Efoju5muKi1vZQKhYKDko1dSncEKUbWOhjh+RSofD1x8
X-Received: by 2002:a05:600c:45ce:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-483a95b5835mr106783085e9.10.1771801624337; 
 Sun, 22 Feb 2026 15:07:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b3d88sm244164275e9.3.2026.02.22.15.07.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:07:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/20] hw/sparc: Set graphic display dimensions generically
Date: Mon, 23 Feb 2026 00:05:50 +0100
Message-ID: <20260222230602.5756-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

If a dimension is not set, have the machine init code
set the default value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20260216213121.47122-7-philmd@linaro.org>
---
 hw/sparc/sun4m.c        |  9 +++++++++
 hw/sparc64/sun4u.c      | 10 ++++++++++
 system/globals-target.c |  6 +-----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0c0d658d301..a17bdb36927 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -892,6 +892,15 @@ static void sun4m_hw_init(MachineState *machine)
                      hwdef->esp_base, slavio_irq[18],
                      hwdef->le_base, slavio_irq[16], &hostid);
 
+    if (!graphic_width) {
+        graphic_width = 1024;
+    }
+    if (!graphic_height) {
+        graphic_height = 768;
+    }
+    if (!graphic_depth) {
+        graphic_depth = 8;
+    }
     if (graphic_depth != 8 && graphic_depth != 24) {
         error_report("Unsupported depth: %d", graphic_depth);
         exit (1);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 5d7787fc1a5..b8bda1eb816 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -666,6 +666,16 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                                 sysbus_mmio_get_region(s, 0));
     nvram = NVRAM(dev);
  
+    if (!graphic_width) {
+        graphic_width = 1024;
+    }
+    if (!graphic_height) {
+        graphic_height = 768;
+    }
+    if (!graphic_depth) {
+        graphic_depth = 8;
+    }
+
     initrd_size = 0;
     initrd_addr = 0;
     kernel_size = sun4u_load_kernel(machine->kernel_filename,
diff --git a/system/globals-target.c b/system/globals-target.c
index e3f7d846ac0..17a27a06218 100644
--- a/system/globals-target.c
+++ b/system/globals-target.c
@@ -9,11 +9,7 @@
 #include "qemu/osdep.h"
 #include "system/system.h"
 
-#ifdef TARGET_SPARC
-int graphic_width = 1024;
-int graphic_height = 768;
-int graphic_depth = 8;
-#elif defined(TARGET_M68K)
+#if defined(TARGET_SPARC) || defined(TARGET_M68K)
 int graphic_width;
 int graphic_height;
 int graphic_depth;
-- 
2.52.0


