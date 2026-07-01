Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B2BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes21-00016l-Su; Wed, 01 Jul 2026 06:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes20-00011o-HR
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:00 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1y-0004jn-UO
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:00 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso824118c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901138; x=1783505938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GJTmb7JTT81bbVI0cEDaE70d55XevEsg0cLzgv9BI8=;
 b=W40dofVNcgjSMTAjnxQxFvvK9IM+6tj3424gw1CrFDt6/jJ+0qZbx0H4PPiY99uEUU
 s/Ly6mnbCfbduvW4395Qtla/uMw5Jf9PCIjUF3iOnMPXCzY5P8HNjIcMtPiDzQIaqCgR
 YGPn42MnxFIbyIGQrcoM08gAbR5xe5WbnhPjQ2UfU3JUHZsmUmCZkMWQ7W58JwEzH+sn
 WR9VJOw99QtJmic8Immdbmz0v+aESbGDA9XJ1uhq5CgY4wbbUwsvVz/OZymhhLzgvZyF
 ZEbzky7kBcK9azcaObioyTa6jVlS0cxypkE1ycMzj0mzGtkhXzlj8zACkmEXRN+GGyTe
 1WXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901138; x=1783505938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3GJTmb7JTT81bbVI0cEDaE70d55XevEsg0cLzgv9BI8=;
 b=ZCBX0EcjONTLWRpz9UfYJUuPyhbyWIWiCnL29SijG6wrJ4mn1+7wPCuHTOk7leUsnC
 RJtVW51wT1K24QUGbZR/6XfnU/3z9vNxzlDIg25OKw6SnxLoEfFJSU7ooqBV9nXC09gX
 qvH72FcxpMzk7yDYJ9/qrQIxv0uRp9WW+IwIX9E3pVexJ3pTVf9ZAoFerhlAXpXY83RX
 TPg78JoTaJjQSuBx/WtD60Kix+fZJQ94CVgqV83aOyFaagF9rgUUC+FpRn63MxpMqFl6
 MBxcSidpc5M2EzwTUMxY+NtFM6ht83RqiLH2fXKjTX7T6lKR4eUMPMppqXrCazcEs4aZ
 B+jg==
X-Gm-Message-State: AOJu0Yw19ynTuTtBBYvrHvH2mr3CkUwe2mm4FhI8Zl4vwY09LrXJ91uw
 9y1Qu0hx/FA8yD77JmU0JUY+fYGG/Ag3zGdTpq/p8Zm5V7QINUir58iT4+04Xg==
X-Gm-Gg: AfdE7clXsXPtqcwdyJ/30rCUsCk5PGDMCIuIQI/2b5iyHbOKnhk7HpSCEF1DR0XJwwN
 78UZhZqWuOCJz4/vatEcTAD5KusXvkQRv6V8IsA5eRmwSr7BNW8EyDu74Bh9n2L8ZavhK120DI6
 97sJJFdal7FVNLB0soFJM+Hf4guVIQ7rxU1/eOaaOqvfq1LiTrTvb72mq49dveQiJtg94HU3D2O
 dNnilumQRguQdQjPLxunA4XEtHru12GPuudhN97i8EHhioSYUPkEyiZMF9Mzp9x6m+71uHAuym5
 GRqy3/NaqXMxnb/rFDY8RdEBT1la3BEmfqFYPRras7UZzLCagzxhGpCkstalwKBnKQ03dTGJn44
 hyKbsPMIYebASRhVkxkdB84ss+aeIbBk6H2JgZ91kV7l76ud8Ce+IqC72gdPIeKZKjBfLilTeaN
 HFG3et+kjlaVXL3s4ItQS92LuLy+mdlpU=
X-Received: by 2002:a05:7022:e17:b0:139:f599:8124 with SMTP id
 a92af1059eb24-13b36d86554mr1114654c88.3.1782901137447; 
 Wed, 01 Jul 2026 03:18:57 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/39] hw/riscv/virt.c: change 'plic' nodename to
 'interrupt-controller'
Date: Wed,  1 Jul 2026 20:17:29 +1000
Message-ID: <20260701101752.2522962-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122c.google.com
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

We're still using "/soc/plic@..." as FDT nodename in virt.c.  This is
not the right nodename per the DT docs:

https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/sifive%2Cplic-1.0.0.txt

The nodename must be 'interrupt-controller@...' since the node inherits
the 'interrupt-controller' type.  In fact, ever since at least the 2020
Linux kernel commit c825a081c169cc7f ("dt-bindings: riscv: convert plic
bindings to json-schema") the correct nodename has been
'interrupt-controller' for the sifive PLIC controller.

There's no deprecation needed for bug fixes so we're just fixing the
name.  This was the policy we dud when fixing the aplic [1] and the
imsic [2] nodenames to 'interrupt-controller@...' as well.

The sifive_u PLIC FDT already uses the correct nodename for PLIC, so it
is safe to assume that available SW is already aware of the correct
nodename and this change won't affect well-behaved SW.

[1] commit 29390fd ("hw/riscv/virt.c: rename aplic nodename to 'interrupt-controller'")
[2] commit e8ad581 ("hw/riscv/virt.c: change imsic nodename to 'interrupt-controller'")

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260616235939.1358663-5-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 33775a61fd..fa464e644f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -335,7 +335,7 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
     plic_phandles[socket] = (*phandle)++;
     plic_addr = s->memmap[VIRT_PLIC].base +
                 (s->memmap[VIRT_PLIC].size * socket);
-    plic_name = g_strdup_printf("/soc/plic@%lx", plic_addr);
+    plic_name = g_strdup_printf("/soc/interrupt-controller@%lx", plic_addr);
     qemu_fdt_add_subnode(ms->fdt, plic_name);
     qemu_fdt_setprop_cell(ms->fdt, plic_name,
         "#interrupt-cells", FDT_PLIC_INT_CELLS);
-- 
2.54.0


