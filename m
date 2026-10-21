Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689D2606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EVF7M3kj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX8H-00038S-4G; Wed, 21 Oct 2026 10:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX80-00034w-4E
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:17 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX7y-0001Um-JF
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1d293b293so4546875e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592233; x=1793197033; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/l7pwoYKX5eULqy7k7jeTGOY07YBYGIqNnMSc7kciNA=;
 b=EVF7M3kj8/TNyh8W6K87o85rzFPApLEz2dAJKAaA5COrNywU3LByvl+IN5hrxRlCd8
 bS4dHkXSuXCA32hh8I2kRdskGaTPN8eVuoHVtickT7KQdnITUaJyZaFy7XYCmsT2e9qJ
 HgJXDOr2aEUOxmB23zJdVoP0yFlHRdVdjzHst97Ve2MAHfF83EXsA3Su7ulPUn5Y5LaF
 RRYJEikukJVrNpUCqy3YdLOMaibo4B1nOYSiALH0DXbx289SUTblYBi233RJxVfD4ttp
 xljarEoEeQu8dPDMEhNoVHAZ6W5PSqEHV3qEF9gSvMLsk+Me/GgTXX/49jnoFZhLhiQa
 GOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592233; x=1793197033;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/l7pwoYKX5eULqy7k7jeTGOY07YBYGIqNnMSc7kciNA=;
 b=MDsr9zIo0MLoi3Kvsfu65g5L59Zc7yqkhDGaggQ/hOv+QtGCx5msGBmPJqybjXD2yE
 kpPB2+7c7cYLTFYCvalAVk2YMz7ThuXJgeR7om4raEA9YKMuMGOKxpXrIQwoaQjb6z/P
 oDOTjah23wDp5U+eyGPIGHmPpRcUK7Pel/HsybHeqXHAYYcBJcl9z+8Y82bIHnoGojdt
 0Jo+bRasM7ottkXeUjHb/bbVEhjP4/o1+unjXgFnxrsvQB8frC5oiAqWZ/gybrdFEmmS
 GNBNqOqxp8MWDc9MSzTEtD4coQRXGugFww4E66lgEDDY5QQrr9F4pAGBCAEp95ExcCaV
 qcUw==
X-Gm-Message-State: AFq9FYJVtzaZIndiV8CYCTamHyYe+VXHsRhNlctUBywJmft+/YCPbhp0
 8vqRgD/QZQqN6v+2vi8ftRiKJAxngmveBf9yzp0J6HFC4foEuJujj6ZyYHtu3d+XEwZi0UMZJ/A
 4+AhVUag=
X-Gm-Gg: AYBFou2p08G7bK629WRfvPqZ2EUiISuE+tESZCLWcC0OnwEX1/EpvKri+ZaXX0HqKFl
 4NoiAJNd9qay0HrM63bPSrDB9XVGkbG3tCEgq+rkYSuTI5DxeX0suXIAAaE0WQUdM5WZyl8cZSX
 uoxAMN0lY4CVIE75TQMnI77k2I8NDYo/5PtOpEtfIzsU8U1bwBZMLMcasRzKr7LLv1jfZ+kHeT9
 jRK94wOzgqPND0oeYTkp1q1wSi8x3Eb1A3rFWI4KgaJn2KaYiPJURO7Z9K2uAQsGuczCHgu8/kN
 a5JFZE5YdVRmMSNbPwCKNnc1aRgYMB0j4/au7BMG5S+dXSykMRfkhmGP0rZOn85Sogk6oL79vQX
 uJdMUqZxjQjLmZxfIN6IJT+Chq6FeOfFcMz8ToF7Y5B59Oj5gfqd/jFqP9VLiOgdnwbhWvEXIcP
 q+27lglRlUCVWGMWSjHJRaoqIVERYy+4/ZyBQJDtcMyx5EixtYHMrJP4v98L9Ye8kG12r/9ZOj+
 ruVX1dSEyZqimFV+065GurGrbh5h+QSQI1vM2UrBjodOLA7rjErOHrmbNbggIf6/J6stzCdO+3O
 vlJ2wEDsM0OCzMwmpY0bgXICSQUVpSjBwwCPY3JLYC4pM+n/
X-Received: by 2002:a05:600c:4709:b0:4a2:1a:a121 with SMTP id
 5b1f17b1804b1-4a2001aa361mr30948595e9.18.1792592232776; 
 Wed, 21 Oct 2026 07:17:12 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 005/100] tcg: Prepare for easy temp lifetimes
Date: Wed, 21 Oct 2026 16:15:17 +0200
Message-ID: <20261021141652.363109-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-temp-internal.h | 2 ++
 tcg/tcg-internal.h              | 5 +++++
 tcg/tcg.c                       | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/include/tcg/tcg-temp-internal.h b/include/tcg/tcg-temp-internal.h
index 98f91e68b7..932ad1aeeb 100644
--- a/include/tcg/tcg-temp-internal.h
+++ b/include/tcg/tcg-temp-internal.h
@@ -31,6 +31,8 @@
 
 void tcg_temp_free_internal(TCGTemp *);
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(TCGTemp, tcg_temp_free_internal)
+
 void tcg_temp_free_i32(TCGv_i32 arg);
 void tcg_temp_free_i64(TCGv_i64 arg);
 void tcg_temp_free_i128(TCGv_i128 arg);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 2620c23b44..d480d10878 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -74,6 +74,11 @@ bool tcg_target_has_memory_bswap(MemOp memop);
 
 QEMU_RET_NONNULL TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
 
+static inline TCGTemp *tcg_temp_new_ebb(TCGType type)
+{
+    return tcg_temp_new_internal(type, TEMP_EBB);
+}
+
 /*
  * Locate or create a read-only temporary that is a constant.
  * This kind of temporary need not be freed, but for convenience
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 65d3190a8e..c3fdcfbe68 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2201,6 +2201,10 @@ void tcg_temp_free_internal(TCGTemp *ts)
 {
     TCGContext *s = tcg_ctx;
 
+    if (ts == NULL) {
+        return;
+    }
+
     switch (ts->kind) {
     case TEMP_CONST:
     case TEMP_TB:
-- 
2.53.0


