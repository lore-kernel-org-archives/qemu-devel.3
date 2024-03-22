Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7736C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnbGH-0006XO-Ly; Fri, 22 Mar 2024 05:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rnbG9-0006WT-8K
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:32:21 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rnbG5-0007rD-NB
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:32:20 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e6ca2ac094so1695311b3a.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711099935; x=1711704735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amxbPeLbXqo1zWE4TFT0EG8FVb63cJF/WE2DZa4oq1U=;
 b=Gx3LKD6o7jLatyJQvoFtNV82MAlHbgapj8AssepvcrczlJsaJQiqeNrO8x3OBZuqAY
 /EmFKlapiW88IuZ/3k2NaPDWVqp0rU8/zAgA1pC4aEo8CzG9W83XswP8TjkRgqPqQMre
 VbF3n11m+R+59BvNdMNRwuIURUdFhOloEbm0FDwnZ3E3pzVNcy1yGVdvTZH2Pe54LGhO
 St76aSRH9IU0z9sFcpu7gOQuyw14BzJJflFXWZkdwI3TcVHgHpfdKVn8GQLOREaYD/rU
 mJ2N2waOmh6Uv95wnloMcyFH354hRfPhNNRBwYY3QhGe+7xrS+NzXxsR0AwZP1vTRMYz
 Odpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711099935; x=1711704735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amxbPeLbXqo1zWE4TFT0EG8FVb63cJF/WE2DZa4oq1U=;
 b=mYzFjMSHKFPbjp/DeQqSPKpzKpXDi+A7lAgyvoAUCv5EqVnenmyqpJ/VHdG+I1aqGC
 GzrwhPTXm0ly4vCaNYFg/8Dd+WUtw3CNxj0oapQ6I2EJLxz2QmDGWud1HVUStYazkVD6
 2++BRE6RNM0x2KTvVOkLUnqDP0nOZr2EuJAvWSp5TvdAQ9ee9jd1f8FY6dNaiwGEXn+e
 BDBZO1xivXNOtu7TDFJHz6i4X2JDaOM+tTS5kIPSgHGTePBFji71RLBFXxIc6675Ctpy
 RsyXk84kqAVqrK6A62feMBvGi4LCig794wIy37XI8dnYGUZ94zU93LtlCcwdIxGabREH
 92cg==
X-Gm-Message-State: AOJu0YzuuM6DkNPRKDwD+g7phWZdxoFL9DLyjl1ndJ2iXOnfqKftV9ZL
 tcyAzq3LKsrUEqKzv11gKE+b5GuM0rg0u9ZRpAh/t+smNkDx2pOoydmWx2BJd9vPeVMUZpPcqrc
 gnW8YTNAlhJuekzUFAqp7B/SNYBxT19l+Of3kwXMjWGLfM1ZLPWsdkKGZ1xByjxxy7nrVCHz+CW
 sU7xEFw820swDDHcC3e6PxOtTAuhKy9IaZulbv4g==
X-Google-Smtp-Source: AGHT+IG5IZkGhxJhqO0EdzGXlNDu4cIS+WC6cZJdvk0/yA9LjjS7ybyWW4hJKJ5n5CicdKJXtKNGjQ==
X-Received: by 2002:a05:6a20:f21:b0:1a3:57b4:ed1c with SMTP id
 fl33-20020a056a200f2100b001a357b4ed1cmr1674613pzb.25.1711099576574; 
 Fri, 22 Mar 2024 02:26:16 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 z14-20020a170903018e00b001e088a9e2bcsm1380380plg.292.2024.03.22.02.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 02:26:16 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/4] target/riscv: rvv: Check single width operator for
 vector fp widen instructions
Date: Fri, 22 Mar 2024 17:25:56 +0800
Message-Id: <20240322092600.1198921-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322092600.1198921-1-max.chou@sifive.com>
References: <20240322092600.1198921-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42b.google.com
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

The require_scale_rvf function only checks the double width operator for
the vector floating point widen instructions, so most of the widen
checking functions need to add require_rvf for single width operator.

The vfwcvt.f.x.v and vfwcvt.f.xu.v instructions convert single width
integer to double width float, so the opfxv_widen_check function doesn’t
need require_rvf for the single width operator(integer).

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index ef568e263d1..6cb9bc9fde8 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2331,6 +2331,7 @@ GEN_OPFVF_TRANS(vfrsub_vf,  opfvf_check)
 static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
@@ -2370,6 +2371,7 @@ GEN_OPFVV_WIDEN_TRANS(vfwsub_vv, opfvv_widen_check)
 static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
@@ -2402,6 +2404,7 @@ GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
 static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
@@ -2441,6 +2444,7 @@ GEN_OPFWV_WIDEN_TRANS(vfwsub_wv)
 static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
@@ -2941,6 +2945,7 @@ GEN_OPFVV_TRANS(vfredmin_vs, freduction_check)
 static bool freduction_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return reduction_widen_check(s, a) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8);
 }
-- 
2.34.1


