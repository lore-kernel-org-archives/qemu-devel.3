Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0469EC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAg9-000767-8H; Mon, 29 Jun 2026 08:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfQ-0006qq-Uv
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:50 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfP-0007LZ-9V
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so839794f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734446; x=1783339246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7lR7Tonf1+bbpt3Sq4KZxZhoKMSzg6FEvdecxKcxMM8=;
 b=W/O1Y0RDc2v+xk342XNxvW83wxwsUtzcbTtIMqp1nJfvJc50l62l8gLk6emEVjNL1l
 cFF9sslNk0Tifrh6oFQCsaBOIA+Jv/v1FXGDu/ca00oRpp4jsEJ7+g4AyxMIzk9w+GKM
 CVph/nVDIxIunHJ8H+xUVmpAT7wSxtDF5f7MZwwgNV81o98iVBicJmagodEUL/EGag3n
 bFxIT4MCm+8F472fJMQsLPAEzL+XYiO3s0jyP7X58QE/FAKWiUVMqOoSflq4vujO7/Qa
 wWfR/jfazEj0g+TE3/IRooDZ0ztHN14i///jz0nEeMNxGz+lrlfO5AObVvzhonlZ+CQS
 sY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734446; x=1783339246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7lR7Tonf1+bbpt3Sq4KZxZhoKMSzg6FEvdecxKcxMM8=;
 b=Q1rzZqPmzcfmasCNHvliuxN90U7ipE2gLtgttpcmQGZ8Ry7QATCuHF/gwZeYZkZ2N0
 2KE3nYVHG2T83nQTXhEbEMNQ2QS/u2/Ngt1EQLIHQjilQCRHgHcfKPVHPaaCTL1921rX
 OLRmXMduOrGhTG1l3hNcsh7+xzY4nBBjHWwmo9cfctJsW7XrJN4wQko8nUpgOfzUbakV
 0Lkva26TQD3F9o8V8AZbpD4okzwPjOKxcIbkgQ+IdrdOyhrAFo6SxrCtpd1ffBvtlY74
 dSX7rdIwO3RqLO/j3DQoKkSFUJ42goSC41kQvFpb9Uvrm5S7jZAb3aH/wjuT+KW+LhG0
 Cnsg==
X-Gm-Message-State: AOJu0Yz+y1jAX6HPdEXjBJA/z/4KHMKUIq+BJZGFILCXZjR4G14YHRvm
 AS31TQsvppA1JQHeX3iQNHG2Sq7E3D9Pv2+xpSonn1qLdWB5RWhItMWJRZd2lWjPs79XTzGMXfH
 WE9II
X-Gm-Gg: AfdE7cnRDhxCx2zooNs47Pti8CikucLwyGm+KswuliCH752rUCsEKXyr7BLksnhq1Iq
 hoHmYO8vKt5DU8xCxB/3HnMBOQng12Ice3piA0wFhn9Xpo75JEkzMibSdZJPf/HE6aN618Ed8YY
 vTJyarXnNebTM/uGOSUmcoQM75ptZzM8i7Tos9/ZB/WzwDfd78eMftI5+TdT6M6DupV4T1eMLIn
 SPzJMf2NRby/2lRQoYLxp5Ubgt2JzT4CpH2qXOCC9+yAycm5uVUwK4P8axMFrhaLgmcP1+nAhY1
 Yp3QC8h3PElVlk9Y99OWPXsPWo3uZUZ7seZjW+hPUg+E/WIYTKO4QmmHfLxdI8B0Ke7ARzEL/kI
 gjZ8dCFBPI80MyK+pNoUCxmtICAFsNpNHP9VVBkU/aU7qAFT1IeYIH3X5ELW+FgAEUlEdTlaBN3
 SBeMGfF4Daa3G+I/Es8c8B9tkBzhmIsFo8WQNccesOtcC/JlHybxqtx5hYuzPT0TZbJE9BukJZA
 s6sCBDUoJrfq06X4M17RazpIwQDjYz6
X-Received: by 2002:a05:6000:25e7:b0:461:a5d3:915a with SMTP id
 ffacd0b85a97d-46fb6bf2c9cmr18285765f8f.6.1782734445487; 
 Mon, 29 Jun 2026 05:00:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/54] target/arm: Move tile_vslice_{index,
 offset} to vec_internal.h
Date: Mon, 29 Jun 2026 12:59:48 +0100
Message-ID: <20260629120032.1645265-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Move in preparation for being used outside sme_helper.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260618041517.573469-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme_helper.c   | 33 ---------------------------------
 target/arm/tcg/vec_internal.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 33 deletions(-)

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
-- 
2.43.0


