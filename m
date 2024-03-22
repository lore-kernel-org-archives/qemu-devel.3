Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BE1C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnbAH-0004RS-5O; Fri, 22 Mar 2024 05:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rnbAF-0004R3-JQ
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:26:15 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rnbAE-0006ZN-55
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:26:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dddbeac9f9so12127325ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711099572; x=1711704372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7C+h3zUkuwKwkH7fDZaYwLp0SCWsBk7qn2QihiXSfM=;
 b=FPpqjkNwZ+u2rT6GYo62lAIgzkWAMv2epewG9+QBFkjFU6Dq/6zPk5PL1+uNnJkt8B
 kRBVNJXkNr0rTT9s/DA8/HJu1TwrCcar9ceO8A9bUPossdBxJrmstdht9PNiYxjHA9kM
 FeU4j1cSH1LGLXpzZeFxV+TRljKTbuVFFOqNnQ/p+X2N/WcGWvidfgOF23N+eZYXBEpl
 1ap0lO9gYgw2VbzRd6tWBt4jQ1Lmd8dFzBOOqtCM4qDCK9Kw/MF9CsfcskPI5RxxOO8K
 CqPUgDvQMuFRrItpx+3wnPheNsisbCuUtcT4m3dLygGEEbSOlo/ufTTgsv208hVIcE38
 Hc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711099572; x=1711704372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7C+h3zUkuwKwkH7fDZaYwLp0SCWsBk7qn2QihiXSfM=;
 b=PjPLMz7Kn3oeIiHcRAU8JpTKg4xiE6kWcurFkWiPXog99YaozsUiVxh6JKHijR+KLv
 NcQDgwclJ9F2zeUOBu7JqeFnNlrEUCF+R98O11tH/02PPz4GrlRmQxCy4/wpg++NJPHT
 eoqeEhwB3PhCTAO3Lb/Vp+JXYjgEYj0qkLIp83QFKvvb1e+SZ4BDv9Oqjt7iduDNl7+i
 2bit+QllnBhGzoLmbVfHYLTsJky1qIH2r5KfwUJAUnyfz17m5tBxY2RS9zJH0jplKDEO
 6xvgqkO4VxezknGBbdTbV6I9ikldF8Z7tfZUDKqqprwRqdaSwmyUoWXGT06qbjFSDvOK
 Dq4A==
X-Gm-Message-State: AOJu0YzO3HPINdSSvelInFdsjqzIxED3Ldy7O34QZTVPzOdiayFqgSii
 0GBkk7si3DWNhxDOmrb9ploCAn63yC9Fxw9CptVoK81kMwyvV8PEt6LiG5Yr0CveyalMniqmh03
 cu+u/LEFC5ClcS/9JKW0Ep3NRT5tvJc+HosTBXIkvih9drAAij8EkXvOhks0rScdMRqC9jJpjwc
 /wgms3liS59UNrHa/mC0c7U3MYJsPhu+2OMeDsCA==
X-Google-Smtp-Source: AGHT+IHlv2PLizP/0esekwZfwldapQ1PoLQcEGMJNtS6xJb3rj5Pz7Cd2ihEBCoQC49rw0UfXVr/3w==
X-Received: by 2002:a17:903:32cc:b0:1de:fdbd:9324 with SMTP id
 i12-20020a17090332cc00b001defdbd9324mr1989767plr.10.1711099570322; 
 Fri, 22 Mar 2024 02:26:10 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 z14-20020a170903018e00b001e088a9e2bcsm1380380plg.292.2024.03.22.02.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 02:26:10 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/4] target/riscv: rvv: Fix Zvfhmin checking for
 vfwcvt.f.f.v and vfncvt.f.f.w instructions
Date: Fri, 22 Mar 2024 17:25:55 +0800
Message-Id: <20240322092600.1198921-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322092600.1198921-1-max.chou@sifive.com>
References: <20240322092600.1198921-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x632.google.com
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

According v spec 18.4, only the vfwcvt.f.f.v and vfncvt.f.f.w
instructions will be affected by Zvfhmin extension.
And the vfwcvt.f.f.v and vfncvt.f.f.w instructions only support the
conversions of

* From 1*SEW(16/32) to 2*SEW(32/64)
* From 2*SEW(32/64) to 1*SEW(16/32)

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 7d84e7d8124..ef568e263d1 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -50,6 +50,22 @@ static bool require_rvf(DisasContext *s)
     }
 }
 
+static bool require_rvfmin(DisasContext *s)
+{
+    if (s->mstatus_fs == EXT_STATUS_DISABLED) {
+        return false;
+    }
+
+    switch (s->sew) {
+    case MO_16:
+        return s->cfg_ptr->ext_zvfhmin;
+    case MO_32:
+        return s->cfg_ptr->ext_zve32f;
+    default:
+        return false;
+    }
+}
+
 static bool require_scale_rvf(DisasContext *s)
 {
     if (s->mstatus_fs == EXT_STATUS_DISABLED) {
@@ -75,8 +91,6 @@ static bool require_scale_rvfmin(DisasContext *s)
     }
 
     switch (s->sew) {
-    case MO_8:
-        return s->cfg_ptr->ext_zvfhmin;
     case MO_16:
         return s->cfg_ptr->ext_zve32f;
     case MO_32:
@@ -2685,6 +2699,7 @@ static bool opxfv_widen_check(DisasContext *s, arg_rmr *a)
 static bool opffv_widen_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_widen_check(s, a) &&
+           require_rvfmin(s) &&
            require_scale_rvfmin(s) &&
            (s->sew != MO_8);
 }
@@ -2790,6 +2805,7 @@ static bool opfxv_narrow_check(DisasContext *s, arg_rmr *a)
 static bool opffv_narrow_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_narrow_check(s, a) &&
+           require_rvfmin(s) &&
            require_scale_rvfmin(s) &&
            (s->sew != MO_8);
 }
-- 
2.34.1


