Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9AAC41513
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 12:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNXXp-0003hh-Vh; Sat, 29 Jun 2024 08:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNXXj-0003gn-9M
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:51:03 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNXXh-0006gN-NC
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:51:02 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d566b147ffso1004070b6e.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719665460; x=1720270260;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DvpsKqJKseTB8512E3EM/mcg58HxToRdE8EyOPRZHqA=;
 b=VjuW9nbTRhNSrwF/hZjfgebxWS9UR+kmw5TreB2ZtEdQLZ6gmg81+2UqqtGGet/NUC
 PY6JWyi2WyxEtXMvx2oWHQHgEF8yNVqkYGOK1kc0Cjs6pRcR3hsQ5y9cM0SRaQPbFsK7
 SJnCE7QAmhGVbxutTXqUOX4N45ok7VZ/3vBlmwLH3Nj8fpgekDrTKGyTUkqw2okmH4W6
 1Mx9GmRr2CoxJbTPQ3EzeQBy7iet+BKUdAVWuMGwGOW1/D5xVcb5RKbcfqc+qKAl7oyh
 X7yjtyVisbV0Y6uJ0Hn/TwGplz/ad/fLkz46uoOXrwoGTK9whTIqq9/sGk21kbpkIcMk
 9ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719665460; x=1720270260;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DvpsKqJKseTB8512E3EM/mcg58HxToRdE8EyOPRZHqA=;
 b=L7AwTp/QOumceMgANJEIsAeIp+mmv1J7030PE4k5ncRVpkQhg/c9DqLLtlKwT59KEo
 kIuiTo3ZgzXHNTHNUN0hm0sK3HKw7CGDpMnu3jD76+mDA5u/zrIfWa+QmkoNywRyUoAO
 fCr4bEgpbjwTUOEZR+9s/rP45tIg7fY8KByHjmHeM0z3iRnow3r4JXjaz37W1+XZyRnK
 NFhUnutLvMK9YVsF/+QG4ZGxXzD5KRMPkm/JZI1yrpO/cOORpPNOkgmAnfFyuysDn/K3
 BmRzTwHgrp2haA+mWsLAYgwli4PYw8nCb3JVE6rd86XNOQeBjhcES5pf1UhG9XeDSiul
 gehw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzmmBOX8Swig9/xEGBQRL6iBF57kpQhXm0CljXagV+slGpKgWufbAlobw+qHcoJ4AmP8rV1IPT7UKrwFkmmIN1IxLo+AA=
X-Gm-Message-State: AOJu0Yw9w6EtBwUByXeN8pT/BhI9aEU2nmjN627h45HNhZ2kalIcyyOz
 xdaSLQaJRe4PMFcRTA7eu+NP1lNeOqyrRU1EOC+CeTKYW+A6ZDcRNjOiaQ+dfbY=
X-Google-Smtp-Source: AGHT+IGnFk33QJj7zRJvjq34kT9S5rKVUvKwNykZ5WrLJUb8d4LshvqBoKRYEFxOAjs4b/IKgR0gEg==
X-Received: by 2002:a05:6808:2204:b0:3d1:fc50:1aae with SMTP id
 5614622812f47-3d6b2a2f0d4mr1188382b6e.7.1719665460603; 
 Sat, 29 Jun 2024 05:51:00 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-708043b7145sm3322714b3a.148.2024.06.29.05.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 05:51:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 21:50:32 +0900
Subject: [PATCH 1/3] tests/arm-cpu-features: Do not assume PMU availability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240629-pmu-v1-1-7269123b88a4@daynix.com>
References: <20240629-pmu-v1-0-7269123b88a4@daynix.com>
In-Reply-To: <20240629-pmu-v1-0-7269123b88a4@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Asahi Linux supports KVM but lacks PMU support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/qtest/arm-cpu-features.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 966c65d5c3e4..cfd6f7735354 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -509,6 +509,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
     assert_set_feature(qts, "host", "kvm-no-adjvtime", false);
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
+        bool kvm_supports_pmu;
         bool kvm_supports_steal_time;
         bool kvm_supports_sve;
         char max_name[8], name[8];
@@ -537,11 +538,6 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
 
         assert_has_feature_enabled(qts, "host", "aarch64");
 
-        /* Enabling and disabling pmu should always work. */
-        assert_has_feature_enabled(qts, "host", "pmu");
-        assert_set_feature(qts, "host", "pmu", false);
-        assert_set_feature(qts, "host", "pmu", true);
-
         /*
          * Some features would be enabled by default, but they're disabled
          * because this instance of KVM doesn't support them. Test that the
@@ -551,11 +547,18 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         assert_has_feature(qts, "host", "sve");
 
         resp = do_query_no_props(qts, "host");
+        kvm_supports_pmu = resp_get_feature(resp, "pmu");
         kvm_supports_steal_time = resp_get_feature(resp, "kvm-steal-time");
         kvm_supports_sve = resp_get_feature(resp, "sve");
         vls = resp_get_sve_vls(resp);
         qobject_unref(resp);
 
+        if (kvm_supports_pmu) {
+            /* If we have pmu then we should be able to toggle it. */
+            assert_set_feature(qts, "host", "pmu", false);
+            assert_set_feature(qts, "host", "pmu", true);
+        }
+
         if (kvm_supports_steal_time) {
             /* If we have steal-time then we should be able to toggle it. */
             assert_set_feature(qts, "host", "kvm-steal-time", false);

-- 
2.45.2


