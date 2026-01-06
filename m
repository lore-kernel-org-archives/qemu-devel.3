Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE614C2A073
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0gt-0005ZC-Bm; Tue, 06 Jan 2026 01:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vd0gr-0005Yt-QF
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:37:13 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vd0gq-0006tI-2d
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:37:13 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso901495b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 22:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767681430; x=1768286230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BpSHIWQQ8x9eIJTo+o+MCuWeunb6JYZPGxKktINRqfc=;
 b=PM6g5FxvW8VU9TomaPrKiKhtb1MA7O2DF0Ve9LAWt7skT834vLC7v+HROPE9aGhQJV
 9xwpm7QJ1d0gUkNOtwo+5WwRZDOJzWuwg7F6vnWqT3xEx9BRJ30tlQFuU7jWIH0p6vov
 sjdpfFMl1vB+xP/zbgDsKw7YuIgUtb1WmRiBuSVhdNO82ARgXOQhnPseeXVZ3QK/y4qV
 3FA/ybAGTrGMJsfz56bao3dQY7FNOFo58TmF6K8LBQoDnLJVyKV8mpW3eXRzeUVHArMK
 w1ehwDPxMb6OxtD/nov+5kwjUFt3IRVDTtcRKutGVmfwRsrN7khF4zxI8pzm0Rz0HSs5
 NeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767681430; x=1768286230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpSHIWQQ8x9eIJTo+o+MCuWeunb6JYZPGxKktINRqfc=;
 b=G7ZEsjmjyJZ+S2Ks+CZvUYYrmc7iZ2DooZaM1MvM6Zosw23qFJZLtEAe0vII4o6os7
 4cGQC+roRAgsfdmZlHXWu2Un/SfnHvs1me09n0V9l55yKw1Yn2UA3d9ZDg7ogTJ1UvA6
 pJ/a3G6+DLMHpDTd//vDtZaRlmPM/RUiuxWkNy84ZPZ6ssHHGNy59oiQQ3j9ipJBZaCf
 g4HKNOYmNnBOKa7MU+olPDzyNw2BgPX2RjaOi7X4d5JXYz0r7gv7yaJ/GyhHi65+hLJ2
 pPCmJ5GK8vt1w4znFVdjxBTB/dbVkt8lQXOmpPUpJv5fYblQjdUhbBswepnNT3GVTrF3
 dYCw==
X-Gm-Message-State: AOJu0YxLXPH35/Nhpovd3hImNJW6Fp1geAbGt1gYtD4VT6WUdmDxd2Jw
 uuyvamsjq73XcblSn+NRLNUGaiBQ33zXi52HRKsfeZLeHNABUrS9s41lkUvi99FT4xiEWBpKDLy
 Us1wdKUs=
X-Gm-Gg: AY/fxX5B7Zyb3Erv93C7fYBcUaXxXzvLAe1VkL6wUk8OosKIg8Di5e6d3LzKYp1/kp/
 DORMBpu6JZMOQuv5cC8iDvFyyaW4AQ3iavZcENCzxeE5Z0fKdKtdAKE6eW07Lb9Xa4M3pKuupLg
 lOOteawAiJxK+a6luX7frTEQoL4Ga3n6/VS4vyvMOdhbaz7PQVYuUyXjLYEgfWd3jQwKtep3yDQ
 rDdm5fdmxpvy0OR45Tfmg3m0BmDkd/zvor6JEKEKhAFt96lHxEhBHOjuJYNitT0KaZIaDwtw2H/
 8/Aibp5AJ8DsZAaBVcgUNYhbRUrA4TkGf1X3odQOwUfwxSPpo5Kh6hM+1oVt6dvc//fuOoPCasz
 6SxySl9jR3jTzIZn/Pjh5khn79ziehLtTUdj15p7OAqZjr5hpfBYNgF43rDE460iikFD3U26PQ3
 57lipDMkuCwMyKP4UnQXmF0aHhkE4u
X-Google-Smtp-Source: AGHT+IF4cX2W1reaFPvi9Tl5h0mYtAk/J69aTnoOtr6ykIGHztljV8lVqM+TXGEXIvQhgo6j8kU6vA==
X-Received: by 2002:a05:6a00:90a6:b0:7b8:ac7f:5969 with SMTP id
 d2e1a72fcca58-8188115eefemr2033426b3a.4.1767681430183; 
 Mon, 05 Jan 2026 22:37:10 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c5edcf34sm1001613b3a.67.2026.01.05.22.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 22:37:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Zhijin Zeng <zengzhijin@linux.spacemit.com>
Subject: [PATCH] tcg/riscv: Fix TCG_REG_TMP0 clobber in tcg_gen_dup{m,i}
Date: Tue,  6 Jan 2026 17:37:04 +1100
Message-ID: <20260106063704.244300-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

TCG_REG_TMP0 may be used by set_vtype* to load the vtype
parameter, so delay any other use of TCG_REG_TMP0 until
the correct vtype has been installed.

Cc: qemu-stable@nongnu.org
Fixes: d4be6ee1111 ("tcg/riscv: Implement vector mov/dup{m/i}")
Reported-by: Zhijin Zeng <zengzhijin@linux.spacemit.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 31b9f7d87a..0967a445a3 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1074,7 +1074,7 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 }
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
-                                   TCGReg dst, TCGReg src)
+                            TCGReg dst, TCGReg src)
 {
     set_vtype_len_sew(s, type, vece);
     tcg_out_opc_vx(s, OPC_VMV_V_X, dst, 0, src);
@@ -1082,29 +1082,34 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 }
 
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
-                                    TCGReg dst, TCGReg base, intptr_t offset)
+                             TCGReg dst, TCGReg base, intptr_t offset)
 {
+    /* Note set_vtype* may clobber TMP0, so do that first. */
+    set_vtype_len_sew(s, type, vece);
     tcg_out_ld(s, TCG_TYPE_REG, TCG_REG_TMP0, base, offset);
-    return tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
+    tcg_out_opc_vx(s, OPC_VMV_V_X, dst, 0, TCG_REG_TMP0);
+    return true;
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
-                                    TCGReg dst, int64_t arg)
+                             TCGReg dst, int64_t arg)
 {
     /* Arg is replicated by VECE; extract the highest element. */
     arg >>= (-8 << vece) & 63;
 
-    if (arg >= -16 && arg < 16) {
-        if (arg == 0 || arg == -1) {
-            set_vtype_len(s, type);
-        } else {
-            set_vtype_len_sew(s, type, vece);
-        }
-        tcg_out_opc_vi(s, OPC_VMV_V_I, dst, 0, arg);
-        return;
+    /* Note set_vtype* may clobber TMP0, so do that first. */
+    if (arg == 0 || arg == -1) {
+        set_vtype_len(s, type);
+    } else {
+        set_vtype_len_sew(s, type, vece);
+    }
+
+    if (arg >= -16 && arg < 16) {
+        tcg_out_opc_vi(s, OPC_VMV_V_I, dst, 0, arg);
+    } else {
+        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, arg);
+        tcg_out_opc_vx(s, OPC_VMV_V_X, dst, 0, TCG_REG_TMP0);
     }
-    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, arg);
-    tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
 }
 
 static void tcg_out_br(TCGContext *s, TCGLabel *l)
-- 
2.43.0


