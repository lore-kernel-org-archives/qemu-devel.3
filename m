Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBD4C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5v-00079j-UX; Fri, 17 Jan 2025 13:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5j-0005W4-L2
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:11 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5h-0000II-QK
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:11 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee86a1a92dso3575225a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138548; x=1737743348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCTRDw7PAbqCKYXvBgcxkNrgrmTWjt+YolnHFRZufm4=;
 b=jSkN4S3zeMoFsamOK9r5MxY4Epy97M2+wdTusXvSFNANZjbIMBRiWVjrn9ru7LClO3
 QTmTbfu3WeXfhL7yjLBWTtS3gqYLEPnA+apFRt8l4gKshrosZXEzKhXsIfYTi3ivrVnt
 sSKpZ29bkicE6eERX0p/YisxitOJhoifnE7u9WQN1oDsrnWViwoCUbfp4jeN5RjHX3+2
 jyZPfI250XyoM3jZb9Hn08MsjzIfRB6+exiCzD9a3qXM9FrjXoBzjkMHM1egN4m1Te61
 1yItx8rY4fRi3DVFsqNZ1HGtbsoo5aVD60Y1e+Tga9NdVFJMY/+uPCmuj/kR6G+MNbzo
 PGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138548; x=1737743348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wCTRDw7PAbqCKYXvBgcxkNrgrmTWjt+YolnHFRZufm4=;
 b=MLte+nbW5232NzUb5AoVjERURZEGUG5F4VkZxIDibDNTrEiDjFel8Lk2DCjcXWhZdp
 MzUYPWlmemq/diS9pqvp8sDnkXCAlp9HZurfIi1Gj5mL2+DN65SSm4vO6wij191eOmvw
 s3zN3FRhpygVRrAGjXPgygdA9gQhT6j8QWitGezWBBQVpZvifsFDqUPmyxtGN4jgHdaQ
 /ofZog9B5BhXOhxYFRt5YkdKfvlI8YnFgO+jZB7AvxaA3SdA6l3Xg+kHL8w592Qr5i5B
 yJkvqLh6ufCPKE2HGqJjfsOKMiRiWD1VSQCAvFx9kPbMgMcAfPUHLd6jjXP16chVoG8o
 16Zw==
X-Gm-Message-State: AOJu0YzBAkwnvXi3SGr/BdcC3vi/BciDIMyQHTtz5IqeC3NWjI/IRMB4
 sleKxSbQF4QLsqcfW3P7qMK95ouxz91nc8KiPD8gBJxJGTaaxQ2SW/rH2lRQy2ABATARlcurIi2
 P
X-Gm-Gg: ASbGnctfgXNqCf2ITzak6y9T/ZKBq5u3wZFjVmdxkoEuCyiaXoGb82pxFPQU1BoNM0h
 V3b70De5Ts+QS/x7LRLfILrR6U8iOJw4wvrEq3Qx1WHCA2EuvYzh2a9k4VtFoo/UcK4vQFIgknJ
 PHaPA537/zh0ufAHoitdofzIgz190atSmvlHzPIHb0Kyz18wRwh164O6+EPkW/N9rHg/7yz43GH
 ZBdo7Xmmf5/yzGP7DWmY/SzQQvwGwYXFb8oVJTCYkvVnNUmpQJSQGG4dFrG7tcDxaAKON14y40x
 BGXdZ/OIrLTN+AY=
X-Google-Smtp-Source: AGHT+IE0K8QrlxgB9pkDEIpAvO7LDrEFKdtZDOwPYhsFUQV7SMV69emQnl9v9nKPFSXfOhMeTyTK1A==
X-Received: by 2002:a17:90b:534b:b0:2f6:f107:fae6 with SMTP id
 98e67ed59e1d1-2f782d32397mr4402272a91.23.1737138548126; 
 Fri, 17 Jan 2025 10:29:08 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 58/68] tcg/sparc64: Use SRA, SRL for {s}extract_i64
Date: Fri, 17 Jan 2025 10:24:46 -0800
Message-ID: <20250117182456.2077110-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Extracts which abut bit 32 may use 32-bit shifts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target-has.h | 13 +++++++++----
 tcg/sparc64/tcg-target.c.inc | 11 +++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index d9ca14cc3d..d3ec569592 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -33,8 +33,8 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      0
-#define TCG_TARGET_HAS_extract_i32      0
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
@@ -68,8 +68,8 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
@@ -83,4 +83,9 @@ extern bool use_vis3_instructions;
 
 #define TCG_TARGET_HAS_tst              1
 
+#define TCG_TARGET_extract_valid(type, ofs, len) \
+    ((type) == TCG_TYPE_I64 && (ofs) + (len) == 32)
+
+#define TCG_TARGET_sextract_valid  TCG_TARGET_extract_valid
+
 #endif
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index afc778fae7..733cb51651 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1510,6 +1510,15 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, a0);
         break;
 
+    case INDEX_op_extract_i64:
+        tcg_debug_assert(a2 + args[3] == 32);
+        tcg_out_arithi(s, a0, a1, a2, SHIFT_SRL);
+        break;
+    case INDEX_op_sextract_i64:
+        tcg_debug_assert(a2 + args[3] == 32);
+        tcg_out_arithi(s, a0, a1, a2, SHIFT_SRA);
+        break;
+
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
@@ -1559,6 +1568,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i64:
     case INDEX_op_qemu_ld_a32_i32:
     case INDEX_op_qemu_ld_a64_i32:
     case INDEX_op_qemu_ld_a32_i64:
-- 
2.43.0


