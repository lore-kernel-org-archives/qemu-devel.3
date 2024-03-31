Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40470CD1288
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 07:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqpi2-0002zW-5d; Sun, 31 Mar 2024 03:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqpi1-0002z7-07; Sun, 31 Mar 2024 03:34:29 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphz-0002GP-Ey; Sun, 31 Mar 2024 03:34:28 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6e8918d29deso361401a34.1; 
 Sun, 31 Mar 2024 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711870465; x=1712475265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZL1L08WWNCihv0YHYd8rN2H0Y3QSivHfttFd+0jXus=;
 b=O2oGMQCjyVjOmywvLKhprfpxfVzYyjUuKHOjw8RAwtT5a7CAYTgsqmAZdDfMpB9sKk
 0UscWs5PeOKfnSoZfoFl1yXLaEnToFoWHD9G8c3/Ry0dpDGGVRSGWqb9gxlr67Ys1WMn
 XDdT7xzQltPqEgSS+plvtNSGfkgitVR+AkwwmEDI3CJB/ZZjq+SGM4AYw5nNK7qJVXUD
 UB4e1Guhhatc7bES6GqX12tkkSHGlWFuJ1713RjaVu4uSOoPbPBim/axu3sO5pU01HTI
 IGZjZDxQnxHBhmfEDaweG5rWUaBTIxu36R+1KqZcAD6117jlyFOibz12a62IJKYSymUb
 xYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711870465; x=1712475265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZL1L08WWNCihv0YHYd8rN2H0Y3QSivHfttFd+0jXus=;
 b=jse2mZNvJPrm+DD+aosZCMYSbW9SxILE3MVO2CNX+010fcKENRIaVY05gkZdM+1z7X
 D3gczjGcOUR+qIOIknC4PMl0FtgbwI3tr221MekpNb7Ft7AMLdNX/4OEQV0aDm0cK4WM
 AZbbPkUG7ZKpQlLVuMGPKA2SULYkiV1MqdCK2D982cVx0wxMwrk+A+sq8Xu49eZ+wD1/
 3rlL+9FIjTq/51OGl3t9MTXrBLU5HN3yCofAGBvexVf7YwEAlbu8SagJ/ThQsXRQ3qsH
 neMUwl+R/tVCzYbdCEsdsKyFOHYTiJ0PgNQJLL6y9A+iP27qp2zJ+iI3B2sbTPC1s3AG
 tGhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhdpsIEvqk23bUQhuBXPDmvJJUWzXjIhhS5/AH2gRrwqeRzdziBSvamyjGO7yB4T53gOByNIOYDgaR5WP9v+LK/5KV
X-Gm-Message-State: AOJu0YxDrcmKuYIbG6W6Bqpq+KRvX973cBGNA+oRD8/Ooykh0sg3KYkE
 wR9B+4iMKHKJkAdvMCrhZeLF5nF+1lwXr54Lycy8Fs9cqb4ly38DICRq3ZXK4o4=
X-Google-Smtp-Source: AGHT+IGzoaWFh2ho0wfRfk3HYKSBF0hywllvqkOhnNHdoufUN2O4R1MUuKPYdcZVaUJwZkIcQOz68A==
X-Received: by 2002:a05:6870:8093:b0:222:63e2:aba3 with SMTP id
 q19-20020a056870809300b0022263e2aba3mr7125090oab.8.1711870465336; 
 Sun, 31 Mar 2024 00:34:25 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 k9-20020aa78209000000b006eabe72ce84sm5822411pfi.16.2024.03.31.00.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 00:34:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 7/8] tests/avocado: Fix ppc_hv_tests.py xorriso dependency guard
Date: Sun, 31 Mar 2024 17:33:44 +1000
Message-ID: <20240331073349.88324-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331073349.88324-1-npiggin@gmail.com>
References: <20240331073349.88324-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x32b.google.com
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
Fixes: c9cb496710758 ("tests/avocado: ppc add hypervisor tests")
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
2.43.0


