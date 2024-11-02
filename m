Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45C9E677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E0b-000331-RC; Sat, 02 Nov 2024 09:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0V-00031p-Ha; Sat, 02 Nov 2024 09:17:37 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0U-0001vU-19; Sat, 02 Nov 2024 09:17:35 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a99e3b3a411so592506366b.0; 
 Sat, 02 Nov 2024 06:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553451; x=1731158251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kcGj5THgATrhziRVv9fCQe0+3eD5yxcFJLfyqBCQbg=;
 b=GslqzL8YoE/OnYE5d0JdKGxBMouqhJKkbfxP5Id/dL8nBWSmxMXUoH+Y2A+5ZyUv+8
 9NFcTDAgdJgRUPgm0+LQYhO6BaT5pjVjE+RLSAN3zyTpfsIINvlR4v+9kzvga8/Iieyo
 92yriv8zY/9Huhx1fep6Xfvzbj9FcgSnHG/Aw6dQ6V6LIcgCEeGqDm3CJgQffUmpQVtu
 Q7cnpd2A4sUZtga/I74jgLOdKZJdowwIU7x65zRMIftY+CNop2l02b8G0cFQBAZzyHnD
 zSR4F51lgCv/4rAUWe+kLz7fHCIZPfOX3pjQpswGeKL2AC5efRXuHyhym66zaMyxsOac
 YdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553451; x=1731158251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+kcGj5THgATrhziRVv9fCQe0+3eD5yxcFJLfyqBCQbg=;
 b=bg00uDRet3P44y97g7YdQShWMRc2voWRcxYf4SCmH6F8dJAo3iTnAesl4+GkORNVON
 sPg/Y4Dw6J9ZyMpPnQn+1AWTCvbXeyVYqnMmF0DQvRpqFNkyM2Ly4Hh67dyf+pwq6Ldo
 cmZsBQR5kpgWKKjoSsWFDv5pWvsEk62O/6HgVkBZaS1ycOKT+opFZBoaGYNu/StWTtyx
 9pKj2ZRfk3PLQpJg3EB3y6EEoriKpRjTlfKOFc511DwZbyq4hbG6zd1bAj+yIiKcwr3I
 hdF2rAjxffSpILX2wKPNPDB6JQ0byV6AYyWk04F0OiRvb136BiCpcwRXhbpX7mE8wrcZ
 GnnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/XUsZYgzfZh6EXpc5iqJ7waZjPbJbHBxhXs5QRCcNMX6UVNUhRTgci+z06D3Y99MJAkDi+e0Uuvd6@nongnu.org,
 AJvYcCXWlrF9c/4oXJ1+J7lOx7ClPrAhlmR77DRLhJuBkicmNzN67+cVkyfxAqFLSj78yw4yfHc/rN8A+Y4=@nongnu.org
X-Gm-Message-State: AOJu0Yxed50SsUmtDam4756Swb2LFb9o8oz9GFhIbl/L4gOWDQANstjX
 zP+60/BaR9LUmbvQsj6PV4Kh+pAD4Ve/O4B4ot672NF6YoKg1BZccuIAJA==
X-Google-Smtp-Source: AGHT+IEnxgul9uLhsk3G0xkAYKbKaOFYkGNx2Q+eUGPRAy+dWb6Ln7E7QIKK90Je5/v7ykDPS8QCzw==
X-Received: by 2002:a17:907:9487:b0:a99:f5d8:726 with SMTP id
 a640c23a62f3a-a9e55abecaemr893323566b.23.1730553450734; 
 Sat, 02 Nov 2024 06:17:30 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:29 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 01/26] hw/ppc/e500: Do not leak struct boot_info
Date: Sat,  2 Nov 2024 14:16:50 +0100
Message-ID: <20241102131715.548849-2-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The struct is allocated once with g_new0() but never free()'d. Fix the leakage
by adding an attribute to struct PPCE500MachineState which avoids the
allocation.

While at it remove the obsolete /*< private >*/ markers.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.h |  9 +++++++--
 hw/ppc/e500.c | 17 ++++-------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 8c09ef92e4..4a1b42d44b 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -5,18 +5,23 @@
 #include "hw/platform-bus.h"
 #include "qom/object.h"
 
+struct boot_info {
+    uint32_t dt_base;
+    uint32_t dt_size;
+    uint32_t entry;
+};
+
 struct PPCE500MachineState {
-    /*< private >*/
     MachineState parent_obj;
 
     /* points to instance of TYPE_PLATFORM_BUS_DEVICE if
      * board supports dynamic sysbus devices
      */
     PlatformBusDevice *pbus_dev;
+    struct boot_info boot_info;
 };
 
 struct PPCE500MachineClass {
-    /*< private >*/
     MachineClass parent_class;
 
     /* required -- must at least add toplevel board compatible */
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index b760c6d6a2..ba83f33033 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -80,13 +80,6 @@
 
 #define PLATFORM_CLK_FREQ_HZ       (400 * 1000 * 1000)
 
-struct boot_info
-{
-    uint32_t dt_base;
-    uint32_t dt_size;
-    uint32_t entry;
-};
-
 static uint32_t *pci_map_create(void *fdt, uint32_t mpic, int first_slot,
                                 int nr_slots, int *len)
 {
@@ -919,7 +912,6 @@ void ppce500_init(MachineState *machine)
     bool kernel_as_payload;
     hwaddr bios_entry = 0;
     target_long payload_size;
-    struct boot_info *boot_info = NULL;
     int dt_size;
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
@@ -974,9 +966,8 @@ void ppce500_init(MachineState *machine)
         /* Register reset handler */
         if (!i) {
             /* Primary CPU */
-            boot_info = g_new0(struct boot_info, 1);
             qemu_register_reset(ppce500_cpu_reset, cpu);
-            env->load_info = boot_info;
+            env->load_info = &pms->boot_info;
         } else {
             /* Secondary CPUs */
             qemu_register_reset(ppce500_cpu_reset_sec, cpu);
@@ -1274,9 +1265,9 @@ void ppce500_init(MachineState *machine)
     }
     assert(dt_size < DTB_MAX_SIZE);
 
-    boot_info->entry = bios_entry;
-    boot_info->dt_base = dt_base;
-    boot_info->dt_size = dt_size;
+    pms->boot_info.entry = bios_entry;
+    pms->boot_info.dt_base = dt_base;
+    pms->boot_info.dt_size = dt_size;
 }
 
 static void e500_ccsr_initfn(Object *obj)
-- 
2.47.0


