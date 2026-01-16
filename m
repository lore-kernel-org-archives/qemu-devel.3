Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F9FD48981
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghqk-0007J6-66; Fri, 16 Jan 2026 06:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqV-0007C5-Fw
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:27 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqT-0005fO-UM
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801d1daf53so10076405e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562303; x=1769167103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7OByW09TC4u5sBcurJXqiba1uVzO9wql2OaJBS6hrUk=;
 b=RRObEnQTSOa1ynFrb2jvq08BoC4rvu6BECgm/Q+Hvq/zhAAZejs3X/Y4pZjNKBKS/N
 2znyI7vZbvjiIdjs+bTtyj1znXkl1lW9VKRtmF8I8YvSEqAfp4YWZWjPMalUGvcK9584
 /rlPHMOHB11EzMJuqqjoZ4W5TB/m+FA4k4lGNL8v6tlYYqnGW3/LQglrpBx9414kOwcP
 hZTl0yvYwluUEAznzkKs1SMg+IKht00dufVHxzxKw/3HDuUZjPtM8YQgjyEDVb+JGoP3
 E6wYolRxfkMl21OFBIrkpQtE2XRSZWMuSmXwU2ETHMMCD5BWGaPgXhrTffIdk7DhFDaf
 TlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562303; x=1769167103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7OByW09TC4u5sBcurJXqiba1uVzO9wql2OaJBS6hrUk=;
 b=pilDsB8PRXWHougF9en705qKK337Q4o5DJgGLM+YGmuWIKaIymJ9z0ZWrxEyH8pjUF
 UaCQRg/9NT3v3Rs+qkVOFlJ8OWz0E03zZz+umiz+Z/ghUEmQsiJxwCxq5f0ObP1+L3K6
 fQFt0HoftbY8qIXTcc5ohuofnl6TdKRisuExLi/hDiyvZTBhEZ57Zbm8yzg0F4VIPSHD
 p7IJonUxnYJr18aDhJUMnmxdm4eXCYOZJL48vdRttHXzR6Lrcg7Exn8gtHKg9FDY8tLf
 CszCMBzfbdOSwo5Hh/bLKR656beyFX2nzA2Q2NuQaMjl8LQrLoZJ3wRF1ly7DYnU7ohP
 cDGg==
X-Gm-Message-State: AOJu0Ywue3Ko5Kspwyr9v6ooUE0XMVzHH4NWLdHCEk0554TTzWkhQQeO
 wPVA7ebhgtTr0fmjKZdCk9aYGCRwRo2Lr8OcH4c4ekeOnxyN6Wr/3F1juliAJK3+a5DY9bUdkH/
 cIUj7IB0=
X-Gm-Gg: AY/fxX5f7OoXWklpa/vT9cmipUicz8y7/CsjWLgwu55amxgyYHqYNeAe6BFA4qVIO3b
 BVDFZNkAARyikxzwTPG1ux+XsOgcPirxbzdXde3LL0pXCSaHP0Al0I9JjgjWfpCpThM50Co7uAu
 GXQldq12FBFjWBb9DMNbH1rr/FeWuUUoeCNPN950oL7zwS+pwRwidDFhMrw3VP5sYu4xklQKcGm
 85wPEWMM+IyuIbl9113POL3sfntrP6ijFpnoBKoYMziq28re/9pB1cmBcLW+G3PEdyc0IYZKBKP
 dY3FtMS7gz1Ml92LF2visMydkPGQOJpDi7n/op5QkPxCi8cpd1dQIiKbH6ZxN0y5nM085GTuS/+
 qITbnNewzOW+BWztovIid0ihEAgpVudjL81Eq3osV3cfwnzvdCNvqg9eFj1SpZBPIhThU2vW2lA
 2ckrFWFlSNuCFRStnN6Ch3WfAogYPSJXMcKTpTK+C+VPeGzt2JUSfdO2GwqBl4
X-Received: by 2002:a05:600c:1d19:b0:477:9caa:1a26 with SMTP id
 5b1f17b1804b1-4801e33dbebmr30785385e9.29.1768562302677; 
 Fri, 16 Jan 2026 03:18:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe7bc14sm13749335e9.20.2026.01.16.03.18.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:18:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/30] tests/qtest/migration: Make 'has_dirty_ring' generic
Date: Fri, 16 Jan 2026 12:17:39 +0100
Message-ID: <20260116111807.36053-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
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

Keep accelerator knowledge limited within MigrationTestEnv,
expose a generic %has_dirty_ring value, only checking for
KVM when initializing it in migration_get_env().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250128135429.8500-3-philmd@linaro.org>
---
 tests/qtest/migration/framework.c     | 2 +-
 tests/qtest/migration/precopy-tests.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index e35839c95f5..6d830079ee4 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -1108,7 +1108,7 @@ MigrationTestEnv *migration_get_env(void)
         return env;
     }
 
-    env->has_dirty_ring = kvm_dirty_ring_supported();
+    env->has_dirty_ring = env->has_kvm && kvm_dirty_ring_supported();
     env->has_uffd = ufd_version_check(&env->uffd_feature_thread_id);
     env->arch = qtest_get_arch();
     env->is_x86 = !strcmp(env->arch, "i386") || !strcmp(env->arch, "x86_64");
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index aca7ed51efd..0283da43e3e 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -1265,8 +1265,7 @@ void migration_test_add_precopy(MigrationTestEnv *env)
     if (g_test_slow()) {
         migration_test_add("/migration/auto_converge",
                            test_auto_converge);
-        if (g_str_equal(env->arch, "x86_64") &&
-            env->has_kvm && env->has_dirty_ring) {
+        if (g_str_equal(env->arch, "x86_64") && env->has_dirty_ring) {
             migration_test_add("/dirty_limit",
                                test_dirty_limit);
         }
-- 
2.52.0


