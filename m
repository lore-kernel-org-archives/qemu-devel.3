Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57D1CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1KFI-0000tW-Sw; Wed, 24 Sep 2025 03:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v1KFA-0000rd-QB
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:48:53 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v1KF6-0007dL-5X
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:48:52 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77f605f22easo1160131b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1758700122; x=1759304922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KB38NnEtT9B3jB0+dFkrRyRsrLIOQtL/A8YIF8wY9qo=;
 b=dnb1YioTTi76PUWMtgkpy806ZQ1Ct3eViwO2kUaZ/3cDD88PC7O/TO6swYc0LcEhEH
 m2XuwBZvCQbTJE2kYpilz6A4E4IeIVEmBwT40ArC8QpbiInCUifLHLl7JUxfjIC8wjiS
 DvpN2wSZTa4HrpuwiaDbKbxUa9/FRQQQ9azos/CwaOg/NZ5ohrnMwtFNZYysoisi1T/G
 1dMdD58Rw+rV9XF4WREs5J/1OkDUJRHvrmvEc7jTvq0q4wQaTpKTKasjvtJDuXTt7410
 QVXBTZuIR8PxbUuCiTTPMX6qhOrY/I3PIuUX/4tB4MuEYduQR/W8W3VdZ6gZHaSiLR9r
 fqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758700122; x=1759304922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KB38NnEtT9B3jB0+dFkrRyRsrLIOQtL/A8YIF8wY9qo=;
 b=HmLOd75hWcbK1WPQUgeS7w94UELmx7YB1LyHygpX/zxl5rB/pIVhqZRUo3BsvrWJln
 EwkuzXFeg8i600o8/BpCpv7nDFbU0+S4+F8FLfAdWXN3f0xAkbLlTJ4Vrnf4kCke1dIJ
 i4v6m9Ri5FfeOGyCrpG6nLz8Jz7WaKbsejc6mpae60pDrGAkxo3T5r4YAj3icNAbt+qB
 PHaBOI39PpSvuskzSSnmSmWbLtXSH00PTqBP/Eai2bgjNu3x7ao15swcofBqap9+gQE4
 GWPsMRsvnTnOXpgozARP+IceGIbYLqQA276nDW2P91ipR1rPL2Xt4TnyVFfNfa7GZLge
 8npA==
X-Gm-Message-State: AOJu0YwfGPQ4q/rmvK4yTbSFaQFvmkqH4O0qP8PeIMwCVZMzPi5psoxQ
 xIz5xrh6NGAbCbY0DzW/d7PMVYqxZNaaPy7qFAG04vsL5nhf9tCbNYNocemlBAcEjCr6uFI5v5Y
 +6HNrCVX43OgjjOp/qRUKMgbEid69u2pCiA/bvxtB3ccDc053G4+IdewpEaPnBEOW58KyQFlpZ5
 J5G5HXUZ4TQOabMj1nuSGYXWHDyS9DnD1c7CskTg==
X-Gm-Gg: ASbGncsqDQRmkIbCHqSWW47t+tsFzf6KkAZMvwG5XQ0dlPeqDDFMJxqO41qakeY5VTz
 2ajvyUO/pKFfN8HF7Uj9pPMWy+S3Fz0O29VplySonfoaYj2IyfMwFYmsv57+DEWwlYrz5l5JmmF
 GSSJcUTQwgnwDqmcsGYwUy4Q+M0KHwc5d+ITWWmjtaqRCM2djo4RUwYOlE9P4kLX2+YAUaZljSE
 6lVH6ORYzgqH5YzebROgEX0IMzLTxCcKUXhXsdbDKDrnU8g+VrVyr67n8eUAkdZZFKNb8eFt204
 diOUawveJjLbFAfzqxg4banEXPduM2c1wBRS4YDrOC49tDWpfg/taP0MhCW9QY/ktnU4ItDztXL
 lqbfUPhtmvRGzFbfIjbMSICFRuzBp1HKU2rw4g/sgEzpmZ/W4oWDPaeY=
X-Google-Smtp-Source: AGHT+IFXI3WzGp2hjeRy8sgxLFhWiU3qxsCqDdU6XJvdOsip9rH89UUsmInCapi4Lhmh805ImBC34Q==
X-Received: by 2002:a05:6a20:6a22:b0:2bd:2798:7ae7 with SMTP id
 adf61e73a8af0-2cfe9410fe3mr8110708637.31.1758700122014; 
 Wed, 24 Sep 2025 00:48:42 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b5541f0374csm8778502a12.49.2025.09.24.00.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 00:48:41 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v1 1/3] target/riscv: Fix the mepc when sspopchk triggers the
 exception
Date: Wed, 24 Sep 2025 15:48:16 +0800
Message-ID: <20250924074818.230010-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924074818.230010-1-jim.shu@sifive.com>
References: <20250924074818.230010-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

When sspopchk is in the middle of TB and triggers the SW check
exception, it should update PC from gen_update_pc(). If not, RISC-V mepc
CSR will get wrong PC address which is still at the start of TB.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index b0096adcd0..45686af4d6 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -40,6 +40,7 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
     tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
                   tcg_env, offsetof(CPURISCVState, sw_check_code));
+    gen_update_pc(ctx, 0);
     gen_helper_raise_exception(tcg_env,
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
     gen_set_label(skip);
-- 
2.43.0


