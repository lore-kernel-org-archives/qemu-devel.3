Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829D9C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kG-0003HS-TH; Thu, 17 Sep 2026 00:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ji-0003AC-1G
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:38 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jg-0006mJ-3M
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:37 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so268060a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619314; x=1790224114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EyvfVIpbqiYFMjTw3EigaFciwRRnh2+tfSMPM9zFtlc=;
 b=u7+gfSZ0N7m+qv98VA5C3iHYOFv8hvAZ9J6KkHoE6lPS92Bp7xiw3xuKQc065sfDrU
 WF/WWTpNwgAjMTFL19ivrx/hVjoih6lHM7suj2DZXG0VRhoAfKyIJ6PvoZ2FwHeW2xle
 CYkwhT4iTOmDWB7QbtBtWR2t0pu2tTWbskWWN9sUbH445N9ocIWOkSQ9KSAFzy3I9QOH
 Ns963fcsCsBA6/fDr+zm3w+J/6HgBR7QbdhF7krm7bTxRz7+n5BMkAhyLolqT2ekNkkN
 6SoseKwi0+uJbsB47L9jwz5dH9otpMbu2TC/CPlAtKK3wCMQs0Uqd6CcA65e1tZXDool
 MrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619314; x=1790224114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EyvfVIpbqiYFMjTw3EigaFciwRRnh2+tfSMPM9zFtlc=;
 b=UqzMnonE99kiyyBs1aiGGKXqBBO6lCWCFd8BVirmP+1recoE6OzC1nEGIzTb7EN5Jh
 zLETjBbxAXoaxKNh6ZaoJ7cKaAUAQ3gid432Y5U12Qe8nwcEjogGiyyKGF3DvUCtJfHj
 6srbmW7c5yCJ68W4u/Y+jxJyQlwJ+GrM6oME2mjPogszN6jgJbeZ/CYRRWEFokUO1pvU
 D6gIrdELB6mnku66AYkCgNaYVLV5vUDUvvILI4bnp3XZ912maUfcDLRNIuASPAJpLDrd
 eXAw1hjG2tLoS75Z94OjN52rGfOaI7Akhg3LLcHe0jrBLixro4gW0WFj2o5HbJmzEASn
 xPIw==
X-Gm-Message-State: AFuF++nRlMU4S/zac6fdgYrCdzylaxlPtzElpM5KW78NgykNXVQRQNb2
 SgxzLyAGijc4Hx3M2I3GbzITfsBegeuIDO0ks+WVJ+paalGIxdxQVPob01V5EP0fujSAk8PECt0
 WvneFsds=
X-Gm-Gg: AYBFou2o+5jmaSvefaz82SNlNZjsbs984MnKy2gpcJFSLfbMbFNcCKmeoX9v8ILH10C
 BjQcOyJBywr459IF8rfM1ymQ+BxhDILjro17huJejHvZQk5DhxmnpWYRXtSemREWtW8DWdbiptE
 eNgj4JifX4pGfuFp9OeZlKsnELPVQ4B6HFLH8TiTUaXqnpG4xzJMqC2xqUgm07PvPsUJldJxHd4
 A5mXaSdcEv7D3pBA5EoG0yrw+eAGDysjf9cDWsfwp6CjoB28ymVB65nd5bQ3QyboLrMyghTq968
 TZZpIItBVcXs6MnYrt/3NN8wXqQeQeHGVSTZWW9843r3Cu02xYf0M6i5TV/R4G2y98y4sg/Er31
 e9wvt2lduY/RVPyE4h+cWG6wUDRa2BNODbyVAXR7hbF5lpTbXRVxb4k8oL7TbukeiTOH81SgJlg
 ODM754sZUE/0sr4IMf/fgUFQtU4b+Bnpbw0+4g87eqdMj5ufXeM1VIVjiRwAf4kU59wtlxe+O2Q
 cORwtU=
X-Received: by 2002:a17:90b:4d0e:b0:39e:17b:a13d with SMTP id
 98e67ed59e1d1-39e1e539c36mr14248816a91.23.1789619314260; 
 Wed, 16 Sep 2026 21:28:34 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 007/101] tcg: Use QEMU_*_NONULL with all tcg_gen_*_ptr
Date: Wed, 16 Sep 2026 18:26:49 -1000
Message-ID: <20260917042823.542588-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1e826b62574..888f00d5f24 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -497,22 +497,22 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 
 /* Host pointer ops */
 
-TCGv_ptr tcg_constant_ptr_int(intptr_t x);
+QEMU_RET_NONNULL TCGv_ptr tcg_constant_ptr_int(intptr_t x);
 #define tcg_constant_ptr(X)  tcg_constant_ptr_int((intptr_t)(X))
 
-void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
-void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
+QEMU_ARG_NONNULL void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
+QEMU_ARG_NONNULL void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
 
-void tcg_gen_discard_ptr(TCGv_ptr a);
-void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
-void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
-void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
-void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
-void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
-                         intptr_t b, TCGLabel *label);
-void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a);
-void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a);
-void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a);
-void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a);
+QEMU_ARG_NONNULL void tcg_gen_discard_ptr(TCGv_ptr a);
+QEMU_ARG_NONNULL void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
+QEMU_ARG_NONNULL void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
+QEMU_ARG_NONNULL void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
+QEMU_ARG_NONNULL void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
+QEMU_ARG_NONNULL void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
+                                          intptr_t b, TCGLabel *label);
+QEMU_ARG_NONNULL void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a);
+QEMU_ARG_NONNULL void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a);
+QEMU_ARG_NONNULL void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a);
+QEMU_ARG_NONNULL void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a);
 
 #endif /* TCG_TCG_OP_COMMON_H */
-- 
2.53.0


