Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D81C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Af-00018m-Fj; Thu, 25 Jul 2024 19:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AX-0000a7-9v
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:45 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AV-0005NR-5X
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:44 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-381f24d6bc4so4098725ab.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951202; x=1722556002;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uj9qOhBpCT9W/nbC5avAHQrsYFSH2V3flkgQB5x2ClI=;
 b=RHWukBa5KReBnH/1nZxlBJ+n/1PQ/B7nQCNbiSTmP4ZVSBX9Tv6D3NmHfMeDGS6Ynr
 C82ms7PvNOOdKeZkGWAqde5WxYaJxKTZTPWp9lNb2k/g8n3MR0HoK+gUcbRArtS7xqxJ
 EU9I2fUOQzdi5F4mxG4ZMYYjSERjZ9MeAslA361gbS9zwkwR4Jl+DDKx6dQhSKUUGnPs
 nn2YwNxE0f/WEb3/q8nCROmlnbCPLJCS6WRbhYX3lgnwN7YDwXkPKnVsldnGnY1dLqsC
 qeIXKkazDdiZGhEUTcduFJB5a+23PFEGwRbq9IPXlGRbjoNIDTOOTElbEtQ+4hW3ZvMQ
 +sDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951202; x=1722556002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uj9qOhBpCT9W/nbC5avAHQrsYFSH2V3flkgQB5x2ClI=;
 b=c3Nzsk6nkzuzldDLjHtz1CtN0PoHe0PFqOPmgLd76TO7glQ3oxDijkOOX3oy0W/tZE
 RAVh5XObbUb68Z6wFENxt0fMToaesNy510B39Wl5TYryhMVP1qP2zhrE32hh4de5kWi9
 jwpdMWRs4AVcbc4syjoEI5wpRm3L2DaJu4qL1ROIrlFgAfjwWtkoRvtNi167t7yZOuUM
 bY1RXPu8pjJXOArrD4WA0fl5mHd/sT/AC3rok0ZQaJs+ePIzM3ZlDFOA1/UEviwhfwj1
 XEhi2pkFU6r+8m5Ry5eBTsanqY6WC1cJUY5nY5ANT4OXd7/tVBWPZF+Na5WOOh5gLti7
 gavw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhH73h2mgaL8DKx54kIps9x7DIDsP/s99IeZSJPDx6Ch6xRbuTtL3SaqM2zS8ToPfj116AE7PIRHx09UJds6HLjpRUBRE=
X-Gm-Message-State: AOJu0YysLFezAJvZ1C9XAXLV4zoIBW4dYOtIAwNKCC2ohlpBLRS9uCl7
 0WXkn6dUGC9ref4MGX0vYZike9wIGT/HafiFXe83RVsyrx3fM/1XuuHdTsAUBBk=
X-Google-Smtp-Source: AGHT+IFZF2Y150hG36srXsae5j+LoDyBCvqWbbzlzdW4nMtoZOcidZNSbXQSx6jPlXjLHZFJuh7B3A==
X-Received: by 2002:a05:6e02:13af:b0:398:b11a:4286 with SMTP id
 e9e14a558f8ab-39a23fae551mr44546515ab.14.1721951201901; 
 Thu, 25 Jul 2024 16:46:41 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:41 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 14/24] target/riscv: compressed encodings for sspush and
 sspopchk
Date: Thu, 25 Jul 2024 16:46:03 -0700
Message-ID: <20240725234614.3850142-15-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=debug@rivosinc.com; helo=mail-il1-x129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

sspush/sspopchk have compressed encodings carved out of zcmops.
compressed sspush is designated as c.mop.1 while compressed sspopchk
is designated as c.mop.5.

Note that c.sspush x1 exists while c.sspush x5 doesn't. Similarly
c.sspopchk x5 exists while c.sspopchk x1 doesn't.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/insn16.decode | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 3953bcf82d..d9fb74fef6 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -69,10 +69,12 @@
 # Formats 16:
 @cr        ....  ..... .....  .. &r      rs2=%rs2_5       rs1=%rd     %rd
 @ci        ... . ..... .....  .. &i      imm=%imm_ci      rs1=%rd     %rd
+@c_sspop   ... . ..... .....  .. &i      imm=0      rs1=5     rd=0
 @cl_q      ... . .....  ..... .. &i      imm=%uimm_cl_q   rs1=%rs1_3  rd=%rs2_3
 @cl_d      ... ... ... .. ... .. &i      imm=%uimm_cl_d   rs1=%rs1_3  rd=%rs2_3
 @cl_w      ... ... ... .. ... .. &i      imm=%uimm_cl_w   rs1=%rs1_3  rd=%rs2_3
 @cs_2      ... ... ... .. ... .. &r      rs2=%rs2_3       rs1=%rs1_3  rd=%rs1_3
+@c_sspush  ... ... ... .. ... .. &s      imm=0 rs1=0 rs2=1
 @cs_q      ... ... ... .. ... .. &s      imm=%uimm_cl_q   rs1=%rs1_3  rs2=%rs2_3
 @cs_d      ... ... ... .. ... .. &s      imm=%uimm_cl_d   rs1=%rs1_3  rs2=%rs2_3
 @cs_w      ... ... ... .. ... .. &s      imm=%uimm_cl_w   rs1=%rs1_3  rs2=%rs2_3
@@ -140,6 +142,8 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  sspush          011 0  00001  00000 01 @c_sspush # c.sspush x1 carving out of zcmops
+  sspopchk        011 0  00101  00000 01 @c_sspop # c.sspopchk x5 carving out of zcmops
   c_mop_n         011 0 0 n:3 1 00000 01
   illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
-- 
2.44.0


