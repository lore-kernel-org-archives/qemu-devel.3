Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF52CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyYM-0001iT-8v; Tue, 26 May 2026 16:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyY4-0001KB-JL
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:55 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyY1-0007VO-TF
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so6737983f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827922; x=1780432722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+taEkHZb9CxjnQO4BHePIfbY9jY0z9KjY9u+7Jb3eA=;
 b=ELKphlNou1BLMs3+0kFxjjGppFQAJKVaxN+CTPYTcL84DqXpf817pCBG0d2lXJTQNw
 0UozA34kzDYiczIEHq3e4k8E9r7gjDMFhR2QaTWo6gf+WW0z0Sy6HK04aZodF78FPRzQ
 MtS1m+GS+gfSZBB84WZn1wY65A1W/zxXUiEBrq//9H9NeSbL0uOWcJbrsd6ktJrnSvnk
 AfAHlhuKLYtYNuWL9upUrDlnOO5c3bikMF2I/nM2sQgdbFcczGrOgABA9rw8+1cikOGl
 6lM/ubsrnvsNg4vgu0erUqBKwdnrm1Htl4QTVuUsnLlFSZu55pe6cSss0VDANBu4TnD9
 3kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827922; x=1780432722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q+taEkHZb9CxjnQO4BHePIfbY9jY0z9KjY9u+7Jb3eA=;
 b=H/6r9qDHw22tpNjwQdFNgA5LM0vOI1lzpCUNQguuyZ27OIwKWUVDR8NjCFKHjD+KVp
 Dl67KAeMqaArzWFbKqlkVM/BRyekfiu1RPCjsDHv33NnK9+FXOr+7dRG8fRtpyR5fP5h
 eF/and+bz3apimIBSRixO8D5DyJpaH8x9mT0RGUpUPxZWbruqu0YxaezVUHlra45GsDu
 MFrmfc+9wvgPTm1WGGLM+CjvNmhVBDDOsmxHA8oQVo+p07Ju45Wtnz4GTtIT+EK06n72
 xtm9DZDKwjcywxpecfFjW3eG9o6yhWgZ3MviASLPPFxucbVyDakypv6411a81D0pl8QD
 Q5qg==
X-Gm-Message-State: AOJu0YyixYuWzkX/lCutALEw8oaX50LbZHmEkEyyKhYMNpXiisU9/Y5F
 ad5kai1kxtAnLmDxGLiM73NcbwOtsvZ7o1IRCeKnSzmB35HBx4jJkzSbD4Sf7Wd1Cl6GFcZTAW7
 qFTrDeeR3nA==
X-Gm-Gg: Acq92OF8f09lWrV7xixz32J4mJyyIVzICug/VLLzQwje+FNsviaCcWOpnCtdeANBZh0
 ChlJlS7R1v/0nr1MoJdqa75fOSBPYmmxz2lQmRRGSkRjzC9F3an2vuHP799y77rku/7CJ8xRjWR
 JbFfWJ6g+wWh+hk+KvIBwfa2U6aTMcVmUoKog9uayL89QfadniMG4Q2C2vS7AtTljuzOHLKgifN
 qpWhX860Al/hRTP89wjoqDEwq9fmHHvsoKVAqXy8CvfcqCgppGzv/Q63K4Zn3AqeaLoZOvY2HLB
 VD11fSM5EHQPEIqRflsRO1sgvvealQR2m6YFv5sNNGNWmyfoobH8ATFG357omMo0vSTpIge8YzN
 Xu6uUiBgBsgULh/OWZokRuMPv68YpBQp1LNdz7w2J4lIXMo2hIij27hEvNTOM2Z3VNmyaWxbZAG
 cJg0nCtNvrtuoNUsOKGLF/Fxf3/lQuLgDc3oY1fFWdW0Ijrhlz4V+J9eU=
X-Received: by 2002:a05:6000:4b04:b0:45e:9420:ed16 with SMTP id
 ffacd0b85a97d-45eb38b0045mr34673111f8f.10.1779827922259; 
 Tue, 26 May 2026 13:38:42 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb558a47sm749866f8f.15.2026.05.26.13.38.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:38:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 11/17] target/arm: Implement DBGDEVID* registers in max
 AArch32 CPU
Date: Tue, 26 May 2026 22:37:16 +0200
Message-ID: <20260526203722.79463-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

32-bit ARM max CPU is a 'Cortex-A57 advertising none of the AArch64
features'. Keep it as close as possible as the A57, by implementing
the debug ID registers, following the changes in aarch64_a57_initfn
added by commits 48eb3ae64b3 ("target-arm: Adjust debug ID registers
per-CPU") and 09754ca867f ("target/arm: Implement AArch32 DBGDEVID,
DBGDEVID1, DBGDEVID2").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index cf643ce43b1..2e8afc28602 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -755,6 +755,9 @@ static void arm_max_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00011142);
     SET_IDREG(isar, ID_ISAR5, 0x00011121);
     SET_IDREG(isar, ID_ISAR6, 0);
+    cpu->isar.dbgdidr = 0x3516d000;
+    cpu->isar.dbgdevid = 0x01110f13;
+    cpu->isar.dbgdevid1 = 0x2;
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     SET_IDREG(isar, CLIDR, 0x0a200023);
     /* 32KB L1 dcache */
-- 
2.53.0


