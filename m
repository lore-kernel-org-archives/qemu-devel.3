Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6142DC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjYG-0007l4-Sh; Sat, 25 Jan 2025 12:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjY7-0007Tc-VN
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:25 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjY6-0000VM-E3
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:23 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso1719390f8f.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824539; x=1738429339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yoQ5t8eM4wCpvT97M9dMQOs6qSsBVPtoxCHVU1aZxhE=;
 b=D89+wa1yb8lhJLBtHip/MtXMZJXqXqqZbtfXl4+7Lt05+U7bwzKObVf73yXSosj3LN
 3UafjpJxwfc48AwSl2X0aGX6EfmDjUhf0r+EtsHixR45vAEOLyeeZb0j7rrK7Rm4xrVY
 rajjUPsCyiaepy2k9IXdQdR3703OGSTXSt34BtYgygmRptp54FlfAk0POEzMFviKkgOD
 kUT1gQAKE5J9lGSRGK5JqUp1FHl90LQgGqJBJAozM+z4i7JmsOy3kEfIaq4JQhasSEOl
 pfJAzq/d3OVhxye6KI55e+5AG9hMY8PXvJ745sThZdRFPr95xZVAWS4waw4qvYe8CDYs
 aPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824539; x=1738429339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yoQ5t8eM4wCpvT97M9dMQOs6qSsBVPtoxCHVU1aZxhE=;
 b=TYXNgR9VG9b22UD6Ro1b3bfrCAo7Mg68xmXR54HuC1NjM3PGAvlssWu4RxfzmdiWmf
 cHD/jFwfJWdsZ87wllg24TiKVA2KQkN3kk+PGuS2qeN54P5FENtbw5mL3FF0X8sO3o7B
 3DH710PakWxGM7rCPzCyKAK2DLxIxvrQZ0xasYXLkOmnZSCQ392+mYlknorIkNNY0ih9
 Gd1SsFQj5l4D66EB6rhx+6UqOuDViEnaNS4mai51Iqz7VnXjvnXFMbwxPZlrGVoxDlsS
 bUATWzCaqW4SJ6xLxgNla4lRJKIpqxIBCAHPJKGMf1VjdKZ5DE/e7qaB4Wn2hvuuT+tU
 gM3Q==
X-Gm-Message-State: AOJu0Yw16CpOR8M4nVr2MvdiGOjGT7jS8PCYlW6rxY5qMShtI0lTAg2E
 UDDBT/23vL2TiSZ+dzIs9OttRAM+rWuXAuyNP+sZ0oMYaCWJA9ePKBfg3So0dRgNdbIBJ/m3hz8
 HTNU=
X-Gm-Gg: ASbGncteSQDVXXcpgYx93sNxJkgtfF6itRcDoPo49zOgFJ5wrn0P4GX0B3tTfmZW++H
 kwppeUeWF5OwTFx2r+fwqNUYVW9QP/UexTf+ix94xYBuqD6MHGnDgmuDpn/78Fb5rsikq/VNHmz
 Ax6ibJgI6Tbx42yECW4Z7NucbjtkdGKmY7nbNdv2OlLYWQ5LmgI7okT4EV0+qC7pvRUubmr9qF9
 a85sdGJ1aVjL7oX7NxVqDPu47+ut+/lmWsiPLlhXNNVlxVYFEzUoUpFpxMqYTQKMbk9TXyJiUHx
 m4+Vtz0Ro7uqhEnYC6pMc6WIzRoZU5sAtBH3Nxi04WfAusPPFXfxmV8=
X-Google-Smtp-Source: AGHT+IHzKcFNJPqwig4S8ifkQ1YTvx+5fHQoFPfZM+cZ1RBxsw1CK7P8rChQn+MKTN1dw753y3eI/w==
X-Received: by 2002:a05:6000:1864:b0:386:3328:6106 with SMTP id
 ffacd0b85a97d-38bf59e199cmr37773444f8f.35.1737824539518; 
 Sat, 25 Jan 2025 09:02:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17650esm6046557f8f.12.2025.01.25.09.02.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:02:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/24] target/m68k: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:12 +0100
Message-ID: <20250125170125.32855-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 41dfdf58045..eb7fb4f7e4c 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -51,10 +51,12 @@ static void m68k_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool m68k_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int m68k_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -543,6 +545,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
+    .has_work = m68k_cpu_has_work,
     .get_phys_page_debug = m68k_cpu_get_phys_page_debug,
 };
 #endif /* !CONFIG_USER_ONLY */
@@ -576,7 +579,6 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = m68k_cpu_class_by_name;
-    cc->has_work = m68k_cpu_has_work;
     cc->mmu_index = m68k_cpu_mmu_index;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
-- 
2.47.1


