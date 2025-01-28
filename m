Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F81FC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 11:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcjcB-0002JM-3c; Tue, 28 Jan 2025 06:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcjc4-0002Ew-Pt
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:18:38 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcjc2-00056a-CS
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:18:36 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso6152319f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 03:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738063112; x=1738667912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PN2sEDLcal0RxGhKQBHLWKpiMjFeqeXkP17+0wDdg70=;
 b=I4HN59Gl6vhGqXO+mQgEL5ronJxsyNLpSxdLQSMjEcKSA8UzHiLKEbOBzxu0roMTEV
 ltwEo7d6cDmGZOV2Ml833DmqTTMl1ePerPP0SxZPcL+xMfFbGO47w7H8toECAouexZhX
 x6hKY55XN7kQHfLMSb9znqyAYUG9k6N7YSfSyVs7MUBj4Q6AVu5or9NqyA2NdhLqR6eN
 +VRB7aGTXzheIA9YHbjJvcKmOk4NioeVsuyeSSQloXndryHIQJ9qijoBjqkL+RXlChsm
 iVm4jDlc5U6ekzMuVZpqdE0Z/YwbmPuj1eyoPzNT/xH1VvbhZ3zyhnRLiORaBhWOgE5v
 hw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738063112; x=1738667912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PN2sEDLcal0RxGhKQBHLWKpiMjFeqeXkP17+0wDdg70=;
 b=YwO+d6eGhPP758HHHbi5X1X7D7Z8X6hGftyuaUAASfZ/sA7PGRr+T/ZQtqsq0GjRnC
 ZEKWOW2ystOPXU8RmbkQP0Uc/6n+pj01H3rUhf3VaUxjKP7V0oevQBofu1JNsEm7y605
 U0pkCModgHZrNkaCukMzCqNmS4eKFZVFYwbQ1JWbyhfjnGHfSmzVsDmPJT7+SFVYq31u
 nYR6sfnMRd3b4D6+JbdpOyHuTZI2P6ea6Qqn8lYVq3NijopTv/00kfsKXDiYGu3IW6E6
 5xyb04BvujRttf0of0d5X/JeLkfI2oBokSaE+Cecvcmo8fDc0i77uDn/R0cpDbI2OC6o
 cwxA==
X-Gm-Message-State: AOJu0YyEVsHE5ZhvaB5AL5W02++AcYTg/2uB3eR1kQKGQPbp05+m+PN0
 ODXP/RwJ4793XXvGd3PN158XdxgUnZO3EZ07POpRNxCz2lfWvqGusLD6z8xs+exe3jrsr9o3gB6
 QQyw=
X-Gm-Gg: ASbGncvn5ry1Aqy3Z48AbRjOw3FRmgCkggA6UTVLQQJWBoUY+KPophT0ReVGi4T2V4N
 s1gWwLggLAYY3pv7FnwrTAPDOx29W3feVJ7YOte4i3N5E7xE1IxAjOgTSw+Y9EHj8tWhTwOSUGw
 nM2J1Nq8W6SqK6ooAncJ2PilDRhVzoOyuiG6uLvMv9ng72WU9V2aGJbCis1Opz5IwZ5orZDv6u6
 jTggW+6uME0DTU9zGXyqtYhOY1DWrOwa0xx9zl64qkA/P5rpU+xC3ANpQVQG6Th8COnnwOECbVu
 OasFz2vyt2QmojtjAtnX+3x7JWySimuE+MtmWXU3Us84fThJR8ZPmCmQIAeaKlaR7Q==
X-Google-Smtp-Source: AGHT+IFWxgl1VusfEZKSGe4OFJyb0PxvJeiXznINSQNI0S+Gx4FvxU/nsmXT0fp2RgHAmqCcN0ELvw==
X-Received: by 2002:a5d:54ce:0:b0:38a:88ac:ed14 with SMTP id
 ffacd0b85a97d-38bf5659e26mr28903902f8f.19.1738063112306; 
 Tue, 28 Jan 2025 03:18:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a18931esm14090518f8f.60.2025.01.28.03.18.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 03:18:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] tests/qtest: Make qtest_has_accel() generic
Date: Tue, 28 Jan 2025 12:18:21 +0100
Message-ID: <20250128111821.93767-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128111821.93767-1-philmd@linaro.org>
References: <20250128111821.93767-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since commit b14a0b7469f ("accel: Use QOM classes for accel types")
accelerators are registered as QOM objects. Use QOM as a generic
API to query for available accelerators. This is in particular
useful to query hardware accelerators such HFV, Xen or WHPX which
otherwise have their definitions poisoned in "exec/poison.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/libqtest.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 7e9366ad6d5..3071dedeff6 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -30,6 +30,7 @@
 
 #include "libqtest.h"
 #include "libqmp.h"
+#include "qemu/accel.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
@@ -1030,13 +1031,10 @@ static bool qtest_qom_has_concrete_type(const char *parent_typename,
 
 bool qtest_has_accel(const char *accel_name)
 {
-    if (g_str_equal(accel_name, "tcg")) {
-#if defined(CONFIG_TCG)
-        return true;
-#else
-        return false;
-#endif
-    } else if (g_str_equal(accel_name, "kvm")) {
+    static QList *list;
+    g_autofree char *accel_type = NULL;
+
+    if (g_str_equal(accel_name, "kvm")) {
         int i;
         const char *arch = qtest_get_arch();
         const char *targets[] = { CONFIG_KVM_TARGETS };
@@ -1048,11 +1046,12 @@ bool qtest_has_accel(const char *accel_name)
                 }
             }
         }
-    } else {
-        /* not implemented */
-        g_assert_not_reached();
+        return false;
     }
-    return false;
+
+    accel_type = g_strdup_printf("%s%s", accel_name, ACCEL_CLASS_SUFFIX);
+
+    return qtest_qom_has_concrete_type("accel", accel_type, &list);
 }
 
 bool qtest_get_irq(QTestState *s, int num)
-- 
2.47.1


