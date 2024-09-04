Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDFCCD484C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnQa-0000yN-FQ; Wed, 04 Sep 2024 06:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQT-0000qc-6g
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQR-00088g-1p
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TmrpfhyMv5XN9n5aiiPgnpe7vWxN25YwzTSZ2B4Iuh4=;
 b=fu+aBYz06pYMJb/4rP8b4fYSnWqn7fAo8bruGX0THRO7oM36Tu3hNGpFlrGmOBjrXL6QRd
 54SwRDbvcvGZjBsSiwkskvxTiTtS8259FMMDseeJHa7SEav1QX9sXv6jfMSNSV5q6unhCx
 wxCTQkGV6KaWONha4VfKxi65s/UWGHY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-V9zdRawzP32_H0i_Ewdnyg-1; Wed,
 04 Sep 2024 06:39:43 -0400
X-MC-Unique: V9zdRawzP32_H0i_Ewdnyg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C280119560B0; Wed,  4 Sep 2024 10:39:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52D14195605A; Wed,  4 Sep 2024 10:39:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/42] Bump avocado to 103.0
Date: Wed,  4 Sep 2024 12:38:39 +0200
Message-ID: <20240904103923.451847-5-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Cleber Rosa <crosa@redhat.com>

This bumps Avocado to latest the LTS release.

An LTS release is one that can receive bugfixes and guarantees
stability for a much longer period and has incremental minor releases
made.

Even though the 103.0 LTS release is pretty a rewrite of Avocado when
compared to 88.1, the behavior of all existing tests under
tests/avocado has been extensively tested no regression in behavior
was found.

To keep behavior of jobs as close as possible with previous version,
this version bump keeps the execution serial (maximum of one task at a
time being run).

Reference: https://avocado-framework.readthedocs.io/en/103.0/releases/lts/103_0.html
Signed-off-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20240806173119.582857-2-crosa@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240830133841.142644-5-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pythondeps.toml        | 2 +-
 tests/Makefile.include | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pythondeps.toml b/pythondeps.toml
index f6e590fdd8..175cf99241 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -30,5 +30,5 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
 # Note that qemu.git/python/ is always implicitly installed.
 # Prefer an LTS version when updating the accepted versions of
 # avocado-framework, for example right now the limit is 92.x.
-avocado-framework = { accepted = "(>=88.1, <93.0)", installed = "88.1", canary = "avocado" }
+avocado-framework = { accepted = "(>=103.0, <104.0)", installed = "103.0", canary = "avocado" }
 pycdlib = { accepted = ">=1.11.0" }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6618bfed70..537804d101 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -141,7 +141,7 @@ check-avocado: check-venv $(TESTS_RESULTS_DIR) get-vm-images
             --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
             $(if $(AVOCADO_TAGS),, --filter-by-tags-include-empty \
 			--filter-by-tags-include-empty-key) \
-            $(AVOCADO_CMDLINE_TAGS) \
+            $(AVOCADO_CMDLINE_TAGS) --max-parallel-tasks=1 \
             $(if $(GITLAB_CI),,--failfast) $(AVOCADO_TESTS), \
             "AVOCADO", "tests/avocado")
 
-- 
2.46.0


