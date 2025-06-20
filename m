Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E62C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfNp-0005si-S2; Fri, 20 Jun 2025 13:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLa-0002m7-Hl
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:16 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLY-0004c7-Ra
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a6d1369d4eso565806f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439771; x=1751044571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HifgVc2llHULzbFJYnx4Gjp/3KyzUdu7DTAkCNPmNJ4=;
 b=Bgr1JFVOZSlM/OSDQrnEzQSpE7vbxydusdCiyLgzY/zqzSlMT8KakK6gDNJzzmuq2j
 ep6vzw+nRRjghsDeTezXVo2hDAqtmmPuKmeXZ6sN+2bjgtNy8rtUSbLn8cGgSJBpkpr8
 nd62DAqmmQv2rIpAbCpcltpIFCVoQ1zIsBJexk9PuQtDtJy0xOIP5V47gH+w800QkS5X
 T7vNMsIcI6KfPfCo5RXlWmkMhoMQ3Qzb/Nv3knw6vM+YZsdmDO4aS/42UMjC/CN/AwMZ
 +iZ4je4WWOFobO9/Jyb7siw7HLTXRBitTq0oRyV+nszAPGk5wKRQyQvwJHn08f6CxBqx
 VFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439771; x=1751044571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HifgVc2llHULzbFJYnx4Gjp/3KyzUdu7DTAkCNPmNJ4=;
 b=PDWT+nXzmKahT9eOe2mFi/29OxSjqwo0mtZ7gnuKw+M7ZoYqeZ7IVnHSB5cbGIWCcz
 XwQ7hw2mSSeqKu68CSr+O3e90g8c8skuJRkUgt2Y0BW1jHed1Gun/Q2fpRxaZosCjWWg
 HoWrKszLori4W5IK043YAxYMIf0DHaOViF1p2lp0KhFn/RJgJFH/4dfJL1scmBWUsT6j
 alxgZYUWC6vQrf3NJI3bpUgnses2j5XFP2tpUtg8t9sY3wcMZOPJKCS5FuhmNSI/FGJV
 n2TA977YOI9wSuAOjo4mWN1HSCn2C/d2jnS36J+DuvccRgl/PNBrBd4/h0SQdYQsksLY
 88kw==
X-Gm-Message-State: AOJu0YzuIEr6sqx9Ru9gmkwuSdyIA3UBUk57VUuQbcSlNrXKms8vWyYk
 2vAO1r/jQd3FQl1G4rPWr4fFRGxrNIukSJEbcNaheJ8SUQbY4F/Lt5xqqJp6DaWu1GMkLpd9HcD
 xg07aM84=
X-Gm-Gg: ASbGncte07+W74+zN4bQbzGDl/eCkAVg6gZ7u/RYQ/dnekTage+N0r3h+4QDJe8E/Ln
 iBAv0vicWeSxZz2h8YNnhCTi2v55QH8AesELSq92aNmsF257NRkYX+Jlcfx742PaJ8GLsNIA7+q
 1Q9ecy3WO2cqbgwDpu65PXV0v6wRyjot66/Q4SEeDowAnGuMP7LlasegvObzQIqGFrRWDJFKWah
 9VlLgTp3sAjBSzaJl64PrMWFreXQB+ftd0Gy/BFpniB6UZude0Vg36ve/3+nYSGCyEkE8Xn7R/y
 jE9xLvRm6oc+kDojsRk0SfdVWTpede/zOBG1BWLy0pQlO0orNWUrGdzk2Ow3vVMePRnXaFR29CA
 bb6LYXRWL0doP4oswfAs/REW3FxXOgidU+gLa
X-Google-Smtp-Source: AGHT+IH2Fj32y2DdNYzoohJCbSnUJoO7LZlCeq5hiSTtFi2VV4bh6XkWi1Y6d8SbFuWwXaDi2dtA1A==
X-Received: by 2002:a05:6000:4912:b0:3a6:cfca:efee with SMTP id
 ffacd0b85a97d-3a6d12a15e6mr2690151f8f.17.1750439770776; 
 Fri, 20 Jun 2025 10:16:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ebced8asm65530905e9.40.2025.06.20.10.16.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:16:10 -0700 (PDT)
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
Subject: [RFC PATCH v2 30/48] accel: Introduce
 AccelOpsClass::cpu_thread_routine handler
Date: Fri, 20 Jun 2025 19:13:23 +0200
Message-ID: <20250620171342.92678-31-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
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

In order to have a generic function creating threads,
introduce the thread_precreate() and cpu_thread_routine()
handlers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/accel-ops.h |  5 ++++-
 accel/accel-common.c       | 16 +++++++++++++++-
 system/cpus.c              |  2 +-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index b1b9dce27d0..b1a55ebe333 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -39,7 +39,10 @@ struct AccelOpsClass {
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     void (*cpu_reset_hold)(CPUState *cpu);
 
-    void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
+    /* Either cpu_thread_routine() or create_vcpu_thread() is mandatory */
+    void *(*cpu_thread_routine)(void *);
+    void (*thread_precreate)(CPUState *cpu);
+    void (*create_vcpu_thread)(CPUState *cpu);
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index d719917063e..24038acf4aa 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -11,6 +11,7 @@
 #include "qemu/accel.h"
 #include "qemu/target-info.h"
 #include "system/accel-ops.h"
+#include "system/cpus.h"
 #include "accel/accel-cpu.h"
 #include "accel-internal.h"
 
@@ -104,7 +105,20 @@ void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu)
     if (ac->ops->create_vcpu_thread != NULL) {
         ac->ops->create_vcpu_thread(cpu);
     } else {
-        g_assert_not_reached();
+        char thread_name[VCPU_THREAD_NAME_SIZE];
+
+        assert(ac->name);
+        assert(ac->ops->cpu_thread_routine);
+
+        if (ac->ops->thread_precreate) {
+            ac->ops->thread_precreate(cpu);
+        }
+
+        snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/%s",
+                 cpu->cpu_index, ac->name);
+        qemu_thread_create(cpu->thread, thread_name,
+                           ac->ops->cpu_thread_routine,
+                           cpu, QEMU_THREAD_JOINABLE);
     }
 }
 
diff --git a/system/cpus.c b/system/cpus.c
index 1721b32fc3f..bd3fd1b31b6 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -671,7 +671,7 @@ void cpu_remove_sync(CPUState *cpu)
 void cpus_register_accel(const AccelOpsClass *ops)
 {
     assert(ops != NULL);
-    assert(ops->create_vcpu_thread != NULL); /* mandatory */
+    assert(ops->create_vcpu_thread || ops->cpu_thread_routine);
     cpus_accel = ops;
 }
 
-- 
2.49.0


