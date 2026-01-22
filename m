Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED54AD625F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqRf-0004pb-A2; Thu, 22 Jan 2026 03:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqRT-0004eW-G5
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:53:27 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqRR-0005ql-Ui
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:53:27 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so5416195e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072003; x=1769676803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VPFM2Gvq6dkLfo8iUWwpn+/VGm21qBkTKu0qqpqcOPU=;
 b=XirM+jSBeB1cvYW0qsHe1skynOoZN2PymGLJ9Jg//4/fOAIcXt+Pnb0C/SVj3gKx7G
 Qq0+vHTgrYnY231ro1lyjG3TGti+G90YSghw8YHtazt/tS3dKaJFNZej/j2eYPiGR6t9
 vUlX7h47Ox1lVCQjkjYjbiP15Kv7InaN9FDhj/LU+r2ob3/sBftxOhW6oCdYSGHxPsIw
 jaMmZjzUnEzwEdI1M26wkKMTNFFpThMTyapdYz3f01PxyKwjn236EVkh+Qhy3vMZ0hbu
 YYfUcmxrYijv/FDmewQ4H7e6ydW6PQXdot7leBtGGAcRRBZVlj+BzWLI/Qk+xQNXeKue
 uyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072003; x=1769676803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VPFM2Gvq6dkLfo8iUWwpn+/VGm21qBkTKu0qqpqcOPU=;
 b=KCUZGNT/Rb+El9Nu6EML6jdl9u/RSyDJlDpXrctqcQKx7gIg4i6SPM1tkeEx0hBnJU
 PLHxhx80UlrPhZtGHbJs5fVbWLbDn9W1CSU8VOOL5Cdds9eRfELZIk+B0Xiw/a9mg6vA
 ZWxFJxBthC+nwrjF1NYlOZRe53/ferQAutX7v5Matlk4ekr2qUepbfgy8DdSFmEUdVJJ
 N9SP33GBfYzAWX/MeWBM5FLIoPQiwCNV5VBdlZt+02lnjMP8sgB1X7w7K5lbLIRrSp62
 aGGD6C9OYE8k6NYPR87xUCG3CqpPXMN24E6qtXjNpAYMsEkTI5TbbJGUFzP9neri1/8+
 Dizw==
X-Gm-Message-State: AOJu0YxB6Elrke6ng/LYAd00WPs2V2R1RnXE1E2rIaUPdv18Lx8xnpdM
 Vj45ipsSUL6jAJh6Xxof/EBuwWHJRr1U8d7+TdqRxQwdB+dNcxUW6PIAhvLVp6Nqa2diDfVeYPO
 fr6JO3T4=
X-Gm-Gg: AZuq6aIG2rSHDaeQLJOvwjcvOH9LajJcH17FnovKPhrS973uHBIuNFRFxaI3Ibsuy0m
 C90BlL9H+Kkz5Or0lNUh7awLerN6h4OMo2emGUKfiBi3OG9coU3XjNohtc/WDvPwv5MktVEsN13
 Ez+lapg6EK2c4ydBZIwAkGzJVjvN+fgt45sLdPkuz9GsPH4gknuo/CcAGfSdvCjuxHILqFXYZXT
 cUifpMLUWBQcL6GDGbB4x+CYfYOgcYKchua5rKgVarc+DHcZFts/zqrjsO1KwWL8BhqgmVkHGZn
 G2oangZOb4zar0dOScriTZG2i3xGQMun8DNk4LYMekduoueBFAMHRvaO+e+DGFqWVZcV9+Xq48g
 xldRLLzkk7FlGMiZZWr40fTUbEbezKuCb2ugCtnxAZ/mlxNPV36mpZQyLAk27A8NyxgFVqvNBpO
 wRiYOgyNfV5fT4CzvA0XtpfAkbl+DgA8J+oL24K9gOdedrzd2CdBX7LgyUZyct
X-Received: by 2002:a05:600c:8886:b0:47e:e946:3a57 with SMTP id
 5b1f17b1804b1-4802168de81mr249676625e9.36.1769072003510; 
 Thu, 22 Jan 2026 00:53:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356999810bsm43062601f8f.40.2026.01.22.00.53.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:53:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/31] system/memory: Introduce ldm_p() and stm_p() load/store
 helpers
Date: Thu, 22 Jan 2026 09:52:27 +0100
Message-ID: <20260122085255.95035-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Introduce load/store helpers which take a MemOp argument.

Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260118193509.42923-5-philmd@linaro.org>
---
 include/qemu/bswap.h | 72 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 65a1b3634f4..387d65c0b0b 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -2,6 +2,7 @@
 #define BSWAP_H
 
 #include "qemu/target-info.h"
+#include "exec/memop.h"
 
 #undef  bswap16
 #define bswap16(_x) __builtin_bswap16(_x)
@@ -375,6 +376,77 @@ static inline void stq_be_p(void *ptr, uint64_t v)
     stq_he_p(ptr, be_bswap(v, 64));
 }
 
+
+/**
+ * ldm_p: Load value from host memory (byteswapping if necessary)
+ *
+ * @ptr: the host pointer to be accessed
+ * @mop: #MemOp mask containing access size and optional byteswapping
+ *
+ * Convert the value stored at @ptr in host memory and byteswap if necessary.
+ *
+ * Returns: the converted value.
+ */
+static inline uint64_t ldm_p(const void *ptr, MemOp mop)
+{
+    switch (mop & (MO_SIZE | MO_BSWAP)) {
+    case MO_8:
+        return ldub_p(ptr);
+    case MO_16 | MO_LE:
+        return lduw_le_p(ptr);
+    case MO_16 | MO_BE:
+        return lduw_be_p(ptr);
+    case MO_32 | MO_LE:
+        return ldl_le_p(ptr);
+    case MO_32 | MO_BE:
+        return ldl_be_p(ptr);
+    case MO_64 | MO_LE:
+        return ldq_le_p(ptr);
+    case MO_64 | MO_BE:
+        return ldq_be_p(ptr);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/**
+ * stm_p: Store value to host memory (byteswapping if necessary)
+ *
+ * @ptr: the host pointer to be accessed
+ * @mop: #MemOp mask containing access size and optional byteswapping
+ * @val: the value to store
+ *
+ * Convert the value (byteswap if necessary) and store at @ptr in host memory.
+ */
+static inline void stm_p(void *ptr, MemOp mop, uint64_t val)
+{
+    switch (mop & (MO_SIZE | MO_BSWAP)) {
+    case MO_8:
+        stb_p(ptr, val);
+        break;
+    case MO_16 | MO_LE:
+        stw_le_p(ptr, val);
+        break;
+    case MO_16 | MO_BE:
+        stw_be_p(ptr, val);
+        break;
+    case MO_32 | MO_LE:
+        stl_le_p(ptr, val);
+        break;
+    case MO_32 | MO_BE:
+        stl_be_p(ptr, val);
+        break;
+    case MO_64 | MO_LE:
+        stq_le_p(ptr, val);
+        break;
+    case MO_64 | MO_BE:
+        stq_be_p(ptr, val);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* Store v to p as a sz byte value in host order */
 #define DO_STN_LDN_P(END) \
     static inline void stn_## END ## _p(void *ptr, int sz, uint64_t v)  \
-- 
2.52.0


