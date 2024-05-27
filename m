Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EFAC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhkd-0007D6-A2; Mon, 27 May 2024 17:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkb-0007Bm-AC
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:25 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkZ-0003dY-LL
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:25 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7007324a568so88493b3a.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844761; x=1717449561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzXpHZidtbi0sLTaWMxf4OnjlMkDwcR3ZaE5FnG7M64=;
 b=gn3t1KdVu1M3H6nK13uLQOjirx3iEiiYoNgy9xnxtpFvThCoMBCYnpud8JktQE80h1
 JIiycrNIMXPDWU2wNLeGcha/7uSRVIb6hBlHqWbhdzWqSsk3VjvlqI6zUB+XdMyg2SXx
 SeWXVO9HR6kGDbH7qvEy1S4yf+D0gUlWTO8Uz5euqjCgJt9l68UW/4T9ObVJfDy/dD72
 0S9ml/bEC0XGJhC02ug1O0c5WpNjENJLwv71lLBxBlpDBVMNhOEA5XW2OYuxfREFUPZ3
 +ssKzGAgK/5Cr/y1GEjRtTP5ehZXQmaUCCkYRHR/taCxszOeyB85y7+dcMEDhsOYJjJW
 8x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844761; x=1717449561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzXpHZidtbi0sLTaWMxf4OnjlMkDwcR3ZaE5FnG7M64=;
 b=nN7LXE0f8Pjin6Xe2nCkUt4rp0TVAEaeLmamevRBog01e7nbCnQsV7ybwHz7SyQcsd
 G0A2JIDv2Zny/FhcgmeLqrlAtTcmpEwbXmB1inwsdkccRPNXF2RWmZG2hwFYWTAnVIhF
 THNGBVBao9YWQlNDwFS0m9C+nLrH4kxU+hzdsfxBQCew8ZOXuuaP4JtUz5Pl9s6KkAk1
 IKscyJwOPUq92C4d8Op/arXBqXsxxjKwu7AvGhB3jeEXsQYnSgT7EU4Bz+WnglJgCewY
 80326cg1OlFjFXaMZADRAWPXLNSgn/VxaWsou4iTl8wYz5ndLh9Sz1fWFVbIUqUsouUc
 HVuA==
X-Gm-Message-State: AOJu0YwXFlku+yaSqofNGA5Y7XlbzbSsM7B7RZ9ipeXNjx4upvSp31yX
 e14qD4OYPLUwVX3aG8757jP46bS0I7al56EU8A+bcDUJNr5vk3BpBJCbSoEXT2bOiA4sTyNSwwa
 K
X-Google-Smtp-Source: AGHT+IF+KV0Ubu4crTmqGqFn6kc2RNiOGEFOOt/Juf/0U+O7aCxkbQTiGXPhABYFuOv7trwUk7rNlg==
X-Received: by 2002:a05:6a00:2a0f:b0:6ea:c43c:a650 with SMTP id
 d2e1a72fcca58-6f8f41a95a0mr9664104b3a.32.1716844761171; 
 Mon, 27 May 2024 14:19:21 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 08/18] tcg/loongarch64: Support LASX in tcg_out_dupm_vec
Date: Mon, 27 May 2024 14:19:02 -0700
Message-Id: <20240527211912.14060-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Each element size has a different encoding, so code cannot
be shared in the same way as with tcg_out_dup_vec.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index cc54bc4a53..1e721b8b20 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1690,8 +1690,10 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                              TCGReg r, TCGReg base, intptr_t offset)
 {
-    /* Handle imm overflow and division (vldrepl.d imm is divided by 8) */
-    if (offset < -0x800 || offset > 0x7ff || \
+    bool lasx = type == TCG_TYPE_V256;
+
+    /* Handle imm overflow and division (vldrepl.d imm is divided by 8). */
+    if (offset < -0x800 || offset > 0x7ff ||
         (offset & ((1 << vece) - 1)) != 0) {
         tcg_out_addi(s, TCG_TYPE_I64, TCG_REG_TMP0, base, offset);
         base = TCG_REG_TMP0;
@@ -1701,16 +1703,32 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
 
     switch (vece) {
     case MO_8:
-        tcg_out_opc_vldrepl_b(s, r, base, offset);
+        if (lasx) {
+            tcg_out_opc_xvldrepl_b(s, r, base, offset);
+        } else {
+            tcg_out_opc_vldrepl_b(s, r, base, offset);
+        }
         break;
     case MO_16:
-        tcg_out_opc_vldrepl_h(s, r, base, offset);
+        if (lasx) {
+            tcg_out_opc_xvldrepl_h(s, r, base, offset);
+        } else {
+            tcg_out_opc_vldrepl_h(s, r, base, offset);
+        }
         break;
     case MO_32:
-        tcg_out_opc_vldrepl_w(s, r, base, offset);
+        if (lasx) {
+            tcg_out_opc_xvldrepl_w(s, r, base, offset);
+        } else {
+            tcg_out_opc_vldrepl_w(s, r, base, offset);
+        }
         break;
     case MO_64:
-        tcg_out_opc_vldrepl_d(s, r, base, offset);
+        if (lasx) {
+            tcg_out_opc_xvldrepl_d(s, r, base, offset);
+        } else {
+            tcg_out_opc_vldrepl_d(s, r, base, offset);
+        }
         break;
     default:
         g_assert_not_reached();
-- 
2.34.1


