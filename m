Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D583C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeE8-0006QX-RX; Fri, 24 May 2024 19:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeE5-0006Mp-Im
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:29 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeE3-0005f7-78
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:29 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f44b4285dbso10941935ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592885; x=1717197685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+CSyQolXNlheFWl3qhhbqIiFKwE+QIiVDDbCmDvV50=;
 b=mHnrM+6isAPPSprFEvnP1SiDCphL522bU/U1h6YKCWKxShIfp4z7Y9q04ogRFzl9WL
 oGphCM7d8faDNyjDp85ZMbTcWqS98NXdktt4DbODiq4NqwTm21zdHMLIsV5kaVOtkDFQ
 ILzUWNb1gfEFQ97rza8cJmJT3+ZLylO0yRnVB/2Bb5S/slMmkbPE40F5U1eQ/npNcnvi
 gDf0O98hMpM8k70aBFc6p1Xy6oiP6LU5Dbf5KAG+lHPr2vfKRBNRA5K+ZC3TEn7z57mC
 LmsaAWcOcZc+/tvpMdXJ5KeG/NfyfAHyx4NVenURbX0cPllC0x7s9iqXvyWX1v9aV2yL
 OapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592885; x=1717197685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+CSyQolXNlheFWl3qhhbqIiFKwE+QIiVDDbCmDvV50=;
 b=wgEd7I7idI1B9EtlCy8s1TAv13suNeEi7pF6zXgUIgzbEerxotazY74lePuRdXUZEG
 IzqnYweZRLt5lFZqHvkm3b8lCebJ7VOMtKW8+Bnur8T9b/bOZOlkJbHK7WwegdZZErUe
 E+8p1H5TK/qcgbivQXcZILCsEzMOZ3UEc4cQnVFnBZHAyqeERp90Fk5EIPu9OKvlZLn/
 a/37piVVnMw3qxR+Dp+0UCBmmbkDpQ6ZIV5ail7h7qErRX8o8UrS0i+xxoVpNMrUyne4
 9+YZv8nv9AbWxee+AMi9ARYEQ13jP4WdAfKPxEc2OYe87inYNGo0jGrNPmCspOG9//gk
 f6Jw==
X-Gm-Message-State: AOJu0YxkcLxCZM7ijkrxgQ7ddkFuyoSGiDu7pNczsgIWWNMVu9TtQqpg
 1mqxBDg7bEjgt3tnhUSJZ2+11m/0gyQcy04Y4UYG4R9zTFjlxUJOV8Tty+tFptogfwgpm89i46N
 q
X-Google-Smtp-Source: AGHT+IEztbQprR+YdrFQyduiMBs6TN5/IVsdl8amdcHJaIcSlu8WLGzHiMv6Xn2f6IpJdoNolqrZbQ==
X-Received: by 2002:a17:902:d4c6:b0:1e2:a467:1b6b with SMTP id
 d9443c01a7336-1f4486d54b8mr40156295ad.16.1716592885414; 
 Fri, 24 May 2024 16:21:25 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 03/67] target/arm: Reject incorrect operands to PLD, PLDW,
 PLI
Date: Fri, 24 May 2024 16:20:17 -0700
Message-Id: <20240524232121.284515-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

For all, rm == 15 is invalid.
Prior to v8, thumb with rm == 13 is invalid.
For PLDW, rn == 15 is invalid.

Fixes a RISU mismatch for the HINTSPACE pattern in t32.risu
compared to a neoverse-n1 host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a32-uncond.decode |  8 +++--
 target/arm/tcg/t32.decode        |  7 ++--
 target/arm/tcg/translate.c       | 57 ++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 6 deletions(-)

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
index 187eacffd9..7c09153b6e 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -8775,6 +8775,63 @@ static bool trans_PLI(DisasContext *s, arg_PLI *a)
     return ENABLE_ARCH_7;
 }
 
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
+    /* We cannot return false, because that leads to LDRB for thumb. */
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
+     * For T1, rn == 15 is PLD (literal).
+     */
+    if (a->rn == 15) {
+        return false;
+    }
+    /* We cannot return false, because that leads to LDRH for thumb. */
+    if (!prefetch_check_m(s, a->rm)) {
+        unallocated_encoding(s);
+    }
+    return true;
+}
+
+static bool trans_PLI_rr(DisasContext *s, arg_PLI_rr *a)
+{
+    if (!ENABLE_ARCH_7) {
+        return false;
+    }
+    /* We cannot return false, because that leads to LDRSB for thumb. */
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


