Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEB5C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdXw-0005Xr-I3; Tue, 16 Jul 2024 04:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTdXt-0005RN-N7
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:28:25 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTdXr-0001xr-0d
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:28:24 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e05992214f9so3462473276.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721118502; x=1721723302;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DvpsKqJKseTB8512E3EM/mcg58HxToRdE8EyOPRZHqA=;
 b=1Bg2hrKJmQVqfGSg+S/1OX+3mK+ItTFNeCA60qIGN8y6vpI6ZnDqLj6+Mdb9pRdp/A
 xfCyvG4S1e/uEzSdByufncPZPu45GJmvbx6tu1kbSGYwsoNp7dOQ/NGKXa9TmrJu3+cf
 /L93qZXCE6nPNjX/UQT50FSFHw3F7IBz3tMa+aF7Gubm5McFiBFRi4DXv6XP/gC9++2b
 8+etHDp9HsIxlwKTIJYpgw28hZiNyFyEZmjyhjPVOpM8rFoKGOeogUImIxxbCjPKDGNt
 1y8qybyLlFzOnuoJ/Jz5JF9OpoTtlv449DtMmbRiTLymHe17+v9bHMhhKW8zfZ4OZD7F
 HN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721118502; x=1721723302;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DvpsKqJKseTB8512E3EM/mcg58HxToRdE8EyOPRZHqA=;
 b=HUSync+669YAlmBchKQg/Vb6ihmsG/jJflvUBKFl2hWPtBx3JtXkC4NosMgtx79Tq8
 curZXpBOgYiJLSBfrhwo0dJ6fkp2+94sFda70bqePshnxu6jF2N1tz7RNlLaWdBlYSC5
 M3Eh+7wx/oKmBK6RpsyhwZWvKFV6jDmUjx+ssJo93v5gvrI8GHqfpMQmKeAiHi8L8X2Q
 OiffHxYwMZGWS6NZQtmahmWxDXwOqC35oVBwhyt0pUIwR2s35Q3RO+6n2eVfb0r8Q6Xu
 Xfy3+8SHBYXArqy+KBcqBtVJdFd0PAA+UKNocP1y4Nf/DtSbsqtJTPMH7zeosbvIkQWH
 cOXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3CCIpl3ji3XSFrzOjIXZ1l8myCBjZU/USIQQDRd+56GHb7YnqAT3vmbTIgTKs2GuP2gfjT5Wu6o2fSJigUr/sEwpnbS8=
X-Gm-Message-State: AOJu0YzI1ANJzMVw/SfNSP1j2A4CFRzZKRBdjaE1UCnNF7pVgwuJild4
 rAy19h5MUnLJkdQJVYNRnNEiBZQHfy0mXzXEDHxyZehz6OTKNudjU4rJJc/4E/T2aNPcySnk9cR
 6IUs=
X-Google-Smtp-Source: AGHT+IFQ05MlplzP52qduKBfnd0ESRUZ3kDwmIURls30SB1PZNzPsUScFaoWpSnOmJbhKqG6+l2Hnw==
X-Received: by 2002:a05:6902:118c:b0:e03:617c:b0ca with SMTP id
 3f1490d57ef6-e05d57b9547mr1740748276.46.1721118501903; 
 Tue, 16 Jul 2024 01:28:21 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-78e33cb61b7sm4469874a12.34.2024.07.16.01.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 01:28:21 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 17:28:13 +0900
Subject: [PATCH v2 1/5] tests/arm-cpu-features: Do not assume PMU availability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-pmu-v2-1-f3e3e4b2d3d5@daynix.com>
References: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
In-Reply-To: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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


