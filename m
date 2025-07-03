Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81C3C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHid-0004jK-Q5; Thu, 03 Jul 2025 07:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHge-0008Pi-A1
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:05 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHga-0003zk-EU
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:03 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso3439643f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540458; x=1752145258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kv+3eABLjDWkuIjt/EEQUuT2EYyux5ATDXpfAYp2as0=;
 b=kzAyxTnUikvyR0ytqHDIm4DARouErWW16J6rjVOM+35+EyXv4x+GCbChf8jXo8HwYP
 XLEp57jA5IL1bMgd2/894ebykS1Xu+Pi9GcXpVcwsuHgKVokW/Sh8IQTlzG5sZUHTpoI
 XLpe1ZNNiZWfkYfzVUhn76hwlXZka5xXmoCk8JC9kNBnsOGAXMKzbE+JLAT/JeQlABxn
 utwSrt3/kxmCFdIe2znhJ2vs3R8KroZzC8TCiHgacyi3f5e9xrun1ieGzde6o7FL9iFQ
 ztXoqtj+TJ0LUZvYQgRn0eYYIsvboxp0GKgsHWmyZE5HkC4k9xZw3ex/8MPEzQP+I7i5
 55MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540458; x=1752145258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kv+3eABLjDWkuIjt/EEQUuT2EYyux5ATDXpfAYp2as0=;
 b=GOHLVWYFtYMU9V7uReqEPcwyMdVi1WgePrIJEAWdH8H7rFU6a8tnjm3AaShgefAw6h
 ULe5ODJZ66Ou5JSITPQd7cHLUn0LfnK6M/oND8KmM9VqDNdYWYc3TRZ5DK/vyG5iFdp9
 5JuwPQh2bs+bohovnFERvKNwCCuZ+mNwWUnwCoZrk9VWR5xicI6zm+QSFIg0/6QmrUJR
 MzA4hQOnL7YvaL+3J0bReaBAde8PpQ7Yqbxr8pzuHizxec+GBfw/MPNjXkT0xxkt7Dce
 p3xRZy5XKTZyR+VoO5fDlp9xirqomzC1OO+brWz0xn34JFbt/iBieSQH86uLvC2DSjHd
 P1Ag==
X-Gm-Message-State: AOJu0Yx83X1tAZGPfq949gadhzHwlIeVlV6UObzxgLu9AtOgcq/VrMZm
 3uKVIAhv40nTV8SfWaosK4GDnc0owa+32tJOea/rVUpzfLAt8bgzqQuXUnvtNQsXb0x5671jA/z
 YHRDhxPI=
X-Gm-Gg: ASbGncudnaBzdz5T99P8e92deH/tWzOE8bxvGOzLvzHMZ0BTGSSr6xS4o5yRarWZ0IN
 Cmtfo5G1PGGCo1iv8hlaaz/oJ6OP2DWQgxj7d2Hj2tlv5C6Ig8Af8daanShHs/ldCVqi+Brp3zV
 D8WSvx5S9Od8fKD/WuqDeRrredOZTItqo3rO3UJ4GmscRDpzn9Da4+xE678AvHAqMyZMaj4w8Ia
 XMLGUCDCwzuEfQxiT4jrX4qShgGGLcsxuZMmRj4rJBZQRTis3I/Dvf6zigqKD35Necr2v9xP+Yd
 jTL876l1Wk+lzxxMVmOmp8eGB/LOJa7JoEJwUrPGicybzSF5hGemqTdKt4RURewQMU5wmEu6BYI
 qC/gARH5ZjD0=
X-Google-Smtp-Source: AGHT+IEP9TKLC5P5AJ7QlKmZqQqcoj8rqfBj8NMgA0J1sYsb5B4zEW1QkyCXHPH+BN/0leJGYauyFg==
X-Received: by 2002:a05:6000:26d1:b0:3a4:f52d:8b05 with SMTP id
 ffacd0b85a97d-3b32db892femr2530477f8f.35.1751540458218; 
 Thu, 03 Jul 2025 04:00:58 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52ca4sm18489948f8f.58.2025.07.03.04.00.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:00:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 60/69] accel: Pass old/new interrupt mask to
 handle_interrupt() handler
Date: Thu,  3 Jul 2025 12:55:26 +0200
Message-ID: <20250703105540.67664-61-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
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

