Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D880DC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5gx-00047Q-HK; Mon, 03 Jun 2024 07:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gh-0003Ne-Am
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gf-0006Bh-8p
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f48b825d8cso33171935ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413429; x=1718018229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgusDoAaCqNHbDW44NpiNn7tTNG1jLHTtJSGtoAQOwc=;
 b=f/IWfqRxnXgD0jr8KwKK9Mh7d18b6Tw8qC3EkPIPcOZMN2GdMMNYnm2cP4N3CFCOBs
 xvaFbncuRwsaD3qpMqxOIkJBdHrp+DbpG1B/5Nox/HyLYWXNrSZkomSnhW0F2CmqwbPm
 2y+d3SLRgnsW1Emq4OiDPfqSA2uZ5d/F7ODfKdIGLwQvZhSa4VdA+DALTp2bsZMtjLFk
 KahGXcDbbScmYIDN86aYHFVD8zh3YarKdNo5p4rM6weBjTjPsyWjHm3VpL/n2R8O8rUc
 LevvuQznQ1H/OaxJ0kQdX/m2nRiN5MGs+7GHxzoCpHKFeknxnepZf7eeI7YpNWJ5XLiG
 rt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413429; x=1718018229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgusDoAaCqNHbDW44NpiNn7tTNG1jLHTtJSGtoAQOwc=;
 b=p7EF5m0ni3fso0r+jM4MBLgYaY4GaoSXLH3yLOL9mQ95VEP8u96mevD+d+FAkSS61X
 fFtya1hC2Wjx86Rw+wRz9EkLNA0iHNTCWnY8obXCfsv/PWEQ0YXwaxOi8AP0DHy5OLfd
 miY0/qbQ0WCAgoGllOUdwOM71xyPm3eVHSv7HU7MRMzP0NiM3Rl4r4thBH0hRz7Dsggv
 /a+jbx3uy++iaPOGIsBqQZ7Dy55v1zlF9Wa0srBCH4s4hcY0MocMPWnpiGOgxr12woSD
 2N4qJiaiuy7HmftiufN4JLgYDAqa0Oi/icaLoi26V5i7u/ho+Xl0DbPrKvSD12e/gCf/
 QqxA==
X-Gm-Message-State: AOJu0Yy7bYtmQwlF9iSCNw1p8TfvDCqlIHFH/KJ162zO55q5btbAjUvR
 fGqxbzEdHfsUUkBBegE3K7xIlypgXMTSPX4kLGJVEio//4q3VZmg0QkL1Q==
X-Google-Smtp-Source: AGHT+IFZiTyaDK6sowgFDA115w8SNTXC985Mdlh0dZVYI0kejOwV8icKAUnhP311MIe0dy3RC/5XYA==
X-Received: by 2002:a17:903:2345:b0:1f6:78d5:f42f with SMTP id
 d9443c01a7336-1f678d5f6bemr33697655ad.52.1717413429001; 
 Mon, 03 Jun 2024 04:17:09 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:08 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Cheng Yang <yangcheng.work@foxmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 05/27] hw/riscv/boot.c: Support 64-bit address for initrd
Date: Mon,  3 Jun 2024 21:16:21 +1000
Message-ID: <20240603111643.258712-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Cheng Yang <yangcheng.work@foxmail.com>

Use qemu_fdt_setprop_u64() instead of qemu_fdt_setprop_cell()
to set the address of initrd in FDT to support 64-bit address.

Signed-off-by: Cheng Yang <yangcheng.work@foxmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <tencent_A4482251DD0890F312758FA6B33F60815609@qq.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 09878e722c..47281ca853 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -209,8 +209,8 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
     /* Some RISC-V machines (e.g. opentitan) don't have a fdt. */
     if (fdt) {
         end = start + size;
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start", start);
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end", end);
+        qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-start", start);
+        qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-end", end);
     }
 }
 
-- 
2.45.1


