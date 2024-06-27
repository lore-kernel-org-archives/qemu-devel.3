Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1863C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlwd-00050B-Pj; Thu, 27 Jun 2024 06:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwV-0004y6-5o
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:29 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwT-0001cH-BE
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:26 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-707f9c3bd02so110190b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482483; x=1720087283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lk4RFwjLc+09kgFZ8qZ2DitRvmSjRrWDbykPLIpzSxg=;
 b=DMO48xq7qswwCmjUMpzeHibPETezpVZ8njOi5aoKKScjhEcUPviOWB91I3tkEA28U4
 VDQDxv4h4HPKaBPVRx2tk7IZg7rU/GfqB/8zb5maQoW+7R/wZ4hUkzPlKazb0bbkiPG8
 dua5+GkPLgU1sPscpbX6UIslprtyjbt9Ed0sGQRnx0MYXvFDNeUAIclXSbt7I61serjU
 2eDXKxKn3jge+TtizgOfZB8Oazi/J0B5cg9CaugPhWT9tXcVgEkhwifDAUBB4/jUYB9d
 eq6BpDt2jdA0cn2o6ocWnGUmmwUBRFmamutg5Kk+5wqJh6owQIWjeZ49hHrqJuxPW0Fm
 mSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482483; x=1720087283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lk4RFwjLc+09kgFZ8qZ2DitRvmSjRrWDbykPLIpzSxg=;
 b=OoGTDcNt4Wb8QNsbuUsTQenKyQOA1GdDk8PJfyMyECOucbGuzjZue0ipqM7mf568KP
 jSxNbnwVcy9bNdDWid9IbZi9TMqZdHw1wiAbhCKLqgmToY+nJolXWtFVcMDk4jzouV5z
 cB0LEVxzHLudZEiCgDPeGL/VA5m6VTqLfi5+Pmfik2NTmfFRtt0xhZU4ZIKpnaONcCOT
 Mm8BY5KA4OCWNJIUa09USUz55I0dlDAF46TO9XE71JUHPttAA7LesUZpuK6AXiKecPr4
 i8r5Rux1/OCbcbf8kFBop/VUCqh9lkPP6sv82B4O61gEW64Y+TzLCoi8M5KzeFDUfIQK
 IKxw==
X-Gm-Message-State: AOJu0Yw/90Sr3d6BYHh2mW488kJ0wt86+nq7C9soIO8q8fgnggouY4kP
 SsABeWP5PCXuP0ME/GwLWCi64OcO5ppuvCD5zyOtpfpi27LJqvbIBjgbgNxb
X-Google-Smtp-Source: AGHT+IGCzweCVynD46ygmLkjsegPoRR0Fb8+6wbRBz6QNj3O8uMTLkcGNsAVe4PuQzEKJYBiDRwwWg==
X-Received: by 2002:a05:6a20:7528:b0:1a7:7ac1:a3ba with SMTP id
 adf61e73a8af0-1bcf7ffa0f7mr10896541637.53.1719482483292; 
 Thu, 27 Jun 2024 03:01:23 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:22 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/32] hw/riscv/virt.c: rename aplic nodename to
 'interrupt-controller'
Date: Thu, 27 Jun 2024 20:00:27 +1000
Message-ID: <20240627100053.150937-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
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

The correct name of the aplic controller node, as per Linux kernel DT
docs [1], is 'interrupt-controller@addr'.

[1] Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml

Reported-by: Conor Dooley <conor@kernel.org>
Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240531202759.911601-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 569d9def24..a803c33e21 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -591,7 +591,7 @@ static void create_fdt_imsic(RISCVVirtState *s, const MemMapEntry *memmap,
 /* Caller must free string after use */
 static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
 {
-    return g_strdup_printf("/soc/aplic@%lx", aplic_addr);
+    return g_strdup_printf("/soc/interrupt-controller@%lx", aplic_addr);
 }
 
 static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
-- 
2.45.2


