Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFA1E6894E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MGP-0007UV-88; Wed, 30 Oct 2024 23:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGL-0007NH-N1
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:21 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGK-0003x3-3h
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:21 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20c767a9c50so5133715ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346858; x=1730951658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4KutYTrZgHZTpGumE02ekFmWFxsAFox/FtQkNUUqSo=;
 b=luZUrEFz5Y7sgjVc996KxXwgEdp0QIUm8yNyShpkaWrK0AGpszHcnw9AmA7v137r4w
 9njRmDIDqzfQvfJ4bEAqJP1x13RjpktgKal4s13T3v1CoHTAt+LJ9tlfCd3mA1zEqYf/
 65k8YfLwSvsvcE9TwZn9H4pd9jDh7aKO2Ka0lMooF23vapMKaug58J7v0Q5Q4seciHj9
 Fv4mJckksAlM1SYRAiEAOlouxY6MakZKH1b7K8NymaiwLuBHGh9NovVARztJ1cCg8Kj2
 NWhhOeueMWdMS/Ak4L+hum4xzD3Rf1FAqQqurfrKlighOWo8xrjll0d7EVdwKMi/SP8u
 QRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346858; x=1730951658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l4KutYTrZgHZTpGumE02ekFmWFxsAFox/FtQkNUUqSo=;
 b=cVVm7hiGVGbObbqyhI+ojn8c8Vv+L+JVDfU8N66eau1GDoShF3SnsIT5UtPRholWmE
 46KY0OwHD+rhRggZOYecXCuHJEsyj6lsh5aS+jthPr2lT9I6AHlFBq+OVeoc3Cy9nAok
 WWRxjOehL9Y8A6kiyPXf5VDLMz09H9k2DtCJIX4o5rIoTk4VrC3HIsPOP99e7/yWdkq9
 3cnKoNtNhJf3rPPkEnZEmlBXyqpM7vDGXFJSbDGPHKd/miEaRKb0Jn+ezHaW6BVufXAi
 oyVlg7xYUywu09mW1M1MePUrTai1SMSjjgiqShKPyyEEuDDGq/5uqhFakAhtaxwHoEIo
 RrIw==
X-Gm-Message-State: AOJu0YwuUa+80cM4fm8IKA7pSz4qr22XBNi1tiXdc1sw7tmq7oevlbOh
 AsDeCSk7vxRhfaiRwhhgASDkHTeIsMks8yEj+0FbAmPKG7iphsrTqLvP7qgX
X-Google-Smtp-Source: AGHT+IHQTzpOqb1aT5bxoqqYuw6aTDErktSh5VkVGkkeCSDUWlmdoSCTh8KYmGcLCA+pb0uMItMGgQ==
X-Received: by 2002:a17:903:2b04:b0:20c:a175:1942 with SMTP id
 d9443c01a7336-210c6c032cfmr219753205ad.24.1730346858158; 
 Wed, 30 Oct 2024 20:54:18 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:54:17 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Deepak Gupta <debug@rivosinc.com>,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/50] target/riscv: Add zicfilp extension
Date: Thu, 31 Oct 2024 13:52:45 +1000
Message-ID: <20241031035319.731906-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Deepak Gupta <debug@rivosinc.com>

zicfilp [1] riscv cpu extension enables forward control flow integrity.
If enabled, all indirect calls must land on a landing pad instruction.

This patch sets up space for zicfilp extension in cpuconfig. zicfilp
is dependend on zicsr.

[1] - https://github.com/riscv/riscv-cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241008225010.1861630-3-debug@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/cpu.c         | 1 +
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 355afedfd3..fe7ad85b66 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -67,6 +67,7 @@ struct RISCVCPUConfig {
     bool ext_zicbom;
     bool ext_zicbop;
     bool ext_zicboz;
+    bool ext_zicfilp;
     bool ext_zicond;
     bool ext_zihintntl;
     bool ext_zihintpause;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f0e32c4e6e..6fa2689f35 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -106,6 +106,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index dea8ab7a43..963c1c604a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -623,6 +623,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->pmu_avail_ctrs = 0;
     }
 
+    if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {
+        error_setg(errp, "zicfilp extension requires zicsr extension");
+        return;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.47.0


