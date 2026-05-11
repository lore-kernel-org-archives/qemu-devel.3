Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C3BCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRE5-0005c7-9w; Mon, 11 May 2026 10:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRDs-0005J4-5c
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:03:04 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRDp-0006Wo-Cq
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:03:02 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40946982a78so1467521fac.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508179; x=1779112979; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QSmDQRrB6e1D8na4i2hbR1VmlezIVrTYO+OHtxE4XeY=;
 b=TPPygsf5EzsQjBHBXjNKVCqJziHkjg1jhNikpkz+Ee1F8PPxmf6PgbCdp1DDjq3u+M
 dmD2sBu3BcTH5f8avmdCm1jmwrmbyJdZEXyJQv+EG/nc4u8TYohvhXRunTScquGIOjp0
 7hmB77oS7Haz6MW6+0wlvrxzpJD+Ze/+IKGHjdgb7Sv+yM90471uNpS9S0gaDB6JVV2j
 4PbokPtOy09/ShslvhR5hmZWm6y35qQ1yhM/HqNDTeKqxlCuu7Pa4xBuhnFe72wICgV2
 /Chli/CHbqEb0I80M7H6q2M+JTY9194WWp48YLqFNkVaHbrS4z4GZQtPnSeT32nB+Z/u
 kATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508179; x=1779112979;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QSmDQRrB6e1D8na4i2hbR1VmlezIVrTYO+OHtxE4XeY=;
 b=G8NP2MwYaMqU/YKXnRN2eUZidWRZK8XhmOhTLDAnA6WL5/XkBkuh892WQEQNJheF+q
 GaNq3tUWOwJtm31Bsy6x1AlwicDIrqoKbclvM91aDf7s5wLtlFhDGt2Cdi2r9GMft2Sn
 p+PLVrYyx+Kn1X5l1KI6S/JI7sOx06lAgvO+7wxz8lXxkIxeI8UenV7WnLWMI2Dk0uDt
 o4GoyNt7HZvJPvpvTd8+5zaXlyJFsEZGWO1H/hQjRBLwYWi8FU1+Sink87l2ezvKlWmE
 mbsxcBUVluMJBP/NBjAyymn8Ysri8L4bRlW5XpchgL8JdUd87dQUGGfgQBx59fL/p8ZQ
 XhfA==
X-Gm-Message-State: AOJu0YwJ/6rF+oJBqu8tl/b7FHFaodKHy+EQZRlP6fVbddAr8J7Eolkl
 gK5EUuFff05rQi5vdZcqpgY8optXcpnXCKmli5MrL2VaRqIXhCIMPqvBjHvj0qa9
X-Gm-Gg: Acq92OGBYre0zmqQLxNVZQrBD4+Cs3cwIQL+eD60ECBXlFkUh4Fd58/BQ/TPNJn4HCw
 QgW0qJjxW09e4dLz+wWLA4gCikiaeyXGlA8NCCQ63xL+fswVM0nSXWTHTuGrMbG/5hWAzYqn5tv
 zIEbAo50PwtfnEXTIbGue1tJv/F/Nqct/XNKJv43ZxiNXJJgdnLpE24SaLmYex9mRX/PUCAD9XR
 x7AlGmcj8AQ/PF7rvzgC235YLWxtr5UP6O4sAI7QH4mYuLguBHB734CZ/gA9H9bJfiJ0rU78r5/
 tGh4kMQUQd7X1D+gUDnouDOvNJupfcqE9nJi/x4fRkWyMoHWUdC2QLUVI5O0+OCa5cY4cDdhs6I
 Jxhg9qMkShf6eKqC2ZeL/bnLK5YXd3KGa663XMc0/Jlyos8UsxjK/DwxFoX7c6WoPBfsMXq5SOT
 YoLVodfR5aGTR4aRgDi4IuJk21xrTqH72/MQJoE5Zv7UBexunATCk=
X-Received: by 2002:a05:6214:1c4c:b0:8bd:de6d:c349 with SMTP id
 6a1803df08f44-8c1a461dd4dmr154548546d6.30.1778508076311; 
 Mon, 11 May 2026 07:01:16 -0700 (PDT)
Received: from [192.168.1.160] ([2600:4041:54f3:a400:c013:3550:ed5f:a59a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7dd09sm94773756d6.31.2026.05.11.07.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:01:15 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 11 May 2026 10:01:05 -0400
Subject: [PATCH v6 07/15] target/arm: add canonical tag check helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-feat-mte4-v6-7-8557cc1313b9@gmail.com>
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
In-Reply-To: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778508062; l=1412;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=kFLv9CCcyzQ9X4nylsyRnwd9Y7Ab46WH0h0K69LE1Qg=;
 b=p298eyZYu8co5o2bs9nJ5yeIrlqOm4daIqSYwX7p56E6h96q7q+ikYqDei2aprQGnZLQEiilh
 vQNBpSqJC8vD0mw9si2x58vTkCieWEwqLVOsA+zXfz+wjRbZV7s2/2z
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=brookmangabriel@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add a helper that checks whether mtx is active from MTEDESC. Refactored
an existing function to use it.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6df2c547c5..192e6a2d47 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1636,6 +1636,12 @@ static inline bool tbi_or_mtx_check(uint32_t desc, int bit55)
     return desc & (mask << bit55);
 }
 
+/* Return whether or not the second nibble of a VA matches bit 55.  */
+static inline bool tag_is_canonical(int ptr_tag, int bit55)
+{
+    return ((ptr_tag + bit55) & 0xf) == 0;
+}
+
 /* Return true if tcma bits mean that the access is unchecked.  */
 static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
 {
@@ -1643,7 +1649,7 @@ static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
      * We had extracted bit55 and ptr_tag for other reasons, so fold
      * (ptr<59:55> == 00000 || ptr<59:55> == 11111) into a single test.
      */
-    bool match = ((ptr_tag + bit55) & 0xf) == 0;
+    bool match = tag_is_canonical(ptr_tag, bit55);
     bool tcma = (desc >> (R_MTEDESC_TCMA_SHIFT + bit55)) & 1;
     return tcma && match;
 }

-- 
2.54.0


