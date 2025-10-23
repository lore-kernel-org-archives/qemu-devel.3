Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F830CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC54T-00049C-5U; Thu, 23 Oct 2025 19:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54O-0003xc-NX
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:12 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54J-0007LQ-6Z
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:09 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b6ceba7c97eso1279868a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263405; x=1761868205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIywLHQdV6UPgECalZOtYVqVU23U/5XRJdU3/A1ZS6s=;
 b=dr21K1+nU8H+RH0ScIa2lZyA/pnwXaWKfhSXQ4UvQzCGBA6kLESTWmqhsLUDRu2VmF
 8NqrAzpW+t7QzVFn0/Cd9p9UUQ1flec4MfN4ReVLEXKMq+pvucjyWOsnXhEhv6W01XIS
 lgbQB84UWyf3VeACtlV6MmewNATnzVY3ZgrRj0iEyhLgS8ObAOOeOWJXZ8bWu4dYxWER
 6wvGuhat7fpbXDtD9+OQHqh6LmhtjZRcskXd9cppCb40/WEVGDcb8nLDBATBGjhhEQhP
 3G8J/IbGQR0Hv1IWR6rpC5Y9XL3+gykFL6Jtj05brETa8Rvq/3kegb+xPaq7vBvzh9m/
 fonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263405; x=1761868205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FIywLHQdV6UPgECalZOtYVqVU23U/5XRJdU3/A1ZS6s=;
 b=xGZOSbPcVEKUdhrU0pBddNkCoQ8tLX3GxT7JyFdkOgk9n9ukuH0N74+5GeB8az5DqH
 vykyoCumrxk/m70DVi6EPlRotVB8l7nxHlVk/PzqlwNmOoIS0reQJf0yu93KB3iubdbl
 HHWlKTaaNH1patsKtBxxqhjSrNLAmDpfsmrClGGrmKos5Nw2JKtMGehlQ1jEkhAwEnzr
 /i6O4uqjTPe6b32VqjZidYgTQwPolMhwF8RRlhTyIctuX2qS3Y/KGUGGwDS4ulgrCgKZ
 48Dwk7h/kqdBvj30p8obRGW7LgvNnfPKVTttumfoxAnoY5WrrxHGKb0KEZhLpC3Cy52h
 08eA==
X-Gm-Message-State: AOJu0YwP4RwKV6Qnna4HFrVkE2PN+Q1L0GGf6oI764fbQMtsK99q0rVJ
 vHsONU7c3aZkdKvY69dP3sGqNPGtcA//FpSFmQGo6C7dkSPNfHrVRNRbqiisRg==
X-Gm-Gg: ASbGncs+KG4CscjNdAkWFwgPxrytLVb0A8aSsaYa+eseJNYHDCdPVEKBlbSE2+YJHwS
 dQK/y5TOu98cVHAyOFokQIcmSScTrRyzNsBU1HwNZFuuhoXYCPppAybJKg7ZdaMkanh/41qSr3o
 GDFRGSsTeO2wTc04TI0MMItraoJ6w6Nv68Jx/laxQBmRdCcaDWLqWCWrgO277nLgcn/+WWq7Atw
 ZC1FTpP3R1rTwItjVxEJ1liKC5OU2gkaUIiWzzai9Po1pB/mS70lKQ2k3ZEdXZCyXZZeDxEh7Hv
 fbblPgxnUzrJlQWdqCKTmiPZy+noQ4OcsL2Vbvu6M4ew8osf7X9dOyN7fxwd28oFKO9ouYr+Ffl
 ppO4g5VHc08fCH29QO/wBkfiXbTPBw9rzRb18bYbanRuyzSMkAu7gEUFUe+wkNYiMmrm+oRRDiG
 uWuvR9fGLslivmPYg3gCrETlHqryiRBwqw++DO+gc2Dymf08GMrfFfQK6cYdrJXNaQKeij5CDd+
 CI+nAhh
X-Google-Smtp-Source: AGHT+IFtjUPjCpZ9F3fpzpx/tQW/wR89LAYtq7Ngip/AfJ3rGiWniYkrqLf5bM6k1uju98vPOvnNbQ==
X-Received: by 2002:a17:903:1a0e:b0:269:d978:7ec0 with SMTP id
 d9443c01a7336-290ca121a4emr331886265ad.28.1761263405299; 
 Thu, 23 Oct 2025 16:50:05 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 08/25] target/riscv: Conceal MO_TE within gen_storepair_tl()
Date: Fri, 24 Oct 2025 09:49:10 +1000
Message-ID: <20251023234927.1864284-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All callers of gen_storepair_tl() set the MO_TE flag. Set it once in
the callee.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-9-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_xthead.c.inc | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 859cbc26cb..2f31842791 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -926,6 +926,7 @@ static bool gen_loadpair_tl(DisasContext *ctx, arg_th_pair *a, MemOp memop,
     addr1 = get_address(ctx, a->rs, imm);
     addr2 = get_address(ctx, a->rs, memop_size(memop) + imm);
 
+    memop |= MO_TE;
     tcg_gen_qemu_ld_tl(t1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_ld_tl(t2, addr2, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd1, t1);
@@ -937,19 +938,19 @@ static bool trans_th_ldd(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_loadpair_tl(ctx, a, MO_TE | MO_SQ, 4);
+    return gen_loadpair_tl(ctx, a, MO_SQ, 4);
 }
 
 static bool trans_th_lwd(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
-    return gen_loadpair_tl(ctx, a, MO_TE | MO_SL, 3);
+    return gen_loadpair_tl(ctx, a, MO_SL, 3);
 }
 
 static bool trans_th_lwud(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
-    return gen_loadpair_tl(ctx, a, MO_TE | MO_UL, 3);
+    return gen_loadpair_tl(ctx, a, MO_UL, 3);
 }
 
 static bool gen_storepair_tl(DisasContext *ctx, arg_th_pair *a, MemOp memop,
@@ -964,6 +965,7 @@ static bool gen_storepair_tl(DisasContext *ctx, arg_th_pair *a, MemOp memop,
     addr1 = get_address(ctx, a->rs, imm);
     addr2 = get_address(ctx, a->rs, memop_size(memop) + imm);
 
+    memop |= MO_TE;
     tcg_gen_qemu_st_tl(data1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_st_tl(data2, addr2, ctx->mem_idx, memop);
     return true;
@@ -973,13 +975,13 @@ static bool trans_th_sdd(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_storepair_tl(ctx, a, MO_TE | MO_SQ, 4);
+    return gen_storepair_tl(ctx, a, MO_SQ, 4);
 }
 
 static bool trans_th_swd(DisasContext *ctx, arg_th_pair *a)
 {
     REQUIRE_XTHEADMEMPAIR(ctx);
-    return gen_storepair_tl(ctx, a, MO_TE | MO_SL, 3);
+    return gen_storepair_tl(ctx, a, MO_SL, 3);
 }
 
 /* XTheadSync */
-- 
2.51.0


