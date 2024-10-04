Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3AECF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlJ2-0003fG-PC; Fri, 04 Oct 2024 12:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlGr-0007PB-TG
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:14 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlGo-0006P4-M8
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:13 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2facf40737eso28347201fa.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059707; x=1728664507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMPHX1jqQUTWI4pf2r0FuqonzJoCTqpttYtMaDPMSzU=;
 b=qpnimFtK6rIxbKY9VVh/UCpMRuYEjoz4H1C7JOAP81QG0G9FcUSbKagjEey/fvKg03
 +p06zPEI2eHHgLh9LR9RWxi1F0yO/2BcRm2KXGqyO3Irdp1yFLatTJwbG0L6fea8CN5y
 5TvjxyBw6jkYx3CfbUzu9Qw7CtGewyQI5umFtbnB3F1JnDpk6/17xtmeplV+5G+k3Zkf
 XmJBAqqRg5Lc66H52GbsNjwDs2uq8V/ySkbypIE6ksvZLtQ7xiNKX5qGWVZdJBseShTS
 xorJa2JKR5GZFzIffzteIV+XRiccqkDMJCZj3MBIENxdIaY37YV/7KKYxfZ4lVhLVdlI
 ji+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059707; x=1728664507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMPHX1jqQUTWI4pf2r0FuqonzJoCTqpttYtMaDPMSzU=;
 b=Ngv5aJrV+HVabhHMddBbZa4zkJlRBPF9nvw+dMZHsiYbeCN4cWhzizMTffqbrfK8xT
 k5ebqBGzXUhvzBJRVECAugYOvM9YLIpNCBLLhgj2wzJ8tLPwsz9NpEqHkQO8eY2y9IjE
 +93BMNOYygcqOxi9tagrhoGyM5OwmtUUPDxN9TX3o4VZBkpilH/phcMuweRTq4EAUSMH
 6+OFYHQjjg3j2+xhKWaxMaBsjxKBrckg3oR3tkbuocSUZvPWKZSDAxBh9Ngw5Vlg8eQH
 RzNmWcp7eCjyDJyHLEOdwsTHFPkxYjZazPwkcCIGeXhqi204BXhTimpJNSEvo3adqPmg
 /JvA==
X-Gm-Message-State: AOJu0Yz3feTxC9SiRpOQ8lW7FN0nzrik8QmwFYl5o+BZ7D14/ZYspFVM
 yp2OfjkA51Io1BfUtJR34h4DEzua0YrPv5+Uwd4VKpHKbJzAP6gyUei6ZL301P8hJXlH5cu37QN
 77RcGfg==
X-Google-Smtp-Source: AGHT+IGx7YQ9AludivP/JgpYsPv0iqZu3pTCEacheY6CQHjkkwcmkF+BNjJ5qSRXCNW56q6LonKaKg==
X-Received: by 2002:a2e:3806:0:b0:2f3:b8dc:7d24 with SMTP id
 38308e7fff4ca-2faf3c5f4f3mr16451211fa.17.1728059707174; 
 Fri, 04 Oct 2024 09:35:07 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9b3b441sm195821fa.139.2024.10.04.09.35.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:35:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 17/25] hw/m68k: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 13:30:33 -0300
Message-ID: <20241004163042.85922-18-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

Mechanical change using:

  $ end=be; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' hw/m68k/); \
    done

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


