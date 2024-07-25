Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5806BC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8I5-00020k-DD; Thu, 25 Jul 2024 19:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8I3-0001se-Bq; Thu, 25 Jul 2024 19:54:31 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8I1-0000XL-J8; Thu, 25 Jul 2024 19:54:31 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d2b27c115so347576b3a.2; 
 Thu, 25 Jul 2024 16:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951667; x=1722556467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5puEPBKf+rK31Y6OLnJJN/a3ntQ27I2J4CiRWM4wMMo=;
 b=FvkvIld85/qXj2MZ5jJNuxY1k+pgEgHkxccGWC4vBENnxNjpp9+kaxoUW0bXxX3dDe
 mg8YJVni1AIi5OnEVHigaZG6a6GOxCm+ahdRLjQxaZK31DPEzEIuWcQHSJ73ptpiQ1Ab
 fJYgp2DYXuR04JXyjwt4EYmdQCwxxHZ1HSp4sGSPN0Cba7JYQbGJQt62a84E0cS4Up6f
 yr/DLjbkmmuvUOuBN35hynWfJPC3NtsB7ni5MPwJfROjmAIQoWaSF5jAZrQcBJ+iqXfX
 2lqdu5+HMigojKy0bp1afFC2BTbWtnuOExgudVDRD/ahEBQ58X6S25hVTZ45U10SvbZL
 FLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951667; x=1722556467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5puEPBKf+rK31Y6OLnJJN/a3ntQ27I2J4CiRWM4wMMo=;
 b=jH9Z7IpKXtrXFEQP6VHV/f0aUg1AfzmPZtBw8vO8C8dq18MNEVWhqvcaGk7gvXwFpN
 OVLhTNfpTuUndWi6X8oTVDJ3Y4+3RlngnBbXIhCFK8KkOVhCBOba8cm8n6ZwVFybeE80
 WFiKfu0IzuYurgubPrgz0Z27CEBJqLm76BLwtPOG2LnluD93Rcttebo1UE4fFrIpUlQ5
 afAw6Wh9tChZTJjTsbmXimD5P8Y+Dh5NX9LkKeysw3TMWQrewIlZlzVFN7EtG/vcrwuD
 cDlOI6usiCCy/4wVunMWl1RPHY+gW/4sjIbk9XxGRNnH1zhPM3GKOh9ZZrcj9Xl5az/Z
 spnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2LS3PuOu7ua38QxvnTTNCOMS6Drysf2URoa7xtFZDPZUcip6JjB++sorK64ZUZ2X2pM6WDVb27QNl6uv6Jxt045uy
X-Gm-Message-State: AOJu0YzwCSsKo+m6PatVNKB0tGpVED6Vh5ZuECM7SIj/GPsv3RYXecVA
 4tE7HPmkkwAAPWNXgoCTAGRNgO8YB/YFGPKpSfInr6/73mYMY56KzTT4Yg==
X-Google-Smtp-Source: AGHT+IFACJ4piwic4upNX73IFGL1tQDD8yo3s0J2XPDySedQ9sW1U2Rt04j7kwsEMXtxAzmhS0m0lw==
X-Received: by 2002:a05:6a20:2453:b0:1c4:5361:b72e with SMTP id
 adf61e73a8af0-1c47b3f049emr4118066637.35.1721951666886; 
 Thu, 25 Jul 2024 16:54:26 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:54:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 01/96] tests/tcg: Skip failing ppc64 multi-threaded tests
Date: Fri, 26 Jul 2024 09:52:34 +1000
Message-ID: <20240725235410.451624-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

In Gitlab CI, some ppc64 multi-threaded tcg tests crash when run in the
clang-user job with an assertion failure in glibc that seems to
indicate corruption:

  signals: allocatestack.c:223: allocate_stack:
    Assertion `powerof2 (pagesize_m1 + 1)' failed.

Disable these tests for now.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/tcg/ppc64/Makefile.target | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
index 8c3e4e4038..509a20be2b 100644
--- a/tests/tcg/ppc64/Makefile.target
+++ b/tests/tcg/ppc64/Makefile.target
@@ -11,6 +11,18 @@ config-cc.mak: Makefile
 
 -include config-cc.mak
 
+# multi-threaded tests are known to fail (e.g., clang-user CI job)
+# See: https://gitlab.com/qemu-project/qemu/-/issues/2456
+run-signals: signals
+	$(call skip-test, $<, "BROKEN (flaky with clang) ")
+run-plugin-signals-with-%:
+	$(call skip-test, $<, "BROKEN (flaky with clang) ")
+
+run-threadcount: threadcount
+	$(call skip-test, $<, "BROKEN (flaky with clang) ")
+run-plugin-threadcount-with-%:
+	$(call skip-test, $<, "BROKEN (flaky with clang) ")
+
 ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
 PPC64_TESTS=bcdsub non_signalling_xscv
 endif
-- 
2.45.2


