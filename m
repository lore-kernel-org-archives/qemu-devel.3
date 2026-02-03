Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13C3E8B375
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 23:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnPOO-0005xm-UM; Tue, 03 Feb 2026 18:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnPON-0005xU-Is
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:01:07 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnPOL-0006A9-Tp
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:01:07 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43596062728so179968f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 15:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770159664; x=1770764464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gyCOlYHu5QJOiJNJo/S/cqdZ5Xq9v1xJdHYg0hHKNtQ=;
 b=ZJF5pKQqgZDizet3LkA5X/CGx+jEEXYmfL0nZWZPFTF0SXFSipreRJNhVjyChHxRIw
 Pw7T12Q0LvGY4azfD1lnQvaq/xH1N9iFInDP/8tRF3mlEdxDWGqC0vVxbfPJipFQOZdC
 Z6UXsl4hh+UVdgEbl+/GLWUgbuIpwb1OX166c5W13+O2eQjPl5V1h3X1UxsqFRWj1YDC
 xr5AlnK4O7KBoTNChZxVG4uTVNFvjolE75IOJvsXeWq9Y5XehEIUHenOzO855n6Gkh/s
 E5KXtVvhA8XHc1QKJMw02Yy3dTU6egCIXFeyVz61L9n+BIr/BdPstzMkZ0j5PCzhFZdt
 gBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770159664; x=1770764464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gyCOlYHu5QJOiJNJo/S/cqdZ5Xq9v1xJdHYg0hHKNtQ=;
 b=PBBKj4SFrnYZCrtKqtArCryyiu1UggCISaGsZmDm35lakho6kNvHUpBg/SxcdmS7cb
 IJTQKNZFWqDhi0yuZF0U1HTbsAFC0m3RyDaDeEKaMycQzxK9K1zH+bI95pMugHYd8bqP
 j/6W7CvumbV6xbqovRJdsexiBJ4JYNb57GjxGN9n4pUALNTu4KdfEU/g3M1RMbXDmOvx
 k0ULAoAAbpk/bB6yZksdfhpB9Bv7FNUWbQ7ugy9IflPhQlqIhiFxgeEfQiOH8quq+xkO
 8btr5zPTVZO29E1+e8EoqiEe67o7ibX9rQP34wBE/XIV+NOZ+gGqYKGLlIDBZWJkkl0n
 wwPg==
X-Gm-Message-State: AOJu0Ywl1Nz5lIY66L1W64+a9M0uzOH+6gSWsba4YkCRTcDyVVqwOiFy
 ESPLTN10Q0bFOayjC2R7pDM3N6pcKKn7X47Mg1Eio3nm9xnEjPSpWmdIpCTwnLcd8khVOD/UAv6
 pu3tUcSY=
X-Gm-Gg: AZuq6aJWQ9h0wx9r+HZ5fPvEDTVkABbP1Tnv1zzJalCPy9Z/1vbQTieVdESIDpvhT6I
 X1So5uNegbv6T9xt0Vv4K+hIb/kzQU+9/kR601u/Uwy5WUaYfUTGhvoRQzNcOvoaUYrHI902wsd
 oLqIv3CNCLQeknVCr/XizwjGPsiF+FKiyRdjHI55lOrcTFO2A2z7UNKrZ7LNa9Zx7BO9I7tR2Q7
 sojOsT0o5MWGH9d5zI2Ffys1dPQ287spdCEc0AqXBLzoTCFHq0CPMxHI85zHZ7/6o4fBk6l752t
 N9WECWtAT6NgVGX1RwZprJP10YKlMxIX0gQoLc5c8dZVCQbkfaT8Unpgm+zIpQvDGovpDLnf+Qz
 vDXLb+F8fYOKzGaIPVBFCg6YdpL9vXrBZdexLzw0m8vIXACxFEbltjN8n0TcmcFoKP7HwrM1qlg
 t7fm6DV87varF/zBJ9KSTYi5ZG1Nabzad2lSaV3tW2BDcjPbOrAe6dMTBrg67f
X-Received: by 2002:a05:6000:18a7:b0:435:db9b:5881 with SMTP id
 ffacd0b85a97d-43617c8d34emr1479454f8f.25.1770159663611; 
 Tue, 03 Feb 2026 15:01:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436180659b8sm1673406f8f.43.2026.02.03.15.01.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 15:01:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v4 1/5] qemu/int128: Add int128_signextend()
Date: Wed,  4 Feb 2026 00:00:50 +0100
Message-ID: <20260203230054.23667-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203230054.23667-1-philmd@linaro.org>
References: <20260203230054.23667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Add a method to sign-extend a Int128, along with unit tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/int128.h    | 10 ++++++++++
 tests/unit/test-int128.c | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 7b3b071c512..c2d6c183393 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -62,6 +62,11 @@ static inline Int128 int128_exts64(int64_t a)
     return a;
 }
 
+static inline Int128 int128_signextend(Int128 a)
+{
+    return int128_gethi(a) ? a : int128_exts64(int128_getlo(a));
+}
+
 static inline Int128 int128_not(Int128 a)
 {
     return ~a;
@@ -295,6 +300,11 @@ static inline Int128 int128_exts64(int64_t a)
     return int128_make128(a, (a < 0) ? -1 : 0);
 }
 
+static inline Int128 int128_signextend(Int128 a)
+{
+    return a.hi ? a : int128_exts64(a.lo);
+}
+
 static inline Int128 int128_not(Int128 a)
 {
     return int128_make128(~a.lo, ~a.hi);
diff --git a/tests/unit/test-int128.c b/tests/unit/test-int128.c
index 25db2455e80..526abd02e03 100644
--- a/tests/unit/test-int128.c
+++ b/tests/unit/test-int128.c
@@ -255,6 +255,27 @@ static void test_urshift(void)
                      0x8000000000000000ULL);
 }
 
+static void __attribute__((__noinline__)) ATTRIBUTE_NOCLONE
+test_signextend_one(uint64_t ah, uint64_t al, uint64_t rh, uint64_t rl)
+{
+    Int128 r = int128_make128(rl, rh);
+    Int128 s = int128_signextend(int128_make128(al, ah));
+    g_assert_cmphex(int128_getlo(r), ==, int128_getlo(s));
+    g_assert_cmphex(int128_gethi(r), ==, int128_gethi(s));
+}
+
+static void test_signextend(void)
+{
+    test_signextend_one(0x0000000000000000ULL, 0x0000000000000001ULL,
+                        0x0000000000000000ULL, 0x0000000000000001ULL);
+    test_signextend_one(0x0000000000000000ULL, 0x7FFFFFFFFFFFFFFEULL,
+                        0x0000000000000000ULL, 0x7FFFFFFFFFFFFFFEULL);
+    test_signextend_one(0x0000000000000000ULL, 0x8000000000000001ULL,
+                        0xFFFFFFFFFFFFFFFFULL, 0x8000000000000001ULL);
+    test_signextend_one(0xFFFFFFFFFFFFFFFFULL, 0xFFFFFFFFFFFFFFFEULL,
+                        0xFFFFFFFFFFFFFFFFULL, 0xFFFFFFFFFFFFFFFEULL);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -269,5 +290,6 @@ int main(int argc, char **argv)
     g_test_add_func("/int128/int128_gt", test_gt);
     g_test_add_func("/int128/int128_rshift", test_rshift);
     g_test_add_func("/int128/int128_urshift", test_urshift);
+    g_test_add_func("/int128/int128_signextend", test_signextend);
     return g_test_run();
 }
-- 
2.52.0


