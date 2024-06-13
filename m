Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E95C27C6E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHo8y-0000jl-K4; Thu, 13 Jun 2024 13:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8v-0000iJ-5o
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:46 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8t-0005rH-KW
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:44 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f6f38b1ab0so10632895ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718299302; x=1718904102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGDcQ/GV1X1agXVxeAbW8TiRh8SRfIqjde3rxwV7xb0=;
 b=jfNTqMjVHbp+IiFyrWM1lERO4TtvWhZQmOAnBDpb0iZ9mA+jiiynO3+RPHe9UBmAQM
 uPgr2oq0xiIJgW1j8h6cbJko1VYzyEHGxmRNY1Gx0UoE5SI+5f6M5+2EGzN2Hn1XX91v
 1snu4K2mOoRHjLQvTq8zXojNalv595brJ5GIUm71khtpHvmQZ/npqgzgFxvQ2viinCu1
 j6NKvZVR1R54hhV5I/fagemB/tJ0i5NUHb0fj4vCLFUb1gB+2yGftE+86GURIW/vEuKV
 B2ciodogRc8WZC6jJHrcUgrl25ODONExoDa2+PsYhixSwXKHvTTLG4OlFja6WAW52WEo
 IjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718299302; x=1718904102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YGDcQ/GV1X1agXVxeAbW8TiRh8SRfIqjde3rxwV7xb0=;
 b=jJuAeT8qT3ywe1/gepjC3j2eJaunMUL4KjWdZbl+J82xmaKBtnFMlycvLaOmAnHuI4
 f/WwqBB3Fgfw5+4Tl3YG6pMYEH+8twtWjiJPDIaw6fz3dYpiFfRNO2tE9ZVu3d1wBrhp
 /adajwM/AkLV0QYjwUNsmHB/2iq80VxaHMFqmix156VCNNH/ZsiTWMfIeIBxVGdM8kow
 Jl5zJ+cCBpk/5Rf5i+dDyoLRnRrz/E/Q/q2YNyg2bP3DfhIsI216o7hG3QwBGGhsVpXO
 /uYoE7T42p8Y3SSVng+fXt7t4HfKhyGFn3SDEje0PcZ/VQ08aqgpOM2aEpW9czsYH960
 H74g==
X-Gm-Message-State: AOJu0YwfL7sz1N+YsWzrE34HI6I/p24FwyidK6EikOsSmGG/QtRdtXph
 AC5zHV9I/Xewj4KKhkdbVkhg8s0eFLNIzCp5BdASwnOUIHbWuDRUd/47J3PgfmRVCYEiiKmWyPN
 U
X-Google-Smtp-Source: AGHT+IERQ0n0TtUFsebsmvbP3FcT4ejJoLZ02CvY1kr9T053IU6s2XYfe5IsyS+8fZJymtIUR3bbbg==
X-Received: by 2002:a17:903:1c8:b0:1f7:1730:b456 with SMTP id
 d9443c01a7336-1f862a0cca5mr4000635ad.57.1718299301878; 
 Thu, 13 Jun 2024 10:21:41 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e5b85bsm16443885ad.32.2024.06.13.10.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 10:21:41 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v2 7/9] gdbstub: Make get cpu and hex conversion functions
 non-internal
Date: Thu, 13 Jun 2024 17:21:01 +0000
Message-Id: <20240613172103.2987519-8-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613172103.2987519-1-gustavo.romero@linaro.org>
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x634.google.com
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


