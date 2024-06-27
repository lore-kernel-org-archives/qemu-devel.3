Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D90C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlwY-0004yi-QP; Thu, 27 Jun 2024 06:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwM-0004xV-35
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwK-0001Zl-Ae
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:17 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-706a1711ee5so1721919b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482475; x=1720087275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Zbww0x25XgOxnxpJhSt8HZ1tEpLVotQQz6WQupL3AI=;
 b=RdIAawFO6kq7MxyieqXywl7+cx0znbmZLI0jBYnXsxZsFAu9nE7P8gH+5XKC3CbxU9
 rQhGvpUOE+TYUR9krtfYwUuhUoWXkAhbLwP5oETMpTKffR65VUbF2srGzrvDMLtiSz6K
 jb/YH+VqfDVCTXvxTmd9J7BZeLeGM43A6qwDCVgYBHoYMVQET2ygirznhC16P5WHjA/T
 E3fdL7iIwwXwpBQ7Xfxno7qQDm0WF9xcv+07LeDKQYgLsgNT5gs/3tgpRHwOpkrpeMag
 Helapg5tIhDGipY4bIojPBOGaUYhDHD+s91tRkEFBFQDhv/LtBiGo5gFEsSnoMBzCaiL
 MR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482475; x=1720087275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Zbww0x25XgOxnxpJhSt8HZ1tEpLVotQQz6WQupL3AI=;
 b=H/WyJO62hjwXhYlPY6OT/aXgUFe17UzyYvZPIK6yJIQFBjYerDXjcE4xNOCpgHYZ6J
 1lZan3ZZZH1eBjgirThm3F3xjrb6HiDo3zugmnApMRAxBiMElCDBszmjROoX8yLgpkNl
 WmaLlCcN0XkHfB638Z3Gt/wPhGwRDXD9Hcx+axInTB9itZujqeHUiThgH9mp1n56zqk5
 wBp4ZHwZuuz8tGzhNX1T+3g4RDLGwxFFBR28ZVlxDHEYa0FncrwiqVlRsd+TIbDcmhiQ
 V6Dn6omCQjFFE/z0B5hYBDtWbYCB40U1zVOi5NvMv0bJwAbPuqSqhN9sMjt94eR8wAQ+
 4ulA==
X-Gm-Message-State: AOJu0YxZ4vtuNItx1kegpx9w/i70JEYNDelB21XSupYLwU73DO3EMdD5
 Ielz8wvDFVQMBEw63HzD2GN/SS9JE1oaf2MKXZPvBisbwAPuMGGb8VxerV5l
X-Google-Smtp-Source: AGHT+IHUyhy6H2RVGOrywT3w4EcatuiZEe2cmmSKkHQYEt9HMgrwHapH3AUJXhMhq3gvgLhl8dA7iA==
X-Received: by 2002:a05:6a00:929d:b0:706:67c9:16d0 with SMTP id
 d2e1a72fcca58-706746f0a52mr14954844b3a.26.1719482474629; 
 Thu, 27 Jun 2024 03:01:14 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:14 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/32] target/riscv: zvbb implies zvkb
Date: Thu, 27 Jun 2024 20:00:24 +1000
Message-ID: <20240627100053.150937-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
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

From: Jerry Zhang Jian <jerry.zhangjian@sifive.com>

According to RISC-V crypto spec, Zvkb extension is a
subset of the Zvbb extension [1].

1: https://github.com/riscv/riscv-crypto/blob/1769c2609bf4535632e0c0fd715778f212bb272e/doc/vector/riscv-crypto-vector-zvkb.adoc?plain=1#L10

Signed-off-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240528130349.20193-1-jerry.zhangjian@sifive.com>
[ Changes by AF:
 - Tidy up commit message
 - Rebase
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 683f604d9f..fa8a17cc60 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -667,6 +667,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
     }
 
+    if (cpu->cfg.ext_zvbb) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkb), true);
+    }
+
     if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkb || cpu->cfg.ext_zvkg ||
          cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksed ||
          cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32x) {
-- 
2.45.2


