Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2240EC30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlwH-0004wh-3I; Thu, 27 Jun 2024 06:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwF-0004wT-UD
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:11 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwE-0001ZC-B3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:11 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7067a2e9607so3839391b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482469; x=1720087269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SbOXMdD9Afo9G+k2c8nKcFprRWncVmzYgA0dcpIFRM=;
 b=fl9UINKxO0NLuqqzyo8BT2fq5WyQXDQZRQdWHakguc15GULVtHUO4hCbOhFLN62IMd
 ZB2sl//WkbQv7ZnnK+BXlFe7i6KyVrvoKFM5KBlQ0VaVR+vvL6NO1hqN/l7bddbX7WXW
 a47+XXXmkyKWvqID1ScGQ2JUeWh3dTw+UEzm4nEY1lCsmmK7B4Fm4BvAW1CLUHXoazK/
 lQoBjsb/A2PYCQft7JeQHaM5+Ohy6Bi4f8VDjaSE35W7klCoQZLqjhHQPm80jl8M1hu6
 Ev3rC0ztXYjFLIMRhT0OsVABu6IC2kkAn291LZLpe8czZCPr7Ny3LqXux6AnkoFrL38V
 PMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482469; x=1720087269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9SbOXMdD9Afo9G+k2c8nKcFprRWncVmzYgA0dcpIFRM=;
 b=mcO+jj6sUVQOxHKV+tsCN+NBg7eD16OtwUjb4NOl3wbP/QuC5S6lkwPsV6x3WZxYpR
 FT+4SS/UCaKawc9ZCPfdBQRK62akJuWLuboPfQ5AujdQbwgreSS1joQMXsa2pYvkft5u
 D+WhIzOyeOba6pGRaewGcgZnGbruYLVMpTcUQCbKxCwCF+/GaNrB/h9vxtu2I0kESQ8Q
 MtJf4iewcxX+VtJFL5F2DJRNUURNekmAuPVgrNQ7aeWAN67C98dMhOp89KXz3cnpLXbd
 QjcSXqYZK8zjAJH2igvVct61H4sP0T9rdAafI507e6j8lj/Gay4tecMKv1Sgg1ElTNwK
 cRsg==
X-Gm-Message-State: AOJu0YwzmGfmr29ml32dqenShQNM8eFhSemW+ESSTUrydNtVElm7VRed
 8siZL0PreN0kNDVRCbTYb+4WkKEiDl+GvqZdG9GvsSXcUGB1IDRkn/EOP8pE
X-Google-Smtp-Source: AGHT+IF3MUcSMi3w/Up7qCoJNqQKwduv5II7kpoB4syDjuHb27AzrelLTkCBjZsYc8HV4bQwjwBOhw==
X-Received: by 2002:a05:6a00:18a3:b0:704:3a0f:1d88 with SMTP id
 d2e1a72fcca58-70670ffc05dmr19409067b3a.21.1719482468559; 
 Thu, 27 Jun 2024 03:01:08 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:08 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/32] target/riscv: Extend virtual irq csrs masks to be 64 bit
 wide.
Date: Thu, 27 Jun 2024 20:00:22 +1000
Message-ID: <20240627100053.150937-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

AIA extends the width of all IRQ CSRs to 64bit even
in 32bit systems by adding missing half CSRs.

This seems to be missed while adding support for
virtual IRQs. The whole logic seems to be correct
except the width of the masks.

Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual interrupt and IRQ filtering support.")
Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.")

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240520125157.311503-2-rkanwal@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 58ef7079dc..dd89edb06a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1197,18 +1197,18 @@ static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
  */
 
 /* Bit STIP can be an alias of mip.STIP that's why it's writable in mvip. */
-static const target_ulong mvip_writable_mask = MIP_SSIP | MIP_STIP | MIP_SEIP |
+static const uint64_t mvip_writable_mask = MIP_SSIP | MIP_STIP | MIP_SEIP |
                                     LOCAL_INTERRUPTS;
-static const target_ulong mvien_writable_mask = MIP_SSIP | MIP_SEIP |
+static const uint64_t mvien_writable_mask = MIP_SSIP | MIP_SEIP |
                                     LOCAL_INTERRUPTS;
 
-static const target_ulong sip_writable_mask = SIP_SSIP | LOCAL_INTERRUPTS;
-static const target_ulong hip_writable_mask = MIP_VSSIP;
-static const target_ulong hvip_writable_mask = MIP_VSSIP | MIP_VSTIP |
+static const uint64_t sip_writable_mask = SIP_SSIP | LOCAL_INTERRUPTS;
+static const uint64_t hip_writable_mask = MIP_VSSIP;
+static const uint64_t hvip_writable_mask = MIP_VSSIP | MIP_VSTIP |
                                     MIP_VSEIP | LOCAL_INTERRUPTS;
-static const target_ulong hvien_writable_mask = LOCAL_INTERRUPTS;
+static const uint64_t hvien_writable_mask = LOCAL_INTERRUPTS;
 
-static const target_ulong vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
+static const uint64_t vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
 
 const bool valid_vm_1_10_32[16] = {
     [VM_1_10_MBARE] = true,
-- 
2.45.2


