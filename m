Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323B2C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MMh-0007ZJ-Mc; Fri, 04 Sep 2026 01:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMO-0007KP-Fz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:11 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MML-0001QO-Jo
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:07 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-853c401326eso307635b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499260; x=1789104060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=00DtHUCdr6tAoH2NitZ7oHGGDAYVNQlogbx7siUcG2U=;
 b=U6YQ/RGWrbnm/SW0OsjrJhIAhQFeml7+MvhBWeEuLgrhk8JmCG6SQocMONl5ahD2dq
 K+HnqbpyUs/onFh8yvHMvJhQG7o7StB9pGAgO+rWArLqP2TC4m6sQnhIy+dwgwVUkAMI
 0XFuPtyPsAmvu+ZMeWOc56NIEtF5S85pCxYpOOpucJGrekEHKZb0L+Vg81BG3QyQhzsS
 hDgEPGrR5gjKqIYey3IP/uYoMiSqYufpN/04jL2wQ2Aequgk/fevLL78AlniIQL29HJ6
 Z2ZwC3Y1iWzbbP2EN0+ThWAyTJG6pcehyMnvkpknNEPtapY8Gzf2C0GRo+67jV2DVEHx
 9f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499260; x=1789104060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=00DtHUCdr6tAoH2NitZ7oHGGDAYVNQlogbx7siUcG2U=;
 b=AvBJzmvRoltpfd61iZ1LN1BCylMDbWcCut2+QVu7hN6thQrIY+GBusZc2G/JIf0wqN
 jtFt7klRWDtrLZd/AFUx38fgpdJ4wP1KffyBGyz+mJ/mt3eDvPAdMCUXe41OzHOqh6z2
 UHy4xgc7OrC4XwihylS5NlhGji99B/n0aKed091aFrqgswdvjn9FZkmc3/d1cE/P0dzd
 ZYcAhfYKKhoRcwwZSi5nzdYgxypL+HhYPgm4xjaiShnKJwnJMrF7ESLt1jb7Ue8xJWUb
 LFqaBZTAnovUPA4cIktZN6StbZSJyRMbOc7ySZ94d1gpp4Vt37K8n6AVXdSmVhFU2AYE
 VUyQ==
X-Gm-Message-State: AFuF++kBGgRKjo4EgDMk+Ig7awhHiE8z1A3okDXp1nTTshxgMBjLDDNa
 0cCLXk7f3ODD7GV/q9cCGpF7kOjLWm3B44c9QAR2MCbnqqCrnWYpu86uEUVPyw==
X-Gm-Gg: AYBFou3CdUUFW35V+8Y3Z/+uaxj7Q4wxEXwDXWe1Xyo0n+9FeKM73QoJEiBTxWxNehE
 jqTbpEU++fPaMcfbkgbpB5XX11KIfEZmZcLyN4nk+0/kj1Md8m161+P+miLTfenOHd+YI1oQmWq
 6Ot4UEDnZrEUYdyVZjiBLl57EBZTmeSFdmCrYbewSdvwBaH/3RvccpIF0wUgCkqLinjooVR56dQ
 4AP/9FCHKp9qDJuXD/8nPDwAX5cYsYczob/4JE0n/CQT/lsAl7PacEiwlLQWgpQ+3V44/LqpEp4
 Y8Kykgv7gb8xOFDNnCRoQ5x8Al6L0dEwZ/boRtXdND3hH+U3NPAprx90ctreViSK07F8EVrP/TW
 hjr6TjODSFaoI7iRgsan+7Z6z8AvH5Ee2Wq25EORMQvxvMc62RGoePDFUtCV3wT1T4zRVWqTRh5
 rdGmHftBsDFPec5enzgihtkmzoo7annfR2aWatg0S/p205faTTKvXA0JYMkX2Foyasx2dJ9Q08D
 RIOaA==
X-Received: by 2002:a05:6a20:9630:b0:3cd:9f0b:f7a2 with SMTP id
 adf61e73a8af0-3da39ee15d0mr5486222637.11.1788499260242; 
 Thu, 03 Sep 2026 22:21:00 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/47] hw/riscv/virt.c: fix aclint soc/mtimer nodename
Date: Fri,  4 Sep 2026 15:19:17 +1000
Message-ID: <20260904051943.799041-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Running 'dtc' to generate a readable fdt for the virt machine produce
warnings:

 $ dtc -I dtb -O dts virt.dtb > virt.dts
<stdout>: Warning (simple_bus_reg): /soc/mtimer@2000000: simple-bus unit address format error, expected "2007ff8"
<stdout>: Warning (simple_bus_reg): /soc/mtimer@2008000: simple-bus unit address format error, expected "200fff8"

This happens because the 'reg' field does not match the address in the
nodename.  The right fix, pointed out by Chao in [1], is to make the
nodename match the reg value:

"In the current QEMU implement, `addr` is the MTIMECMP base address,
while the MTIME register is located at addr + RISCV_ACLINT_DEFAULT_MTIME."

In other words, the 'reg' value is correct but the nodename isn't.

We'll make the fix now, allowing the next patch to move the fixed version
of aclint FDT to fdt-common.

[1] https://lore.kernel.org/qemu-devel/apHH1upnh8udUUT-@ChaodeMacBook-Pro.local/

Cc: qemu-stable@nongnu.org
Suggested-by: Chao Liu <chao.liu@processmission.com>
Fixes: 954886ea6d ("hw/riscv: virt: Add optional ACLINT support to virt machine")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260828203918.350131-9-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 63a32de3b4..840dd0e075 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -233,7 +233,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
                (s->memmap[VIRT_CLINT].size * socket);
         size = s->memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
     }
-    name = g_strdup_printf("/soc/mtimer@%lx", addr);
+    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx,
+                           addr + RISCV_ACLINT_DEFAULT_MTIME);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible",
         "riscv,aclint-mtimer");
-- 
2.55.0


