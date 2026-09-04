Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FFBC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MNH-0002m3-0P; Fri, 04 Sep 2026 01:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNF-0002ZI-Bm
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:01 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MND-0001Uk-HW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:01 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cc2276e6daeso580274a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499318; x=1789104118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2U5NwZYisIZpSvurMExseWRhqQFF+Wz/Mz8+LQ84uh0=;
 b=F54jsEVdLmqyc8ic+yqXM4ZFFzenOopVP0GJR5r+qlgIPu67OiNl8R6d+SsEGUsdO9
 51s0Vpw/lhLeai9jutEbgtmrYZDxeTJ/eSh/GF878Jh74DnMiWaAdPiYh0tpUh0eRhNV
 zprT3NZhy2yuEMtbJbR9ETY9w/VEEa6XTamGjt/QoVhDxB1qt6KBn41cUzBPXeTTqGkt
 NLfyqU6FP1OdEvdd/9MYXNiIDAl/+aVdukgzEr62F2ZHGLvQcZqH13fuqhwWtRtXKGn6
 WTFNO7vPTNaYpTz7ZEkJRZHWHK37+B03GgZRS6AIFYQh1elTZ8tTnL6Izq/LFforK5/1
 LnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499318; x=1789104118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2U5NwZYisIZpSvurMExseWRhqQFF+Wz/Mz8+LQ84uh0=;
 b=a41iMCvwD67yi6Mg/GGkf3opv5dQWP4APMww7fhiMpQEKIViXDLvFNUm4E4pgXHVEu
 E1ufP6ZMpf+9EdBK5U7/i2xdebzmH/T8QMaqjAflAw6tyVwqH2zxSNRH7oOnvet60TtQ
 6CysOSmuDU7hwaXjqIM2Pv4gUEAbAXaVs01wyTnOTccgbMIsqZNTDYykDoaYXwCyEZJy
 DDN2iiTsrMWWkkPuCec1aosBKDOLd1TNX5WHk+pQRIUfIuoTLJBBb45DAfFOLjxs9KeP
 lsyGfJ218bnTeLZNkkUOb751BhX51BQEpXwMqa2WAqe6lI4iZSimv9/8aSqnmHZAo3Nz
 dhqQ==
X-Gm-Message-State: AFuF++lHPI3X1VSTUk2fJsTpAD6FSh03TiQ+bCIiTVhegEjjq/DYVpLI
 bnqCFdfNk6UKIimrEQgf+Fw1IniIL2iz/UdhaipF740NHPbG+WtbIPlN53pNNQ==
X-Gm-Gg: AYBFou3XvVN9Fy+GaE/Kze5N2m1559ivqpmW91CJKyf64hihsaiTdkca6kJ2pteGg5i
 WButwZmHWVYsmI6MzHU6ijqj6W7MXus3FgZniJumi9uSchCExdkcg2fooZMwlg5h3B/Oe6r3Y8J
 jZFqJpEqNdb/F4W9atb5G7zgL958I6QFZ4bVOwygG/WuCXnV9iXqL9ZTlFMngO7Y47AuhMLSko9
 VRSGDSFWz/BI7kpqYAE2ncjiuU2y58B4xaelVovjcRGXdoLME316bo4cM3m9cd/6R50o5zt3Faq
 El21bQjuJtx9c+LlDgesG+BAXen13ZsNEFdLRuMaPgXwcmnvZSm30BBf77EH9rGE2qVsaVZsPfl
 c3Yc6x6abfCX4rjFvk5jp/X0WBwgCPMGdX1gdGU1rBXmp2b2PLstqpGKzK9vkv2UIp3lxwpKPau
 aFGB/VcS54LUQo5WqR5DR7GAdquJZZWd7Mge+Cvm0nL3+PVSoeu2juhyLJlJSc44xLnOiJjYlqW
 zj1Kb47rzeVTWVuoFP6vhbeEcYEpg==
X-Received: by 2002:a05:6a21:7314:b0:3c3:f371:1ea9 with SMTP id
 adf61e73a8af0-3da39ee3817mr5432508637.10.1788499318046; 
 Thu, 03 Sep 2026 22:21:58 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 39/47] hw/riscv/atlantis: Remove unused fdt_size
Date: Fri,  4 Sep 2026 15:19:35 +1000
Message-ID: <20260904051943.799041-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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

From: Joel Stanley <joel@jms.id.au>

The machine state carries around the FDT size which isn't used by
anything.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260903055131.257903-9-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/tt_atlantis.h | 2 --
 hw/riscv/tt_atlantis.c         | 9 +++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index c9308aa570..d0cca3b024 100644
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
index 6e1e50aaf6..c682bb6848 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -366,10 +366,10 @@ static void finalize_fdt(TTAtlantisState *s)
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
 
@@ -385,8 +385,9 @@ static void load_fdt(TTAtlantisState *s)
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
2.55.0


