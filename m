Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C20C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 13:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV9AB-0007xN-EH; Fri, 27 Jun 2025 09:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uV9A8-0007x6-FX
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:30:40 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uV9A5-0006Jc-KC
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:30:39 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b3182c6d03bso2481421a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1751031035; x=1751635835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BQ/ELmtpaVFDvL8MnrTDwR7mnKt6S4FAnUnxosIKkao=;
 b=bUT/6Pqj3XZEpTkdDoiCH9gLc6okxx5/j4riLtdn9uuzThZ7S+lXbtVCQN9PSm9Ybr
 fdTghTsuyVI+ytPNVi/mdlTg7oy2lJf0CeGTm7nU2fOz/59VbaGPEmqlidBEdorfXYUc
 tAgTL1Tfb2Dg0Xw5YdE63P9MzTbbOseG/Xr/ndKonQkCkOggZk4QgSB+6nIypEroa8yh
 ZjirSxIcI9C90wsw+vcifNY7BV7Y2kGx/QsXzO3TU90/q+3OiFPBv7RvJZ1O28PwC3q4
 rFSb3qaGobzal9XpHM4VnO6hyCoa9hFJ0oYBAo4sNPUoC38yNKOd3FpL1f+G+82q8hwx
 Rhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751031035; x=1751635835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BQ/ELmtpaVFDvL8MnrTDwR7mnKt6S4FAnUnxosIKkao=;
 b=YOaEkGcz2ZZw9mO/5es669v0fyl82p9YzR7pqu+Wl57n/Gj59K5ZA+cSrVoRNsPID7
 PqiB3U0yITXHA+lM9GXJl4lcXyMNmJlyvyVJcTSp6eXSqwybEGXKWXyJ+8qkfJEjUwZ8
 ENJx75blf9UOjuUxw5qC1mpF3EbrgfGXLMr6DweS7w/aeg5EmKGKNvF5g4SZe71Rvcrx
 O6L+CRfUdbt/YKIDahVRUOgsgXYLvf9sQ9l6tfeQdEtYVdvmbOCH9qzz7eY4OWKTkM/Z
 lZ6BIy8tJZiUbYAb6uSyDm/tZdAdqPp7aLYg2cOLjt65inTJenv29bxzZhqCc5TwL7ie
 EmEg==
X-Gm-Message-State: AOJu0Yy+vIZ0WsOPfMiEcEnZdhS+vnR7+teSTJrzZTLNtyQPcJFa5FTJ
 aq6PGA9Xn1ZzzL5TllBzCI5159AxvB8youPEj0gHro80hgLkgv3qGYobDqeafKTnL4bRPYJ+K/g
 G3SCW7YXb4MJzB9NfFE3vJxrEObocITzB87dUtwlGZkqVqQMuxycWSnn0047H8SzgxRnvwkWzTz
 Djy7aXXW5SQ8NwZAp5BpDczp7jg+fUQGS7tBn2of9Bmg==
X-Gm-Gg: ASbGncvvI33M8yCYT6RSeje/FCSv39LMe77XFb+itnGuyD0S5WXx9lvjj3ZpiyLXcPU
 n90ilFFeK06JChiyXsRs903KZM1T42pWwyoVdJ2eQyLeF2vRjnta4F5yDT21NrUNKd2ymJK1VXV
 aN6CJm8FZw6Wkgbfsl9CbBdx7zKqNGIRCE3UnuoiiNUe7Ue5L3QfnJnyjU55LBmzCKsyw9DBM8N
 cwnIlB8nkcOy0/WhLRI+Ye8St2AzKG83uWr+FLRsLrU3IaaZKP9nWixE3adroFcZi4pigavI17p
 DRoUr0JvAgGUPgleWkq8ndMmFf3XuAm4u7m08WnNrn5D2qORo45JqCaGyqDqW2GEkoqHYnF1JYY
 DXROmg5WvPqvRp33+nEFSbLPbHHOLazA=
X-Google-Smtp-Source: AGHT+IHo/1pkGyRXMTpDt1BUaqnsvjB72HFzpFQPqFL24ak8/5CwEHR0kyNZQ2yxclpTlO2pP+XG8w==
X-Received: by 2002:a17:90b:2ecd:b0:313:db0b:75db with SMTP id
 98e67ed59e1d1-318c93252f0mr4647020a91.33.1751031034466; 
 Fri, 27 Jun 2025 06:30:34 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-318c15232c9sm2489462a91.45.2025.06.27.06.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 06:30:34 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH] target/riscv: rvv: Fix missing exit TB flow for ldff_trans
Date: Fri, 27 Jun 2025 21:30:13 +0800
Message-ID: <20250627133013.443997-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52d.google.com
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

According to the V spec, the vector fault-only-first load instructions
may change the VL CSR.
So the ldff_trans TCG translation function should generate the
lookup_and_goto_ptr flow as the vsetvl/vsetvli translation function to
make sure the vl_eq_vlmax TB flag is correct.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 2b6077ac067..4cd030c7eb3 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1361,6 +1361,12 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     fn(dest, mask, base, tcg_env, desc);
 
     finalize_rvv_inst(s);
+
+    /* vector unit-stride fault-only-first load may modify vl CSR */
+    gen_update_pc(s, s->cur_insn_len);
+    lookup_and_goto_ptr(s);
+    s->base.is_jmp = DISAS_NORETURN;
+
     return true;
 }
 
-- 
2.43.0


