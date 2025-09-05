Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C6FCA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 05:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuOrX-0002jI-Le; Fri, 05 Sep 2025 01:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuOrT-0002iS-VX
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 01:19:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuOrQ-0006uF-BX
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 01:19:47 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b7d485173so11607585e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 22:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757049580; x=1757654380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Q0To23hpXEvW6Mrfa1LxQN66jwPz0EI7k2HbJO2kUs=;
 b=EJn0yhnGZ94IlNW2754osm3Du6U+Pj16VqjUA9RAysd/Llf74jRPX2nmfqUigdABtY
 IW6qyQWiF8SZzE7LRohZGTZnRiG6sfyt2RlEleChCSVdSz/y079nTGFLWJauawvlEu1V
 8g8X6vEUx8nuZ9x1vI8h2+MfIMiYZSeYDUBODnxSr+dG4Jqzr7ZZyn3P9EJvbPcTYO1Y
 Wa8oZF0R8u8cbwIi13Y3xVXXAMPiX+6iNfnI4DTOrzNyPd6IUC5/CU1JKUZpmSUcwNis
 K/VxfLAEFJ5IA0k1eh/cPSXrgnwMjI3VchhTs/ezy+pjcdaQiAocIRveMKE6TQmRr1Nq
 u/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757049580; x=1757654380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Q0To23hpXEvW6Mrfa1LxQN66jwPz0EI7k2HbJO2kUs=;
 b=puTpM9H5MyGCH6qDoD2bHCfJUYJwSLhByWUotOzJW++dH0NwvH9YQjB2AI2JnlsJUQ
 fbisWNeWQZRJvokIaReqnbM1VLN8+CqDE28U6VNPXp3NX0Uw9O/5ldUN/D+mLXPaGq3G
 IeSXBPCG4lYoKvGFI8d1fQH2ItP3UZW/UQOfosbcTb1Mh94zrrXdmttMrwbnMCYgyGS5
 7VL5ewde/eSWVYp0js9gZDkT1iSyAvdx4r5vdi3Ej/AaedxFSe1OIaIxs2i8HG4D/AbN
 LmbC7tHGCAB+9Pm5PPHuchh6AXVPYK5Ky3PkV0Y2BL6XHt/blx0qo4N92TzPPatnqdp2
 NY1Q==
X-Gm-Message-State: AOJu0YzIGSI79ARaXkydR+Fjudg/jT4FU4n3FlhIc6uw0fQeiJPPISb5
 e50tbRLA1MwTO3+X6Cvgs1vrWFy1/iWPHosyUqQzpcCDBYE84VkoMd3s/izAbDnxQ6vaQvmB5pO
 TvQXie54=
X-Gm-Gg: ASbGncutm2DhIBy8XYrxRnpeJeHx4fp7D++dhGs2yddB2dI/X5ZKXZd6MmfIV/CywoU
 /s+/OTOJZyRQMmtH95V2TGSJuht2uziXHb3grdWh4EVb4GsovlFTnKZJYNXezVRlxPKEfvOcoTX
 kDY4xSaIbLscGkHBM9fYKoHVpxZMAL5ivW9HoOQDSJ5VIcIEiv3CbRd/v3ynxoBOAOuQ2x14l7m
 QXTxIZKwfj3C/eXvH4m9KWzr6CM5gRNuXBOIMDG56R/gLId/F9KT2yTIUN5ACTaDovoJiTl/pUI
 JVnr35TLM/AQxT9VKmPoLIkSt0zf0bMT3fVvX88opKoWgwGdKkTh3DglkbY7neIKhNNtkNYc+/F
 nWC2F/x8nDBuj3Hs+3BGMIpNufDS8ABI6O+s18LVhrH8TiBfHO1cuF1POgpVST15xtCJNcaTk
