Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2D5CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut429-0002TK-EN; Mon, 01 Sep 2025 08:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut426-0002Qn-5p
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:53:14 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut421-0004Ik-AG
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:53:13 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61cbfa1d820so8394861a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756731187; x=1757335987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BW+pcAYJr7rs8sK+GJ83FOVoqQy2R24okxpayuOukDM=;
 b=uXz3ueEH8grKmRvzf8oB819OxF6JhLXEoZfAiufDSxA7hkTnei6eoDGyjTxnO6DXbA
 8+A1JWoLEOb4rjsd5COE1XGw3SHVJEm2xWKzbVBAurEiHgl8tXSwYgprSp35p78nklQZ
 zVXt5Vein1OUK/i/TG/yReplqNlBcjDBhd+OMsA1k/eKD5PbgugixYlMKDVQSRoSf2fT
 DQ9iVlMUqtIynpMq+k3yXJasYN6WBwOcnCWr91/Gj/woFXJbEB1o4mMoWZy22upLIKmK
 /VQLJBsdVHwu3lt9ueE4fYyaAijT78+o+tE9EIjtaF0hpveTqcmiLbALeKof5l5E5EBY
 UrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756731187; x=1757335987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BW+pcAYJr7rs8sK+GJ83FOVoqQy2R24okxpayuOukDM=;
 b=CDLntT9MuuHUq+K3PbSWYGSTqzBP3DlQDqXA3/s+aeec+3wkxnmSF8VS93nGVmrapV
 5PzeVgaOGj3Ju1rvzSWqhI7B68t/nPzvwq3+pxMZ/XXWP5lNwGF/QeeZLM9HCpOLFLCS
 pW1jm6rxtzMxH2nk2riQxAnPO4LmXC9k58wMM0ofo1hIzoGCosACv09xm5+HLKpNE47i
 6spPRVlEDD/2G9Ezt00EBICjonY6T7efRhsKUL4mwTktUUWVzjC+6rbS2TXznKYNViJE
 iNZXnEFSQMJr1rlveL81+6FL9eKvi55yIm+DU9dELS90+RoH1rejOr0MbbG10dAyaoKC
 E3GA==
X-Gm-Message-State: AOJu0Yx+AwnzoJUnHVyeQt2EFof80jVRk+FWjRziBD1aW8TipgbbrqI4
 jOcPVpN5mkocusq+wRb7JzHRkLsMn34MMHUZDJ5oBpDQpuCCDJi/+HaQ5VvsyrGPM50=
X-Gm-Gg: ASbGncvr/KIrQiQ/KhE8XyerrVPOVnDoEBahnAJVLx3RY2ESRCBzy8oguzukGxkBgM3
 r8qZkU43z1ouGsS6giAS32uHJO+CcUApd6ds5cn6tfCP9jA30jMby+73SSz3oli7ROGlO5kdeG8
 3WZDdkDp1aeiQgbXJ6LTEbuCvnewh+4SHcym8GpPMWYhXT4feSg0oJsR6aGOkL0Ri3bkDVzokTh
 +rAj8kTxfmaKmGkjpo+YpDv965q/TsjDkBcDHtIeP1baJ1Q3jhstyegoigEIr7vFv5fMbRsMi7s
 0Y95DtW9HNW0jU1952w1ECIXrm8FtcQjwm8/V/RoYuN7Pr+JE9AJj8IIBLlBWVqw70aoPDiTiFv
 071h2Zpgk/wLkGxmqnhlDrOg8SSAY/YYEcw==
X-Google-Smtp-Source: AGHT+IErB9p5Z0ZCWdNwbhoKUaI0nbChocKjfcOqjuNfXkeiherqMi5oWD33sD8hEdJgDaOZVNuPhQ==
X-Received: by 2002:a17:907:3c85:b0:af9:5e9a:b6a with SMTP id
 a640c23a62f3a-b01d9743b83mr685530566b.42.1756731186643; 
 Mon, 01 Sep 2025 05:53:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04093c9161sm515809666b.54.2025.09.01.05.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 05:53:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2D8395F8D7;
 Mon, 01 Sep 2025 13:53:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/4] hw/arm: use g_autofree for fdt in arm_load_dtb
