Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64278C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5NpO-0002LI-B2; Fri, 10 May 2024 06:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Np9-00024I-Ng
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:50:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Np7-0001a1-94
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:58 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-34db6a299b2so1406971f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715338194; x=1715942994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MMieI22tvUHRez0ASZq1ieLRFlQN49cydbbEGQRCXw=;
 b=z5oMFXzPVEKemroKPdSa3uvc/+olFkBPQzM/e6J1n8ytvMF3jbmFt4MwFTnrz1YXNN
 fN/d0PTEWueh5Areewg/0jpxjkZITrMH4/qGVMMdHMkCwugR7ItQVRGGGBX7JKNTSeah
 HdaOGk65vil9aJALcMG2jFK+FlwQ4pymurW9C7lMaOQ+BryLYbdYPmZcq+TRFbxhG/SS
 trq9f3rXoFNMq8MPMb6Jznc8fyG2hhcK+4GRqvrGL7SZAw2iZSDNnC7EowgS2XgGJRNq
 nRldid1srx3QYTZUKzjSn16L7+HR28sFQQw6WzcqFi9R+KCG688ZKnqQJ2bxTEmI6r8v
 SF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338194; x=1715942994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4MMieI22tvUHRez0ASZq1ieLRFlQN49cydbbEGQRCXw=;
 b=PQhMNQS+OTSbI400tzNQ10BO2OeUncT0AoUo6NVkWcnxilLA30JkGH/pnw5d1aMu+c
 4wvdP/UFmzdRc85ln7z/Ed2rwHUQhNkCjbo6Y8/ZHNxJckKs8Ie3Aiye15akYeXRW4Y3
 t800fN+nyv8PTm07wxd4KELbwjYN68uzBErAWdSZb3hGKYVA47Y8auOqwYSXp5w71vGz
 +GrwBN9HuFjHGAhnMFAGS1lUk4IoZG8q9v7ms9bxjoYXCZAzZu0mZFtR8mcORgRsII0p
 mw5s5mTmAz2kuU5ZB3CxFVCvZc6nUyayCOATA8cWeTeE26ZqCu3W3wyoax78YG6JWAcM
 aTgg==
X-Gm-Message-State: AOJu0YydW1UrcrnZodX+5I8jF5N0sZwyToGloABjkKc/kcJkP0j27arT
 OCmNzkYEKyeibiDQv1mXOBm4gABUw2FSTdCA1qucAGkZh3b7JaBOctuEocgFx5On143Qb0yprFZ
 X
X-Google-Smtp-Source: AGHT+IEewNU5yU5UDos2eDjrq2/6gYromkISrbJeR/i31/cfP+aw0nvt1M9WGWO7AigSVj0qKxcq5A==
X-Received: by 2002:adf:ef09:0:b0:34c:fd72:f308 with SMTP id
 ffacd0b85a97d-3504aa69de0mr1652917f8f.71.1715338194433; 
 Fri, 10 May 2024 03:49:54 -0700 (PDT)
Received: from m1x-phil.lan (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbfecsm4215282f8f.105.2024.05.10.03.49.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 May 2024 03:49:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/7] hw/xen: Register framebuffer backend via
 xen_backend_init()
Date: Fri, 10 May 2024 12:49:08 +0200
Message-ID: <20240510104908.76908-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240510104908.76908-1-philmd@linaro.org>
References: <20240510104908.76908-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Align the framebuffer backend with the other legacy ones,
register it via xen_backend_init() when '-vga xenfb' is
used. It is safe because MODULE_INIT_XEN_BACKEND is called
in xen_bus_realize(), long after CLI processing initialized
the vga_interface_type variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen-legacy-backend.h | 3 ---
 hw/display/xenfb.c                  | 9 +++++++--
 hw/xenpv/xen_machine_pv.c           | 2 --
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index e55a14057f..943732b8d1 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -66,9 +66,6 @@ static inline void xen_be_unmap_grant_ref(struct XenLegacyDevice *xendev,
     return xen_be_unmap_grant_refs(xendev, ptr, &ref, 1);
 }
 
-/* backend drivers not included in all machines */
-extern const struct XenDevOps xen_framebuffer_ops;  /* xenfb.c */
-
 /* configuration (aka xenbus setup) */
 void xen_config_cleanup(void);
 int xen_config_dev_vfb(int vdev, const char *type);
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index b6d370bdf6..ff442ced1a 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -29,6 +29,7 @@
 
 #include "ui/input.h"
 #include "ui/console.h"
+#include "sysemu/sysemu.h"
 #include "hw/xen/xen-legacy-backend.h"
 
 #include "hw/xen/interface/io/fbif.h"
@@ -996,8 +997,12 @@ static const GraphicHwOps xenfb_ops = {
     .ui_info     = xenfb_ui_info,
 };
 
-static void xen_vkbd_register_backend(void)
+static void xen_ui_register_backend(void)
 {
     xen_be_register("vkbd", &xen_kbdmouse_ops);
+
+    if (vga_interface_type == VGA_XENFB) {
+        xen_be_register("vfb", &xen_framebuffer_ops);
+    }
 }
-xen_backend_init(xen_vkbd_register_backend);
+xen_backend_init(xen_ui_register_backend);
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index b500ce0989..24395f42cb 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -50,8 +50,6 @@ static void xen_init_pv(MachineState *machine)
         break;
     }
 
-    xen_be_register("vfb", &xen_framebuffer_ops);
-
     /* configure framebuffer */
     if (vga_interface_type == VGA_XENFB) {
         xen_config_dev_vfb(0, "vnc");
-- 
2.41.0


