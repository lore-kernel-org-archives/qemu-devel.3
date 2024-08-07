Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832BDC49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUDD-0003U5-S1; Tue, 06 Aug 2024 20:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUD2-0002wB-Dz
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:21 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCx-0001Cd-B2
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:18 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso10680505ad.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722989232; x=1723594032;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uj9qOhBpCT9W/nbC5avAHQrsYFSH2V3flkgQB5x2ClI=;
 b=02g6eg1+/CTSSkUJCaTG5JH/MCdDrXvsX2fI7MbhlG/FUmgEZqpEKR2nVZYvR7JXYk
 6oefauza1pxndNln/BSaO8J/4IpnOJ8DSxiMihJrksWccM30UL0wWeMnrW59BNXWa6jJ
 vO9dFCwP8b6ufRokd6w4kw1OCIehQ6CW21ikV4K2rFCtN6vZ2ZO9SBSTZjvz8WcnXjfG
 N1Us83A9L08+xvnmL6KyuLA81HEJETXSGxEOVWa+dm3qdYDRH9mHLX+TwK/HrahQY3Qb
 btBu7Bey9m4g+2hZB9LB+x8nD7mMSTmU6TLocong9dFcbQKO1tpSo+CqwfU7fmlkebHB
 8AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989232; x=1723594032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uj9qOhBpCT9W/nbC5avAHQrsYFSH2V3flkgQB5x2ClI=;
 b=J+YQtsIoC0WVgVQydRtjGkFbajoWR0AIvbsF52R9hv4zL0vKEH0uYaszs2jYauPcDh
 Q6XeQSmDFRkWsIrlIcb1bdwy0FSzQyzlDtqWHJItwpeWEKfh2zLmJYmxPkbhx5K4mgZT
 lKR/A8/6MwzQInEXrjrnTnQ8ECAW4vyBy2STU+vee461JchEQnzcArtF4p6zi5+4wclG
 nEeW2CHljsITjuMIBfLWDbkuZUuDcn45VR67ZkLhaPIxq54MiM3FWf6EDFj+c+/A0BWt
 m/6sYaZSnS8ZkbPGDc4ev2bv213tihS+XTLA+iZpxXRjKj6sIrdwXG/CHOokFwtotLqH
 v52A==
X-Gm-Message-State: AOJu0YxPy6EfHO+Bc1al2rjyxg/oKw/KjJb7zdNXYE3l1OL2MWxrigyK
 BOTxHmPUyYtgcqeQy0YnOTbAQsX5H1lInNPmVifWEiO9OXysGi9E3qmP50SXNyKuuX5uRl4ai8i
 Q
X-Google-Smtp-Source: AGHT+IG0S6K7Re+FGinsFaYDN0gkrxNlCeNS/oEXXga0S7b1YEvHU99FnDlbAFgN4FUcK+ezq/Eujw==
X-Received: by 2002:a17:902:ea03:b0:1fb:83c5:cf93 with SMTP id
 d9443c01a7336-1ff572a81bcmr181473415ad.27.1722989232182; 
 Tue, 06 Aug 2024 17:07:12 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f59cc2sm93381845ad.92.2024.08.06.17.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:07:11 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v3 13/20] target/riscv: compressed encodings for sspush and
 sspopchk
Date: Tue,  6 Aug 2024 17:06:44 -0700
Message-ID: <20240807000652.1417776-14-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807000652.1417776-1-debug@rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


