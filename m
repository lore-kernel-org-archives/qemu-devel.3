Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8861AC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 04:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rphBj-00078u-4J; Thu, 28 Mar 2024 00:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rphBD-0006YW-V6; Thu, 28 Mar 2024 00:15:58 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rphB7-00036k-Gm; Thu, 28 Mar 2024 00:15:55 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e0f2798cd8so5225855ad.3; 
 Wed, 27 Mar 2024 21:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711599339; x=1712204139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqNV1Px+UeUIkQe6eNi16n5EEB0O2oNu4OLcirdIkeA=;
 b=m5PIN8od1vYInML8r2/NqrJiSbGp2cScs+nfJXmeeNMYPTsv158cBxt0JeDiU3h/ht
 ZzxjWEV4/sSnDSd7EysvLvEDeJVw9k20p6vStF1w7QKzzQOpcAvvm2ZVZbdhQmPbkF2d
 cSkpuUErKCO1vG9C8OliKgA7PX6Kev9e1u6nYanrTxkISgDDQ4gOZqAyO+qL6TJDCsMe
 6KETF8nAd2UMnYil1O0E2IEwweWyp3azPRNpfc9TuAScN3e56r8DeAzMkqed7gTmHNbT
 FbeQn87odqy2E7lf99O1VHj7azSjhtNPJ72t+05xW5HY5qsiwuE/ymWT7ZWi+D5HZrLj
 pA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711599339; x=1712204139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqNV1Px+UeUIkQe6eNi16n5EEB0O2oNu4OLcirdIkeA=;
 b=DhYiMwRaL/KaSLQ2gXZkq+03pzgdtjnII4cY2Ek5sGab9rronGdDobDvUfPp3kO7gK
 fXrgnoMRTluT5DqaHOPKRoYQWru70K9sFg9FRpumakKF8PrBsOyDjcerhamhCEEgoOjI
 cQWfDL2TOsEySIgxPn7vNkfmYvK1Bg+LqaUY94NPXURsFTHgvVFSuZl3AqAJ8HGNvvIi
 3fkSQHVAfl152rbnNWq9Kj7pulOPFYeOdfzBX6qDmAgjHy0TuO6yNK5Ly4RiC2ZoV0t+
 iEBi3yPzysWv0OFKFYuXViBGeMREoFdz9oX7Run6ABlIGuSH0i26pFwOyRaSemBVfJyY
 P1zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlW/eH8Jn6SCAjqTBiu8Xzslt6nHyoysrl6QTDpRmc5f6VaeKAPXFPoGYjEOP1wjVrxD8ZUn6+K9SyE90zWGWNs4DU
X-Gm-Message-State: AOJu0YxyWgYWEsjN3yH6GQgKKE8vtHjg8iUOfyHpldccU7sT3V/sgCid
 5Q6YStjwkdAG38MYjhTlHWd8P0Fk5QzWWQsirQVTxbOfonj/n3Dk3x8KWYwQz5g=
X-Google-Smtp-Source: AGHT+IEzv/DTp3i8g3Z4/vt5fMyPweXlHUnRGPtBfOIvA4UMzhYbAquTg7oxAmK6CPBjpeOCXhhRaQ==
X-Received: by 2002:a17:902:ef52:b0:1e0:b871:53ed with SMTP id
 e18-20020a170902ef5200b001e0b87153edmr1919424plx.40.1711599339391; 
 Wed, 27 Mar 2024 21:15:39 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a1709026f1600b001e0b5f9fb02sm395416plk.26.2024.03.27.21.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 21:15:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/4] tests/avocado: Fix ppc_hv_tests.py xorriso dependency
 guard
Date: Thu, 28 Mar 2024 14:15:24 +1000
Message-ID: <20240328041527.2602823-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240328041527.2602823-1-npiggin@gmail.com>
References: <20240328041527.2602823-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

For some reason the skipIf missing_deps() check fails to skip the test
if it comes after the skipUnless lines, causing an error running on
systems without xorriso.

Avocado implements skipUnless is just an inverted skipIf, so it's not
clear what the bug is or why this fixes it. For now it's enough to
get things working.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2246
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/ppc_hv_tests.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/ppc_hv_tests.py b/tests/avocado/ppc_hv_tests.py
index 5080358e25..2c8ddd9257 100644
--- a/tests/avocado/ppc_hv_tests.py
+++ b/tests/avocado/ppc_hv_tests.py
@@ -42,10 +42,11 @@ def missing_deps():
 # QEMU packages are downloaded and installed on each test. That's not a
 # large download, but it may be more polite to create qcow2 image with
 # QEMU already installed and use that.
+# XXX: The order of these tests seems to matter, see git blame.
+@skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
 @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck due to console handling problem')
 @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
 @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
-@skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
 class HypervisorTest(QemuSystemTest):
 
     timeout = 1000
-- 
2.42.0


