Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1D6073806
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=LdbGQFjg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtz-0005nb-RO; Wed, 04 Nov 2026 14:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtv-0005TR-Gh
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:44:03 -0500
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgts-0002f0-TG
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:44:03 -0500
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-36d6765756fso990861eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821439; x=1794426239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ohqauE+X1k2Aa1PJoa/sZh9BgjfoRi6y5dDmTqKezlc=;
 b=LdbGQFjgH+CTtuILE6b7/+lqkmoesff+4hDlF2usoo5usl5LV5XgFbdECq94IEmRb6
 jLxH/c37PpXX+CaP7YVFDjnUn5nUNx3pQNBTKKsqbek9KGxApYFpfzPTRO4JfxDuK+Yg
 yCIEXDvI1JnyBkJ7Qn9fETsBVBswAKCt3zx9E1R85HmcS6Z4nkWWq/LHzmjkU2Rs5yi7
 inmXUlg6I9luvX9OuJBOQLSphI/+SIa2oSy+qFIbMjQsLvDUQrwBar2nbIGSTv/y8I4h
 pU9SUY41GMPUsN0hz7v1lt0SXWQsJGkW8m25+TPImpCaPYuOgf/dAFmzI91pXD5OIMXv
 2dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821439; x=1794426239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ohqauE+X1k2Aa1PJoa/sZh9BgjfoRi6y5dDmTqKezlc=;
 b=VKKXN8OIIYMkxOgK9R8rJOMGPMkT5s0zit5brUY/QrwAhW7i1dTW5KxIcp21ecAZrV
 GD0L3NN2bHRHPgXwHPRKetTwtcdcVFVYbMlEKgttTa2y/fcho8u5ENb2wACmnWYk/+Yi
 34bE23KP8CDCq2o6z8ojSkGormErafCcyIDMX3YF6qi8cki+GwgYqeVQw442P1uRDVOV
 VFrWrtLBPCltO4OJF8NfgzBpztGcfPJTvRvPA7GvjFXQbqzGtSPr9cEj61q8h/xLpoRz
 PzaJnjP7VQ9WHrFpyDgWodi5M0XCHtYhITxANIAsDI90QgKvoWeyGA7VQJsdxRZTjjRi
 vXvQ==
X-Gm-Message-State: APuU4Z9tC2KVkTMge8b13mjCV+bE713p5GFHSHj+ZS++/HqRytsZlKpy
 sI5ylEuuCkh/2Q4fWYeJ8P9fDjTxoLWmA98Zc6CQZYTOdUh0V24g0O3PNpLH2LyRm13cApYpzfA
 0CWxCaVFqDJ1FQOtzromRfbrYuvMjjHB246s7XIl3bB3LaeihNsJ3zAB2yZSFVhqAir1fnPTZAk
 +7c33U6AEBlaW4Xr1JUWE37cHW6MoUKm7GHfzRcbbOyQ==
X-Gm-Gg: AYBFou2FWYJY47ryFfIp5ndRsKhsAkc/3zzqVosIMPX78J7mN7EHLEP4eugHIxCF6o9
 LyK5e1q4mM7xqTzs5zRNdQXA1+3x9pSVtcLGGHK5W2WoAErKfO1KaANQUvRlLQft4d/DG3u1zy8
 96zLGLQU0f/leuMf0s85JSJtVzmM6ZQUFXBxc6fkE+qURpI/I8N/ehXrZ4qe+Yf4Wu9uFvFsWRA
 HSGW26+BDNOwvXmplaNKlR6XsGR69hIDB9Aj+D8lfDeuajVvlfMwPxIvz/QdG+NKTjcoDh8o8Eq
 nbJtxFOQAo0q7Ar+ZS4nImr17P1aHeiu+TCZxWNl3qF6/lsxqEgTfjRyTBW+uNTmo2b10/xiq48
 UCZYCObOXydb55sEPr5VzZUTo4ONuJQRhdXcrmybwmTGE+eurWtBK5ssdFjTgvBO3uzWeEbk5Xt
 cheLHRyc+Ia8k3Aklky14/8mzezASAnMEf0BQ33J9aohCLouYU9GKIgHGY8VY4FED7pfzbnQBcA
 Vfwvj6mnTCiulz/cPCwBPIekqJrCRjB+HJhOaOlGyZm5xygPMZEzuiw79s+JSsaJn0Dz4zyarXe
 /Sm3sBMC7LIT5QCTv4VPZf9s0O60C3tusaudl/0ONpIjeMQXdbJ4rqyD/DIUYQtGwHBy/dlg0Z2
 rZlY36IAGcNNJpOBQOzwZQwr/F2Ta5TOy9yc7B4sUcsFgrJhF+Q==
X-Received: by 2002:a05:7300:d0a5:b0:36a:1b23:a1cd with SMTP id
 5a478bee46e88-36a4239359bmr23484086eec.9.1793821439045; 
 Wed, 04 Nov 2026 11:43:59 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:58 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 33/38] disas/riscv: Support Zvfqwbdota8f extension
Date: Thu,  5 Nov 2026 03:41:48 +0800
Message-ID: <20261104194155.679241-34-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adds support to disassemble Zvfqwbdota8f instructions.
- vfqwbdota.vv
- vfqwbdota.alt.vv

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv-op.c.inc | 3 +++
 disas/riscv.c        | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index b24ffb45d8e..58f6ddac35a 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -583,6 +583,9 @@ OP(vfnmsac_vf, "vfnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
 OP(vfnmsac_vv, "vfnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
 OP(vfnmsub_vf, "vfnmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
 OP(vfnmsub_vv, "vfnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfqwbdota_alt_vv, "vfqwbdota.alt.vv", rv_codec_v_r_ci,
+   rv_fmt_vd_vs2_vs1_ci_vm)
+OP(vfqwbdota_vv, "vfqwbdota.vv", rv_codec_v_r_ci, rv_fmt_vd_vs2_vs1_ci_vm)
 OP(vfqwdota_alt_vv, "vfqwdota.alt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vfqwdota_vv, "vfqwdota.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vfrdiv_vf, "vfrdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
diff --git a/disas/riscv.c b/disas/riscv.c
index af41c2204f5..a124cbb4bbe 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2648,6 +2648,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 38: return &op_vfqwdota_vv;
                 case 39: return &op_vfqwdota_alt_vv;
                 case 44: return &op_vfwbdota_vv;
+                case 46: return &op_vfqwbdota_vv;
+                case 47: return &op_vfqwbdota_alt_vv;
                 }
             }
             if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {
-- 
2.56.0


