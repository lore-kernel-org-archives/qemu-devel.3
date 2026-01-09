Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3158DD232EB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6yo-0002gN-LP; Fri, 09 Jan 2026 02:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ve6yg-0002PG-Qu
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:32:11 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ve6ye-0008Hk-DB
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:32:09 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so2724837b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767943927; x=1768548727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vyb0Kc//2+NTy6ceQi2JB94//CAYGf9ike4wuoluXYc=;
 b=l8HEWnIsCFIEGhJKX51wI+Vwdlp8H+TxK0c2ybZlvXGXWvEJvN0In5iE1ti0uB+94K
 h5kqEpqztZvEwUiW2o/UF911fH4NmChsiscuHkvIp4QuFUSeiHt47rUelTTwA7Z4cV5d
 Vj2TqDMqCAJ4zKEQOFJAMPRKH4NTR2TYVmhSt9LoHGjjv87KBxtcHWmkOYqOjRG7gtnc
 bnaIj7nPr7dZ0OoEvtkuuVyIcaqi8TxSQxVBTS3M/xi12yj56f8V4R0naO+9OUAP27fW
 a3I4Pa3934TmYKpOQNfFh9yWmZT6LYome1c/WJ24c59QR5Jps0yWStY+TwiHRPjCWbcT
 1dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767943927; x=1768548727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vyb0Kc//2+NTy6ceQi2JB94//CAYGf9ike4wuoluXYc=;
 b=CkM4v6D2HAUypWqUacoQpEoP5bK98eNaiqeKuVJCKGZ4pXIO7h3Y1GmNKRhkcG+ImL
 LAiFy+w/cgSjFpZytY6O+x5MTvanxmLMiOPqK9FqSTzFqi8mvspNBUY8g166Hi3te7Vf
 YbNKTAzp+MCi3o5lk45p42rsEh6xMl8UBc02y9w6Gn7eNUMVjfkZG5BRk3TX+r3J3enT
 rug1TAeWpmRO4fokd9gTDXGVxg011RjEFp+VrYKMLn6Mduht8L5xgSBB1mzf0xevxS0D
 UWOR6/xVXg6V6YO0DRHudsf6mDLZjM0K+sGq2+9Kov19uu1Zr2f4RueX96xbBbVNkKQl
 7SJw==
X-Gm-Message-State: AOJu0YybJCB/7xJBrI/WXvNUL3VNjVekeuDZJxm+l6E6gqDjM2p02f+U
 KUirXXWUsWLx/D5fNotaQnlqzHEs2x1IFbS/hm4j3ZEu6wGV8DYlp6kGQ5SlW9HzdvfYsBCeqb6
 vWBQWb2c97VOp9kNogvhUiqVblyWvCKc+HMsEA+TuDc3jYx8aLvPBML1IZgsugjNyhrOSPKdcwa
 yO0xm0sZO+HXXMYQfZ6vMGMzjF+Z/RgK6ZMogRtuo=
X-Gm-Gg: AY/fxX7PCCN/bhywVaTF5WfFfldCUhhCmCEPAZfxRxezPs7Mgf+2jrAiVJsH+WDRPTD
 Zvdz7LEcAvgneNEtH0iwZFIbTFLlDtlN8bCWFkiVGaltBQ5ftfoO7eK+MaQpa8dTzUo1WtIAcg5
 jkWTU4/xZOvMMz75zpc9xY+yFTEX2bw9k3rdYSK5PDEZAB5VTYJTHUab/rSIGrBVF+k3LF37Peg
 hLxyPjvA+h5Z7DJ7Z9M3dF8atG+RTB3jvk+fWGstzAEhiohQpV8ZCjsH88mC6zRJ1zwiaRu2MXf
 +Uu8eWetOZ2QKkmhgPCg5TXwIUOB0EtONgFPWA5R8MAOnSu5+/Mp4//h5M3L3eeYKHM68RLDx3h
 4RSVQdD2Qkx101s4bRTwU83IcvNCXoN8tHdxRqnWLTNmXDfsRdzPLfdHBmpy9RSChBpvHKLZDoJ
 OnwLviswiwO6CNmtWWaRcg5C2gTe5e1vhKfduWhBdpcGKKheCL5fyNW1E=
X-Google-Smtp-Source: AGHT+IEfeRnC4GZEHQ+7b/k+hH9nJF7hCH9udvtNgVwgNu35gl866OOEpMI8uNpl+lUUHLIzOXWrOg==
X-Received: by 2002:a05:6a00:90a2:b0:7e8:4398:b360 with SMTP id
 d2e1a72fcca58-81b7fccabbfmr8923030b3a.51.1767943926337; 
 Thu, 08 Jan 2026 23:32:06 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c52fd904sm9490421b3a.33.2026.01.08.23.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 23:32:06 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 1/4] target/riscv: Add Zvqdotq cfg property
Date: Fri,  9 Jan 2026 15:31:51 +0800
Message-ID: <20260109073154.46251-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109073154.46251-1-max.chou@sifive.com>
References: <20260109073154.46251-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The Zvqdotq extension is the vector dot-product extension of RISC-V.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ffd98e8eed..a295ddefdd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -206,6 +206,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
     ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
+    ISA_EXT_DATA_ENTRY(zvqdotq, PRIV_VERSION_1_13_0, ext_zvqdotq),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 70ec650abf..44224ef3d7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -103,6 +103,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvqdotq)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 988b2d905f..924f1728e0 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -783,6 +783,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvqdotq && !cpu->cfg.ext_zve32x) {
+        error_setg(errp, "Zvqdotq extension requires V or Zve* extensions");
+        return;
+    }
+
     if ((cpu->cfg.ext_zvbc || cpu->cfg.ext_zvknhb) && !cpu->cfg.ext_zve64x) {
         error_setg(
             errp,
-- 
2.43.7


