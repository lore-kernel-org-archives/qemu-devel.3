Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226C7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBGC-0007qv-Nv; Mon, 19 Aug 2024 18:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBF0-0002Pa-BQ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEy-0000pr-NS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:46 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-428141be2ddso37493345e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107962; x=1724712762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pBm6V4tkAnYFc+ZirSS/Y/4pdgPe/X+of3pcxo2Q7E=;
 b=INfzaB0Ks+ahSo489RyNOjB7L15rmMqUWzCuft3oyjRsJJsvpEAwQCri1RdKMjhvht
 jw+KeHFuKQYb9zy1Ux4b7YJH7SfpMsWs/2mtJV7MSE7bVTeBNVhMxqDm1bl/nWnz7vQX
 4avz+ME0I6I41NJYM4fueDTYdWuG9WQASlUuis0Qmv6au3YIG1tVjUUghGcvJxDxynmb
 SLyQyFKQYQSI5j3ych84IckmVwvPLRFT870LcQwpbL2YS5hVyPAA0h0PETlRjWBOBNZE
 0UqCLjpXXbfB7wKiBFVCFNHhSM0hfUGbQ7YVo2s1nQx1xUV9a+J8DeZB84vHikf4PYjx
 VU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107962; x=1724712762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3pBm6V4tkAnYFc+ZirSS/Y/4pdgPe/X+of3pcxo2Q7E=;
 b=aBJUjQEX/Uk38t3zrzIxgfb0f16/JJAvHeYm7fjhWletgkrNZk3XWynhVoTErCVym6
 asKiz61S1k1dXJ82pTadQsWy7bhqYNZ07WMHn0n+ZVlypafzvQm1m6GnfYGtNWhyp3NB
 gLLOaMWe5sdK0IrYETRUmLWEUnXBukOaUNbNS3eQ46j7FtQT0mCjCT4e0WoTu/5ufr3Y
 Hn/KcDqcdcLA57iBgtzsPqg1SqD4QKLfh5hGJr04Ribkyn8DrfQG+JevU5xI0DAQicjR
 36Gz2qufPWlajf9+ImKXTY0LYEBwkXJ56eX4CLaJcjsKIgLRQ+ocP1EL+ztpj2G3JfM4
 U5pA==
X-Gm-Message-State: AOJu0YyANwwngx6xsiqr27b7mJT0z3EBTjG7ePKOzSuqP+6VhVxxBOq9
 KGO8MNSgPKeZ4a/i/CftN+4brRmJe0ShpE6PkOUO9aZIg1BCWSMf4oFt5P4Cbe20HSWjxExQOg9
 QGYg=
X-Google-Smtp-Source: AGHT+IGCsDoBkmmL9a6NkyCXQz+PNOWnKA5h4I+zJkmOwB+9ePw3LsP+7F1zreFZlQw+OcjjwrSc3Q==
X-Received: by 2002:a05:600c:1f83:b0:426:5e91:3ff1 with SMTP id
 5b1f17b1804b1-429ed7d1a13mr84497905e9.24.1724107962118; 
 Mon, 19 Aug 2024 15:52:42 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898497f0sm11573714f8f.39.2024.08.19.15.52.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:52:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Kamil=20Szcz=C4=99k?= <kamil@szczek.dev>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/20] hw/i386/pc: Unify vmport=auto handling
Date: Tue, 20 Aug 2024 00:51:14 +0200
Message-ID: <20240819225116.17928-19-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Kamil Szczęk <kamil@szczek.dev>

The code which translates vmport=auto to on/off is currently separate
for each PC machine variant, while being functionally equivalent.
This moves the translation into a shared initialization function, while
also tightening the enum assertion.

Signed-off-by: Kamil Szczęk <kamil@szczek.dev>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <v8pz1uwgIYWkidgZK-o8H-qJvnSyl0641XVmNO43Qls307AA3QRPuad_py6xGe0JAxB6yDEe76oZ8tau_n-2Y6sJBCKzCujNbEUUFhd-ahI=@szczek.dev>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c      | 5 +++++
 hw/i386/pc_piix.c | 5 -----
 hw/i386/pc_q35.c  | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c74931d577..72229a24ff 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1217,6 +1217,11 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
     }
 
+    assert(pcms->vmport >= 0 && pcms->vmport < ON_OFF_AUTO__MAX);
+    if (pcms->vmport == ON_OFF_AUTO_AUTO) {
+        pcms->vmport = xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
+    }
+
     /* Super I/O */
     pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
                     pcms->vmport != ON_OFF_AUTO_ON);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d9e69243b4..347afa4c37 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -310,11 +310,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
 
-    assert(pcms->vmport != ON_OFF_AUTO__MAX);
-    if (pcms->vmport == ON_OFF_AUTO_AUTO) {
-        pcms->vmport = xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
-    }
-
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
                          !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 9d108b194e..f2d8edfa84 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -276,11 +276,6 @@ static void pc_q35_init(MachineState *machine)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    assert(pcms->vmport != ON_OFF_AUTO__MAX);
-    if (pcms->vmport == ON_OFF_AUTO_AUTO) {
-        pcms->vmport = ON_OFF_AUTO_ON;
-    }
-
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, !mc->no_floppy,
                          0xff0104);
-- 
2.45.2


