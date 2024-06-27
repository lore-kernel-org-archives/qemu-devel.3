Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D1BC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlwj-00052g-4S; Thu, 27 Jun 2024 06:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwg-00052A-OB
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:38 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwf-0001eP-6V
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:38 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c21ef72be3so1036457eaf.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482495; x=1720087295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jZvBLMTasb9eS7DfRHEia3PyJ7fRL3eXKnFZzLUWrg=;
 b=AmPNSxYAouIOWVMAIpmDhG3NyZ0jFczMvMQ/SiKSUSLlyQiduAsZd+BheODN6UaHfy
 8+5xnd7NgJbIeBXfIN+8c1yvL5vCW1CvOxfyTRoNuz5nkPCwmjA0UlsZWV6zck7XjehZ
 Xr9t6D7z2cCvMnVdykK37lBHmpIFefOTyZJ6LZgYAKPVJEwLRmjrxcMud2RpQIo93Jn/
 hMJ1aQutOh3AOe/nxGrqPX697NnLJLUbhnOq7ajbSKbtGs6yjGSZvw615Yr2dbV4NwUc
 4zxt1yJ5xlj81QsQVqaDgrY2mSd050g/1DNr5S6Aue5ptY/u1Iuks+YMl+XJFxSfeymA
 p3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482495; x=1720087295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7jZvBLMTasb9eS7DfRHEia3PyJ7fRL3eXKnFZzLUWrg=;
 b=TvrpdX3yRrae6VSplIzF7Kjrr431YfYl1BL9zp0xjOYTqcR8nq82a8XME9fuMBHOdd
 9cFkatsnFB3ETkuxJ7skX2VSI5rAFNeISBsnzWqSXECN3/5NhnBFCz2WtFR0WpmGNIUV
 t9VvDMUvLiJh6+Z+si+Nt30wfmU15FcanU/cuJz4kp+Tt0ysdZeLfGtKEg1oMpB9BqSt
 +DG/53FrEibXQTA56bJ22vFK5lEZtgwcCfba0OoY6XxZz9DjXr1530Mc7SYQ55+jViaG
 3zKhyBYmPgs6JEnTl+yPTv4wY8LyMCRHz0as2GMrBDwfugHfcyN2ZEI0MPtquaTCv7TU
 ChaA==
X-Gm-Message-State: AOJu0YwJ0EbD9GmpHxgv9Eq9tSL0e2FvisSeiI1RFvLvfbxG7/JP5dr4
 sOxBsn1HCrX3ieDAHuwcnwVDNMA8vUfGuHpQWSIt6zYLsXXVP+Kr2QZ2p2EW
X-Google-Smtp-Source: AGHT+IEHV26eGqKyh6Lu7Ts7gc/X3NzhEHoElKQAVXolVRBvMjC+mdR8tnAdZSfiXIq0LvVnFNdq0A==
X-Received: by 2002:a05:6870:158d:b0:24f:dc76:f6d2 with SMTP id
 586e51a60fabf-25d06e2890emr14257687fac.45.1719482495537; 
 Thu, 27 Jun 2024 03:01:35 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:35 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/32] hw/riscv/virt.c: imsics DT: add 'qemu,
 imsics' to 'compatible'
Date: Thu, 27 Jun 2024 20:00:31 +1000
Message-ID: <20240627100053.150937-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The DT docs for riscv,imsics [1] predicts a 'qemu,imsics' enum in the
'compatible' property.

[1] Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml

Reported-by: Conor Dooley <conor@kernel.org>
Fixes: 28d8c281200f ("hw/riscv: virt: Add optional AIA IMSIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240531202759.911601-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 376e362a68..e1ecf79551 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -515,6 +515,9 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
     uint32_t imsic_max_hart_per_socket, imsic_addr, imsic_size;
     g_autofree uint32_t *imsic_cells = NULL;
     g_autofree uint32_t *imsic_regs = NULL;
+    static const char * const imsic_compat[2] = {
+        "qemu,imsics", "riscv,imsics"
+    };
 
     imsic_cells = g_new0(uint32_t, ms->smp.cpus * 2);
     imsic_regs = g_new0(uint32_t, socket_count * 4);
@@ -541,7 +544,10 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
     imsic_name = g_strdup_printf("/soc/interrupt-controller@%lx",
                                  (unsigned long)base_addr);
     qemu_fdt_add_subnode(ms->fdt, imsic_name);
-    qemu_fdt_setprop_string(ms->fdt, imsic_name, "compatible", "riscv,imsics");
+    qemu_fdt_setprop_string_array(ms->fdt, imsic_name, "compatible",
+                                  (char **)&imsic_compat,
+                                  ARRAY_SIZE(imsic_compat));
+
     qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#interrupt-cells",
                           FDT_IMSIC_INT_CELLS);
     qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
-- 
2.45.2


