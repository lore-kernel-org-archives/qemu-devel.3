Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F9CC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOcp-00068v-4h; Fri, 09 Feb 2024 06:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcI-0005nw-NA
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:25 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcH-0000bp-7w
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:22 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-204f50f305cso482009fac.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476420; x=1708081220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/nC+XRNjbRu1tLkl9+SEjgInRyZNy4S28XqYNcl84I=;
 b=QYPO16CWdIp8+ulBwBJ6G2AuM7ZYQDJXVXe1aeCZhHruJXhFPNdsoTJAdBA/I8dEhN
 6K5lvbjnu3ccbtOao+EgrSfUqzJWsE11tJt8ag4T7iwMLYTXzlsUQf49Bav/jLsRGFRI
 t0sjCjh00hLTwpBhaIl5QSkCrvdm/YBbFwVK69fxqF19zrxazWVIU0BDbUYZ5Z520OWl
 460FcR3mEB7djBgkIJ4krzp97SqbgvkB5lOz3mu9fyK/B7kWfGzd2WR0y7j80A+BxlZ3
 3X+Wp0dcM2rLL152rTzi3y8C+jg6Hnb6QLZ4F7VxVcCh6eTXMda4urR+Bv/OHrkW+MPV
 x1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476420; x=1708081220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/nC+XRNjbRu1tLkl9+SEjgInRyZNy4S28XqYNcl84I=;
 b=WHOsG0F+3f3+SBrVZ+64hiChq8N9O7gPdtHmBEuqgiasHaU7nS/CtynjofIKcko2tE
 TG/CFEJ3E8gMSXADJMgG1N4k1aRjbVil59gKjZaMwfrEzleNE4gwUs+HA2NAw8uCVXfw
 Pk8GwrDDpC/jg6DjePbSOT8siVpBL6l//64swzGxVAyiGvb6xJL3eGVCn1frmhYfiUyM
 DG6dOfvHxP/Uuntf+8a9zcMLFtbBYHo3SYLFqfqIypj8kYfeetNT+rigk4V/DOi46D7O
 6x9WsUSIohWwaC3G4HEfUIZEOEjqBRnu2/0vmSaYJLk5DK9mjPM2ACM3rOOO0YBJPAX/
 GR+Q==
X-Gm-Message-State: AOJu0YzClEa0TgtWhPc6SNq/B1UNx0Xeq36dS721ODjB1zYEj3B4Msa0
 MuOcoUzIMr5rpFCVKDZjCfT2rI41htJBo8IkmnCSSB9qctyfysFRQoHQzBtk/8FJpw==
X-Google-Smtp-Source: AGHT+IGXlN7rsjtp7biRZ9ztMsHnecu6+aHCw8h2Dxkb0RLUcFgfhiP+OwPtQnG3v0Iz4XzkUjfYew==
X-Received: by 2002:a05:6870:4721:b0:219:5dc9:691a with SMTP id
 b33-20020a056870472100b002195dc9691amr1093089oaq.47.1707476420045; 
 Fri, 09 Feb 2024 03:00:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVb9ek9VfqWvHuoa+UAgnIIodD/OuiiJK9PV0slC/+Lpm4FoMOSa1eTJQU3a2B9ei7KYjRyy39lctsjn2LjQSSqnScyyh3BJoE6NzgM0mtobTAyxN0yg/osUKyKyuxcrX5EooA=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:19 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/61] target/riscv/kvm: change kvm_reg_id to uint64_t
Date: Fri,  9 Feb 2024 20:57:47 +1000
Message-ID: <20240209105813.3590056-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The field isn't big enough to hold an uint64_t kvm register and Vector
registers will end up overflowing it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240123161714.160149-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 4dec91740b..902180e8a5 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -145,7 +145,7 @@ typedef struct KVMCPUConfig {
     const char *name;
     const char *description;
     target_ulong offset;
-    int kvm_reg_id;
+    uint64_t kvm_reg_id;
     bool user_set;
     bool supported;
 } KVMCPUConfig;
-- 
2.43.0


