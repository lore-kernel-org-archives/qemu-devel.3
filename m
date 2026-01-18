Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00791CA5FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhatk-0002Ma-F1; Sun, 18 Jan 2026 17:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatH-00025k-Nd
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:00 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatG-0000Z3-2e
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:59 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-29f30233d8aso24795385ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773897; x=1769378697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92HxQ69qgo/2VgbhtKQwCIAt9EeS2yQ9NqJlStKghbs=;
 b=A2EjFy6Eu4gtloGFlVw5tdkLB8lIIBeJSKsdtxfYdLAdq3Hc9IXEX1dHhldctZmYYa
 mZH0ZKI6iVYNF10cijbN8McwcncV4C9UHTzGCOSPeCuKsTIg655fcDaHUc8UZmmMYuzA
 iw3XLXn8b1PceZ5/VuZiJTRtmZ0TQwBWTxK2kk1Smdu3DWv0iPIbLTdx6vvFgIChoD8s
 D48Dq14j0qOUYo/HPSwMSl/R3uEeP0rMTHJhoTi1ZeBn2zS5ixiIBi2CdxHgW/96FY7r
 iumFI11L4hbiRtsUmReB2L7hraqs3nXSWjOrPTqJzH5ZJYjfuECsN5i1mXkTCg3lL5SS
 Iq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773897; x=1769378697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=92HxQ69qgo/2VgbhtKQwCIAt9EeS2yQ9NqJlStKghbs=;
 b=SmRAW1GbAE21Pb2X+4ub0Rxarol0EqNkAA6Sasjy9AoQDZ9KJoxbdY4F4bLue/FQ54
 ijaSMc74/5PxPXCuLmDotjraTutKpLQpQ3n0Ci+2uqh0uQjTV0Qg7Yc24279tA//q3AO
 4mBqj4dxwCOwjK00/1zyQqZ7xkeBDBhhI2dmFH4OGgBPOb3MeOGAsWgfIwr5UvTVMedw
 BWBBKgDmhgQfiRmOSCdZ74nRxdlHFrcqZv3C3CPar2FyaYCI035MGw352IxJgxODPHRR
 S2dt/Y45hJyO9rzCmzNyq3mXY7n9YuTV+UjEyS6NqH6kD7RCj1dVr9VaCd+py44dVGFX
 MaYw==
X-Gm-Message-State: AOJu0YyWlyIsAlQ+EqIiEyKyJ4J+9UM4KjFkAACVIOeUDhiMa287o0V4
 41GEhtIBL8IQ3wjQjxSHgdgmQjWq3yU4stK22ej23+RilvIhkFjoUS7XDFWWrR8AgBcsBI7yIeq
 r/n9BRlchPQ==
X-Gm-Gg: AY/fxX5O96fBSXNxETzrR0wVGsbN6GdmQACkc3VW6Pc2ll1Q/j3fILsKdvlcth5mLE4
 EWIbsv4EziG+9odf9zdy8rB90U81lVTDcz2FDZej2Z816oCVPhpH0Ov3qx8702ehxRtXBF8q7Bv
 iIFzeehwcs9cHkRaNnuh2zpVvMdcHIeckStsK1ZYziGyWcM5ke/AYvFzw3v3gCHqQaK+ejrZMjK
 Vdn4RTRAuKwzS1ujCx8XvnTbCp24r2y8ZVasAbbEmdGcE/e0SYN8AxSYZjgtfiIMathQgrJq025
 wKhZ39w8V4TQiCNLShiie/GvUVOOdZaoQRJoHQrLQCVeimeqUCJpq5t2oOr0tl2WuLfM5KGyeEz
 ogpi7lE0OikPaKmPPXblAT1LpyP4eP/hL0jWxwUH3+w7ZStkBMt3yVSLzI9tJ9NIU4HKadaR4uF
 IG3f/O1frDEFqt6pWu7Q==
