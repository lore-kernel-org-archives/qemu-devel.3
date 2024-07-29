Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0C5C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZR-0006PI-K0; Mon, 29 Jul 2024 13:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZF-0005Sc-PK
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:57 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZB-0000Lu-Nb
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:53 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3993c6dd822so14177875ab.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275628; x=1722880428;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uj9qOhBpCT9W/nbC5avAHQrsYFSH2V3flkgQB5x2ClI=;
 b=TxH+ogYfFk4l3XxIfy+8nG1290tSid4ZbpzrhrtuFMxL+Eg1lua5fgmr7jtp7f+20y
 6c0CM+D2vZhx+bmlIGEE4WgoNwuEROZMVsIawl9dDlCKKk/DsplJD+j6OaanBisfJyJ/
 eMdCfQj1uiGfkmLWU86ghFmd4V81XvBMkAfekhnHiXKNWwyTk0NhbkJugkihYWuS/kbn
 eTTntGSxnQHt4AGIlxDyAbOCantdbBx1GHjTsXNwyfyNaXZjhr/2bh8XUiGyWR5vsirD
 p5xkv9YFaVzSKWwphgiwdI6VSSAVf8EJ1oHI2hzLfq+VevPcvjag3/khbAccKKfpE9Li
 BGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275628; x=1722880428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uj9qOhBpCT9W/nbC5avAHQrsYFSH2V3flkgQB5x2ClI=;
 b=K94PAnlrpKtG7P0hAuyruXb0eYlkzLF4TllDb77tXde4f6FyMtBGmS2pwob2qMelxr
 aOsb5i1JYxJhbawMIeec99pQkvIk+/z5Q7DZIOV5/GrpyE4QvoM/vIVy0f4Q1UZalWRx
 3cbmds0PmzdC2TSPgd9mwxLA4DM3UlpwxVWhRcUVUxy0curqclC5BoHiWuhrmWZQYVMA
 2OG2VMXE8aW1kFGquA2+XJc2d+lkucnF8+JtsEjBSnEj8yuh1VUk/7xRXmFcDYyKAIws
 bIDHJAcDLxO4sdD+geHf6ofCHXdU/9olkeI1JTXqb0x+mr1RUztyBMIL6y1c/r9GICMD
 2MYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOuRx4hRnsruHthci30nSWBneXBabBA+/Hsz9FVQj+E13AvPCR/Ri0jQvNL3CFD5cAQQb809rFHhL3+cnowS6QaAJAnB4=
X-Gm-Message-State: AOJu0YwYfLZuF62nFSqijMTWv3j6V9Sk++2bhth3gpEPRsPOL0LCwvXB
 cV3IynlyK1HNiNKICjNLQIXQKwp36GwPNrFjzkViUyolVvxC/IZi8aINCS70Fok=
X-Google-Smtp-Source: AGHT+IH/U3ghK7j5ZSCo9FLWyDVR242srP8apgB36GOjYp4ObB9A7U9CXVIw/4THX6x1QyxDNA49OA==
X-Received: by 2002:a05:6e02:1523:b0:37a:9ab7:ce34 with SMTP id
 e9e14a558f8ab-39aec4020cfmr96570275ab.19.1722275628094; 
 Mon, 29 Jul 2024 10:53:48 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:47 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 14/24] target/riscv: compressed encodings for sspush and
 sspopchk
Date: Mon, 29 Jul 2024 10:53:16 -0700
Message-ID: <20240729175327.73705-15-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=debug@rivosinc.com; helo=mail-il1-x12f.google.com
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


