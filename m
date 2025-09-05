Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD89BCA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 11:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuUz6-0001dY-94; Fri, 05 Sep 2025 07:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUyw-0001Zn-K2
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUyh-0003YW-E8
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b83ae1734so12212725e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757073092; x=1757677892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRAc5xsl1m+VhgQiShnpQM6Hj9dAAWKFHFsWJQupR0Q=;
 b=RKywCmrWEqtA63n0aOWj+eMGkPSTDQ/NQbhYLwrcwG7UnVaak9vyagvyDKfuAcAurh
 nWS4K3R0WLenjMMwJeE/Ayy1Y0AskCQEkBvne6LjND4s6A5lFky/4gINYdNErIH7Y+cB
 jSrq46Yw55iF6+Nzkg3+b1RqeXYi/z8NYboYIiHEyaId5nUMoGUmMepfl6X2Wkl+2TGr
 1V+VcFZLBITQcGr9gcU/stSIF2fDhF0/EhDR6XsaaBFu0wFw5G41uLpaSxMx20XmBgwY
 bdbb8WUse0/8716uHO8YWs6PrkL1ZDfWDyW2LaLpmr4fGDjSG2w3qKyFhb9244ES7CrH
 aTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757073092; x=1757677892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QRAc5xsl1m+VhgQiShnpQM6Hj9dAAWKFHFsWJQupR0Q=;
 b=uaMSz+prQcHMeeapGhJsKRbzr4Ie0fPCgEe0MEBgUY6uq0ZxYtlGpfI0Tzl5pUXqu5
 bVaR2fOJ7PorVd8NVAion90UrOdok1pHYBzuB3DPOP7a6FtNQ0Hi3TSb6aE5NlDapTYV
 SI2bH0Qfg+7UmXpsDmx2KQcBENWyuXMzgynngIoOu26avQH6QCSeyv/QL/jFDdliXT50
 +7BV0JeZUMHABdrM09Qxbo/I0HAwFvfESz8F4cL2/h1/+LFLjkGGETaCD227DL24VyiI
 b0jvMDQxc21SLGqcQ3c/O0xyxEMOdNW4QXbE/oCB3rv8qJypcCTvA+Eccfuv3k37Zx08
 k1dQ==
X-Gm-Message-State: AOJu0YwjpfpHtqFVm/vqBCiGxVzKeoYxIvOUAlBFzLwZ+JD/QyX2U4gM
 /YAr0drcN7HFc9WdD6vE478kNhcWtyBlaHeEMiwAufCp+uAicKtUptmQ/WWHf68TfP91tmQLHAx
 MT3txFqI=
X-Gm-Gg: ASbGnctDSvRf7Gcy40YOvolWSI49q06CFMUYfKnocScL2pL0XbimRNYtgv4JFpiJuIu
 zfZwNXGm+ndqmBjduCIkx4h0bQl+j1pIkhD0lTBwMiLxj9fTrDKdvYBvgcCOQVzWtVja4shG/7+
 NDakl9nZ52a257WUf/M8NnwDiFYm/9kmkm3AsKRDYZu7+6Cb7uAJLRy1srtGHaNrMmgSlBQs7w/
 jEW4owF0IOmy9xmlOUxGSuE5PiEmE2oDHlw9cyjjRuxQTh0rQ6IyjXH/MxAEh8VgEBrjEBJMD5Q
 E3tm8kH3BAU0DOX6O3FBTFTvwH3FQzxwXJHmwf87Gm8tbWctXlBuGJaphbcWjhh9D+eIhepiM10
 wkPKBfWYlAN+XvtRflQ3qHktJHw/7HtaIxfQMLOwrK3hddw==
X-Google-Smtp-Source: AGHT+IECuoN9SI3WJVaYQ8UbPL01dMYz7L+gYRudquYjCkk0F3MMQAmJ8sb2A0h8U5VkNznuy7Jv9A==
X-Received: by 2002:a05:600c:1914:b0:45b:8a6f:c6de with SMTP id
 5b1f17b1804b1-45b8a6fc825mr157000985e9.29.1757073092245; 
 Fri, 05 Sep 2025 04:51:32 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm194285115e9.19.2025.09.05.04.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 04:51:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH v2 3/7] target/sparc: Loosen decode of RDY for v7
Date: Fri,  5 Sep 2025 13:51:24 +0200
Message-ID: <20250905115128.376295-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905115128.376295-1-richard.henderson@linaro.org>
References: <20250905115128.376295-1-richard.henderson@linaro.org>
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

Fixes: af25071c1d ("target/sparc: Move RDASR, STBAR, MEMBAR to decodetree")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c  | 14 ++------------
 target/sparc/insns.decode | 12 ++++++++++--
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ece393fffc..cfdd9c1ce4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2863,18 +2863,8 @@ static TCGv do_rdy(DisasContext *dc, TCGv dst)
     return cpu_y;
 }
 
-static bool trans_RDY(DisasContext *dc, arg_RDY *a)
-{
-    /*
-     * TODO: Need a feature bit for sparcv8.  In the meantime, treat all
-     * 32-bit cpus like sparcv7, which ignores the rs1 field.
-     * This matches after all other ASR, so Leon3 Asr17 is handled first.
-     */
-    if (avail_64(dc) && a->rs1 != 0) {
-        return false;
-    }
-    return do_rd_special(dc, true, a->rd, do_rdy);
-}
+TRANS(RDY_v7, 32, do_rd_special, true, a->rd, do_rdy)
+TRANS(RDY_v9, 64, do_rd_special, true, a->rd, do_rdy)
 
 static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
 {
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


