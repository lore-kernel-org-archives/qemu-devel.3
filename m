Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2438ACCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJH2-0005Vc-RV; Tue, 21 Oct 2025 16:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGp-00050l-3h
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGm-00016O-KY
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:50 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4711f3c386eso30320775e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079666; x=1761684466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kLrXAGfmdWrgxLaTu8U7Tv+AagNM/KHjl/sq9+z40ow=;
 b=HuqXrX87NHLCptbeUolbxJI7dAe9LjdsxICxuhOAXON4tQc9SWAPsBrb4Y49TPXPY8
 qvbEiuppoY2+cA2lCByRIw8p69HiU/a21aIZdypuD8U3RW146cuJlUZX5FLtlm5C2k8F
 UyeLJIUsqyjC0O9Lmz/z1OfgSNps047JqbMcby5IrNCKWaljxybj4fLuPttrzIRJpGNl
 0kAW2XU9J6OC2Aju4nP77ZMOVUZSf5tJU+Mwb8L/fWj+s6TLOc+vEpKE/fTr5iD68UtR
 MWEnji/6/IY5rqbigXM34FuMRAEW6IIitO5F0MzKcau2uFa3Fsu5oLEgexX4gEaPXGm7
 S9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079666; x=1761684466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLrXAGfmdWrgxLaTu8U7Tv+AagNM/KHjl/sq9+z40ow=;
 b=tJVXrb13nKaS+s5uKF8rgwcjT5QVr8XplZIk+XY5Gwbfq0DmD+FOCcj+45YGUWf/WU
 MmPEiavPBSRgJH7z4TpSCA2a88FOs6bR792WU0b7WccShld1hXs5b1DEq052mhVU8gu9
 vaD1ERtzsPL9FSytOfx6q0Ry+jDGboPp6lIze+Sccih5t4M+BLJoJq9ZEol3kJB9P5vL
 gpurKkOaqPZycKnOpdqIiO/zeK9y/S5QPuegN0pQBOKDy8bk/h0aIXFjfPt7zE6Ly3/s
 AqGC7Tqe7jXLKER9ag3b6OY7G+uWJ4dGUb/xJUmSaduLtl8c9lijhz6XT5nrIZPOQQQH
 pIjA==
X-Gm-Message-State: AOJu0YwZELPsAe/s+GmMfTG7oF6fJWzo5R3Hog0zhbxUFHy1xn5s73ch
 7wsteJmhBLsdW+pvJ3iPPIdoT8Nfbg/b34RImoqOH4hJHR0qe27ckDqwTzoOllLKqAizJChdr5W
 tinokVNE=
X-Gm-Gg: ASbGncvBYH7E+xp81NXWfnF5Dr6w0GSeYOhXPm0VZi2Rc11lXpMJLDVi3rYObS/Of1f
 3GVFCELp3jiOJHBbPcxHM+P9wIfyR2v9EiQ5TWCx8bVMW0ZbIOucEZ9AeONiBVRfNbvc4KLu318
 yMDAPUSgv+8Fnhmr0qe8dANSednsA2DiPGJndAjlA1FNkQi9VXb17ZgFA39FT4JvR6fcsTjdqen
 WbGaoOtF0gM3tmGsPBcLcIoo9/mqp85v8xOPbAn/Vu8qbpsdRkKyvk+E/raLKlusN0/MLBMRI9o
 Lvv3KKTq/H19epM3gE5dfh0OCVyb/zvAcKyyF6kkPHAdvP1EQRRWfKjb1qa2HaN4Yl+8Q5cBOLP
 uJgzb3ZMvzpht0s8kYgP1ULTr8RY7U9D2ah2kp32wy1lXPzJnKna2qDH/ESEgYS7HFR6hbD6+/V
 VbL9hrZof9J/MjNglIupZHr+ZyoZeBzAhEhQZDAY00q25UU3OO9Q==
X-Google-Smtp-Source: AGHT+IFYCvuUWE3CC9vjZou4ht1ko0skcZlXIvwOSYlX9dWIRoNsLdynSz4CTTu6Fbz5U6JSeEtlLw==
X-Received: by 2002:a05:600c:468d:b0:45f:28d2:bd38 with SMTP id
 5b1f17b1804b1-471178b14acmr130860395e9.18.1761079665776; 
 Tue, 21 Oct 2025 13:47:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42b4867sm9617325e9.14.2025.10.21.13.47.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:47:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/45] hw/core: Introduce MachineClass::get_default_cpu_type()
 helper
Date: Tue, 21 Oct 2025 22:46:23 +0200
Message-ID: <20251021204700.56072-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
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

MachineClass::get_default_cpu_type() runs once the machine is
created, being able to evaluate runtime checks; it returns the
machine default CPU type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20251020221508.67413-7-philmd@linaro.org>
---
 include/hw/boards.h |  6 ++++++
 hw/core/machine.c   | 10 ++++++++++
 system/vl.c         |  2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index c45272b7414..014007920dd 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -25,6 +25,11 @@ OBJECT_DECLARE_TYPE(MachineState, MachineClass, MACHINE)
 
 extern MachineState *current_machine;
 
+/**
+ * machine_default_cpu_type: Return the machine default CPU type.
+ * @ms: Machine state
+ */
+const char *machine_default_cpu_type(const MachineState *ms);
 /**
  * machine_class_default_cpu_type: Return the machine default CPU type.
  * @mc: Machine class
@@ -303,6 +308,7 @@ struct MachineClass {
     int numa_mem_align_shift;
     const char * const *valid_cpu_types;
     GPtrArray *(*get_valid_cpu_types)(const MachineState *ms);
+    const char *(*get_default_cpu_type)(const MachineState *ms);
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index cd2f1414a77..cd63803000c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1556,6 +1556,16 @@ const char *machine_class_default_cpu_type(MachineClass *mc)
     return mc->default_cpu_type;
 }
 
+const char *machine_default_cpu_type(const MachineState *ms)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    if (mc->get_default_cpu_type) {
+        return mc->get_default_cpu_type(ms);
+    }
+    return machine_class_default_cpu_type(mc);
+}
+
 static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
diff --git a/system/vl.c b/system/vl.c
index a96063f9901..fd98ea52d9c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3817,7 +3817,7 @@ void qemu_init(int argc, char **argv)
     migration_object_init();
 
     /* parse features once if machine provides default cpu_type */
-    current_machine->cpu_type = machine_class_default_cpu_type(machine_class);
+    current_machine->cpu_type = machine_default_cpu_type(current_machine);
     if (cpu_option) {
         current_machine->cpu_type = parse_cpu_option(cpu_option);
     }
-- 
2.51.0


