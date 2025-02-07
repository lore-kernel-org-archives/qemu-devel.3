Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D00C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQLU-00012M-Sr; Fri, 07 Feb 2025 10:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKF-00085B-C4
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:30 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQK7-0003yl-BX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:26 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so487864966b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738942277; x=1739547077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lDr+EsB9w5MfJH5NPFFSWodYWU+B9nCbgauMyudXbU=;
 b=P4X9tpfGGZlzbK7ymhNUbk3UfHthspQPQLyErWWEwB73Z0MfVGS15v6bvBk5QGeP9X
 xctUifOLrc3p78AJ+1L/bCb/lAUkk/7EItNuwOW3tgZwwW/Lv7+w7e2nRPSlXOrg/osz
 JBPmWcMNdGCqz7lPZEqCGuSLOyQWXwSv17C/WWFDtSsJStzf8tbQ4rvuZkkFUJUM+HNw
 PxWg3xHLVTxEPg5zXdFo1+z1Z6nUpmh13cDU3cw4FGup5CMrTzdNqpXaNp3PwnlMkd+X
 f7vDTCjPsfMUdbTritTS91ZY5Jpq7xc/3vCsAnro02Q+yzhU68s/iM+p6KMObkR6Ud7H
 5bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942277; x=1739547077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5lDr+EsB9w5MfJH5NPFFSWodYWU+B9nCbgauMyudXbU=;
 b=Qa0goGYQmFyqvf0jksyXaagTwPl0jmD65f8J5pLI0lZB+mh7KGw5Grl2i9KD4HaWjg
 Tgl8PEzbBk2Cuesvz6aUSmcQC0IOuvWGz9lUlwGhZZf7+zNjcOSFq3SLUisF2wMYNO+k
 NEjI1ojVjEoUWEib7FPOhWWZX3uwvmFMvFSJfH0gZfkA7rDSuQPS4Hc/4K2UoHRQC9B7
 SdDQPqo9osG/o+FgK/wI21s/NfaD13gl1LlRK6t3i/Ri/zJJTiOeGftP8yw9CE1eXrF8
 tiNOTVM04mXvdTtVDBnYK05HZi1KlxwmSfvcCZugc/boG93u3TSkRmAX1o5iZ8Rg/EGn
 jZ1Q==
X-Gm-Message-State: AOJu0Yw0jz+xXHgrJ9It9hBfN5ceJ2LZDuEqXGH+Ojabe9Vs0jTbdhlP
 Wn0Hb+E2qfBvxDT4UYHxp1cE1mLnHKplyXbWdA9g/i94yr3+iX5gaitWxz447T8=
X-Gm-Gg: ASbGncsk6+LDoCRQPFcufScVayCfk8ygDIyidoeSyAuqCA3pigWvRf49VkOlpPeWNdm
 NZmJfDl5pXJqHXBDV27C7bejiltdpVxYCpg/Wj7hlyhwH3r+MJW8hnQ76PrPqxri+57Vi9bqh//
 ZELefaUedz25WmMoguiFiX6v18/zxU3jMo95uxO2vWrTI4YWjhiXN3d2Vn2Fijnu+rf3wDM3Pqa
 mkhhP1DT3Mg0DbNHSxuCe6xuddLOffJdPIeHInszauVzBQ1fX8bZoYop9/akyiaBH/vVte2EZKg
 UzIiUFL3bknngw5nOg==
X-Google-Smtp-Source: AGHT+IF9+jxXYpCMp+bOSqJy3krGolEAMQ48O/qIqY5HelrVvwMwYm0I/WGcxVHeOIFnEIx3Mjzubw==
X-Received: by 2002:a17:907:3e8d:b0:ab7:63fa:e49c with SMTP id
 a640c23a62f3a-ab789cbe110mr419239766b.36.1738942277438; 
 Fri, 07 Feb 2025 07:31:17 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab772f84417sm286389666b.53.2025.02.07.07.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:31:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CFA4B5FB14;
 Fri,  7 Feb 2025 15:31:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Kyle Evans <kevans@freebsd.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 05/17] tests/qtest: rename qtest_send_prefix and roll-up
 into qtest_send
