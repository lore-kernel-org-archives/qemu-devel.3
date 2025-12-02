Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ADAD12668
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 18:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQVD7-0007wf-IK; Tue, 02 Dec 2025 13:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQVD4-0007wN-Cx
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:34:47 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQVD2-0007pd-Jb
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:34:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477a219db05so38097315e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 10:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764700482; x=1765305282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jPSRQNJwBjBJCfJqtNQ1IZ2kMdEHT214puaSI5qicHw=;
 b=QshTnZSA0v8UbicpZPUU2mYmaQSeRyXHjnAzRkVJ/tD5hfuxHPuUYab463RNzyMNx3
 FgKDi4ZHi2Ej+KoAbLgtZncD0Me0ZP/t1BC2UFHHFO2TOnmhUn/toSZulaWW6/aHaWdR
 wAjX0SoBvJ7zEjHP1S6rvcv2r4jfbwJL0t2HW678yci1SgyIeWPEZx9WLobJF32J6CKF
 YcBhT7QEr1EY7b95015XW9LrN0y9L0ciev6AqCP+jSGms1TxBToZLQsDZvgfkhCNBn/w
 Y6KR+3RxWuJo9y4QfmqYRArLOgWyLWSvZgETd3n110AXwwJwNhkmmEN34UU1WdJY5aQA
 NXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764700482; x=1765305282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPSRQNJwBjBJCfJqtNQ1IZ2kMdEHT214puaSI5qicHw=;
 b=K+k3KpQLwGJUPYJ3c/cYlykFhN/6t6LPSe8hQt8CZacZapkZESh6WYdzewXzYgOZ5H
 Qa48oaNqt4MY2Q0gOwGBONo3IzCYncSNMzkaLQpRs1dZX5G7ZjA++ctDOKni+MibtPZx
 x2ZyVEHyB6rhYESxcg5U5UpsJxv3NAPplnlbbpTplrYfN6r23nPTRAdFyul5WtJbxD0f
 Iw866mRGxy4A8EL7LYdrH25ggvhABg4EnaT78U9yB0D1/ntcOJzXqwTxo7wLBEYgHd1M
 s9ilah6HeSrIBB24WPBBPwE/bwjfGlbQ0m1A+1BNVAdQY1vagYTVROFO9Ibe8/n0BDy8
 j16g==
X-Gm-Message-State: AOJu0YwLi6UZjPBgnevtJ7d9EmaeLkMNNwIXCSqoRR1rWf1P3woRbtNo
 4L6g2aqhoqJkm1Oq4AfZG6NIoZNsO6AVVljbufxCZ0epja6d2q/bmkLOpWBGm9zzTxSOUQHbIT3
 duNYug1c=
X-Gm-Gg: ASbGncsUavl+vAPrGRH2cRFkSX44gBSpqkhs7OPkgbL0DJu0ZMnSjMUBnJ83p5jTIMy
 kmrgxwTZRF+CMiHQZWG/HPJZ591d8Y5LfS1YLs56g0PFgNwYHxLtuN50B/+keNFI56CfYK6yirp
 i+9+auG+ThawY6LXvkhixz+Kjwy1kpKVJkN3VTasW0URPPc1CuVLO3STA/4vxKPpoarjMCKdzX/
 C3AZIbBGpXrCOKb6jr0Foz2xCDUCzRiAc9Tl7pf5WYef81Lvoet3LTnrKETyqkJ0AqsVahtACg8
 Mb8Pt/uQEqqF0+0gKJ2mqWkCL7imndHQPOdvdooXa9XWkt1mnwz+k8HSbrVDBUYPBdiPxdZw2/K
 U673g/PZuvofmxmipCDDhcbyn/2raMkPIre6Qy9U8TS4z5As2zOQsMRDHMaCyKd2Fwy+gbheTDY
 a/uire0ylmj193nzAzPVJ4GIfDKiEEs0I/6MX5DzXzig4/H8LtnoopMuynhlc/s1zpuVGZ1Ds=
