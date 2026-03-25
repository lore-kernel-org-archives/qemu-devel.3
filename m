Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B1C103A9A0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ED3-0003Dg-SJ; Tue, 24 Mar 2026 22:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5ED2-0003D1-3v
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:43:04 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5ED0-0002hU-Lk
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:43:03 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82c28f0a4ecso3047800b3a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774406581; x=1775011381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXFYKSBtZ3rl5sjFkHrU2KpK/1VnbUweUNCoeUTZG00=;
 b=u9h8pdBcw1sQ/nUHEB5m4sZH6M3+DRdFjXOuwtEDgk1UXuavjlre8Ya3gBUh/fWzj6
 tVslWmXtMVlINpnY15rLtH4qDRHUM05DDe43gkTs9LFj1/4bAN/kkqGE5jFAJWJX0fEj
 BBOggac9poWeCZuSv1Uuc049MCoYCrg79nJvNjAxKp3i1D9dZ5ISaHwd3BcJfFWh8vOH
 D/4Aoc1tt6eur3+xIVCUp2Td+I821MyKnZOT6k25jS67jMYhrpVvTpDR77kTXkdreC8S
 MZvGPZMofZSYq5dRsf2iKbFKxU9sFkL1qOd54F4CbtwX4KYxNtzBzEClAxjbFH52bJrc
 L3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406581; x=1775011381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HXFYKSBtZ3rl5sjFkHrU2KpK/1VnbUweUNCoeUTZG00=;
 b=Pu5rgbfZgTdfuMsZ5FqHmZAZWwfLi6R2+ylr+4Kbdl79pQJ7b7cL7ju0ehbKKylK7x
 bQjE2CKfHzfdlKSpXb/sLkFIH4apEo70SbV8VihjfTIQB26diExjFA9DwYVCB+M8DJOO
 n2q6jc4rg3HhoIu/H7iFLyOWow6uBxkJJeihvtLmCCua6YdmWHIE46t+ngX51WVC9I6a
 iw0lhUsDDfVFuX/TbG288idKn0iepvx0GdCzibVdHBsXPYMUxFcxyvarPRd8GFqXND2q
 /ZZc2sr1Q5uXRikLCVttiiF6YNrROl1T//znCWH916veP731U5720y/2L2qRvAbKYGfD
 b5iw==
X-Gm-Message-State: AOJu0Yxzo8B+PxkQbu/mcsXkEouzgclN+DSZzCiqR1kl29G0WlgxnJIx
 AGxV3cS0ffRygLyMH5bMB69Z/4EI7bAbBfzynfJuLSLVdvNVbgcG+5fh28zOTv47sPq2mI6M5+Y
 Fbjg7QdM=
X-Gm-Gg: ATEYQzwHdZJpKFd88dG0oV9o2Ak3EOYLNZbQKE0754mpMROgpLl127Wd9/qTQljvfxo
 /zfY5UyozIw+ngbNDw8GimDcPtknKe3KDiz75LKuzP3G3w3bphwpTNMOd51xSTF1gavTM+E1VbI
 nSWcu/a/yskOCyhfCL+Ap99QLStgtY0jOdYBCGXymCw3uzCTzxvS+UpjhaLHgZXEc3pDN6FB2Hq
 IbmlEdeWvvYhfqyQ/tjww/NwAR8eVHP1N4ot+UJYKpCcyfnuvK3w2+5ct2F8deA5fQkqOcDJDP+
 3muI83KlFgFGEXIUpZ+vg0DFe+2zD0s8VZT35wzfCahWMHny/sM8Rgh6heVAREYFzGN6S0eb59/
 5fVifXCBPA7Z8F7onGRrpHAhsxNXKeOPzrsE/Kdcw356+BsZAHTX1o9oLtE7CC6tMZTBmmRsyPl
 F0cbb7lTzeO+7Rspmt6Vk38NvdwHwN7StlrRhqSGeuwH1Q2zacEn11UG0BehF+tVH45tscv60ZL
 38X
X-Received: by 2002:a05:6a00:f89:b0:82c:6c90:c77f with SMTP id
 d2e1a72fcca58-82c6e1353a3mr1742795b3a.50.1774406580978; 
 Tue, 24 Mar 2026 19:43:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b04222f42sm16762716b3a.61.2026.03.24.19.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:43:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 3/3] tests/tcg/plugins/mem.c: fix endian swap in
 update_region_info
Date: Tue, 24 Mar 2026 19:42:52 -0700
Message-ID: <20260325024252.3369186-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
References: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

value returned by qemu_plugin_mem_get_value() is always in host-endian
order, so we need to convert TO target endianness and not FROM it.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/mem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index 1ee257f855b..6b0732dc0fd 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -154,20 +154,20 @@ static void update_region_info(uint64_t region, uint64_t offset,
         val_size = 1;
         break;
     case QEMU_PLUGIN_MEM_VALUE_U16:
-        swapped_value.data.u16 = be ? GUINT16_FROM_BE(value.data.u16) :
-            GUINT16_FROM_LE(value.data.u16);
+        swapped_value.data.u16 = be ? GUINT16_TO_BE(value.data.u16) :
+            GUINT16_TO_LE(value.data.u16);
         val_ptr = &swapped_value.data.u16;
         val_size = 2;
         break;
     case QEMU_PLUGIN_MEM_VALUE_U32:
-        swapped_value.data.u32 = be ? GUINT32_FROM_BE(value.data.u32) :
-            GUINT32_FROM_LE(value.data.u32);
+        swapped_value.data.u32 = be ? GUINT32_TO_BE(value.data.u32) :
+            GUINT32_TO_LE(value.data.u32);
         val_ptr = &swapped_value.data.u32;
         val_size = 4;
         break;
     case QEMU_PLUGIN_MEM_VALUE_U64:
-        swapped_value.data.u64 = be ? GUINT64_FROM_BE(value.data.u64) :
-            GUINT64_FROM_LE(value.data.u64);
+        swapped_value.data.u64 = be ? GUINT64_TO_BE(value.data.u64) :
+            GUINT64_TO_LE(value.data.u64);
         val_ptr = &swapped_value.data.u64;
         val_size = 8;
         break;
-- 
2.47.3


