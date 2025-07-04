Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66397C83F0D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFY-0005S6-DR; Fri, 04 Jul 2025 12:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFF-0003FJ-Rm
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFD-0006sm-B6
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d54214adso7694285e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646394; x=1752251194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lIJhiRCR8HjwsIRcjeXNXOpA6NWPSbM7MJPUG4ggQaI=;
 b=CUxUbBKulEdKPLfEa3UadvmIGYzV5oHoNLr8t4oovOErFBJBqHUKRoYuP7whCC1Azf
 BLDUWvnRpVGfHfrN+jj+ErjbCp8NavMrnjH7jXOPvkuNzuTO4E2bP1IboRpqe1Py7gN7
 vQRHXaTh4z2REMzJm+NQ85vOFIdNhl8kXhy8FuPPtexLrAjbnDxt95MYCfWBdR6UNW13
 5RY71STMu34vIOc0nCZ09YpHFgt8MSriCe9uqHCPIWjZ8q32RizAEJe93MfaUbwHHyCO
 aI8Ar2OAKFL98E/YcZzPf3593ca68PNnOvEL4AMSA1G4EF5hAkeDycJJbFaZAOex7U1F
 F3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646394; x=1752251194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lIJhiRCR8HjwsIRcjeXNXOpA6NWPSbM7MJPUG4ggQaI=;
 b=v028JF0aMPJ9cWpSYWFQWrE1y7K4+G2FK6p6g4vdj2bDs+kPEoZyMW3A2MP7J9eyH+
 CR/zqhzkVlslygOJQ3yuloNrB77Vxq6ahqaIeX3ZNKL+pDczc5sM2yt9JjSnBuBS9IKh
 l4jwgROauTFhy5Wmy30RrsdlOS7M9EOBcs1fo9H+kA1WspHmw1DPPp1vHDaeNbkeVmRZ
 +M/EpA/S4fMtl2H65SMYWl3Z5e1gAyfxz5QXkg6b1A7oh64Xzhs6XB8ep/qzObRJ0VQE
 i1aNvQJG0gWxmlrZ5hiLoqH5LzGAQXppMRMvww7aeyqfdjmaFU+uX4pONUedEZYryI0P
 idmQ==
X-Gm-Message-State: AOJu0YzzBb8TfNTQj5845cdj9iVpP5hfb8L31Q1j0W/xpa7rKxBcuYnG
 ouXRTSXk4AlL3mL6rulToXwZf/HtmkWVCO7PkyEedd3Qb1M8A5KhB11cJVbMIdr4+5TyUcTMaX6
 DeLjZ
X-Gm-Gg: ASbGncuBqgAsdh4D1OvF0CcaWNzFkXIdpi6SQK1or2tnUiJGegVxeNW09lgqAtNfs4N
 R7W+tcLtlbfx86h323eMHjwd+SgunycuME+eo608k+2RF5uux46Z8ZsQq3RoqUNo1ZF6tX+2SAe
 Vd1oJpTHcBw9xK4gH8dwIhOb4K1T7g93Ajine3FbED/eJ6O5fP3PzQFcBeEffjtMo0c/bEVnImO
 AvUSMS2NelS9g5+ZfBLpBYme/5qTMIvKiik00QhB3UzUtOkuhUeLgpGSPr1/9J5RpUo1q7Tt5kH
 831gDZNJO9HaBErGTj/ZSLxzuDdTC9APWSsKN9GiH7zGEmQu0dBs3c2KN465+a7pT1X8
X-Google-Smtp-Source: AGHT+IGHAwWTHRsxjhLkp30nyUnIeTGyO12y5N5KCUVQQKo3mO1jhjPZ5i8ZtRgZJgeVODz4cpZNLw==
X-Received: by 2002:a05:600c:3b8e:b0:43d:fa58:700e with SMTP id
 5b1f17b1804b1-454b9872ebamr4202805e9.33.1751646393553; 
 Fri, 04 Jul 2025 09:26:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 095/119] target/arm: Implement SME2 SEL
