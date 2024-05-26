Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D877DC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlx-0008Gn-DM; Sun, 26 May 2024 15:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlt-0008EX-2S
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:09 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlr-0007er-BE
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:08 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f47db642c2so5512735ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752585; x=1717357385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wUZMTv05nx5Don35neKlPDb72azGnDuXe1OnwMDjAQQ=;
 b=gIciHtMsUDK2vB3vvKyjjFHjHbI7U/6j+VoT+dmAR+VZBYnwDclIVZ909/jes/xSni
 rll6wW1e3Jv1u1b99YDCJS/IUzcSY/JhyM6JFNesoRfZyKU98qY26zf4nwZwax3pSwjt
 HFJj3Vz0UFhgjtH+N2zTebcoHUUXsBrZKe/cF9VEWtKkNiAaJFL+91JkieEB41gf5QE5
 FzxbBQAkOvoto142d7hHWaOsWCyP2m//2YfAXMq5rLP46QIpqINmMleulSvyMtdPgqqh
 326olhSxt1SMiwXdnYw4B/ISEcSFlo8hQCJftNYyGFizUFieKfxhi32jtx+oS3+4LfzU
 oang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752585; x=1717357385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wUZMTv05nx5Don35neKlPDb72azGnDuXe1OnwMDjAQQ=;
 b=nruj25DUTiCe76cHCaHNSuCGp5sHbcGz8vQZ5xfhEw9hUzBS1ks93IT5nQUV6wJCym
 909UzBVzSWzRbHYn+BUvPqNR/NI1UNZdlqB3M+WQ18Qh4Ck0vcRwlGNS3cBMtNlPHy19
 3CFF2qfhopnzfwL+XQpyaTm/V2cXVp7V8nknVA4Zr98JNA8AYkyr0BG3B+bfxKyHGu8f
 1VSEfrvslP4iSbQuM8sePgva9BCP2rUYMX9esoc9u5oAKRqcVhHkxDkPUIa4pOGSVCJS
 CWCAbQz3E5Z9Nq7hM0oZTRDPMyrQTcx2eiiav2F2qscXLLvhygToABzJPbbVDf9iWx3I
 kizA==
X-Gm-Message-State: AOJu0YxOkV6mVBkEDjxf8lb5JUC0B/Cqjd4gtUT4c5fA50swrHFEe4K3
 BpF7m19Tz9JZZWkUoAhHHEgoQxhO6RbJtjluifSwWjVjm4MmF9mNXIlqDb17p5aEZt+v2sZBn3U
 U
X-Google-Smtp-Source: AGHT+IH+yHsH5qrJOWYNX6UAFonjF/Vxo71zOtg7XlEvl25RlJf9fcWqfDFR7+JKYIGhWDl7gqvbhg==
X-Received: by 2002:a17:903:188:b0:1f3:487e:fbad with SMTP id
 d9443c01a7336-1f4498f2b06mr85457765ad.55.1716752584934; 
 Sun, 26 May 2024 12:43:04 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 12/37] target/sparc: Implement CMASK instructions
