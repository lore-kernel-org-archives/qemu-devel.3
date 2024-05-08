Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DA3C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 14:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4iOA-0002hs-BL; Wed, 08 May 2024 10:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4iO8-0002ek-3z
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:35:20 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4iO6-0004g8-4z
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:35:19 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51f74fa2a82so5086865e87.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715178916; x=1715783716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Znvm/tKg0F+01QfyX6rQqjcFA81lmYWx+WoExy2PfEY=;
 b=l2SQ8HD6YP7oG0IlxktHvI9s/0Ks3yGwFhvjBqgkr+Ka+S1cf4JzlJJmSsG5Y0lTWp
 3q8JNaTVB42vE7mBh5K/Fqy3UY7uW3ZJFVwxTHvr2t79poVZHM2i1B3uBkOPYYeBNRoV
 /gqLRd7j97uNRw4XDdpzhm48MDZm4lsFHffspI+ijipPfiMhC5fdxySCofdpCbXcJakZ
 zr0GTZ6EsPlaz3GHvMXmGnA/t5v5UZ+LYn5weEhAYSyw10Wne1Yv+sK4YXUkXGqzhpw9
 ThX1minno+KfdL2m3DeRKC6jwoAxEpV0laVZ4sl8ZHhLToWGP0sl5b417zepM2c60AqZ
 wk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715178916; x=1715783716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Znvm/tKg0F+01QfyX6rQqjcFA81lmYWx+WoExy2PfEY=;
 b=KHgSeySiBWfkFXqxMUYZaeBvfEPFzF1CG77yNvKYKT9shfC/hki6QX0haMjNm0WSwX
 PxW+3OLo+ybwKoOA9bKpGkunEoBoPqJfKph9/zkjSLJUouJNGEeOiutZkt5CsXeOBVS7
 GVlPF/SVctNhnrNIuQoxnz08yQN3mcxfKpVeg3lMdm/99KZm6uvjnLoOYuVkP4uTjs/l
 9taxNePGNwxmfFkpQ4ShNvORRSee0zoeJbSWuHZC7kuWqY0f9EEvtz9f9Nl8Qd2hKSUc
 giKNhQP7GobK0iEiTDiYdKJp/pSC0xpgz4xjEDmnr9Tld+FS0GcPR+dgIUfgcZER8n5m
 cstw==
X-Gm-Message-State: AOJu0YwajoCcHzoncTe0xS5+o5jmzRzmHzMSxcuz5/JvZ/Kj2gJ1pxnk
 JzFYcsNkHdp9aUX6O0A/Nie+sAIToJCu8ElygoxToly6btQ6Fv78+L82qEJQ3E9zUv2kvHTtFP+
 m
X-Google-Smtp-Source: AGHT+IGinbXw0xib84O+A/UBZWknfYZ+Y9HX/lj27vUlH8IPc6Dap1t0EYEYyIIeuBzumM3eGW5c0A==
X-Received: by 2002:a05:6512:3157:b0:518:eef0:45c0 with SMTP id
 2adb3069b0e04-5217cc520d0mr2390867e87.48.1715178915749; 
 Wed, 08 May 2024 07:35:15 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 n4-20020aa7d044000000b005720e083878sm7610286edo.49.2024.05.08.07.35.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 07:35:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] hw/input/tsc2005: Fix -Wchar-subscripts warning in
 tsc2005_txrx()
Date: Wed,  8 May 2024 16:35:13 +0200
Message-ID: <20240508143513.44996-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

Check the function index is in range and use an unsigned
variable to avoid the following warning with GCC 13.2.0:

  [666/5358] Compiling C object libcommon.fa.p/hw_input_tsc2005.c.o
  hw/input/tsc2005.c: In function 'tsc2005_timer_tick':
  hw/input/tsc2005.c:416:26: warning: array subscript has type 'char' [-Wchar-subscripts]
    416 |     s->dav |= mode_regs[s->function];
        |                         ~^~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v2: Use Peter suggestion
---
 hw/input/tsc2005.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 941f163d36..8d35892c09 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -406,6 +406,9 @@ uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len)
 static void tsc2005_timer_tick(void *opaque)
 {
     TSC2005State *s = opaque;
+    unsigned int function = s->function;
+
+    assert(function < ARRAY_SIZE(mode_regs);
 
     /* Timer ticked -- a set of conversions has been finished.  */
 
@@ -413,7 +416,7 @@ static void tsc2005_timer_tick(void *opaque)
         return;
 
     s->busy = false;
-    s->dav |= mode_regs[s->function];
+    s->dav |= mode_regs[function];
     s->function = -1;
     tsc2005_pin_update(s);
 }
-- 
2.41.0


