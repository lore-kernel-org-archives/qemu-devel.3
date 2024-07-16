Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76144C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThds-0002TU-Cs; Tue, 16 Jul 2024 08:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThdr-0002Oz-4t
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:50:51 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThdp-0004sv-K8
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:50:50 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3d94293f12fso3129854b6e.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721134248; x=1721739048;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YbyfiuQZejtjAK0lLgqdILt7MjxfEZc/Ti/4KzdWWdc=;
 b=RHO79leX3Azp63E15nDK6xVj6H670ZiJbeZhDnQUAGZJ2i+2GYRlDwqTfrUuYAuq+h
 F8eqZeClU+zfNLtZG8J1sf0bayyoQ3pRBl/VuxLZH3hO97kUtX6hpsqt7iqpAP8HvXK6
 97znEFuajaBrYteHemgGD5NGYl65I4JcYFYDQFiPCc+ksVh3b2yowQTT1pvfeO03Xzw7
 YMjKexrirrdZK57MdMdot/5sLWqP8/5pjFihwhE6/dPgGNDbxXkmMQ8TfPrN9t0ZF3Ll
 ARTgteJl3iTvaRSydEXijImQov4f8EZr51RknOZxoEsOWK35l8c+uXp+mZNooRtd/6EI
 fkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721134248; x=1721739048;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YbyfiuQZejtjAK0lLgqdILt7MjxfEZc/Ti/4KzdWWdc=;
 b=MZuRjopV9yy6+p5AtDAQQgBOyAdpEklAGO7ZI6JYAI6afVn8fGKsyCwb2YZQh6d21k
 XMsA5WyxdkiM6Ice3t5oIzSyNOk/kcNYPYJPmm50ygf4nbc8ycLT4fcINVmDAfiCtNVv
 PvA5yNl/duW0PhxoJ66iSshN7s6sukyy1EkbI9916pzs7riTtYwbaIzdo+IsVyJ6Ac7J
 eBxub/170nYgQ5BUCFGu9YHOedZ47oT6cYJjU+ruqfT4/PJWsvhLMKED9p7YarHEWYsb
 4LhPqOLKlflKZ1thtMyeqOzkxoeDjPnXGCXCia+HUAP4QSaLs4ZPu59RvhHoaZKkgJr3
 6Otw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0RTIH3R3IQMFrNDaHwVeq/i+lekCheRT+DpNcsYm0Wff/J1lmOvrSI5fm/00SHDae5xdzN3lE/LXyHonwoVoOTnRzc3A=
X-Gm-Message-State: AOJu0YwwcLBE9JwvLreV22CfMfitquO/m+VYQZt4B3gedrE4rmy3Mt8b
 y3Kfkti0Rv86gn95kPpADaX0HDyUgPucEODHpEvfBGyMSPHqcJsxuLWK1LBPeK4=
X-Google-Smtp-Source: AGHT+IGFBBm3xGktf8NTZcTnM8+UpM0LHi+BQkpIUqXaBQ9UZUEQ6ylj8rrem6a9LAOE3XQbO9WocA==
X-Received: by 2002:a05:6871:29d:b0:260:3bdb:93a6 with SMTP id
 586e51a60fabf-260ba823174mr1786700fac.46.1721134248404; 
 Tue, 16 Jul 2024 05:50:48 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-78e32b6bbb7sm4683985a12.17.2024.07.16.05.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 05:50:48 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 21:50:30 +0900
Subject: [PATCH v3 1/5] tests/arm-cpu-features: Do not assume PMU availability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240716-pmu-v3-1-8c7c1858a227@daynix.com>
References: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
In-Reply-To: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22e.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