Date: Mon,  1 Sep 2025 13:53:02 +0100
Message-ID: <20250901125304.1047624-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901125304.1047624-1-alex.bennee@linaro.org>
References: <20250901125304.1047624-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

With the fdt being protected by g_autofree we can skip the goto fail
and bail out straight away. The only thing we must take care of is
stealing the pointer in the one case when we do need it to survive.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/arm/boot.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 56fd13b9f7c..749f2d08341 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -519,7 +519,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                  hwaddr addr_limit, AddressSpace *as, MachineState *ms,
                  ARMCPU *cpu)
 {
-    void *fdt = NULL;
+    g_autofree void *fdt = NULL;
     int size, rc, n = 0;
     uint32_t acells, scells;
     unsigned int i;
@@ -538,13 +538,13 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         fdt = load_device_tree(filename, &size);
         if (!fdt) {
             fprintf(stderr, "Couldn't open dtb file %s\n", filename);
-            goto fail;
+            return -1;
         }
     } else {
         fdt = binfo->get_dtb(binfo, &size);
         if (!fdt) {
             fprintf(stderr, "Board was unable to create a dtb blob\n");
-            goto fail;
+            return -1;
         }
     }
 
@@ -553,7 +553,6 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
          * Whether this constitutes failure is up to the caller to decide,
          * so just return 0 as size, i.e., no error.
          */
-        g_free(fdt);
         return 0;
     }
 
@@ -563,7 +562,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                                    NULL, &error_fatal);
     if (acells == 0 || scells == 0) {
         fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
-        goto fail;
+        return -1;
     }
 
     if (scells < 2 && binfo->ram_size >= 4 * GiB) {
@@ -572,14 +571,14 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
          */
         fprintf(stderr, "qemu: dtb file not compatible with "
                 "RAM size > 4GB\n");
-        goto fail;
+        return -1;
     }
 
     /* nop all root nodes matching /memory or /memory@unit-address */
     node_path = qemu_fdt_node_unit_path(fdt, "memory", &err);
     if (err) {
         error_report_err(err);
-        goto fail;
+        return -1;
     }
     while (node_path[n]) {
         if (g_str_has_prefix(node_path[n], "/memory")) {
@@ -611,7 +610,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
             if (rc < 0) {
                 fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
                         mem_base);
-                goto fail;
+                return -1;
             }
 
             mem_base += mem_len;
@@ -622,7 +621,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         if (rc < 0) {
             fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
                     binfo->loader_start);
-            goto fail;
+            return -1;
         }
     }
 
@@ -636,7 +635,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                                      ms->kernel_cmdline);
         if (rc < 0) {
             fprintf(stderr, "couldn't set /chosen/bootargs\n");
-            goto fail;
+            return -1;
         }
     }
 
@@ -645,7 +644,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                                           acells, binfo->initrd_start);
         if (rc < 0) {
             fprintf(stderr, "couldn't set /chosen/linux,initrd-start\n");
-            goto fail;
+            return -1;
         }
 
         rc = qemu_fdt_setprop_sized_cells(fdt, "/chosen", "linux,initrd-end",
@@ -654,7 +653,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                                           binfo->initrd_size);
         if (rc < 0) {
             fprintf(stderr, "couldn't set /chosen/linux,initrd-end\n");
-            goto fail;
+            return -1;
         }
     }
 
@@ -673,14 +672,10 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
 
     if (fdt != ms->fdt) {
         g_free(ms->fdt);
-        ms->fdt = fdt;
+        ms->fdt = g_steal_pointer(&fdt);
     }
 
     return size;
-
-fail:
-    g_free(fdt);
-    return -1;
 }
 
 static void do_cpu_reset(void *opaque)
-- 
2.47.2


