Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D90ACA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lhc-0007Zi-OJ; Mon, 22 Sep 2025 14:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfw-00050B-7h
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:14 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfJ-0004zw-3P
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:09 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b5507d3ccd8so4285089a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567210; x=1759172010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpGCCThsena9eJaUjNGXk5YpWbCZ6xAMscsxPYodbx8=;
 b=gcZPAXs64dU6OyFHwehKkhgYM8459ZpjiC689a156nUCPACjsmjbQOZ7cNtBBzMPS6
 pqo4enIpGvk12X+Ot8FfRgoYWn00K/mbekpsHJ61UllzDQsq9KP1nrSUnlYNovOORm+Q
 iqHURhwmDPQRxJV6R56vgeAzrzQtrClujKeGBx3m5oLSst+Jh0ikdJpUEkFOO+LkSiqw
 uFyu/q9pRBSLwJRrEYA0Y/sl6tWDiegllf/JVsYHaFH1MQo0/KoRHVrKkbLiCPR0XvVQ
 iAUv8TOVIM4e8pwcX2p0rG0DjpdkcY2ZCOzIrfXYgl6KiKJWaPmMWLnSI4mUOtX6Z3OT
 HshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567210; x=1759172010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HpGCCThsena9eJaUjNGXk5YpWbCZ6xAMscsxPYodbx8=;
 b=aUQWs2NMjTpfdvNki4dPWwlNeziPz08GXH5/h8DtgbFwWK/ZGM3Q4UFVFiGRmirLH8
 GBpzdHYWMepn2fdB4LJ7tk7bZPifoA4UgafLrpCrA3u4yy9mGizgUSkGoP4efldl1qhS
 Yq8QTHXATJJR+z0AJaC5scTB737NrkoFzb1ya0sI1mJj8/shzi/UP95yNBpfFZWwlm/p
 aNLO+V3kZqqtfsBMHxcwFTBsAS1PPLB1hGTfFhKej6i8SKUPOg1Yr1Az7YI861IOXtzw
 2YEVmlHocXPnNVqLivW4moziQLjbpMVxke5SGc3RmFooSXY03MTWMATPZjmAyxv+s+v8
 RiZA==
X-Gm-Message-State: AOJu0YwVOkTJHmyPN28WUGjAX6dsK5fKclaU0JjflUQ/CFIq+fpDPdAf
 VQHhLxQlWXLgdToWj7/UDhH/5VfuB4wuoKMaQgIvJQZ6W3TB/o0UaLSiV57hemaxyou19TGWlme
 cGdya
X-Gm-Gg: ASbGncs6vaxPDEw0Kcj2UqqpWBm7U3Duj1yk1GG9PgbUKNT1435LLs9IXz/fIl7VYQp
 psgKJahaPSLloADK4mAKDz4pCISt38qC5Bg1L1gri5GwS10lZkg2H4XT/Jh274taPjY5pScop0B
 gvcfvThFxnMg8lMP3ip+nDDOHTzzI5w6qyskcajb7OEgUpFEyINNU7aEFE8zbQBp4RI0itrUz+l
 omBeT0289W0cRt5VGQc2/aj2BN8I1qUfXeszQiO8q7KJT9UZs0gYvIY4F1+cN9bF+TJw3Qpttcc
 pkqIp3Ulz6coDlZRWqRfN3i21917CQ5LEa2OQHr8FHXiPX0yhfmhQblsJsL3lAsc57NTe23XdFT
 C0m1WlHMp/upxRV87n8aJuU/EAmNt
X-Google-Smtp-Source: AGHT+IGMJVqFOItknxpQo3V6c4ovsfSSQmZdRMN2JSs6XoVFOR0nMcUfY3XO/oCPdkDEjklKKPM5iQ==
X-Received: by 2002:a17:903:3884:b0:24c:82ad:a503 with SMTP id
 d9443c01a7336-269ba53a976mr164010435ad.41.1758567209883; 
 Mon, 22 Sep 2025 11:53:29 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 58/76] target/arm: Add gcs record for BL
Date: Mon, 22 Sep 2025 11:49:06 -0700
Message-ID: <20250922184924.2754205-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index dfa2a6d64c..6eca241f12 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1678,7 +1678,14 @@ static bool trans_B(DisasContext *s, arg_i *a)
 
 static bool trans_BL(DisasContext *s, arg_i *a)
 {
-    gen_pc_plus_diff(s, cpu_reg(s, 30), curr_insn_len(s));
+    TCGv_i64 link = tcg_temp_new_i64();
+
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
+    }
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     reset_btype(s);
     gen_goto_tb(s, 0, a->imm);
     return true;
-- 
2.43.0


