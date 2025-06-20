Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0591C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfL8-0001zZ-GX; Fri, 20 Jun 2025 13:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKP-0001CP-Mj
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKM-0004GB-TE
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:00 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a510432236so1621608f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439697; x=1751044497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y2LkrHR6vpwcd+SjWT8bFSjr80XVAv5K9YgR9HGhVJU=;
 b=CzH9iATe1ojbp1/BKLOqZkfvNtj5nptgCgFMShOg7Kf+xLEyKN7oFNeEo5+w/DTFoq
 DTJnOHHEl66OZQkh2qckadHbJKCYyOBAaZ4oshB6m1ApM85uRsSzisdS1lKsv+6qpFvZ
 raxDjShEGGafZb4OS3pjemN5pJmtvPSd4G6GFno8Sp8+Gv9Kc0WRo+JJVvJyxpiqu8ow
 gWE2e9dJ9KJ8IVOYgJd6lKLlKQHEkWf/l2LWNatBA1kj6KvlEp8loIOnBWGCIAaI4gSE
 NuwxpAaWrWpExhBLWfekVaiSSu6Meco49ttr83PLWlBhccH/i/nH2/z+JoIYD2Y4n05v
 esFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439697; x=1751044497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y2LkrHR6vpwcd+SjWT8bFSjr80XVAv5K9YgR9HGhVJU=;
 b=R+6jPr0OiND5C4DEM4Tg5snijFIKW4n9Y2kDaRHGJvgT3igWOnjVHTjWWp/LQWRkSg
 eKf5ptiMw3SOZyJemdeA4bxDteq38KyzNKKJ2lZGP0nqk//18FrRMX1W6ll197rzltvV
 jie+tWHNrki4KT9Uw8dNv8NC7eIIXRzR9QQrx6p9v/0Z80aQ1hdPOkQ3/LxAMx3mUI9t
 c1P58zCkSgxsjXmx+Ky25MwqWDD+C3xgix10YTycoO1u5ZeFoaieS8wewgkx6NW4xEoG
 HIjHAYdxaDmzYEGpYxCPm7uxswf9ee5ncmC7FuducHtI2zpGlqs87lpHfwhX3Mdk87Qa
 ki5Q==
X-Gm-Message-State: AOJu0Yza11t6h4eM30Fx1ErSlOgY26DZzbdf2sQtmO+M/MaQYnICu4KJ
 r8ey9El/aNPFqNCGv307h3q+QqvSoTWHbYAQey4DRB6wi+moe2cM2nHuvBZHJZ2O4YLDRnB6jvU
 n+3OcpVc=
X-Gm-Gg: ASbGnctMlENP9HLAVg1P0KbFy7KTeWyVKDJPBGUpKDiGoljsU8Wx4LKhEOg4DQrH2wn
 pW4elp2kfHkPyeCCeyNPnEsWSw+yDJc50uYZG9fmTEi8da3GTqbwf24zBU8DGSk/LpD8qp+k8C3
 NEik7E9R/jqwZDMZ2DcMvJj/kFTMLx2aDIgq02FornIxgZ9FnOjIWyHM7yXoq84jrtq0Fy/32oW
 p3UV3jYtu8+puIeGLVsy+/x5U+fQaZJDXpGg9IEBR91nuUan0Or5zN+ZGW7G3SxLeW11JRNd1nt
 p0Zs6K564MWzjE5EjYcqOUYYNL0AS+MA+sqS8JN7EsvOTzxo+t+/bpYQl3QhzjGUbjZVwijM5gK
 2iXrRIjxxx7lewOvtofy+rXqKpx6+R/2ITF4y
X-Google-Smtp-Source: AGHT+IHgcrhW0PKqS+kaPaqrWKch4ZdB2fTs6aTZNlTDz5ScIPa5JoScXFZbtuhc5EniO4UjK+GyAg==
X-Received: by 2002:a05:6000:4911:b0:3a5:57b7:cd7b with SMTP id
 ffacd0b85a97d-3a6d12ead65mr2988311f8f.22.1750439696859; 
 Fri, 20 Jun 2025 10:14:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535969dc4bsm41895455e9.0.2025.06.20.10.14.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:14:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 15/48] accel/system: Add 'info accel' on human monitor
Date: Fri, 20 Jun 2025 19:13:08 +0200
Message-ID: <20250620171342.92678-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

'info accel' dispatches to the AccelOpsClass::get_stats()
and get_vcpu_stats() handlers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h       |  1 +
 include/system/accel-ops.h |  2 ++
 accel/accel-system.c       | 28 ++++++++++++++++++++++++++++
 hmp-commands-info.hx       | 12 ++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index aee0a2e3309..4ed5f264a88 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -41,6 +41,7 @@ typedef struct AccelClass {
     AccelOpsClass *ops;
 
     int (*init_machine)(MachineState *ms, AccelState *as);
+    void (*get_stats)(AccelState *as, GString *buf);
 
     /* system related hooks */
     void (*setup_post)(MachineState *ms, AccelState *accel);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index fb199dc78f0..5c5171ea5b5 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -51,6 +51,8 @@ struct AccelOpsClass {
 
     void (*handle_interrupt)(CPUState *cpu, int mask);
 
+    void (*get_vcpu_stats)(CPUState *cpu, GString *buf);
+
     /**
      * @get_virtual_clock: fetch virtual clock
      * @set_virtual_clock: set virtual clock
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 1db146139c4..b37889b84f0 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -25,6 +25,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qapi/type-helpers.h"
+#include "monitor/monitor.h"
 #include "hw/boards.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
@@ -72,6 +74,26 @@ bool cpus_are_resettable(void)
     return true;
 }
 
+static HumanReadableText *hmp_info_accel(Error **errp)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    g_autoptr(GString) buf = g_string_new("");
+
+    if (acc->get_stats) {
+        acc->get_stats(accel, buf);
+    }
+    if (acc->ops->get_vcpu_stats) {
+        CPUState *cpu;
+
+        CPU_FOREACH(cpu) {
+            acc->ops->get_vcpu_stats(cpu, buf);
+        }
+    }
+
+    return human_readable_text_from_str(buf);
+}
+
 /* initialize the arch-independent accel operation interfaces */
 void accel_init_ops_interfaces(AccelClass *ac)
 {
@@ -102,11 +124,17 @@ void accel_init_ops_interfaces(AccelClass *ac)
     cpus_register_accel(ops);
 }
 
+static void accel_ops_class_init(ObjectClass *oc, const void *data)
+{
+    monitor_register_hmp_info_hrt("accel", hmp_info_accel);
+}
+
 static const TypeInfo accel_ops_type_info = {
     .name = TYPE_ACCEL_OPS,
     .parent = TYPE_OBJECT,
     .abstract = true,
     .class_size = sizeof(AccelOpsClass),
+    .class_init = accel_ops_class_init,
 };
 
 static void accel_system_register_types(void)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 639a450ee51..0496be6abfb 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -281,6 +281,18 @@ ERST
         .cmd        = hmp_info_sync_profile,
     },
 
+    {
+        .name       = "accel",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show accelerator info",
+    },
+
+SRST
+  ``info accel``
+    Show accelerator info.
+ERST
+
 SRST
   ``info sync-profile [-m|-n]`` [*max*]
     Show synchronization profiling info, up to *max* entries (default: 10),
-- 
2.49.0


