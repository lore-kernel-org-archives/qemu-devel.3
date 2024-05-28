Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5A7C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmqP-0006TW-La; Mon, 27 May 2024 22:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpx-0005d0-Uc
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:45:19 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpw-00042O-59
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:45:17 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-68185f92bfdso251207a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 19:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864314; x=1717469114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6AzoFo8JUHoIoVJzS9JZAaDEbHq/fZUj2l7V7rYL/A=;
 b=QP0cU1jVAzH8PWWfB1EMpFXE90o83NVkfE+7bRRlw551Ql4jYJjAuXLSHWNiF73fHc
 wL8s2DQvHquJxUIBvBhoQS+T4ZDtls3QZAOUfH7stMWo6mrEaRdaWR13yxVMdRmRXtCp
 hizbmx3rbcWAM7fUxMld1kzryx5J6RVKyEer0VZzUOYJ70sCWOM0guI/Xlrsyw8flQoU
 sbf60oKv+0/PF7U+tHd6pSV/5U1RpYqim98K8rqFg3o1rAYjznZnOLZs0UCtcpYGD2f1
 fpFrJ9eK7mdCBmRpIXMcxMUytj10XFNQGpsZ8EepYikDHZJ20yIahDJthR4myIB4p1y4
 r3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864314; x=1717469114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6AzoFo8JUHoIoVJzS9JZAaDEbHq/fZUj2l7V7rYL/A=;
 b=ImznSdoGpdVFPA6MmWTjUHGTBzAHyozF+Ue4VXbzHd46E5mfRtiIydFsXO09onay1F
 2iCqHUW2P9gA8ndIe30DEyZQlzHcY6hDOI810sylOkRP9M0pR8FY0BOB9a/NtxrlsnSS
 uhBc0N0Lasnli1eyDPOnASlDJY/9N4nV6R5PUB1xiQGSVZYr1CzZyFKAQNl63fUsnJSD
 fQmzXbzNqTtHU8cZ2oDRLANZVkuapay+6Ca26uIjhc2xz4kD3hZUwaxyQA6hsE2xnXY9
 NG6jr9fOTQLL4suLS5BCZfJAPBaYoGaAfrmLoDQ2qdsSMPdwwy15F35B70gMdY3FKRmX
 ozyA==
X-Gm-Message-State: AOJu0YwUvMD4AijOM1Ks1WJQdjQLYHBOVRSbf9aANbwtTSE9szH94yvX
 N5N8oVHuMB4kaYwaiCQGWYamoU3LeJqyP+PW45vrugx2TShvwtTUMEOH8Q==
X-Google-Smtp-Source: AGHT+IEMjkSkq7OD8Ut5c2F3mGQxtpTmFwGgmVHfToyBFud2Q9HNqb/25Z1NWCIpEsAYVRnHWwf49w==
X-Received: by 2002:a05:6a20:3d8a:b0:1a7:7ac1:a3ba with SMTP id
 adf61e73a8af0-1b212e2c397mr11877294637.53.1716864314503; 
 Mon, 27 May 2024 19:45:14 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:45:14 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 23/28] target/riscv: Remove experimental prefix from "B"
 extension
Date: Tue, 28 May 2024 12:43:23 +1000
Message-ID: <20240528024328.246965-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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


