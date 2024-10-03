Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA0DCF34D5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 23:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swVTW-0007fu-CV; Thu, 03 Oct 2024 19:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVTT-0007ef-3H
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVTQ-0003oA-5m
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:10 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42e5e758093so13320175e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727998986; x=1728603786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1QD6cD3yUP4Co4YUKGgzzxrZ+bpsLuJ7Figy/5ND0k=;
 b=InJv+gx02WJp74aMtkkGQjVqi92Bnf7F/OWzvMm2doFX6P6rO3kPupha5KUvJLlHpE
 Ch0mICgcZbfdrpI2zG12s8eIwT6xfzU0zPWZIXo20a8qLVbayiQO+okZx13ClCRp1zpB
 qQSkwBaxNi8IVFN662d/NujMB2ADZMOLz27GvpBQoJe752Jb3FkID748zgoVNAQYR1zF
 NCWaVk0lRWFA2K57AiEKlEWh8jeR+/plOQy+pmG2QMfKusqFXj3DV3SrZAldaev7m/oQ
 tfLKsxvxcOZ+Ocbk9QCyKDAGpALjFJlKcrnqYAOf81I6oUOGUJXyLDR7pEiWI+33Fq9e
 97Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727998986; x=1728603786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1QD6cD3yUP4Co4YUKGgzzxrZ+bpsLuJ7Figy/5ND0k=;
 b=mf55CP7m5MHzoCzrS5bVRX32E3K3O60XBSzDu/WuAnK1Bxra32+F9vmFblWZjtZ1CG
 Tn9UG6Gd7IVJYyyhTMlGwCGw2o2sjUYUMFKsgmuCjAUEMf6jFrU+AIcKBeFRdJsEcQjD
 b3elUk6TSdTAbBHkuKWvAJ2uFSDenkeYvnGP6KIYSlXsSyC1mt/49h/nr8dBkj/feCJe
 fu2M1TAqUHJLpdY2r7xeGaNTKzDaWgvokk+bkzGfiihSQQ8fjRotN0E538jmgnmEaqvG
 WOrziqU3enjIQ0Duz5mbNtSO8t0gM4YfGw5Fl9J9n7se0Dw3YnmvxR76GNvcEsbTSMFC
 f1nw==
X-Gm-Message-State: AOJu0YwyAUrY9KdQ0iymf4GO8c/8ipPmi4WwtW9CIin3kLaLgirQQHmh
 cS5FCbj/HSczm3zxDvONhkLLtaU16LRy9aEdXAISoyFHDKYXJEcHruBax0tm8+/e2k19+UVSyRV
 rdio=
X-Google-Smtp-Source: AGHT+IHnogbccrvdvf0bnbP1G/jvo+XfKiRZju4L/aWRsl3BFT5ro7mTJVZpSj4D60pGQ9j/vMh9UA==
X-Received: by 2002:a05:600c:524c:b0:42c:bae0:f065 with SMTP id
 5b1f17b1804b1-42f85aa32famr4151435e9.5.1727998986282; 
 Thu, 03 Oct 2024 16:43:06 -0700 (PDT)
Received: from localhost.localdomain (45.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.45]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a20537sm1340495e9.15.2024.10.03.16.43.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Oct 2024 16:43:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 06/16] hw/m68k: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 01:42:01 +0200
Message-ID: <20241003234211.53644-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003234211.53644-1-philmd@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The M68K architecture uses big endianness. Directly use
the big-endian LD/ST API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/bootinfo.h  | 28 ++++++++++++++--------------
 hw/m68k/mcf5208.c   |  2 +-
 hw/m68k/next-cube.c |  2 +-
 hw/m68k/q800.c      |  4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
