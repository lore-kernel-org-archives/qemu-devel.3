Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E35C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGc4-00077t-7x; Wed, 17 Jul 2024 22:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGc2-00070m-0D
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:18 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGc0-0003Ug-A3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:17 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70b42250526so202265b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268674; x=1721873474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tiM16zXYhmuZPz2GQxx4QOHbJ1OS8Hkw+EMarcoHyQ=;
 b=lhFn9+IkWhXqXHIn0Or5okHxtxqV04zcV/QejnubT9F4meKRzz/s30gU6ZcMIgqOha
 pFDzxRat3+snfIGtV+P5sV/39gZkybgWPZPz86jOGtwRUuba2Vnz9oKs4HKD9xXWAMRy
 H97M1kocH7BB6N2AR02gaQwrjJYio+yqgVwzP4rU3N2j5FgKbRlINDgbElr++vD2tYLW
 +O46LmS749SANuq27Er4VeILVlnHghMvxkGVfx0zG3ITlxGhpx15R6TQQuA0RM8894n+
 Wwr8ExMOqbHpMpiOdhVLMig96cppldOcVDEoTNiWN51bz9VfceVGdud8W8nrYBLmBRlH
 IgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268674; x=1721873474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tiM16zXYhmuZPz2GQxx4QOHbJ1OS8Hkw+EMarcoHyQ=;
 b=AZZ/jAGoIP8aVrN+kOQP/7EXEgzNBLsuMimMnOpc+M29FdCu7Cp/boSEilw/0fiFkA
 0ikfpE6EED+AYi1TAbcf1hOlNnsk67m4d0pD4ZCx+9PZ5NQi6rKdUwlCwHH0PTRYY5b0
 oSMtUrm1NnxuLhBsuKPm5w5zqn04Mj7K5iTmut/LibylNNwoi0PliqHm/e2CWKYudUj9
 wllWvrJVK5SaOLDUWy3tfKZqcSSEBJF6JuCV0Wgcz6Cs1X5151cOioEFCRccu+DSPH4E
 yaI9K2ffqxeRKMvqgWibMC55liMezeR9GXPyJADuue+qWZ1j8QaXWdqSmvqY+xalttpE
 DeEg==
X-Gm-Message-State: AOJu0YygKET18Wj5Rnh9gXLDi+iBBBwYE07cHCXYXsfEmjCmxSfOucs5
 tR0ZT2t/wszTbhK8SWItkpMy4fVIJdtNilp7Bn8YiyXS/vDsSutbpq/yxoIl
X-Google-Smtp-Source: AGHT+IEIxiMKA0JHSZ3tD+7R5bNrhtgNAVoXlWPC/nqGTWSqRweVPqtbgg5hLMRaHM1EmFTg9LNe7w==
X-Received: by 2002:a05:6a21:3282:b0:1c3:ce0f:bfb2 with SMTP id
 adf61e73a8af0-1c3fdcf3d55mr4578334637.23.1721268674359; 
 Wed, 17 Jul 2024 19:11:14 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:13 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Kaiwen Xue <kaiwenx@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/30] target/riscv: Add cycle & instret privilege mode
 filtering properties
Date: Thu, 18 Jul 2024 12:09:59 +1000
Message-ID: <20240718021012.2057986-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the properties for ISA extension smcntrpmf. Patches
implementing it will follow.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240711-smcntrpmf_v7-v8-3-b7c38ae7b263@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 target/riscv/cpu.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 120905a254..8b272fb826 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -76,6 +76,7 @@ struct RISCVCPUConfig {
     bool ext_ztso;
     bool ext_smstateen;
     bool ext_sstc;
+    bool ext_smcntrpmf;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 33ef4eb795..4efe7ee3b0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -182,6 +182,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
-- 
2.45.2


