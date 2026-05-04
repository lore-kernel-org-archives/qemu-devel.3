Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD7AFF886F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJslJ-0003qi-9Z; Mon, 04 May 2026 08:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJslG-0003q3-1h
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:50:58 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJslE-0005Jm-B9
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:50:57 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so3641886f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777899054; x=1778503854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3hvOSst11XJn1fddizPqUlPM2aRnGtyZVd74gxDi58=;
 b=NGtGQW3j6WjjJWOPZva0ilPvI27Tt1fE/oC0p1jZ76rD5/WJ0CPlMG8x4wgm6OJPUr
 DP6XnP0NZ1RZGBa3+mi21pByiOFa6N3ZKkaZgTzixRCbd/dAC2cU7fCLLnmyKUdrnRWx
 KAjWn3tKBi8/yBOiu1kayNPIrv3JATuTg0ZykkVi38fAKk+VA6/vMjoXdyaEoit2t0p4
 7alUdBJ33Btrlu2VfgcoL8Vc1V0JAVIKiHBMRyR8LMCKvwo2I2E+C2xBhl32+Uzh5d5m
 bnyS4BBOVHZv+TnQv5KZq/Ks8El8x4BMDWL5j0vk2oMaQQ2DiH424ydcgv0ZJYSH3z5C
 pDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777899054; x=1778503854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N3hvOSst11XJn1fddizPqUlPM2aRnGtyZVd74gxDi58=;
 b=VYCdr5OzOn1fq9JJm13YppW4x4vNDwGtKa0FLNEmqKovdPzKuw/Uk+UbxahCS8tfus
 2gkGXCZFOBJBtdGbchhyasVQm55B3zDT0TCK+KBWnC/YH6bCvi0XA29vcgX/z6RZXZqD
 WRk5KsVvK2Dmc0SP1dCIRKgunHt/2bRo+3gc/aAsFFJVKIHatCJJ3ZPpQ6GdG9qre44q
 MClrE3Eiv/wk49zBl2mCgBiax6bqRES18MqJJvnUhKq9YLu5Y0bThFZk6/Xs36o4E/hM
 gFgaalsMA49Mk2ZpSg1L7brGwfhG9BpAJ/vKJT10mKr+s0NEG5LyM1CXk/XE3qkp7j+Z
 90xw==
X-Gm-Message-State: AOJu0Yy6iLz5X0PBwMyDSmi+JKIrbUpEYbwPEdMYNXANXI6MruuIvBKl
 tv7SVCEpz87Z/k47qdDo98hBbG20cxNzKn/PoaDg/EL2u98tKqSGWCv7qW83R5xVJKHexB0aHIr
 fmG4iMzQ=
X-Gm-Gg: AeBDieswy/lUfMvc/LhPLmH1PR88BtvPUDWjvNnq3C+hmPH9iKXW4ZD4WtoPM4UDlpD
 9D6eUTK9jOSH1Y1HmYedneiNuvc0qQ4J6LBZ9z5dzUXCstpl7JsMR0llQv5B1gMu1t3L8aGJA3c
 5VjrHZLxIEet4epo+8Df3sLCYLKuqc1DnzNlXUWIqm0Fy9hT57Si/lCU5HpsORH52Odu+aA10XW
 BrFIc3D/P2qFL24Hj8l8LE4HLASYoLF67DYje0E2IHTYD5OPF1Ruw9Qb2pBoVPA4+RgMnyw9Af8
 xAaVMuhpojibLqzvPGe9G5xZADwzx6wiCim8TFZNChTyD7W2PG3dG6Mvtgi0WNKIGLNVTKdpUVk
 Bry2Eu4hxpJjkx24BTCvtOkcG4UWq357Kb/wEuUHnAn45zd+j+Gj80lTAWo1vV8qs86U0+Li9NS
 C7Ibzmx/PLh36lwFmNgjzBdx+l2EPW64is7FxizQgAyP11Reji2m39CAZuNpY27W2Cb/o7G8qeu
 TpNU7oMnrQ=
X-Received: by 2002:a05:6000:228a:b0:43f:df1b:9e07 with SMTP id
 ffacd0b85a97d-44bb6ab19c2mr15430579f8f.42.1777899054485; 
 Mon, 04 May 2026 05:50:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a98b76fd0sm27283204f8f.35.2026.05.04.05.50.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 May 2026 05:50:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] docs/devel/tcg-ops: Slightly expand on discard() opcode
Date: Mon,  4 May 2026 14:50:31 +0200
Message-ID: <20260504125032.35465-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504125032.35465-1-philmd@linaro.org>
References: <20260504125032.35465-1-philmd@linaro.org>
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

No need to precise the argument size.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/tcg-ops.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 56c0b0bd3de..73d8bdcf942 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -437,10 +437,11 @@ Misc
          for consistency with the other bswap opcodes. For future
          compatibility, the flags should be zero.
 
-   * - discard_i32/i64 *t0*
+   * - discard *t0*
 
-     - | Indicate that the value of *t0* won't be used later. It is useful to
-         force dead code elimination.
+     - | Indicate that the value of *t0* won't be used later. This is used to
+         force dead code elimination, particularly for condition code
+         optimizations where TCG might otherwise assume a global is still live.
 
    * - deposit *dest*, *t1*, *t2*, *pos*, *len*
 
-- 
2.53.0


