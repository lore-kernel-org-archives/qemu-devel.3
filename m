Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E15D3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SKq-0004wU-Ld; Tue, 05 Nov 2024 17:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SKp-0004wG-31
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:47:39 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SKn-00046H-Er
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:47:38 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4315baa51d8so53681885e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846855; x=1731451655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMgnD1f2TMybfS2TXqKpX7ke8go0TcVe3Ve35OZXk9k=;
 b=Ds84GUvwts10o2mNvL+CeMM8QoOpb5wYssZRV4NtGUb3kwLFDK5c3sneVaRWANQnWY
 iat7qK9JToP7J4En1fHrjWCO30eFIoJnAEcWym1fH9JmON8ueXhZLJceSQanfiV0IYJ2
 MA7Xb7kvTSply7F8vEXZoDS/eV0M34Yh7NKO+fb1HpNxXm0rbjUKf2pDqvbM464q2jqW
 HJItC/LEH3qQjula//xUBw0oILXhxCLF3UkiHmoVJJkAZ5QqdMhyAZ8CEB/wsFPhsA5L
 zUVpUJDHgGkM1/cEahZaKwgFQiSLGgIoaQc7BcaDDutIEEiXeDJMy5mhdxQdOssE9HMs
 6qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846855; x=1731451655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JMgnD1f2TMybfS2TXqKpX7ke8go0TcVe3Ve35OZXk9k=;
 b=gOiVPC+NYFCtxdyz/6atLDHZiGalnd85o4wuNMln4CbD2i/NHpmx0p6fWEDh/3KcZU
 0SekpYThnY7L1TxL/yVcraFWFAp7wgjb+Ed23sXSc2ahSWYM0HBT4n3HUKSY1hJ4Q1Tp
 wM3wH09MWN3QnNVmmr7UMUYclxOuSCvg4mHOudb5mVN6VircgneNH9+JnrtV3x7LLTLS
 L/o9hQ4zjrdmp+l5V0J7X7mI3gmIxguGhtqVhE1nSwjfuIleG4idUIrhfZIVxnOYtIZ1
 X1yk3bQPZ3r7OoFdHORUHVSVepNPTAd6iuEKWFgCtFtG5n8/jtxxXO3Dm55giDhA5DcH
 tE7w==
X-Gm-Message-State: AOJu0Yy1MQ1xfs0Mf4Hy/J4lsaQ2XlGlx7KQzEOCsjNas32Xjm9A0jy9
 mmhs+fdfC51J4yk6nAzAuKcP/Q2Rmec7bWaFUPU0uWS/IJh7diTyZb+b97tNmYftBWA/odb6quN
 pp+YVYg==
X-Google-Smtp-Source: AGHT+IFB0T2oS+pmpfxlL+x03jz4LtkYGhwsIF08MW9v7wMT4D8yHhfwJkL85lbn+948MNAJQ3lBGg==
X-Received: by 2002:a05:600c:4e8b:b0:426:61e8:fb3b with SMTP id
 5b1f17b1804b1-4327b80d1cemr176713695e9.27.1730846855567; 
 Tue, 05 Nov 2024 14:47:35 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116a7a6sm17354385f8f.92.2024.11.05.14.47.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:47:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/29] target/microblaze: Rename CPU endianness property as
 'little-endian'
Date: Tue,  5 Nov 2024 22:46:59 +0000
Message-ID: <20241105224727.53059-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Rename the 'endian' property as 'little-endian' because the 'ENDI'
bit is set when the endianness is in little order, and unset in
big order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20241105130431.22564-2-philmd@linaro.org>
---
 hw/microblaze/petalogix_ml605_mmu.c | 2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c     | 2 +-
 target/microblaze/cpu.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index b4183c5267d..df808ac323e 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -90,7 +90,7 @@ petalogix_ml605_init(MachineState *machine)
     object_property_set_int(OBJECT(cpu), "use-fpu", 1, &error_abort);
     object_property_set_bool(OBJECT(cpu), "dcache-writeback", true,
                              &error_abort);
-    object_property_set_bool(OBJECT(cpu), "endianness", true, &error_abort);
+    object_property_set_bool(OBJECT(cpu), "little-endian", true, &error_abort);
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 1bfc9641d29..43608c2dca4 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -90,7 +90,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_bool(OBJECT(&s->cpu), "use-pcmp-instr", true,
                              &error_abort);
     object_property_set_bool(OBJECT(&s->cpu), "use-mmu", false, &error_abort);
-    object_property_set_bool(OBJECT(&s->cpu), "endianness", true,
+    object_property_set_bool(OBJECT(&s->cpu), "little-endian", true,
                              &error_abort);
     object_property_set_str(OBJECT(&s->cpu), "version", "8.40.b",
                             &error_abort);
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 135947ee800..e9f98806274 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -368,7 +368,7 @@ static Property mb_properties[] = {
     DEFINE_PROP_UINT8("use-non-secure", MicroBlazeCPU, cfg.use_non_secure, 0),
     DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU, cfg.dcache_writeback,
                      false),
-    DEFINE_PROP_BOOL("endianness", MicroBlazeCPU, cfg.endi, false),
+    DEFINE_PROP_BOOL("little-endian", MicroBlazeCPU, cfg.endi, false),
     /* Enables bus exceptions on failed data accesses (load/stores).  */
     DEFINE_PROP_BOOL("dopb-bus-exception", MicroBlazeCPU,
                      cfg.dopb_bus_exception, false),
-- 
2.45.2


