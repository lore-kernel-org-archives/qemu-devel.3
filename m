Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2140AC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 00:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf6jH-0000sQ-VV; Mon, 03 Feb 2025 19:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6jC-0000aY-4F
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:47 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6j9-00077c-2i
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so58356485e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738628621; x=1739233421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4BsHBCpnaPz96xyXgY6FPwDTShzZ0gjgpBf5vsUfhxs=;
 b=UMQ3YQwLsFy9KCH0bwJv1YJrekfy/X1BdHa8hlo2E73bAvXrclnRhBpyE9yM0iSLSA
 GZOFM3EhxSzzWDwVtCuh8cUohooSJakVT+/Fvcu3Pu4YfR7mZzmj5p1KLCtCp/i8HT+H
 0bDJFNQV/yUo+CXKzN6Tz3wWF9NA/InyWHZzi/2SiYjnGIJANAvy2C2JuKaZhnqUql8v
 1ongUyqaub8IZoql9qFw/4eCJysaJ7hojwygCA2DYDu8q0ZfqeFfrGIrd2NjXI0ofmUb
 +m45ZezlpMiztdHnGRJON34KuuKsQLKa46QFLKk59Roau5N2Gn80vpuAUr9MF19W57R5
 Hc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738628621; x=1739233421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BsHBCpnaPz96xyXgY6FPwDTShzZ0gjgpBf5vsUfhxs=;
 b=g8qG3fsUC2IJmlpteUUXesj5nDl+14E20MwvHyRWKF4SbRsYXJHLJAcl16A2cFmVvf
 EDtcxIWOshs+0Bq3SYnLVYtcgLVNBR6DBcOiK1eT8UuYuXBBlwfH86kBkMIlNlhWa3pt
 0KMRsKOWmTGI5aZpzE6tZFND6zbTjX6CljmJz2X7x5L0DacQHm3+3MxfwL2jJYzbOpvh
 n9b1T4gn5bdNHrgJnsU7TlcOeOLOwcOz0RgTIyDQe9KayMBbJaaZl26kfumfnKpCNlYk
 bb5y8MN9bCVqjA0pIamv/ShiYiLz2fdV1eWPMHX1U4fFTCJxPqTjfddiYcJGI4G6+vCG
 f73A==
X-Gm-Message-State: AOJu0YzLkYjXMd4HQ8ByEVCLAalr10jWAZ8/TTl0W20IoP9ozaRUfYL3
 jq++tN14CvcJ2Q/F1+8MZT+bKK97S/xhwtGeMTtgZVyDqFZDHMtsmUglCRs2IdDEUzF4H9gS3Kh
 vHsQ=
X-Gm-Gg: ASbGncsJFT2ufKMHW5yKsTFkn6sxQSqbSq9qru/BFgILI5g7sO1jEROzjbkXp7gqdjw
 whhDRX4lI3F3wHvqUX/z/YFmDfNfjpD6F6iTrU6cphrkvK0AQ16QbsHTv79DRIfo5MTeMdgEfra
 YqrO1/3GwRX239dfdF2/NNu8rbvftyqPNWqqTvPLs8EFe2m1R3k3SYQGAc33zpMduz8RHa1+Wee
 pKWhmwneib5U/lxNkRFOe3uCvy2eSZJ7pLBDM3XOglY0R18dUzgXGpggMFhHsdQK0+ZHBtBfVJc
 PuFahYzoaFxkRQUIlxc8qysgPaIIrqt1BymG2bEfDuhy73RGlKqvCmBZHuzdGKjh5w==
X-Google-Smtp-Source: AGHT+IG7jWGrmSQyucvp8cl04A0B6GQvyWzANUSPKFJhjeQG53dan6HWFQx2maj55IYQawVpHdmwxA==
X-Received: by 2002:a05:600c:1d06:b0:434:fa61:fdfb with SMTP id
 5b1f17b1804b1-438e561ceaemr158695135e9.18.1738628620679; 
 Mon, 03 Feb 2025 16:23:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1016a1sm14187863f8f.21.2025.02.03.16.23.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Feb 2025 16:23:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: [PATCH v2 10/12] hw/arm/raspi: List models creatable by the generic
 'raspi' machine
Date: Tue,  4 Feb 2025 01:22:38 +0100
Message-ID: <20250204002240.97830-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204002240.97830-1-philmd@linaro.org>
References: <20250204002240.97830-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

All the following models can be created (with different RAM size):

  $ qemu-system-aarch64 -M raspi
  qemu-system-aarch64: Missing model, try -M raspi,model=help
  $ qemu-system-aarch64 -M raspi,model=help
  Available models (processor):
  - A          (BCM2835)
  - B          (BCM2835)
  - A+         (BCM2835)
  - B+         (BCM2835)
  - 2B         (BCM2836)
  - CM1        (BCM2835)
  - 3B         (BCM2837)
  - Zero       (BCM2835)
  - CM3        (BCM2837)
  - ZeroW      (BCM2835)
  - 3B+        (BCM2837)
  - 3A+        (BCM2837)
  - CM3+       (BCM2837)
  - 4B         (BCM2838)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/raspi.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index b184ac3c446..8cae1ff6f93 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -445,7 +445,7 @@ static void raspi_generic_machine_init(MachineState *ms)
     uint64_t max_ramsize;
 
     if (!board_rev) {
-        error_report("Missing model");
+        error_report("Missing model, try -M raspi,model=help");
         exit(1);
     }
 
@@ -500,8 +500,33 @@ static void raspi_update_board_rev(RaspiBaseMachineState *s)
     ms->smp.max_cpus = soc_property[proc].cores_count;
 }
 
+static void raspi_list_machine_models(void)
+{
+    printf("Available models (processor):\n");
+
+    for (unsigned i = 0; i < ARRAY_SIZE(types); i++) {
+        const char *soc_type;
+
+        if (!types[i].model) {
+            continue;
+        }
+
+        soc_type = soc_property[types[i].proc_id].type;
+        if (!soc_type) {
+            continue;
+        }
+        printf("- %-10s (BCM%s)\n",
+               types[i].model,
+               soc_property[types[i].proc_id].type + 3);
+    }
+}
+
 static void raspi_set_machine_model(Object *obj, const char *value, Error **errp)
 {
+    if (!strcmp(value, "help")) {
+        raspi_list_machine_models();
+        exit(0);
+    }
     for (unsigned i = 0; i < ARRAY_SIZE(types); i++) {
         if (types[i].model && !strcmp(value, types[i].model)) {
             RaspiBaseMachineState *s = RASPI_BASE_MACHINE(obj);
@@ -512,6 +537,7 @@ static void raspi_set_machine_model(Object *obj, const char *value, Error **errp
         }
     }
     error_setg(errp, "Invalid model");
+    error_append_hint(errp, "Use model=help to list models.\n");
 }
 
 static char *raspi_get_machine_model(Object *obj, Error **errp)
-- 
2.47.1


