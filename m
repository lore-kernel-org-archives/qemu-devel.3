Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C05C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwKv-0002Qh-CS; Mon, 17 Feb 2025 03:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwKt-0002Px-HE
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:18:39 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwKr-00013K-Be
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:18:38 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6e6698667c7so32311796d6.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1739780316; x=1740385116; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kpVywB6YQYdl9MWDctfNmlq9T5N7Yd18fL8TXZluVxo=;
 b=PE4mo33xXJ7N2TVSD6yN2g53Y08yY9UcjXLiYS0egQHO59u2Eb3HUL/H13YrS/hD+6
 mbfS+TE4Lr+HSSl59yHSQfb5cUMY7bXWgDCu/eKnBN9yubVCmQ1llJ29RqztYDypHaIM
 H6uLBb6pvfHgYzgR+sDnjgp+m1wOxGeELVSwhsApyOo2TYUbk1g7/ju0fGWCffdtZls0
 NpvutYZ2B76jkZmFl8kXKbrt5IhiBrfHyeZ0bB9fDglQ9Ia93DhdONxMGUqSFsSx1MOb
 hMZttVD3rghvzXKBN9AM+p3b7NQo/2q+q0oWpTVErE/fYvZea92lexCA3AwISB8CAa4Q
 19CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780316; x=1740385116;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kpVywB6YQYdl9MWDctfNmlq9T5N7Yd18fL8TXZluVxo=;
 b=b1WxFmubxlDRcqLf0gMnN1sLAyJYo/HrJcmQNWjKn8HhxHk6SoflcCMszW+aPrqaOb
 +/JTzJxKpyoeoip3+yZzz0ngXKKTiIXd9X+6VjHub0m/07GSH8V6mOfurg3YeItHhyu8
 XznQwGeXpd+Boxp/9ldaoiswAz8X60E/x4LyoZcf9lzTAn7cfB+mLN9Wc9ke/Kf5YD74
 VpZoq1VcUkpEFIMhGnAGJ3/icrTYLgSnf/axAUeuxwAASDUl3BA8LVo9nsDhOFzflO4s
 auIb/Zo3I1m/EstGJaNltKC6CK+MQeUUavyeOIi0Bythk/IzgGjAhUn90dZBdt2Vs5rX
 BORQ==
X-Gm-Message-State: AOJu0YwnaOlakgVTWrPRDTcr+RTXQS9PFOo3C5fuSsI2EWrgTIMdKZxx
 QqdDIDvN/pyA5sgVy1QsYSPA2cMeQiBg5R4rtvvcegwzQ7Nd/0+rsLGPb+XTOn+GS0boXJ1CCqQ
 Yy+b9CjaONQdaX0Xpd76mY1grKK7U0sYXL7RMiUBin192f0SCHuGutbU6ksJgFPokOALvllU8tq
 ImGrGStt8Ty4zS1QQBnuNRw0yh6zi1f2HYnwlR1SgnrQ==
X-Gm-Gg: ASbGncvBkpry6kAq5gaytwIjIhYbCE9GHLx5o4b+RgR7lsd1pupTVzOL0+0x5aSuOSJ
 PhgpnljVplpjguLG356HVLsI+EGUsIohJWadLWvr1+OchFanM00N/GPaThxnUiuOHWk3Ukhn/Sh
 ttXuMW+96+fw097i8nt2nKTMd19mQ+SHcw10QMcnR2BUwpnpcaJEInMrEmg2z4GpCibXMTyCnIC
 fF8Q1iJZl+1//ZZwawAuRH98BmjKUzVYbuTF4wdTU8hqtZK5HBA9nDEZ1BddtzIZIme8Rb2O286
 +S2vgVOTnkA/Fo0s28fKdSioOv2KPwHg3npIUm8KkTg3Gw==
X-Google-Smtp-Source: AGHT+IFwP0HYUZtij50ZgVk3V1h2EfvdsdEmU5/7kKLRWMRNrbd7uNHzkWsVpDWX1A5yaQYdwkCyTg==
X-Received: by 2002:a05:6214:21cb:b0:6e4:6ff6:bac2 with SMTP id
 6a1803df08f44-6e66ce2c480mr108033076d6.40.1739780316142; 
 Mon, 17 Feb 2025 00:18:36 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e65d9f38absm49673346d6.88.2025.02.17.00.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 00:18:35 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] target/riscv/kvm: rename riscv-aia to riscv-imsic
Date: Mon, 17 Feb 2025 16:17:27 +0800
Message-Id: <20250217081730.9000-8-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250217081730.9000-1-yongxuan.wang@sifive.com>
References: <20250217081730.9000-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-qv1-xf30.google.com
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

The riscv-aia property only controls the in-kernel IMSIC mode, the
emulation of AIA MSI mode is controlled by the kernel-irqchip property.
Rename the riscv-aia property to riscv-imsic to prevent the confusion.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 target/riscv/kvm/kvm-cpu.c | 52 ++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c047d5f36951..ab53b76ab81f 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1798,9 +1798,9 @@ void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
     }
 }
 