X-Google-Smtp-Source: AGHT+IEFMZH2pcohxFVeu1IN9vYvbRCXBoHm8cGkoB4J3f95wHZ/68jANAfOrXm8iIrCJpFr/tNlgA==
X-Received: by 2002:a05:600c:3b22:b0:477:8b2e:aa7d with SMTP id
 5b1f17b1804b1-4792a61e58amr5650985e9.30.1764700482165; 
 Tue, 02 Dec 2025 10:34:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a6602afsm2443555e9.5.2025.12.02.10.34.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Dec 2025 10:34:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-10.2?] qemu/atomic: Silence -Wuninitialized warnings
 on macOS AArch64
Date: Tue,  2 Dec 2025 19:34:39 +0100
Message-ID: <20251202183439.33259-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Silence warning when building on macOS AArch64:

  C compiler for the host machine: clang (clang 17.0.0 "Apple clang version 17.0.0 (clang-1700.4.4.1)")
  Host machine cpu: aarch64
  ...
  In file included from ../../tcg/tcg.c:41:
  In file included from include/tcg/tcg-op-common.h:12:
  In file included from include/exec/helper-proto-common.h:10:
  In file included from include/qemu/atomic128.h:62:
  host/include/aarch64/host/atomic128-cas.h.inc:72:22: warning: variable 'tmpl' is uninitialized when used here [-Wuninitialized]
     72 |           [tmpl] "r"(tmpl), [tmph] "r"(tmph)
        |                      ^~~~
  host/include/aarch64/host/atomic128-cas.h.inc:61:30: note: initialize the variable 'tmpl' to silence this warning
     61 |     uint64_t oldl, oldh, tmpl, tmph;
        |                              ^
        |                               = 0
  host/include/aarch64/host/atomic128-cas.h.inc:72:40: warning: variable 'tmph' is uninitialized when used here [-Wuninitialized]
     72 |           [tmpl] "r"(tmpl), [tmph] "r"(tmph)
        |                                        ^~~~
  host/include/aarch64/host/atomic128-cas.h.inc:61:36: note: initialize the variable 'tmph' to silence this warning
     61 |     uint64_t oldl, oldh, tmpl, tmph;
        |                                    ^
        |                                     = 0
  host/include/aarch64/host/atomic128-cas.h.inc:92:22: warning: variable 'tmpl' is uninitialized when used here [-Wuninitialized]
     92 |           [tmpl] "r"(tmpl), [tmph] "r"(tmph)
        |                      ^~~~
  host/include/aarch64/host/atomic128-cas.h.inc:81:30: note: initialize the variable 'tmpl' to silence this warning
     81 |     uint64_t oldl, oldh, tmpl, tmph;
        |                              ^
        |                               = 0
  host/include/aarch64/host/atomic128-cas.h.inc:92:40: warning: variable 'tmph' is uninitialized when used here [-Wuninitialized]
     92 |           [tmpl] "r"(tmpl), [tmph] "r"(tmph)
        |                                        ^~~~
  host/include/aarch64/host/atomic128-cas.h.inc:81:36: note: initialize the variable 'tmph' to silence this warning
     81 |     uint64_t oldl, oldh, tmpl, tmph;
        |                                    ^
        |                                     = 0
  4 warnings generated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 host/include/aarch64/host/atomic128-cas.h.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/host/include/aarch64/host/atomic128-cas.h.inc b/host/include/aarch64/host/atomic128-cas.h.inc
index aec27df1820..1334f467871 100644
--- a/host/include/aarch64/host/atomic128-cas.h.inc
+++ b/host/include/aarch64/host/atomic128-cas.h.inc
@@ -58,7 +58,7 @@ static inline Int128 atomic16_xchg(Int128 *ptr, Int128 new)
 static inline Int128 atomic16_fetch_and(Int128 *ptr, Int128 new)
 {
     uint64_t newl = int128_getlo(new), newh = int128_gethi(new);
-    uint64_t oldl, oldh, tmpl, tmph;
+    uint64_t oldl, oldh, tmpl = 0, tmph = 0;
     uint32_t tmp;
 
     asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
@@ -78,7 +78,7 @@ static inline Int128 atomic16_fetch_and(Int128 *ptr, Int128 new)
 static inline Int128 atomic16_fetch_or(Int128 *ptr, Int128 new)
 {
     uint64_t newl = int128_getlo(new), newh = int128_gethi(new);
-    uint64_t oldl, oldh, tmpl, tmph;
+    uint64_t oldl, oldh, tmpl = 0, tmph = 0;
     uint32_t tmp;
 
     asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
-- 
2.51.0


