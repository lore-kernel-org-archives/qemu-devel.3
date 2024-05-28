Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAB0C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3TW-0002v3-Qy; Tue, 28 May 2024 16:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TK-0002nO-Hi
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:03 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3T9-0003ZE-VC
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:00 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f8e98784b3so943111b3a.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928247; x=1717533047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MchPVAymmY5yNkN81n4CDKNHDxrfiZwJmhq2h//dOuw=;
 b=CGaf23lPMgnY/4e/1DFquk3rt0Gp5wlbkQtuvsb06Fkb23W9Vp8ldIbZwQX5fDXBaP
 o9/fyWm5kWLUU1ZIeBZ9s1fGMAPsvADumROhr08eJD2Ed9dxqrk8LQo71bVgTpuPzuWN
 yS0T7yamIzSBtO/60hYXZDl6HmXH8XmzGrtUZaJfE0wN8n9zTPtWtjeddh7lkw0OIKk9
 RVv8rIyU1tnpHqNty5ZupF6SallqXzeXEKAyxIZ/kbrVMVxCF/v1mjGw73sxZWFqvXl5
 LvNAZepu0lYbLGvFT7YKI3VWxNf+w+QNSDnzokzQwX15WKxd/T1tOV1QDD8nTBCjOHNI
 4IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928247; x=1717533047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MchPVAymmY5yNkN81n4CDKNHDxrfiZwJmhq2h//dOuw=;
 b=Hy19FFHRVmwYE3jWtkqZhBZxa8+sMJc3CumO4fN02vBMpWItrZiwfRwN7IrN2xoaHw
 WgRS8iCvJvxiFzfkgo19lBJG6KDQIxIpF4moMQLSCrXbz7ye9BccugPv5n624n8/9s8T
 V0ISgzd6wBUAql34+IbSSis/IevgBPn+KJquPq6W7sJrrZVPILKSkNFUxiFFIHVCTiav
 TGjEr2xPv9sebNPmbgDeidkmG+zvUlbJIcR0kUM2pNadNAZqg7v45nZ0SZBx1YrUcXw6
 Zm+pLfMmKX7to3/zd3MBkGKF8Mg8h4EbirsQCc+Djq7qiFkh9h1VFUw6d4edlURxWX4l
 UCTQ==
X-Gm-Message-State: AOJu0Ywc1h/MOztpp1JwcIkcgsJ5LKwa9TgPDrlFtEbcgSlMFv06Tezz
 ckpI0J1lyvmtN/jp8sOd5Qq0TsVCRGeD5T/NdqlI+BlFtB9VMgk4cpYE4gIy4lDZVdvJEz3NYqs
 y
X-Google-Smtp-Source: AGHT+IEG6EJmL3UNz6nvocA8z0jc592RY6qnTltZkUD2d6AojPSEKctusrbtKkw/bXPmUBbvaI0qrA==
X-Received: by 2002:a05:6a21:7794:b0:1ad:7bfd:54a1 with SMTP id
 adf61e73a8af0-1b212dada23mr12593803637.17.1716928246741; 
 Tue, 28 May 2024 13:30:46 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:30:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 01/33] target/arm: Diagnose UNPREDICTABLE operands to PLD,
 PLDW, PLI
Date: Tue, 28 May 2024 13:30:12 -0700
Message-Id: <20240528203044.612851-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

For all, rm == 15 is UNPREDICTABLE.
Prior to v8, thumb with rm == 13 is UNPREDICTABLE.
For PLDW, rn == 15 is UNPREDICTABLE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a32-uncond.decode |  8 +++--
 target/arm/tcg/t32.decode        |  7 ++--
 target/arm/tcg/translate.c       | 58 ++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/a32-uncond.decode b/target/arm/tcg/a32-uncond.decode
index 2339de2e94..e1b1780d37 100644
--- a/target/arm/tcg/a32-uncond.decode
+++ b/target/arm/tcg/a32-uncond.decode
@@ -24,7 +24,9 @@
 
 &empty           !extern
 &i               !extern imm
+&r               !extern rm
 &setend          E
+&nm              rn rm
 
 # Branch with Link and Exchange
 
@@ -61,9 +63,9 @@ PLD              1111 0101 -101 ---- 1111 ---- ---- ----    # (imm, lit) 5te
 PLDW             1111 0101 -001 ---- 1111 ---- ---- ----    # (imm, lit) 7mp
 PLI              1111 0100 -101 ---- 1111 ---- ---- ----    # (imm, lit) 7
 
