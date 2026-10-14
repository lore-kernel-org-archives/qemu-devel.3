Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FFBCC6B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvWy-0004bv-W8; Wed, 14 Oct 2026 05:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvWs-0004SC-8Z
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:44:13 -0400
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvWp-000233-EO
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:44:09 -0400
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-157fe9d771bso1524588c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791971046; x=1792575846; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q0y6iWTViEYs2Yni2aIzizLDmK3bL+XdOhnGK9u7D5w=;
 b=MbXxSYw82rLpmvpIWz96+OdSHpBzzlhv16KWdzhVgiJijsl544w519/N4EkRGuX0In
 os2AVNZiALogwupbCXkzYQHDvM1Bomh2Ynays7a9XjGp3prYNXmiwn/qrJe3g4PozIk7
 w8STSR77E+Zj8yysdKEDaVj0VPVXnyt0onhSk0Vl27Xd4gv3OwGHTnHbeZ4+P0Jli7Ym
 V7kGg1+JBDehGfvzmLoRs9nX0m1M6P95fqP//c1HotfS9v+6vKponf8kYIvNO1iIlI9w
 DcHZMD2/NY1Tqjh7HWVsca0qiKla5ZPisIPyKvE6v0JhmkQBHG2AL8YFVjdkuL7i+nm7
 Gigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791971046; x=1792575846;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q0y6iWTViEYs2Yni2aIzizLDmK3bL+XdOhnGK9u7D5w=;
 b=0pEylrORl5K4a4qPi7KDfDVASt33EGjq4jBOBS3TRoCqmiH8VbVj038b4vV4lEM+q/
 yUVq+35JCGNwd5xwx16rknfHwkmoWXppIXniVRtmAaTjT1uBfiGGTFkKYXvDmAyfiT/F
 COlRw85+Y+oDyo21TnPWfcv1QwpKq4nXLrwkC6Q2XMCXIsT9qOeBc+xkX1ydEt2DFpUI
 3c7Jp0/6x1WLqLaPG7uW2S1TQNR6kzjMNIg5uR9rnew6JF2VRyL+zzJT7lUeqS5nU0xa
 h6Zx5Ss6uUFcKHyIGC4im72Z2mtrF1+mpILIJ2v7YYoNhH0fQqYjmaXqa3oe3TRbD9Oq
 u9vg==
X-Gm-Message-State: AFq9FYIZFlEiDinuU9JaysJZWBytfJYQWUrdFLxt/KX5MvN89C4OJPpb
 9ArRt+OEZlbfxbEBa+cqOz0m7oGVVRpJPuokHVvAw8Kis6fxtYem5Ih8TzGsTH1v3Kc=
X-Gm-Gg: AYBFou2MAK5srywz30uQSfJMTsviKJVqKOq28S2lOTw+MyGQwvoTuJxynaeCB902bMS
 HlcFG88U3c/xvx/kJXvHu0ZHbzioRd7LC16LOxuPJRwBMVKPO+8VoXrPf8gelO6Sb34snBcp7tG
 ud3YQmvhXY7Sr6vSH/Z6h74/HzUtV8i+iqXXx329pTIT5wqrZgVn5GHXyGCRgsoue0LMAcm6/FC
 diTdc6CSUXjTRobKmGpt2lBAQwjbALX4a78yYyhR0OnNf1n7oj8IY7uJyIJb8ytZVq9h0FFg4Kb
 8PqxPR7s4pmUAalNasgO/6Ww+VvYUsyyPZqLO6QSwSejYRMnvGlf4X09PyMJ8US6Pjc8B+LFwoS
 xnllqt1bGEc5wT78nvEtsLkITaIZqNpwHO5b56Bip2+mYwhsy9crcZHDUcNzXI608hTN8X7f0no
 6BztZICktqQhWoQqJEQE0yBO47sfQZyLOrIVY99TbbF+Y65en6JGmwAKBpU+qw4CRQligJcYCif
 hY+hdjMy8ruS9KRJQ==
X-Received: by 2002:a05:7022:5f14:b0:168:6ad8:e89f with SMTP id
 a92af1059eb24-16a56c9dd9dmr20132931c88.3.1791971045771; 
 Wed, 14 Oct 2026 02:44:05 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a31f6f5csm44348380c88.11.2026.10.14.02.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:44:04 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Eric Blake <eblake@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Fabiano Rosas <farosas@suse.de>,
 Song Gao <17746591750@163.com>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH 25/34] hw/xtensa/virt: use unique QOM name
Date: Wed, 14 Oct 2026 17:41:40 +0800
Message-ID: <20261014094224.1976-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014094224.1976-1-luoyonggang@gmail.com>
References: <20261014094224.1976-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Register the board as xtensa-virt so Xtensa virt no longer collides
with other virt-machine types in one process. Keep the -M / help /
migration name as virt via machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/xtensa/virt.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 271f06e0953..d3c51f8158a 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "system/reset.h"
 #include "hw/core/boards.h"
@@ -118,10 +119,29 @@ static void xtensa_virt_init(MachineState *machine)
 static void xtensa_virt_machine_init(MachineClass *mc)
 {
     mc->desc = "virt machine (" XTENSA_DEFAULT_CPU_MODEL ")";
+    machine_class_set_name(mc, "virt");
     mc->init = xtensa_virt_init;
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_nic = "virtio-net-pci";
 }
 
-DEFINE_MACHINE("virt", xtensa_virt_machine_init)
+static void xtensa_virt_machine_class_init(ObjectClass *oc,
+                                           const void *data)
+{
+    xtensa_virt_machine_init(MACHINE_CLASS(oc));
+}
+
+static void xtensa_virt_machine_register_types(void)
+{
+    const TypeInfo xtensa_virt_machine_typeinfo = {
+        .name = target_combined_binary() ? MACHINE_TYPE_NAME("xtensa-virt") :
+                                           MACHINE_TYPE_NAME("virt"),
+        .parent = TYPE_MACHINE,
+        .class_init = xtensa_virt_machine_class_init,
+        .instance_size = sizeof(MachineState),
+    };
+    type_register_static(&xtensa_virt_machine_typeinfo);
+}
+
+type_init(xtensa_virt_machine_register_types)
-- 
2.55.0.windows.3


