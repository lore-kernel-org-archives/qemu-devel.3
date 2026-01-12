Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F23CCF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQix-0008Su-Ry; Mon, 12 Jan 2026 17:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQiw-0008Rx-G7
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:22 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQiv-0002Uy-1a
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:22 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so54712125e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258159; x=1768862959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yG3O/8zEPTmdQian+9ftZRLTDwFtWAAKWudEcRXMF2I=;
 b=A7zdmRLwASlF2Phq/eUpIXK0yToFY4bdI30IHmJM6LpWfgYnIrRswyjK+EPOFTlSzZ
 LETgLrpAqme78zzxxMVMLhX1paIFt71FHJadFuztBZ2mb2mgSwvWUV4FEmfIdWWGMdij
 5/wS3aE59e1nURlperCgsQZFdS/LzorgK8s09UOcc6/riSzw3mm/lQrpJ6H2kA71w5hu
 o7lIUHeMHzSc2FlgVHRK2YqeP349SjdrAdbhRZYrdKSnh7X/iWpRCVpyU6tW+zve/gR1
 oiPE/+nM4Ui+LRZ3NKN+gj3DZvE6V0QDa+qgWIyCEzUo1qgbwD+HGuESfqK2RTCyyShg
 9vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258159; x=1768862959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yG3O/8zEPTmdQian+9ftZRLTDwFtWAAKWudEcRXMF2I=;
 b=PW1prfFLMXlq7uVyuU7657fhepPH8W4YNLMDa1k9d9Wwk60hZLHMmQ1QzKm5rRO7gh
 ob9SRfzkkrGMDpyFBa5Je/bzge12x7Tfsk31QYHaxwLQMJfulYQxqsIb7B0rtF8QWCFj
 DMbBs9aD/uE15wrLcO/OOmgD+IUFjnKZ8FaNbxmDTS/cW+eCequ82+M7rTzQ/ANpzdMe
 /NVgCGXtezvrHWpap9z0XhxYITbBHCm8tXnIX5TDereEm9PZFHHT4w5UrsEPRMgRxhT3
 Q7qjhaetjlR4T1r1Yh2G7v15m/Uz+ZcLuF5Z1BPM3rcUr5RYAUz30OLpjduqIy5ncNiR
 fsxA==
X-Gm-Message-State: AOJu0Yxh42WrCFAqkjI8X7hrMPvOC/7fKKoSP49bxHpYaqaG6HckczpK
 Xtu/9tGvOfaKkunrC78s9RUb76Y6mngTeJnX5kCwY01tqjtMmru8TArSTE1C3SrTj4cu6zVWGYg
 3AHDSpek=
X-Gm-Gg: AY/fxX4iJg9BdgpEUEzgdCga8/kgwdKLFf5XNAmqtpndmvVIRIdnbX3ZI69aM616+3t
 2wFZ6VHbJn4CCs7GPYMO/N8gP4qYd4tUdOfVF/joaT1YgyCqEdoFiSmaJt0d2VoF7d+LkjeGj8b
 cxAH1cG2P8iP/JNvY1OxP4H06EjnYsW8mZR7MhR56hLCwPd7g44t8F8oRqXY9kiI8mTDfAyaaDH
 OOLFuH6+F1r54f01hQCA0JDvcImGoq1T3jeRn4sUYKRMvp88hQVGlHxyLbIrKtIAKpn+qNOyP3b
 kCex4GAS0g1ViHWewDt5BDXa5bmPL1EdOOtGHx0c/2WLK0cwdHLQ01YRy/rQn/47iubK4rdy6+k
 r7HnKhPF2lJGsU9d93a8XAoyJ7R5z+tDEWA05EMbf3BZf3jjEnlTODq6EGjBqAMImmW0/VDf/Kw
 JjZcoFEQSFjS/1eoti/EK2lwEfKLi5JhirZJmT+wcwqoHDxzhefW6moXlth/8Ww3P+DBg78Mw=
X-Google-Smtp-Source: AGHT+IEPVynFFGzqsQi3eDZGydIZxxsjKtHRhitPOijfX1wO8eKwA33eiBOuyW1qR9YZyIolCqP+kA==
X-Received: by 2002:a05:600c:6385:b0:477:632a:fd67 with SMTP id
 5b1f17b1804b1-47d84b1a166mr223572445e9.12.1768258159318; 
 Mon, 12 Jan 2026 14:49:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9afsm43222151f8f.24.2026.01.12.14.49.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:49:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/61] bswap: Consistently use builtin bswap() functions
Date: Mon, 12 Jan 2026 23:47:58 +0100
Message-ID: <20260112224857.42068-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Since these headers use some __builtin_bswap*(), use it
consistently in all the cases, allowing to remove the
"qemu/bswap.h" inclusion (which only defines bswap* to
the builtin equivalent).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109164742.58041-5-philmd@linaro.org>
---
 include/qemu/host-utils.h | 6 +++---
 include/qemu/int128.h     | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index dd558589cb5..0777a2bb60e 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -380,7 +380,7 @@ static inline uint16_t revbit16(uint16_t x)
     return __builtin_bitreverse16(x);
 #else
     /* Assign the correct byte position.  */
-    x = bswap16(x);
+    x = __builtin_bswap16(x);
     /* Assign the correct nibble position.  */
     x = ((x & 0xf0f0) >> 4)
       | ((x & 0x0f0f) << 4);
@@ -403,7 +403,7 @@ static inline uint32_t revbit32(uint32_t x)
     return __builtin_bitreverse32(x);
 #else
     /* Assign the correct byte position.  */
-    x = bswap32(x);
+    x = __builtin_bswap32(x);
     /* Assign the correct nibble position.  */
     x = ((x & 0xf0f0f0f0u) >> 4)
       | ((x & 0x0f0f0f0fu) << 4);
@@ -426,7 +426,7 @@ static inline uint64_t revbit64(uint64_t x)
     return __builtin_bitreverse64(x);
 #else
     /* Assign the correct byte position.  */
-    x = bswap64(x);
+    x = __builtin_bswap64(x);
     /* Assign the correct nibble position.  */
     x = ((x & 0xf0f0f0f0f0f0f0f0ull) >> 4)
       | ((x & 0x0f0f0f0f0f0f0f0full) << 4);
diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 174bd7dafb8..2b8dd4dec9f 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -189,7 +189,8 @@ static inline Int128 bswap128(Int128 a)
 #if __has_builtin(__builtin_bswap128)
     return __builtin_bswap128(a);
 #else
-    return int128_make128(bswap64(int128_gethi(a)), bswap64(int128_getlo(a)));
+    return int128_make128(__builtin_bswap64(int128_gethi(a)),
+                          __builtin_bswap64(int128_getlo(a)));
 #endif
 }
 
@@ -451,7 +452,7 @@ static inline void int128_subfrom(Int128 *a, Int128 b)
 
 static inline Int128 bswap128(Int128 a)
 {
-    return int128_make128(bswap64(a.hi), bswap64(a.lo));
+    return int128_make128(__builtin_bswap64(a.hi), __builtin_bswap64(a.lo));
 }
 
 static inline int clz128(Int128 a)
-- 
2.52.0


