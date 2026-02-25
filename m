Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E69BFD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOBn-0007pu-Hg; Wed, 25 Feb 2026 18:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBl-0007pA-M0
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:05 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBk-0004Du-6G
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:05 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so10333355e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061662; x=1772666462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q2aM84oDDmGMmCgRLZTwoFAMGKPzDi3I8qnQoIiNA7E=;
 b=i+qdOwvf+TvyWALZKse4rUHq/Xe+sfuV+NQ5fGksHpTH8POO+U95b4WK0wEGruqCxd
 6UpnNLiYXybdffaBDazAXCMlJ+pkymbwbF80pdJzcwQhyYwQYIaxfBy27eqlzLMMnBqQ
 bZeXKlAbpDe7GkckqNGVFZp2XR5xjkPHkh7qSEmmVGW6uvlpO8HoyIK+Ld0iwVlfXIzs
 KD3c68x/HhODtlEYj7ut0/b6yFaR3LI7s3ar1Oz3gGnzP1QtOBpkrqZz2cbIHnYJ8iLU
 NqHc6rBfknQZ+uvFnAophjPICnPnioLgeB2vpX77E4OO3SfSyiCPnx5buvP68VlP7VZl
 VtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061662; x=1772666462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q2aM84oDDmGMmCgRLZTwoFAMGKPzDi3I8qnQoIiNA7E=;
 b=h4oDqT2y3i/zrb12/9LBU2jQQUe7AUAfiYtdw8J6V7klKJq5i52VUK+GHyxzf25Z9s
 KuWoQYnAp0wtol5CSjq8lq1+TJrfpoiOr+ZtCb0yZnY67kcXvCQPygiHVWahPm2PUa79
 r0nXz+AFXJhoRQy+TFWmKgzFZsEqBM+83TWVORSqqCC4dUk5GCZKIlFSekbTrrZEobsc
 IHpyUhPdAk5xpEM+IHFjGO2MveHu6r+WLJj7+ziAAHDxtuA0iUKZZk4pywrzDQXv1zAU
 pk7dWwRFeNm0EDwdOry3eu3QzJqq9meIQBr9blL1qi86plg5JNk+DoixeSDONZz0kMN9
 7h8Q==
X-Gm-Message-State: AOJu0YydE7mtE9m9m27y71Gsv6O/OlUKn2fOuTCwQmI5cdsGW1fjTcGv
 qv3sCp+03SPOLjkZ1w1ZbnAU038EksYT9BUx7rrF8v6NhD/RW5QtEN6xAKpyymf4YQqGSEtc3OZ
 eivgZ5T0=
X-Gm-Gg: ATEYQzzbcxgkqsXoiLk07KULjuhwHwUItQQNC0/EBADaqBMMX9qv418ldKqg6jme3oi
 EFAut0HSLjLK+Hm9EZRpBWCIjv3QD4T+vvx3q5Bcjg3ub79xMgoOLcX6WaSNKl8oFhb+cuY4JAk
 IY4il4xaOXr6RoinnxeLIVpI7T47LjzMISumALA8xZ+oU4uIUMitCRHbdSYZQIQiCL1Zqno+m3A
 Xjnlqi+ftXX2UCmpTJdbC/JkUTmdkv6KYYEl73Avg/quvY2yE60ce2CezTCZRFtaB4kFiJ1Mgdk
 Rg6XftqMYOTb13FWAZG7c9uUJ7TiCQJrOiWyHuiXdVNdJYn/KRQQei5Uv7T131Nl/ag71qkfeoT
 Y1Q32UjE4iGDo81mJ9jXcNt5CtzYsvzJJnQ+Yg8izpPWUwhR9cBnK6u0CzgCPzw/IWw6VZvAYoX
 bgzbbiNnNPQiPyRe7EEBx/OZB7FEQNao1gTr+Ow+7myduecXMLJNF+EF5NR2e5AR6+HnKqgg0ZU
 CupARS5BXQ=
X-Received: by 2002:a05:600c:5583:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-483c33c1d04mr10965705e9.1.1772061662343; 
 Wed, 25 Feb 2026 15:21:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b841absm4453305e9.13.2026.02.25.15.21.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:21:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/70] qemu/target_info: Add target_s390x() helper
Date: Thu, 26 Feb 2026 00:14:00 +0100
Message-ID: <20260225231411.96482-61-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
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

Add a helper to distinct whether the binary is targetting
S390x or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260213175032.32121-3-philmd@linaro.org>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index e3287334304..23c997de541 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -92,4 +92,11 @@ bool target_ppc(void);
  */
 bool target_ppc64(void);
 
+/**
+ * target_s390x:
+ *
+ * Returns whether the target architecture is S390x.
+ */
+bool target_s390x(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index a26532f660f..28c458fc7a7 100644
--- a/target-info.c
+++ b/target-info.c
@@ -88,3 +88,8 @@ bool target_ppc64(void)
 {
     return target_arch() == SYS_EMU_TARGET_PPC64;
 }
+
+bool target_s390x(void)
+{
+    return target_arch() == SYS_EMU_TARGET_S390X;
+}
-- 
2.52.0


