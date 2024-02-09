Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D89C4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 10:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOam-0008Iq-1R; Fri, 09 Feb 2024 05:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOak-0008IS-9Z
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:46 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOah-0000CD-QS
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:46 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e0939748ecso173707b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476322; x=1708081122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63FC0NlB1Cs6e1ygz1zwNXFgal+1xcgDDbAJFdc8M8Y=;
 b=MjaCKkCD5M28aS2sqJtvGb/u6BqQBXSIzUcOTDwhH3JDRW34lvFbpEazXPL9PJ9oEs
 x9KVeE4VZEqyljL9fXwxarZM2KDM1JdcUhmvS9zG1HoIrnnF9NDcaYsAe/y60DjivxGC
 jyn365T/EFxDgZb4j+RYB9xvVRheUh0+obUGyMIlgW3SUUmIOC9LvtKHRK2pqUpIZvek
 4vmdUe/DAuJ6oXgv3qDsWbUEZGCW/P5ksxIiYcrgsjgKGph3WaHxhXGiQwb1p86yXx2s
 fybRMzIOXc/fraMShwpOr58V0KCzpc0H/aYVvGVhDwlpSenc3xsb2DhetE6d/UMBf4oq
 6C7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476322; x=1708081122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=63FC0NlB1Cs6e1ygz1zwNXFgal+1xcgDDbAJFdc8M8Y=;
 b=WDXwOuhQXFVsJo6CPNmyQITCKb61mr8nlBkxDSwoNE2hA3ZeVIzUBRJ0BdrO3A84Cr
 hyel2KMl4FOj0j/SLeF/jNjKC8GrFna4/pXU727QGrdxAwMXjMFvJkJjfhG7asyUdIbQ
 Dzdriqo/cHYQsX+PcdYmWdZIXo94WKEjCDXiV6QjSK910uduzPGbt7la8i6O/InDDmEl
 jeIc8CJrj45Elx42+BsFqa8TIZuC/BAduzgn1zGRsLYnNppCKrppfMrjxVB9GLrP3CCZ
 7dTD1FROgOLOJJTWDxE5jsFtcu9paKgBUot4VJG2owicuT/IOJsPsNlLN/C1vgCuBJ6z
 8QzQ==
X-Gm-Message-State: AOJu0YxYB1vkndZP6wF5l1Lxle9QzzdUDUndIIZ3GJQ/1NwHH5c+FLby
 KoncBwLS8dqB7qo1m2d0zv4nZHAYhXZyM3LZ3Ain0N65ZS0t/9EqRokHOvWoi6BFkw==
X-Google-Smtp-Source: AGHT+IFDBE4alfzkYUkbmr2NREXEEM3F+rmoaOzIkTo6BKV4HHlU7/ghVpjFBjtDo6BBNPn3TDnGRQ==
X-Received: by 2002:a05:6a00:2351:b0:6de:40e:65a3 with SMTP id
 j17-20020a056a00235100b006de040e65a3mr1361042pfj.16.1707476322134; 
 Fri, 09 Feb 2024 02:58:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXSwT1O7ZnJUGKviznPECy3OcoyeYi7FidftD5GqLhxZ6LGcs80j4u+XDlGR3qF1MM0CaHOA1GRt6PiNLvX+FkWOutyjtWpZg+oSlKvhvL1s6Xz7bqa2C7fAfuFAxve674VNOVTmmJYsRtVYSJHVE/G1WG9IugCCp8D+X1GIUc1fu8=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:58:41 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PULL 05/61] target/riscv: make riscv_cpu_is_vendor() public
Date: Fri,  9 Feb 2024 20:57:17 +1000
Message-ID: <20240209105813.3590056-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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

We'll use this function in target/riscv/cpu.c to implement setters that
won't allow vendor CPU options to be changed.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
Message-ID: <20240105230546.265053-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         | 1 +
 target/riscv/cpu.c         | 5 +++++
 target/riscv/tcg/tcg-cpu.c | 5 -----
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 52648e3af0..bd103d2be3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -770,6 +770,7 @@ enum riscv_pmu_event_idx {
 void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
 void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext);
+bool riscv_cpu_is_vendor(Object *cpu_obj);
 
 typedef struct RISCVCPUMultiExtConfig {
     const char *name;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8a2fd7d031..1718a213c2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -190,6 +190,11 @@ void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en)
     *ext_enabled = en;
 }
 
+bool riscv_cpu_is_vendor(Object *cpu_obj)
+{
+    return object_dynamic_cast(cpu_obj, TYPE_RISCV_VENDOR_CPU) != NULL;
+}
+
 const char * const riscv_int_regnames[] = {
     "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
     "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index bf8e72a0e8..67aa2d1c37 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -950,11 +950,6 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
 }
 
-static bool riscv_cpu_is_vendor(Object *cpu_obj)
-{
-    return object_dynamic_cast(cpu_obj, TYPE_RISCV_VENDOR_CPU) != NULL;
-}
-
 /*
  * We'll get here via the following path:
  *
-- 
2.43.0