-static int aia_mode;
+static int imsic_mode;
 
-static const char *kvm_aia_mode_str(uint64_t mode)
+static const char *kvm_imsic_mode_str(uint64_t mode)
 {
     switch (mode) {
     case KVM_DEV_RISCV_AIA_MODE_EMUL:
@@ -1813,19 +1813,19 @@ static const char *kvm_aia_mode_str(uint64_t mode)
     };
 }
 
-static char *riscv_get_kvm_aia(Object *obj, Error **errp)
+static char *riscv_get_kvm_imsic(Object *obj, Error **errp)
 {
-    return g_strdup(kvm_aia_mode_str(aia_mode));
+    return g_strdup(kvm_imsic_mode_str(imsic_mode));
 }
 
-static void riscv_set_kvm_aia(Object *obj, const char *val, Error **errp)
+static void riscv_set_kvm_imsic(Object *obj, const char *val, Error **errp)
 {
     if (!strcmp(val, "emul")) {
-        aia_mode = KVM_DEV_RISCV_AIA_MODE_EMUL;
+        imsic_mode = KVM_DEV_RISCV_AIA_MODE_EMUL;
     } else if (!strcmp(val, "hwaccel")) {
-        aia_mode = KVM_DEV_RISCV_AIA_MODE_HWACCEL;
+        imsic_mode = KVM_DEV_RISCV_AIA_MODE_HWACCEL;
     } else if (!strcmp(val, "auto")) {
-        aia_mode = KVM_DEV_RISCV_AIA_MODE_AUTO;
+        imsic_mode = KVM_DEV_RISCV_AIA_MODE_AUTO;
     } else {
         error_setg(errp, "Invalid KVM AIA mode");
         error_append_hint(errp, "Valid values are emul, hwaccel, and auto.\n");
@@ -1834,13 +1834,15 @@ static void riscv_set_kvm_aia(Object *obj, const char *val, Error **errp)
 
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
-    object_class_property_add_str(oc, "riscv-aia", riscv_get_kvm_aia,
-                                  riscv_set_kvm_aia);
-    object_class_property_set_description(oc, "riscv-aia",
-        "Set KVM AIA mode. Valid values are 'emul', 'hwaccel' and 'auto'. "
-        "Changing KVM AIA modes relies on host support. Defaults to 'auto' "
-        "if the host supports it");
-    object_property_set_default_str(object_class_property_find(oc, "riscv-aia"),
+    object_class_property_add_str(oc, "riscv-imsic", riscv_get_kvm_imsic,
+                                  riscv_set_kvm_imsic);
+    object_class_property_set_description(oc, "riscv-imsic",
+        "Set KVM IMSIC mode. Valid values are 'emul', 'hwaccel' and 'auto'. "
+        "Changing KVM IMSIC modes relies on host support. Defaults to 'auto' "
+        "if the host supports it. This property only takes effect when the "
+        "kernel-irqchip=on|split when using AIA MSI.");
+    object_property_set_default_str(object_class_property_find(oc,
+                                                               "riscv-imsic"),
                                     "auto");
 }
 
@@ -1851,7 +1853,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 {
     int ret, i;
     int aia_fd = -1;
-    uint64_t default_aia_mode;
+    uint64_t default_imsic_mode;
     uint64_t socket_count = riscv_socket_count(machine);
     uint64_t max_hart_per_socket = 0;
     uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_addr;
@@ -1867,24 +1869,24 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 
     ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                             KVM_DEV_RISCV_AIA_CONFIG_MODE,
-                            &default_aia_mode, false, NULL);
+                            &default_imsic_mode, false, NULL);
     if (ret < 0) {
-        error_report("KVM AIA: failed to get current KVM AIA mode");
+        error_report("KVM AIA: failed to get current KVM IMSIC mode");
         exit(1);
     }
 
-    if (default_aia_mode != aia_mode) {
+    if (default_imsic_mode != imsic_mode) {
         ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                                 KVM_DEV_RISCV_AIA_CONFIG_MODE,
-                                &aia_mode, true, NULL);
+                                &imsic_mode, true, NULL);
         if (ret < 0) {
-            warn_report("KVM AIA: failed to set KVM AIA mode '%s', using "
+            warn_report("KVM AIA: failed to set KVM IMSIC mode '%s', using "
                         "default host mode '%s'",
-                        kvm_aia_mode_str(aia_mode),
-                        kvm_aia_mode_str(default_aia_mode));
+                        kvm_imsic_mode_str(imsic_mode),
+                        kvm_imsic_mode_str(default_imsic_mode));
 
-            /* failed to change AIA mode, use default */
-            aia_mode = default_aia_mode;
+            /* failed to change IMSIC mode, use default */
+            imsic_mode = default_imsic_mode;
         }
     }
 
-- 
2.17.1