Update CPUState::interrupt_request once in cpu_interrupt().
Pass the old and new masks along.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-icount.h |  2 +-
 accel/tcg/tcg-accel-ops.h        |  2 +-
 include/system/accel-ops.h       |  2 +-
 accel/tcg/tcg-accel-ops-icount.c |  8 +++-----
 accel/tcg/tcg-accel-ops.c        |  4 +---
 system/cpus.c                    | 12 +++++++-----
 6 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-icount.h b/accel/tcg/tcg-accel-ops-icount.h
index 16a301b6dc0..1d9d66f0707 100644
--- a/accel/tcg/tcg-accel-ops-icount.h
+++ b/accel/tcg/tcg-accel-ops-icount.h
@@ -15,6 +15,6 @@ void icount_prepare_for_run(CPUState *cpu, int64_t cpu_budget);
 int64_t icount_percpu_budget(int cpu_count);
 void icount_process_data(CPUState *cpu);
 
-void icount_handle_interrupt(CPUState *cpu, int mask);
+void icount_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
 
 #endif /* TCG_ACCEL_OPS_ICOUNT_H */
diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 129af89c3e7..3f8eccb7a7f 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -17,7 +17,7 @@
 void tcg_vcpu_thread_precreate(CPUState *cpu);
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
-void tcg_handle_interrupt(CPUState *cpu, int mask);
+void tcg_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
 
 #endif /* TCG_ACCEL_OPS_H */
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index d4bd9c02d14..6d0791d73a4 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -67,7 +67,7 @@ struct AccelOpsClass {
     void (*synchronize_state)(CPUState *cpu);
     void (*synchronize_pre_loadvm)(CPUState *cpu);
 
-    void (*handle_interrupt)(CPUState *cpu, int mask);
+    void (*handle_interrupt)(CPUState *cpu, int old_mask, int new_mask);
 
     /* get_vcpu_stats: Append statistics of this @cpu to @buf */
     void (*get_vcpu_stats)(CPUState *cpu, GString *buf);
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index d0f7b410fab..500b5dd4942 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -147,14 +147,12 @@ void icount_process_data(CPUState *cpu)
     replay_mutex_unlock();
 }
 
-void icount_handle_interrupt(CPUState *cpu, int mask)
+void icount_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
 {
-    int old_mask = cpu->interrupt_request;
-
-    tcg_handle_interrupt(cpu, mask);
+    tcg_handle_interrupt(cpu, old_mask, new_mask);
     if (qemu_cpu_is_self(cpu) &&
         !cpu->neg.can_do_io
-        && (mask & ~old_mask) != 0) {
+        && (new_mask & ~old_mask) != 0) {
         cpu_abort(cpu, "Raised interrupt while not in I/O function");
     }
 }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 4931e536beb..a8c24cf8a4c 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -99,10 +99,8 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 }
 
 /* mask must never be zero, except for A20 change call */
-void tcg_handle_interrupt(CPUState *cpu, int mask)
+void tcg_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
 {
-    cpu->interrupt_request |= mask;
-
     /*
      * If called from iothread context, wake the target cpu in
      * case its halted.
diff --git a/system/cpus.c b/system/cpus.c
index c2ad640980c..8c2647f5f19 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -246,10 +246,8 @@ int64_t cpus_get_elapsed_ticks(void)
     return cpu_get_ticks();
 }
 
-static void generic_handle_interrupt(CPUState *cpu, int mask)
+static void generic_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
 {
-    cpu->interrupt_request |= mask;
-
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
     }
@@ -257,12 +255,16 @@ static void generic_handle_interrupt(CPUState *cpu, int mask)
 
 void cpu_interrupt(CPUState *cpu, int mask)
 {
+    int old_mask = cpu->interrupt_request;
+
     g_assert(bql_locked());
 
+    cpu->interrupt_request |= mask;
+
     if (cpus_accel->handle_interrupt) {
-        cpus_accel->handle_interrupt(cpu, mask);
+        cpus_accel->handle_interrupt(cpu, old_mask, cpu->interrupt_request);
     } else {
-        generic_handle_interrupt(cpu, mask);
+        generic_handle_interrupt(cpu, old_mask, cpu->interrupt_request);
     }
 }
 
-- 
2.49.0


