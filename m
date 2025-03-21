Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028FCC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgup-00089R-5J; Fri, 21 Mar 2025 14:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvguh-00087I-Qg
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:12 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvguc-0008O7-EC
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:11 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so15763885e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580962; x=1743185762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3gKBXZln9nMsOOdNbaWiLIoe8aJQ76mDsXOYG6g2pk=;
 b=wvcYqtDTM4O08FAznAdHGWTcKpb8MBGRheJjAxJAkRudT2U7VOZGVmCBHUplBLnVxW
 S+70YaA2365WFnOaSXAc5288pAMUUX7K13tWwk1Ta+jHquD1fXpk8JNRrGubYB4U8CJt
 60S6ohvSCNCIMGaIaX1Ku7XFB3gZAcVVjjJSj0dYMZgRB3sH+QtfOKLFSPCPisEYwkd3
 lzRmWtvVttOWLGD21349dpfT7mcGSBtS43BymQ9HQB0rxThJFmdiX6BNKo9soqZLeezg
 N7cNJ/3Fu0tiB+O4FNl5tHoQsnaN1GTwVS35p8gaKtT+qKiLPy3X0reSlwlLNPJXAbqO
 f2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580962; x=1743185762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3gKBXZln9nMsOOdNbaWiLIoe8aJQ76mDsXOYG6g2pk=;
 b=U6f2XfGIoyOjLG1NcyGlwYqYuu+jZtAOeGjricHV4taNhk1JlQdJZvt/7rL0Sj369c
 a4SUlxWu25iBl2qHr4ZPOs6xlkkjYg8ujtJfRuvhbssAYAJNqHV/KzOfSgd6zHM5I6cc
 weEm4JO8Wdb7j9b8ga6e5NSt8jKy5oAWzP7HjsS9lZparSom3BZFwRBBkYDTnueCjkti
 K7pYgq0/6MqtbH7EeRhhY0dz+G4rIPb65LZ6rAwVkQkrm6qnRXz8JqwqJj45at4Xh326
 LHhAzYh4Ohwjw98gnC9MA0rwNnNNm/V/6DZBeDmhdVVMrlboDV7u8DiL1DY9diPonu+E
 G0sg==
X-Gm-Message-State: AOJu0YxwhH5AQqOVeeTHX6Rohr33EjObfnEyzrOfknR9r9lXKGi2eyTL
 hZvcxHCz4qKisrD+eZ2CyIp15S2IjtOp8KNNtOJXWn1r/5PMM9ZspGvG+6p68dTWXrOKqS4rk/p
 g
X-Gm-Gg: ASbGncvex0vFO1pxkzt5Ox/cuGyeNd9Hr/xXqVXfBZOu30KhgukSDlsssM40AeulDWt
 PyB1DxzSxt2mc3pRf8Hsa5eoxTkH3O+nJt4JcYsYnN54/3JfSbZvR8luV3YrkFdW0RP3fMr6F1t
 p12m5NVvqS3sMa0w42tFFYEABWFre+bvq0OoQ970Sz9neMRNODkIQaK7HwzTM8bnOqLeRxgN2dv
 4C3vTyLH/ypVDU/qETgGpn6F0fFshqPm48y+y/a0J3mKa2gxokAhtBErHyA9PNiQevL9pu+zZqp
 E9AXKytmXNq77PKZ2yg9OLVCWk03KQunB2X9IGMbDNq/uUzMPAun5/BIXnbBlXahAjM/cxLtdH+
 biqy9BNpnvDcvTFW+BMg=
X-Google-Smtp-Source: AGHT+IHOZbA0ooO0KX7y3Azur3bFSJytur53/xrOCcLL+OXaI/A3wmWM2w60iCevPk7Bz0Juwca2BA==
X-Received: by 2002:a05:600c:1e8f:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-43d50a3c949mr34411605e9.28.1742580962205; 
 Fri, 21 Mar 2025 11:16:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f332adsm85183635e9.3.2025.03.21.11.16.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 11:16:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 2/7] tcg: Simplify tcg_req_mo() macro
Date: Fri, 21 Mar 2025 19:15:44 +0100
Message-ID: <20250321181549.3331-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321181549.3331-1-philmd@linaro.org>
References: <20250321181549.3331-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Now that TCG_GUEST_DEFAULT_MO is always defined,
simplify the tcg_req_mo() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/internal-target.h | 9 +--------
 accel/tcg/tcg-all.c         | 3 ---
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 2cdf11c905e..1cb35dba99e 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -50,17 +50,10 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
  * memory ordering vs the host memory ordering.  A non-zero
  * result indicates that some barrier is required.
  *
- * If TCG_GUEST_DEFAULT_MO is not defined, assume that the
- * guest requires strict ordering.
- *
  * This is a macro so that it's constant even without optimization.
  */
-#ifdef TCG_GUEST_DEFAULT_MO
-# define tcg_req_mo(type) \
+#define tcg_req_mo(type) \
     ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
-#else
-# define tcg_req_mo(type) ((type) & ~TCG_TARGET_DEFAULT_MO)
-#endif
 
 /**
  * cpu_req_mo:
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c1a30b01219..cb632cc8cc7 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -77,9 +77,6 @@ static bool default_mttcg_enabled(void)
         return false;
     }
 #ifdef TARGET_SUPPORTS_MTTCG
-# ifndef TCG_GUEST_DEFAULT_MO
-#  error "TARGET_SUPPORTS_MTTCG without TCG_GUEST_DEFAULT_MO"
-# endif
     return true;
 #else
     return false;
-- 
2.47.1


