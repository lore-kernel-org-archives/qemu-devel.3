Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C016CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQgP-0005DC-5h; Tue, 16 Jun 2026 06:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgL-0005CH-Lr
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:10 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgJ-00036L-R0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:09 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c855599a77aso2142096a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604366; x=1782209166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSc9axaPT/La+j42KDU1GrRJuTBvMeNI5owh5Ul0ye0=;
 b=HdiggKge4C4uwgc3wKvm65bHu0oLYOp1v3c4/PQaz83j6H8Zn61DayEeXQgd8K07MC
 sG/WhK5MZYOfkUibtgR+12cgNy/02ghB/NJJvvSWEDEp0QNl4/zq3XdTnJcILHDO3zli
 4B49PZTeqL2LZJNgnuuOmM/4o/UG7gwn0xV29xEIe+r46UE0TGpKj97ObOAiueiOhYeD
 UPTMYINB/yYRxO/qY0S+bpE8KAyOjguNIQ4Pz6jZ5TQjSLqfMc5c4JJkTo+HKx964SnD
 tbzKhzuTrXNmKpbiYiRctWTEmbayKr1y9Bb6R+XyI0oEjbrSrJZccLYzapsNqLDImXC3
 8RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604366; x=1782209166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MSc9axaPT/La+j42KDU1GrRJuTBvMeNI5owh5Ul0ye0=;
 b=GLsWEZlcuaNNNI3BXckND4EOCEQPtSdIWm5DA/yZjyQdux1t659pC2n6Wrs/f/TKl9
 ftup/Zk9t9W4pEhwSKvJQj/twNMuLasAPBus7MOJo2vSWCPm9CYL1WK7UGxphCt5bKqO
 6EvoXI6Rh9goQxAvP4kv8Gdhl6FDBkJ1bYSRXZ8DgpJDHKxqUD7R1yiDHEvajP6jvCgD
 9H+2gJ6GPrKoiyMPeivAlfw7XW60GIaKnSDE2P3ZuMtnR+Qq+GENcR/y0MrGrFRIUXPd
 Y8F2t/+OxScHekws2ossbSU1wJ6iKptgpQcgNqRjqRuu3AaqYZ2OOB/ljm2uGnROG2Ex
 4YDQ==
X-Gm-Message-State: AOJu0YyIl4qBMb5FkcR1KE7IWkONescdNn8Opbh8Q51XzPguYR9hKROR
 wtq9/FN+loPhYD862lM6Xz4kjeiO31xfPTzS+I8RP66K1sFSSjWn5tW3M59eWDO2
X-Gm-Gg: Acq92OGiQmIlzYUE1w7OmeBvPw8HFAWPy5gpm0/N9S2N5mhj14GaZFEpGz8Rm4CueVL
 gS3aoXUpPQysREfpRj4clNvAU2Fues+GEKViXVyhYgq1dzCOk0se4ESI32/ZyvKih4/KYk17TXQ
 B/iH/aD2RGzPbj9TjsG39fkdXuzwKcFrOnKzzEkNmGDV15rN14Yyhvb8rOSzBNI7JHJDBVL5jO7
 5R2Q6S3uhi9TYTOpD3GwJLasRI79qBJylFZmop/FFm93wkWaYV4CVD0iW5Lyy1gSVP7Sq0dbnu1
 R6suaHqEWl4MVPHw2wEZUh7HCr4m+NFKc6rgPD43CYTN1j5X9Vh+qipZkWowN4z8SPH/U6Ex5ap
 AYKv1eMcv+8RBbZLfeUkUR+lQZ5g+DPcX/Y7lY3nVrLjD+raid8mFdDcoqgDBoT+kl/C3xr2Spu
 BexwksBsBIhSSRXSdS8UZ+Ai8pNJloUzRByyX4fDcR
X-Received: by 2002:a05:6a20:3c89:b0:3b3:241f:66c6 with SMTP id
 adf61e73a8af0-3b7e4cf86b3mr3343464637.26.1781604366394; 
 Tue, 16 Jun 2026 03:06:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/83] target/riscv/insn_trans/trans_rvzicbo.c.inc: save opcode
 before helpers
Date: Tue, 16 Jun 2026 20:04:12 +1000
Message-ID: <20260616100527.1939565-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

All helpers from this file can trigger ILLEGAL_INSN exceptions via
check_zicbo_envcfg() directly, bypassing the usual exception code from
translate.c.   If we don't save the opcode before each helper,
riscv_raise_exception() is triggered and env->bins won't be unwind during
cpu_loop_exit_restore() (code path cpu_restore_state ->
cpu_restore_state_from_tb() -> restore_state_to_opc()).

And finally, in riscv_cpu_do_interrupt(), we will set (m)tval = 0 when we can,
instead, set it to the cbo opcode that generated the exception.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3380
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520214704.1943652-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvzicbo.c.inc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/insn_trans/trans_rvzicbo.c.inc
index 15711c3140..096f7dde27 100644
--- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
@@ -33,6 +33,8 @@ static bool trans_cbo_clean(DisasContext *ctx, arg_cbo_clean *a)
     REQUIRE_ZICBOM(ctx);
     TCGv src = get_address(ctx, a->rs1, 0);
 
+    /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
+    decode_save_opc(ctx, 0);
     gen_helper_cbo_clean_flush(tcg_env, src);
     return true;
 }
@@ -42,6 +44,8 @@ static bool trans_cbo_flush(DisasContext *ctx, arg_cbo_flush *a)
     REQUIRE_ZICBOM(ctx);
     TCGv src = get_address(ctx, a->rs1, 0);
 
+    /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
+    decode_save_opc(ctx, 0);
     gen_helper_cbo_clean_flush(tcg_env, src);
     return true;
 }
@@ -51,6 +55,8 @@ static bool trans_cbo_inval(DisasContext *ctx, arg_cbo_inval *a)
     REQUIRE_ZICBOM(ctx);
     TCGv src = get_address(ctx, a->rs1, 0);
 
+    /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
+    decode_save_opc(ctx, 0);
     gen_helper_cbo_inval(tcg_env, src);
     return true;
 }
@@ -60,6 +66,8 @@ static bool trans_cbo_zero(DisasContext *ctx, arg_cbo_zero *a)
     REQUIRE_ZICBOZ(ctx);
     TCGv src = get_address(ctx, a->rs1, 0);
 
+    /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
+    decode_save_opc(ctx, 0);
     gen_helper_cbo_zero(tcg_env, src);
     return true;
 }
-- 
2.54.0


