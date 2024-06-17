Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48130C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 06:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ5rz-0003oh-3P; Mon, 17 Jun 2024 02:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5rv-0003oN-Qa
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:29:32 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5ru-0003Tj-9L
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:29:31 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-709423bc2e5so620495a12.0
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 23:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718605769; x=1719210569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGDcQ/GV1X1agXVxeAbW8TiRh8SRfIqjde3rxwV7xb0=;
 b=H7UwL1AfHcBZWnc2sIxfTJaZmE3ZqV3pD0ayAcbjEa3gtUmf6Ucms294OBNT9FcEjp
 bBr7ZMxbo2rCc/jTP5awQTz5jLbLXcTHCF7dOmmg3OPbJPyp5QitkWqdvdtZZoYiY/b6
 JdEB1421VucxMIGLcPFol7nKXeY0ebuK/VLVmP/OvF3J+rSx6uiUNIdp9JTn6KPvzokI
 cM/3U+wr3/jk5FZf6GhJY/aeaG1IVHZmcy2nGRTWhx07i411YuImmowpZ1pJB2tH4vsq
 Ik096fmVhxIcmwLYpCSMqi/YZjKddO1ayRmqtfL4AsN0hyPn9AownMAECQEc9zU2tVil
 PkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718605769; x=1719210569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YGDcQ/GV1X1agXVxeAbW8TiRh8SRfIqjde3rxwV7xb0=;
 b=cbUtlhJVLrSHhBugUtSwiQZyjsjYMywDd1kHiMCUz4XuKBe+S0I4LlwknR0RkzoqVL
 QZPfcP8N1ycwlHWIYQABD5AeIK+ymGShfA4D1P+IzVU89L9srNC75ehdB6yY4pasqq3D
 5fre+j0nQbvUlmi7N7uqLR4I1tBaQonhz9om4Hjc4O8PvGAvkheo900eSbqh8wf7PXCS
 jQ8d+pWk7+NXoUO/nh6Cf/UWB+PB4fy0FFXSreg4FKq9CseU86qqiq9tzIZdMUPy31aM
 EPKiizQ0c/qF9/Mgxg0Ib4eDyjF+kOSbPplVbB9t96w6gNzx+Gj5kWIFCHB4Zvj7jcB6
 vZNg==
X-Gm-Message-State: AOJu0YzGGSQbvVBfawu2ZMO9nog7Pqc4RqyfB6WlJy6iwY42QOZrI5Oc
 cI7y1CyhHoSvqTpzl9bKc/qYZUsf8nIUkxLpWT9SlmeedUkwff/iz8drkeeWCkpyrTG5luS6Abr
 m
X-Google-Smtp-Source: AGHT+IGYC6kt55a1dAW+HHcHZQc2uR0UutKuR8OSuQIS4gLXu/9xAmR5dzjrRmdR+TTCiHkVBAH00Q==
X-Received: by 2002:a17:90a:a389:b0:2c5:2acb:1acd with SMTP id
 98e67ed59e1d1-2c52acb1bf8mr1693418a91.10.1718605768724; 
 Sun, 16 Jun 2024 23:29:28 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a75ed69csm10641863a91.14.2024.06.16.23.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jun 2024 23:29:28 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 7/9] gdbstub: Make get cpu and hex conversion functions
 non-internal
Date: Mon, 17 Jun 2024 06:28:47 +0000
Message-Id: <20240617062849.3531745-8-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617062849.3531745-1-gustavo.romero@linaro.org>
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Make the gdb_first_attached_cpu and gdb_hextomem non-internal so they
are not confined to use only in gdbstub.c.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 gdbstub/internals.h        | 2 --
 include/exec/gdbstub.h     | 5 +++++
 include/gdbstub/commands.h | 6 ++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 34121dc61a..81875abf5f 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -107,7 +107,6 @@ static inline int tohex(int v)
 
 void gdb_put_strbuf(void);
 int gdb_put_packet_binary(const char *buf, int len, bool dump);
-void gdb_hextomem(GByteArray *mem, const char *buf, int len);
 void gdb_memtohex(GString *buf, const uint8_t *mem, int len);
 void gdb_memtox(GString *buf, const char *mem, int len);
 void gdb_read_byte(uint8_t ch);
@@ -130,7 +129,6 @@ bool gdb_got_immediate_ack(void);
 /* utility helpers */
 GDBProcess *gdb_get_process(uint32_t pid);
 CPUState *gdb_get_first_cpu_in_process(GDBProcess *process);
-CPUState *gdb_first_attached_cpu(void);
 void gdb_append_thread_id(CPUState *cpu, GString *buf);
 int gdb_get_cpu_index(CPUState *cpu);
 unsigned int gdb_get_max_cpus(void); /* both */
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 1bd2c4ec2a..77e5ec9a5b 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -135,4 +135,9 @@ void gdb_set_stop_cpu(CPUState *cpu);
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
 extern const GDBFeature gdb_static_features[];
 
+/**
+ * Return the first attached CPU
+ */
+CPUState *gdb_first_attached_cpu(void);
+
 #endif /* GDBSTUB_H */
diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index 2204c3ddbe..914b6d7313 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -93,4 +93,10 @@ void gdb_extend_set_table(GdbCmdParseEntry *table, int size);
  */
 void gdb_extend_qsupported_features(char *qsupported_features);
 
+/**
+ * Convert a hex string to bytes. Conversion is done per byte, so 2 hex digits
+ * are converted to 1 byte. Invalid hex digits are treated as 0 digits.
+ */
+void gdb_hextomem(GByteArray *mem, const char *buf, int len);
+
 #endif /* GDBSTUB_COMMANDS_H */
-- 
2.34.1