-PLD              1111 0111 -101 ---- 1111 ----- -- 0 ----   # (register) 5te
-PLDW             1111 0111 -001 ---- 1111 ----- -- 0 ----   # (register) 7mp
-PLI              1111 0110 -101 ---- 1111 ----- -- 0 ----   # (register) 7
+PLD_rr           1111 0111 -101 ---- 1111 ----- -- 0 rm:4   &r
+PLDW_rr          1111 0111 -001 rn:4 1111 ----- -- 0 rm:4   &nm
+PLI_rr           1111 0110 -101 ---- 1111 ----- -- 0 rm:4   &r
 
 # Unallocated memory hints
 #
diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
index d327178829..1ec12442a4 100644
--- a/target/arm/tcg/t32.decode
+++ b/target/arm/tcg/t32.decode
@@ -28,6 +28,7 @@
 &rrr_rot         !extern rd rn rm rot
 &rrr             !extern rd rn rm
 &rr              !extern rd rm
+&nm              !extern rn rm
 &ri              !extern rd imm
 &r               !extern rm
 &i               !extern imm
@@ -472,7 +473,7 @@ STR_ri           1111 1000 1100 .... .... ............        @ldst_ri_pos
   }
   LDRBT_ri       1111 1000 0001 .... .... 1110 ........       @ldst_ri_unp
   {
-    PLD          1111 1000 0001 ---- 1111 000000 -- ----      # (register)
+    PLD_rr       1111 1000 0001 ---- 1111 000000 -- rm:4      &r
     LDRB_rr      1111 1000 0001 .... .... 000000 .. ....      @ldst_rr
   }
 }
@@ -492,7 +493,7 @@ STR_ri           1111 1000 1100 .... .... ............        @ldst_ri_pos
   }
   LDRHT_ri       1111 1000 0011 .... .... 1110 ........       @ldst_ri_unp
   {
-    PLDW         1111 1000 0011 ---- 1111 000000 -- ----      # (register)
+    PLDW_rr      1111 1000 0011 rn:4 1111 000000 -- rm:4      &nm
     LDRH_rr      1111 1000 0011 .... .... 000000 .. ....      @ldst_rr
   }
 }
@@ -520,7 +521,7 @@ STR_ri           1111 1000 1100 .... .... ............        @ldst_ri_pos
   }
   LDRSBT_ri      1111 1001 0001 .... .... 1110 ........       @ldst_ri_unp
   {
-    PLI          1111 1001 0001 ---- 1111 000000 -- ----      # (register)
+    PLI_rr       1111 1001 0001 ---- 1111 000000 -- rm:4      &r
     LDRSB_rr     1111 1001 0001 .... .... 000000 .. ....      @ldst_rr
   }
 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c5bc691d92..16b8609ec0 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -7187,6 +7187,64 @@ static bool trans_PLI(DisasContext *s, arg_PLI *a)
     return ENABLE_ARCH_7;
 }
 
+/* Check for UNPREDICTABLE rm for prefetch (register). */
+static bool prefetch_check_m(DisasContext *s, int rm)
+{
+    switch (rm) {
+    case 13:
+        /* SP allowed in v8 or with A1 encoding; rejected with T1. */
+        return ENABLE_ARCH_8 || !s->thumb;
+    case 15:
+        /* PC always rejected. */
+        return false;
+    default:
+        return true;
+    }
+}
+
+static bool trans_PLD_rr(DisasContext *s, arg_PLD_rr *a)
+{
+    if (!ENABLE_ARCH_5TE) {
+        return false;
+    }
+    /* Choose UNDEF for UNPREDICTABLE rm. */
+    if (!prefetch_check_m(s, a->rm)) {
+        unallocated_encoding(s);
+    }
+    return true;
+}
+
+static bool trans_PLDW_rr(DisasContext *s, arg_PLDW_rr *a)
+{
+    if (!arm_dc_feature(s, ARM_FEATURE_V7MP)) {
+        return false;
+    }
+    /*
+     * For A1, rn == 15 is UNPREDICTABLE.
+     * For T1, rn == 15 is PLD (literal), and already matched.
+     * Choose UNDEF for UNPREDICTABLE rn or rm.
+     */
+    if (a->rn == 15) {
+        assert(!s->thumb);
+    } else if (prefetch_check_m(s, a->rm)) {
+        return true;
+    }
+    unallocated_encoding(s);
+    return true;
+}
+
+static bool trans_PLI_rr(DisasContext *s, arg_PLI_rr *a)
+{
+    if (!ENABLE_ARCH_7) {
+        return false;
+    }
+    /* Choose UNDEF for UNPREDICTABLE rm. */
+    if (!prefetch_check_m(s, a->rm)) {
+        unallocated_encoding(s);
+    }
+    return true;
+}
+
 /*
  * If-then
  */
-- 
2.34.1


