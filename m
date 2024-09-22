Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A62CF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLIh-0006QB-Aq; Sun, 22 Sep 2024 08:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHP-0000x4-UG
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:37 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHL-0002OM-E2
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:30 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8d2b24b7a8so819669666b.1
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006484; x=1727611284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9b9mkCmXoU5+lAS1nKxmD/0m8Y1rJXywU6UvSKpWek=;
 b=r3y6a0TjGHVGIipnr5sR+urqGNJ5a0gwYf5cm+R5APLqUTsHmoSLw7Oknly+oZVJ6O
 wUrKGUpNbTikGdmN5nRPP2VAQlzLpZcSfs+Pbc5WEOoGNj5iC6xCLLc0dJPb/cuP/Bca
 76spWFrrXXGFzYXYXcS01wnovkaEnpcK5dmgm6x33krChHf9xZ8UeJM8L5wpnRqXZ+vq
 YGDufPicS1B2oqMaDB6yqCxTyARSOvi1N8/W9wM21YG+lqvJQX+hYZDCdkbNvA/cczqj
 w/V2AQf+ZfR9ryfQrutARyEV6gxEH7iCypaXygB1OkqLeEGAZnlu6J0DGhWe6ucVRLwz
 GU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006484; x=1727611284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9b9mkCmXoU5+lAS1nKxmD/0m8Y1rJXywU6UvSKpWek=;
 b=p5Z9CD2whpo0CREm1v/shb+hzfSt5bPmgFOgPlqhRU7DtecTlFKMSkr0i/Th8dPB55
 BmIkP4LH/11QGrCDmrb9hggpSxwwCoVBVk8Bjd+iyd8uB0rM/N6o77SS2t9a0OOLSK9C
 feorNDL0uIQsoIVya9RWjYBkQDDVyKWDDg9jnAIdAQY3u9UBkTAOyZDIyv8wXuVl5WhS
 5WzrvHzpNI9+WB8ovrcL5evqUlFA/GR3FtUaJ+R2uzzwn+tk3PtnVB2eDmvjo9sS7e+B
 /w1N4gTrokhNx4P/G1NQtVk/uB7EaDIWf9AFJNYyBQLKYWUxGOuwPpAh95P/Ho9OJg4N
 F6iw==
X-Gm-Message-State: AOJu0Yxs2fjbp/1g4rr2pixCzme3CDONlp1eYpVOpVOwKpRmaVq8fpmm
 P+sqmzxFami8t9pCbk1dvigXutYZE7WfW1FLVMf9tInTdbx/e7jRoOWD/dSvDCoWgEuTaEBoGRL
 HvCE=
X-Google-Smtp-Source: AGHT+IGlkjgMyzWwCWPUIjkMLMzMPeUfQ4WPNX1M0YWEqd6TBsmR9ZMb6s9TvAXD2u4ADiBafjQP/Q==
X-Received: by 2002:a17:907:3ea8:b0:a8d:2281:94d9 with SMTP id
 a640c23a62f3a-a90c1d6f9c0mr1456848866b.23.1727006484029; 
 Sun, 22 Sep 2024 05:01:24 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/31] tcg/i386: Implement vector TST{EQ,NE} for avx512
Date: Sun, 22 Sep 2024 14:00:58 +0200
Message-ID: <20240922120112.5067-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x634.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.c.inc | 31 ++++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 342be30c4c..c68ac023d8 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -224,7 +224,7 @@ typedef enum {
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       have_avx512vl
 #define TCG_TARGET_HAS_cmpsel_vec       1
-#define TCG_TARGET_HAS_tst_vec          0
+#define TCG_TARGET_HAS_tst_vec          have_avx512bw
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d473dc7a5e..1bf50f1f62 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -462,6 +462,14 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_VPSRLVD     (0x45 | P_EXT38 | P_DATA16)
 #define OPC_VPSRLVQ     (0x45 | P_EXT38 | P_DATA16 | P_VEXW)
 #define OPC_VPTERNLOGQ  (0x25 | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPTESTMB    (0x26 | P_EXT38 | P_DATA16 | P_EVEX)
+#define OPC_VPTESTMW    (0x26 | P_EXT38 | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPTESTMD    (0x27 | P_EXT38 | P_DATA16 | P_EVEX)
+#define OPC_VPTESTMQ    (0x27 | P_EXT38 | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPTESTNMB   (0x26 | P_EXT38 | P_SIMDF3 | P_EVEX)
+#define OPC_VPTESTNMW   (0x26 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
+#define OPC_VPTESTNMD   (0x27 | P_EXT38 | P_SIMDF3 | P_EVEX)
+#define OPC_VPTESTNMQ   (0x27 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
 #define OPC_VZEROUPPER  (0x77 | P_EXT)
 #define OPC_XCHG_ax_r32	(0x90)
 #define OPC_XCHG_EvGv   (0x87)
@@ -3145,6 +3153,13 @@ static void tcg_out_cmp_vec_k1(TCGContext *s, TCGType type, unsigned vece,
         { OPC_VPCMPB, OPC_VPCMPW, OPC_VPCMPD, OPC_VPCMPQ },
         { OPC_VPCMPUB, OPC_VPCMPUW, OPC_VPCMPUD, OPC_VPCMPUQ }
     };
+    static const int testm_insn[4] = {
+        OPC_VPTESTMB, OPC_VPTESTMW, OPC_VPTESTMD, OPC_VPTESTMQ
+    };
+    static const int testnm_insn[4] = {
+        OPC_VPTESTNMB, OPC_VPTESTNMW, OPC_VPTESTNMD, OPC_VPTESTNMQ
+    };
+
     static const int cond_ext[16] = {
         [TCG_COND_EQ] = 0,
         [TCG_COND_NE] = 4,
@@ -3160,9 +3175,19 @@ static void tcg_out_cmp_vec_k1(TCGContext *s, TCGType type, unsigned vece,
         [TCG_COND_ALWAYS] = 7,
     };
 
-    tcg_out_vex_modrm_type(s, cmpm_insn[is_unsigned_cond(cond)][vece],
-                           /* k1 */ 1, v1, v2, type);
-    tcg_out8(s, cond_ext[cond]);
+    switch (cond) {
+    case TCG_COND_TSTNE:
+        tcg_out_vex_modrm_type(s, testm_insn[vece], /* k1 */ 1, v1, v2, type);
+        break;
+    case TCG_COND_TSTEQ:
+        tcg_out_vex_modrm_type(s, testnm_insn[vece], /* k1 */ 1, v1, v2, type);
+        break;
+    default:
+        tcg_out_vex_modrm_type(s, cmpm_insn[is_unsigned_cond(cond)][vece],
+                               /* k1 */ 1, v1, v2, type);
+        tcg_out8(s, cond_ext[cond]);
+        break;
+    }
 }
 
 static void tcg_out_k1_to_vec(TCGContext *s, TCGType type,
-- 
2.43.0


