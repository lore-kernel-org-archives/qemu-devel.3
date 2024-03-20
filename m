Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F087C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqM9-00069A-Lo; Wed, 20 Mar 2024 03:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rmqM8-00068b-1t
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:27:24 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rmqM5-0003fB-JX
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:27:23 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3bbbc6e51d0so4160779b6e.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1710919640; x=1711524440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tMojK1PB/GVWxT/1IXB22MelDK0HnyWdF5VYQb2Haw=;
 b=W3/9EUiJUM5v9nFPi5nyYs0CixmwEztsIDK3a0YPG/ZZzxqDxsZSNjVA6QxbzLcZrO
 3bK7rVMaU8P+5MuLMYvqiGlzQexdo/JKBCvN3GWt7hy/I4SKW9N2XqyYtkgoAEfT7Xdn
 d1M94EDSpfHMfFx9o8aN5kuilVNQrBg1dkFZ9Eiktwl8tZnV89xVoOWvB24dVxe+Gyf5
 3FNbWSf/W8+fzUP8eUOlgb2Uhnb+XS0sJBvvG8YIkg8RTvi1rQvXkU47UzHys2nyXyZ/
 1eC4D2zKvAnPdFlK8yS3vtfWXmKwoROdydRBWgyzpOIuQVTBwybhpokwY7ENBsb0y29/
 xYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710919640; x=1711524440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tMojK1PB/GVWxT/1IXB22MelDK0HnyWdF5VYQb2Haw=;
 b=ZwrISQDXSxkT+ZyC0nDu5VRy0FUFSZUwTphLfBP39IdEwurzMatz9pshqzaY9SlU0q
 +JIMNCpDw1egLaBHGv74fhjWjpOaNz065ktC/ytsy+zpYfTD5brTVkIj46I4SgdmKEI/
 tT4fPrO71xU4/wTD4d0L60d1ekFRVY8OfYcb/nabpyTzzMGPeC6bPZtwctLbgO6smKL3
 lr/DvXEBI6cXZIqZYl/Ag1rj4dKF26ywmKhP2po5RYfXD4IXJ8m1cBANJCcrOKf+cfQh
 yyL31FdSLpgNBqpGj121KrSP04EDD4v36hWX72G8UmwgzaOBqFauaVi+6mHue7fsYbgS
 6yUA==
X-Gm-Message-State: AOJu0YxIVufaZKm6Bnyw23KRALZT8UaJR9z9zCdQ+th8PyEvsCVaLsJL
 1ZuXcwAt0O0R7VapIO/GiXTjS/rqjx9LCFQoZppZeLPIELHWZmf6lSRqXhZo9PrfUc/ps8WsDfj
 Vwqtrg5jtJ3vTGAFPeF4vzUD7PL5KG+i5mx2JFKsJ84ufCpavnrShalkJVKH1n5e1NpuCGBnC6t
 dPeGyOXgffAWdWqTPsOxZOPm174QnUcSrpAQ2wLA==
X-Google-Smtp-Source: AGHT+IHUSCNbFaF1sSpqQn2xNgk6naOGLHUaSqoKNiYKNfwXYey7AbdWrHJ/lQQI8ZlPTa9Zp04rTw==
X-Received: by 2002:a54:4813:0:b0:3c3:8395:1119 with SMTP id
 j19-20020a544813000000b003c383951119mr9683774oij.26.1710919640092; 
 Wed, 20 Mar 2024 00:27:20 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 p10-20020a056a000a0a00b006e6b45debe8sm10811376pfh.78.2024.03.20.00.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 00:27:19 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/riscv: rvv: Fix Zvfhmin checking for vfwcvt.f.f.v and
 vfncvt.f.f.w instructions
Date: Wed, 20 Mar 2024 15:25:02 +0800
Message-Id: <20240320072709.1043227-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320072709.1043227-1-max.chou@sifive.com>
References: <20240320072709.1043227-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=max.chou@sifive.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/insn_trans/trans_rvv.c.inc | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 7d84e7d812..ef568e263d 100644
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
2.31.1


