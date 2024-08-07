Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C68C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 04:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbXz6-0006zd-Af; Wed, 07 Aug 2024 00:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXyx-0006yU-9G
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 00:09:03 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXyt-00067z-TN
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 00:09:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc56fd4de1so3652655ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 21:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723003735; x=1723608535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTSrcFCetK79+4KzFc9T0JvzztNS6tf659Ej5rsMwn0=;
 b=kIcGzAwt14GbFzXfTWk/GPGYj7U+wCGv2rFrj0xKfebOE1dwQPnmVQhEUJdI3AnimX
 w9URRF3WYBDCIzMvN78y++BFR/utZYWZu5iN5ShUj+qUBrUCVwQyiXWjKi8xoHVtwQnr
 gegBYqhizAT7QHkDLdEi4L0ogagspnGwOFv+UkSbUdR3utGWPnPxifXDoMp0ExpNjLBo
 arEJEXkFf7IbSbek+A/lNT7+x3ka6oG9eboXvEmiSPMFrS6x3WXMf6+0pckvIruG1g92
 S9ydq8BD4YObA6HQkaC0WBBSk8goZkJ6do31fFNYrASU/cP2+zZ9ZHpVa1kX3JWAJBQ3
 mdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723003735; x=1723608535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZTSrcFCetK79+4KzFc9T0JvzztNS6tf659Ej5rsMwn0=;
 b=Grf6MORdsDP+Yp7rK2rFne+KBAzdeT7WvbwDfnJBENFMljcd86riAAUV74frLX+HgD
 04YebSwAl1Dc5YVLI8RwU0WUK9gECpMXTgQZ69SJfgjmI3RN4ij9in0NkfQcEUaALLRs
 PqC6XkqFagPVljzng3y88oIuP9kgZNw19Hbt5Pls84Vm9MwJZIPf/gYrHU4BFprPIwI/
 hdj6rKmpMZAFed+fI0HrAJWiWof+eY8NOWnnDPgkg5qxTGfGHDAc6paLSc4kX+j//PiY
 nxjkJ3JUxFY4jAVA70/nEciUCaj6mL3WVs/SPiKvi3T/+Sq1q/tccc2Q58FW7+HSFh/0
 vQCg==
X-Gm-Message-State: AOJu0YzcCjgDzrNcmWERwothfNeUby1/yFFIXXppPZ9hUmkB32HFWv/V
 ckat/x5Oe7NWBK4nNelCo7HlFmUWnNks0ndtgpeIoCzmbN0s5OyByIpt/TTrQDxWNQIIZFDEE6i
 wic0=
X-Google-Smtp-Source: AGHT+IEnePo0DIVp9T2s7Pbgonh0wwJHVlVK7MdFT93+QFuDfvUVsSVbqvKQ3P1QBOFcC2AQVAcNfw==
X-Received: by 2002:a17:902:f690:b0:1ff:5135:131f with SMTP id
 d9443c01a7336-20085543263mr16288365ad.25.1723003735245; 
 Tue, 06 Aug 2024 21:08:55 -0700 (PDT)
Received: from stoup.. (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f57001sm95858825ad.91.2024.08.06.21.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 21:08:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH for-9.1] tcg/ppc: Sync tcg_out_test and constraints
Date: Wed,  7 Aug 2024 14:08:43 +1000
Message-ID: <20240807040843.7882-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Ensure the code structure is the same for matching constraints
and emitting code, lest we allow constants that cannot be
trivially tested.

Cc: qemu-stable@nongnu.org
Fixes: ad788aebbab ("tcg/ppc: Support TCG_COND_TST{EQ,NE}")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2487
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 7f3829beeb..3553a47ba9 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -325,9 +325,11 @@ static bool tcg_target_const_match(int64_t sval, int ct,
             if ((uval & ~0xffff) == 0 || (uval & ~0xffff0000ull) == 0) {
                 return 1;
             }
-            if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32
-                ? mask_operand(uval, &mb, &me)
-                : mask64_operand(uval << clz64(uval), &mb, &me)) {
+            if (uval == (uint32_t)uval && mask_operand(uval, &mb, &me)) {
+                return 1;
+            }
+            if (TCG_TARGET_REG_BITS == 64 &&
+                mask64_operand(uval << clz64(uval), &mb, &me)) {
                 return 1;
             }
             return 0;
@@ -1749,8 +1751,6 @@ static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
 
     if (type == TCG_TYPE_I32) {
         arg2 = (uint32_t)arg2;
-    } else if (arg2 == (uint32_t)arg2) {
-        type = TCG_TYPE_I32;
     }
 
     if ((arg2 & ~0xffff) == 0) {
@@ -1761,12 +1761,11 @@ static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
         tcg_out32(s, ANDIS | SAI(arg1, dest, arg2 >> 16));
         return;
     }
-    if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32) {
-        if (mask_operand(arg2, &mb, &me)) {
-            tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
-            return;
-        }
-    } else {
+    if (arg2 == (uint32_t)arg2 && mask_operand(arg2, &mb, &me)) {
+        tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
+        return;
+    }
+    if (TCG_TARGET_REG_BITS == 64) {
         int sh = clz64(arg2);
         if (mask64_operand(arg2 << sh, &mb, &me)) {
             tcg_out_rld_rc(s, RLDICR, dest, arg1, sh, me, rc);
-- 
2.43.0


