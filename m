Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E2910F284F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6APY-0006zn-U8; Fri, 27 Mar 2026 12:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOs-0006Hs-UB
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:51:12 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOn-0005IT-1W
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:51:07 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c6dd5b01e14so998830a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774630259; x=1775235059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXzIIST3xy/TAN4MvDOBAWjprHM5xgU3m+1mXtsXC14=;
 b=qtny/1ks16hMzGB841I49a/LFXti1c57RII5JoeNWSeBk/U63ivhvfKITXqWpJRYMf
 HrAmBz54j/RrGBLPbBaDrBFJoDQrCyQDGlLvVyMRZLR5vjbzmUOqXhN8giOgrDs27M4s
 yZJ5OuD+AdijmfAkISiNp/sFLviTBakRSFlOseXVBjBAl1fXtjsDBV2bmuOHUy9/rJZ2
 LMVr4vFKsHdOLL9ZoJy5Ms7xTAJU4YDKLPcr3mKKNNXup3tFyV8Zsa+imgDJeK9hOIeB
 OFpEaDqWM7aFWOmcp2pp1UVbhYwRXJ0Sk9Gj/53N8Xq1STThCg4mMlnKzwfT0Qc9UkZv
 y9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630259; x=1775235059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YXzIIST3xy/TAN4MvDOBAWjprHM5xgU3m+1mXtsXC14=;
 b=dLMwnSr+j8Nwp9u/hvBe0+ySJU7xOhYj3KZt9W1rhtBP8A3c4BEpfaGx+IIAVSgzi7
 punlEY+MCHHoVk2Gyw5JN2RRXPlakfM9lQabjWnPvux++Ii//ReVlwN/zz7g9APiDIju
 E8J67vOfD4ELRGKaWk25VumN7ABDpbFi7liLy2WIBzbvfalkxFpFhY0KicU9pRwfj3Hv
 Tz+Y4PRvN6AdrXpXEq/t9RwsYQCRNKEaom4wlM35yCrmlnqQUoUtPYInqkdKdOlOxb3i
 Lg93AZqbypr7d5Y1gsbvo6LWLZtuNy7ZjlPYJtGL3Plku0uzn8o2129yN/uwP7/cWo5f
 1fWQ==
X-Gm-Message-State: AOJu0Ywk7vXiV6iFZYBqn8Kr0AHTghf6lsn2x7UaWSlwMEBN2WAU2sKj
 r8bpMwlpl6yXsVcPFB1Pb5C4NG7AfYrwSimtoU4egAF6vfo7QSTJvZqD2nLs7R+2Wk8zEZ4gm3G
 F7NgPWQE=
X-Gm-Gg: ATEYQzywo9fgNxQFvbMSLtGwCjZOKnHSMxSGisQ9dpgEbN4y3hhmBMgWEb1DUqI43IG
 RkXlhkOTr7aUc8S8zdqzgfOvO41aCiMyQAvBC9KsK4PNSeRjDZGRzGPcPYF3nqPxXosSBzWe35k
 4B3j1nZRwWPejELsChvKoyJx/BKEbAwi1F8x5Cp9ROPlF3iS87w1u2d4wm54IW+c5DSNVDr96uS
 jrASm+HzGBk2taQp2S3jMJ5b451kYJzGk9o51hpISLZuAlsEj/16Pz7Y6WvWANz5oNLuOfW8RKD
 KIB/gZstnhZtnCvf2VdyfBY85MPcggN+cMDgxptPNN4T8migHJQ4slWmlKMUaj1tKrcKgSWSqma
 9ZL2AFJPVigfPDybQHoaOdRJa1B1+BbcZUKxl9yGo9QiVqViJpWHCt4lOKdLvvWE6dpSw0OglyS
 yeCq3C4la6UfPWHHFluAA2bJ8M5ZSbswbN4KbBJt6NWqo2Wqd/jQouTSNWK0KrbnWkAcQM8auiB
 Naru3QeQ90irrU=
X-Received: by 2002:a05:6a21:6d98:b0:393:74ed:7de9 with SMTP id
 adf61e73a8af0-39c8780230emr3548698637.3.1774630259056; 
 Fri, 27 Mar 2026 09:50:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c767399e0casm5514038a12.31.2026.03.27.09.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:50:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 12/12] target/arm/tcg/translate.c: replace target_ulong
 with uint32_t
Date: Fri, 27 Mar 2026 09:50:42 -0700
Message-ID: <20260327165042.604105-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 4546bbeeeff..204f9657993 100644
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
2.47.3


