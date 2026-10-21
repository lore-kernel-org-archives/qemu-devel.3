Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA6606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZtqbI7tZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJWlb-00070N-Cj; Wed, 21 Oct 2026 09:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJWlT-0006yy-1O
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:54:00 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJWlR-0007gH-EI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:53:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e9cf928dc9so9470205ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792590836; x=1793195636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dxnFporQ4rn5YtvH0PzOh6MHgLq7rylmA6sbBANnVyQ=;
 b=ZtqbI7tZF3tPTnBMMih3AnCN6dqtlEWjHR9HAkE2Xz1s5LFEXeINZsLK1aXGjN/mme
 7oZYnz7TjqnEu/Ny8fMm3pn/JK+XOpGjvkh8V3sw6EDPRVwsKxDtWwkn3O3/bdtK0pJO
 vqWimOOuCedk4QmJpE1mRH6uM/fUYa8I9GI5FY3a8+LUaCH8pF9ZFwmlnDNPqeNWFD72
 5+k/bs1IycvcYphU/ig0VLQu1RNwDMqOQoAmr907gCctuk4VmfVahC5SffyNBrod7sJE
 g0BpcUwXEfw1/1s7oFZcdrIZrZjfdVbHNHnUbhxVHUXybeZoVaQMyWy372sGbt3wDWk3
 o/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792590836; x=1793195636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dxnFporQ4rn5YtvH0PzOh6MHgLq7rylmA6sbBANnVyQ=;
 b=Vnl4NsCHdYzFIDfdbJ0ZhcGHBy6Cp+EGy7fWo7M3Z0sA2KUy8p782EM9eMwnWdMhcI
 iAdKmrSYaePJOy8Q5mAXKASorF1sP5zQCRsm6Te+KMUkR+i72WMZxnAmB24Z7Ijzvwo2
 2I/xsW6sRO6IltMBERsMGI7V5sR5OagydT2AlEWNwCAGVYdEr5ufwUnk5UFhf39Srz6z
 +RYkwwUiMIzQ6qFbOljNZbHxA8KA0MaXJ8Y37MTNIeT1bGvhYuQDWrfYJPjiTaApfJvA
 t6+RB2lKYG6Xtr8kV3BPnQOeY5ImuIqDhIaKO/nvEzS1tp5b2yzLR0L4jPa8YlLNyqkV
 ikgQ==
X-Gm-Message-State: AFq9FYK0h0CGfE4KxtDssYrbLSFmWlFqYQpf38EYHE6uYS53nWUdJY9Z
 tdJmADN4Mq8hCKMKOZLvAy98R8P9bQFsWz6uIkhcXGz1YKnQYpGPX6buCODfRm5+pOePKQ==
X-Gm-Gg: AYBFou0K9dpK3liNKkhiQ1w4/wqcUYNJqDpckF6HmNTYC6JH25rJkoL47adJ3sdoLAG
 +NuaAl6eiRZRbQfhMhZNngT5TRN643ozeBEsLrtEi2Zvc4e8gJ+vcasV0YKYAqJbkC8ga6SOr41
 1RamW+8yEJQEBAaozVPpXAcSRJdzgojHWuVDAL1zgUVELl5L5zpQnsbtdcxtjOVzmKNrncMCs4/
 FHUHPL66+juyXP1suN8ddYxUtQ7g9p0fqL/Wxi6Ccr14EdpfRrs3wZq6Rd3gzq80L/Y1XzjbU0u
 gVt6STi/jDVVtVZEAL9wxV9/98Vay0+HD5+RmiJOE+UWjRPieQtkNhVg7DlW2oxdChTyIXdzyir
 G00uqzhSzX8jHKSLxC4jl/Y68RuJUO3IhtqT926wx2KsK0qOFMztOeMvcMESELnLCMrBFsKWD37
 9tdbuvkbcSv62qBwrER2KzCuFg9l/vcdctrK1ts8U1LgBrXVBwAprQ7COHSoB+xndYa6GSRJDGy
 x0IsilJmXGkxt3moz7hG8uks6b7LLY0R8lGEVZKHaSXLgDAx5IZscuZRVQf
X-Received: by 2002:a17:902:d4cd:b0:2e9:95b9:4bcb with SMTP id
 d9443c01a7336-2ea43dcd579mr11076855ad.14.1792590835704; 
 Wed, 21 Oct 2026 06:53:55 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b49caa7sm11865135ad.69.2026.10.21.06.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 06:53:55 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pillow <waysorrypub@gmail.com>
Subject: [PATCH v3 2/3] hw/loongarch/virt: Drop UART _DSD/_CCA and add _STA
Date: Wed, 21 Oct 2026 21:53:21 +0800
Message-ID: <20261021135322.473781-3-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021135322.473781-1-waysorrypub@gmail.com>
References: <20261021135322.473781-1-waysorrypub@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=waysorrypub@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The UART _DSD contains only a clock property, which has a typo
("clock-frenquency") and the key/value order is reversed. The declared
100 MHz also does not match the current QEMU model.

The Linux PNP serial driver uses uartclk = 1843200 Hz by default, and
the QEMU UART uses baudbase = 115200. These correspond as
uartclk / 16 = baudbase (1843200 / 16 = 115200), so the Linux default
clock is consistent with the QEMU model. Since the clock property is
the only content of the _DSD, remove the entire _DSD rather than
keeping an empty one. The QEMU x86 ISA serial ACPI description also
does not provide a clock property, which is consistent with this
change.

Also drop _CCA because the emulated UART does not support DMA, and add
_STA = 0x0f to indicate the device is present, enable, should be
shown and functioning properly.

Signed-off-by: pillow <waysorrypub@gmail.com>
---
 hw/loongarch/virt-acpi-build.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 54965f0..55c7641 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -314,7 +314,6 @@ static void build_uart_device_aml(Aml *table, int index)
 {
     Aml *dev;
     Aml *crs;
-    Aml *pkg0, *pkg1, *pkg2;
     Aml *scope;
     uint32_t uart_irq;
     uint64_t base;
@@ -325,7 +324,7 @@ static void build_uart_device_aml(Aml *table, int index)
     dev = aml_device("COM%d", index);
     aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
     aml_append(dev, aml_name_decl("_UID", aml_int(index)));
-    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0x0f)));
     crs = aml_resource_template();
     aml_append(crs,
         aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
@@ -335,15 +334,6 @@ static void build_uart_device_aml(Aml *table, int index)
     aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
                                   AML_SHARED, &uart_irq, 1));
     aml_append(dev, aml_name_decl("_CRS", crs));
-    pkg0 = aml_package(0x2);
-    aml_append(pkg0, aml_int(0x05F5E100));
-    aml_append(pkg0, aml_string("clock-frenquency"));
-    pkg1 = aml_package(0x1);
-    aml_append(pkg1, pkg0);
-    pkg2 = aml_package(0x2);
-    aml_append(pkg2, aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301"));
-    aml_append(pkg2, pkg1);
-    aml_append(dev, aml_name_decl("_DSD", pkg2));
     aml_append(scope, dev);
     aml_append(table, scope);
 }
-- 
2.56.0


