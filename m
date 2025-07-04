Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21A6C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeMy-0004VN-Gt; Fri, 04 Jul 2025 07:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMa-00033O-A6
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:54 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMY-0004D4-0R
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:51 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-235f9e87f78so9676365ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627628; x=1752232428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdSAk97v2JSe8k5QnqQFx0dJz3dX1gSeCclLDALqBQs=;
 b=NLujgNwxXHJR+5bTxYTQ0WXM6q662oMU5vyhln4TQ6KECAnDTEj92Ifzy1z0zhrwqD
 2f55QzRbVTlyakYWWDkv3I6O6COeGw+5ZX8ro/jawuQlXIR3+inifvb6tDRy4hgsmLkm
 UASv0OFcoCqf99O8ChYRxFeVTY69pbcI3tQfBn63ckh4BwBl1rdEJ+ohV1wu5feUkJee
 /cwPCQSVu0LfAErqGK88Qn52o1WVagiLIvhB5ULh4QLKKYKiVIrTN2Kz18fVf4BVslVw
 r1b4WCX6b33XE1oIUPsRpXCft9xTBAeW5s6wmPiFnBufkMAZMqG6QKjJAQCuo1NT7sWC
 oMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627628; x=1752232428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdSAk97v2JSe8k5QnqQFx0dJz3dX1gSeCclLDALqBQs=;
 b=aLh8FvQtuQXHiDc8SAEXJOre4GiDpDjVWGKgNdQQbNuoT5wNT5rnf1FM3AFKce0zTb
 BuIoJM2k+CthWRPiesKzlxtnWg4XLOMK0VRzAsIDSbyoZAQAD1igeRAltQoLohsDktdK
 b0sp+YgSDIwYgJ2hp2J56YVlBvj1jWw6e+LnWZclySinMKBb5+P8Fsavi++fBNT+rAGZ
 HhrAFU4/dFJ4MIrNfKzj9fkxhVHxuym5QKqkVZ8hgPrpYoJ4+jOzbX3cb0v2++YtkKEi
 a4+mvHyI665xAFSydw93o6m9xKrkJKRZmEse8M66Igq/vaQBeLySqdUyZGnNVZkhfKpd
 VSGg==
X-Gm-Message-State: AOJu0Yx4iifNdKBAlj8jBCWVCWT8YdRizKNWmj+++PGsA/KE4hxtCq0N
 2h0KvhQ1+TDBKSiS2Nhto1wPYpuznxgzRzlH/kxMAXeTwwaLvr0qlDcGZHKt5Q==
X-Gm-Gg: ASbGncvK/Rr7ZbzB4944AAe9nWVDdeuMRZ5BQLKSw7fQALu6B62lMyMSr6uj//CCS44
 SLnVjNrV3bZkVjF3A33DUg2BYKy0JBG5j7ZrlVeTrSU+fhgrnbIa79UKGgi1lyaxnZkXmt2TWFp
 BVWoYMjD7u2n8OthvWRON6ANY2J44/LQYukM4g91Jj4RX4j1gw8mOKrP64DwZkQAfo0vYL1wzT1
 ssFTZ1TVCRbPrYp7d9xb5p9tR25i6twmkaMPIpnY8E6VFcLg6tLcf+BXJYrzxsVeMfFEIRQY3Q3
 Cginf5Pxi7P238nnxdQC0cA25ivN8whAnLxXYqqvR1K4bIbEe53gv8VmNgC3jclAlIgDl/L3dfz
 QCwbBtsbyS42nByLF4iitV0te5V3eO7hx58qaTUyeLsFfBBz3GaTqF7pGqGOe1/HL64E=
X-Google-Smtp-Source: AGHT+IHQeGkZZnVT2amVEwLqnPlF9vkywSYadPhY2CNRS6gJbTwdQCKmi2Lno1hS2EBiOZ09a3vRfQ==
X-Received: by 2002:a17:903:1446:b0:235:e942:cb9c with SMTP id
 d9443c01a7336-23c85d9f014mr38510715ad.5.1751627627816; 
 Fri, 04 Jul 2025 04:13:47 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/40] hw/riscv/virt: Use setprop_sized_cells for plic
Date: Fri,  4 Jul 2025 21:11:53 +1000
Message-ID: <20250704111207.591994-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Joel Stanley <joel@jms.id.au>

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20250604025450.85327-7-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4fd966a342..67e60eec1f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -493,8 +493,8 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
                          s->soc[socket].num_harts * sizeof(uint32_t) * 4);
     }
 
-    qemu_fdt_setprop_cells(ms->fdt, plic_name, "reg",
-        0x0, plic_addr, 0x0, s->memmap[VIRT_PLIC].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, plic_name, "reg",
+                                 2, plic_addr, 2, s->memmap[VIRT_PLIC].size);
     qemu_fdt_setprop_cell(ms->fdt, plic_name, "riscv,ndev",
                           VIRT_IRQCHIP_NUM_SOURCES - 1);
     riscv_socket_fdt_write_id(ms, plic_name, socket);
-- 
2.50.0


