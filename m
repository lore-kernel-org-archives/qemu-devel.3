Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A4AF99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtf-0006Qu-18; Thu, 23 Apr 2026 06:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtc-0006Pj-T3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtb-00024u-Cy
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d73422431so5467998f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938574; x=1777543374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hygiL4rCH4Y4ETW/ONUbAGwRs7sVnhNnGSZRgBVtg9E=;
 b=h4XJK+dw5Mbrqu7FH04jegTCQXLMOooji0lV7cJaG+yhA7wXm6yechj2SPzv3JdWmv
 YDQfkNTZ/1vQO0r/QcHATreL993orBuoFR+IC+//dOO9TTS+MinKFfEivjwThQ8iuxYx
 iYTprNeMVL6QGaTy6u5vOV42k/4BKTL8JKbhMtWREOsx3ku2kzwVLqZ7qM583Em6bdLj
 8IhPx9AfpFX7XkxM23ZT1XEOl6vJDKgIbFUj+amoRs2dlV2JBKG+aKCTNgvDriQuuuvL
 rvw6Q8Ky/DXwTvMIJds52QL1P9k68nsSRYd+/1ZuzarA14/jlwTMBTHxySzIUy6cj0vY
 c0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938574; x=1777543374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hygiL4rCH4Y4ETW/ONUbAGwRs7sVnhNnGSZRgBVtg9E=;
 b=YbW7E0JUGnrzSUcl+lFInb3Z1+zX9GrQCf8NU3ihf3IA9P1KOnHEHTLmPAvLKmYfBv
 S2zkILk8tIxTPwkWhYQTc7+9sGD1T63W2C5k2hWZ9NU6xkBNa5hm03XRGaKvTIikdIDF
 2lOaBhgUtULjppxxs+bD9P5yXEYBF3b6VZoxLb31HKreGMDb1zWG2ckFn0nf0OuROxWs
 SzOpZtfr/kXLoX7qqgy9N/wEuvEETFPfATl86KF45YSCAR3krqgHQmoAQIzQjyMHcXc/
 +pdo8vlBsqTOUdxM8UM04CoPgcwOix+hscYhOu3zUmGEpY2X1EUP+n/W3Epoc8Ecq85u
 t3gA==
X-Gm-Message-State: AOJu0YxeHAEhCIhTdAWkRguG7bVvzKxrC58zALfpdBiyCEPuZ9UOHDfM
 i8ge6rcNubq6pEvQ5C9ff+KvwbaBgrVAUHPMeWOOCSJNF9zbPeuDlg3iETMIPhO6efNsqLph45V
 QgPoM
X-Gm-Gg: AeBDietUD4oQdxzJ0vaqZUE3AUoAHUy730c8cXK0j+VZTZZkQVRLGdHpSEvm2HqLYXw
 QRjDzCRnU6pLgqMbuWaY6idqmkLakt41BnipBpqleHGOocPQUD29qjbZ/VIiOzVBfB5Oo1CL/pc
 WoeTP3C8MJFnFyhMO+Q5oXvLxOSkU/4rP0HgtGanBdi8Y9rOio3jsVer8/3MKoTmgr6IL4t0QEt
 vv/MkkCXHKbR+5gCiOO3ZDffsqhx8efe768vcgga/9vcckAc/XGTXDUzczMg3hk7mRtQpRu4jXO
 gKVKf53IS61oeBrXKdlFUBTszAF4X7puWgXQd2by0w8xyrXWOq28XoMDNqD5DUomQ2xwTXvobop
 KeqmZqvU5SPZ/5gFRlrkAugYDUR94nnzDhdooawTC7Vx2ZVz1+8scYhtTX4/cPEWlL9w9SteVjt
 xjnJ17Ie5X0U/JSbvYLj2ooTiKhJk4apMacBEoCebrqfoGglPOOOQ1FZndzjvrnRSxr7y0XDOjf
 L33354tg13W/7A3CMhRcEAVMwR3HXY+5YI273L9sw==
X-Received: by 2002:a05:6000:22c5:b0:43d:6fb7:fedb with SMTP id
 ffacd0b85a97d-43fe3e1645emr41436464f8f.36.1776938573681; 
 Thu, 23 Apr 2026 03:02:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/59] target/arm/tcg/translate.c: replace target_ulong with
 uint32_t
Date: Thu, 23 Apr 2026 11:01:51 +0100
Message-ID: <20260423100229.2941820-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-13-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 4546bbeeef..204f965799 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6450,7 +6450,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
      * fields here.
      */
     uint32_t condexec_bits;
-    target_ulong pc_arg = dc->base.pc_next;
+    uint32_t pc_arg = dc->base.pc_next;
 
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
@@ -6612,7 +6612,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     bool is_16bit;
     /* TCG op to rewind to if this turns out to be an invalid ECI state */
     TCGOp *insn_eci_rewind = NULL;
-    target_ulong insn_eci_pc_save = -1;
+    uint32_t insn_eci_pc_save = -1;
 
     /* Misaligned thumb PC is architecturally impossible. */
     assert((dc->base.pc_next & 1) == 0);
-- 
2.43.0