index 70c1dc0e8c3..0b3e7c4ea01 100644
--- a/hw/m68k/bootinfo.h
+++ b/hw/m68k/bootinfo.h
@@ -14,39 +14,39 @@
 
 #define BOOTINFO0(base, id) \
     do { \
-        stw_p(base, id); \
+        stw_be_p(base, id); \
         base += 2; \
-        stw_p(base, sizeof(struct bi_record)); \
+        stw_be_p(base, sizeof(struct bi_record)); \
         base += 2; \
     } while (0)
 
 #define BOOTINFO1(base, id, value) \
     do { \
-        stw_p(base, id); \
+        stw_be_p(base, id); \
         base += 2; \
-        stw_p(base, sizeof(struct bi_record) + 4); \
+        stw_be_p(base, sizeof(struct bi_record) + 4); \
         base += 2; \
-        stl_p(base, value); \
+        stl_be_p(base, value); \
         base += 4; \
     } while (0)
 
 #define BOOTINFO2(base, id, value1, value2) \
     do { \
-        stw_p(base, id); \
+        stw_be_p(base, id); \
         base += 2; \
-        stw_p(base, sizeof(struct bi_record) + 8); \
+        stw_be_p(base, sizeof(struct bi_record) + 8); \
         base += 2; \
-        stl_p(base, value1); \
+        stl_be_p(base, value1); \
         base += 4; \
-        stl_p(base, value2); \
+        stl_be_p(base, value2); \
         base += 4; \
     } while (0)
 
 #define BOOTINFOSTR(base, id, string) \
     do { \
-        stw_p(base, id); \
+        stw_be_p(base, id); \
         base += 2; \
-        stw_p(base, \
+        stw_be_p(base, \
                  (sizeof(struct bi_record) + strlen(string) + \
                   1 /* null termination */ + 3 /* padding */) & ~3); \
         base += 2; \
@@ -59,13 +59,13 @@
 
 #define BOOTINFODATA(base, id, data, len) \
     do { \
-        stw_p(base, id); \
+        stw_be_p(base, id); \
         base += 2; \
-        stw_p(base, \
+        stw_be_p(base, \
                  (sizeof(struct bi_record) + len + \
                   2 /* length field */ + 3 /* padding */) & ~3); \
         base += 2; \
-        stw_p(base, len); \
+        stw_be_p(base, len); \
         base += 2; \
         for (unsigned i_ = 0; i_ < len; ++i_) { \
             stb_p(base++, data[i_]); \
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index b6677ad6bc3..e37cd50d189 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -359,7 +359,7 @@ static void mcf5208evb_init(MachineState *machine)
         /* Initial PC is always at offset 4 in firmware binaries */
         ptr = rom_ptr(0x4, 4);
         assert(ptr != NULL);
-        env->pc = ldl_p(ptr);
+        env->pc = ldl_be_p(ptr);
     }
 
     /* Load kernel.  */
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9b78767ea8e..9832213e7ec 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1036,7 +1036,7 @@ static void next_cube_init(MachineState *machine)
         /* Initial PC is always at offset 4 in firmware binaries */
         ptr = rom_ptr(0x01000004, 4);
         g_assert(ptr != NULL);
-        env->pc = ldl_p(ptr);
+        env->pc = ldl_be_p(ptr);
         if (env->pc >= 0x01020000) {
             error_report("'%s' does not seem to be a valid firmware image.",
                          bios_name);
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index fa7683bf76f..556604e1dcf 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -684,9 +684,9 @@ static void q800_machine_init(MachineState *machine)
 
             ptr = rom_ptr(MACROM_ADDR, bios_size);
             assert(ptr != NULL);
-            stl_phys(cs->as, 0, ldl_p(ptr));    /* reset initial SP */
+            stl_phys(cs->as, 0, ldl_be_p(ptr));    /* reset initial SP */
             stl_phys(cs->as, 4,
-                     MACROM_ADDR + ldl_p(ptr + 4)); /* reset initial PC */
+                     MACROM_ADDR + ldl_be_p(ptr + 4)); /* reset initial PC */
         }
     }
 }
-- 
2.45.2


