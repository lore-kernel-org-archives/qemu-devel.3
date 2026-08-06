Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA544C56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws1wM-0004on-Qt; Thu, 06 Aug 2026 13:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1wL-0004nR-Do
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:31:33 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1wJ-0001gs-6W
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:31:33 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso3020160a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786037490; x=1786642290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sF6vo6buf2buHSJtaG2kN2rWhatR3Lo0cYJzfphOzAc=;
 b=i2s94HipVOho1WbYlVPsNDlS/cUQUCAQn+0qmhUEF05sLkK5r18XMpekDFPeVzYxRT
 +qjK9Cuj2qfA5mgw+Fli3KoexhLv405SCJB8AAC/s2/FA967PrQcDk59MOCGBLeShii9
 4NcNdAS+G6kYAgvgqhZv5Gkru+tx+VK+4v1EcKYpOyMn1OZYMeJWocdmpTRollHeeJJy
 DoK92ox3F2wMK5XMaK53M72WjzsDb/oShNhVvaLQLmbQ++znLVSwgNnArINQz2PlqzPO
 Hp5dPLR2OAEjF4WXAsKPoa0suaDkivOKiZddhCv3wFMIoOOgH3VhNFuDZBsp9YxydMic
 TSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037490; x=1786642290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sF6vo6buf2buHSJtaG2kN2rWhatR3Lo0cYJzfphOzAc=;
 b=Pur0LdzMRRDTMhq3m1l23xkxc+HlRjFgExvWIju0ngR/KTkI9A6FJXBuqatN/yDuMX
 5bNv9Uq9W9efDr7F1LumoKl7fOwzbMRamSHqr1jcP3zAwDwfBd3vVv8q/MLqH96GmLHj
 6wJ6E1N/ptPofNxfHyWDHpsqq9Pd/QQYCJofl0UrL5gA1rNNy9nl2TG1ytdrWgH+G0pw
 HZF9jwReQaovT7K9yIj29ybJxIiX2Ygnai2fza8w6ymTA3fqRsg7dDadVzQ9pwDVC3ug
 N2DOGz5OsbiA0HTzC01k0Rl3YgVoADQ0akJBgASJ4bm4Pll1SWhIpYsDpIFaDkWJeX9O
 Jr5w==
X-Gm-Message-State: AOJu0Yy4MPR6p7a1Rof28bcLyDW3VWhDq3jXLcDLymMpBcAHQQQk3Dp8
 mIVTfbKVzBdUY0xoLq21jy3V/Fg6QWYdTMlT5CQbOaeylAhZn6sgDmruTqJur7gRsMLjK+ebl0k
 Wel9H
X-Gm-Gg: AR+sD123bXCHVfQoyf26RdVuQYI3p1Mb5wgj/mygN9uChGg6Z4p0p46bBb3xOWoYFAa
 wDi90paxjz4c+yW/9lC6qy7dG/y4SfdF9s3Sm5a6K4gZBHPqHMinJByTRiwBIvShQLvyPGxBPVc
 E6GKxNcaoVL0/T6mG4dEmI2QdTtfmHdyvybpFVX3+NExikhvv5Il+fA2AZaGY3+wnKW+UA1D4VM
 1p1+I8/aWR6lNEciYAyRYHEYDB9WszjCz5jNaDQkwasKTaVwNOj4NmvvbOiWYkdiE6ezEsLZT58
 geB8m79kv2LmfauXHJlEcRuf1I1PqKVfKp74RrDrDXyyDdcLZKLInh7NaUjpXeVktVLkHwu7KqK
 x6r+LOhI9277WmKCO5hYFjI4p3rTNOIqgZpr/oB3LSqIufGd5t5jNL6b788pfyyQz/LhPkgR+8S
 WmqjZLFnJ6vbBYf40V0a1768ltV2kRBC0G6jU95JFO+PCgcCfaOZSDNQZoxssZZBVldTS1TOmyz
 dxqhskEOT21G6QnEYCi
X-Received: by 2002:a17:90b:1dc4:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-3903c537808mr17786572a91.8.1786037489679; 
 Thu, 06 Aug 2026 10:31:29 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085e4a2a5sm1983711a91.14.2026.08.06.10.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:31:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 6/6] target/arm: Enable FEAT_IDTE3 for -cpu max
Date: Thu,  6 Aug 2026 10:31:23 -0700
Message-ID: <20260806173123.333423-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806173123.333423-1-richard.henderson@linaro.org>
References: <20260806173123.333423-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 4b9d01420a..e46d9f71c4 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1456,6 +1456,10 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* v9.2: FEAT_FPMR */
     SET_IDREG(isar, ID_AA64PFR2, t);
 
+    t = GET_IDREG(isar, ID_AA64MMFR2);
+    t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 2);      /* v9.0: FEAT_IDTE3 */
+    SET_IDREG(isar, ID_AA64MMFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR3);
     t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);      /* v9.2: FEAT_MEC */
     SET_IDREG(isar, ID_AA64MMFR3, t);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 392db5ccf9..bb1a8da002 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -105,6 +105,7 @@ the following architecture extensions:
 - FEAT_HPMN0 (Setting of MDCR_EL2.HPMN to zero)
 - FEAT_I8MM (AArch64 Int8 matrix multiplication instructions)
 - FEAT_IDST (ID space trap handling)
+- FEAT_IDTE3 (Trapping ID register accesses to EL3)
 - FEAT_IESB (Implicit error synchronization event)
 - FEAT_IVIPT (The IVIPT Extension)
 - FEAT_JSCVT (JavaScript conversion instructions)
-- 
2.43.0


