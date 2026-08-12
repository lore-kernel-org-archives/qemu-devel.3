Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2441C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUj-0007TJ-Ei; Wed, 12 Aug 2026 18:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUb-0007NG-Ib
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:13 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUX-000121-0d
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:13 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-84a652535dcso64404b3a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573927; x=1787178727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DOe/8CgW1I0IqzeuFb72e2cDgpWu8PHkLLWj4arZE14=;
 b=QIKgkrOvMZascGem8SrtvpV0/gqjPUnKSMBf1xdBeoAsGq13be0lIqexYa0uLzA6g5
 usgFb/ainSU4TmYYK5gOCbYcJSxgLGI5Ivj1ugQ+e8xEDmrpkYqtWTWxwzqJKC7jeM04
 wcs+WdNAQw4lXcZQb6PAlGqq2QWlP3BW0JOx6TRcXSMaPJ3zLaKP07IwR1eUPydNDW9s
 QYWtkDyC8Cvkx8Q1e2T7d6q24OSbzDetgxZXxw4svI69u9twZsuZQwGqmEELr4rdezM3
 auqmHZLpzpypMIq3K9IjUL8dgx1ty2aDCamE5x8dvgunybUhZPHwbO7VzTFcvr0hiLmh
 kz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573927; x=1787178727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DOe/8CgW1I0IqzeuFb72e2cDgpWu8PHkLLWj4arZE14=;
 b=ViIm2vyi+xxhl74chH8h1AYXYlxdPvQG97Fg3Hm/3sxeYX5g6SW0ilTOIfLCr9ZMbA
 SlSd9Eyc30iu0hgwrzY2vx3C6ghMypPx3y377oy6Wsb//UrjlpEs4ZbBGHPVgzClVVph
 K/UZtV7K5ehnkuBnJ9c4eSIUWURHjYW7mydEoVzGegSTuXWp7bF+e/KCxb47c29AQl5S
 Nz7aN4IBrdoNgPxcSSwjRWTMUJp61xZbQVatzpZkT0BS8vQ1MJlnwmArgqIpYZNdgab3
 +oueON8wd48eoW8NUBVJfIgT9uDMM+3isdUf+1C0XrFXg81rV3IMPlw2ii7LeJZL78oW
 GqnQ==
X-Gm-Message-State: AOJu0YxaeTNEj8rylPRlQFkydfjoIK3bJpmXnHotjDdG60oPW/jDZfBu
 763XrSU1mnHJeSY6BXHVw+t2HB4s332MNHay8GeRgH7I7YhJo93GJ+akrvztPQ8LzcYcSd+z5xC
 kuFzF
X-Gm-Gg: AR+sD12hDYerV80DsWR25GfbKdjJDofM3k3Yp/wbWtNd4mEmHsf9+zvR+4HFL1FJNGo
 6uTsa70ek8RgqdfdksasrCZldAiPU3MKVyn+z7JqsI1vcZ5qkgz9QvVnLfJShWKdVGfDAlQaXOi
 mY0Szto27fhoJ1xZ13oHSagCBxk4VdTvGEsZAAwnuBQS2crtBktpRNvprjVWTko3Jz5hmtNG3YH
 HVPBG83d8R+j52NtOebWck16A5mwK+gdxcsRJWX6VWocUJB0BBvtD+L/QLUWoVREDH3ugCkQ5so
 U/Dn/LjeGBuImh9P35iw9xTtjGRnuMQhfbCVcuLFkgTY0Q/pBnQB1kyxMqEbOhpdOMN5/1m2Sl/
 MpMGwCTj2BvgOdlg0yRGPNuzCqVsMOGUTNMZdhRKVxem9ew5m1wjOwUeJqs1xounbirlMV2ipee
 keLLPk8XH/SVQe0K+Xf+u/qpuyKbtGI1FjWYJb/A88czj2tjK5egv80JaAACeZrWRMzDsucCBsi
 bBbY0sETJ8TK0PFfA1WhqxkQ1hDVzs=
X-Received: by 2002:a05:6a00:b85:b0:847:77e9:acbb with SMTP id
 d2e1a72fcca58-84fc74f859emr1065789b3a.13.1786573927346; 
 Wed, 12 Aug 2026 15:32:07 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 22/52] disas/riscv: Handle aliases of csrrw during decode
Date: Wed, 12 Aug 2026 15:31:12 -0700
Message-ID: <20260812223142.349142-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index bde1cc6e62..e464b8b075 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1081,9 +1081,6 @@ static const rvc_constraint rvcc_frrm[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x002,
                                             rvc_end };
 static const rvc_constraint rvcc_frflags[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x001,
                                                rvc_end };
-static const rvc_constraint rvcc_fscsr[] = { rvc_csr_eq_0x003, rvc_end };
-static const rvc_constraint rvcc_fsrm[] = { rvc_csr_eq_0x002, rvc_end };
-static const rvc_constraint rvcc_fsflags[] = { rvc_csr_eq_0x001, rvc_end };
 static const rvc_constraint rvcc_fsrmi[] = { rvc_csr_eq_0x002, rvc_end };
 static const rvc_constraint rvcc_fsflagsi[] = { rvc_csr_eq_0x001, rvc_end };
 
@@ -1166,14 +1163,6 @@ static const rv_comp_data rvcp_subw[] = {
     { rv_op_illegal, NULL }
 };
 
-static const rv_comp_data rvcp_csrrw[] = {
-    { rv_op_fscsr, rvcc_fscsr },
-    { rv_op_fsrm, rvcc_fsrm },
-    { rv_op_fsflags, rvcc_fsflags },
-    { rv_op_illegal, NULL }
-};
-
-
 static const rv_comp_data rvcp_csrrs[] = {
     { rv_op_rdcycle, rvcc_rdcycle },
     { rv_op_rdtime, rvcc_rdtime },
@@ -1761,7 +1750,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "sfence.vm", rv_codec_r, rv_fmt_rs1 },
     { "sfence.vma", rv_codec_r, rv_fmt_rs1_rs2 },
     { "wfi", rv_codec_none, rv_fmt_none },
-    { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1, rvcp_csrrw },
+    { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1, rvcp_csrrs },
     { "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm, rvcp_csrrwi },
@@ -4443,7 +4432,14 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     break;
                 }
                 break;
-            case 1: op = rv_op_csrrw; break;
+            case 1:
+                switch (operand_csr12(inst)) {
+                case 1: op = rv_op_fsflags; break;
+                case 2: op = rv_op_fsrm; break;
+                case 3: op = rv_op_fscsr; break;
+                default: op = rv_op_csrrw; break;
+                }
+                break;
             case 2: op = rv_op_csrrs; break;
             case 3: op = rv_op_csrrc; break;
             case 4:
-- 
2.43.0


