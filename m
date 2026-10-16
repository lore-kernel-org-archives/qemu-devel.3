Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCA1CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWOv-0003tH-Ue; Thu, 15 Oct 2026 21:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMm-0000uW-1t
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMk-0004MD-CN
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:11 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2e946155442so19972275ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112649; x=1792717449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uqp4I/rJ2Ya5fffBQw8ThCsmnhz1VM80eBLNZU/wOTU=;
 b=LuU18cz+DfRESVVG/jfQ8dBiUERJzrP+ZjdUbesCuvKxTtu/PdmaDaeXtsJp4BkXCK
 FTCT7v+IMQokR9vfETnmIwy90khAt1jrxg3rYs8mrOrlcYpZFZMqBK2uoay4+Tu/kDsk
 HJMZ+vB5dP8/GoBA+xri03RDYLY46AT6kGNkRWcWCDF7dHXoXmgG0/pYneTpxodD4/g+
 o9A/6HsKlUeUJ5Hb1bfWgBRY4hkFDn7XRwlTxmn+U4Sg5BZ3B9P7mXHQBlY8NNHChveg
 ep1w/9Cgag3iKHOConjIIUFbwgF5uIHaDV4UDZhmXIyyiPsRAU6px+5RRILFcqe978rz
 50Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112649; x=1792717449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uqp4I/rJ2Ya5fffBQw8ThCsmnhz1VM80eBLNZU/wOTU=;
 b=02IgWMFzRA8/Ha4nHkucI21artUECW8Si4Xub1DUnOl5jguMD7y9rngnAT3ANHFE6Y
 1NUKzUaQ3NrReO8OP2CS6OzvI5EuB8VGzdvVdiinRVtlpxZDZQw3Tnw1fRHyZlLolQhj
 sSS4lVPOerv4zHD1XBesN1k2zfZscg3DKPVnyLQuPjuKREkTxM1d+NPyWEysj7mNXMfo
 JVd4/jaH75PPaiRdy6Ydc1k4mouKb/eNiOKKEUBLQmUCuOX1jYZrbETRsI3xbGYUr8e+
 vSD3YHYEMV0GuBmEhesDxkD1o9TIKLTfBiX+HmwSKwA3Ns6yHS25CVL2w49h7VHGMPl3
 M5Kw==
X-Gm-Message-State: AFq9FYIguavlPcNP1ftsbHR3kW5z3EsZwXrV8Z5FkTv7buf/KanygWTU
 rJZFhSfHIazPnoW6DqwV7ZOawppcNSN2jkkjpabtxrGV7uu4NBBYyW1R+CKorA==
X-Gm-Gg: AYBFou1eqh9BbNzNRZ/9bi8RWL8B9I/KM4IW4lv1g0RI1Tv7kcRDCQFDByoP0VFpBEq
 1zAnG0NK74ocsrkUyvKDYuIo1ZdBqmYedNpnw2FnglJbf19pvHeeiuOOVYf3gaXB7KKESTfjhvh
 JLWHn+2tbfhrAcztk4UuhD0Xj/700eTHeCw0QDAbkdhJ0g8KBq2qCvGe2FilJxNrCsimGAS9Uw5
 giG60ez8xfGjiXwDeWVA6vvV5aSRKHchgx5y+DVf5sX2rBtmQ/OGi8LarT/BDnv4yNw0uEVqWgK
 5/J6SwAttapHuq7TJaNIvX50ArPgIB4pA6BlDcoI92o6Q4voXrItoR+wKxBnTdGgqgWXTugUiqE
 PUCuQo5CJCShc5EPgbkTVG6y/u1eUhyfhLJ+lVyMjmPlBAjyw4U1yIZY6NvTB4q6mOokksAfP9j
 cqcnOV5ZspCL8FieIymOEOK+24ZzjGftTAYV05yC+90SIVo6rrN8MhPiFuMxaE92tB8viAasPSI
 d4QX2SZX3QBwUDs
X-Received: by 2002:a17:902:e94c:b0:2e5:db61:e5d4 with SMTP id
 d9443c01a7336-2e842e07fa7mr205003455ad.62.1792112649013; 
 Thu, 15 Oct 2026 18:04:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:04:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL v2 29/50] target/riscv: Add cfg property for SiFive int8 matmul
 extensions
Date: Fri, 16 Oct 2026 11:02:16 +1000
Message-ID: <20261016010237.1102834-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Max Chou <max.chou@sifive.com>

Add the CPU config properties for SiFive's custom int8 matrix
multiply vector extensions:

- Xsfvqmaccdod: 2x8x2 int8 matrix-multiply-accumulate operations
- Xsfvqmaccqoq: 4x8x4 int8 matrix-multiply-accumulate operations

All instructions of these extensions require the Zve32x extension
to be present whenever either extension is enabled. Validate this
in riscv_cpu_validate_vendor_ext() alongside the existing vector
extension validation in riscv_cpu_validate_set_extensions().

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260927082534.3228237-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg_fields.h.inc |  2 ++
 target/riscv/cpu.c                |  2 ++
 target/riscv/tcg/tcg-cpu.c        | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 24f3606f94..bcff8f55f1 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -160,6 +160,8 @@ BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
 BOOL_FIELD(ext_xmipslsp)
 BOOL_FIELD(ext_xlrbr)
+BOOL_FIELD(ext_xsfvqmaccdod)
+BOOL_FIELD(ext_xsfvqmaccqoq)
 
 BOOL_FIELD(big_endian)
 BOOL_FIELD(mmu)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c0837c6c55..a175817e22 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -301,6 +301,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
+    ISA_EXT_DATA_ENTRY(xsfvqmaccdod, PRIV_VERSION_1_13_0, ext_xsfvqmaccdod),
+    ISA_EXT_DATA_ENTRY(xsfvqmaccqoq, PRIV_VERSION_1_13_0, ext_xsfvqmaccqoq),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index edc530525f..e07ca95e49 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -436,6 +436,16 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
     }
 }
 
+static void riscv_cpu_validate_vendor_ext(RISCVCPU *cpu, Error **errp)
+{
+    if ((cpu->cfg.ext_xsfvqmaccdod || cpu->cfg.ext_xsfvqmaccqoq) &&
+        !cpu->cfg.ext_zve32x) {
+        error_setg(errp, "Xsfvqmaccdod/Xsfvqmaccqoq extensions require "
+                         "Zve32x extension");
+        return;
+    }
+}
+
 static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 {
     CPURISCVState *env = &cpu->env;
@@ -813,6 +823,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    riscv_cpu_validate_vendor_ext(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     if (mcc->def->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
         error_setg(errp, "svukte is not supported for RV32");
         return;
-- 
2.55.0