Date: Sun, 26 May 2024 12:42:29 -0700
Message-Id: <20240526194254.459395-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  3 +++
 target/sparc/insns.decode |  4 ++++
 target/sparc/translate.c  | 13 +++++++++++++
 target/sparc/vis_helper.c | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index f4d3311ac4..84435b0932 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -107,6 +107,9 @@ DEF_HELPER_FLAGS_2(fpack16, TCG_CALL_NO_RWG_SE, i32, i64, i64)
 DEF_HELPER_FLAGS_3(fpack32, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fpackfix, TCG_CALL_NO_RWG_SE, i32, i64, i64)
 DEF_HELPER_FLAGS_3(bshuffle, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_2(cmask8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(cmask16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(cmask32, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #define VIS_CMPHELPER(name)                                              \
     DEF_HELPER_FLAGS_2(f##name##16, TCG_CALL_NO_RWG_SE,      \
                        i64, i64, i64)                                    \
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5d1c55aa78..8be808d065 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -384,6 +384,10 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
 
     BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
 
+    CMASK8      10 00000 110110 00000 0 0001 1011 rs2:5
+    CMASK16     10 00000 110110 00000 0 0001 1101 rs2:5
+    CMASK32     10 00000 110110 00000 0 0001 1111 rs2:5
+
     FPCMPLE16   10 ..... 110110 ..... 0 0010 0000 .....    @r_d_d
     FPCMPNE16   10 ..... 110110 ..... 0 0010 0010 .....    @r_d_d
     FPCMPGT16   10 ..... 110110 ..... 0 0010 1000 .....    @r_d_d
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 40e245abdd..66c6fb6e41 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -61,6 +61,9 @@
 # define gen_helper_write_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_wrpil(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrpstate(E, S)              qemu_build_not_reached()
+# define gen_helper_cmask8               ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_cmask16              ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_cmask32              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq32             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpgt16             ({ qemu_build_not_reached(); NULL; })
@@ -3748,6 +3751,16 @@ static void gen_op_bmask(TCGv dst, TCGv s1, TCGv s2)
 
 TRANS(BMASK, VIS2, do_rrr, a, gen_op_bmask)
 
+static bool do_cmask(DisasContext *dc, int rs2, void (*func)(TCGv, TCGv, TCGv))
+{
+    func(cpu_gsr, cpu_gsr, gen_load_gpr(dc, rs2));
+    return true;
+}
+
+TRANS(CMASK8, VIS3, do_cmask, a->rs2, gen_helper_cmask8)
+TRANS(CMASK16, VIS3, do_cmask, a->rs2, gen_helper_cmask16)
+TRANS(CMASK32, VIS3, do_cmask, a->rs2, gen_helper_cmask32)
+
 static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
 {
     TCGv dst, src1, src2;
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 41312deda4..20baa4ff71 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -351,3 +351,41 @@ uint64_t helper_bshuffle(uint64_t gsr, uint64_t src1, uint64_t src2)
 
     return r.ll;
 }
+
+uint64_t helper_cmask8(uint64_t gsr, uint64_t src)
+{
+    uint32_t mask = 0;
+
+    mask |= (src & 0x01 ? 0x00000007 : 0x0000000f);
+    mask |= (src & 0x02 ? 0x00000060 : 0x000000e0);
+    mask |= (src & 0x04 ? 0x00000500 : 0x00000d00);
+    mask |= (src & 0x08 ? 0x00004000 : 0x0000c000);
+    mask |= (src & 0x10 ? 0x00030000 : 0x000b0000);
+    mask |= (src & 0x20 ? 0x00200000 : 0x00a00000);
+    mask |= (src & 0x40 ? 0x01000000 : 0x09000000);
+    mask |= (src & 0x80 ? 0x00000000 : 0x80000000);
+
+    return deposit64(gsr, 32, 32, mask);
+}
+
+uint64_t helper_cmask16(uint64_t gsr, uint64_t src)
+{
+    uint32_t mask = 0;
+
+    mask |= (src & 0x1 ? 0x00000067 : 0x000000ef);
+    mask |= (src & 0x2 ? 0x00004500 : 0x0000cd00);
+    mask |= (src & 0x4 ? 0x00230000 : 0x00ab0000);
+    mask |= (src & 0x8 ? 0x01000000 : 0x89000000);
+
+    return deposit64(gsr, 32, 32, mask);
+}
+
+uint64_t helper_cmask32(uint64_t gsr, uint64_t src)
+{
+    uint32_t mask = 0;
+
+    mask |= (src & 0x1 ? 0x00004567 : 0x0000cdef);
+    mask |= (src & 0x2 ? 0x01230000 : 0x89ab0000);
+
+    return deposit64(gsr, 32, 32, mask);
+}
-- 
2.34.1


