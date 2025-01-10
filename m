Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0D2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 17:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWIsG-0005WP-0b; Fri, 10 Jan 2025 12:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWIs2-0005Tc-FQ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:32:31 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWIrx-00009I-UV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:32:28 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so26912405e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 09:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736530344; x=1737135144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pG3zaZWN3xKo4fMPNgWXUV42ACJFQFragGulQEy5rlA=;
 b=rILu3Q2J0k6CtlNaKLAvB3faC6aatfR0BEKoGkmdlULzmClOJCiBEi3htZDXaf7lwm
 n8oaGJiZGIjPYdqCv9Q9JxIbXH1rT7jzjbHEA3hUVy9RI/c93+5E4HqBqBjjozlhHGsX
 bUP7ABqApoUVn+RAWrfj3ePcS6zZC2Cl8D+TL7dhl+ECaGsshEWPwgwchQZn11UiOb0a
 sf0n6y8efOy4JzLlreOig2oB0gH1c/vb0KBO+WEijCP4Fmia4IXb+4tNwD3UhUkrFCHg
 U+G8tIom1Yidi009GwDshVWbWmhInCYtUWcfXIHiVBQNiNEHs+91eb1r3F//sIrMobaD
 f/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736530344; x=1737135144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pG3zaZWN3xKo4fMPNgWXUV42ACJFQFragGulQEy5rlA=;
 b=cRVYxtp/YZs6tGbHgK2Zs01ysVdyHmm41ffVijXU4DugfxE1jZpyV/05Ug9vZv7A9s
 kxT+zyuzSTDTcyAAU4VBf7oyT5ISTE+pgm3fvIpfr8Dsq5fQFcBxm3jlFJpPCTgODoMX
 96ox3jNg/V5Eh6eLWZEG07xI/G2kC3/8FejNAGyqFrO4+zuqu0ZDlCKRg/HGRcK9DDgb
 iu+ibcZMc52RjLOYV+2e5PbbSl7uqliat+M0Lrn0HS3jCOjytj2X/TR4w2EtbhCXMNM1
 Nob3dFzrFsp+0mYxyg/9YNEoOCX7RYPToC3lQzL/la7C7w5kK4tCTaKjUCwlE70IeKX4
 k2hw==
X-Gm-Message-State: AOJu0Yyac7uCuvniIzsN60TwofHSHG6RNeYbmkIu+VEwjrbjlcIf/Zfb
 cfZ5Z1aqvOZX22nZANLveLch4YaHe4g6v20fakkRj2nUKKh/UvvbH1OkkKe+HhM15bnxRsvxyx6
 1+cc=
X-Gm-Gg: ASbGncve/sMmNOn0z5srgLmurHEstULEXCsi7k21XAxJ4w5j5e5aU5b09rCbwsyeh4V
 xx3cZX1WT9Or9XT5+l9hvYL2qpOCKKL0jAMdJopY1OkmyMHM95YBxaK0n2yvaZYuMiG1ZBzJBio
 MmRh2V1dbAk18R6/5Yyzo6+Q1QjmlVI1hjA834zZek/7oUNYrjpP+Ve0f/B6GATx+IRj3QLeFCt
 sEUOfu/oiNJRTyXH+c5kN+DSrSUjqp81Vg0QOi3ABhUHQtCGwyXqimAO8RfohLJr+e5Q5S3rZb6
 1x9eAct8RkofRjGRmARXEQTbg8HWOgU=
X-Google-Smtp-Source: AGHT+IFw4UKTHnetcGf7xY5mKTrBfh3NU1eovELNRWynxfrYx/X4H35J0SQB6evrqulW+njap3/F+g==
X-Received: by 2002:a05:600c:511f:b0:436:1b96:7072 with SMTP id
 5b1f17b1804b1-436e26867f6mr117937825e9.5.1736530344082; 
 Fri, 10 Jan 2025 09:32:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dd1957sm58173665e9.16.2025.01.10.09.32.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 09:32:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] hw/ppc/prep_systemio: Use link property to remove
 &first_cpu
Date: Fri, 10 Jan 2025 18:32:16 +0100
Message-ID: <20250110173217.80942-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110173217.80942-1-philmd@linaro.org>
References: <20250110173217.80942-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

In order to avoid using the &first_cpu global, pass the CPU
as link property from the 40p MachineClass::init().

Declare the link type as TYPE_POWERPC_CPU to have the CPU
type checked automatically.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/prep.c          | 2 ++
 hw/ppc/prep_systemio.c | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 3e68d8e6e20..88a9b0fa7bb 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -324,6 +324,8 @@ static void ibm_40p_init(MachineState *machine)
         dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
         qdev_prop_set_uint32(dev, "equipment", 0xc0);
+        object_property_set_link(OBJECT(dev), "cpu",
+                                 OBJECT(cpu), &error_fatal);
         isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
         dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index b1f2e130f03..7cbf7e4eecd 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -44,7 +44,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(PrepSystemIoState, PREP_SYSTEMIO)
 
 struct PrepSystemIoState {
     ISADevice parent_obj;
+
     MemoryRegion ppc_parity_mem;
+    CPUState *cpu;
 
     qemu_irq non_contiguous_io_map_irq;
     uint8_t sreset; /* 0x0092 */
@@ -255,14 +257,12 @@ static void prep_systemio_realize(DeviceState *dev, Error **errp)
 {
     ISADevice *isa = ISA_DEVICE(dev);
     PrepSystemIoState *s = PREP_SYSTEMIO(dev);
-    PowerPCCPU *cpu;
 
     qdev_init_gpio_out(dev, &s->non_contiguous_io_map_irq, 1);
     s->iomap_type = PORT0850_IOMAP_NONCONTIGUOUS;
     qemu_set_irq(s->non_contiguous_io_map_irq,
                  s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS);
-    cpu = POWERPC_CPU(first_cpu);
-    s->softreset_irq = qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_HRESET);
+    s->softreset_irq = qdev_get_gpio_in(DEVICE(s->cpu), PPC6xx_INPUT_HRESET);
 
     isa_register_portio_list(isa, &s->portio, 0x0, ppc_io800_port_list, s,
                              "systemio800");
@@ -288,6 +288,8 @@ static const VMStateDescription vmstate_prep_systemio = {
 static const Property prep_systemio_properties[] = {
     DEFINE_PROP_UINT8("ibm-planar-id", PrepSystemIoState, ibm_planar_id, 0),
     DEFINE_PROP_UINT8("equipment", PrepSystemIoState, equipment, 0),
+    DEFINE_PROP_LINK("cpu", PrepSystemIoState, cpu,
+                     TYPE_POWERPC_CPU, CPUState *),
 };
 
 static void prep_systemio_class_initfn(ObjectClass *klass, void *data)
-- 
2.47.1


