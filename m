Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5CEC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCJk-0000Sv-M4; Mon, 19 Aug 2024 20:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCJi-0000Ra-5D
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:01:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCJf-0001Be-3U
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:01:41 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2021537a8e6so28052365ad.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 17:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724112095; x=1724716895;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=krAOmrRGwzk16D6jxvidgTchDV2onVejpnKMH45Rnic=;
 b=MgVo2E/JYUPqtE+aG1egfj5WsKK5P2GrxUEvtqMAMkU1vrIxbwvec6o89X4s9A23xV
 oeSebszOGn6wfVDHX+ekSjb+SiA/dUkvb+kgGEql21DLIf6Fq7ag1blF2IUkTahmGZLi
 KXyEvNilEN0w8IpKIlJfJS/Y8J0rAMURXfMHVvDTPu6JBskw6tRcPuyPMrD9ehWubrsv
 b8UnUyudJ9Uxqc4+Ngu8MPWGTzqgq7mZLu7ylAacsm7ggzqEjxwIxbuUDL2yWQ3+IqNG
 QjQZ0B2WoPDXN78w03QMJYW/qrYes9F6rHWKLsyDPuR8KJC2Oq2DWqsM1t37gyakeBu4
 M1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724112095; x=1724716895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=krAOmrRGwzk16D6jxvidgTchDV2onVejpnKMH45Rnic=;
 b=H8RFRw1m1e1D6hRyPMbVCDjqYtOwFuzEPcEC3F6HhaZdxcr0Bp4d2XH3m7qMx4iQDu
 1TTaTzMTQ1OUv8/pjaVUcNEilynK6GJqqIN6UTRgjDIqva9175+aS1OcuZRhj8ui6VYM
 YnAEpr37bKGm8/sAayFjsgJJAFr86vvHRy20yyRTKAd0hzMUkSLm+N5KmS3LhGXEu2+P
 E6MxmQQsneFaz4ThcLtUOba1gXEY1j2Un7zF4XE9oUOY09hK86Xb9t7Fe9F+ri7ubJ7r
 5Hu8MbIgo9TBugYi9B9BaLd+qyK/V5JJMC7LW9CuSxvARH2g7tSbtWV57I1OkbokmhDA
 A5pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfKwOositCz84+iaZ61fDbdHqbHteRYT1WZg3rF3oFzN116dj99eSJ4HYUxky6q7vmnk0Zc3rlN214cZunKLW7XaXWbkw=
X-Gm-Message-State: AOJu0YyzOHWEnuiYchqb6OX6QXsmJsPnyvJDxFRdNS/iRphNO6mIQS/F
 2TzEd5xXAQYP36cJo8MYWU5UjtC+aburpZfRmtJc6zPLVC1oFOS22gf1e95/nwA=
X-Google-Smtp-Source: AGHT+IEhD2F8ekGV/M9M9F+9TlTldSA+/m90ztUZolEv/hx6Fquc5pi1CdiE+sRKBMFbR9ZT48tBtA==
X-Received: by 2002:a17:902:f550:b0:202:3444:af80 with SMTP id
 d9443c01a7336-2023444b1e3mr96961285ad.8.1724112095261; 
 Mon, 19 Aug 2024 17:01:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038a779sm67477445ad.188.2024.08.19.17.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:01:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v5 00/15] riscv support for control flow integrity extensions
Date: Mon, 19 Aug 2024 17:01:14 -0700
Message-ID: <20240820000129.3522346-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


v5 for riscv zicfilp and zicfiss extensions support in qemu.

Links for previous versions
[1] - v1 https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg06017.html
[2] - v2 https://lore.kernel.org/all/ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org/T/
[3] - v3 https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg01005.html
[4] - v4 https://lore.kernel.org/all/20240816010711.3055425-6-debug@rivosinc.com/T/

---
v5:
   - Simplified elp tracking and lpad implementation as per suggestion by richard
   - Simplified shadow stack mmu checks as per suggestion by richard
   - Converged zicfiss compressed and non-comressed instructions to same translation
   - Removed trace hooks. Don't need for upstream.

v4:
   - elp state in cpu is true/false instead of enum and elp cleared
     unconditionally on trap entry. elp in *status cleared unconditionally on
     trap return. 
   - Moved logic for branch tracking in instruction translation from tb_start.
   - fixed zicfiss dependency on 'A'
   - `cpu_get_fcfien/bcfien` helpers checks fixed to check for extension first.
   - removed trace hook enums. Instead added dedicated trace helpers wherever needed.
   - fixed/simplified instruction format in decoder for lpad, sspush, sspopchk
   - simplified tlb index logic for shadow stack instructions. Removed SUM TB_FLAG
   - access to ssp CSR is gated on `cpu_get_bcfien` instead of duplicated logic
   - removed vDSO related changes for now. 
v3:
   - Removed prctl specific patches because they need to be upstream
     in kernel first.
   - As suggested by Richard, added TB flag if fcfi enabled
   - Re-worked translation for landing pad and shadow stack instructions
     to not require helper.
   - tcg helpers only for cfi violation cases so that trace hooks can be
     placed.
   - Style changes.
   - fixes assert condition in accel/tcg

v2:
   - added missed file (in v1) for shadow stack instructions implementation.

Deepak Gupta (15):
  target/riscv: Add zicfilp extension
  target/riscv: Introduce elp state and enabling controls for zicfilp
  target/riscv: save and restore elp state on priv transitions
  target/riscv: additional code information for sw check
  target/riscv: tracking indirect branches (fcfi) for zicfilp
  target/riscv: zicfilp `lpad` impl and branch tracking
  disas/riscv: enable `lpad` disassembly
  target/riscv: Add zicfiss extension
  target/riscv: introduce ssp and enabling controls for zicfiss
  target/riscv: tb flag for shadow stack  instructions
  target/riscv: mmu changes for zicfiss shadow stack protection
  target/riscv: implement zicfiss instructions
  target/riscv: compressed encodings for sspush and sspopchk
  disas/riscv: enable disassembly for zicfiss instructions
  disas/riscv: enable disassembly for compressed sspush/sspopchk

 disas/riscv.c                                 |  77 +++++++++-
 disas/riscv.h                                 |   4 +
 target/riscv/cpu.c                            |  17 +++
 target/riscv/cpu.h                            |  15 ++
 target/riscv/cpu_bits.h                       |  17 +++
 target/riscv/cpu_cfg.h                        |   2 +
 target/riscv/cpu_helper.c                     | 140 +++++++++++++++++-
 target/riscv/cpu_user.h                       |   1 +
 target/riscv/csr.c                            |  84 +++++++++++
 target/riscv/insn16.decode                    |   4 +
 target/riscv/insn32.decode                    |  26 +++-
 target/riscv/insn_trans/trans_rva.c.inc       |  41 +++++
 target/riscv/insn_trans/trans_rvi.c.inc       |  55 +++++++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  73 +++++++++
 target/riscv/internals.h                      |   3 +
 target/riscv/op_helper.c                      |  18 +++
 target/riscv/pmp.c                            |   5 +
 target/riscv/pmp.h                            |   3 +-
 target/riscv/tcg/tcg-cpu.c                    |  24 +++
 target/riscv/translate.c                      |  30 +++-
 20 files changed, 625 insertions(+), 14 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

-- 
2.44.0


