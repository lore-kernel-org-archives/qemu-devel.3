Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3C7C52D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 01:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selRP-0001UN-0r; Thu, 15 Aug 2024 21:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRJ-00018k-Kv
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:37 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRG-0002Mb-U5
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:37 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5da6865312eso944923eaf.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 18:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723770454; x=1724375254;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7aDgKAdSr4Q9H2dHxpS8ZORJDwuil1GkJKQqDSSaQE=;
 b=bBjIq7uewVUDXOnHEXV3tda18uus09yQF2pMI8EY15NQZyidGyGQp14fCHZY/JkH/A
 L+J3tFbLuHbFtiSh32bi/owQi1L7b6ZfKouPPB2h7OpZ2dcQGueS1x6LPSSzudwdTjUp
 aBBOM754dslF4K33A+PsY5Q9uaPs4Cle0YE4oeVMaSGrLfFhh92g8ITU3RgHITWCjzBq
 m68zR6Lq4jVOaVY+G8dtSGMcAPV8G5/OTvrDjAK5Tdv9uhFmJ6q9RYt47MRHzZXNucZJ
 dp/SaRMsHkNDZ7ejzAUfAsOOD69366BJljJAi/dpeG+xJ+k3idkwy1AOi42/d2Bvt2Gi
 m1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723770454; x=1724375254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t7aDgKAdSr4Q9H2dHxpS8ZORJDwuil1GkJKQqDSSaQE=;
 b=JNpMYVBUA3J2L8DdMLQVcyI2U2y69nWfFfYdoflPpLG0dK3ADNTZ2gokeUZLRK9TWM
 bHFfxUMuUtKimwIf/E/Yxb1mgv04Ne0hShVDzZPU1/X1ZwUwWehLPpBEu7k4oNKc1JXl
 gypHYhtWQH4k2wqw2nxyoBMC2vJw+s0wFGRVnzVsKzbx3f0/ry5LVRBAJclw2zKmp+7T
 wpLpVqWRwF3yayk+UaGRoigwDh50do+buySt4y/RQhYHMGUrRbNo2ff68eWWArMihoGg
 h9bIdtgub8f8O/giqxJauryDYFuTiS5ipLWNHuZTLlS/JxPTCm9BlIURevYvYwh9u330
 vRBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKXl2SuHEZKKGWsVKUzk90Wzcjc4xBbLLOI/0IXzfIFRFwpdRHCzZo+qJ1o9REizZFz5PrDqFTc2PPMhg1V1//GgT2bMU=
X-Gm-Message-State: AOJu0Yzfytur2Z3jGlx5Ad3pWSBWohHTn1btVjX3yfTOaQUlqcnXKfzZ
 bf+6ptMW+gqflSu+fKhk9n4DEOi3CE4fzZWIa4MAVYV9mmkUUx+k50LdT38Tv3w=
X-Google-Smtp-Source: AGHT+IEfJ5QtQ2rEcjS0hTKXMGBl9bb63KhtK7fKVigiB3CdjKDOihrAaXDdaLFeKJx/ZnDKZ2ynog==
X-Received: by 2002:a05:6871:758b:b0:270:14cc:656c with SMTP id
 586e51a60fabf-2701c349552mr1419335fac.6.1723770453773; 
 Thu, 15 Aug 2024 18:07:33 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae120cdsm1604806b3a.77.2024.08.15.18.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 18:07:33 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 13/16] target/riscv: compressed encodings for sspush and
 sspopchk
Date: Thu, 15 Aug 2024 18:07:07 -0700
Message-ID: <20240816010711.3055425-14-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816010711.3055425-1-debug@rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=debug@rivosinc.com; helo=mail-oo1-xc2a.google.com
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

sspush/sspopchk have compressed encodings carved out of zcmops.
compressed sspush is designated as c.mop.1 while compressed sspopchk
is designated as c.mop.5.

Note that c.sspush x1 exists while c.sspush x5 doesn't. Similarly
c.sspopchk x5 exists while c.sspopchk x1 doesn't.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/insn16.decode                    |  2 ++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 3953bcf82d..3b84a36233 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -140,6 +140,8 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  c_sspush        011 0  00001  00000 01 rs2=1 rs1=0 # c.sspush x1 carving out of zcmops
+  c_sspopchk      011 0  00101  00000 01 rs1=5 rd=0 # c.sspopchk x5 carving out of zcmops
   c_mop_n         011 0 0 n:3 1 00000 01
   illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index 05d439c1f6..67f5c7804a 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -109,3 +109,15 @@ static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
 {
     return gen_sspush(ctx, a->rs2);
 }
+
+static bool trans_c_sspopchk(DisasContext *ctx, arg_c_sspopchk *a)
+{
+    assert(a->rs1 == 5);
+    return gen_sspopchk(ctx, a->rs1);
+}
+
+static bool trans_c_sspush(DisasContext *ctx, arg_c_sspush *a)
+{
+    assert(a->rs2 == 1);
+    return gen_sspush(ctx, a->rs2);
+}
-- 
2.44.0