X-Google-Smtp-Source: AGHT+IEHZ3HW9f14+6qaqP7+J3Rsva/b45cVC63XrQVqcxgSCBC1eYSop2F0J1aVdTeUimPSKoAx/A==
X-Received: by 2002:a05:600c:358c:b0:45b:9a3b:34aa with SMTP id
 5b1f17b1804b1-45b9a3b36d5mr120590985e9.16.1757049580501; 
 Thu, 04 Sep 2025 22:19:40 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dcfcba94esm34360325e9.2.2025.09.04.22.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 22:19:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 2/2] target/sparc: Loosen decode of RDY for v7
Date: Fri,  5 Sep 2025 07:19:36 +0200
Message-ID: <20250905051936.92815-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905051936.92815-1-richard.henderson@linaro.org>
References: <20250905051936.92815-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

Bits [18:0] are not decoded with v7, and for v8 unused values
of rs1 simply produce undefined results.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  | 24 +++++++++++++-----------
 target/sparc/insns.decode | 12 ++++++++++--
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c2ffd965d8..69d5883dec 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2865,22 +2865,24 @@ static bool do_rd_special(DisasContext *dc, bool priv, int rd,
     return advance_pc(dc);
 }
 
-static TCGv do_rdy(DisasContext *dc, TCGv dst)
+static TCGv do_rdy_1(DisasContext *dc, TCGv dst)
 {
     return cpu_y;
 }
 
-static bool trans_RDY(DisasContext *dc, arg_RDY *a)
+static bool do_rdy(DisasContext *dc, int rd)
 {
-    /*
-     * TODO: Need a feature bit for sparcv8.  In the meantime, treat all
-     * 32-bit cpus like sparcv7, which ignores the rs1 field.
-     * This matches after all other ASR, so Leon3 Asr17 is handled first.
-     */
-    if (avail_64(dc) && a->rs1 != 0) {
-        return false;
-    }
-    return do_rd_special(dc, true, a->rd, do_rdy);
+    return do_rd_special(dc, true, rd, do_rdy_1);
+}
+
+static bool trans_RDY_v7(DisasContext *dc, arg_RDY_v7 *a)
+{
+    return avail_32(dc) && do_rdy(dc, a->rd);
+}
+
+static bool trans_RDY_v9(DisasContext *dc, arg_RDY_v9 *a)
+{
+    return avail_64(dc) && do_rdy(dc, a->rd);
 }
 
 static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1b1b85e9c2..74848996ae 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -91,6 +91,7 @@ CALL    01 i:s30
     STBAR_v9        10 00000 101000 01111 0 0000000000000
     MEMBAR          10 00000 101000 01111 1 000000 cmask:3 mmask:4
 
+    RDY_v9          10 rd:5  101000 00000 0 0000000000000
     RDCCR           10 rd:5  101000 00010 0 0000000000000
     RDASI           10 rd:5  101000 00011 0 0000000000000
     RDTICK          10 rd:5  101000 00100 0 0000000000000
@@ -118,8 +119,15 @@ CALL    01 i:s30
   # This confirms that bit 13 is ignored, as 0x8143c000 is STBAR.
   STBAR_v8          10 ----- 101000 01111 - -------------
 
-  # Before v8, all rs1 accepted; otherwise rs1==0.
-  RDY               10 rd:5  101000 rs1:5 0 0000000000000
+  # For v7, bits [18:0] are ignored.
+  # For v8, bits [18:14], aka rs1, are repurposed and rs1 = 0 is RDY,
+  # and other values are RDASR.  However, the v8 manual explicitly
+  # says that rs1 in 1..14 yield undefined results and do not cause
+  # an illegal instruction trap, and rs1 in 16..31 are available for
+  # implementation specific usage.
+  # Implement not causing an illegal instruction trap for v8 by
+  # continuing to interpret unused values per v7, i.e. as RDY.
+  RDY_v7            10 rd:5  101000 ----- - -------------
 }
 
 {
-- 
2.43.0


