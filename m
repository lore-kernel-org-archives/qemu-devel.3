Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCAAD2B921
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JEs-00016f-EX; Tue, 05 Nov 2024 08:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JEq-00015C-Ai
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:04:52 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JEo-0002Ah-ND
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:04:52 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43168d9c6c9so44383355e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730811889; x=1731416689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eawrki87ewjyeRlcMvMb8c/enE33+lgoSeTt32ZNL40=;
 b=GWoW7pk/2CoCrUluBuZHB7dsPT/TU1B1pmKzzA7xSKVBnamNSgATa8AEPDxxpzhtw8
 4fGhe6Tku/9h4AXgfSU/cCq5Ho7aWUvt0Y+53JQEKpO4Y4vrvLU2nSq+aMn0I/JMahpG
 sIhJt8BHcw+D5IcnTRdmk/oIFLN29+eoCjdjOHHEz30Lp/uD+3dwHpPhlZzs/ycCrS4j
 KOkDnWAl8rqBgjSQva1nn4dMBcolNy7sSlcqKXZRNp5WuiaxC0Nyhm2bVx9ngBsJDiWJ
 QkI2dzz++uqYWcATn0oPOoc/KuhJQNe3tz4FVGUO1rimsmsVoQbxK9ave2ITipX2cG3v
 WyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811889; x=1731416689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eawrki87ewjyeRlcMvMb8c/enE33+lgoSeTt32ZNL40=;
 b=V4hKcGeAASQhxH91O4xnx/wONmS2AqkTcsX7+bgo/fC637JrhYA8/ii1zqM1lnsXFX
 AeF6jeBb8ORmsGlW3UkULB94zLz3Z/YcqXV9CwoI+Nit5EhJ7n2/9h+PvulmMnsUW8vI
 iZfUpVmLG5RFJIdVckJZ0ZV3M4OD1AqdgsAIJjL7SRmntn0crj+zDPomh5jFyMB+vK3h
 MHqcNbEkF8hKsYKKskIol9wrtLO4A88D7vsPwqdhY+44hzph1sjlL+jCC44TzhDFAxM0
 /cHkpkHjY+nlZSGQBRiVPXxU4frtX0d6BREeV5qM82kYdtuACz8GsB65LpB66YX58HUg
 JO6A==
X-Gm-Message-State: AOJu0YwNq8m+7zzYoAuYHCT5D65SRnurDhrTCNCokUuuJDbvw+kr4U6H
 h1qwB23x3sIbRVNoWlwzI0ciTi+JPOO2WBAnQgudmPdRv3Ocz4IBTu9+jHRKv0lKJWK9N98MaQ8
 ozv0=
X-Google-Smtp-Source: AGHT+IFA89KjLx4zmk5aKeXaQtH/0tB7DdO7ewLtxTyKzDyQukZG30AEKFNGGTm3yWZIfO852UxOdw==
X-Received: by 2002:a05:6000:1868:b0:381:d014:9be0 with SMTP id
 ffacd0b85a97d-381d0149ed0mr8845872f8f.17.1730811888759; 
 Tue, 05 Nov 2024 05:04:48 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116ac7dsm16160227f8f.105.2024.11.05.05.04.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:04:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/19] target/microblaze: Rename CPU endianness property as
 'little-endian'
Date: Tue,  5 Nov 2024 14:04:13 +0100
Message-ID: <20241105130431.22564-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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