Date: Fri,  7 Feb 2025 15:31:00 +0000
Message-Id: <20250207153112.3939799-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153112.3939799-1-alex.bennee@linaro.org>
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

qtest_send_prefix never actually sent something over the chardev, all
it does is print the timestamp to the QTEST_LOG when enabled. So
rename the function, make it static, remove the unused CharDev and
simplify all the call sites by handling that directly with
qtest_send (and qtest_log_send).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/system/qtest.h |  1 -
 hw/ppc/spapr_rtas.c    |  1 -
 hw/riscv/riscv_hart.c  |  1 -
 system/qtest.c         | 26 +++-----------------------
 4 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/include/system/qtest.h b/include/system/qtest.h
index c161d75165..6ddddc501b 100644
--- a/include/system/qtest.h
+++ b/include/system/qtest.h
@@ -24,7 +24,6 @@ static inline bool qtest_enabled(void)
 }
 
 #ifndef CONFIG_USER_ONLY
-void qtest_send_prefix(CharBackend *chr);
 void G_GNUC_PRINTF(2, 3) qtest_sendf(CharBackend *chr, const char *fmt, ...);
 void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words));
 bool qtest_driver(void);
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index df2e837632..503d441b48 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -565,7 +565,6 @@ static bool spapr_qtest_callback(CharBackend *chr, gchar **words)
         g_assert(rc == 0);
         res = qtest_rtas_call(words[1], nargs, args, nret, ret);
 
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %"PRIu64"\n", res);
 
         return true;
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index ad67cd7645..a55d156668 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -94,7 +94,6 @@ static bool csr_qtest_callback(CharBackend *chr, gchar **words)
         g_assert(rc == 0);
         csr_call(words[1], cpu, csr, &val);
 
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "OK 0 "TARGET_FMT_lx"\n", (target_ulong)val);
 
         return true;
diff --git a/system/qtest.c b/system/qtest.c
index bb1efba9fd..28b6fac37c 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -265,7 +265,7 @@ static int hex2nib(char ch)
     }
 }
 
-void qtest_send_prefix(CharBackend *chr)
+static void qtest_log_timestamp(void)
 {
     if (!qtest_log_fp || !qtest_opened) {
         return;
@@ -282,7 +282,7 @@ static void G_GNUC_PRINTF(1, 2) qtest_log_send(const char *fmt, ...)
         return;
     }
 
-    qtest_send_prefix(NULL);
+    qtest_log_timestamp();
 
     va_start(ap, fmt);
     vfprintf(qtest_log_fp, fmt, ap);
@@ -301,6 +301,7 @@ static void qtest_server_char_be_send(void *opaque, const char *str)
 
 static void qtest_send(CharBackend *chr, const char *str)
 {
+    qtest_log_timestamp();
     qtest_server_send(qtest_server_send_opaque, str);
 }
 
@@ -324,7 +325,6 @@ static void qtest_irq_handler(void *opaque, int n, int level)
     if (irq_levels[n] != level) {
         CharBackend *chr = &qtest->qtest_chr;
         irq_levels[n] = level;
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "IRQ %s %d\n",
                     level ? "raise" : "lower", n);
     }
@@ -380,19 +380,16 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         is_outbound = words[0][14] == 'o';
         dev = DEVICE(object_resolve_path(words[1], NULL));
         if (!dev) {
-            qtest_send_prefix(chr);
             qtest_send(chr, "FAIL Unknown device\n");
             return;
         }
 
         if (is_named && !is_outbound) {
-            qtest_send_prefix(chr);
             qtest_send(chr, "FAIL Interception of named in-GPIOs not yet supported\n");
             return;
         }
 
         if (irq_intercept_dev) {
-            qtest_send_prefix(chr);
             if (irq_intercept_dev != dev) {
                 qtest_send(chr, "FAIL IRQ intercept already enabled\n");
             } else {
@@ -419,7 +416,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             }
         }
 
