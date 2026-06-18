Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDDECD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa4AC-0005WI-Eg; Thu, 18 Jun 2026 00:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A1-0005SN-R0
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:26 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A0-0005Zf-02
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:25 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2bf22d29dabso3120555ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781756121; x=1782360921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPZ+QWhKOCzUvOJFQw8MMBMoO74ds4ZmhhvtP05m4yQ=;
 b=EnfpRirSXRSlFAsp98iE0BYJt0sTweGM/NKQ6q/dh7bzN6WV3qadhpqckEx05Fhhp6
 TCPd4/5E3baWvBrXI+F1DyLU3nxxm3UxtxFSGt1sT+QaOcxKVxFcfJ9Eienj7GzVQSsM
 e6CGNT7r+AMesWGBVotvjo1SS13ffkxupaRvMhJ0yMRyOtb9Ev56OklKn+VIPC67VDCe
 1ZHvnYnXMNwHZ6L1Cv4YrSGavDRPkjDBaxnwipRi5wRzA/05lSc9gt29ixwzbpED2ehw
 0yOjNBB0Ads2o4MxHTYpvvLsv7LlhJMjYbmgSVQqxugHJGkiKVz9GnC9gk050+dlHWP2
 H8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781756121; x=1782360921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uPZ+QWhKOCzUvOJFQw8MMBMoO74ds4ZmhhvtP05m4yQ=;
 b=E48oxzIEhvw1kpZZRn9ktOcXm+ATCgcRXPhMGTufr+kznb7hkrd0Tqm5klBU0gszKp
 Hu2mcwOFQ9j89AzSX/7uFmYI6ly4kjHlniKGUjaWYl7lWYX3ttxHBfdAK1LimZiNPqzr
 8mtNKVaqsdIJG4JKNPDbBq1484qrVzxkeaBYybDLeX//zFx+nwXqG4E+9WdFw8hzPeNz
 dVBEoCu6wve60QkH3QyTVZVthY49uCF6BbJVpxgLeTpXzR92m1SHMuRhiE6WaKMDbyI0
 +4c7ebL8tIXrpmdXocDopECXP/eaAkZrtOoRsQHoza3AFiglrWjjTdlEeS+5DCo6F3/9
 CETQ==
X-Gm-Message-State: AOJu0YxH4IbbrU8Bg3DSx+Y0OyMGdyOTJ/mVr6J3RWVbRSVNd9qXtV7o
 2FcQjzvhPg/1p+zh9cbXldMv/b30kDlGZCN3aVqpYV+U35b0Zv7DTs9uea0ToUlpHygzCt6GG+0
 1ImK6
X-Gm-Gg: AfdE7cnM2Qb8F9l0bgAWWcALJwg0Ky4Wh2FifBRMjmyTl9/5jF6YL8TNstlz+TTWRMk
 3CF8QbCnEGQ9vpH8u0hWYumQFDjcNJra7/ySZo/LzAS8qWq+4iiflpeknkV4GzxpMnWFA1cU2z2
 iNymQ3gty7kDeGV9ckLwHS3ofRIbj+wdPsVYqyxhWavylt0yDUPFjUw1jX853SVw7SzbdS/v0JE
 6PKUAk2rBx6HcoQ2ezLJdbBK9SOL+PIO11ntWOHJiLCfpDYYevFb7+cn9YFKx9llWletAL/WnCA
 mqKb20nROX7f1RKpq2LmQnwTgj3dV0SAk37+s9FePm9ut0PQpyQkvojjq1/yQ3iG6FWy5f+8sce
 tCRVgZUasZmWXNhf1nAtaU57WUF+zseoIgE2g1FCgAzC31TCl8z+a0NXtMt7VnYor4XLnUY3UfE
 2ce6aKwMWt0TaBiDtDVK3BjjqRpHeWKgqYnB5zksm4Hph3d3/a8g==
X-Received: by 2002:a17:902:d543:b0:2c0:c2c7:58ad with SMTP id
 d9443c01a7336-2c6f3427af2mr7728025ad.13.1781756121486; 
 Wed, 17 Jun 2026 21:15:21 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e535csm173905935ad.6.2026.06.17.21.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:15:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 01/10] target/arm: Move tile_vslice_{index,
 offset} to vec_internal.h
