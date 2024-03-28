Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1961C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 04:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rphBM-0006g0-Q9; Thu, 28 Mar 2024 00:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rphBF-0006Yi-Gi; Thu, 28 Mar 2024 00:16:02 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rphBD-0003I1-Di; Thu, 28 Mar 2024 00:15:57 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e0025ef1efso4272425ad.1; 
 Wed, 27 Mar 2024 21:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711599352; x=1712204152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxW8RoTidESLDKkq5eDz3cLjlu91W/7FWMuBF0zDoaM=;
 b=aVJaINa3Ru39QXCEKxMlbSNBvylCDCaPh1qwJ7VOQYMfgI/vGE7VqVIwH+p5JbRcqw
 mo6PvW1j2+89Zg4NjSXv1cufGHw2EWOo2olcU9uPkY+F4Cj2ipoQJScMJgNSQxI5x6Qx
 W+qYJZZr/ShbLIY3hnd9RvpN3cD/pxKYlY8PVUWtuSJCEtL6hhgYhP5V6MIlZ7c7pWfF
 2QJ0u2BAp+L69FVwIIvSl6WkRc0cQm+VVAyQdiIMA8v8bMeF4JV3fwxKlOROduZ0dKx+
 8Sooz7lDysWEWxPtaTh2eT6h1f3zRx5edVWul+XBEnV1OC+2RmiJCJaSWraC+9GetanE
 Wlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711599352; x=1712204152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BxW8RoTidESLDKkq5eDz3cLjlu91W/7FWMuBF0zDoaM=;
 b=Yk7ntWJUdEAR0p5u3OFtErvvUK1ZxsfqlGW7Q7zUFCC1XOSxsQy3kfoBehtyiARDZ8
 2elyHlABxTnoSZzkwL+H1rb75vHLmUdNNm6aexNNL2bgpT/721cEQgfeQk+g3r+Koe9N
 K2XITE3mH/qtUKqNMHMx9liY0xlcRm7Vp/a4wWB2FhG1Wv/IGFjkGDIALDUpPjjLFfuN
 JQFnxfK0LQ1YkCkpkUXlvrv1Xqc+yoA1lZUL9vjZ2H9R63jRItdX+SyMFdvbvL6UJuye
 h0LRIUIVZ+pLvd48jZU3Zpa0c++ZJKObvg9pU4p+l7egRuyMhcNJb7bBl436FNP9NGPt
 EEVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk9E96el7KNzTTzSLOCvEY1v3rEcj5btZLYCjYwNe/dT+Swgv+sPIGyKx/ekfJ/SjgTRupnQaXzl1OHL9OdWvuuqur
X-Gm-Message-State: AOJu0Yyn7vc28eCnPNdCcJRZuL2fEVRRE2nhYgid+20XZmW5GAORNq7U
 ZYaU8jFXd8e+/mE1c0sdle4xtwvvyH9SvvWwjnutJ45cxChijP5YaqxG9K1OmmY=
X-Google-Smtp-Source: AGHT+IHe4TtQpipRtv65fEN4a7zsREs+DSpd1jTBvkRfhph65b7dDf02PaThiH5W7859NrBiLn7r/g==
X-Received: by 2002:a17:903:238e:b0:1e0:10c1:6288 with SMTP id
 v14-20020a170903238e00b001e010c16288mr1763879plh.51.1711599351870; 
 Wed, 27 Mar 2024 21:15:51 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a1709026f1600b001e0b5f9fb02sm395416plk.26.2024.03.27.21.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 21:15:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 4/4] tests/avocado: Mark ppc_hv_tests.py as non-flaky after
 fixed console interaction
Date: Thu, 28 Mar 2024 14:15:27 +1000
Message-ID: <20240328041527.2602823-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240328041527.2602823-1-npiggin@gmail.com>
References: <20240328041527.2602823-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

Now that exec_command doesn't incorrectly consume console output,
and guest time is set correctly, ppc_hv_tests.py is working more
reliably. Try marking it non-flaky.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/ppc_hv_tests.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/avocado/ppc_hv_tests.py b/tests/avocado/ppc_hv_tests.py
index bf8822bb97..0e83bbac71 100644
--- a/tests/avocado/ppc_hv_tests.py
+++ b/tests/avocado/ppc_hv_tests.py
@@ -45,7 +45,6 @@ def missing_deps():
 # QEMU already installed and use that.
 # XXX: The order of these tests seems to matter, see git blame.
 @skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
-@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck due to console handling problem')
 @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
 @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
 class HypervisorTest(QemuSystemTest):
-- 
2.42.0


