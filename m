Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B6BC369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8REM-0002u1-C4; Fri, 25 Apr 2025 18:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAz-0003iR-IG
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:45 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAx-0001st-Pv
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:41 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so2758857b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618738; x=1746223538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrBCsIJgWKGCpaAsMFDooeM8W+Z2wqYDVyB0/xDhg7c=;
 b=BVr2N3XRFRAWz+zavJ8cT6qgBFmM+WmYrKeBhIriwRLImqYGCUGIEJDEKLEAUO3tDP
 H/4hTPvWPyjYCdxHGhiMh3dBhuTOtb+oiirFC7TypErn+i5IDLlYW+jvakcCSICMH6uD
 CZSMTauITWm1s/dNvSrW8WKIx8IMkWkpe4Gk77OOKFnm4O5SPmgCAeXjki6hiV5YGLW+
 0u4mfN78XlyhvTOgLWi4e6o1P5L1DTU/G0C93v6cuzKDOhKuEDM8lDWfEcFp5TfCLG2V
 x1rQ4Pl5i3Drh24t9sU94NL/SYpDdlC1QimLYEfWQbN88KSquIjeAj7z4W0AnNi99/XW
 j2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618738; x=1746223538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BrBCsIJgWKGCpaAsMFDooeM8W+Z2wqYDVyB0/xDhg7c=;
 b=QeBVn98oapHQHh6ep0/j/kn6rLnIoMsazs99PXh2luym6ESl6JsLpCogBd/gl3tTjE
 9A3+zwlCnS4zY8jP79IX4Tkxu/TJZjWXb0uQUZff4IY/q6UDrH7xyskMc2MZmNFANnOJ
 rn7Qhy2xx89dLJxhPVuUukxgZ2HBI869xrnRe8oFkEq2OCDGFmwmLRSXcJPWVCsLHoMC
 KxEM778Yg4fZ5AbXPM2jBHx0XNE3LYru2rKVqYjkJXRGAcOJuRQ7TiHmPspOWDEGxqXt
 Shdtq8SUnn0JqbB8GuFDD9vj3X8/ncPYTfgUej3FogjHHHVTikYigp7uwLHizfaRUF75
 VXow==
X-Gm-Message-State: AOJu0YxCAcagzVrzHOGpU23bJ99QRNqKXiwWkcFrjpGqYoLv2Z3puyyn
 QtGloHf0h1mNZUVRAjkkmqgGs8/sFMv5ci/DRm3FVE+ONV+g++wRY9F0/6W730BxQjVK8QWM03h
 S
X-Gm-Gg: ASbGncslmjPjW6KfPSwmx/xoQlI9Iy/jHjzbQKhgTiQlRvdURq1/HofdLJpPzvVl/A6
 gsAg36VtpAb7T/Wj9K7uMVGvwLc3VvxonrIEeNLF4VJEkSOjV4jURmJSwMFDvAnVG/2WPF82PjJ
 pPc0j7aXfitaGQL+MwQvfLkJCV2GcLO67nHV6vGKaofpiHcWhtk1j6iFcN7Vbzn1p7l2WQvQtnA
 +NMdnZa8sxpZ8MMsKh6IZJKqEr6uD2XShtOWLESzdOO2ZSyeP6yzH5bzhTfX2rJptnFGTuvRPHo
 OajGHPjo34CFEnb2kDPuKDfKraEauH0Cuoux0kuoh9mfuOu6rVv9fzpw01rL3m7hVPTSd4oXUAc
 =
X-Google-Smtp-Source: AGHT+IG9MhhbG3uv8kQVqCa8lzMoI0Q/AuxP+L59yu47jFpHjBMvL7zjrs40NJXFCq3Ik/Dv5ssTBQ==
X-Received: by 2002:a05:6a00:1481:b0:736:42a8:a742 with SMTP id
 d2e1a72fcca58-73ff72e237amr1363009b3a.11.1745618738400; 
 Fri, 25 Apr 2025 15:05:38 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 140/159] tcg/s390x: Add TCG_CT_CONST_N32
Date: Fri, 25 Apr 2025 14:54:34 -0700
Message-ID: <20250425215454.886111-141-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

We were using S32 | U32 for add2/sub2.  But the ALGFI and SLGFI
insns that implement this both have uint32_t immediates.
This makes the composite range balanced and
enables use of -0xffffffff ... -0x80000001.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-con-set.h | 2 +-
 tcg/s390x/tcg-target-con-str.h | 1 +
 tcg/s390x/tcg-target.c.inc     | 8 ++++++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index 78f06e3e52..f5d3878070 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -44,4 +44,4 @@ C_O2_I2(o, m, 0, r)
 C_O2_I2(o, m, r, r)
 C_O2_I3(o, m, 0, 1, r)
 C_N1_O1_I4(r, r, 0, 1, ri, r)
-C_N1_O1_I4(r, r, 0, 1, rJU, r)
+C_N1_O1_I4(r, r, 0, 1, rUV, r)
diff --git a/tcg/s390x/tcg-target-con-str.h b/tcg/s390x/tcg-target-con-str.h
index 3e574e0662..636a38a168 100644
--- a/tcg/s390x/tcg-target-con-str.h
+++ b/tcg/s390x/tcg-target-con-str.h
@@ -24,4 +24,5 @@ CONST('M', TCG_CT_CONST_M1)
 CONST('N', TCG_CT_CONST_INV)
 CONST('R', TCG_CT_CONST_INVRISBG)
 CONST('U', TCG_CT_CONST_U32)
+CONST('V', TCG_CT_CONST_N32)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index e262876614..9b28083945 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -43,6 +43,7 @@
 #define TCG_CT_CONST_INVRISBG   (1 << 14)
 #define TCG_CT_CONST_CMP        (1 << 15)
 #define TCG_CT_CONST_M1         (1 << 16)
+#define TCG_CT_CONST_N32        (1 << 17)
 
 #define ALL_GENERAL_REGS     MAKE_64BIT_MASK(0, 16)
 #define ALL_VECTOR_REGS      MAKE_64BIT_MASK(32, 32)
@@ -613,7 +614,10 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_S32) && val == (int32_t)val) {
         return true;
     }
-    if ((ct & TCG_CT_CONST_U32) && val == (uint32_t)val) {
+    if ((ct & TCG_CT_CONST_U32) && uval <= UINT32_MAX) {
+        return true;
+    }
+    if ((ct & TCG_CT_CONST_N32) && -uval <= UINT32_MAX) {
         return true;
     }
     if ((ct & TCG_CT_CONST_S16) && val == (int16_t)val) {
@@ -3548,7 +3552,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i64:
-        return C_N1_O1_I4(r, r, 0, 1, rJU, r);
+        return C_N1_O1_I4(r, r, 0, 1, rUV, r);
 
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
-- 
2.43.0


