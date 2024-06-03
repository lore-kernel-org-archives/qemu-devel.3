Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0BAC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5hl-0007aD-RR; Mon, 03 Jun 2024 07:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hf-0007LB-Jb
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:18:15 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hd-0006Vs-Cn
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:18:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f44b42d1caso31643175ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413490; x=1718018290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6AzoFo8JUHoIoVJzS9JZAaDEbHq/fZUj2l7V7rYL/A=;
 b=jzS1loQ4JxEszbqBmTCY3OU9rmtWKcDO88YqnDJ8ASEluDOPxuwXLsJL8RYu1ZdfnQ
 lF/C74Eog1pxTBXj/+KqOmdnF7YOx9kd7DuTeWQwKY6f5rkaEWvuDmybW8yWbmtNALIP
 gN1WlF8pZorZRrOJ7jBlJ7CNuKJSercX4/DIlvrxPy/8bstq7RV+VLM4u/S49KkTUSXQ
 JP/s5+Hv60mCkAzaRH+MDqWdHg1X6DcQypaDiTIegolOYOkJljuX3a/TgacZBbZC+HlZ
 UQpAv+JG4z/vPm5lWGv3pLP0LGWPZQ6J3P/UxszSYsp7nqj3UHUIrG8dOXzFhLTV58qe
 7IRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413490; x=1718018290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6AzoFo8JUHoIoVJzS9JZAaDEbHq/fZUj2l7V7rYL/A=;
 b=TaKXrkYs/BL71JYmx2VoVNsUyPof+YzutSUG8lhzx9A+4dpU3Tyn+h8Xe3u77lystB
 G82LDubNN5lJuZGYoakGEc9IjeplWLbnvBjxjz76bX3MWgfAuXrm6iHvoCGDSNM49cr/
 XefYZ6gBRlGkBatq9veRUEIgOdRU5Ru0p7M7w8t99Os0J0fDiyllONHO9cZI+Qt5J/3Q
 hZCprjya8waVbaEzBNk+EuUC3o77tYyoeRaxh2xVGouNscpxYvm3BEtaIkiFEr4q+b+7
 pSQXCyo+KIgQCz252aKnYZTg0nv4Cj4EG3qEfqesCuN2H8yuqrFQrSF5mhloPdIQp9Rz
 AGqQ==
X-Gm-Message-State: AOJu0YwGqWV1nvJlF6eGCBA5xa28/Kda4n2RF/zU8lO3a7Cuv+UMewTA
 daqDOLWX5CcBGACi9Vm4277asqm3B7x1Xk11G6K/IzSBCKa8vtszbTC9/A==
X-Google-Smtp-Source: AGHT+IELaqT5zsTCVytn5m1fuR1ae7RyOQ50dgeEuwEobS4zVRBZCz8GOun5O9EVZd/EJLC1jA2Lkg==
X-Received: by 2002:a17:902:cec7:b0:1f2:eff9:cd4 with SMTP id
 d9443c01a7336-1f63696304dmr77153385ad.0.1717413490306; 
 Mon, 03 Jun 2024 04:18:10 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:18:08 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL v2 23/27] target/riscv: Remove experimental prefix from "B"
 extension
Date: Mon,  3 Jun 2024 21:16:39 +1000
Message-ID: <20240603111643.258712-24-alistair.francis@wdc.com>
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

From: Rob Bradford <rbradford@rivosinc.com>

This extension has now been ratified:
https://jira.riscv.org/browse/RVS-2006 so the "x-" prefix can be
removed.

Since this is now a ratified extension add it to the list of extensions
included in the "max" CPU variant.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20240514110217.22516-1-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 2 +-
 target/riscv/tcg/tcg-cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2946ac298a..cee6fc4a9a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1400,7 +1400,7 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
     MISA_EXT_INFO(RVV, "v", "Vector operations"),
     MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
-    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
+    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
 };
 
 static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f59b5d7f2d..683f604d9f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1301,7 +1301,7 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     const RISCVCPUMultiExtConfig *prop;
 
     /* Enable RVG, RVJ and RVV that are disabled by default */
-    riscv_cpu_set_misa_ext(env, env->misa_ext | RVG | RVJ | RVV);
+    riscv_cpu_set_misa_ext(env, env->misa_ext | RVB | RVG | RVJ | RVV);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
         isa_ext_update_enabled(cpu, prop->offset, true);
-- 
2.45.1