Date: Wed, 17 Jun 2026 21:15:08 -0700
Message-ID: <20260618041517.573469-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618041517.573469-1-richard.henderson@linaro.org>
References: <20260618041517.573469-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move in preparation for being used outside sme_helper.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 31 +++++++++++++++++++++++++++++++
 target/arm/tcg/sme_helper.c   | 33 ---------------------------------
 2 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 06fef2a209..77e5b01550 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -55,6 +55,37 @@ typedef struct CPUArchState CPUARMState;
 #define H8(x)   (x)
 #define H1_8(x) (x)
 
+/*
+ * When considering the ZA storage as an array of elements of
+ * type T, the index within that array of the Nth element of
+ * a vertical slice of a tile can be calculated like this,
+ * regardless of the size of type T. This is because the tiles
+ * are interleaved, so if type T is size N bytes then row 1 of
+ * the tile is N rows away from row 0. The division by N to
+ * convert a byte offset into an array index and the multiplication
+ * by N to convert from vslice-index-within-the-tile to
+ * the index within the ZA storage cancel out.
+ */
+#define tile_vslice_index(i) ((i) * sizeof(ARMVectorReg))
+
+/*
+ * When doing byte arithmetic on the ZA storage, the element
+ * byteoff bytes away in a tile vertical slice is always this
+ * many bytes away in the ZA storage, regardless of the
+ * size of the tile element, assuming that byteoff is a multiple
+ * of the element size. Again this is because of the interleaving
+ * of the tiles. For instance if we have 1 byte per element then
+ * each row of the ZA storage has one byte of the vslice data,
+ * and (counting from 0) byte 8 goes in row 8 of the storage
+ * at offset (8 * row-size-in-bytes).
+ * If we have 8 bytes per element then each row of the ZA storage
+ * has 8 bytes of the data, but there are 8 interleaved tiles and
+ * so byte 8 of the data goes into row 1 of the tile,
+ * which is again row 8 of the storage, so the offset is still
+ * (8 * row-size-in-bytes). Similarly for other element sizes.
+ */
+#define tile_vslice_offset(byteoff) ((byteoff) * sizeof(ARMVectorReg))
+
 /*
  * Expand active predicate bits to bytes, for byte elements.
  */
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 8e8e6c00ca..685b6b46be 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -64,39 +64,6 @@ void helper_sme_zero(CPUARMState *env, uint32_t imm, uint32_t svl)
     }
 }
 
-
-/*
- * When considering the ZA storage as an array of elements of
- * type T, the index within that array of the Nth element of
- * a vertical slice of a tile can be calculated like this,
- * regardless of the size of type T. This is because the tiles
- * are interleaved, so if type T is size N bytes then row 1 of
- * the tile is N rows away from row 0. The division by N to
- * convert a byte offset into an array index and the multiplication
- * by N to convert from vslice-index-within-the-tile to
- * the index within the ZA storage cancel out.
- */
-#define tile_vslice_index(i) ((i) * sizeof(ARMVectorReg))
-
-/*
- * When doing byte arithmetic on the ZA storage, the element
- * byteoff bytes away in a tile vertical slice is always this
- * many bytes away in the ZA storage, regardless of the
- * size of the tile element, assuming that byteoff is a multiple
- * of the element size. Again this is because of the interleaving
- * of the tiles. For instance if we have 1 byte per element then
- * each row of the ZA storage has one byte of the vslice data,
- * and (counting from 0) byte 8 goes in row 8 of the storage
- * at offset (8 * row-size-in-bytes).
- * If we have 8 bytes per element then each row of the ZA storage
- * has 8 bytes of the data, but there are 8 interleaved tiles and
- * so byte 8 of the data goes into row 1 of the tile,
- * which is again row 8 of the storage, so the offset is still
- * (8 * row-size-in-bytes). Similarly for other element sizes.
- */
-#define tile_vslice_offset(byteoff) ((byteoff) * sizeof(ARMVectorReg))
-
-
 /*
  * Move Zreg vector to ZArray column.
  */
-- 
2.43.0


