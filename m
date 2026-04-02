Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EF5D6AB18
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q2O-0008Pe-8x; Thu, 02 Apr 2026 17:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2E-0008Kb-8N
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:06 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2C-00077S-N1
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:06 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso225585566b.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167023; x=1775771823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnoM34DCC1pHSVw13BegRYuqsTlliloemYTyLqTUADg=;
 b=aJ9AYo0q56BRZYlAr3yYFj54qEsJw02uRipwbPUQI0nB++rXp5niXpuqPZ0qaU/N3R
 R+7SY7n7qCsOU3rbzxle2Y/kXyR+B8jKkix3++ijLbpnh4HGq9LIRtkP2upkPFgKHzdF
 dpFwV7Y4lHVWdDLmnmbhyPUjKxeft6z4n9AUpSavisaFKsmRO35i7BKTrqU+mAO8K1zf
 JdFXI5Qp+PVxaYBnvsFQwfvpNJiAful62lzz+iUiN54dualxeceYPyAXSMpVxQ5JppuQ
 VajOcWUuzal/kIJOAMXkfk3esoFTJt441JcKVOQepAuoBMnQSqJ0LCMAd3l3tRg4hL84
 2AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167023; x=1775771823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZnoM34DCC1pHSVw13BegRYuqsTlliloemYTyLqTUADg=;
 b=oxsA4w61f2guGqzK35RfgqgKx7c3bk28cbUfCcLAUmx/ffyS7MYYlTiGAuegffRvzl
 f2g8QkkyaDUzHU/ok96LTq2GLImqM4oJ/zT7NazGRShf8p0ME9r+tU9uXl4RFp4rw3RL
 23xCzMN0jd22FE/GAJEcJqK+Tw6rBjiuohROJOheIESNPwOGdexu7jE5KnPMbd0/XHfd
 QZCXqiWY+LS8wym6SlNmUUEOZft6oxY31MG9ezo7FcHRTPhSExgpNZsVil4+FNaB56kx
 0MmaYb/crqN7zzs/8CyDElzDA+bXECw/cKYhPAf89myfptQKYm7MzXqNTY4+LUOv4LPp
 0Kww==
X-Gm-Message-State: AOJu0Yy18Vbz4W+3pPW4EzOzOT3u9HE2Uh4y0HTO1qrJ9AWdBbKHVX0C
 sCZCqOFJ1kNqGgPa2jT3WIaFGg5eul+kK5Dc4bh6t74JPm8PcU4xC+XfVaLoe9zC
X-Gm-Gg: ATEYQzzSXzuw5o9A53f00aNlLofkqfSKlhO0rq0oXNNTQUKRxhs7en+kswMW0eYfO/y
 Jlmk3smQTYN1xnFu5bQoNC7vMHHaB5Qepr1CEhNczXVRrPxV0rIDtETOD+SRC778TUhwIUuPs+s
 i7C/YtFOqxzMrXELFM3moungrz09txE3EWQKfHrcuOBKNsHABsHIsQ41lzlqoxHQleBpHrWHVMX
 SCEw44l6uguAgn+CQxnL1Zr0y3qFF45nlv8kwX8oFSNrRbN6awoV3GKGFcNy/1pju38AKzRix/P
 gGqqTUwbwgGOT3Srg9ClEC2eC7Drk4gInN1T0KGXaoZFjXzDnlf+y7/O2LD7tF5uYHdHtjUMghs
 bxf9mpIohNG06UMvgXm9pPw/AJ/pSgt/VZyZE8Fxiu23SKGpwuH9c0cCdnmUsxOnW/9euvXUSOf
 wpEh6Td6T5FvbIYn58iY4r2Vjfjp/YFjDVH2fHAu9i+oe1wIh2OzECzPtHJwFbw8V0kd0USw==
X-Received: by 2002:a17:907:a4a:b0:b9c:451b:2348 with SMTP id
 a640c23a62f3a-b9c672e4cd2mr22057166b.6.1775167022767; 
 Thu, 02 Apr 2026 14:57:02 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:02 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 12/33] hw/core/fdt_generic_util: actually realize device
Date: Thu,  2 Apr 2026 23:55:57 +0200
Message-ID: <20260402215629.745866-13-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Actually realize objects with TYPE_DEVICE after main
allocations done and properties set for qdev.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 6f0a1e1e4b..8ae9e23073 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -540,6 +540,34 @@ static void fdt_init_parent_node(Object *dev, Object *parent, char *node_path)
     }
 }
 
+static void fdt_init_device_realize(FDTMachineInfo *fdti,  char *node_path,
+                                   Object *dev)
+{
+    if (object_dynamic_cast(dev, TYPE_DEVICE)) {
+        DeviceClass *dc = DEVICE_GET_CLASS(dev);
+        const char *short_name = strrchr(node_path, '/') + 1;
+
+        /* Regular TYPE_DEVICE houskeeping */
+        fdt_debug_np("Short naming node: %s\n", short_name);
+        (DEVICE(dev))->id = g_strdup(short_name);
+
+        if (object_dynamic_cast(dev, TYPE_CPU_CLUSTER)) {
+            /*
+             * CPU clusters must be realized at the end to make sure all child
+             * CPUs are parented.
+             */
+            fdt_init_register_user_cpu_cluster(fdti, OBJECT(dev));
+        } else {
+            object_property_set_bool(OBJECT(dev), "realized", true,
+                                     &error_fatal);
+            if (dc->legacy_reset) {
+                qemu_register_reset((void (*)(void *))dc->legacy_reset,
+                                    dev);
+            }
+        }
+    }
+}
+
 static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 {
     Object *dev, *parent;
@@ -582,6 +610,8 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 
     fdt_init_qdev_properties(node_path, fdti, dev);
 
+    fdt_init_device_realize(fdti, node_path, dev);
+
     g_free(parent_node_path);
 
     return 0;
-- 
2.43.0