-        qtest_send_prefix(chr);
         if (interception_succeeded) {
             irq_intercept_dev = dev;
             qtest_send(chr, "OK\n");
@@ -438,7 +434,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         dev = DEVICE(object_resolve_path(words[1], NULL));
         if (!dev) {
-            qtest_send_prefix(chr);
             qtest_send(chr, "FAIL Unknown device\n");
             return;
         }
@@ -457,7 +452,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         irq = qdev_get_gpio_in_named(dev, name, num);
 
         qemu_set_irq(irq, level);
-        qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "outb") == 0 ||
                strcmp(words[0], "outw") == 0 ||
@@ -480,7 +474,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         } else if (words[0][3] == 'l') {
             cpu_outl(addr, value);
         }
-        qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "inb") == 0 ||
         strcmp(words[0], "inw") == 0 ||
@@ -501,7 +494,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         } else if (words[0][2] == 'l') {
             value = cpu_inl(addr);
         }
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "OK 0x%04x\n", value);
     } else if (strcmp(words[0], "writeb") == 0 ||
                strcmp(words[0], "writew") == 0 ||
@@ -537,7 +529,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
                                 &data, 8);
         }
-        qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "readb") == 0 ||
                strcmp(words[0], "readw") == 0 ||
@@ -571,7 +562,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                                &value, 8);
             tswap64s(&value);
         }
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
     } else if (strcmp(words[0], "read") == 0) {
         g_autoptr(GString) enc = NULL;
@@ -593,7 +583,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         enc = qemu_hexdump_line(NULL, data, len, 0, 0);
 
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "OK 0x%s\n", enc->str);
 
         g_free(data);
@@ -613,7 +602,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
                            len);
         b64_data = g_base64_encode(data, len);
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %s\n", b64_data);
 
         g_free(data);
@@ -649,7 +637,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                             len);
         g_free(data);
 
-        qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "memset") == 0) {
         uint64_t addr, len;
@@ -673,7 +660,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             g_free(data);
         }
 
-        qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
     }  else if (strcmp(words[0], "b64write") == 0) {
         uint64_t addr, len;
@@ -705,10 +691,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
                             len);
 
-        qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "endianness") == 0) {
-        qtest_send_prefix(chr);
         if (target_words_bigendian()) {
             qtest_sendf(chr, "OK big\n");
         } else {
@@ -726,7 +710,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                                             QEMU_TIMER_ATTR_ALL);
         }
         new_ns = qemu_clock_advance_virtual_time(old_ns + ns);
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "%s %"PRIi64"\n",
                     new_ns > old_ns ? "OK" : "FAIL", new_ns);
     } else if (strcmp(words[0], "module_load") == 0) {
@@ -734,7 +717,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         int rv;
         g_assert(words[1] && words[2]);
 
-        qtest_send_prefix(chr);
         rv = module_load(words[1], words[2], &local_err);
         if (rv > 0) {
             qtest_sendf(chr, "OK\n");
@@ -752,13 +734,11 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         ret = qemu_strtoi64(words[1], NULL, 0, &ns);
         g_assert(ret == 0);
         new_ns = qemu_clock_advance_virtual_time(ns);
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "%s %"PRIi64"\n",
                     new_ns == ns ? "OK" : "FAIL", new_ns);
     } else if (process_command_cb && process_command_cb(chr, words)) {
         /* Command got consumed by the callback handler */
     } else {
-        qtest_send_prefix(chr);
         qtest_sendf(chr, "FAIL Unknown command '%s'\n", words[0]);
     }
 }
-- 
2.39.5


