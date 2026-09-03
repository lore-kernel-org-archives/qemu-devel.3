Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19114C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20Ny-0006kL-7d; Thu, 03 Sep 2026 01:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20Nr-0006hi-VG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:13 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20Np-0006TP-Q3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:10 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc1d57602e8so2059750a12.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414788; x=1789019588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zzHd8Swv+yj+u2BkQmCyGqXupXQENpHU2L/YRyfQl20=;
 b=KCujN2wR5P4OQYFEdTOY5sKXckMQTolwpxfLcYDB/v1SnEjNNApM9h7rgIGKfwTT81
 nPo+QlXRaN4iAd6bK786Gt0NJwTTQlcWL26mbQOQ03GSGDiiPV1oFXJcuy5gtS195FNb
 zJhZktuKu3bQhTcbnNjH+3V0JWSfTBW21dSaN7CmJwE+6HN/yNY5dfXAOwJpVSYexRRs
 IM5vdmqvMZSrdgITu+K1Ft6ywHrXDWsWS9fmWqi+mdDOdiUK2xVZ7cHCSBRNogvTEJha
 zxBnsZqK39rLR+8yV0nZMo6vVHPNKswp6hGHeHaeVxdq//tIci4g3im5ziVjlIwG63Yt
 URaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414788; x=1789019588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zzHd8Swv+yj+u2BkQmCyGqXupXQENpHU2L/YRyfQl20=;
 b=a1e6Ra6DknPVigbjFJK6f42AibzAWcZsR9E2Rr4IB/ii83+qt3kWKZVHu3RoaJGNSy
 8CgxUxXmf3RDzp+2U0oPW/r3F+u5majSE6pjuBBSeGG2+xrH3DkBBp7+vgCIyne01a72
 8mr1Ugj/1+gQdYiTSwaTjUtNg+Jxg0nFIbBQIanRdgb4v5HAS5A956zPVZadMYbfnOAL
 QsD6d8RadIsbRmWxw7Bxm2rIIQqdNOO7sU86HZjg4wRY4Ho991RW7iM1FKWW3RmSsBCM
 sqUpETQxH8iW7jQ6TLCdMExo+m7B/rVBfrmDP0ahAGLa+Q6CgPqL6f+lDIN5vQDTBN7h
 YfHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0gtfdots7NiQohY6cO5T0YJ7blk02xFS4ycuz6KwMTNFwMUZxCcn5gh8ZaFdcWRY2WS0GH4w2Ah/5@nongnu.org
X-Gm-Message-State: AFuF++mF9CulNZRmh8T64Mc14Xy0B71unE51mz6lyakeOxoE9bjMyTqq
 yyKte5VrGjKFFfLhNpJEnsKFWAyFxqekjUmtcWaLHBz4ugDvFPKWZsk0
X-Gm-Gg: AYBFou0mtakLDjpNErPEMoDcaKLl2Koib/V6H0s3fiQxxBxbvYesStH8wwgiQKPy73Z
 x50A9/kwD3BgoAqcHxYMHeM41+aEw2WEYOrH5tGBJWjEC7WYg1thztN/Bx2hY4Pl2uiBjKn9BKg
 7Qyg0lg3d4pM4rM7iuWgVhZE7N7eVsmtc6917K9n8FHDoVbjtXY7qksILWUP3uxEzrC7Nfx3o9C
 HEvXCEI5aMWEM14H07QeeFqFchI1EnFrQWWEMtCSzrMVI96zK/RwaeN7TZQu6eZad4DM+Ha1WoP
 IwNVFek6CKqc8fXCSTuDflTBrh91MAFLTXzCXDlaRx+xT59xGUgztqaQCaalLQmCuE6MKvExI3F
 NV9gm9Fzlr1K+bA6Hvtej6XHWE6WewHpG3QbT+DgwDw9hp8+tI2WkCoKa1egNAQ3hEFq10ro0Jd
 BsBPi9Pp29CpLvs9XXjt6m/Y30c1LKKjbpuNUcsoWkgsL911eKRZ+TfCdujPvwClV/Li9jWRKX0
 WplzfBoCs4O6aoLVGNs2Y/pVwvQBamqpTH4eyLAO1F5T1Cxqu8w3Ri7ps3ANHRmTJpfyDZ5e8ky
 W9CTGuDL+NyJeKdBOlXU
X-Received: by 2002:a05:6a20:9146:b0:3b2:a809:1000 with SMTP id
 adf61e73a8af0-3d9ac8425c0mr13410369637.3.1788414788072; 
 Wed, 02 Sep 2026 22:53:08 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:53:07 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 08/16] hw/riscv/atlantis: Remove unused fdt_size
Date: Thu,  3 Sep 2026 15:21:22 +0930
Message-ID: <20260903055131.257903-9-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
References: <20260903055131.257903-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The machine state carries around the FDT size which isn't used by
anything.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h | 2 --
 hw/riscv/tt_atlantis.c         | 9 +++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index c9308aa57017..d0cca3b02424 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -33,8 +33,6 @@ struct TTAtlantisState {
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
     UnimplementedDeviceState uart1;
-
-    int fdt_size;
 };
 
 enum {
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index a2fb83aab78e..7d31294ea1fb 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -367,10 +367,10 @@ static void finalize_fdt(TTAtlantisState *s)
 static void create_fdt(TTAtlantisState *s)
 {
     MachineState *ms = MACHINE(s);
+    int fdt_size = 0;
 
-    ms->fdt = riscv_create_board_device_tree(
-        "Tenstorrent Atlantis RISC-V Machine",
-        "tenstorrent,atlantis", &s->fdt_size);
+    ms->fdt = riscv_create_board_device_tree("Tenstorrent Atlantis RISC-V Machine",
+                                             "tenstorrent,atlantis", &fdt_size);
 
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
 
@@ -386,8 +386,9 @@ static void load_fdt(TTAtlantisState *s)
     MachineState *ms = MACHINE(s);
     char **node_path;
     Error *err = NULL;
+    int fdt_size = 0;
 
-    ms->fdt = load_device_tree(ms->dtb, &s->fdt_size);
+    ms->fdt = load_device_tree(ms->dtb, &fdt_size);
     if (!ms->fdt) {
         error_report("load_device_tree() failed");
         exit(1);
-- 
2.47.3


