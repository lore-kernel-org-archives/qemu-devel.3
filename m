Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B9EC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZeR-0003GA-VK; Fri, 18 Sep 2026 10:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZeL-0003Ed-PN
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:33:14 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZeK-00010j-Bo
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:33:13 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so4819365e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741991; x=1790346791; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oQOylOhcR1gLWw7VoNLMF7sUgVCYqtoo/7yW7qxOJo4=;
 b=FKFJ2CEIcLUhZoRrOEyt8yi6eN+CHMITHaXLGuvgPsmECO7xr2S5DKf6Q9wqmo+Ye3
 9YidJaZgoZlZQBmpw97+fnbM7rxXiUisW6gzEiQR017HJaoDmCm+j0f18E2lbvYsWxgM
 ogSbmBpoDUBK3YhnCOTouGNI8jPGzY5ZJpydDLiIlNwiByFvGxE8GG6N+0muNKAI0fxP
 +4ObhB88Re1RFT4yBFS8AcyDCTJEFNhpWvxbfidWlM5vipuLbacWd4/ZX9T4n3Z/JfUZ
 D7qeQTJDYHfPw2Rx4eYwpFJSQIvUIAqbFS9h8AWhGC75BvQ0Y20akB99jsOOxTSDXLtH
 mjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741991; x=1790346791;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oQOylOhcR1gLWw7VoNLMF7sUgVCYqtoo/7yW7qxOJo4=;
 b=VvsoUgRbz4JTjmiui35anIWwMm1+SkpE+NFPhdl4H0WtDILnkdmYagJTT5WNH6Lo2C
 O38LqSN7tpHn8GOIAxjSzhTaJ+KN7CJcNPlZ+GBEnV4j5EDq9gVjwgUxYLLXW6j3S55o
 cLwtYKX99yD8JDhOUbn7CoimCjqhHPn+DYC6QzY81mJ2vhZt0a16Qvf1yMfths3O4PFm
 obQ3vxHgOzkaUW8nZngw6jZ7OhvP2A0d0Gd86Kv3GcG4J4Hn7+pH4a0iz6qEHuCl+NH3
 FPbJ+quI8f6onFcGowHl0TdI/qrGO4h/KOreOR5pz2J02OfxgX69NYtioQvQHEkWJ3Vg
 gdiA==
X-Gm-Message-State: AFuF++kqFQesjl5ZdqgIeWS8YvJIz//ClX/ew/0duYjhEI2++ADITqBd
 Cm6JTqJ/qBHWH0IkvCqd1rSaJdsf/zZ22NadPLp68WMLhR4hsJgPxGVZ8DF4GFc2PdU=
X-Gm-Gg: AYBFou2A0OoS+YeQaygjMuqMhwUft3i0w1tOhQ9WpWHZvGVUUuBm2DXGUoboUTDswpv
 jRQ5lE2lQgXNdjB8HAGQoCkSTGXt8BtG1YCYx8XLZuf3Gac1IQNvUcS+YKE2QkV0XKC+HJ+YKtz
 gPnoAC+/d3XYqumnhAw1Wb26ovP80v8mlgqPTCIitZwoffGFdrHLZdBIoBzmQgrZMyAQNSGgbI1
 7XgJb7Vh25TUa6Jkjx+ubTlNSaHhYRTwtIGfNx2mA6L0VBiEL9Q244HucUdkrfIWKEBqPIN3f2u
 GskUjYT9E7WVyPNTLu06hF0YaS4me0ZhV9ZRS52cuvuKiAyssj1B6TjJ3EVEq2kCV+sceIZyQZW
 vftYrNIsbDgkhQP/y3ujprYHQPxOWWpsIRNPloIygrYYuScaGlr45gKSuYWIdke8ItAcVko6uEs
 19JNaL4+3a7E5P72MdKFZyKRluCvTaU9jXlXMuuAo8m/Dc35X2tMoqaDc0Eljvr8e8Tb6oqz8=
X-Received: by 2002:a05:600c:3ba9:b0:49c:f504:2af5 with SMTP id
 5b1f17b1804b1-49fc566939emr40358375e9.1.1789741990751; 
 Fri, 18 Sep 2026 07:33:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7d1cca3sm56479365e9.11.2026.09.18.07.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:33:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5604D5FEF7;
 Fri, 18 Sep 2026 15:24:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 17/17] gitlab: drop check-tcg from clang-system job
Date: Fri, 18 Sep 2026 15:24:28 +0100
Message-ID: <20260918142429.336497-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

We have no cross-compilers in the fedora image so don't bother trying
to run the tests.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260917165602.3405537-18-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 5f21703645b..a97cc0b20b8 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -441,7 +441,7 @@ clang-system:
     CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan
       --extra-cflags=-fno-sanitize-recover=undefined
     TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
-    MAKE_CHECK_ARGS: check-qtest check-tcg
+    MAKE_CHECK_ARGS: check-qtest
 
 clang-user:
   extends: .native_build_job_template
-- 
2.47.3