Date: Fri,  4 Jul 2025 17:24:35 +0100
Message-ID: <20250704162501.249138-96-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-84-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |   5 +
 target/arm/tcg/sme.decode      |   9 +
 target/arm/tcg/sme_helper.c    | 317 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  31 ++++
 4 files changed, 362 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 78ba3d1f20b..467073ea258 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -313,3 +313,8 @@ DEF_HELPER_FLAGS_5(sme2_fclamp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i3
 DEF_HELPER_FLAGS_5(sme2_fclamp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme2_fclamp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme2_bfclamp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sme2_sel_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
+DEF_HELPER_FLAGS_5(sme2_sel_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
+DEF_HELPER_FLAGS_5(sme2_sel_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
+DEF_HELPER_FLAGS_5(sme2_sel_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index c4b85a36d0c..0a2ceea8bee 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -878,6 +878,15 @@ UCLAMP          11000001 esz:2 1 zm:5 110001 zn:5 .... 1    \
 UCLAMP          11000001 esz:2 1 zm:5 110011 zn:5 ...0 1    \
                 &zzz_en zd=%zd_ax4 n=4
 
+### SME2 Multi-vector SVE Select
+
+%sel_pg         10:3 !function=plus_8
+
+SEL             11000001 esz:2 1 ....0 100 ... ....0 ....0  \
+                n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2 pg=%sel_pg
+SEL             11000001 esz:2 1 ...01 100 ... ...00 ...00  \
+                n=4 zd=%zd_ax4 zn=%zn_ax4 zm=%zm_ax4 pg=%sel_pg
+
 ### SME Multiple Zero
 
 &zero_za        rv off ngrp nvec
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 8a1f9fbf3df..c1166e4ffa9 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2118,3 +2118,320 @@ FCLAMP(sme2_fclamp_d, float64, H8)
 FCLAMP(sme2_bfclamp, bfloat16, H2)
 
 #undef FCLAMP
+
+void HELPER(sme2_sel_b)(void *vd, void *vn, void *vm,
+                        uint32_t png, uint32_t desc)
+{
+    int vl = simd_oprsz(desc);
+    int nreg = simd_data(desc);
+    int elements = vl / sizeof(uint8_t);
+    DecodeCounter p = decode_counter(png, vl, MO_8);
+
+    if (p.lg2_stride == 0) {
+        if (p.invert) {
+            for (int r = 0; r < nreg; r++) {
+                uint8_t *d = vd + r * sizeof(ARMVectorReg);
+                uint8_t *n = vn + r * sizeof(ARMVectorReg);
+                uint8_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+
+                if (split <= 0) {
+                    memcpy(d, n, vl);  /* all true */
+                } else if (elements <= split) {
+                    memcpy(d, m, vl);  /* all false */
+                } else {
+                    for (int e = 0; e < split; e++) {
+                        d[H1(e)] = m[H1(e)];
+                    }
+                    for (int e = split; e < elements; e++) {
+                        d[H1(e)] = n[H1(e)];
+                    }
+                }
+            }
+        } else {
+            for (int r = 0; r < nreg; r++) {
+                uint8_t *d = vd + r * sizeof(ARMVectorReg);
+                uint8_t *n = vn + r * sizeof(ARMVectorReg);
+                uint8_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+
+                if (split <= 0) {
+                    memcpy(d, m, vl);  /* all false */
+                } else if (elements <= split) {
+                    memcpy(d, n, vl);  /* all true */
+                } else {
+                    for (int e = 0; e < split; e++) {
+                        d[H1(e)] = n[H1(e)];
+                    }
+                    for (int e = split; e < elements; e++) {
+                        d[H1(e)] = m[H1(e)];
+                    }
+                }
+            }
+        }
+    } else {
+        int estride = 1 << p.lg2_stride;
+        if (p.invert) {
+            for (int r = 0; r < nreg; r++) {
+                uint8_t *d = vd + r * sizeof(ARMVectorReg);
+                uint8_t *n = vn + r * sizeof(ARMVectorReg);
+                uint8_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+                int e = 0;
+
+                for (; e < MIN(split, elements); e++) {
+                    d[H1(e)] = m[H1(e)];
+                }
+                for (; e < elements; e += estride) {
+                    d[H1(e)] = n[H1(e)];
+                    for (int i = 1; i < estride; i++) {
+                        d[H1(e + i)] = m[H1(e + i)];
+                    }
+                }
+            }
+        } else {
+            for (int r = 0; r < nreg; r++) {
+                uint8_t *d = vd + r * sizeof(ARMVectorReg);
+                uint8_t *n = vn + r * sizeof(ARMVectorReg);
+                uint8_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+                int e = 0;
+
+                for (; e < MIN(split, elements); e += estride) {
+                    d[H1(e)] = n[H1(e)];
+                    for (int i = 1; i < estride; i++) {
+                        d[H1(e + i)] = m[H1(e + i)];
+                    }
+                }
+                for (; e < elements; e++) {
+                    d[H1(e)] = m[H1(e)];
+                }
+            }
+        }
+    }
+}
+
+void HELPER(sme2_sel_h)(void *vd, void *vn, void *vm,
+                        uint32_t png, uint32_t desc)
+{
+    int vl = simd_oprsz(desc);
+    int nreg = simd_data(desc);
+    int elements = vl / sizeof(uint16_t);
+    DecodeCounter p = decode_counter(png, vl, MO_16);
+
+    if (p.lg2_stride == 0) {
+        if (p.invert) {
+            for (int r = 0; r < nreg; r++) {
+                uint16_t *d = vd + r * sizeof(ARMVectorReg);
+                uint16_t *n = vn + r * sizeof(ARMVectorReg);
+                uint16_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+
+                if (split <= 0) {
+                    memcpy(d, n, vl);  /* all true */
+                } else if (elements <= split) {
+                    memcpy(d, m, vl);  /* all false */
+                } else {
+                    for (int e = 0; e < split; e++) {
+                        d[H2(e)] = m[H2(e)];
+                    }
+                    for (int e = split; e < elements; e++) {
+                        d[H2(e)] = n[H2(e)];
+                    }
+                }
+            }
+        } else {
+            for (int r = 0; r < nreg; r++) {
+                uint16_t *d = vd + r * sizeof(ARMVectorReg);
+                uint16_t *n = vn + r * sizeof(ARMVectorReg);
+                uint16_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+
+                if (split <= 0) {
+                    memcpy(d, m, vl);  /* all false */
+                } else if (elements <= split) {
+                    memcpy(d, n, vl);  /* all true */
+                } else {
+                    for (int e = 0; e < split; e++) {
+                        d[H2(e)] = n[H2(e)];
+                    }
+                    for (int e = split; e < elements; e++) {
+                        d[H2(e)] = m[H2(e)];
+                    }
+                }
+            }
+        }
+    } else {
+        int estride = 1 << p.lg2_stride;
+        if (p.invert) {
+            for (int r = 0; r < nreg; r++) {
+                uint16_t *d = vd + r * sizeof(ARMVectorReg);
+                uint16_t *n = vn + r * sizeof(ARMVectorReg);
+                uint16_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+                int e = 0;
+
+                for (; e < MIN(split, elements); e++) {
+                    d[H2(e)] = m[H2(e)];
+                }
+                for (; e < elements; e += estride) {
+                    d[H2(e)] = n[H2(e)];
+                    for (int i = 1; i < estride; i++) {
+                        d[H2(e + i)] = m[H2(e + i)];
+                    }
+                }
+            }
+        } else {
+            for (int r = 0; r < nreg; r++) {
+                uint16_t *d = vd + r * sizeof(ARMVectorReg);
+                uint16_t *n = vn + r * sizeof(ARMVectorReg);
+                uint16_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+                int e = 0;
+
+                for (; e < MIN(split, elements); e += estride) {
+                    d[H2(e)] = n[H2(e)];
+                    for (int i = 1; i < estride; i++) {
+                        d[H2(e + i)] = m[H2(e + i)];
+                    }
+                }
+                for (; e < elements; e++) {
+                    d[H2(e)] = m[H2(e)];
+                }
+            }
+        }
+    }
+}
+
+void HELPER(sme2_sel_s)(void *vd, void *vn, void *vm,
+                        uint32_t png, uint32_t desc)
+{
+    int vl = simd_oprsz(desc);
+    int nreg = simd_data(desc);
+    int elements = vl / sizeof(uint32_t);
+    DecodeCounter p = decode_counter(png, vl, MO_32);
+
+    if (p.lg2_stride == 0) {
+        if (p.invert) {
+            for (int r = 0; r < nreg; r++) {
+                uint32_t *d = vd + r * sizeof(ARMVectorReg);
+                uint32_t *n = vn + r * sizeof(ARMVectorReg);
+                uint32_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+
+                if (split <= 0) {
+                    memcpy(d, n, vl);  /* all true */
+                } else if (elements <= split) {
+                    memcpy(d, m, vl);  /* all false */
+                } else {
+                    for (int e = 0; e < split; e++) {
+                        d[H4(e)] = m[H4(e)];
+                    }
+                    for (int e = split; e < elements; e++) {
+                        d[H4(e)] = n[H4(e)];
+                    }
+                }
+            }
+        } else {
+            for (int r = 0; r < nreg; r++) {
+                uint32_t *d = vd + r * sizeof(ARMVectorReg);
+                uint32_t *n = vn + r * sizeof(ARMVectorReg);
+                uint32_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+
+                if (split <= 0) {
+                    memcpy(d, m, vl);  /* all false */
+                } else if (elements <= split) {
+                    memcpy(d, n, vl);  /* all true */
+                } else {
+                    for (int e = 0; e < split; e++) {
+                        d[H4(e)] = n[H4(e)];
+                    }
+                    for (int e = split; e < elements; e++) {
+                        d[H4(e)] = m[H4(e)];
+                    }
+                }
+            }
+        }
+    } else {
+        /* p.esz must be MO_64, so stride must be 2. */
+        if (p.invert) {
+            for (int r = 0; r < nreg; r++) {
+                uint32_t *d = vd + r * sizeof(ARMVectorReg);
+                uint32_t *n = vn + r * sizeof(ARMVectorReg);
+                uint32_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+                int e = 0;
+
+                for (; e < MIN(split, elements); e++) {
+                    d[H4(e)] = m[H4(e)];
+                }
+                for (; e < elements; e += 2) {
+                    d[H4(e)] = n[H4(e)];
+                    d[H4(e + 1)] = m[H4(e + 1)];
+                }
+            }
+        } else {
+            for (int r = 0; r < nreg; r++) {
+                uint32_t *d = vd + r * sizeof(ARMVectorReg);
+                uint32_t *n = vn + r * sizeof(ARMVectorReg);
+                uint32_t *m = vm + r * sizeof(ARMVectorReg);
+                int split = p.count - r * elements;
+                int e = 0;
+
+                for (; e < MIN(split, elements); e += 2) {
+                    d[H4(e)] = n[H4(e)];
+                    d[H4(e + 1)] = m[H4(e + 1)];
+                }
+                for (; e < elements; e++) {
+                    d[H4(e)] = m[H4(e)];
+                }
+            }
+        }
+    }
+}
+
+void HELPER(sme2_sel_d)(void *vd, void *vn, void *vm,
+                        uint32_t png, uint32_t desc)
+{
+    int vl = simd_oprsz(desc);
+    int nreg = simd_data(desc);
+    int elements = vl / sizeof(uint64_t);
+    DecodeCounter p = decode_counter(png, vl, MO_64);
+
+    if (p.invert) {
+        for (int r = 0; r < nreg; r++) {
+            uint64_t *d = vd + r * sizeof(ARMVectorReg);
+            uint64_t *n = vn + r * sizeof(ARMVectorReg);
+            uint64_t *m = vm + r * sizeof(ARMVectorReg);
+            int split = p.count - r * elements;
+
+            if (split <= 0) {
+                memcpy(d, n, vl);  /* all true */
+            } else if (elements <= split) {
+                memcpy(d, m, vl);  /* all false */
+            } else {
+                memcpy(d, m, split * sizeof(uint64_t));
+                memcpy(d + split, n + split,
+                       (elements - split) * sizeof(uint64_t));
+            }
+        }
+    } else {
+        for (int r = 0; r < nreg; r++) {
+            uint64_t *d = vd + r * sizeof(ARMVectorReg);
+            uint64_t *n = vn + r * sizeof(ARMVectorReg);
+            uint64_t *m = vm + r * sizeof(ARMVectorReg);
+            int split = p.count - r * elements;
+
+            if (split <= 0) {
+                memcpy(d, m, vl);  /* all false */
+            } else if (elements <= split) {
+                memcpy(d, n, vl);  /* all true */
+            } else {
+                memcpy(d, n, split * sizeof(uint64_t));
+                memcpy(d + split, m + split,
+                       (elements - split) * sizeof(uint64_t));
+            }
+        }
+    }
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b6316ac716c..74075971772 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1642,3 +1642,34 @@ static gen_helper_gvec_3 * const uclamp_fns[] = {
     gen_helper_sme2_uclamp_d,
 };
 TRANS(UCLAMP, do_clamp, a, uclamp_fns)
+
+static bool trans_SEL(DisasContext *s, arg_SEL *a)
+{
+    typedef void sme_sel_fn(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32, TCGv_i32);
+    static sme_sel_fn * const fns[4] = {
+        gen_helper_sme2_sel_b, gen_helper_sme2_sel_h,
+        gen_helper_sme2_sel_s, gen_helper_sme2_sel_d
+    };
+
+    if (!dc_isar_feature(aa64_sme2, s)) {
+        return false;
+    }
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        uint32_t desc = simd_desc(svl, svl, a->n);
+        TCGv_ptr t_d = tcg_temp_new_ptr();
+        TCGv_ptr t_n = tcg_temp_new_ptr();
+        TCGv_ptr t_m = tcg_temp_new_ptr();
+        TCGv_i32 png = tcg_temp_new_i32();
+
+        tcg_gen_addi_ptr(t_d, tcg_env, vec_full_reg_offset(s, a->zd));
+        tcg_gen_addi_ptr(t_n, tcg_env, vec_full_reg_offset(s, a->zn));
+        tcg_gen_addi_ptr(t_m, tcg_env, vec_full_reg_offset(s, a->zm));
+
+        tcg_gen_ld16u_i32(png, tcg_env, pred_full_reg_offset(s, a->pg)
+                          ^ (HOST_BIG_ENDIAN ? 6 : 0));
+
+        fns[a->esz](t_d, t_n, t_m, png, tcg_constant_i32(desc));
+    }
+    return true;
+}
-- 
2.43.0