X-Received: by 2002:a17:903:2f8a:b0:2a1:3cd9:a73a with SMTP id
 d9443c01a7336-2a7189482fbmr79829645ad.40.1768773896594; 
 Sun, 18 Jan 2026 14:04:56 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:04:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 15/54] tcg/ppc64: Rename from ppc
Date: Mon, 19 Jan 2026 09:03:35 +1100
Message-ID: <20260118220414.8177-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Emphasize that we're generating 64-bit code.
Drop the explicit rename from meson's cpu.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/{ppc => ppc64}/tcg-target-con-set.h  | 0
 tcg/{ppc => ppc64}/tcg-target-con-str.h  | 0
 tcg/{ppc => ppc64}/tcg-target-has.h      | 0
 tcg/{ppc => ppc64}/tcg-target-mo.h       | 0
 tcg/{ppc => ppc64}/tcg-target-reg-bits.h | 0
 tcg/{ppc => ppc64}/tcg-target.h          | 0
 MAINTAINERS                              | 2 +-
 meson.build                              | 2 --
 tcg/{ppc => ppc64}/tcg-target-opc.h.inc  | 0
 tcg/{ppc => ppc64}/tcg-target.c.inc      | 0
 10 files changed, 1 insertion(+), 3 deletions(-)
 rename tcg/{ppc => ppc64}/tcg-target-con-set.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-con-str.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-has.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-mo.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-reg-bits.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-opc.h.inc (100%)
 rename tcg/{ppc => ppc64}/tcg-target.c.inc (100%)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc64/tcg-target-con-set.h
similarity index 100%
rename from tcg/ppc/tcg-target-con-set.h
rename to tcg/ppc64/tcg-target-con-set.h
diff --git a/tcg/ppc/tcg-target-con-str.h b/tcg/ppc64/tcg-target-con-str.h
similarity index 100%
rename from tcg/ppc/tcg-target-con-str.h
rename to tcg/ppc64/tcg-target-con-str.h
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc64/tcg-target-has.h
similarity index 100%
rename from tcg/ppc/tcg-target-has.h
rename to tcg/ppc64/tcg-target-has.h
diff --git a/tcg/ppc/tcg-target-mo.h b/tcg/ppc64/tcg-target-mo.h
similarity index 100%
rename from tcg/ppc/tcg-target-mo.h
rename to tcg/ppc64/tcg-target-mo.h
diff --git a/tcg/ppc/tcg-target-reg-bits.h b/tcg/ppc64/tcg-target-reg-bits.h
similarity index 100%
rename from tcg/ppc/tcg-target-reg-bits.h
rename to tcg/ppc64/tcg-target-reg-bits.h
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc64/tcg-target.h
similarity index 100%
rename from tcg/ppc/tcg-target.h
rename to tcg/ppc64/tcg-target.h
diff --git a/MAINTAINERS b/MAINTAINERS
index c39a8f54e8..c58fa93fd5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4079,7 +4079,7 @@ F: tcg/mips/
 PPC TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
 S: Odd Fixes
-F: tcg/ppc/
+F: tcg/ppc64/
 
 RISC-V TCG target
 M: Palmer Dabbelt <palmer@dabbelt.com>
diff --git a/meson.build b/meson.build
index 594e7d42c0..0647ca0c89 100644
--- a/meson.build
+++ b/meson.build
@@ -907,8 +907,6 @@ if have_tcg
   endif
   if get_option('tcg_interpreter')
     tcg_arch = 'tci'
-  elif host_arch == 'ppc64'
-    tcg_arch = 'ppc'
   endif
   add_project_arguments('-iquote', meson.current_source_dir() / 'tcg' / tcg_arch,
                         language: all_languages)
diff --git a/tcg/ppc/tcg-target-opc.h.inc b/tcg/ppc64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/ppc/tcg-target-opc.h.inc
rename to tcg/ppc64/tcg-target-opc.h.inc
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
similarity index 100%
rename from tcg/ppc/tcg-target.c.inc
rename to tcg/ppc64/tcg-target.c.inc
-- 
2.43.0


