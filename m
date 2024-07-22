Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA46FC3DA64
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrSc-00006t-9I; Mon, 22 Jul 2024 07:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sVrSW-0008Ld-Cy
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:44:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sVrSU-0002PC-2V
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:44:03 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4265b7514fcso19673745e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721648640; x=1722253440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ad1q3cWy2NP9DSF0U1i3kXx2egXQhijAsyWJ4WTxexM=;
 b=UrNCAABsyD0/Nviiw3F70+YNCU0DIziahMyhatgpx261oM0AQifJXUCni3FvJsIjWu
 EBCOFNbYkpt1DB+Kx5XRAgxOgIdqmGNRK8Z4GTSRMjGwG6pso9oC6AhlAxxV/rvzNyBH
 KIU4Nr4djXmN/q5+Vls8sofTmwXPuYQeEqhsDrdzqPxckqbi9EOgKbKoK/3caW3DUp6C
 Eol3QJ0F++DFK3xLRa+PIM7B6E+y2TkG8KCjWrr7pwKLfIrzpObclJqNH6SY1oYa7ZkZ
 k2mWMNivq0a3aVvsRU34KWaWkHTbG/UhSsleVpNhCe2eBsq9FsAWIYkghA7J6ETZbMYU
 tj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721648640; x=1722253440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ad1q3cWy2NP9DSF0U1i3kXx2egXQhijAsyWJ4WTxexM=;
 b=bcs7n4qMXYzwVcyxMdBX4Tf5EkYqxnxxIznPYmelcAo9f3jXcBW9ooLnREGREx+qiW
 tnSr/ngzmanxzCsHrsV8/TaZ80wWEMMhCQ+X+oLY6VaCBlZx+X/ILIX/zE+13jKjsAp0
 2cIF1pCNI6TUAo3xT3quI6CjpxhWYTB8sWJu3UEordfRbDK2Pn5kHpYoJxfI5dFFaALg
 Qii4fnuJ/jGtHHUavUNf5qOsXdEpOmhxlFcN+O/QyI+iwErXY7xaBQsW+XnnnjLYrdyD
 C4gmQBEq5JtgH33pgcbqxb2obrz54C6KgUVZgGzM/YgnFTyyrZWIltWO9b8UyPfBaZR7
 FYPQ==
X-Gm-Message-State: AOJu0Yym3ahGvy3k8XcG/sM6uhtDWi0Z5hrSwb5bnH8Uk9z8XcyYnApo
 kvbL+tPLBSRlpDIOZcQg/Vz/gsq1H7S90k17cx2Uj6XAGvOY6qfpJ5FW1Yxwbdyt8uSW73oAkzH
 D7HM=
X-Google-Smtp-Source: AGHT+IGJPu1H8utodtxZtamymnhLfM7D9BY0V/NjE2wcgiAG537xZuLrloE2ItLEuodB5VVhXmsqhA==
X-Received: by 2002:a5d:4e41:0:b0:366:e09c:56be with SMTP id
 ffacd0b85a97d-36873dc24admr7188496f8f.6.1721648639987; 
 Mon, 22 Jul 2024 04:43:59 -0700 (PDT)
Received: from localhost.localdomain (adsl-231.37.6.1.tellas.gr. [37.6.1.231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787eba8csm8323513f8f.91.2024.07.22.04.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:43:59 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH v5 3/8] CI: Add build-system-rust-debian job
Date: Mon, 22 Jul 2024 14:43:33 +0300
Message-ID: <ef587f7f38ad5714d5c8eeb05448d19a6130799e.1721648163.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

Add job that builds with rust support enabled on debian.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index e3a0758bd9..e025e2cbf6 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -107,6 +107,17 @@ crash-test-debian:
     - make NINJA=":" check-venv
     - pyvenv/bin/python3 scripts/device-crash-test -q --tcg-only ./qemu-system-i386
 
+build-system-rust-debian:
+  extends:
+    - .native_build_job_template
+    - .native_build_artifact_template
+  needs:
+    job: amd64-debian-container
+  variables:
+    IMAGE: debian
+    CONFIGURE_ARGS: --enable-rust
+    TARGETS: aarch64-softmmu
+
 build-system-fedora:
   extends:
     - .native_build_job_template
-- 
γαῖα πυρί μιχθήτω


