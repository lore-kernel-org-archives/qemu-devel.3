Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB617CA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 15:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up7PT-0006mN-Ka; Thu, 21 Aug 2025 11:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up7PS-0006lr-14
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:41:02 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up7PQ-0006y5-6I
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:41:01 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45a1ac7c066so7150175e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755790858; x=1756395658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvhcTLxPsUCkPB4qwOiGoL+dUJvDmAnVbQGWGy8Tu2c=;
 b=mnBs+0/9qwJlPoIpyNGq1K423763grm+2eN4/6xCRPKE5uW+uMMgKOcSR3CEsUE1gP
 z7O59yMYNa+H2eHJY5sWlkWGHOKJKbITeLCTpJMntagWPQOSneBf+xQ0MnOza2Pi3Kdq
 z5XIHGHinanm2/FeGpRAhNA/aAsh4bnF5n65xgUWF15adixvSH7seNKK9x1nPwuXl3NZ
 lRvAotycvLbwu/jIUuqirI3rZUXsMR69aLlwjhEovSBCCgLGIHMzCUwEsD/RAzJ7sGxW
 WgEcqogRlhC0Yf5NW3oU9iF+mNkCuTJmguEP/W4zQHMcAY7apHoWEYXhiUqDdpTWXBHZ
 LMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755790858; x=1756395658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CvhcTLxPsUCkPB4qwOiGoL+dUJvDmAnVbQGWGy8Tu2c=;
 b=Feq9I+ShQSWTdS72fR8UrfgwVkNgmT9/ZbocMmwkkAaGfKDyHTf+5d0SU6YaFdyR3J
 zSnr9au94c2P61QQFnCMe/dF8q4NZqhc7SK5xBhVRDq623imao98Kts/23WP+i8W/VLM
 PN0fNvfx7n7rgMHBLn8Y0hFuVSSmGOEWBzn5mMUT6NvxDdl1xKnkxj4EWD+kWvhcjUjg
 twNLaZmTUZ1Ot5xWlJdIX8fX0Vn8lYSXi+LCc1bF5LGddeHukHMp5SQoHshHvll4eWAo
 A+UELGZrhMNZvMCsxuiuOyri6ouqiTP0p6dxm8uqh6Zgma5tDv241arrJQzhCzTavi3+
 y7OA==
X-Gm-Message-State: AOJu0Ywvb51jiXUQ3AGH05R5fA6+5WtosVtPDi7l7db7NyhSCUJN80Sq
 n5DhUAHPS9z03a3T9vNRjFDaOT1JX4LM0gqmBaGxldOzctcq0C/sXhDeepPSvZTvh0LBYVS2Bb3
 7PA5c
X-Gm-Gg: ASbGncsk5ZfMbIMxu4ZPswsYTOvIxgOJWmvtBl9EPulFPT0RHJ9eRmxLrz8D4F0kORM
 X4tkDpgps1El284afi8ElKqIhaIxvzcDJ7xxxAxRggY8TMyfsQvMsmq10BTxbKg4nttzCQeckBl
 3DgHUjXIw0p6u+sv80u4+bDrVuKQGRf3x0Q1huayhAeHO0TKilQ2NiZ4Jxg9U1QgNgLSAuRKhHX
 aMtQFoSGUkHAFuEa/ObHm8s4rV4qXw2kjXtQCLz/0lWkde0bomJDPhV6bqbfIpBYBNUJf23jFEB
 49HY9NebKnZgJGt4Ax4I+WmRH8Kzr5vjr5h9YiFneU8RlgGeNYaq53Fp7rUfVq6E1RiF+spvX2x
 x57KIsLH7BThuuJyMSfeyP2/6YRyYAKPhmiYiCKc=
X-Google-Smtp-Source: AGHT+IHhzP8ijZwJ4Yku2Lg8fAXEWLjjjJx2GgiqvYqMqHx2uHi5InwyWEW+S44sCwqs9zGP4sd0hw==
X-Received: by 2002:a05:600c:8b17:b0:456:942:b162 with SMTP id
 5b1f17b1804b1-45b4d9eaca9mr32373195e9.11.1755790858502; 
 Thu, 21 Aug 2025 08:40:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b50e0a479sm1443285e9.21.2025.08.21.08.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 08:40:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] hw/char/serial-pci-multi: Use qemu_init_irq_child() to
 avoid leak
Date: Thu, 21 Aug 2025 16:40:52 +0100
Message-ID: <20250821154053.2417090-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821154053.2417090-1-peter.maydell@linaro.org>
References: <20250821154053.2417090-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The serial-pci-multi device initializes an IRQ with qemu_init_irq()
in its instance_init function; however it never calls qemu_free_irq(),
so the init/deinit cycle has a memory leak, which ASAN catches
in the device-introspect-test:

Direct leak of 576 byte(s) in 6 object(s) allocated from:
    #0 0x626306ddade3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qem
u-system-arm+0x21f1de3) (BuildId: 52ece17287eba2d68e5be980e1856cd1f6be932f)
    #1 0x7756ade79b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1
eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x7756ade5b45a in g_hash_table_new_full (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4445a
) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #3 0x62630965da37 in object_initialize_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qem
u/build/arm-asan/../../qom/object.c:568:23
    #4 0x62630965d440 in object_initialize /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/ar
m-asan/../../qom/object.c:578:5
    #5 0x626309653eeb in qemu_init_irq /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-as
an/../../hw/core/irq.c:48:5
    #6 0x6263072370bb in multi_serial_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/char/serial-pci-multi.c:183:9

Use the new qemu_init_irq_child() function instead, so that the
IRQ object is automatically unreffed when the serial-pci
device is deinited.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/serial-pci-multi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 13df272691a..9410428ba90 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -180,7 +180,9 @@ static void multi_serial_init(Object *o)
     size_t i, nports = multi_serial_get_port_count(PCI_DEVICE_GET_CLASS(dev));
 
     for (i = 0; i < nports; i++) {
-        qemu_init_irq(&pms->irqs[i], multi_serial_irq_mux, pms, i);
+        g_autofree char *irqpropname = g_strdup_printf("irq[%zu]", i);
+        qemu_init_irq_child(o, irqpropname, &pms->irqs[i],
+                            multi_serial_irq_mux, pms, i);
         object_initialize_child(o, "serial[*]", &pms->state[i], TYPE_SERIAL);
     }
 }
-- 
2.43.0


